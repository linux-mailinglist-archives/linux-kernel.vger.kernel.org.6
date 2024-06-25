Return-Path: <linux-kernel+bounces-228235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B51915D20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1171C217D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB54E1D2;
	Tue, 25 Jun 2024 03:05:23 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198814AEFA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284723; cv=none; b=ZQ9SCxkaoQ655mLXr2ln/RuDjnikuUrjlJFysUOsA3EGrNSDCZru2KHz1oKO5ibYdCN37GEwx1LoU+92dSy4QQ2d425syQ8K8JS7RSh1mvyzdSmrdkzeWGu7AwtYdL761m4WyznjSpI1Gxm0ixBuaMaYvys44VJvxhuNZs0HQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284723; c=relaxed/simple;
	bh=QMK1XmhKnmgYUTUZ9V/V43jdFuZ3zPgdogMXw3AYJiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtNY6Z/lt+2yZRU+8mM5mpAOSb45q4NZ9Adf6Au1y6jh4HToqn0rtQ4acumK4NhUGuzqk8Davpyv5Ws8Njd2MXkGjMF07gtV3LCBaXiUyH90tpoNWvgFBzr7h3ba7cg1NIfvxc+ycIvv4rdMizwQZABhP702m4xMvwIA4sWKP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 568A9900114;
	Tue, 25 Jun 2024 11:05:17 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.69.245])
	by smtp.cecloud.com (postfix) whith ESMTP id P1340310T281473223422320S1719284716218537_;
	Tue, 25 Jun 2024 11:05:17 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:liuwei09@cestc.cn
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.69.245
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<bed57cd35782c123b2e918a31b672f68>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: liuwei09@cestc.cn,
	will@kernel.org
Cc: catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on ARM64
Date: Tue, 25 Jun 2024 11:05:04 +0800
Message-ID: <20240625030504.58025-1-liuwei09@cestc.cn>
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
completely silence the _serial_ console, and only enable it when needed.

But there are many existing systems that depend on this _serial_ console,
so add acpi=nospcr to disable console in ACPI SPCR table as default
_serial_ console.

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
Suggested-by: Prarit Bhargava <prarit@redhat.com>
Suggested-by: Will Deacon <will@kernel.org>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
---

v2: Add a config option suggested by Prarit

v3: Use cmdline acpi=nospcr instead of config

v4: Some description in comment or document
---
 .../admin-guide/kernel-parameters.txt          | 10 +++++++---
 arch/arm64/kernel/acpi.c                       | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11e57ba2985c..6814ff7ae446 100644
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
@@ -21,8 +21,12 @@
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
-			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
-			"acpi=force" are available
+			nospcr -- disable console in ACPI SPCR table as
+				default _serial_ console on ARM64
+			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
+			"acpi=nospcr" are available
+			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
+			are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e0e7b93c16cc..55757d8884d4 100644
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
+	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
+		param_acpi_nospcr = true;
 	else
 		return -EINVAL;	/* Core will print when we return error */
 
@@ -237,7 +240,20 @@ void __init acpi_boot_table_init(void)
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
+		 * behavior, use acpi=nospcr to disable console in ACPI SPCR
+		 * table as default serial console.
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




