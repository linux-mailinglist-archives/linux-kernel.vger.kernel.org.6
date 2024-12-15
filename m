Return-Path: <linux-kernel+bounces-446304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE49F2257
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7BD7A0617
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCA49638;
	Sun, 15 Dec 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnwUTsUQ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A0208A5;
	Sun, 15 Dec 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734241023; cv=none; b=oPZTGZ0JgFy0vNTJPB1zeTTJwTGphwbB0ZnMLJWvG/9+RNwxtVOXD3eD9nvL7bMOGQOZIUl77ZoZvoRfZExtTPUJ5EB12aybQiu56p9Zjq+7i/EocMYYrgOKDBF8zpG7tiW4kOMDLCXgfVKw26hkF5v4d/miSfxtvg3saUnNo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734241023; c=relaxed/simple;
	bh=hjq60g0f5rs7IOK+bpQIZlGtwoS5wPwAF2qfnusr93Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjKNUf2i9h0X4peqrGlV3879bStyG3hbL1qHaT/C34BEQlXkSOFHgHBfJZ2zNOyuRp3zmiqqZqwjLpHTTRUGvFWHjDJLTcb2s1FOauN0LKGEkA7kWTzPiqguvM5v69f05seENV38re04qT7wZYgJVm7k7AQ5/spj6+GmFbog/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnwUTsUQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so3246660a91.0;
        Sat, 14 Dec 2024 21:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734241020; x=1734845820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhrQlN2vwbW+HH5J9QciNO8jVjYFc2SW7Nua2x90G3A=;
        b=lnwUTsUQAclglqekuyzhTsQPzLHI7SsamEGL7pm2a16DlOKhVcyCeY0B2OLKFGA+fm
         uDdEuT9LyxGOjYHMZ4GRCdivfGkzu1kCT75L3PAJgdp5uMDKIetFjcDKelkEMgvqZ/PB
         3xl5L6MRZgnmEgG7aLGwFF9CESwtMOxDu56Cp7LRzpcpU0/LJiHheOhs+f5l0hYgUpiw
         uH6mJPy80HkPgi6uzVRi6zNq7VaAzMw9M2nvfH4VRb3Bo5cTdtKfiWggTyiQikcLPgrw
         EBS7k8CwI2OHkkWxs8CIFnvh1as6ER7QDvDb74jEushX1sbYayYvijf3oc8BP8jgJ266
         sC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734241020; x=1734845820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhrQlN2vwbW+HH5J9QciNO8jVjYFc2SW7Nua2x90G3A=;
        b=CNu5Cvu4faP2VdVCQq5fTPE4EjH4MuhPFbzLKUy6nPWu7FqG7zzhTzEE51g7FOJQzu
         N1nvHHbO6mqymqWTtur1mf7g1+qNr1dbH97ztVfcbHnqdcOpFl5V65SvN59LVpy+oKDS
         bSnIouzkVXQJmQFQjjFwqF5Un2oLaPgcuOiecriLTjmAzkJGqZKHd1CrnZL8jusC/2GI
         2TyAhRqYEEvUgc1B7hdIuTeCunFrrNulHvOI12obOnGgQdwD7GKbhrMkgEpXrp0K6pir
         /iWun5cEga/RmKWMVW8PDhOHfm5l9VcG/UMBec3bvaigu2+dUBtzSmdevHi9P46qXkww
         9N0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2R4Wm/45Fh5l7ZQTkUzoaJEZCsZFN/t4GaVER64KrvTwLimlUvqNpCW5g9u6fahF01vftptbwdyqV2c3j@vger.kernel.org, AJvYcCVY3jdlr1ZVu3J4bfM9aNyz+AXJfZZMJXgBW7Z3XRT9UOebqlrdSu4HMInsjfTvsajIx/C1pbISxSDJ@vger.kernel.org, AJvYcCWanLiHcVkZFdEHBmeV/b+UZZCElfYqBV91xWoN20Q8qquVQq81EGWb028cO+BSoIqjyvBG2ZBEyAS+@vger.kernel.org
X-Gm-Message-State: AOJu0YyobbpPQ6KPOMX2WJWnuKTfXydGI64ceJiC7ybgtN3OdC4uvAOn
	O4HAV2PYpg3NcT+AWTg+1QbkSBHpGewh0fferf69FLCbWUUcXgL6
X-Gm-Gg: ASbGncs1L4rYtLGIydRqXmeNP0OuwzX5uc/OaDhK1N1udZnn+NhGv0S++6CGwigjRDz
	WfDw4EBS97qeS11Piy8avAEgeeY3IRGDYjmPMiZL9my1QYyVRC7nAFMoPcoF1s1iRUtJ12wTlW/
	rIjtGfG4gW/G4OKebapvPXILUAJh1T3Jl3xUPRHZ1VimZSOv2+H7AcXvauv/5Bw/McS6KeLUsjY
	6FOcxe0SnQzLyuENT+gowNPSciGPohrh+MFhOClb2C1RyM6wQ==
X-Google-Smtp-Source: AGHT+IErUG9RW0X9xHdH5/Ssxiqt3RncarH98/x9Df651+JEpUXRrMwQ+2RKrQ87NQ7RiDs3G7ovLg==
X-Received: by 2002:a17:90b:4cc2:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-2f29166acd5mr12192019a91.9.1734241020112;
        Sat, 14 Dec 2024 21:37:00 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cf8sm5729803a91.38.2024.12.14.21.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 21:36:59 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Roman Beranek <me@crly.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/3] arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0
Date: Sat, 14 Dec 2024 21:34:58 -0800
Message-ID: <20241215053639.738890-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215053639.738890-1-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCON0 seems to need a different clock parent depending on output type.
For RGB it has to be PLL-VIDEO0-2X, while for DSI it has to be PLL-MIPI

Video output doesn't work if incorrect clock is assigned.

On my Pinebook I manually configured PLL-VIDEO0-2X and PLL-MIPI to the same
rate, and while video output works fine with PLL-VIDEO0-2X, it doesn't
work at all (as in no picture) with PLL-MIPI.

Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 379c2c8466f5..86d44349e095 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -390,6 +390,8 @@ &sound {
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index b407e1dd08a7..ec055510af8b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -369,6 +369,8 @@ &sound {
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index a5c3920e0f04..0fecf0abb204 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -445,6 +445,8 @@ tcon0: lcd-controller@1c0c000 {
 			clock-names = "ahb", "tcon-ch0";
 			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
+			assigned-clocks = <&ccu CLK_TCON0>;
+			assigned-clock-parents = <&ccu CLK_PLL_MIPI>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
 
-- 
2.47.1


