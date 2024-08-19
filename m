Return-Path: <linux-kernel+bounces-292866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01286957576
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340DF1C239DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDF1DC491;
	Mon, 19 Aug 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="GpXTxvR4"
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424661891D9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098447; cv=none; b=LYAlzwSvo/XxoTNK0V6QmmhntX2sLhleUkqWxp9thshzMg5+WY840zrYM3BoNoUq9ieytn8NXa9uiqAUx1XC70VDC0iLYczXSDN4FimjPMj8vbmziVnaiRvZPNNiGxoYa9OXjrVQsvlA+npvOPjh6xvBvgiNMokEC7lSdJHltqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098447; c=relaxed/simple;
	bh=X0d1s5YDtJblz2a9A/iODWTVwyvHX7wVajoH70X677s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cNhuhRRz7oSUcid0iQiy/2Mc3gmfjUbuPJFcyc6nSbJnBK8qiegRpxQCDr9vIVXacsADtnoHYQz0k2K2WNWqNCuGAKwOCz91dEzV7rGVBb9IkFlIKDOmTd5whCOpGQAAYJgIg2+YZSjdJ4Daid3GJkKkWSOB0moAnVJoBYjmb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=GpXTxvR4; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K8RSHjHTYAWv95BsWuQX1QGsu952Wudcs9NTcvFuhv8=; b=GpXTxvR4FBRFJKyd9ilyPVKjxg
	oGB7zIn/G6HFBzgWX25W+m5kispOQy2KR6y3eTdZkbICxsie5d702KaQbPdPLJfa1lGtNSRXEXfCK
	HZWkKUjnVzQ3K7WhUpH1DqHJm0N08aZqbOU9cxs6dS0MIypBHwyAh/xUwuO6ekIPnTJM=;
Received: from [88.117.63.232] (helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sg82G-0001gg-1f;
	Mon, 19 Aug 2024 21:27:24 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH] misc: keba: Fix sysfs group creation
Date: Mon, 19 Aug 2024 21:26:45 +0200
Message-Id: <20240819192645.50171-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

sysfs_create_group() races with userspace. Use dev_groups instead which
prevents all the problems of sysfs_create_group().

Fixes: a1944676767e ("misc: keba: Add basic KEBA CP500 system FPGA support")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 9ba46f0f9392..ae0922817881 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -212,12 +212,12 @@ static ssize_t keep_cfg_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(keep_cfg);
 
-static struct attribute *attrs[] = {
+static struct attribute *cp500_attrs[] = {
 	&dev_attr_version.attr,
 	&dev_attr_keep_cfg.attr,
 	NULL
 };
-static const struct attribute_group attrs_group = { .attrs = attrs };
+ATTRIBUTE_GROUPS(cp500);
 
 static void cp500_i2c_release(struct device *dev)
 {
@@ -396,20 +396,15 @@ static int cp500_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pci_dev, cp500);
 
-	ret = sysfs_create_group(&pci_dev->dev.kobj, &attrs_group);
-	if (ret != 0)
-		goto out_free_irq;
 
 	ret = cp500_enable(cp500);
 	if (ret != 0)
-		goto out_remove_group;
+		goto out_free_irq;
 
 	cp500_register_auxiliary_devs(cp500);
 
 	return 0;
 
-out_remove_group:
-	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
 out_free_irq:
 	pci_free_irq_vectors(pci_dev);
 out_disable:
@@ -427,8 +422,6 @@ static void cp500_remove(struct pci_dev *pci_dev)
 
 	cp500_disable(cp500);
 
-	sysfs_remove_group(&pci_dev->dev.kobj, &attrs_group);
-
 	pci_set_drvdata(pci_dev, 0);
 
 	pci_free_irq_vectors(pci_dev);
@@ -450,6 +443,7 @@ static struct pci_driver cp500_driver = {
 	.id_table = cp500_ids,
 	.probe = cp500_probe,
 	.remove = cp500_remove,
+	.dev_groups = cp500_groups,
 };
 module_pci_driver(cp500_driver);
 
-- 
2.39.2


