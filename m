Return-Path: <linux-kernel+bounces-327757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63088977AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185B21F26839
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C91D58A3;
	Fri, 13 Sep 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="u1icESwL"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72501D54CC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215214; cv=none; b=ZkHaZZIIjJ3Px3Afe3Y4fQvn9SUCAaxHm2FiPL1XRaiUhmpXYKUPt9ltF7x9xFIV53Q9Y8Ptq8T1cPX6+gWA6QS7suZPtrafSnRtvXeSfYVXfmFSJyykKxjUhKJqOFpxHMJxOr1tEYHPiWUX94qWTWmORuowJpmkctJLBg5935A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215214; c=relaxed/simple;
	bh=7os+h1//0xS4f1wY7V0AnocFIZElNDK5UXGVQ5Gs78A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BZnm/SpxRk3Jn+xDrbYPyFfpP/lHdSlk9bri6sZwNRFu6oQyKaZB9DuQfgzUgwtx6Q9kXFka/0y/aTfdhIkcJoF/UpdyCKfovUI01K2nTXt62rDXi+d9fk/AB+lszlyYEPiHmstEaWOv5IHOlgPm7yUYysegQbG6f3F1OyeV08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=u1icESwL; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=UwVQGcAvlHyCad18FyKM0n1Cv16vhzbYDI44aFiCCQI=; b=u1
	icESwL7v3HQf/p6F0JathIb4kzaAGhXCMwpLTURXWnMosOPruQt+Cf9SZWfi3tz/uQf5x2uepKOHX
	WBRcXokdNclOVLmTJM7V7OFxEG/FwfYN9B4DZRocD70EWcrv/N/NFMQ2TusGEEjzmJI6NQQWI/zMA
	lvnu4PfMiK17vWOuXSCyXPUabfxk5i7h4aOuR44yL8IDMaG3+j11O/KtDEOwVPR68EcsUPGS0rrJe
	yFLYYyIG80/UJA1luzIG1XroC5HPlUe4BFGtrFYE7Q9ccTNZ8laA66jukOr2XsB5PGOETkLCYa634
	IwSmkSaKnqJ6KnznROGTJWMXjI+ApzYw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp1Qi-0008Y5-Rs; Fri, 13 Sep 2024 10:13:24 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp1Qi-0005fo-0O;
	Fri, 13 Sep 2024 10:13:24 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 13 Sep 2024 10:13:12 +0200
Subject: [PATCH v4] arm64/configs: Update defconfig with now user-visible
 CONFIG_FSL_IFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-fsl-ifc-config-v4-1-ae4b012fc402@geanix.com>
X-B4-Tracking: v=1; b=H4sIABf042YC/3XMQQ6CMBCF4auQrh1TpkDBlfcwLqCdwiRKDTUEQ
 7i7hRWGuHwv+f5ZBBqYgrgksxho5MC+jyM7JcJ0dd8SsI1boMRM5qjAhQewM2B877gFU2pdSWy
 w0iQieg3keNqCt3vcHYe3Hz5bf0zX929qTCGFgpzTqrFGU3Ftqe55Ohv/FGtrxL0vDx5BQu6sb
 kgXRS7twaudV/LgVfSps2iURaXsr1+W5QsRcEjeLQEAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726215203; l=1796;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=7os+h1//0xS4f1wY7V0AnocFIZElNDK5UXGVQ5Gs78A=;
 b=eb0gc1ZGMqugBb1eQXXAX6FC/7o3voK/9ARGD/6vgPAVKCU1aRTYAganAnB0nxdTbqW7OFEyN
 dczdnJ9hAyeAh3ImaLl/EWg5nQsSXlAgnX1HrPT8B1Hi1n/KaKrPHxe
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
selected in defconfig.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
be selectable for platforms using fsl_ifc with NOR flash.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")

Changes in v4:
- Rebased to 6.11-rc7, dropping patches 1-2/3 as they have been merged.
- Link to v3: https://lore.kernel.org/r/20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com

Changes in v3:
- Refresh arm64 defconfig.
- Link to v2: https://lore.kernel.org/r/20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com

Changes in v2:
- CONFIG_MTD_NAND_FSL_IFC depends on CONFIG_FSL_IFC instead of select.
- Refresh powerpc config snippet accordingly.
- Link to v1: https://lore.kernel.org/r/20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 362df9390263..f485609697e3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1462,6 +1462,7 @@ CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
+CONFIG_FSL_IFC=y
 CONFIG_RENESAS_RPCIF=m
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y

---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240523-fsl-ifc-config-c877902b297e

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


