Return-Path: <linux-kernel+bounces-218390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80D90BDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B141F21E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6334199259;
	Mon, 17 Jun 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/mB/Trl"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885231D953B;
	Mon, 17 Jun 2024 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664001; cv=none; b=BDXEvspzkdHWIAIY0oBW80vjzh4mgvkttchs4di6uD0Jgsi02g67zsngAdQThfYPTNmPoB6NjnNvXVUSx8sWxCu+On0j3p70TdMuB4IA6AbiGNVN/eULAXXDpMJNuBpjKLM9pzLlGQApISxVh+GR/MhNwpC/gLdRrKHUVCAOoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664001; c=relaxed/simple;
	bh=bi6Y8zmXiTKInnkXG7JwRP6/fjYzKkL1vZpdveEyuRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZGanWhRoWplmv9bo07oL+gtd3401XROpxpnV/lTOqe5mJu6mKw11cuwVk94ICiPWNIC5NDQW6pzc3qkVCtvoPZsFPlEd5V9GKooCMcXnssaJDInbw9vb5VQMtk5wZjfJNcFBLXDX087xxx9eWyiDvqf6KnYznJ+6KQILxAri+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/mB/Trl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so217462539f.1;
        Mon, 17 Jun 2024 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718663997; x=1719268797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pilmjE7Fd1aeWcRQgiLhuPvlXnr77T8c/+92X/hR46s=;
        b=B/mB/Trl9s636vLy07rGsRHK3sd8xOrQn/Ma/mA1ghr7Z4eKlxwj1eZTKLmbaCToMX
         o6qFkeZqv5pwDGJEtiY7c4CF7ANdLglkly3DvY0GH53eknlsosi53pf42k92+PB0Zi4U
         X2PjG52+v79CNP62548EIwNSgREnqYoPHBKfpAaoRpn2qfpnyy7UMI0oSUDk8A1PZaH9
         2ZQ+V1w3espxfIap1OnK43J7vu5GCg+/gfQo8CLR/4VK5+4aXi3jqWmj70op+TbBit+a
         mWDQLemRlSG2VDCWavZywBGtSF2XZVWmRLEfp49b6GKxDQdoP9To0uMlWz+wKMiaskg5
         wuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663997; x=1719268797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pilmjE7Fd1aeWcRQgiLhuPvlXnr77T8c/+92X/hR46s=;
        b=B5NrWTsAl6c1zTQWenQlwOeIxjYkvOPO0VtXzynMGeQSJylVWJTj7shuj5n02RewEv
         FYwY78wWyo8+DDNQ6l7pR91lyuiDig29Np+I/xWLrJ0Jy2DimNXGmznEmLAIXTZLJEV2
         F/OC1agSRagSGJqUqB2tLPKzrjquhGu7r7E6xdW8eQ1KHGbfP7kPK6VxSfhwvc2mj/qH
         I7HeqzY52VlaUz44+y+iG0/eQGSmj7piOfyu5RljMEmCTNbx4KX4f9V/PSEMTk4DLduM
         sX5tKCkDaEOZPwskXo7MRkV/RTs012lSFPmlVX5MAC+Ki42JfWWkfwSF7eX7/sOnovg4
         A3+A==
X-Forwarded-Encrypted: i=1; AJvYcCXHyhwNCYuUwS9pnRP356a6WfVzZqE/1Y2XV/TjdxBXktoaHFrT5r6FQXghlXfw/MaMNkuquAUhhvBNUBUuta+PX96B3mDBeqYh2mGcA+BUXh+aKhrQWkK2xTHjUzAWq4K1hKCdKXoPNw==
X-Gm-Message-State: AOJu0YyrZFVoQ6R93hgPf6m6a6wdLJbbQXnhbJj9qlTi1Jgjh+QfTdR0
	z4kITQwCtKfc6fVD4aoNmHKKP8NYzMKu97tTmYLiDYdjHBuwlCrspmVcHucL
X-Google-Smtp-Source: AGHT+IFthX3l4bIPWr8JOAwFidH7wht/c8nO5p55fH77H04hecSOh9g8mWsGGcbpKHaJyVlEct9MiA==
X-Received: by 2002:a05:6602:6d02:b0:7eb:89ba:44fe with SMTP id ca18e2360f4ac-7ebeb647388mr1076974739f.17.1718663997401;
        Mon, 17 Jun 2024 15:39:57 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:3ccd:905d:95c6:7d96])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdb74cd1asm251549639f.0.2024.06.17.15.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:39:56 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	marex@denx.de,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
Date: Mon, 17 Jun 2024 17:39:51 -0500
Message-ID: <20240617223952.1899201-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pgc_mlmix shows a power-domain@24, but the reg value is
IMX8MP_POWER_DOMAIN_MLMIX which is set to 4.

The stuff after the @ symbol should match the stuff referenced
by 'reg' so reorder the pgc_mlmix so it to appear as power-domain@4.

Fixes: 834464c8504c ("arm64: dts: imx8mp: add mlmix power domain")
Fixes: 4bedc468b725 ("arm64: dts: imx8mp: Add NPU Node")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index b92abb5a5c53..3576d2b89b43 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -789,6 +789,23 @@ pgc_usb2_phy: power-domain@3 {
 						reg = <IMX8MP_POWER_DOMAIN_USB2_PHY>;
 					};
 
+					pgc_mlmix: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+						assigned-clocks = <&clk IMX8MP_CLK_ML_CORE>,
+								  <&clk IMX8MP_CLK_ML_AXI>,
+								  <&clk IMX8MP_CLK_ML_AHB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <800000000>,
+								       <800000000>,
+								       <300000000>;
+					};
+
 					pgc_audio: power-domain@5 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
@@ -900,23 +917,6 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
-
-					pgc_mlmix: power-domain@24 {
-						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
-						clocks = <&clk IMX8MP_CLK_ML_AXI>,
-							 <&clk IMX8MP_CLK_ML_AHB>,
-							 <&clk IMX8MP_CLK_NPU_ROOT>;
-						assigned-clocks = <&clk IMX8MP_CLK_ML_CORE>,
-								  <&clk IMX8MP_CLK_ML_AXI>,
-								  <&clk IMX8MP_CLK_ML_AHB>;
-						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
-									 <&clk IMX8MP_SYS_PLL1_800M>,
-									 <&clk IMX8MP_SYS_PLL1_800M>;
-						assigned-clock-rates = <800000000>,
-								       <800000000>,
-								       <300000000>;
-					};
 				};
 			};
 		};
-- 
2.43.0


