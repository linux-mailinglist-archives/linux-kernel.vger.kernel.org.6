Return-Path: <linux-kernel+bounces-440283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985439EBB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992DC284143
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5222FAF0;
	Tue, 10 Dec 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GhhT67cl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCD22FAE7;
	Tue, 10 Dec 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864099; cv=none; b=khYZ1FxA6HFZKO0b2iN4lsmP3EjSBN+6r0bUfGZBaQ8u1oCCkVtBSnGYyvp+kg4e4sF2fXiOq8g0QRXEpR58J5PcCfQdyqunuVWbTeKfxP4p55AFNQ5vKemCA1F4wckNpvIL5zJuaJ5bWBLfoLu0Rzg/+wV8Bms0JV4oHNFpgRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864099; c=relaxed/simple;
	bh=LqEkimeRIC2RS4VpxiR75y2hmkC90M/mOqKrUkHY3Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4qP/ZrqMFTchvpwDiVcKteNTDHAO44+dQ7Qzwa+WazyjlurAO+F7zLQQR4XEgqVKdCGyyyf1Rl2wGRjhBA4qsSic+JPwCOjmO/FDr2hnT6Eo08OK5f9S9yYqOSO4/9s9HyxFpLXQJku+/vcDAPZinIh7Uo+bthZFHE4OoY4gGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GhhT67cl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733864095;
	bh=LqEkimeRIC2RS4VpxiR75y2hmkC90M/mOqKrUkHY3Qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GhhT67clcJoTkt3EMvN1kfcyptYhyav38nirR5fIkZTbc2S1WIb5msNnssy5PGuj0
	 6va9Uu7uvzUd5d3hI+Xm4xeqNTkRKg8yWNC1mn9CLu+dzRmJqUdKfJd/22VfuCo368
	 XkQ02z5kvFmEDOEuulVCTsxy3iEU61Xlpb9eZkEcdBjSFZDgt7jbHav1XMZTLxU2fi
	 gQ/qyez2ApP3Wk9clHqawk7lZ5i7tUnE0WiDqknvkb4UIZjfGnw9ew7Fe5Bmvdo5HQ
	 nMaqdma9p2JYTbcpUmcvHxPYYUZES37X4PZ3F8EpFiCskiOQRwa+9ICYVMPRREwU7z
	 AdCRmyv4eTI+g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3C5917E3806;
	Tue, 10 Dec 2024 21:54:51 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 10 Dec 2024 17:54:29 -0300
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 sound output support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-genio700-audio-output-v2-2-c50886ae0be2@collabora.com>
References: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
In-Reply-To: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

Describe all the components to get sound output working on the two audio
jacks, Earphone and Speaker, present on the Genio 700 EVK board with the
audio DSP enabled.

Co-developed-by: Aary Patil <aary.patil@mediatek.com>
Signed-off-by: Aary Patil <aary.patil@mediatek.com>
Co-developed-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 13f2e0e3fa8ab6679f843693230b9661d323a705..04e4a2f73799d04d50476eb1664b1afdbc66c124 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -93,6 +93,24 @@ vpu_mem: memory@57000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x57000000 0 0x1400000>; /* 20 MB */
 		};
+
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xf00000>;
+			no-map;
+		};
+
+		afe_dma_mem: memory@60f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60f00000 0 0x100000>;
+			no-map;
+		};
+
+		adsp_dma_mem: memory@61000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x61000000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	common_fixed_5v: regulator-0 {
@@ -210,6 +228,16 @@ usb_p2_vbus: regulator-9 {
 	};
 };
 
+&adsp {
+	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
+	status = "okay";
+};
+
+&afe {
+	memory-region = <&afe_dma_mem>;
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&mt6359_vproc2_buck_reg>;
 	status = "okay";
@@ -932,6 +960,26 @@ &scp {
 	status = "okay";
 };
 
+&sound {
+	compatible = "mediatek,mt8390-mt6359-evk", "mediatek,mt8188-mt6359-evb";
+	model = "mt8390-evk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&audio_default_pins>;
+	audio-routing =
+		"Headphone", "Headphone L",
+		"Headphone", "Headphone R";
+	mediatek,adsp = <&adsp>;
+	status = "okay";
+
+	dai-link-0 {
+		link-name = "DL_SRC_BE";
+
+		codec {
+			sound-dai = <&pmic 0>;
+		};
+	};
+};
+
 &spi2 {
 	pinctrl-0 = <&spi2_pins>;
 	pinctrl-names = "default";

-- 
2.47.1


