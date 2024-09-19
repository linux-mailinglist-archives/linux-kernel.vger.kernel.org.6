Return-Path: <linux-kernel+bounces-333766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E654897CDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A907C280CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32EC208D0;
	Thu, 19 Sep 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X37I/edh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2C1CD1F;
	Thu, 19 Sep 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770959; cv=none; b=f/TPXoTMdNXQ/rfHcp2TlhGI2wu1DrfWIa/AE0S8bIQJAsPQgtJXyv3QX6nW/7jZfyVe4OqELM3aiQg5iuPruyY6fDMNoaOHBch4lKPllfIUV78d5k0D1sk51a7URA6xEI0Ho+Wxy3dCibwlJrj8mhO0slV1+/DPIjR66mABnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770959; c=relaxed/simple;
	bh=W49WozanLprZEJxgdhsiRD8i1r/Epzp6B7fBpUrzNNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ju65XGio3JzB33vPUEzP8KxQ+TvMfHY2z7sa7Evubp7C3MLHh6cUSt61unRJwFaeWNTI0pT0Rx/6yWSaGG3Lki2FgnAFI7VEUEWlCRr9FS1IVDfrcpgMVJ876jUtBIyrmY6K/wEElCU/7ayPTh1ZvVN008XposZKuETB1jRGMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X37I/edh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so10984865e9.0;
        Thu, 19 Sep 2024 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770955; x=1727375755; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7wbTHSo9+XfWUpxWPDNev/PMADReLxOtwvmxGAdnEw=;
        b=X37I/edhlrYahGYoTtacXbdYRakoKI/Li742LQ6RhcAf/ikcMtHuR/y6ucRhPpHRY5
         TG1DeRInGURFsb10/pc3D//ILqHTMvjSXwCOBwHj8lzxN36H34SaOjrgr/oXSsHNesiL
         XHpyZfQU6q3jwUzd3Nx1WH4k1eASUSgIbYqNc/v1b9LBExd+BOf1k2LjD5bLQGh7O4c6
         4qyj/nMsVNmGsuTmkmlfD6bVKYxZPQKPLsh4zMKj81MpBCr5Y285TgB0eJPO+Kat5MsS
         ru+rcOhvliXb5ZlmJDUq5NmC6sfTt1BmCH82orfOoeeitaNcK2xnIs0Uz0qdaEy15x0s
         QQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770955; x=1727375755;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7wbTHSo9+XfWUpxWPDNev/PMADReLxOtwvmxGAdnEw=;
        b=POp7Sc3NTf95FKekozlNdJWme+S9vo++2um5LpmsffuQdIWcJAO5iTP2ZSu2qnGaWF
         ehVucUS/tzNq9xDieF6CzcYjLvam3uX750aqvcnIsFJso/wD75hjxg72UMYtBwwHONIm
         cJLF/BMDCdwGhfWTk3M4pcz2EfZ3yze0x4zSJWrOlTWucP0tnBLz+c1p8n4M6v3vBoHp
         1XEzBXfmGHJbBa3qXRHjSqrPHEQnjTke6IGe2TzYElXrqpeGBRhUWEX5x+HAiSImekfP
         hfl8KyXAkgOwudH12pvPp7PagzmANqIFejLU94xJ5fXdH5DgIUoOU/NSn94k/NNEsL6B
         ZMdA==
X-Forwarded-Encrypted: i=1; AJvYcCWeji26hmrYJdjCNzK2+DWXVxbgdJzmjXC2yXtnJEKntg+MBRutU2tnvFvdjOWkX7yIVkJOMu4wkK2+Zpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjDPJDRK47ucF7seTV5iAPJhe3wlXlxSphLD7xPDb1N0tFrPE
	5lhJIoedPcR3+LmPygbEMcHFvE+CiQ7C5fSx2vLUUG2vEdRfU7XZDrcI93o8
