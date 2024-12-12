Return-Path: <linux-kernel+bounces-443361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF59EEEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38AF1891FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE36223C72;
	Thu, 12 Dec 2024 15:53:04 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E3223C40;
	Thu, 12 Dec 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018784; cv=none; b=WF1qr1JNXX45nLRuxUBZ7fHH8hf+fW77Fj1KPGA6ZDLWBmxfgLpSecGQpt9lDztWXlWBClrmaFot8Yux0Tn+5XRVoyzap9dv/kwlqxIcPSYtFgletD1pFSlY+Pk/h4fn2iYfefbYWMz2wbSL/7QpMEAZE1YZm0v1Ak2ORm1NfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018784; c=relaxed/simple;
	bh=PDBcMGSgHlDtMAyhCoGHt+7oogWqv9VrcXPppWF3K0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCuIM7MiFQKjfHB+KUEpKXnm6n8jvfyayfVAZob/a9OTngkVjdgDnfu1uPhu4wewKKi2x1sSbz/Fqsna60Xde0zO9YvhL8kFcNS0eDnM9MUbd/h5cdOAjdYqIy7GHCXHJPDa/b/FwuZrbJpZdZiJ4TArkDJ064zhLvQsiITbPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 3/6] arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
Date: Thu, 12 Dec 2024 23:52:34 +0800
Message-ID: <20241212155237.848336-6-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add ARCH_ASPEED in current arm64 architecture.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 MAINTAINERS                  | 1 +
 arch/arm64/Kconfig.platforms | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..c6d04cea43d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2261,6 +2261,7 @@ Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed/
+F:	arch/arm64/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
 N:	aspeed
 
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 370a9d2b6919..894b80434776 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -40,6 +40,12 @@ config ARCH_APPLE
 	  This enables support for Apple's in-house ARM SoC family, such
 	  as the Apple M1.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	help
+	  Say yes if you intend to run on an Aspeed ast2700 or similar
+	  seventh generation Aspeed BMCs.
+
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
 
-- 
2.34.1


