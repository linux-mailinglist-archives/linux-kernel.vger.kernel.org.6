Return-Path: <linux-kernel+bounces-321260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D150971683
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93191C22DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71721B6533;
	Mon,  9 Sep 2024 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtbKNtZu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79851BA86D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880704; cv=none; b=BUYza8zgW4kc6aRrxpuPGW+yMQ5mTS97kRanzeJGkRsaGL2r//Z0KwpiQzxEf8g4tD8wyhHcN3rsI31CDj854ixQ8kP9YGHS2DhC2wDfRwLgP+XV8pEneVTdYMarV7T71JyitsZvnEQ8lnNa2pfYQ4ROSzleweKXxPfWHWNnlz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880704; c=relaxed/simple;
	bh=EGMm38iFpe69baE+7XL9M6ZlEcBp3g8HrzLvr55YfSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBYrQXQoU94z4QkAbgVqbTuEeQPmW313nY3ow34hp/hDAEzGjk8iC8v3iCmL6lR3vEg7VTzCLBanGYWJm7P8hz3aREraZVR/cP0RSQ+Me81/NOeK4IE8iCENsJuXz9nm82rxXr8lnW4/udcmJCNTIbsHqPPstf9A9axQXcrnMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtbKNtZu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068a7c9286so37676645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880702; x=1726485502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E0O8WG9qwHR9JUYmxw/yuHs3HNYdoAdYl7RzElF3KM=;
        b=gtbKNtZuDFRgCcQN+ZTszF8Iqb34VWsY7oX8gC1m3AwjKHM4O97KCdZzPylbTiPYSp
         /Hmf0fynvCp21BQq60LUmqi2DQue6dZrjMpYVzYJKYzpennAhT4gXrE4x5COo4H7Nzfj
         MMnK7Z6CfBcgBTo3AL6zYKBslugWEybj4I+a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880702; x=1726485502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E0O8WG9qwHR9JUYmxw/yuHs3HNYdoAdYl7RzElF3KM=;
        b=T1Pr4v3Sxw3Tvh4tFcC+iUvpt0v/3K25fiJ2YxFkyAfZQIz1wJqBjfAl1oTjG+W9Az
         Roe9dYwXYzr7jmW7f8yi9N5B6sWwN3/avxalONexuRu73arxPM0i4BxnRqx/Zgm4tccf
         G2ttVsK42KshRNn8APAt6W3KrVxuvQh+wNF2A/NFeqHJDtijqMtrdtjByxOnr+PGlJAM
         4JDub/gmnZjpAHvLynQAAMkVbJIyuukeXZUV++QhNX5y1GLp7NnQBTFWjd0IpRaCgH1O
         zr+QjuJhj4VEQAOt2XWqTy5uTx+9vAFvE4cp60I2eNejyVAyfQmzalcT6Etpktsv5BNU
         9Z2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcHiTZVsC6pjL/nTvnpJPzL9RCGU0binhqbeZIh2wkcyWRrilxbtsWt3u74rBnghUaDY+TuRo+zLZODXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPklvIjz2SGEyGpQVhD3sF8afMiG9rHgmUTRC77HtZ7urqAIu
	1EFJn62/K5YRQP6/vcY+vfgbNc0H2J7IrV6H8xmw+CXM1FGUVFA0LjhUniKcHA==
X-Google-Smtp-Source: AGHT+IGmr6w0YJFJy21E98ud0odKV33bYvulxcOeJu7Zcyxoe1V9M007M6uliWys5/1acdhBj/f9wQ==
X-Received: by 2002:a17:903:230a:b0:206:c486:4c33 with SMTP id d9443c01a7336-206f0522330mr138456765ad.30.1725880702085;
        Mon, 09 Sep 2024 04:18:22 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:21 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 13/13] arm64: dts: mediatek: mt8188: Add audio support
Date: Mon,  9 Sep 2024 19:14:26 +0800
Message-ID: <20240909111535.528624-14-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add following nodes to support audio enablement on MT8188 SoC:
- sound card
- audio controller (AFE)
- audio DSP and its associated mailboxes

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 08f13ccefcfc..d99447a01a60 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -431,6 +431,11 @@ psci {
 		method = "smc";
 	};
 
