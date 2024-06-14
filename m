Return-Path: <linux-kernel+bounces-215235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C225909020
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691741F2387E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85C17B511;
	Fri, 14 Jun 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQxUiPqN"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBB17FAD9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382256; cv=none; b=ORHuefUA3ENalpxv/WH8EL7fIpe6KJKl3CuNWJKLxQ+O6A4sXtQkz3JDlno4Bk8JuP4g4Tl+6OMKKEbU5GnicsuaJSEjl+pWPhtTSc3f7X89kGrVNq3Q/HAX+RiRtsrnU32RO/W2RxP16jjxirFg8vQ30MAE+OViAeWwtH7ieDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382256; c=relaxed/simple;
	bh=Q6/X+ycWXviJzuIA+8tN3nWtQeXrSOW42C9SQTEXNjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFwlDf+XqQMeM6pBylMyVGj87r9qqyTseaeGQOHp/EL843kIKxxVo4u4tStSUh5507ymw9wL0nNaNOBhLRvWlxo8MmRPidXgQIGK7Hqcn01+52P4akHf3EE08JJwXOfdqss7flmhTblo0NK22k3gUCMphYWFeQ8RkUoB+FERgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQxUiPqN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f23f3da44so2120245f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718382251; x=1718987051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1GZMrG8PcWzBYLyyF3xF90kHOD1WZpdahDlpB8IEos=;
        b=ZQxUiPqNMsbSe5horyoe9rsE8S2hVpdk1ZWUoCaNvxD5NrgowXs2XqyItnmDPLz4jC
         GUAoMR/50LHtmVdGPPPYCaBuQaaex5w0494JRFbInxTL3WpvdJhqLkV99Y0nhy4deejl
         wUvEf/2DIvwHF30Z+1Mf59G3vbR/9qm/TnPD5eLb0H13D6Uj1iEXcRlsGfi4eDcCILJj
         k/NqreAiIreCUXf/X+FlD9W9RN9x1xt3YOdc0Q+QI8h/O32Ne+MpgVsjQP3tautSou8+
         9v6bQz0V91iZyWHMdJ9jzxC3XULaMVMgBf6WuYyb5x900rZef7HNw/LSxAcA4QAHd4F5
         zFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382251; x=1718987051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1GZMrG8PcWzBYLyyF3xF90kHOD1WZpdahDlpB8IEos=;
        b=cvw7K3UqQYbKsGOIM47GrTWzH7/r/2PKebLIebEhcw4hrDR6C2Vg/+nXb7Gqz3rtYz
         VOt7JGnrB1s0HzHxc/TOT1VDq8rF2wtMT2xRd4goKd/nre90VyosNCN+mXf9KzDpgzmT
         eyYEVoJJ61vnMRZCQv/NgxlZU57lPJAOqlboVDrFnkiGZUVJPGTRGLXBPOAsXEkqakh4
         2vtC7NLzqqmzPgk/kgs/LgPw1cmPmIOfjLWlvMbEcACryvanf2BTsXBaPcUkpy+N/wIV
         MDbbDzlUA7Fjs2w/kmLNBKnqV+8oQyamZA1px+SgXo8qDI1rmj2H1+Vf9tB0IEZIFV7a
         1giQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEe7O58kc35QD9rFiYzeGIIIx/VzX2EMe1HWFv2iHsZTtdpOFk+lyYZSBELTBNQBkSB+TTHHGh/JIeGVennj3d64m4YuLuqnu6Mqya
X-Gm-Message-State: AOJu0YygfA/deoXloPZLnEWCYDSHdOKw1JoCyUSv2US6EJIO0hdkLfVE
	S64nypk/n/FUd5q5pvajs3lnJwNEdEwW4Z7af1jIEeBc5+cDEcnFw7zWbu28hks=
X-Google-Smtp-Source: AGHT+IH0FxeBGPaMn3UPn0XbTnvPZqq/APrPTA8gnQzrsv2MQ133nOvksfmfzXys+bMwDf+2o2eaAA==
X-Received: by 2002:a5d:6da4:0:b0:360:7a6f:f79b with SMTP id ffacd0b85a97d-3607a7b0f45mr2809352f8f.1.1718382250773;
        Fri, 14 Jun 2024 09:24:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm4931165f8f.0.2024.06.14.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:24:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 14 Jun 2024 18:24:03 +0200
Subject: [PATCH RFC 3/3] arm64: dts: amlogic: add clock and clock-names to
 sound cards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-3-9f57d9e01834@linaro.org>
