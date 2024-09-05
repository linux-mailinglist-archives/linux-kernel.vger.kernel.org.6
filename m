Return-Path: <linux-kernel+bounces-316690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C741B96D2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CFA1F22828
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41228198A30;
	Thu,  5 Sep 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DxGzfLLj"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937119884B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527261; cv=none; b=Vf2kfE2dPHjJ+jFgXp/OQeWhZFtPwN2iYyqFYvMnMdQKdY6EYJpyQCh/K0LcXyqYyppuub5hqWNoFid8Aw+NPSkjtXLs3ifiHimjyMbl6vx+dlp8Z6xnGGckFvN/ODuzJ3YFT3v2dYqGR3SitfYdD5Xa9sCCFsJqv2OlgkREz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527261; c=relaxed/simple;
	bh=9lwjGAo/eulIDZolvaj7IvijeNRCw0bV1DWR4muCdTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5dkG7w2W3tfp47+aPMu044qrJbkMR+uNBWl2GwocpbCALVC2mPCFGIwnpYXpqS/o6Kk12pH4qriNNnvibK3TWe2nphg1Pmee3kN6YLOexI7KJddlpWCB8eyAUWFQfqwnz1Ax333R3uP+Rcx3Ou4Fr8uVe3tUfkCb+puUh5sz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DxGzfLLj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5356bb55224so604915e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527258; x=1726132058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwBZdTpyVXBSQS4XVblNW9FdhaJgE98Fp4i6BiAgiH0=;
        b=DxGzfLLjiN/lSqyy13cFkLv37AZIU8DzMlr2W47aKq2LTyPGQ1Qd8CoBpDUFdDsHqs
         Qe9GI+zVuNCKnL7/2a3HCuT26vEiwAYs56l+RpzY5V3SISoUgMq+r7W6g6GkhJ7qrzNq
         dc1GRdIDxvwaUPApQkmpNRF++7QI6rCUMEY0FLpUp7o8Qt2P+nTOiY5MxQLYU6iasDGk
         LjFrx0b1o29SufEfvjLuapmc3s61g70FbY9hWJZdSTb8YxBbDU4+BitUDXdDuxLdTpMv
         +C20wjsTnkDgu9SnSrKidQTQQxoLnjx+vBLruQxXQTICX7iFu+9LxGgGF5lr00lJ9tTs
         gOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527258; x=1726132058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwBZdTpyVXBSQS4XVblNW9FdhaJgE98Fp4i6BiAgiH0=;
        b=KCJpc2XjwltRAbGwOrJdNoQV5WjyBeFWvtI7+xrf8kL0weJDgzjqpt9cXdYNf3PkMH
         OKD1OnNEzEcPfWbZ7Hznq6eNofR57uu1Ef8mFFpR4D2F942fb549h2OtQ+agRCDb6SNX
         5/RBepLE4izmpIK1eyqn7EcODJsab8XyDEgpQUOP1reDcC4EaYH0nwh2dqFb1NU9pHgA
         zWjuUW139qh4pR+aPh2GzGWxq9b3tX0vyPkqaF11znirTfOE2aRVKoiAeqRAuns9FPDC
         7+SoqwZNNAOPiT5z7MmBUXu5Nsmom+3H6f+7Z1bmnubz2L8tHpEHK6dRJb++tzkzffC0
         eyEA==
X-Gm-Message-State: AOJu0Yx5e1G4tsancI/NOw535z0UdIgNjhPrGYZHgEP3e3KXlDNXO/O8
	VxekGh7QvqHUfSFEVQ5tpARUgWro1C7WhJ+jgMgqMBZiYznmSpTiBmPCBM5lbB8=
X-Google-Smtp-Source: AGHT+IF7aieJvZ8HE8YrbzaTZ0UEWnmZPAe12UaGqRXV9bW7BmaC7FDWdzRWuEtOWguAaMgKm3ZiVA==
X-Received: by 2002:a05:6512:138e:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-53546ba9d09mr12417584e87.48.1725527257841;
        Thu, 05 Sep 2024 02:07:37 -0700 (PDT)
Received: from [127.0.1.1] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-535406e5549sm2554188e87.0.2024.09.05.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:07:37 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 05 Sep 2024 11:07:01 +0200
Subject: [PATCH v8 4/5] arm64: dts: mediatek: add afe support for mt8365
 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v8-4-e80a57d026ce@baylibre.com>
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
In-Reply-To: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9lwjGAo/eulIDZolvaj7IvijeNRCw0bV1DWR4muCdTU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBm2XTOynFXcIpNO/bFp0nwJbFFUoDl8Wxr5YnClGyk
 bbgNlV2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZtl0zgAKCRArRkmdfjHURUcjEA
 CCcne5XQQBcdrQ57wgg1j9rcUE1gnwrSKYOhA5xbFT9R91zByRb2NLPm6dxzECpG1/qeDATa2IpbqX
 1clMLiwTUsYnlt6tLwUqvYBzXi1nW9XaEqyBK/P0Wu2ySLD+Oz0u9IHtd0QauZTZo7U039Gnv0lkp1
 Gy76QeEtjCGdfz8iiv+PQB/8J6TIx+Wb18wymnlnK8MWaCrO6lRZZzrDAh7wR45Y9cbOBgkIifEGia
 SvWG2aKA1CmS15fkryiR0cyW07BSKjl5gnTVx/niPATf4RfpwNDd2ykQqSufX2umMw5CcinpLmR6tY
 Z+u1CQmPdncXTd0pQ2evFDNfhyZ6FjaHJ6b2EKR/3h3LFr6cv4HrR9/XkuMIO9gSuJlt9MvNgMUaVR
 CfX5mOY4OgB2iCW7NRWv0ARZmzMHffR1/tmVTFtY4sNUiuJJSLoDvK9YUQL9QIDDfDTwBKbM9+ap3U
 k6usMPc47B85X100vyxtrwi94nJeH3LuvArhy/oB//ugi3J6ttBuRfrQ9Y75x9kbzPnQ7AyVa05+bc
 Mz6Bf2RsmC2/SW5yQvgYioNdkSKInbxj1/JzcYPHSiLb/RkUFnPCG65Z2hbvTVAIQm3i1tuQx68GJJ
 5SRioEf+J3M7lqIUGrLLK+kQypR/NwUTbp4PAQYKlJ5LGf9Fs649MbrR7+tg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio front end support of MT8365 SoC.
Update the file header.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index eb449bfa8803..9c91fe8ea0f9 100644
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
@@ -812,6 +814,43 @@ apu: syscon@19020000 {
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


