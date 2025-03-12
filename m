Return-Path: <linux-kernel+bounces-557912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5888A5DF46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C48D7A756E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A624EF7C;
	Wed, 12 Mar 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jONsDT29"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF47253B4A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790512; cv=none; b=hRB/0EdxCKroKhYqFiIgs5Uwj3sBNH24vuwQhX7MupD1B7k8p2cHpLHNJ8ruiP7dwe97podF+5oJapaFjcd718Lni0heOJfYyRQ/iuIsfaWU39ZbaAhownGeY4fqL4QgXxlavwAw4POWxaaRQEMZETrSUOJR9Z2uI+9BG/EoB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790512; c=relaxed/simple;
	bh=ABo5c/g/NmTfed1rIlmDQYaywrtYmQqrN3BxtbVRwXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsCrC83pn6nAmE8M2OznC5917f8YzdtMW6pCVb1fdVcZJOvBG13/PTrZj3BDOux4ywEC91cPGiMxGXxefQIy/GfT6N4/xrH3VKYT5Gv1ANtnMNdi3L/+F54QOjusnVOSLLKhlbam5xdPsTic+VP2HsaNsqwrKLPQLm9kfTix0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jONsDT29; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from cap.home.8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5A3C6457E7;
	Wed, 12 Mar 2025 15:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741790503;
	bh=ABo5c/g/NmTfed1rIlmDQYaywrtYmQqrN3BxtbVRwXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jONsDT290Lwv9Ht2/jlvKGwGGLafHTWbHFU4mB4/VoOFicXgIsSUkhYL0jV2MnF8n
	 EK3Zu/q9AcxX19WMo7eu7zrn1Dfbi59sA8993HT7nav0x4P8xZe2Bb0eUVjgUSJNn+
	 6dWxOYjHmSiS+VDUW91SoENeDJSADghOkggVAhetsRX50jj1nBe8z9hnC0YJ+bYoTX
	 OKIMyqjXWy6D0xr/Uzn/cLo/VWS3TDjX91Lk9KJIc1RnZ2Lt/w9lldX2rIFqK9iiMV
	 1MaBMnO+RCnzySV4+P865EVoY+AkTF2140M9k5XUjlq8qnYk701xVzjBJVDAejH5mN
	 r78ihaQr10a4w==
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Cc: hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Larry.Dewey@amd.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	kirill.shutemov@linux.intel.com,
	alexey.gladkov@intel.com,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/2] x86/coco/sev: Move SEV SYSFS group to /sys/hypervisor/
Date: Wed, 12 Mar 2025 15:41:06 +0100
Message-ID: <20250312144107.108451-2-joro@8bytes.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144107.108451-1-joro@8bytes.org>
References: <20250312144107.108451-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Move the SYSFS information about SEV to the /sys/hypervisor/ directory and link
to it from the old location. The /sys/hypervisor/ hierarchy makes more
sense for this information, as it is only relevant in a virtualized
environment and contains values influenced by the hypervisor.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 11 ++--------
 Documentation/ABI/testing/sysfs-hypervisor    | 10 +++++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/coco/sev/core.c                      | 21 +++++++++++++------
 4 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..f056c401a550 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -607,16 +607,9 @@ Description:	Umwait control
 			  Low order two bits must be zero.
 
 What:		/sys/devices/system/cpu/sev
-		/sys/devices/system/cpu/sev/vmpl
 Date:		May 2024
-Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-Description:	Secure Encrypted Virtualization (SEV) information
-
-		This directory is only present when running as an SEV-SNP guest.
-
-		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
-		      the SEV-SNP guest is running.
-
+Description:	This symbolic link to /sys/hypervisor/sev/ is only present when
+		running as an SEV-SNP guest.
 
 What:		/sys/devices/system/cpu/svm
 Date:		August 2019
diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
new file mode 100644
index 000000000000..aca8b02c878c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-hypervisor
@@ -0,0 +1,10 @@
+What:		/sys/devices/system/cpu/sev
+		/sys/devices/system/cpu/sev/vmpl
+Date:		May 2024
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Secure Encrypted Virtualization (SEV) information
+
+		This directory is only present when running as an SEV-SNP guest.
+
+		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
+		      the SEV-SNP guest is running.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1665ebaba251..5b717f6ccbbb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1497,6 +1497,7 @@ config AMD_MEM_ENCRYPT
 	select X86_MEM_ENCRYPT
 	select UNACCEPTED_MEMORY
 	select CRYPTO_LIB_AESGCM
+	select SYS_HYPERVISOR
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 96c7bc698e6b..51a04a19449b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2698,12 +2698,10 @@ static int __init sev_sysfs_init(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	dev_root = bus_get_dev_root(&cpu_subsys);
-	if (!dev_root)
-		return -ENODEV;
-
-	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
-	put_device(dev_root);
+	/*
+	 * Create /sys/hypervisor/sev/ with attributes
+	 */
+	sev_kobj = kobject_create_and_add("sev", hypervisor_kobj);
 
 	if (!sev_kobj)
 		return -ENOMEM;
@@ -2712,6 +2710,17 @@ static int __init sev_sysfs_init(void)
 	if (ret)
 		kobject_put(sev_kobj);
 
+	/*
+	 * Link from /sys/devices/system/cpu/sev to /sys/hypervisor/sev/ for
+	 * compatibility reasons.
+	 */
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (!dev_root)
+		return -ENODEV;
+
+	ret = compat_only_sysfs_link_entry_to_kobj(&dev_root->kobj, hypervisor_kobj, "sev", NULL);
+	put_device(dev_root);
+
 	return ret;
 }
 arch_initcall(sev_sysfs_init);
-- 
2.48.1


