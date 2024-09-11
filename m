Return-Path: <linux-kernel+bounces-325156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352359755A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98691B290F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD31ABEA5;
	Wed, 11 Sep 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="co0Ulp5A"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633F1AB536
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065331; cv=none; b=r2dsLjh2LUdXTYZYrao3vQSO/QgRGyL4Fk31emYxHakRigIUDg4UGwQjc7NUp63axB1RlJBYuG17dBxLG/Gb7gO6Jaz18cnRu0LKbWjPHR5xcC/yTCifzss+8/RkW44r/sUf4S6lxiHt7z0XsqBVbN6brr6Q9NWLi/CfKIPgZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065331; c=relaxed/simple;
	bh=AjMlsJy9+TPD7Xb3eSta7m5LxVV8cDiIB0vj6OtI2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUpKsy6xUTFs0PmrETSpUz4OKU7Xri6End49pTgcdyYO1siLogVU/166AbN0mUb3qA5Kft8FWSA61cAHmyGhrf8CQKRU/lUFKg/NjmlrkvKKtWp+7EvO9KLamVIOjC66MawjQtay5XrQZuM5Jd6Ai2M44TCtJZpOgFneEFGmvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=co0Ulp5A; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27beb2496f4so854393fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065328; x=1726670128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMA2TvApaDTXXGS5nmqA51iitinMolQ+6wWJX3y5BMY=;
        b=co0Ulp5AgBxA0IaQrTinvWKzgn6MGiJmfR6O1Uyw1lyfbhuUrnXJD+wcmp7segIwCy
         6guwmDXtNavRt6hRjJQPno2JJBdk2OCRcYqkYulMbE2vWGyWUokmHe7G6UvtMJf7Gwcn
         J53SvZYpmLhp45RXz7js6lkUM4CfWHjCusEms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065328; x=1726670128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMA2TvApaDTXXGS5nmqA51iitinMolQ+6wWJX3y5BMY=;
        b=jfGumTO5+gVFvloy+S36wDrDhvR44iuAxYOUlC4A2rMWd6T3KHiC4sPfSnj2pwzi4k
         YsRGl4uRS92rXxmnTM2/TsHTIhwACZIcx5BFIlcaIEubThJUKg8k1Skw8SROcwL/6gsY
         BozAHgzs4KUVvcMa9bSgPESVR+UhK2smRiG/RdqLLYJtv0dnGOg1FyoILkpg6gHln5Bt
         uwJUKQSPyS9O2Q/C4WXqxFyrvCnQsiBqwpK7xCya+XyH3nu7ipsXAhT1QGmLBG0g1mG4
         o3uRrHTFCWPIOQxMTb6ZE4ohU25egTiQeUJgSuAHyB5sftAdzF0+n8AiRrII0P90x7q7
         Kvyg==
X-Forwarded-Encrypted: i=1; AJvYcCXOjgcA2xAmXAmZdG0oAsZ/alGNFWnsCTcPDwy8b4DKxmNcwp9mBdvDYY3/CxeQZPxq+/NpS5IYNzRKh7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuI0CziJnHbCzDrlTdyyU5dDybflHxAxbQoAiPEqQ8faHmBMe
	CiG3+beU6DyBLrFzYVvGOITrSsz38DrxZl5ZGR5Giid00vlzh5AsD/v0J2cR/I7cOUei2DDxodn
	gRA==
X-Google-Smtp-Source: AGHT+IGh2PWgPSU6BdEEz5hfgfCNNula9mOJg1NHDihIHWnwxKEijWaa+jCqU93yQyerjX21e/lgUg==
X-Received: by 2002:a05:6870:4723:b0:277:c28c:147e with SMTP id 586e51a60fabf-27b82ed0f49mr16843837fac.21.1726065328099;
        Wed, 11 Sep 2024 07:35:28 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:27 -0700 (PDT)
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
Subject: [PATCH v3 7/8] arm64: dts: mediatek: mt8188: Add audio support
Date: Wed, 11 Sep 2024 22:34:00 +0800
Message-ID: <20240911143429.850071-8-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
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

(no changes since v2)

Changes in v2:
- Replace hardcoded AFE reset ID with correct definition

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index a826ca4d10e3..6327e1006de8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -429,6 +429,11 @@ psci {
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
@@ -1349,6 +1354,97 @@ scp: scp@10500000 {
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
+			resets = <&watchdog MT8188_TOPRGU_AUDIO_SW_RST>;
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
2.46.0.598.g6f2099f65c-goog


