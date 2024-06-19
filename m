Return-Path: <linux-kernel+bounces-221282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DAF90F144
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80ECEB242A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D45156C5F;
	Wed, 19 Jun 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aMTFo4xP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B821581F4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808437; cv=none; b=hXSC2GZeatbQS0pla3fVpuXIDa8qz7hQdgF2XOEkWTbYFnu3/qP33RpF395smn50g9a+vA+ubiaNvq/YZULY5fHQZuU3mw/T/7Bsj4IbuixhGMLLgKsU7/2xAq+Rgv7cjB2SQeUHIApIc5n+04VUoibG/qgIsLGbpR2c+pt3l20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808437; c=relaxed/simple;
	bh=AvMEH8+KihB+RCqkEHdbuY3XBZvm9qmhSI5bau/Z8bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r78zAziGOjZkGpU1it2Svoyhx+ok03/mQ6FZkmnDW2z1c9JDdbTUj60MgP3NVsRrEmgfCGjl2TVC4ts9iglSAoYqXr1ZEBHW3F+ILDW/Q53B1ccr2HTgGfaxnvnIy/IYCMezsWC5cyClizQDzNEobbfuQ/ozOvFeevlcOxVjC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aMTFo4xP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso871538866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718808433; x=1719413233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7n2AkJl0fgGMf2VEe6AhFr9U06FnNgwEKVPhxtEQpY=;
        b=aMTFo4xPUaTsOKWSmczjNh+YrFTKwCNYAU7cUEItAAYvoIMwt2tfj9L5B7rza3PgX6
         VJFIE48X/dIthz4RpXIgiOELMdyLcxeOMZkGgaut4MT+xSJL574aVH/tke8hIfEsRQGG
         5wUE2MG/dt8H8joHikgYCKzW6k23rwA9N0zd5JA50DFubEjq8RAmvSBeT33GPU2P2QYe
         saXursk6qYGNqsOtig/6Ct7tdp+9YUy6iHyBA1jlPuyWNIUC2p00qM0yB+FYjmPIB4s7
         tXmopAkl3uaYocg9wAWM7/bapsvWHgkkEVHVa0AOiiaLeqURsiP/p6uduSGH5co50eGx
         hewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808433; x=1719413233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7n2AkJl0fgGMf2VEe6AhFr9U06FnNgwEKVPhxtEQpY=;
        b=Ic1xZwO7bWrVurfgGch78OVgbbD7HrWp6thU30i5Z7b1icDFrks4S0UOnsvt50LMXP
         8Eld2RFVQjLDP1Osr6ydnqCtp0WNn3Mq7xxV/GlKbAI0E3810W0ZW/VVrBIWje7iC2zK
         /S8VpSTa412aorhEmWkBja0qdKFRLi2+gtv++J61eJ4VF90bebPOvT7kE2A/mPD+LlNx
         8tYzgqSeyOZhKoyM77PwSSMdi6Yj9w997MVTyzGz9yGJOgdY0PktZqVtEcu60gm9yMeu
         zmkAgjDttBRudqNLB3dwDf3roFaWoBQgDd9sxGZRWpxqt7DRy7S+KU+34wSknnTjRQrQ
         MhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Bk1b8uinrM3veK2fUN6H6utIL3aNexvbePaL5jmq/EsJrMyS9J/4VYUerua6g9VZi7okHSvm9kUnhfxByVRNA39lRRydWrsLEnZp
X-Gm-Message-State: AOJu0YxnV3gl7vztJzf0f9bAw+27jvsUqbcef04JwqFAocINMgDgqfwZ
	UjZM5/esobWnNuMSUeC+XQVKGUTPjjn9gbKQCuJH9ZhtyJRQxTjGLvyOOjWnSwM=
X-Google-Smtp-Source: AGHT+IFejjmBbR+O7NOilDUucTHeY4c4aDqAu2lRXv8q4ZHn25X/QRNZIhLDZJ8tRMuEdemHgCMIog==
X-Received: by 2002:a17:907:c708:b0:a6f:9ded:3200 with SMTP id a640c23a62f3a-a6fab602dcamr173816566b.3.1718808433651;
        Wed, 19 Jun 2024 07:47:13 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f56da32c3sm679787566b.13.2024.06.19.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:47:12 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Wed, 19 Jun 2024 16:46:52 +0200
