Return-Path: <linux-kernel+bounces-545841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F24A4F250
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D747A165ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD153AC;
	Wed,  5 Mar 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="3RC5UXMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0jpC5ivb"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829B70810;
	Wed,  5 Mar 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133962; cv=none; b=d3XUWqn6rkzRCM7z0Bsy5oJQ5vHPGZCFAcOq/AZSjbMTUSzR2zD+7TlLD3EcZZ0O+W9I0OzDlSB82jn2R5H+EJc/xIl56qsw1FeASRTlznIEjZ3Poz9R8zqb1EfDSNwkgs6BO0rmrSZBBG3gb16Axc1mWvSc+SPyO450S+8mTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133962; c=relaxed/simple;
	bh=eEWb/XZmXX9nazc+bTYI9X334LW1NVj5KLZW+K9JODU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pqh7n01cZoo+Sfr4Xk4pFgOHb17afqeGn7u9PORrBK2yKKVob5CHqHxZ8ZTxSmYOSkjQ0dYXy2saEh9bzstbrQRWvpBo9xXEsIXICX7+y82SQ7kBDTuabjuWdKsaxC44BmBJn3n4ZvPIgG+G6TAYbig35oXiZhhs4l7s7PmLlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=3RC5UXMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0jpC5ivb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F20A13826D1;
	Tue,  4 Mar 2025 19:19:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 19:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741133958; x=
	1741220358; bh=nMqliGyYpfsu19Ad4wb4NZGMWZWQ33k71V6ukpvY4Vk=; b=3
	RC5UXMYN1NS7Zin/KABAZ9c/FhehsYxvDzlJ9+eurKAU6nTEi46onYYa/QLMSQ2W
	Ya2UzRmKeOixLK4rJbXMCA/Hp60/lxDl9FrCBQphTLzObUiVmRWHU6AMaadkh5UR
	7RNRngSZJld8p1ocBbKlR6PgkD4n/iqjBMe4uXcOmgeBjbd5C3wTFnEOSBy6pokS
	TehuQhrORhzpnOcdI6m6AHyuNvqd0P6ZByp1mUhb5K1GfZEh2cuQTMBR98lQrxcz
	Cpu5PvPvtufN1s8MkS6SH3GzmGPr9yQ1rl6vgMu+KR48o0jTWOMfD0XxVkG6OOv9
	utoGxQvEv6132i3V8whLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741133958; x=1741220358; bh=n
	MqliGyYpfsu19Ad4wb4NZGMWZWQ33k71V6ukpvY4Vk=; b=0jpC5ivbhoGFFt4kl
	ytqePwP7Uvz9oIi/BaMv6htv4TZbM9RR/VDmpdHABOdWsL1KShLsBl0Fu70xiPJZ
	+kg/fOiL4NVQT+YKYUjIQXdb/uhe9hnuFqtmZzmlDUFyzH/rc/wDUAG8m1H0c3nw
	Gyge8QsjHS/V3jo/97lZz5xpNId2nPToWVTWBfAaC/an0UhQHltzMGenA/E2yTT1
	P5ww+Z6rvUwxMHsn1HslT5w0cZVwB2Bgm9h1kFfhZ5zxWcfk6UCB7305Dp/ubTHk
	8fBPAYNRNHbWjEaSAprH4BTehAEPVmfKvHUh4WHmJzZF1DZNUh97KbngamiFh2YA
	soaaQ==
X-ME-Sender: <xms:hpjHZ-JXkbGo9EWtIIJ_NEG8M1FdNsYKPO51s_Sj0WtG-Q-U46TOjw>
    <xme:hpjHZ2KTJXg2Viy8GlMvpq6uMRSBlERpfWMNj1E9kLW9nynYOfHDYfHNCRZ1yuO_K
    bbnUOsdbspMbrNEuZI>
X-ME-Received: <xmr:hpjHZ-skIrz2acmI-BxtLVhkhE1As_odX4ooBDrgnrwYzAEw4N1Rzo-tGLWVTxmIvMmzorb4_Ssn0rGbFJQ-Lr3dXgqh62jtUvfbO_cr_AlfqNBEq20ri1C87BJ5fwk9jDzBtpO6Gb5J0ND-jNZh2p5zuP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepofgrthhhvgifucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrh
    hsvgdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeeiieefheeiieeuledufefgtdev
    feejffetgedvveduffffleehjedtjeegleelgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgr
    uhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    gvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghu
X-ME-Proxy: <xmx:hpjHZzZGPN_CM1ZDnKFt7SzFu-AOT1JgdzIVbvJoe4JtKAB_SVdBMw>
    <xmx:hpjHZ1Ytyv0OaZUqfr5-aA457j6BeY56PhUVAbrnq7XYRkLS1aJqnQ>
    <xmx:hpjHZ_At_5POVMFJoYXKSG8KRVd7seOQow4vfXoUlI_7KAJb0jmGDQ>
    <xmx:hpjHZ7bAyTIx2gmPL41EEkNMOLb14Rx8DdmHU3LafyOc5RQ6-FtRhQ>
    <xmx:hpjHZx66gkd99NWuyvUNq2AfVqV_gqNyiLDXhV1wDzHT2LZGEXUp2hep>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 19:19:15 -0500 (EST)
From: Mathew McBride <matt@traverse.com.au>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Mathew McBride <matt@traverse.com.au>
Subject: [PATCH v2] arm64: dts: freescale: ten64: add usb hub definition
Date: Wed,  5 Mar 2025 11:19:01 +1100
Message-ID: <20250305001901.31594-1-matt@traverse.com.au>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250129045352.10728-1-matt@traverse.com.au>
References: <20250129045352.10728-1-matt@traverse.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device tree binding for the Microchip USB5744 hub controller
was added in commit 02be19e914b8 ("dt-bindings: usb: Add support
for Microchip usb5744 hub controller").

U-Boot will consume this binding in order to perform the
necessary actions to enable the USB hub ports over I2C.
(We previously used our own out-of-tree driver for
this task)

The Ten64 board does not have any switchable supplies
for the voltage rails utilized by the USB5744, so a
pair of dummy supplies have been added to facilitate
operation with U-Boot's hub driver.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
Changes in v2:
 - provide unique node names for the two regulators
 - remove unnecessary newline under &usb1
---
 .../boot/dts/freescale/fsl-ls1088a-ten64.dts  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index bc0d89427fbe5..3a11068f2212f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -87,6 +87,22 @@ sfp_xg1: dpmac1-sfp {
 		los-gpios = <&sfpgpio 7 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <2000>;
 	};
+
+	usb1v2_supply: regulator-usbhub-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "usbhub_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
+	system3v3_supply: regulator-system-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "system_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 /* XG1 - Upper SFP */
@@ -231,6 +247,12 @@ at97sc: tpm@29 {
 		compatible = "atmel,at97sc3204t";
 		reg = <0x29>;
 	};
+
+	usbhub: usb-hub@2d {
+		compatible = "microchip,usb5744";
+		reg = <0x2d>;
+	};
+
 };
 
 &i2c2 {
@@ -378,10 +400,32 @@ partition@9400000 {
 	};
 };
 
+/* LS1088A USB Port 0 - direct to bottom USB-A port */
 &usb0 {
 	status = "okay";
 };
 
+/* LS1088A USB Port 1 - to Microchip USB5744 USB Hub */
 &usb1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&usbhub>;
+		vdd-supply = <&system3v3_supply>;
+		vdd2-supply = <&usb1v2_supply>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&usbhub>;
+		vdd-supply = <&system3v3_supply>;
+		vdd2-supply = <&usb1v2_supply>;
+	};
 };
-- 
2.45.1


