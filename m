Return-Path: <linux-kernel+bounces-325154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53329755A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AACB28B52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D01AB523;
	Wed, 11 Sep 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2uiY/we"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5311A7AF5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065325; cv=none; b=HrEa2pgDNofJkqtU7we/stWe5HEt6JkNL65UjVDTQlm2uzzMz2Hg1dX0xKCwknodzbDx/9tGIerxVKk70bPia0Epog6UzE+6VqgrTM2XjQqjX+1reQDnUZyq9Bavts5j8C4FeK9w3C3xmIduYaf10PNxYYwwLwLJNwjjrAQ48FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065325; c=relaxed/simple;
	bh=mAs/mfkaY9YLmO0UTj7/fb0KstDo6E6P+uaBJ+XjPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJOQGtSIIEp2MK2to0Wq5txwv16ySd83o333XBd5yYtgw04O4ioFDkCdZ2OofxBxUwJwHd2OIq8kwHpOyVpn6XgIYMpmhqMQoO3S69jUeP9t/musEV30Rls0tUgg8JhfF3XdC3qfgSK9uEoRXxSkbfw1Mz1bST+MoGQMLJkrgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m2uiY/we; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27b88b8a24aso2593687fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065322; x=1726670122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcMX/bqTdupL750gbpR+dTL3DKvin6dl5vwknoD/GKo=;
        b=m2uiY/weOJe/Q6OAu3Im9LgKnhi9luFI6tRrllrUS7OxIZy9PGktEweu6KH5uLLUbk
         xcjW8ytVvhckPBdTHXVVObJUnJtR8HZpnwp0U4BZ8AzarxpPM7MnynQR0Z2cP8Mp+TB3
         rbaWJ+bZT8KsjzEfbijAiX9hRZEsGvZFViA7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065322; x=1726670122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcMX/bqTdupL750gbpR+dTL3DKvin6dl5vwknoD/GKo=;
        b=dG/7bAeXPIAXekzetJlOfhB9admUSqfeUTwnXft1oDZL0nM6CmZJrn1CkMCCCRRgge
         TXdDUv5v4EWkmAF7TmvEf6ykIoAu5zPtvZLyX9i8wHLvgR/Dm3lm8mF3IVuQo0KB6Vw7
         MSlJNOxdajTaGyE4Sp3KUlZrpxX+3aeMJQhyT8e3zYKi2cPT5eV2+GwskXyO/Lt1f+5G
         AUQRkRCJGVx9Ly8Db85hbonTy5o9ZQqj9PB+RYC3dzehsA3qJwCkDKg7kbhgHeBac4Yt
         e9LB3Q804rXfrxLsuPLIilGhSgCmWmKbfdIzzcnp7D8Q7PPK601J5RHiMwQxmRnhGtIz
         /lIg==
X-Forwarded-Encrypted: i=1; AJvYcCWImXNN7IlIyTS9C0mhSBhkJMG1zrtJuI+2n51hS7osGIVWhXBvN2gb8L6j2qwhB5Hfv2BgByNA6k2eDxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQiUv1veBr/ko/UfT9NZU0+zCFc+vd/rj87/hdGSO6qCbbOBU
	qhNAYyxKtWrpYMWWXoQBNmCRaSe5SZaDshX5KjgKj10SVUg78VUdT8CscSTmow==
X-Google-Smtp-Source: AGHT+IHDFd+1Qao0x/djh7BnAl9fxiCea616EBUFpEIvtWPidor0dGilr+S0MNN3z9ITAlHbdxzKew==
X-Received: by 2002:a05:6870:b28c:b0:278:1c68:9c0b with SMTP id 586e51a60fabf-27b9db07830mr10994291fac.22.1726065321905;
        Wed, 11 Sep 2024 07:35:21 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:21 -0700 (PDT)
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
Subject: [PATCH v3 5/8] arm64: dts: mediatek: mt8188: Add PWM nodes for display backlight
Date: Wed, 11 Sep 2024 22:33:58 +0800
Message-ID: <20240911143429.850071-6-fshao@chromium.org>
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

Add two hardware PWM nodes for display backlight usage on MT8188 SoC,
and mark them as disabled by default.
Boards can enable the necessary PWM node as needed.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index f746b89c1ec6..61530f8c5599 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1418,6 +1418,28 @@ lvts_ap: thermal-sensor@1100b000 {
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
2.46.0.598.g6f2099f65c-goog


