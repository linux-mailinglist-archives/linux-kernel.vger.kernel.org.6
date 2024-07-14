Return-Path: <linux-kernel+bounces-251879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12426930AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ECC1C20F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74F13C677;
	Sun, 14 Jul 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcOjqwJb"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9DD27D;
	Sun, 14 Jul 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720977626; cv=none; b=sRtSBCQHhd9+4JJo+nSqSPYoDsZm+kcLrHc3BwOmG/1BvGejkmXEkz6WCUQ0P6JvYr/KniSZQo7Mnfmt+N7fsyNCQUwkK5j3BYZ1Afju64YNEGe3mJd3bHaxpGnWmx5tPdwHixqCi3b3Glsa9rmhJZ0qzX5xQ/S9PtKJVHJsN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720977626; c=relaxed/simple;
	bh=A5Bcqn8FRqYalb1UZD9jh+58Ex3sAWvAdNFs//hWPBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhseH9bDzhrHJOEWfG8aJfAY77h5uajGMi/k239SkqqnKuxwLKghkN4s90fHqqfsRQpcdoDy/e9pfOYIzI8YiOZMVSZOxUWqyV17Wdkl1nu3td/0yHWViXILW8utlQXjnOquRWFcsgqRPioWjSNMl86CarQSGwp/iM918rJyTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcOjqwJb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3856b7be480so13006075ab.0;
        Sun, 14 Jul 2024 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720977624; x=1721582424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlQJVnEnvYtG6Urx8xlXkjHKNYwq7RXhH4sQHIkE5Zk=;
        b=jcOjqwJblIMoQGQKMuYmylbC8vfG/J0fPgVCCm1sisnd6/PRxS0BMrXSpPPVIob4Ef
         tqf3Q6pBL22a1hk5YlqEffuNxRli3QcfFNW8csaoM8q0JhjKPK4UMhVuI/7QP+z3QBGp
         uol5rQZrtJRh3SsdN0e/aiO9jVfL6/bYGy0mo0S0JnviYu7nOX82G6yhhAdx2jwE1OmA
         QvN7+GxIQnGIMsWDuiQghjHZpdVZWhONWDM911o/nS6HHdsq+f8usVDHsgxh+dMoZ9Vs
         SjB/HBZToWOEq4t7VId1bx9aOj9w0/R+blQyhlduFkcxlwKdp9GmWlP9qXRVpxANzbpL
         IpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720977624; x=1721582424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlQJVnEnvYtG6Urx8xlXkjHKNYwq7RXhH4sQHIkE5Zk=;
        b=bg5bap8tVPd6bIfp3hhuuTFi/WEDdj2DmVwN0Do1uJoQyX2dImULJdj0coi92GwHvs
         q6sGfiXOuWEAzydIc/ROaQ52VmUJvGVIuqKxQtn1LVJRlGYEQ0FQzSVlu620ZZglYBV3
         njq0Qu4qiqEJmxW+XABLUpErQPqilR51mfGY4awpTy5RSjUxBgqpGG0/xTrD9UAANn8L
         Fxeyd/4i2T4rGdNTxAt5ho55+4PLAPfj2BBY/BLr01H27NftFQiTfZCMMnKw9Gw3/zFO
         wekW4lzoNnkcURfkswneg2u0oeEGw4HtGqgd4Z6qoPWLKec2nhgHMccdwEHVko9WtDAv
         iLlg==
X-Forwarded-Encrypted: i=1; AJvYcCVIFvADAZrTMH+vK0opVQZn1jgx7MEtkyHzcu8Sn41y2Ropq9nTEwOxdLsA9VSxYn1RRky7DF8aYVzBIsD83UHJEMbmin608f5bmlKYSKuWwZl+ROOPuPF0Gn4rd2f3choFbjR1igMR0w==
X-Gm-Message-State: AOJu0YzYtTbzBPfZ/9eXCsLtGQ4b71tknvXPQLuFO2JcM1ZAZn03D7s8
	MGLPbpd2Ltcpw/RZDULRLT7/ztanbIflrWSEkZb+IhZ1CakSDKqO
X-Google-Smtp-Source: AGHT+IF6DTVl/wDe0J/V/t+5rtM8BQuGZZ8qgIqSyMgnG7/Y0BdktL+/90gcxU5w1DRx/MZmfcmztg==
X-Received: by 2002:a92:c546:0:b0:375:a7ee:dff9 with SMTP id e9e14a558f8ab-38a585825f7mr226453335ab.17.1720977623667;
        Sun, 14 Jul 2024 10:20:23 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:5d97:4e3d:78d3:be9d])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3900f5280b1sm11357625ab.32.2024.07.14.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:20:23 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962
Date: Sun, 14 Jul 2024 12:20:17 -0500
Message-ID: <20240714172017.422811-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The L/R clock needs to be controlled by the SAI3 instead of the
CODEC to properly achieve stereo sound. Doing this allows removes
the need for unnecessary clock manipulation to try to get the
CODEC's clock in sync with the SAI3 clock, since the CODEC can cope
with a wide variety of clock inputs.

Fixes: 161af16c18f3 ("arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock")
Fixes: 69e2f37a6ddc ("arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 1871c10f5c12..de5b64fa479a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -222,13 +222,12 @@ sound-wm8962 {
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai3>;
+			frame-master;
+			bitclock-master;
 		};
 
 		simple-audio-card,codec {
 			sound-dai = <&wm8962>;
-			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
-			frame-master;
-			bitclock-master;
 		};
 	};
 };
@@ -544,10 +543,9 @@ &pcie_phy {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
-			  <&clk IMX8MP_AUDIO_PLL2> ;
-	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
-	assigned-clock-rates = <12288000>, <361267200>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
 	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
-- 
2.43.0