X-Google-Smtp-Source: AGHT+IE52EiCmyv96iQ6F9zx0Vq2tE3Sx85XTboMQtqUo9n54qi1QYTgF3Q3MaSwtjjHK9zj1ChviA==
X-Received: by 2002:a05:600c:4f51:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42e7abf3db1mr3004865e9.13.1726770955107;
        Thu, 19 Sep 2024 11:35:55 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-128.rib.o2.cz. [85.193.33.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e75440657sm29110805e9.20.2024.09.19.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:35:54 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Thu, 19 Sep 2024 20:35:39 +0200
Subject: [PATCH v2] arm64: dts: allwinner: Add disable-wp for boards with
 micro SD card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPtu7GYC/42NWw6CMBREt0Lut9e0tUDwy30YPnjcwk3oI62ih
 rB3Kysw83VmkjMbJIpMCa7FBpFWTuxdBnUqYJg7NxHymBmUUFo0UmOv0XXOB3bkw/JMCg2/0dp
 B4CtgM9a16RuqSnmB7AiR8nz4723mmdPDx89xt8pf+695lZijTKmNGKtKidtkO17Og7fQ7vv+B
 TbRJH/KAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726770954; l=9820;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=W49WozanLprZEJxgdhsiRD8i1r/Epzp6B7fBpUrzNNE=;
 b=wfXOiLSQZ9AQdNDPurMx4ypsx/yoUjo62d87kyOsMX3tbkihuOulnziUFV09yRHCP3whqkMBu
 8R7ihgSCnXZB6q2qFHDOYxW39Ooix/+QrajYbKIhNn7b2Wxvnu03vDt
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Adding disable-wp property for micro SD nodes of Allwinner arm64 devices.
Boards were verified from online pictures/tables
that they have micro SD slots.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
Sorry that my last messages were not in mailing list,
one was wrongly sent and second was rejected, as the bot claimed it contained html.
---
Changes in v2:
- NEW: Added the property to all Sunxi arm64 boards, as discussed in mailing list
- Link to v1: https://lore.kernel.org/r/20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f54f0d6620@gmail.com
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts       | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts  | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts         | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts          | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi           | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi              | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi    | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts          | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts       | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts | 1 +
 16 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 526443bb736c..18fa541795a6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -136,6 +136,7 @@ &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index 05486cccee1c..128295f5a5d6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -88,6 +88,7 @@ ext_rgmii_phy: ethernet-phy@7 {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
index 3a7ee44708a2..44fdc8b3f79d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -157,6 +157,7 @@ eth_mac1: mac-address@fa {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index ce3ae19e72db..0f29da7d51e6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -153,6 +153,7 @@ &ir {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index b699bb900e13..d4fc4e60e4e7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -153,6 +153,7 @@ &ir {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index ae85131aac9c..3322cc4d9aa4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -82,6 +82,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 734481e998b8..3eb986c354a9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -79,6 +79,7 @@ hdmi_out_con: endpoint {
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3be1e8c2fdb9..13a0e63afeaf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -129,6 +129,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 6c3bfe3d09d9..ab87c3447cd7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -131,6 +131,7 @@ hdmi_out_con: endpoint {
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 13b07141c334..d05dc5d6e6b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -94,6 +94,7 @@ hdmi_out_con: endpoint {
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index c8b275552872..fa7a765ee828 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -133,6 +133,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index 855b7d43bc50..bb7de37c0d58 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -124,6 +124,7 @@ &mmc0 {
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
index fc7315b94406..a3fe39f8e2ca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
@@ -81,6 +81,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 
 &mmc0 {
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 26d25b5b59e0..dd3bd9cca710 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -52,6 +52,7 @@ &ir {
 &mmc0 {
 	vmmc-supply = <&reg_dcdce>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
index 18b29c6b867f..16c68177ff69 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
@@ -111,6 +111,7 @@ ext_rgmii_phy: ethernet-phy@1 {
 };
 
 &mmc0 {
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
 	vmmc-supply = <&reg_vcc3v3>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index d6631bfe629f..024377b333c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -71,6 +71,7 @@ &ir {
 &mmc0 {
 	vmmc-supply = <&reg_dldo1>;
 	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };

---
base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>


