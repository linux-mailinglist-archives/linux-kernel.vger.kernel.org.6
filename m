Return-Path: <linux-kernel+bounces-252496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2929313E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597EB283D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873118C34B;
	Mon, 15 Jul 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCT9xen/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC98218A958
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045770; cv=none; b=YnHMENpDvV0LYdlU6LXRfagrtllXzYaOWcqhFD8NqaDnm9xt182FInQZBDaZGQJk3icKX6T/d1wl1WCyuzw0xNI2IP2hQ3BGyAsg5punR64AVX609nvX8VcLCy8/HKjGq+/Kui1JDJ/rBoLKOLJbnJdzVVG8HPGlc4tURj1FasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045770; c=relaxed/simple;
	bh=uRHj+xASeRStbUPUcco0GvGgUPHvwx8Q22ADeqLFEsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDJhQVfxoAed5a/76JOSpXhNNoI+8R0MhCGVfyFd4PVjbWlGt4fMraR7ZgN7+n7gAjKaHX9WT/XAc7p9gnxLQ9tEAjxRzCp3JmnaH5Kuj+31Xf7KOqRWfSiDKfmBstqdQ5jHYYdbpKOFhaFQmAplEXBQrq4Wi1uxN+L11GVZGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BCT9xen/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36799fb93baso2429648f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721045767; x=1721650567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlicpzX8j7ceD/JMCHCgT4Wp1znP1wKt2ZwJqztrd3Q=;
        b=BCT9xen/HkPZmswnKd8e98txmjSZD63NCzsGErdCO/fLiloTaLeBRV7DHU/8Zt+ZdB
         tPIH2cWppYioAZ45FHoFN9w2yslKoUysd5uHkjv/to3IE9XWUjQNG0zmPLxWnRihTqXG
         HN3Y+oNGTdfU7Ns0fZ/CDzd+uP6U7JVgWh9/fP+F1k+IWzFcXQJ18SkFKXbZhm3fm19k
         OshAbzsZcHWtDi+eITydJ6bQWMi7wvCSWp6aqgN/PUv48rv2WH+AZRRTVBJihqKTbg8f
         1xNNoK3gpdewkqNYZ0Uz6UZ5vrGDLfggJ0/nDQUTzZvwK7viSXx7BbzIngWZMP1PuL9h
         Qs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045767; x=1721650567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlicpzX8j7ceD/JMCHCgT4Wp1znP1wKt2ZwJqztrd3Q=;
        b=NmKwdj4RFenll+WGcGVYHrUQYrtL2MAjpwNBHJb4nbmoOrUxei921LBVHjpPSH/Lq+
         r66EGTP9FPu47HZnJJ7AaoXJ68p7uxwYcKexmZCh9FlScjFqRWR/IAIQDYShl6RJLZAv
         6cKc0KGPNuVLv7F/i5Lo6+9yw7nGs2KmIncfOkUk+mhLPvfvqBw/trsG/t1uOMpI6vXl
         VJEJNp0n5SpxXzyEr6KhPdlYkhT7A4iGy9sH+t64EibJ8D1uYz9YsFfhYBrJ4a7cvbd0
         rPzB2/U8Dy5v+IFxVv2gtBTkIZLIUT3PLcRdvV7kF8jf40Z8nup+B9jeYX1FKtSlZ4S7
         xMhg==
X-Forwarded-Encrypted: i=1; AJvYcCUxqiMOV/bVD7CDzrXbXwnJ4XOmBByGki6hK343YTslObkPisKx6+VLPxSclryUqTmBoDn2w5wGoMbG6ZIA/Ad/Q21wA3bz6gZ6kqE7
X-Gm-Message-State: AOJu0Yyp+uR9ExSq6yqi2ktzflV3S0jBqlXrPNhJa4KuH5QEQjouGiQb
	XfIMn2mrTRSWOgPgdBg8pmj8UPqh+M40jnNekZNjYXzzCsLwUttREMUeNFdtLE8=
X-Google-Smtp-Source: AGHT+IGgvcNb0nVQlFTcKcu6JOIlWWDkfbIbuPOAB1CSXeabBGkhzvEOawCNDGbvQTG94lGN9DpG+Q==
X-Received: by 2002:a05:6000:2c3:b0:367:f281:260e with SMTP id ffacd0b85a97d-367f2812acamr10220652f8f.3.1721045767292;
        Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:886b:1a3a:7569:3d95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680d9771aasm6369201f8f.0.2024.07.15.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Jul 2024 14:15:39 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: x1e80100-crd: Fix backlight
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-x1e80100-crd-backlight-v2-3-31b7f2f658a3@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The backlight does not work correctly with the current display panel
configuration: It works after boot, but once the display gets disabled it
is not possible to get it back on. It turns out that the ATNA45AF01 panel
needs exactly the same non-standard power sequence as implemented by the
panel-samsung-atna33xc20 driver for sc7180-trogdor-homestar.

Switch the panel in the DT to the new compatible and make two more changes
to make it work correctly:

 1. Add the missing GPIO for the panel EL_ON3 line (EDP_BL_EN on CRD and
    enable-gpios in the DT).
 2. Drop the regulator-always-on for the panel regulator. The panel does
    not seem to power off properly if the regulator stays on.

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
This can be applied as fix for 6.11 since the driver works as-is with the
fallback compatible. If so, the defconfig patch should ideally also go
there to ensure people actually have the driver enabled.
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6152bcd0bc1f..4a4eb7211e69 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -268,7 +268,6 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		pinctrl-0 = <&edp_reg_en>;
 		pinctrl-names = "default";
 
-		regulator-always-on;
 		regulator-boot-on;
 	};
 
@@ -724,9 +723,13 @@ &mdss_dp3 {
 
 	aux-bus {
 		panel {
-			compatible = "edp-panel";
+			compatible = "samsung,atna45af01", "samsung,atna33xc20";
+			enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
 			power-supply = <&vreg_edp_3p3>;
 
+			pinctrl-0 = <&edp_bl_en>;
+			pinctrl-names = "default";
+
 			port {
 				edp_panel_in: endpoint {
 					remote-endpoint = <&mdss_dp3_out>;
@@ -785,6 +788,16 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pmc8380_3_gpios {
+	edp_bl_en: edp-bl-en-state {
+		pins = "gpio4";
+		function = "normal";
+		power-source = <1>; /* 1.8V */
+		input-disable;
+		output-enable;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };

-- 
2.44.1


