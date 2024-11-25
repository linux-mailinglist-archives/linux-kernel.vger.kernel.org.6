Return-Path: <linux-kernel+bounces-420652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83EA9D7FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15474164819
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1218FC85;
	Mon, 25 Nov 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Vv/Ejg7m"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4A18FDB2;
	Mon, 25 Nov 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525373; cv=none; b=RAUt8VLmTc9yAa3T/A28KvAuN4iGI+2TVnlYrVstCUXTxQr6UDqHFgfaCjV4XrsqX9T1d3tndWfx6gJ3RxXPuHl8CtbFBKLdD2lkUenLQhrOfir1JyfJV+UfeH9OxGMbW8CPlHFe0r9dN920Y5i7JkpXvJeY0P7tAUQjOWv5/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525373; c=relaxed/simple;
	bh=uZT2iBXe9UuhlJ9TygrX1VqYtFP+FE4SxrxENxyx7QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sU8q4lPPhjGjA0UB9KSc0v7AVUR9EofPkLI85OIn1Dwe2XK0huy8wnHY2LIj1NdhVYbA+AYMRY8vqhrivwv5wrK7cCK3G/wbBHkY0UAI5wUB/BIIviSwZka2mxnCDGzebCj2G6WIpdRh2l9pBM4bs2P1/OaCuubgrHCg/mwCoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Vv/Ejg7m; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2VSk0YkTxmS7lNUnuFUnvEgxZ7d4xlsb3g/LizjVEFY=; b=Vv/Ejg7mXXs3XOL0J+2qpzgPC/
	x6atx0vBWZIaDYLP1fJGIbY7DsKduQ02SiTIusyF6/uEpqmbGre24O3EL//tRc//JHeGdyhf21RHA
	ZZ8304pDgeanf5XQy+4XLAr3j93kA4HUD1hLYEjJMHJqzPSm1NSpvj6tQwL9icJkla8aynUE6916O
	BitYvWDPaTV6uggcR7AznGzf82lGwxlRgzJfdBaGm2lliHPbcZi57T2INdtSwRLZfKY4eEsGEua2H
	mEuqIcDJzcoBErh42TA1kreiq47N9Ck94gW1fF8dVNP3l0dyH82nvmbXTWxzXJbiww/ZpOZvrzhNX
	7muhO9DQ==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIp-00Eq70-0m;
	Mon, 25 Nov 2024 09:18:38 +0100
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
Subject: [PATCH 04/15] arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds bridge
Date: Mon, 25 Nov 2024 09:18:03 +0100
Message-Id: <20241125081814.397352-5-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125081814.397352-1-andrej.picej@norik.com>
References: <20241125081814.397352-1-andrej.picej@norik.com>
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


