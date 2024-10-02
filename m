Return-Path: <linux-kernel+bounces-347422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C098D27A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D84A1C21832
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5559206964;
	Wed,  2 Oct 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xig75mOd"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D0206952
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869632; cv=none; b=Ff59ImuFP9Hd3BRXr2nOCQrOeEGL5nAjr1koPIhziOqRjvml74au2PcgYK0AlTDQwswHbyHgQhWQ+1/P+Z6r4yyOZOzroxj8ygqLowqKnnewLi7xyVgOT3ZMyzFiMDiStqpvqZC1mWYbSnXSGta95U8UxrlCWGyfGKZJvft4CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869632; c=relaxed/simple;
	bh=mUqkqHEcCxtpRTfeg/binSxH16mf5p09ySmI/fIlzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6XQTlu9JlP+fxrQXjZKm2wN9xAgtUEKzRYbM1VYjy7O/er3dMbZGiAhtXR76hHZ8dSRJAnPd880j04QWF3XRPhCEOV8MSUzucVlpx1cGEa0L42aFdadRCLeBKJdnaKey2MSz/KSsxUAxEyOlLqEk8y7tsHs3dYzNyYhtILfDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xig75mOd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d606726cso4691411b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869630; x=1728474430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J6IAMekTb4vqO9a374pLD/X7ddMa658jNggvdKpP9o=;
        b=Xig75mOdPBlOjHVZZL4lljOvSfzgpkO78y/aD9ktKpHJq0b1t4rve4SXsJBiCQbbuR
         F8UbWrOSOvppS/toyW6pg8Mx4NDfhh/ksQ+mYVCnq9PnQLPtuMuGw+nZLkWzC6MJB7dB
         XQB4b2VgHvAv3KI9KWqd/2Tbk25G+/iGNBd/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869630; x=1728474430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J6IAMekTb4vqO9a374pLD/X7ddMa658jNggvdKpP9o=;
        b=PG7DPVp1wU50ey73asXOckV5UpAj1ixAA90N0eqdYodGTm01GZCjXRK3PP5NP+OUbd
         5c485kD1r+nr6LeHu+9/S/XOqBscgYu+B/a7bDvoiLW8KI8jT/3Rwus7taI3rbybwb3v
         DmRaAr2q26DZJ01Ky47+xu+CGyvept+ru4QGBKF9K/vtt8RYpvyA/vt84gJSATh0AEM2
         OF9GdlSkEsqs3fVLEwcoL/V8UfLp6YfqhELt8wVeAVXn5Xd7O61r6SYt3eNI445mnnYn
         ZbodDPn7zxpAqhIVpHKbToVOwl5n1yVAUuscmZNoFDmQNMyD7YADceq02rLh3D3bEzMM
         szrw==
X-Forwarded-Encrypted: i=1; AJvYcCW46Nhu8HJhNo2bPOHAQTPFVCjK8MkoyEZLDx8qLxWwfOVRtGTtMpajXyP74YqTPmCAXK6MvYDJDhlqHRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BPrlfpalTgXxSnnuNnMZf1iDL//6xxIjpJft9JWVz5hifatJ
	TODzmBQ1ieass4SCYWUk0nbe7RNBF4CmwvuyM1fd8nRIWb6iTvqsLqLnPOY4/Q==
X-Google-Smtp-Source: AGHT+IHxoSxlQF4L8vnk+9d+dcrFTwh2sgZBeoesnLzs4EQ03w9gCUtKP/Slm2w+wQYV4T7a2uPNvA==
X-Received: by 2002:a05:6a00:4615:b0:719:1df6:c0fe with SMTP id d2e1a72fcca58-71dc5d5443cmr4531512b3a.21.1727869630106;
        Wed, 02 Oct 2024 04:47:10 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:47:09 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 8/9] arm64: dts: mediatek: mt8188: Add DP-INTF nodes
Date: Wed,  2 Oct 2024 19:41:48 +0800
Message-ID: <20241002114614.847553-9-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002114614.847553-1-fshao@chromium.org>
References: <20241002114614.847553-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the primary and secondary dp-intf nodes.
These DP-INTF hardware IPs are the sink of the vdosys0 and vdosys1
display pipelines for the internal and external displays, respectively.

Individual board device tree should enable the nodes and connect input
and output ports as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 5410469e5fd8..943333d2567f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -24,6 +24,8 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		dp-intf0 = &dp_intf0;
+		dp-intf1 = &dp_intf1;
 		ethdr0 = &ethdr0;
 		gce0 = &gce0;
 		gce1 = &gce1;
@@ -2448,6 +2450,18 @@ disp_dsi: dsi@1c008000 {
 			status = "disabled";
 		};
 
+		dp_intf0: dp-intf@1c015000 {
+			compatible = "mediatek,mt8188-dp-intf";
+			reg = <0 0x1c015000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				 <&vdosys0 CLK_VDO0_DP_INTF0>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			status = "disabled";
+		};
+
 		mutex0: mutex@1c016000 {
 			compatible = "mediatek,mt8188-disp-mutex";
 			reg = <0 0x1c016000 0 0x1000>;
@@ -2713,6 +2727,18 @@ merge4: merge@1c110000 {
 			mediatek,merge-fifo-en;
 		};
 
+		dp_intf1: dp-intf@1c113000 {
+			compatible = "mediatek,mt8188-dp-intf";
+			reg = <0 0x1c113000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&vdosys1 CLK_VDO1_DP_INTF0_MMCK>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			status = "disabled";
+		};
+
 		ethdr0: ethdr@1c114000 {
 			compatible = "mediatek,mt8188-disp-ethdr", "mediatek,mt8195-disp-ethdr";
 			reg = <0 0x1c114000 0 0x1000>,
-- 
2.46.1.824.gd892dcdcdd-goog


