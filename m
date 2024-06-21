Return-Path: <linux-kernel+bounces-223874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6E9119D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3C282FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E912D1EA;
	Fri, 21 Jun 2024 04:54:26 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB6EA4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945666; cv=none; b=BvPVC+QtFw60l9/xjiwQwSmrfeXiDfRXYemTcFFCOLrhMyYkfcm5qnDiQuI0nx0g68M9baT+eTPMGRmrCwyMUXiKjsST5Hf3uaQqfamWAcCkhJ7mLcVFWXQbZLcIOt5pG6nyFRVg754vVWiiqwKe4PTLm4M/uSxpObYz+Z5l6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945666; c=relaxed/simple;
	bh=bZ9mK9GNb7YG2nv62WAZv4V5fghiZJAaNPQsE+uaTqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqxzhkEseVS6XAFnl7cThPpd/Qnnn3BYVnP1a0w3xcq1RrAPiOXu7VN0iypmnM3GhlbmwJ7tfBipd4Y8sB1Lslmhsw24Vv66yJ9c+Oyl8BO+GtAaPinNk9ikAV2E1G3r2DqBF6dPhC7UdShMGk0jL28rwdW6HfSQjPSbxmdym0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 8F64B900112;
	Fri, 21 Jun 2024 12:48:00 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.69.245])
	by smtp.cecloud.com (postfix) whith ESMTP id P1340310T281473214968176S1718945279182439_;
	Fri, 21 Jun 2024 12:48:00 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:prarit@redhat.com
X-RCPT-COUNT:10
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.69.245
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<9a2b04ede9b60af26aa0b40245e81f4a>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: prarit@redhat.com
Cc: catalin.marinas@arm.com,
	guohanjun@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liuwei09@cestc.cn,
	lpieralisi@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	will@kernel.org
Subject: [PATCH v2] ACPI: Add config to disable ACPI SPCR console by default on arm64
Date: Fri, 21 Jun 2024 12:47:06 +0800
Message-ID: <20240621044706.87181-1-liuwei09@cestc.cn>
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
completely silence the serial console output, and only enable it through
cmdline when needed.

But there are many existing systems that depend on this console,
so add CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE for this situation.

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
Suggested-by: Prarit Bhargava <prarit@redhat.com>
---

v2: Add a config option suggested by Prarit
---
 arch/arm64/kernel/acpi.c   | 12 ++++++++++++
 drivers/acpi/arm64/Kconfig | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..3365fabb5cf8 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -227,7 +227,19 @@ void __init acpi_boot_table_init(void)
 		if (earlycon_acpi_spcr_enable)
 			early_init_dt_scan_chosen_stdout();
 	} else {
+		/*
+		 * For varying privacy and security reasons, sometimes need
+		 * to completely silence the serial console output, and only 
+		 * enable it by cmdline when needed.
+		 * But there are many existing systems that depend on this
+		 * behavior, so use CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE.
+		 */
+#ifdef CONFIG_ARM_DISABLE_ACPI_SPCR_CONSOLE
+		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
+#else
 		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+#endif
+
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index b3ed6212244c..7e4d860d7089 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -21,3 +21,14 @@ config ACPI_AGDI
 
 config ACPI_APMT
 	bool
+
+config ARM_DISABLE_ACPI_SPCR_CONSOLE
+	bool "Disable ACPI SPCR Console by Default on Arm64"
+	depends on ARM64 && ACPI_SPCR_TABLE
+	default n
+	help
+		For varying privacy and security reasons, sometimes need to
+		completely silence the serial console output, and only enable
+		it by kernel cmdline when needed.
+
+		Say Y to disable ACPI SPCR console by default.
-- 
2.42.1




