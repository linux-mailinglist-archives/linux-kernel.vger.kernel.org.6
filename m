Return-Path: <linux-kernel+bounces-426996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D09DFB0B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78327281BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C21F9402;
	Mon,  2 Dec 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="RZzZt9vQ"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AF1F9A91;
	Mon,  2 Dec 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124082; cv=none; b=qZMF/mqxdJ8yz0+uBRgIXy19gnJq8IsYbJ67hpm2hZvvcXycc2qHM4FRRmsr0E2t4MdlbywTbeDoYInwNIIXnIIPxpYJjoyTWGSTSWz/tVdbrqdj6OzBBhr5ByRpjkwwPYAVLra3fcuBm5ZdMxCDjAGdLXQtkuEJ9eWlJZbQBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124082; c=relaxed/simple;
	bh=e/N4zEf41eTpw12OT3r56Z4cX9cB6dPfNbXeSAThuWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IHJL2e418YRWDG9QBOIjelIM/PKv32GsjtvLe3Ob2qyt0cjsPf7x/8fARLXU2Wc5Us6zossH6rfFVz0/7z9/OnktNGFJYUwPZQX1VUVE+0NrIQgS4DNjUPfmPOo2yvjNdsEad+DpZ4Cu5ZPMbv2XRZGAcBAQVaaKA4tm3aDTr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=RZzZt9vQ; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j60eV0RDWpIwo/6h35ZqVsbEzvZp+/wceYsBxRYHttU=; b=RZzZt9vQzISA7TfQ/XdmsgdjDa
	1vIlqm69BOBIsCDduCMBaO3+YeaDvk5B9zxGi4wwvrFk8jLZbI7ldPNtfO2Q0TKaM51SlMmyVwTzE
	7Y6L7IeAONjH3eC3OdUpn8jBWgZ9AIgHPRHhZR8zIp12GmeNp4hQvI9FD6EuOR9huHgXJtE9bGC6u
	3sHOF3Hksx4xQY+T+kn4znl0WIxe5e0iwTa+QkQdYVPH7MAIAAxVfk/HBXtapr3L1LyUZjQ4kEvfH
	ApwJAN2iLxq3bvgnJ2xB49EgEVmo6jBAavB0MXC84X/kHVmCfGXpO5bfqfQ1Axur22zugYAJxyPlF
	vHohSiuQ==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0k4-007Bva-2g;
	Mon, 02 Dec 2024 08:21:12 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 01/15] arm64: dts: imx8mm-phycore-som: Keep LDO3 on in suspend
Date: Mon,  2 Dec 2024 08:20:38 +0100
Message-Id: <20241202072052.2195283-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Teresa Remmet <t.remmet@phytec.de>

LDO3 is also used as switch for enabling VDD_3V3_S and need to
be kept on during suspend. Disabling this can lead to an unwanted
reset during resume.

Set LDO3 to 2,5V as the voltage should be fix.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 6069678244f3..7761acc5c510 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -161,11 +161,13 @@ reg_vcc_enet: ldo3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <2500000>;
-				regulator-min-microvolt = <1500000>;
+				regulator-min-microvolt = <2500000>;
 				regulator-name = "VCC_ENET_2V5 (LDO3)";
 
 				regulator-state-mem {
-					regulator-off-in-suspend;
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <2500000>;
+					regulator-suspend-min-microvolt = <2500000>;
 				};
 			};
 
-- 
2.34.1


