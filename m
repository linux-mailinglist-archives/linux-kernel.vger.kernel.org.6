Return-Path: <linux-kernel+bounces-446218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F909F2142
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF781625FA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2AD1B85D7;
	Sat, 14 Dec 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xoTuDkrV"
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252461B4F29
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215194; cv=none; b=rOPjBhH6pSOwEZdRVjzf0JPr7ha5V2T5uDoRc0psVgfl0j/Qg9P4Nqpmx19Igs5WwIGlgPdmvWX17knQ9fbLnWHWmjky4hqmo9uJos+vP8lBjqKFQc/YZkGB6XSi49AxRx9Bfg+X3Rh3FBFPQbD2Hvm1LKF4cFlGCwvXKRupA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215194; c=relaxed/simple;
	bh=zvdyZzPaCnRXEefBzLAd/8nZMGbOxiQyzRBX9R4DkO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cxS/HxvXHJKrYuUGfinGDkvKjdlaULGM4Ku/vTWW4fS1C0Px0G8hwOH+0hDEVF6QVDL8IkJuM8HQS5eDdOU4P1Q1O3e8NrIQmT9frIsEZ42pnOmcK6oYTcL7Ic1hoFoIKVwgMm9ZfV0TKH8bqWPgRGMlV+jMcyhbvDUSa2qx5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=xoTuDkrV; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4n+aE9Nz2uXIWtI2nLwH2qv+kJM4V/wl+PdktQqxhHY=; b=xoTuDkrVnBy5yP2V7EqdqNywDR
	AOQ/hZi05o9kGCDTSC0D4itfHr9NzPgXXrmu2+EI1WFl9ht4ey4bG7mAhcTZjfpDmIzkB76nnRsnW
	rs3w7bONOLuODBJZAgwiM2Zh9S+YUiVfMfthwQHcfSdbTQcv6o1HDjx2/jecDdb/rWrk=;
Received: from [88.117.62.55] (helo=hornet.engleder.at)
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tMa9K-000000007yN-17gz;
	Sat, 14 Dec 2024 22:58:10 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH] misc: keba: Fix kernfs warning on module unload
Date: Sat, 14 Dec 2024 22:57:59 +0100
Message-Id: <20241214215759.60811-1-gerhard@engleder-embedded.com>
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

Unloading the cp500 module leads to the following warning:

kernfs: can not remove 'eeprom', no directory
WARNING: CPU: 1 PID: 1610 at fs/kernfs/dir.c:1683 kernfs_remove_by_name_ns+0xb1/0xc0

The parent I2C device of the nvmem devices is freed before the nvmem
devices. The reference to the nvmem devices is put by devm after
cp500_remove(), but at this time the parent I2C device does not exist
anymore as the I2C controller and its devices have already been freed in
cp500_remove(). Thus, nvmem tries to remove an entry from an already
deleted directory.