Subject: [PATCH v6 16/16] arm64: dts: mediatek: add audio support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v6-16-f754ec1a7634@baylibre.com>
References: <20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com>
In-Reply-To: <20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=AvMEH8+KihB+RCqkEHdbuY3XBZvm9qmhSI5bau/Z8bo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmcu9RgD0cIrV6/lCH0NYdwIPSFjZgfo8uICKgdRMK
 BiUeAheJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZnLvUQAKCRArRkmdfjHURX5xEA
 CVAxYmx20YDtVP5oFfSpgCktC+zv920AeENrb2JQxRdR02ezp1MasNc5UuKYalU+fXHwpgGjDaCEIf
 YqYAbCgFcT0QS/gij2R5R0zpORXf8quGhlpQx+5VqnF0lKCCG4U2PelntPOgKGMnZNlV2gEZodL/9n
 +0WiTS0FUzaTzQrC0vSh1CArExbmcxeg+JE6N+k3NCx1bEzRFX6yI3+F6bu40xUADNIrUNBzHkJtBr
 HSdVO4wWMXxuLM7EOZ+NWD3A4KdaToDG6T6gek5a1tVW5XQDUqMSxclIPtaF8Oyk0O9Cd8GCxKnkzC
 0wc8qSbhEVnOpMFt8ONEHPQVdaDF3Gndv2J3j/bnG5yQ9Zgo/g2Ezz33cHu0loW9J2ca6SY9BRfRo+
 E+JwpPhCxNLh+L288kzF6n9CBP+/O54C0LupdysRSxzDd/WBtbvZQMDCwIqpm5m+xJ41kOBe4eIPQr
 JnTj16T/X+Vb8FYvXw0mn1lv+K5VVh+uWTrcQZ52W1MsfpbU3HojZbfS4WzDawiPmc7YRa9/OOP45R
 sGmzx8awEwD38ybbIcpGx8lUo0lGI0w0vr/VlzSGrYXgl02FrsYjgu+F21jvflA+8QfY9ujx2B1zpU
 BKrnHGupCmTswsKViw1AnCcl4JFje0yKrx2j9WC0Fole5dwv41uEJaRkHfQg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add the sound node which is linked to the MT8365 SoC AFE and
the MT6357 audio codec.

Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..f8e9bd732668 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -4,6 +4,7 @@
  * Authors:
  * Fabien Parent <fparent@baylibre.com>
  * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Alexandre Mergnat <amergnat@baylibre.com>
  */
 
 /dts-v1/;
@@ -86,6 +87,28 @@ optee_reserved: optee@43200000 {
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
 	};
+
+	sound: sound {
+		compatible = "mediatek,mt8365-mt6357";
+		pinctrl-names = "default",
+				"dmic",
+				"miso_off",
+				"miso_on",
+				"mosi_off",
+				"mosi_on";
+		pinctrl-0 = <&aud_default_pins>;
+		pinctrl-1 = <&aud_dmic_pins>;
+		pinctrl-2 = <&aud_miso_off_pins>;
+		pinctrl-3 = <&aud_miso_on_pins>;
+		pinctrl-4 = <&aud_mosi_off_pins>;
+		pinctrl-5 = <&aud_mosi_on_pins>;
+		mediatek,platform = <&afe>;
+	};
+};
+
+&afe {
+	mediatek,dmic-mode = <1>;
+	status = "okay";
 };
 
 &cpu0 {
@@ -178,9 +201,75 @@ &mt6357_pmic {
 	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+	vaud28-supply = <&mt6357_vaud28_reg>;
+	audio-codec {
+		mediatek,micbias0-microvolt = <1900000>;
+		mediatek,micbias1-microvolt = <1700000>;
+	};
 };
 
 &pio {
+	aud_default_pins: audiodefault-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_72_CMDAT4__FUNC_I2S3_BCK>,
+				 <MT8365_PIN_73_CMDAT5__FUNC_I2S3_LRCK>,
+				 <MT8365_PIN_74_CMDAT6__FUNC_I2S3_MCK>,
+				 <MT8365_PIN_75_CMDAT7__FUNC_I2S3_DO>;
+		};
+	};
+
+	aud_dmic_pins: audiodmic-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_117_DMIC0_CLK__FUNC_DMIC0_CLK>,
+				 <MT8365_PIN_118_DMIC0_DAT0__FUNC_DMIC0_DAT0>,
+				 <MT8365_PIN_119_DMIC0_DAT1__FUNC_DMIC0_DAT1>;
+		};
+	};
+
+	aud_miso_off_pins: misooff-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_GPIO53>,
+				 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_GPIO54>,
+				 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_GPIO55>,
+				 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_GPIO56>;
+			input-enable;
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+	};
+
+	aud_miso_on_pins: misoon-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_AUD_CLK_MISO>,
+				 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_AUD_SYNC_MISO>,
+				 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_AUD_DAT_MISO0>,
+				 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_AUD_DAT_MISO1>;
+			drive-strength = <6>;
+		};
+	};
+
+	aud_mosi_off_pins: mosioff-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_GPIO49>,
+				 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_GPIO50>,
+				 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_GPIO51>,
+				 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_GPIO52>;
+			input-enable;
+			bias-pull-down;
+			drive-strength = <2>;
+		};
+	};
+
+	aud_mosi_on_pins: mosion-pins {
+		clk-dat-pins {
+			pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_AUD_CLK_MOSI>,
+				 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_AUD_SYNC_MOSI>,
+				 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_AUD_DAT_MOSI0>,
+				 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_AUD_DAT_MOSI1>;
+			drive-strength = <6>;
+		};
+	};
+
 	ethernet_pins: ethernet-pins {
 		phy_reset_pins {
 			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;

-- 
2.25.1