References: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
In-Reply-To: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35207;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Q6/X+ycWXviJzuIA+8tN3nWtQeXrSOW42C9SQTEXNjI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmbG6mtyE+9EiIrd6FTxek7z+VYBrYLOZ1zl//9kMj
 4eIBNO2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmxupgAKCRB33NvayMhJ0SdoD/
 95WWg069Tjp0H1BiJOkncVEcRNP77XHPBYx/if5h2hD9Qi4w75JlnHADnipLKxXfHpPFgq2TicyOr8
 Sj1TJrp9o+f4aKf/Ns1ZbLDJsGd6utH+UKub2fSwXBXy5UlqUycqKSwd8l18broGaR/PkbJW681YTX
 Nda1c+By7Qw+G7rafkEa7yPQPrCTba8BHX+6SVRb1zF1BodqH7yiP4WqvevAHoqB58UgJHWwUFHMpc
 xPNz4FaDZY3XqprY/kdBYw+BudRL0gGIj1sMdbBw8a4IP82UI+lUhqQhalp/+KXihZ+nkjoTR/bSWj
 FU2wDJmAZQcGlR4bFEx1cSN0udiXaC7lkEPM7X7oOs1Msb9rcceLUoKtF0X1ERSLi+8oFmv8mC2rTA
 fd0iHz25pv6Cv4P5ZCJuUawIblVdOmnn07S3AoJcbe+Q9buYjJmBAcbP2O6kwHIaTkBfY0T3wg8bkZ
 uxeBMtUMPCme2c6s4sMjimx5XXiKEqPO4x6pjWnO2ZcyJJK6g6VPZxaNq22B0o1GzM7eZpD/0WsPiX
 Nl/GJmikUTBriypEvst7G5BQTuw/PnJ4Fz15az5HWnuz/HJjFFL6MhpitdYrQA2sAjEq2wQ8F93Zj0
 L/R85h5DC7C8DrT42giTdF6MiX2Zf2klQmT8LkDyUjPAvhfw8aoiAwzhHMmQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the missing clocks and clock-names in the sound card nodes
according the the AXG and GX sound card bindings changes.

It solved the following errors:
sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
    from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
    from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
