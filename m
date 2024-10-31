Return-Path: <linux-kernel+bounces-389891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CED9B7298
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6571C2217A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6812D20D;
	Thu, 31 Oct 2024 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b0H2NESF"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFE4689
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342668; cv=none; b=UFr3Js0V+dX0fHeiAScvNZy2tgqNBX0a827OBJ+RbKwkZUzVwBG/+deqSSOgPuWt2cKCngSCI4vQZPPLHFtqXLwlxvmdOphTGVO+YL0R0GEtA818FSc0toIMBb0oUFuIbWZtc0SR1iKX23YXFtub9jwNsKVkhecjAVCZj0or2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342668; c=relaxed/simple;
	bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cX1rnAZfvdrbpz95rgthcssnP0HLrbnfIIxMBko1eN+6d0FXS2vxcqoV+F2kdGaVb7QyFNzi8fhlkZff4NZDDSHZd0vKuvxR3G1mEncAWEZUnyToL1XlgNKNclwNpg9+pX7judiV/CwrrmeZHTAohvpReZbbwbR6JtTV8xjwGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b0H2NESF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342662;
	bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b0H2NESFCP/uyS9vTXKfvcMQdc1trWOQ5a00Wv2bFXk4673CFixk5q3NL2TNVQxqP
	 FzTrS3rhh3mJ9b+6uH3F7f3VD5AqjhJVXPFbOh2qDK1+X8jRQIVadIk9P/8il0jV0m
	 tbMqJMXalEAR0SX6DfaUGMURzxEy8c9lfQPn0YZo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:52 +0000
Subject: [PATCH RFC 03/10] PCI/sysfs: Calculate bin_attribute size through
 bin_size()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-3-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=2359;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
 b=fh5azo1dxElpMiHMFwshE8J2OJOb7k7moGh24FiRi3roNkr6MrU1GAExxEW9VZdQfoLmKAhVH
 fOP7YRkZnmXDa/4zGUonCCqozMGhWUxW1EJdAGU5PxbuH3aTYur4C9u
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Stop abusing the is_bin_visible() callback to calculate the attribute
size. Instead use the new, dedicated bin_size() one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/pci-sysfs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab78674c5e5906f321bf7a57b742983..040f01b2b999175e8d98b05851edc078bbabbe0d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -818,21 +818,20 @@ static struct bin_attribute *pci_dev_config_attrs[] = {
 	NULL,
 };
 
-static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
-					      struct bin_attribute *a, int n)
+static size_t pci_dev_config_attr_bin_size(struct kobject *kobj,
+					   const struct bin_attribute *a,
+					   int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	a->size = PCI_CFG_SPACE_SIZE;
 	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		a->size = PCI_CFG_SPACE_EXP_SIZE;
-
-	return a->attr.mode;
+		return PCI_CFG_SPACE_EXP_SIZE;
+	return PCI_CFG_SPACE_SIZE;
 }
 
 static const struct attribute_group pci_dev_config_attr_group = {
 	.bin_attrs = pci_dev_config_attrs,
-	.is_bin_visible = pci_dev_config_attr_is_visible,
+	.bin_size = pci_dev_config_attr_bin_size,
 };
 
 /*
@@ -1330,21 +1329,26 @@ static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
 					   struct bin_attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	size_t rom_size;
 
 	/* If the device has a ROM, try to expose it in sysfs. */
-	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	if (!rom_size)
+	if (!pci_resource_end(pdev, PCI_ROM_RESOURCE))
 		return 0;
 
-	a->size = rom_size;
-
 	return a->attr.mode;
 }
 
+static size_t pci_dev_rom_attr_bin_size(struct kobject *kobj,
+					const struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_resource_len(pdev, PCI_ROM_RESOURCE);
+}
+
 static const struct attribute_group pci_dev_rom_attr_group = {
 	.bin_attrs = pci_dev_rom_attrs,
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
+	.bin_size = pci_dev_rom_attr_bin_size,
 };
 
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,

-- 
2.47.0


