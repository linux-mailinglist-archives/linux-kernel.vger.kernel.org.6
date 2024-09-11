Return-Path: <linux-kernel+bounces-324671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5B974F85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D2D287A70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F07186E5B;
	Wed, 11 Sep 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9s7bpHv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0A185954
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049997; cv=none; b=OY650ynYp9cRHI1iKbm3oaWRFsSQIfWHY/Ur+6TfJBvfFwHooZQG15RoCHsq6nYM9wssUbo9Nh1+nQpuh45TJ8l1n5MeBwp9MKLGuIxRWQ1yZq/nDKbcQW2HvALkXZ7SGo2PhyMDpQceVZB/XDrbXA/x2ETONq01hG3x78jUzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049997; c=relaxed/simple;
	bh=RWmk6OF5GEw/0+RQqnhJttyJm2tPM7O3ljEKjPu2GbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5UxcnquuwH2Q1vQAAnm4Lks1Bsi8GzIa0D7l/yWr5fXJJN3B5fCQk1x65PwO8vtEXGZkIHSMDPPMhakPgO2U0zA4eX3kcr3Lzd96fytAjvpERNtp9yjQtRIpxgGoNqI+yajsUrgvoiIDNSwvL+1K/zX9NPDZTPm8fUQeqKk0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9s7bpHv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so2894995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049994; x=1726654794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtVXEEyIECSDN6VChW7COEyWFA2mGv3xOzKg/F3A7CE=;
        b=Z9s7bpHvGLMDYpNM1bEF8AuPev9So+n0gti6vNw/DcfJqfjCLgLsHNQ0sOsmCs5hQ4
         XK4+aBdJg7Ua4sc20E6xfStoIRq38sVYW1ueKSkD0qlN8KTiUumc29uMWscPJJfr9dvv
         lxO0YadETt6H1JvWQUU0a/HqYMLXP642WkhbUR0sxy8VIC0veCPcSsVavhsgdoodsFFI
         PfmuZfvIdL5wjClq6RDuUOK50LgPR1TvA0xtfUd+UuX0CEup5uxRmzsJ0cAzigq+tZIZ
         pTjBlU3AYipoLCoZMARdPzcgE6kEsL5K9Qj26vc6kZmZehQTQIAXr99gvela2Oajdz86
         U/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049994; x=1726654794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtVXEEyIECSDN6VChW7COEyWFA2mGv3xOzKg/F3A7CE=;
        b=j392ZIx79HmoFRidD7j9mX9Jk+Q7qI0szI5UF/5LZXRG5l0YGDcR3A5DeDCctyWl8J
         CIT7zQYVpSCgQ0W/yGQKYBaiOhMWSbCC8HI6jFbOJJTlaSedo5Nn92Y4ylyJFMHG/dwa
         RLCEXleal/y0+sUemktNUmQue+uQAAFCg4DW5WuD247ikIMHumkbTNCAl8GAzw4wkJNT
         ai78EmmjLuOEogLV+colWp4OTrSrnoURpo7YTuOD/H6wIB4KorCAPBMSPIWgyeUHSJnV
         q90rrwuYO/MreI3+f6+rF/nIPY/8dePN7tf+iHyXRwuuXjVpP3dUp9Vgk3ZmW/qdIhtU
         BEXw==
X-Forwarded-Encrypted: i=1; AJvYcCUuGI07SXV9G/ZljfhGgQ73QmpVqmoU3yp4eHokR/aBva9iOG3spUa8Y8L9QD2AAhv5TopTDWA9qpF9zz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznz+JiQ8WrQCsJwnLyEYXxXkq/9nQ6SPO5z4DCWN6DzJdyaAPE
	FJZL1DrZP2wNABl75jD/r7kkB6zNoqZKngi7mkQrDoF6JxhRiDyOwCylxV+fOa8=
X-Google-Smtp-Source: AGHT+IF60qGdNf7PJkX5FDe/IGRRPdd8lxrMmNtxnSMaOHABQ4KsCRSSsI5n2gss620PjPeGmffV0A==
X-Received: by 2002:a05:600c:3ca1:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42c9f9ca788mr139816475e9.25.1726049993598;
        Wed, 11 Sep 2024 03:19:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm139349125e9.7.2024.09.11.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:19:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 12:19:43 +0200
