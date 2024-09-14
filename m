Return-Path: <linux-kernel+bounces-329540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E89792AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242AF1F20F17
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6CB1D173A;
	Sat, 14 Sep 2024 17:30:07 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60C1D1721
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726335007; cv=none; b=LIu+IMvOh/HDGkeYZi5Hv7fFwDNNX6N8rhPp5KrPHMdhCKziABwRrDbczbn/0G7ghzD3QBKaZJ98mQQznmyUZulJUN8LIHB1/0qRh0n5fJ+U8nOZz/EnywyPBbhDpbYLY5nCGOFE3Gdilc7vE3lf0VMhnZoYzF3kaZrbnstpTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726335007; c=relaxed/simple;
	bh=7SwQDAyUoFMWzIy3yXdqXJzgfsyJhcb5PxtbX+NzEd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uYzH3VwMY//fIiiTrgPPoxLffGCbSrm0imAaz3CykJoLDeufI/Qy9aH+Ix/FoB8/KsY631mak3N1hTfTR1jgbnExOFK9ibBHxbscco1nL746YMENPMrUhl66qI9bG75Uz4N6pkYORnZPKtRKhT5ZLnsdsQzWImc6BxmArFrkTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpip2t1726334958tz8kkms
X-QQ-Originating-IP: in1OYiiuQTYbide+/sv3GmdQ04ZIDyV4AGI52lnlhok=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Sep 2024 01:29:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16676436338478922279
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: sre@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH v2] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Sun, 15 Sep 2024 01:21:43 +0800
Message-Id: <20240914172142.328-1-kxwang23@m.fudan.edu.cn>
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

In the ssi_protocol_probe function, &ssi->work is bound with
ssip_xmit_work, In ssip_pn_setup, the ssip_pn_xmit function
within the ssip_pn_ops structure is capable of starting the
work.

If we remove the module which will call ssi_protocol_remove
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
with the cleanup in ssi_protocol_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
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