+	sound: sound {
+		mediatek,platform = <&afe>;
+		status = "disabled";
+	};
+
 	thermal_zones: thermal-zones {
 		cpu-little0-thermal {
 			polling-delay = <1000>;
@@ -1356,6 +1361,97 @@ scp: scp@10500000 {
 			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		afe: audio-controller@10b10000 {
+			compatible = "mediatek,mt8188-afe";
+			reg = <0 0x10b10000 0 0x10000>;
+			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
+			assigned-clock-parents =  <&clk26m>;
+			clocks = <&clk26m>,
+				 <&apmixedsys CLK_APMIXED_APLL1>,
+				 <&apmixedsys CLK_APMIXED_APLL2>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV0>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV1>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV2>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV3>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV9>,
+				 <&topckgen CLK_TOP_A1SYS_HP>,
+				 <&topckgen CLK_TOP_AUD_INTBUS>,
+				 <&topckgen CLK_TOP_AUDIO_H>,
+				 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+				 <&topckgen CLK_TOP_DPTX>,
+				 <&topckgen CLK_TOP_I2SO1>,
+				 <&topckgen CLK_TOP_I2SO2>,
+				 <&topckgen CLK_TOP_I2SI1>,
+				 <&topckgen CLK_TOP_I2SI2>,
+				 <&adsp_audio26m CLK_AUDIODSP_AUDIO26M>,
+				 <&topckgen CLK_TOP_APLL1_D4>,
+				 <&topckgen CLK_TOP_APLL2_D4>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV4>,
+				 <&topckgen CLK_TOP_A2SYS>,
+				 <&topckgen CLK_TOP_AUD_IEC>;
+			clock-names = "clk26m",
+				      "apll1",
+				      "apll2",
+				      "apll12_div0",
+				      "apll12_div1",
+				      "apll12_div2",
+				      "apll12_div3",
+				      "apll12_div9",
+				      "top_a1sys_hp",
+				      "top_aud_intbus",
+				      "top_audio_h",
+				      "top_audio_local_bus",
+				      "top_dptx",
+				      "top_i2so1",
+				      "top_i2so2",
+				      "top_i2si1",
+				      "top_i2si2",
+				      "adsp_audio_26m",
+				      "apll1_d4",
+				      "apll2_d4",
+				      "apll12_div4",
+				      "top_a2sys",
+				      "top_aud_iec";
+			interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_AUDIO>;
+			resets = <&watchdog 14>;
+			reset-names = "audiosys";
+			mediatek,infracfg = <&infracfg_ao>;
+			mediatek,topckgen = <&topckgen>;
+			status = "disabled";
+		};
+
+		adsp: adsp@10b80000 {
+			compatible = "mediatek,mt8188-dsp";
+			reg = <0 0x10b80000 0 0x2000>,
+			      <0 0x10d00000 0 0x80000>,
+			      <0 0x10b8b000 0 0x100>,
+			      <0 0x10b8f000 0 0x1000>;
+			reg-names = "cfg", "sram", "sec", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_ADSP>;
+			clocks = <&topckgen CLK_TOP_ADSP>,
+				 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>;
+			clock-names = "audiodsp", "adsp_bus";
+			mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+			mbox-names = "rx", "tx";
+			power-domains = <&spm MT8188_POWER_DOMAIN_ADSP>;
+			status = "disabled";
+		};
+
+		adsp_mailbox0: mailbox@10b86000 {
+			compatible = "mediatek,mt8188-adsp-mbox", "mediatek,mt8186-adsp-mbox";
+			reg = <0 0x10b86100 0 0x1000>;
+			interrupts = <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <0>;
+		};
+
+		adsp_mailbox1: mailbox@10b87000 {
+			compatible = "mediatek,mt8188-adsp-mbox", "mediatek,mt8186-adsp-mbox";
+			reg = <0 0x10b87100 0 0x1000>;
+			interrupts = <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <0>;
+		};
+
 		adsp_audio26m: clock-controller@10b91100 {
 			compatible = "mediatek,mt8188-adsp-audio26m";
 			reg = <0 0x10b91100 0 0x100>;
-- 
2.46.0.469.g59c65b2a67-goog