sound: 'anyOf' conditional failed, one must be fixed:
    'clocks' is a required property
    '#clock-cells' is a required property
    from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                      | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts                     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts       | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts          | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts                     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts                     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts        | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts          | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts     | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts        | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts                 | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi                  | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi         | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts           | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts                | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts           | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts               | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi                   | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts                    | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts              | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts                   | 4 ++++
 48 files changed, 192 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7ed526f45175..2228ed88b977 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -268,6 +268,10 @@ sound {
 				"Speaker1 Right", "SPK1 OUT_D",
 				"Linein AINL", "Linein",
 				"Linein AINR", "Linein";
+		clocks = <&clkc CLKID_HIFI_PLL>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_HIFI_PLL>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
index af211d8f3952..0bd298920191 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
@@ -176,6 +176,10 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
index 15b9bc280706..b44c0802d47c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
@@ -138,6 +138,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 61cb8135a392..3ddd0e2c4710 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -201,6 +201,10 @@ sound {
 				"TODDR_B IN 1", "TDMIN_B OUT",
 				"TODDR_C IN 1", "TDMIN_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 0e239939ade6..42ac5dcdb19d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -238,6 +238,10 @@ sound {
 				"Lineout", "10U2 OUTL",
 				"Lineout", "10U2 OUTR";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 05c7a1e3f1b7..0ee32d7bceae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -158,6 +158,10 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
index 13d478f9c891..cdc9d387d9be 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
@@ -70,6 +70,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
index 003efed529ba..0af7ba8ec896 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
@@ -79,6 +79,10 @@ sound {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 					<&clkc CLKID_MPLL0>,
 					<&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
index 6a346cb86a53..5136b062e19a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -194,6 +194,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
index bb73e10b5e74..8356b881fb31 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
@@ -48,6 +48,10 @@ sound {
 				"TDMOUT_A IN 2", "FRDDR_C OUT 1",
 				"TDM_A Playback", "TDMOUT_A OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index 6eeedd54ab91..cc1156a225c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -49,6 +49,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 0da386cabe1a..4d1ef4d98391 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -37,6 +37,10 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index eed2a23047ca..c58e551b0e95 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -234,6 +234,10 @@ sound {
 				"Internal Speakers", "Speaker Amplifier OUTL",
 				"Internal Speakers", "Speaker Amplifier OUTR";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index d80dd9a3da31..1f4674bbebda 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -71,6 +71,10 @@ sound {
 				"Lineout", "U19 OUTL",
 				"Lineout", "U19 OUTR";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
index e26f3e3258e1..058453f547b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
@@ -39,6 +39,10 @@ sound {
 				"TODDR_B IN 6", "TDMIN_LB OUT",
 				"TODDR_C IN 6", "TDMIN_LB OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 8445701100d0..bf434fcee31d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -176,6 +176,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index 6396f190d703..0ad35693ccb3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -32,6 +32,10 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index efd662a452e8..db76787386ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -194,6 +194,10 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"7J4-14 LEFT", "AU2 OUTL",
 				"7J4-11 RIGHT", "AU2 OUTR";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 08d6b69ba469..4e2cbd9d60f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -129,6 +129,10 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index f28452b9f00f..01c47d1545b8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -45,6 +45,10 @@ button-reset {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KII-PRO";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 1fd2e56e6b08..a7a2767a42a1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -135,6 +135,10 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NANOPI-K2";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index cca129ce2c58..8c01a43e4e7a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -142,6 +142,10 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NEXBOX-A95X";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c37cc6b036cd..6a794f72544d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -177,6 +177,10 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "ODROID-C2";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 7f94716876d3..3ba3681fe3ba 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -68,6 +68,10 @@ button-menu {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "P200";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 6f81eed83bec..32e1c272052e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -17,6 +17,10 @@ / {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "P201";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 255e93a0b36d..cbb847b8d5fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -108,6 +108,10 @@ sdio_pwrseq: sdio-pwrseq {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "VEGA-S95";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index af9ea32a2876..b5b0ced8ecff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -16,6 +16,10 @@ / {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "WETEK-HUB";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 376760d86766..29749b053e1e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -48,6 +48,10 @@ button {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "WETEK-PLAY2";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 90ef9c17d80b..6aef181ca2ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -123,6 +123,10 @@ sound {
 				"Speaker", "9J5-2 RIGHT";
 		audio-routing = "9J5-3 LEFT", "ACODEC LOLN",
 				"9J5-2 RIGHT", "ACODEC LORN";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index 08a4718219b1..fdc387c9b202 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -128,6 +128,10 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index fea65f20523a..065a7fc9d2fc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -67,6 +67,10 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KHADAS-VIM";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 63b20860067c..2fe5c6686657 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -160,6 +160,10 @@ vcc_1v8: regulator-vcc-1v8 {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "LIBRETECH-CC-V2";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 8b26c9661be1..4b40794721fd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -142,6 +142,10 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 9b4ea6a49398..98c6251142c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -50,6 +50,10 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 07e7c3bedea0..d97fca396e0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -150,6 +150,10 @@ wifi32k: wifi32k {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KHADAS-VIM2";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index ad2dd4ad0a31..71ee228781fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -86,6 +86,10 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NEXBOX-A1";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index d05dde8da5c5..81387968f51d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -101,6 +101,10 @@ sdio_pwrseq: sdio-pwrseq {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "RBOX-PRO";
+		clocks = <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>,
+			 <&clkc CLKID_MPLL2>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index e78cc9b577a0..bd4ffc07e456 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -182,6 +182,10 @@ sound {
 				"TODDR_B IN 0", "TDMIN_A OUT",
 				"TODDR_C IN 0", "TDMIN_A OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
index 082b72703cdf..746ce70b545b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
@@ -200,6 +200,10 @@ sound {
 				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
 				 <&dioo2133>;
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
index 9b2eb6e42651..4cca62ddd04a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
index 6e34fd80ed71..4a2aef4948ff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
index 586034316ec3..3203280bffe7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index f045bf851638..6db7c5ccdbbc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -57,6 +57,10 @@ sound {
 				"Lineout", "ACODEC LOLP",
 				"Lineout", "ACODEC LORP";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
index e6e9410d40cb..918ace039da6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 951eb8e3f0c0..44d2346482a5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -174,6 +174,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 3581e14cbf18..19b712e45066 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -239,6 +239,10 @@ sound {
 				"TODDR_B IN 1", "TDMIN_B OUT",
 				"TODDR_C IN 1", "TDMIN_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
index fc9b961133cd..c913af910208 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
index 9ea969255b4f..49978855c2d9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
@@ -22,6 +22,10 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
+		clocks = <&clkc CLKID_MPLL2>,
+			 <&clkc CLKID_MPLL0>,
+			 <&clkc CLKID_MPLL1>;
+		clock-names = "mpll0", "mpll1", "mpll2";
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>;

-- 
2.34.1


