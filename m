Return-Path: <linux-kernel+bounces-518742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B15A393F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6063A165257
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985C1D5AD3;
	Tue, 18 Feb 2025 07:42:49 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25A1B87D3;
	Tue, 18 Feb 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864569; cv=none; b=W6FFW50vxiNz+QdqJeH3o86Jt2awYv42Tx4MnO2S2DnqwVNoq+fME/6hoKy5ZpBhPJ4wsNJFOiUZ1mDgPPsnbbO36QliH/tRYovYt1CbusDA1v/GYPQkrGDlfhmoyNKWVJruAjkvoo8esM/BAz2Cm4PxAhIizZAVpYaXXrvbiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864569; c=relaxed/simple;
	bh=9Y5xqlji3QcnjPR1iWTgZUWuGo15XrO/7x06Glzq6qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlIumwCqs4QaDG0gPL067LUjouGWQlEaczTs7U0Aj23EU1sq7sYp7ErZ3AgqlpjtqKAPwaKeCGCTqqSJSgfrpGAD9ySTeGH+nm1SWF+1LxOXtNZNuAr0eOfi19lFdruek5kefjjPAqtwk2/KfHnZTb4lv5KVZ+95TMkG//jK6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFd-00G0MD-0q;
	Tue, 18 Feb 2025 08:42:40 +0100
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
Subject: [PATCH v3 04/15] arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds bridge
Date: Tue, 18 Feb 2025 08:41:45 +0100
Message-Id: <20250218074156.807214-5-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
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

From: Yashwanth Varakala <y.varakala@phytec.de>

Add a missing voltage regulator of 1.8v to the sn65dsi83
(dsi_lvds bridge) node. Due to the absence of this regulator, a fallback
dummy regulator is used and that triggers a warning message from the
kernel. Assigning the appropriate regulator avoids the warning.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 8de5a46512b0..7e859c65317a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -286,6 +286,7 @@ sn65dsi83: bridge@2d {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sn65dsi83>;
 		reg = <0x2d>;
+		vcc-supply = <&reg_vdd_1v8>;
 		status = "disabled";
 	};
 
-- 
2.34.1


