Return-Path: <linux-kernel+bounces-263140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE7F93D19B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE593282958
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CF17A932;
	Fri, 26 Jul 2024 11:05:17 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAD17A5AA;
	Fri, 26 Jul 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991917; cv=none; b=IucRFxITUB1rIV/o3VjkRtZl0KnoNfDzWE6TS/zyhemoC3yclLub6+gfK9EFzSaffO3wZ3M2lNntU2v2sLzF0Jzws8lq1HTJsnZr3baSkzlHRQlJmb75PQZlG1jX2UW6aZ94N02HlQdOnA+2zcez+8LWLbGA7lJRJt7Nev6TEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991917; c=relaxed/simple;
	bh=cme7oJn9iUT7d60crBis97v411aBVAM/HX893B8bYLg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgnL3XNRpa6JSKlpkzbyiYS0pYMdJm7dlAcZL5fUD3EN1vrYcmRu/kl764siLez/ZN21KxmR7KdpYglqQhqSWU10jd2sm6RgrIsKPpCnPCztEqPEGxtY+L9ZbEzTvhqCBPD2+3puDoqJ1NvqKrb0/M8hBWuInh0WPVJLdZKxx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 26 Jul
 2024 19:04:00 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 26 Jul 2024 19:04:00 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 07/10] arm64: aspeed: Add support for ASPEED AST2700 BMC SoC
Date: Fri, 26 Jul 2024 19:03:52 +0800
Message-ID: <20240726110355.2181563-8-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
 MAINTAINERS                  |  3 +++
 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..08609430cfe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2121,7 +2121,10 @@ Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed/
+F:	arch/arm64/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
+F:	include/dt-bindings/clock/aspeed,ast2700-clk.h
+F:	include/dt-bindings/reset/aspeed,ast2700-reset.h
 N:	aspeed
 
 ARM/AXM LSI SOC
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..1db7b6f1ee0a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -40,6 +40,20 @@ config ARCH_APPLE
 	  This enables support for Apple's in-house ARM SoC family, starting
 	  with the Apple M1.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	select MACH_ASPEED_G7
+	help
+	  Say yes if you intend to run on an Aspeed ast2700 or similar
+	  seventh generation Aspeed BMCs.
+
+config MACH_ASPEED_G7
+	bool "Aspeed SoC AST2700"
+	help
+	  Say yes if you intend to run on an Aspeed ast2700
+	  seventh generation Aspeed BMCs.
+	  Aspeed ast2700 BMC based on the Cortex A35.
+
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
 
-- 
2.34.1