Subject: [PATCH 4/7] ARM: dts: amlogic: meson6: delete undocumented nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-4-feaabb45916b@linaro.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3135;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RWmk6OF5GEw/0+RQqnhJttyJm2tPM7O3ljEKjPu2GbM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4W7Dm+JGWmHBTBU05K0c+ptKNT/q7A4vBnGP1Il/
 iWFkHYmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuFuwwAKCRB33NvayMhJ0Z6CEA
 DAO+OKkQLeCMKNxQ2jKTnoaUlwJxj4gPDCVD+aS0Z4iMz0llhoDdd5wVyA/ahuQ+Q6l7PVH+SVK9kN
 ZJBzQdyZ0/wjNi6xALoBqG8SSVBByh8Fmj2AAJlwJK9/mU33bdZCl2ImobLgFqH4Pd8LlwneHD14yp
 PadZ6jRpu+/HO51okQq7FGZU+54haBJrZ5QsJtW9rRs8MX63v9JAnugpRWmF2jbIU7KIJ8C7EjbJkD
 LeVzoCpzPwoMFFh2AWEtiN12l+NGa+fggOcxv7FcNat0misjiwOq0vwU3KOlxJLM3GuTX2J5/AjFar
 ctQtPpuOxfxF5XT2XVVx2pu7AEO0ZPx5YZxorOhPQObL1wUccHrwjnouwZrcIC2JlBF9Uy1sw0fdmT
 jBvlLTfhH8Lv/yYFwH48faaVa4S6nufkKdl5oeI3IQCjaS7VbaOYOhKQ/SVCmaqxfTAkBJwmAg2hkN
 lzpr8O+4HreLrOfpcURtHgDNtkjXU2bgYbojjKjftZMZjMhUmM6L1CfknZ3BY3eqzCx+URjgnuaKNk
 IiNaUuhMszICSiKbmSHycbdUqUM6CUv66OSILGJqwRnKlepIjx+QvRUvzZbMstkeBhu3qbbImQRGBD
 g6bhl+k0bi+GjwFlz1nella/mJ5wHU1ur+t2sU8dxoMtklS7jn7DUC6tWF3Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Delete nodes in meson6.dtsi that are clearly undocumented & unused for meson6,
fixing the following check errors:
audio-controller@5400: compatible:0: 'amlogic,aiu' is not one of ['amlogic,aiu-gxbb', 'amlogic,aiu-gxl', 'amlogic,aiu-meson8', 'amlogic,aiu-meson8b']
	from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
audio-controller@5400: compatible: ['amlogic,aiu'] is too short
	from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.yaml#
/soc/bus@c1100000/pwm@8550: failed to match any schema with compatible: ['amlogic,meson-pwm']
/soc/bus@c1100000/pwm@8650: failed to match any schema with compatible: ['amlogic,meson-pwm']
phy@8800: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,meson-mx-usb2-phy'] is too short
	'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
	'amlogic,meson-gxbb-usb2-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
phy@8820: compatible: 'oneOf' conditional failed, one must be fixed:
	['amlogic,meson-mx-usb2-phy'] is too short
	'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-phy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
	'amlogic,meson-gxbb-usb2-phy' was expected
	from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
/soc/bus@c1100000/mmc@8c20: failed to match any schema with compatible: ['amlogic,meson-mx-sdio']
mmc@8e00: compatible:0: 'amlogic,meson-mx-sdhc' is not one of ['amlogic,meson8-sdhc', 'amlogic,meson8b-sdhc', 'amlogic,meson8m2-sdhc']
	from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
mmc@8e00: compatible: ['amlogic,meson-mx-sdhc'] is too short
	from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
remoteproc@1c: compatible:0: 'amlogic,meson-mx-ao-arc' is not one of ['amlogic,meson8-ao-arc', 'amlogic,meson8b-ao-arc']
	from schema $id: http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
remoteproc@1c: compatible: ['amlogic,meson-mx-ao-arc'] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson6.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/amlogic/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
index 1c4ea7266f66..8952c086d069 100644
--- a/arch/arm/boot/dts/amlogic/meson6.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson6.dtsi
@@ -43,6 +43,10 @@ clk81: clk81 {
 	};
 }; /* end of / */
 
+/delete-node/ &aiu;
+
+/delete-node/ &ao_arc_rproc;
+
 &efuse {
 	status = "disabled";
 };
@@ -71,3 +75,15 @@ &uart_C {
 	clocks = <&xtal>, <&clk81>, <&clk81>;
 	clock-names = "xtal", "pclk", "baud";
 };
+
+/delete-node/ &pwm_ab;
+/delete-node/ &pwm_cd;
+
+/delete-node/ &sdhc;
+/delete-node/ &sdio;
+
+/delete-node/ &usb0;
+/delete-node/ &usb1;
+
+/delete-node/ &usb0_phy;
+/delete-node/ &usb1_phy;

-- 
2.34.1


