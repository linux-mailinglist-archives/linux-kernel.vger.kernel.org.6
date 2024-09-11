Return-Path: <linux-kernel+bounces-325247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783C9756DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8690B28CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28A1AAE24;
	Wed, 11 Sep 2024 15:20:28 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383362C1A2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068028; cv=none; b=eyD3w5NXtU3bL08rAS2OTAp3a3/y8TVWNOdTbE7SttEdA4B03Y2Usb/d4LS6DHjL8FC5MXAXWPaw4h3UTK452nYpMD9X6dNNdG33IPwPhBx66kFq68PuH2ipbx2UC7dBpmugwogg3H6Xo+UfW8xhPzMQcWjbhquwU9teafTUCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068028; c=relaxed/simple;
	bh=t5CyNGkl6z70y1vjQrbax4gj0Z6ReivxQ35sXvKqdyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c19YSsANjEKf/OwxLVehHvT9wdRbjpJOXzLDWfO3ip99Z0a0sBo45A7WwtZXYxbaJcDJ1LXPsyUJG65jwfZh3e6u3DC98Rvr4hjP3OQW7ZzKcak8j2CE3NcJ1LJZL58let9+tpaYpwd2wk0VSv4565h6IAckAFVkNYgKFYiMZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtp88t1726067963t111lr2i
X-QQ-Originating-IP: 4xcA3XA/GQAxfTj6heLXU/mH6T1mI0VSSPKebrxAPFI=
Received: from fastnlp.. ( [202.120.234.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Sep 2024 23:18:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11881671115936726217
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: sre@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Wed, 11 Sep 2024 23:19:15 +0800
Message-Id: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

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
with the cleanup in ssi_protocol_remove

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/hsi/clients/ssi_protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index afe470f3661c..3506c70e3505 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -1155,6 +1155,7 @@ static int ssi_protocol_remove(struct device *dev)
 	unregister_netdev(ssi->netdev);
 	ssip_free_cmds(ssi);
 	hsi_client_set_drvdata(cl, NULL);
+	cancel_work_sync(&ssi->work)
 	kfree(ssi);
 
 	return 0;
-- 
2.25.1


