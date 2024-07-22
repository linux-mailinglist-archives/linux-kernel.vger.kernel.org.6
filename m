Return-Path: <linux-kernel+bounces-258540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED08C938965
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D702824C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836585956;
	Mon, 22 Jul 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a1ADw+x/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDD71B47
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631254; cv=none; b=Bp3fpK2vS1rHzyjtLqCRBPqrQHoUdZWk/imGOET4wep+Wdim+aVGIxb+IU+y/oMMf2OyJmRnaNOBPJ7z8qj7C99iEnW1LjJRWK7jjA6RmnsnwqzKg6l5ToAGd8PhKw0wYL3fn82F2jaeSEfjPul5WjwHovWoE5TMNNMSGjqEIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631254; c=relaxed/simple;
	bh=L/X5S7kQaZX7wsv4CHwCmLD31FcTik1b6cbELb3AlwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drLk3who3wtNNCHeIG/3XyohqXnjuU5aS79IWY/E3E4nspOBxrmy4r3wTToXSZfY0SetZ0Cbwfep3FDFBM43vk3qEcuj2QebtFevvxrtwfexTXI/Ae6K3+k0a6J5UkePYZCveLJDpaDiFxbTXSkSfk3m5GsPA3l8SN4oPYM+3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a1ADw+x/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611d9so2991149a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721631250; x=1722236050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKdTgT3KsHBdg4+GhO78bEt6cew1IEq5DPVjepzwO8s=;
        b=a1ADw+x/3WfGjMDF9AfsU+Vqoz53ZVGFUTh3N0EbWMLbmPNEbkBxwphLLFQtOwL1fj
         082XMeOmrIrwJEz1l0TO5RPFoRcC2skwFiAvRSgnHemfsHhlwXMM2WDPHH+qUQq9yv1t
         OcoHXS4F6qpKqJ70r9WvT2YO+UITZebqTpW4JMZr26whhkyq8t0gXoutDQCfy1ZrxnzW
         37M71T44ftgNJsmQZ2C7rRHq4csJMrKK6SSaDE9mdanVKPSsUXxYvmiGhT7GJdtwzCaH
         ikPRQRNZmEaVKxA5NumR/TIx6rvkWQdFqNwtKj3BzFps9UNpgMr8UXcUlkDdhcQjZDRu
         YETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631250; x=1722236050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKdTgT3KsHBdg4+GhO78bEt6cew1IEq5DPVjepzwO8s=;
        b=TtKuxPEs1tL9Sbo1CK8fj4dElMxtDPzbb3OvvN5PtWrHeaPjFxzuJGBm6FpdTG/6RO
         02uukBWTvvajHWkO5BtNFXSrIT8KCvA+pxDOhfXZXcpnZbXJzaGIfxd0Rr3Tc9RtkECS
         9TMDfU4x1V7XcWImhaiI8nHg2RHfe2oTvhk6PBN2NqJYUdsV5W9hzNNgl2x9sTa34Ftk
         QlOcoAYD28Dhlxi+4OTGeZkoNCHTB/QuB0OjgF1IkoWkr5vnc+niDozPmGsKLrBR3iAS
         y0jUgRx/bYVi17RMG/nN1eZfL/xh6P6j0UaIwY70dDCEr68FUzp1ciqtv67D3EPqsm32
         COJg==
X-Forwarded-Encrypted: i=1; AJvYcCVf3RYHcFK3xpxnXTEUwM2H5ltujyyfYN3XZZJu2t0Il6F56zq+X2Hin/g8pFmTXUFblj4IuWNR6MVU5qE3+6OVUF2+IpDLwxLM07LY
X-Gm-Message-State: AOJu0YxRMDbvWaeCu8HeykMNYDNEsNuBBTMq7xis7uagv3xl3fhsXr+8
	PsKHQBw20FvTDxSQ8gMJMGU9qqDfwvJO/luUaxGicCY6DOGQKs99qDUZa4Y+a8E=
X-Google-Smtp-Source: AGHT+IGRHDZ6lSTNR+Vp8mSLIwOqZwh/cysql+g6CZ2J+sqcY5BXIe7wCvGbMFi/JpenhRewq7wJKA==
X-Received: by 2002:a50:ccdb:0:b0:5a1:b7a1:eac2 with SMTP id 4fb4d7f45d1cf-5a477695253mr4183158a12.4.1721631250729;
        Sun, 21 Jul 2024 23:54:10 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a69c1f56a0sm1982126a12.64.2024.07.21.23.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:54:10 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 22 Jul 2024 08:53:44 +0200
Subject: [PATCH v7 15/16] arm64: dts: mediatek: add afe support for mt8365
 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v7-15-6518d953a141@baylibre.com>
References: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
In-Reply-To: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=L/X5S7kQaZX7wsv4CHwCmLD31FcTik1b6cbELb3AlwY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmngHxE1HtH/8qPYOuuuGIA0Xv1sscguHP6j0t+Bmr
 r0dNh/uJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZp4B8QAKCRArRkmdfjHURZ2YD/
 wO7fnA1dxytSYvoi35ZwJmadZ/OrYFAc4n46a2FX+ViBQbtzaSE1yd/STWveNJ/kq4pIjHmKhktcup
 wixJB1hR/XsxpLr18Q7+vj7NyjU3Hn/I47JdWiYqqujwhurqImVEoLM1q07WD37uVmkwANLGNT5H1X
 BOergCnj81apnFS3jhVK9VpydIY68xCm/DK9fkPjpRNlqrv16JHr7IkWzFU/O9V7b1qd7rbdnAVscm
 +03WYA8IuWc5ThAzR5Vao5cgVLMJUxInueGiIZgRu4X7LX1mFjR0/0RjWMcBP5vjg+lf9Z/EnFuOGW
 NwlZ+OQPryGJmuYSZyM6nC34/ddFpwIi+TGrEy/3beIS1QPs2hYCRg+hzHLRMfh70ryrl7cG2SxsYb
 HMi2D9FLSVy631bzON1kmMLcF32y0S+75pwBgwHt9F8tolEr2rQLVnlZgiB5nPNueUdvbs7ybiEdjm
 7v/WvLnRQFxaEoxw7Sh73tDjbVPcRMrOweQA1dbOXhlefRfuE7vaOuphdq6KGr6FpK8kPD6NcCCIX5
 9CabJhJiRQyeeniYuaEjOi9XJA9y5TKA4/e1drZwLAqGgeP+mbIX8X32PdcJPMWHMH1a4LAL9DjxO8
 9JRSriB8/P3QJkS7IXbBFfQym0Wd4SU3K6zXMTiu8+FnpAdZUa3akY/2OnBQ==
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


