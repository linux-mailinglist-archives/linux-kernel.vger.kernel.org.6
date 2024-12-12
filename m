Return-Path: <linux-kernel+bounces-442440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D79EDCCA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771552837CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC518784A;
	Thu, 12 Dec 2024 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFvlN1Ux"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070BA17CA0B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964478; cv=none; b=KaWz05mh/spgCCWsrc+1Tgyn3LzLOZ06fZuzmyL15WhQdkGkUTLtp8iNlT6vROuDdFDZHjVhsoLF9U3jUQvnjXYFOQORWLN/LH6O8qU6jlUm6RWSdRNzGhYcZutRM+TGPJH4BQZ4K7h76dtYJJKUZdetW0oRr456bGXbQlzBOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964478; c=relaxed/simple;
	bh=G01gKfVugkgLOj1qCnYDaqgYbwrnec4EMd+74eUtQZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiWKPp4+2Ib79snLtez6S1j2DQaSwIN3rT5Z/JknzB6XVX32DaVbm/H7h0HVniHxzWN3Bwe6//hV4FEpSqsYFf8hPq0Ds7Nb/IQcudDNo7GOOm0ov2HL1xgoeVQz4JVYL4FQseExlnPeSkehNQh3hjvFZ8eEKHpVTpO0KgCDPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFvlN1Ux; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so43791f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964474; x=1734569274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3lzZAY2al4gjffBF7O/Qr3GavkSOo8mFCJbq43caK0=;
        b=EFvlN1UxMWLmJ/pdEbgX8J+gALwlb5avIysoM85JCj1/yWAJm0rk1kldeEauwuxZ2d
         76knmtwejDFD4kl17Zd1Tv8JAu50pO9s75W+SnZy2eRtpufDk6zRlDSJBxmrOjEqjxyj
         eeuYeG30W9fo+Kr/jDmNdLwCVzdcA1hfY0X7IcW7Cep0i1tco7Dnu8rhY5SgQcIu3Fre
         jD6UVgZrxdyaNU60FsZvacJ3gqqQwcoCQkpCce3TmQDOqRgefAyk1ljiakfjvOoD8doH
         JKGUfmutvbUMdY3l3JCiFSFyIJH77jvfxBsbC3WixWFSCobZILVBD17aUQzes1Jy+Cl/
         AicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964474; x=1734569274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3lzZAY2al4gjffBF7O/Qr3GavkSOo8mFCJbq43caK0=;
        b=V3ogrEAPpcpWO0zUdkfafUxD9/dVaVvZLodVu7if/C3FYp1tG9chMC9v23V6T8liCY
         rEHr4MlJtyphD40LYr6c+jIjLEPfdkyO+vdY+ZX3Q/62DttJ0XIF7tlaIxFRZW5khblL
         mnwI8CBu0/3dUorzN3HugqwXtw0jBLT3ZZmYQ7Iq7MeiIK1g6wELHyJ4PHsk3tkQtouD
         DpV3Hd68IyNOATk/IIYlj0ussdu4e44Hdnqbgv/S+YEXOYH17ZH8ogurDrIvwhY/b1AG
         qA/sRdJRhXZctq7aVBcscPGY+j5DuaB/w+91GcT7ms+FIECiEmZzdQadpemP2PB0Vfcn
         whDw==
X-Forwarded-Encrypted: i=1; AJvYcCWdAAJhixZ5nx95XlVNJHQswkoah/A05WMKqFmEQZZT+QUblhBdHQJ8Gcc6xKRogPY8u4I2smlayfmxMt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQImACp/IFY5AnrHPUUnqP54gBEgf0SFKLx5O6D81OSq/lWa0X
	iweGEkUyY0VcoBn5l4Tz1tA7ubBSQvXAb3jygRPNKDqBzqNFo3X2UXjjvkIkAwQ=
X-Gm-Gg: ASbGncubAASCRR0A5uWcABdwllmoSNKcFmLdTxnj6fvEs1lKW3eSK3q/u7H6FOUDPUj
	fK1sJd2vGPIT1LVE7roHuIKBGZJ4HMGoL1Zvx+BztPuDRj+0V2AhNG4UuuNsu8HpU56JHwcI/68
	6nXo7VQHVFjJHoH4fiCfexmOEgDOKys5m0XdkL1jVkWq70ywoUVqYEIKFHqFng4Mc/zbzvmqaZX
	b2wlU23Sxv1RfU1ACyQM5KlFvxJnsyekWpsrowQmPWxy7cfvq/V/J+hNdF+F1DtQ9JlXBYn
X-Google-Smtp-Source: AGHT+IHfxJlBFyDrHmrHUAJImrACZdzTClOYSJj355MVm/7aogrPRx+Wl/aqNqwSqrWJeBi5Ylx+kw==
X-Received: by 2002:a5d:6f04:0:b0:386:4a2c:3908 with SMTP id ffacd0b85a97d-38788808b00mr869294f8f.17.1733964474344;
        Wed, 11 Dec 2024 16:47:54 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:53 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] arm64: dts: qcom: qrb4210-rb2: add WSA audio playback support
Date: Thu, 12 Dec 2024 00:47:25 +0000
Message-ID: <20241212004727.2903846-13-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for audio playback via WCD937X/WSA881X. From DSP
and rxmacro the sound stream goes into AUX port of wcd codec.
wcd codec decodes digital audio into analog and outputs it to
single wsa amplifier hence only the mono configuration.

The audio playback is verified using the following commands:

amixer -c0 cset iface=MIXER,name='AUX_RDAC Switch' 1
amixer -c0 cset iface=MIXER,name='RX_RX2 Digital Volume' 80
amixer -c0 cset iface=MIXER,name='RX INT2_1 MIX1 INP0' 'RX2'
amixer -c0 cset iface=MIXER,name='RX_CODEC_DMA_RX_1 Audio Mixer MultiMedia1' 1
amixer -c0 cset iface=MIXER,name='RX_MACRO RX2 MUX' 'AIF2_PB'
amixer -c0 cset iface=MIXER,name='SpkrMono WSA_RDAC' 1
amixer -c0 cset iface=MIXER,name='LO Switch' 1
amixer -c0 cset iface=MIXER,name='RX HPH Mode' 4

aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 827ce5f7adfb..34ba563d0d07 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -111,7 +111,9 @@ sound {
 		pinctrl-0 = <&lpi_i2s2_active>;
 		pinctrl-names = "default";
 		model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
-		audio-routing = "MM_DL1", "MultiMedia1 Playback",
+		audio-routing = "IN3_AUX", "AUX_OUT",
+				"SpkrMono WSA_IN", "AUX",
+				"MM_DL1", "MultiMedia1 Playback",
 				"MM_DL2", "MultiMedia2 Playback";
 
 		mm1-dai-link {
@@ -145,6 +147,22 @@ codec {
 				sound-dai = <&lt9611_codec 0>;
 			};
 		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6afedai RX_CODEC_DMA_RX_1>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&wsa881x>, <&wcd937x 0>, <&swr1 3>, <&rxmacro 1>;
+			};
+		};
 	};
 
 	wcd937x: codec {
-- 
2.45.2