Free nvmem devices before I2C controller auxiliary device.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 69 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 255d3022dae8..d0c6113dcff3 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -126,8 +126,9 @@ static struct cp500_devs cp520_devices = {
 };
 
 struct cp500_nvmem {
-	struct nvmem_device *nvmem;
+	struct nvmem_device *base_nvmem;
 	unsigned int offset;
+	struct nvmem_device *nvmem;
 };
 
 struct cp500 {
@@ -581,8 +582,8 @@ static int cp500_nvmem_read(void *priv, unsigned int offset, void *val,
 	struct cp500_nvmem *nvmem = priv;
 	int ret;
 
-	ret = nvmem_device_read(nvmem->nvmem, nvmem->offset + offset, bytes,
-				val);
+	ret = nvmem_device_read(nvmem->base_nvmem, nvmem->offset + offset,
+				bytes, val);
 	if (ret != bytes)
 		return ret;
 
@@ -595,15 +596,16 @@ static int cp500_nvmem_write(void *priv, unsigned int offset, void *val,
 	struct cp500_nvmem *nvmem = priv;
 	int ret;
 
-	ret = nvmem_device_write(nvmem->nvmem, nvmem->offset + offset, bytes,
-				 val);
+	ret = nvmem_device_write(nvmem->base_nvmem, nvmem->offset + offset,
+				 bytes, val);
 	if (ret != bytes)
 		return ret;
 
 	return 0;
 }
 
-static int cp500_nvmem_register(struct cp500 *cp500, struct nvmem_device *nvmem)
+static int cp500_nvmem_register(struct cp500 *cp500,
+				struct nvmem_device *base_nvmem)
 {
 	struct device *dev = &cp500->pci_dev->dev;
 	struct nvmem_config nvmem_config = {};
@@ -625,27 +627,52 @@ static int cp500_nvmem_register(struct cp500 *cp500, struct nvmem_device *nvmem)
 	nvmem_config.reg_read = cp500_nvmem_read;
 	nvmem_config.reg_write = cp500_nvmem_write;
 
-	cp500->nvmem_cpu.nvmem = nvmem;
+	cp500->nvmem_cpu.base_nvmem = base_nvmem;
 	cp500->nvmem_cpu.offset = CP500_EEPROM_CPU_OFFSET;
 	nvmem_config.name = CP500_EEPROM_CPU_NAME;
 	nvmem_config.size = CP500_EEPROM_CPU_SIZE;
 	nvmem_config.priv = &cp500->nvmem_cpu;
-	tmp = devm_nvmem_register(dev, &nvmem_config);
+	tmp = nvmem_register(&nvmem_config);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
+	cp500->nvmem_cpu.nvmem = tmp;
 
-	cp500->nvmem_user.nvmem = nvmem;
+	cp500->nvmem_user.base_nvmem = base_nvmem;
 	cp500->nvmem_user.offset = CP500_EEPROM_USER_OFFSET;
 	nvmem_config.name = CP500_EEPROM_USER_NAME;
 	nvmem_config.size = CP500_EEPROM_USER_SIZE;
 	nvmem_config.priv = &cp500->nvmem_user;
-	tmp = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(tmp))
+	tmp = nvmem_register(&nvmem_config);
+	if (IS_ERR(tmp)) {
+		nvmem_unregister(cp500->nvmem_cpu.nvmem);
+		cp500->nvmem_cpu.nvmem = NULL;
+
 		return PTR_ERR(tmp);
+	}
+	cp500->nvmem_user.nvmem = tmp;
 
 	return 0;
 }
 
+static void cp500_nvmem_unregister(struct cp500 *cp500)
+{
+	int notified;
+
+	if (cp500->nvmem_user.nvmem) {
+		nvmem_unregister(cp500->nvmem_user.nvmem);
+		cp500->nvmem_user.nvmem = NULL;
+	}
+	if (cp500->nvmem_cpu.nvmem) {
+		nvmem_unregister(cp500->nvmem_cpu.nvmem);
+		cp500->nvmem_cpu.nvmem = NULL;
+	}
+
+	/* CPU and user nvmem use the same base_nvmem, put only once */
+	notified = atomic_read(&cp500->nvmem_notified);
+	if (notified)
+		nvmem_device_put(cp500->nvmem_cpu.base_nvmem);
+}
+
 static int cp500_nvmem_match(struct device *dev, const void *data)
 {
 	const struct cp500 *cp500 = data;
@@ -663,13 +690,6 @@ static int cp500_nvmem_match(struct device *dev, const void *data)
 	return 0;
 }
 
-static void cp500_devm_nvmem_put(void *data)
-{
-	struct nvmem_device *nvmem = data;
-
-	nvmem_device_put(nvmem);
-}
-
 static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
 		       void *data)
 {
@@ -698,10 +718,6 @@ static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
 		return NOTIFY_DONE;
 	}
 
-	ret = devm_add_action_or_reset(dev, cp500_devm_nvmem_put, nvmem);
-	if (ret)
-		return ret;
-
 	ret = cp500_nvmem_register(cp500, nvmem);
 	if (ret)
 		return ret;
@@ -932,12 +948,17 @@ static void cp500_remove(struct pci_dev *pci_dev)
 {
 	struct cp500 *cp500 = pci_get_drvdata(pci_dev);
 
+	/*
+	 * unregister CPU and user nvmem and put base_nvmem before parent
+	 * auxiliary device of base_nvmem is unregistered
+	 */
+	nvmem_unregister_notifier(&cp500->nvmem_notifier);
+	cp500_nvmem_unregister(cp500);
+
 	cp500_unregister_auxiliary_devs(cp500);
 
 	cp500_disable(cp500);
 
-	nvmem_unregister_notifier(&cp500->nvmem_notifier);
-
 	pci_set_drvdata(pci_dev, 0);
 
 	pci_free_irq_vectors(pci_dev);
-- 
2.39.2


