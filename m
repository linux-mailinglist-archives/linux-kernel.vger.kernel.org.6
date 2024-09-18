Return-Path: <linux-kernel+bounces-332620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2697BBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58EF1F253E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DF18990D;
	Wed, 18 Sep 2024 12:09:49 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063D189912
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661389; cv=none; b=lj23Vd9i6LD5KrQr7RcNfqWj0zGPSWZ+58z+NZ8A/TKNeQ8gFlFsK5d/Pvd+678AYGAEL2dX9Xn5LNqmwmHZaj7UlQMC4KqFQhB8RZ4khB83b52C78uasniGcfv7ML+UVizdP+drY8hPoBoAv5fMrLkurrS0H8g96eb9ad3er5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661389; c=relaxed/simple;
	bh=mxiog+7uQ5UbpzuiYRjcClOeWZdu4yn9DdinuWcVkfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MY2omKzQ5kfMmlRwyBQEMtN89toQw55c4IFxQjOGc1mUewc+bEKQYc0OJG+mEPeORq/M4QQemffEC+GcuR+DGQwTnl0q6ffq6RhbUXbOJ6IEjkymCPVkdskRrCPuZeruQLXQA76nl5yfnbuoxrsaC2FUyJ1JJFCPdMRNx1KfN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpip3t1726661306tfvaym9
X-QQ-Originating-IP: FTLkGsaCNkw4dZ7TVtj6+CR2xA8opmmteOmGxZR82rU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 20:08:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3793229850566540725
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: sre@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH v3] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Wed, 18 Sep 2024 20:07:50 +0800
Message-Id: <20240918120749.1730-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the ssi_protocol_probe() function, &ssi->work is bound with
ssip_xmit_work(), In ssip_pn_setup(), the ssip_pn_xmit() function
within the ssip_pn_ops structure is capable of starting the
work.

If we remove the module which will call ssi_protocol_remove()
to make a cleanup, it will free ssi through kfree(ssi),
while the work mentioned above will be used. The sequence
of operations that may lead to a UAF bug is as follows:

CPU0                                    CPU1

                        | ssip_xmit_work
ssi_protocol_remove     |
kfree(ssi);             |
                        | struct hsi_client *cl = ssi->cl;
                        | // use ssi

Fix it by ensuring that the work is canceled before proceeding
with the cleanup in ssi_protocol_remove().

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
v3:
- refer to the functions in the form of func() in the description message.
- Link to v2: https://lore.kernel.org/r/20240914172142.328-1-kxwang23@m.fudan.edu.cn
v2:
- cancel the work in ssip_reset(), suggested by Sebastian
- add the Acked-by label from Andy
- Link to v1: https://lore.kernel.org/r/20240911151915.844957-1-kxwang23@m.fudan.edu.cn
---
 drivers/hsi/clients/ssi_protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index afe470f3661c..6105ea9a6c6a 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -401,6 +401,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
-- 
2.39.1.windows.1


