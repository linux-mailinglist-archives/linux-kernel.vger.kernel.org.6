Return-Path: <linux-kernel+bounces-426997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71D9DFB0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E301F162F66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF7F1F8F1B;
	Mon,  2 Dec 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="frDWe2gy"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6471F8F0B;
	Mon,  2 Dec 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124083; cv=none; b=avgoyhBoGWhYESifGW8gRrIDt0DOAK9ioEB5WyiZ0gFXwWCocAeGkM1hbu3Sf1z7/TMZEHgrQeVFMnrESVUoUstqplUSaaOoDeqShn45G6MIwMdbkXD8Uwjmt1yM2kd/FGVUgQ5wyzTGNA2iifQvYuz/60BNpHpKwI3qQCEuvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124083; c=relaxed/simple;
	bh=ieMtmlHLq5dKLoi2Q+lMqC1PwX47zkdNIJlauAhROfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMwbdoFvZvY9m/XQ4/kMxSpEhhbTOvPRSp/jYbmbkbbW6S3x5N/Lla+p/Na1nbumo4X3FgwJc/n+qr9IsGaa0zi156OEgKP97q36xLX9bPvgviHVtMnasVbF+SG/2Euf3X9vUupdYkD9QuEJql9orj0z+VnUhPWJdYyAID9E8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=frDWe2gy; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DQOeXeiVkvhOLe3ErqOoSSoGW4JjirN8zefwDthKPwE=; b=frDWe2gyWqkXEN0hc+lflggVym
	ll5T9qsVjKUEsQIGC9I56xuE2qpjPSWzSuzrjIdQtvBB4AYBx7WtBFfvDN3n3SOnR/ChEMFd0Uk6M
	5jwfhO2mGrNGxsg0cg8upNKts/sKTUfqb9iUoh65JUlmETg2Hhg3cM8oQpzMEm5CLCjGyLY6cgPoQ
	1mp/QLaRUIQWS+Za6K2OMQ9+fABfa7Olp5ROSZZdQFKLpmsFkywbzt1vSArknCccexrW5s4pRxbxS
	XNFNItfogwYfFununuMjpPbcuP9xhvp7TXD62qAEgQ2z3X+LGpQRlO7wRXkyJXZ8xr+NPWwgF6NTQ
	7zdiQbkg==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0k5-007Bva-05;
	Mon, 02 Dec 2024 08:21:13 +0100
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
Subject: [PATCH v2 03/15] arm64: dts: imx8mm-phycore-som: Remove magic-packet property
Date: Mon,  2 Dec 2024 08:20:40 +0100
Message-Id: <20241202072052.2195283-4-andrej.picej@norik.com>
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

Remove device tree property "fsl,magic-packet" as WoL is not working
on the SoM and so not required. This also saves a significant amount of
power during suspend as the ethernet phy is not powered down otherwise.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 7761acc5c510..8de5a46512b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -69,7 +69,6 @@ opp-750000000 {
 
 /* Ethernet */
 &fec1 {
-	fsl,magic-packet;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	pinctrl-names = "default";
-- 
2.34.1


