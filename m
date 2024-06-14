Return-Path: <linux-kernel+bounces-214462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209D908518
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477C2B23AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642818C32B;
	Fri, 14 Jun 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RcjOlPu4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBB18F2E2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350108; cv=none; b=odC/OMkm/mfbWavlQeAmZt2R4IEtf7m6HJP8q+3KrF0hKkaXgSLimHB4BK82ADb7MZnCznz2b0HHT9cERhf2DAAqmYZVaigNSgdSZN/DhaZp+2mTCiQU/PThp8ve11WZhOqqKwVHpL5YsdvCYLP7hT0rheZPijLBTc0byhQFYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350108; c=relaxed/simple;
	bh=t0tf5ggyvEv3KEhg9dzpup8fwcOHLyJsYbfkqMonRjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOGh0LVlpkZbVgaD8MkKV1A6vHLjWRb0BpmVQfKIg+26OOaxr23rYaCuMifX3B+nj1bgues1YBydTC6oLjaEGdWfQqURKx0l/hbUsNSviuI8D3Lz2eEJrMI0TUcCpb8N046N2PRFoBWLdzqEsz4eiecWsLuXarArJVhO0dS1TBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RcjOlPu4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso2387385e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718350104; x=1718954904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi1a6qRL/sSf88RkAxOBKeEEBw29sLy7LzarlapS72s=;
        b=RcjOlPu4plXecdbb0+lRn9hQC8vuqxT1eL18t/wSJ28okFVpIwAWU/v6LNpxbQYkS2
         RUuUjfN+jm4mMuEmtUTF+/ehSAyEiLg98iW/0Ci2SBkq4hbkKKsBcNDmfSDYDsWz5OQ8
         eG016BOsS6JCSQyPj5t8gPOAE84ZSx1xc6r9D15XG13V/f3fXDS9/P3ox0GgAXTt3aYs
         YU67WntUAX5PdFXiSKw8+VuPM1BucaUIvN3BBXOntYsi9/RnAvJzedhtrVszfgOygfMh
         ZHVj9UCwdMaBwL7n1kQdQR8lR+W68oQBIcgw3g7xxm9q8I/aoARuiAHsE1kGLEHJkZGm
         T/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350104; x=1718954904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi1a6qRL/sSf88RkAxOBKeEEBw29sLy7LzarlapS72s=;
        b=n2YJN+2QDLCbMcOr0D58QvrGMiiT7HaPxDxiGYqe/GEsgHXx8UVxWWWtV1WZR+5ylQ
         Hve8wYGK2l5Rim02/3AjIzLU4N9DqbL+m0eJE4h5Pyzy8exWyzfvWhYwz62LH8x92eBv
         kipre6moP0jpoxf2Nf3O2lQzaEO4Zh7yO6mLhsQzfDdLShChsTngLa6DWS7qEN6n56EO
         0X2uBXADh6xkKavpmnOWm0YhDUdDovRaZjZdKpxaYDwmOCgoA5sgUV4flmyXSX455kvf
         zubq7vSjd3I3/PXe0xoSOO4jQ5atHIxgfgV3qvWS2cEf8qT+7ev4Ia3xQrBepAgQdTjr
         hFcw==
X-Forwarded-Encrypted: i=1; AJvYcCXvEtudo7foT6BRS/apKtZw/ZntG9oRolp4V5C3wmtdyVGsFRxFeWyKwv6bhOeHLCFUrAIlibQhHqfvf0oln2tFP9wPgUo7MwbngnwM
X-Gm-Message-State: AOJu0YxuCZ0ulF9Wge9wIpfRIkytrPI+lRLDGCZOTdKTyna3SzMKEKk8
	bt2C4pMhUmcIRdP/rf2kTLyGPlYIRBoT8wkgZHcH+fX0HiyveAiMq98VFOUG78s=
X-Google-Smtp-Source: AGHT+IGnyuTyl004zNEknsuOkKnFWyFDczGzzd63f7Ew8B3WBH5+1B0Z8HM3W/isRBTFc2QhVm2A2A==
X-Received: by 2002:ac2:5613:0:b0:52b:c0af:6876 with SMTP id 2adb3069b0e04-52ca6e987c7mr985960e87.60.1718350104243;
        Fri, 14 Jun 2024 00:28:24 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36075104b2esm3535773f8f.101.2024.06.14.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:28:23 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 14 Jun 2024 09:27:58 +0200
