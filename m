Return-Path: <linux-kernel+bounces-225613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72A9132E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4331C20F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460614D42C;
	Sat, 22 Jun 2024 09:36:01 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D82119
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719048961; cv=none; b=dTS7VVM+XvpttF+YNzjAz5pcRLnxbEnIo+BY+yBq6TA8MsQYyoP+bIyJQHL94IpXBdvU87JCYfq2MeIKGfGaCWxRLheC7GZvBb3H08xgNV5WI7tpBI8sMJtnlej5iqShIoc86LxYKTfl24TZZa/TSs8FGNVJ9uu24eHlQRDE738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719048961; c=relaxed/simple;
	bh=Ysdu5GUeb/eEymFQnEOn1ukw1VmYXg5Whegsw3EKEPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAk4aUe/1WAMjKREaQwZ/kX3IDl3qmcPHut7afRFy9ze+nYBBtoI2kuRzpUFaIanYamLiOhHD0OlMnSWPMqWv4g/0GkUbxbsnXAMlEd3/uzHUidnpbfoIdAfRXB8z6vW3iVRQw7T2fTzegilEjRURu+IFmuwl7/ezVIFGao42SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id D2BC37C0114;
	Sat, 22 Jun 2024 17:35:48 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (117.240.211.222.broad.my.sc.dynamic.163data.com.cn [222.211.240.117])
	by smtp.cecloud.com (postfix) whith ESMTP id P2702681T281465036140912S1719048947961346_;
	Sat, 22 Jun 2024 17:35:48 +0800 (CST)
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:liuwei09@cestc.cn
X-RCPT-COUNT:6
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:222.211.240.117
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<caf728f0f2ae81041780a31e9dc2581d>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: liuwei09@cestc.cn,
	prarit@redhat.com
Cc: catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org
Subject: [PATCH V3] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on arm64
Date: Sat, 22 Jun 2024 17:35:21 +0800
Message-ID: <20240622093521.71770-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240530015332.7305-1-liuwei09@cestc.cn>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For varying privacy and security reasons, sometimes we would like to
completely silence the serial console, and only enable it when needed.

But there are many existing systems that depend on this console,
so add acpi=nospcr for this situation.

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
Suggested-by: Prarit Bhargava <prarit@redhat.com>
---

v2: Add a config option suggested by Prarit

v3: Use cmdline acpi=nospcr instead of config
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++++---
 arch/arm64/kernel/acpi.c                        | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11e57ba2985c..4c331cfb28f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -12,7 +12,7 @@
 	acpi=		[HW,ACPI,X86,ARM64,RISCV64,EARLY]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
-				  copy_dsdt }
+				  copy_dsdt | nospcr }
 			force -- enable ACPI if default was off
 			on -- enable ACPI but allow fallback to DT [arm64,riscv64]
 			off -- disable ACPI if default was on
@@ -21,8 +21,11 @@
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
-			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
-			"acpi=force" are available
+			nospcr -- disable ACPI SPCR as default console on ARM64
+			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
+			"acpi=nospcr" are available
+			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
+			are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e0e7b93c16cc..35cb12f3b9bd 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -45,6 +45,7 @@ EXPORT_SYMBOL(acpi_pci_disabled);
 static bool param_acpi_off __initdata;
 static bool param_acpi_on __initdata;
 static bool param_acpi_force __initdata;
+static bool param_acpi_nospcr __initdata;
 
 static int __init parse_acpi(char *arg)
 {
@@ -58,6 +59,8 @@ static int __init parse_acpi(char *arg)
 		param_acpi_on = true;
 	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
 		param_acpi_force = true;
+	else if (strcmp(arg, "nospcr") == 0) /* disable ACPI SPCR as default console */
+		param_acpi_nospcr = true;
 	else
 		return -EINVAL;	/* Core will print when we return error */
 
@@ -237,7 +240,19 @@ void __init acpi_boot_table_init(void)
 			acpi_put_table(facs);
 		}
 #endif
-		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+
+		/*
+		 * For varying privacy and security reasons, sometimes need
+		 * to completely silence the serial console output, and only
+		 * enable it when needed.
+		 * But there are many existing systems that depend on this
+		 * behavior, use acpi=nospcr for this.
+		 */
+		acpi_parse_spcr(earlycon_acpi_spcr_enable,
+			!param_acpi_nospcr);
+		pr_info("Use ACPI SPCR as default console: %s\n",
+				param_acpi_nospcr ? "No" : "Yes");
+
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
-- 
2.42.1




