Return-Path: <linux-kernel+bounces-321256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6197167B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741282814F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71EFC11;
	Mon,  9 Sep 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPf5uymZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D11B9B36
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880693; cv=none; b=aN6SWQn5LJThppMjv0MEI0zzpTSkVbC8VN/bJYd/By3AzN5bpHgWNTyQFkjEazAA/VIlzOEU2i9CPh88UcwEQDwpcjOuBjNKYojzJgrGhsIh2ugF2Gp1/RSBhXUVnwUBKCPahs4bEnksKmZ6wg9fn7kvcc2ok+KbPzalWf5GydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880693; c=relaxed/simple;
	bh=vp6Fq+YpweFo9g/cmJU/rl+izykNZ8G/i8wfZuo6jR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8OCH21YgdjwPOoZ/3KrTTR0YZIwcVMU2kM0L8eSpNKy8FauGGFVC6iDJHRrbNkGukarVny9YfJAQ0eoCiooWn4J5odK9IdSUIrrb3jowAuCx4eKZ24XjRwJ5YY1W+KL+k/oMjWR3WuYxYxkSin/pMkPmWh9SabEXJ0rNHN4Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BPf5uymZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053616fa36so43982295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880691; x=1726485491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8SnkEIUaJgzB4YgotT7EsNuRM1+AXvDniyzdMxhF5A=;
        b=BPf5uymZ7Pb3qzo/7iDOkQHSbyMrWEP0Td6hkkBWf+MiJ8bv6hEQMIlniItszFz9wV
         emlAwATU0PJHxof45+wej5a5VWc2IUKK/x3YzyW+tytlGtBg+nR7TNWY+wgB1N0qsrU7
         azkkpBoh500nHpAFmGz1Uz05uGfjkblryGbZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880691; x=1726485491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8SnkEIUaJgzB4YgotT7EsNuRM1+AXvDniyzdMxhF5A=;
        b=aYgSqaqc+6eoYio+FJU6czfJNF8HB3QGvJRiF85TOBkIskdZvBB4wQDWEelgExb5wi
         T6sL3R2QhJuQPTf4989UU1uyQDqGQFV1XFtQ/TVBKRG93swydWLnNAqmzc7k0osVj89t
         iZNjSZEcbw6o6ybGBADwgEjDsqHt58ZRrM1Oy5KFLef/NcQv+oBFiDXa6RO1krvBRkSd
         xUF5EroUgcJ4lEIvFWlMlnlir44ttcilAM864d3F78IzMTBn85ufInsqshn8+JLpYnVT
         f1Tz0qgHr0kLNKuncRSxyTj/aPuWj0F7aYer9Dm+wA1QeRWn+wcWS2mBizdisAEaauzR
         /tEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuYunHzgqcrbnI2T6cVW0S4qzq+62mQTiGRwOrSwIzP7FtxW1V3/HR1k/EV6Ow/4ykAPg+8XuNghPZrHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZSJtZT/+uFfOdGIH48vRGSnFFCbtnsmYS36SRvO0GNucS38u
	u8sT85HAscZg/pDsGex0NFYLUnZc4h+kuRB6TKCaEwzr6vBOZx/hheLt/uvveA==
X-Google-Smtp-Source: AGHT+IHyDTzsdvKTYHYCRsjLXJj55VMYefAZZ1kao3wEu5P8Vpo/msMT/FaZZWK8Pig44zwKxNmXAQ==
X-Received: by 2002:a17:903:244d:b0:203:a20d:5857 with SMTP id d9443c01a7336-2070a3c3a13mr73134925ad.5.1725880691452;
        Mon, 09 Sep 2024 04:18:11 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:10 -0700 (PDT)
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
Subject: [PATCH 09/13] arm64: dts: mediatek: mt8188: Add PWM nodes for display backlight
Date: Mon,  9 Sep 2024 19:14:22 +0800
Message-ID: <20240909111535.528624-10-fshao@chromium.org>
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

Add two hardware PWM nodes for display backlight usage on MT8188 SoC,
and mark them as disabled by default.
Boards can enable the necessary PWM node as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 7e3a90c1a173..4593bc1fb5b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1425,6 +1425,28 @@ lvts_ap: thermal-sensor@1100b000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		disp_pwm0: pwm@1100e000 {
+			compatible = "mediatek,mt8188-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_DISP_PWM0>,
+				 <&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
+			clock-names = "main", "mm";
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		disp_pwm1: pwm@1100f000 {
+			compatible = "mediatek,mt8188-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100f000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_DISP_PWM1>,
+				 <&infracfg_ao CLK_INFRA_AO_DISP_PWM1>;
+			clock-names = "main", "mm";
+			interrupts = <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
 			#address-cells = <1>;
-- 
2.46.0.469.g59c65b2a67-goog


