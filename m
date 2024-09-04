Return-Path: <linux-kernel+bounces-314272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A496B0E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99073287872
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1C84A22;
	Wed,  4 Sep 2024 06:05:07 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B47F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429906; cv=none; b=PXcr/3lIjJg0kJW1nQcM1jaddXenDYmUL3vXPGRBNBWusIAL3QN4Hl/8bM5wJ6dYI1ZAhMaGCXdqX/0bPrBlsiVaET8X1IFp7zKHKu7l52SOA4dkor+GYkbQ7Fc/YbVV/qBISOsJx58wLgh2RCBNn0M1FRB0g0W/N2NBmJyXgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429906; c=relaxed/simple;
	bh=tx4lEADMd74YQFjQTU9b8oXT05pAW7yWAdIIrIaPUHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NtGtePsP9M329GYRmaAB3rQpiXddqVEYDRunrF1eKc3bPiXzj0VC4xVfS8Y8Mxnqaho3P8ntf/6W5yvV1zxTLLxo4uvMCt7LQd36GWcDi0v5ndg6c97HCmeQ1DZtSbGeQP4AIYDvRgPJI0atSRorAqZqDL0fIA352GPMpKRkggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d7f88b9d7-e89db;
	Wed, 04 Sep 2024 14:04:59 +0800 (CST)
X-RM-TRANSID:2ee966d7f88b9d7-e89db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d7f88b847-1716a;
	Wed, 04 Sep 2024 14:04:59 +0800 (CST)
X-RM-TRANSID:2ee366d7f88b847-1716a
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] ipmi: Use devm_kasprintf
Date: Wed,  4 Sep 2024 12:12:13 +0800
Message-Id: <20240904041213.53052-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Use devm_kasprintf to simplify code.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e12b531f5c2f..5d78b1fe49a8 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3213,7 +3213,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 
 	if (intf_num == -1)
 		intf_num = intf->intf_num;
-	intf->my_dev_name = kasprintf(GFP_KERNEL, "ipmi%d", intf_num);
+	intf->my_dev_name = devm_kasprintf(intf->si_dev, GFP_KERNEL, "ipmi%d", intf_num);
 	if (!intf->my_dev_name) {
 		rv = -ENOMEM;
 		dev_err(intf->si_dev, "Unable to allocate link from BMC: %d\n",
@@ -3226,7 +3226,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	if (rv) {
 		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
 			rv);
-		goto out_free_my_dev_name;
+		goto out_unlink1;
 	}
 
 	intf->bmc_registered = true;
@@ -3237,11 +3237,6 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	intf->in_bmc_register = false;
 	return rv;
 
-
-out_free_my_dev_name:
-	kfree(intf->my_dev_name);
-	intf->my_dev_name = NULL;
-
 out_unlink1:
 	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
 
-- 
2.33.0