Subject: [PATCH RESEND v5 15/16] arm64: dts: mediatek: add afe support for
 mt8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v5-15-54827318b453@baylibre.com>
References: <20240226-audio-i350-v5-0-54827318b453@baylibre.com>
In-Reply-To: <20240226-audio-i350-v5-0-54827318b453@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=t0tf5ggyvEv3KEhg9dzpup8fwcOHLyJsYbfkqMonRjM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBma/D/A8g4JQKGf/bpZClCZkdFBg2gy1TwJe3EHB0N
 zfIyizqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZmvw/wAKCRArRkmdfjHURZMZD/
 0U4U3mFaqelf8+oXtjqp6va1E/hhZpK7ad8wAzeSFAimNE5m6rjbrFIu7WQxmMtYUVuFDL6tC5lkfn
 hfHWunT2Pm55GneefMiXpOuK5Zv+9UZfUrkfxXq2nav0GXUpR5J8cI4WM0p4nG/SWpSLXHEOicKOh6
 QCCocL43vKiNyk42G4exPFaShPNfylM8iMhD/c6iH93CcLR3eLYVtnV+UiVKWpPtoIxrpkUxyEpOPm
 Lfa0xZFWClVCEqz+9fH3rIQBGLnwk1qqtd3gYlnk9trSO/bZ5vtluK05KEFkynYi0/zU031UkDZkhI
 K9nGooP7It3JfUaSCCd2V8igTMoHyW4h0QvDYMcWrPu4/7xJoZh3lCtP4vO2sZrbv/mPHIwIeXC2Tv
 Lhha9ERXxtTlkNgPvARVW3MV5JEwYkrqm/J4yuWeqp9mtdUcr51CdbPkxXiGRRRBsksaz9ps0oclPk
 pY8i6w1QN2Q/a8wJntO6vDsRpd2I5evI+GIzzFc5p1dJmNK8hUCublsqjnDt/Gm7kZphssf1MDW4ej
 LtGVuS2jPtGoZPdM6rS0UTZRdqvV7SKdAuf/WDh9uRQ6Gmym3KDz09L3XzXSssFNsB1kPW9q/DnYWf
 Aeln75CpqX3eUtieL8n1LurXJjbM8MNkX6h1qMEA0lEw8JtRQUF4kZSwTVVQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio front end support of MT8365 SoC.
Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..0051d5613bcb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -2,9 +2,11 @@
 /*
  * (C) 2018 MediaTek Inc.
  * Copyright (C) 2022 BayLibre SAS
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Authors: Fabien Parent <fparent@baylibre.com>
+ *	    Bernhard Rosenkränzer <bero@baylibre.com>
+ *	    Alexandre Mergnat <amergnat@baylibre.com>
  */
+
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -813,6 +815,43 @@ apu: syscon@19020000 {
 			reg = <0 0x19020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		afe: audio-controller@11220000 {
+			compatible = "mediatek,mt8365-afe-pcm";
+			reg = <0 0x11220000 0 0x1000>;
+			#sound-dai-cells = <0>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_AUDIO_SEL>,
+				 <&topckgen CLK_TOP_AUD_I2S0_M>,
+				 <&topckgen CLK_TOP_AUD_I2S1_M>,
+				 <&topckgen CLK_TOP_AUD_I2S2_M>,
+				 <&topckgen CLK_TOP_AUD_I2S3_M>,
+				 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+				 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+				 <&topckgen CLK_TOP_AUD_1_SEL>,
+				 <&topckgen CLK_TOP_AUD_2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S0_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S1_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S3_SEL>;
+			clock-names = "top_clk26m_clk",
+				      "top_audio_sel",
+				      "audio_i2s0_m",
+				      "audio_i2s1_m",
+				      "audio_i2s2_m",
+				      "audio_i2s3_m",
+				      "engen1",
+				      "engen2",
+				      "aud1",
+				      "aud2",
+				      "i2s0_m_sel",
+				      "i2s1_m_sel",
+				      "i2s2_m_sel",
+				      "i2s3_m_sel";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_AUDIO>;
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.25.1


