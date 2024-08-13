Return-Path: <linux-kernel+bounces-285387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BE950CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E51B22909
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF91A7064;
	Tue, 13 Aug 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fFi6IjYo"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B11A4F2A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576011; cv=none; b=Yrrfgf94/Und1KGJzE068gmoncq0DoRRyLOho2VHq6uTtzfpM+QqxPd5ynMQIF3uS6j4bSCNi6XRB5AJwZ3stuWjnSosW9W0SW8kMVnhDF46DzW8EvJ0ZAKtGmHfth7/nR9ydqeThraK8fxx1rjZXN+K5WK6sWQsHjuh4hY60zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576011; c=relaxed/simple;
	bh=Lc4YaS6ZY5fTHZKs+E55pOevRiwlUIWNmJcRejo55PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4Nvs+glILIaB1WYUJAfDdN4wP/Xa96X44oiKChRE+wlvitHavbPFDinMNeOVTrRobPrvd/H5ml24maCIqIHmzLnKHbTp7xiJubXLJjZ/IIzTWfUP9chMLK3JfnGrW6EDuZdiK9fGviH7iI4SW5qlmu/ngQLcMMiNXj48JpMpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fFi6IjYo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3685a564bafso2672247f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576008; x=1724180808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg9KmrQlFy2FwEIPZsQiUDiuIEJaRg2BBZMpmfdhcvs=;
        b=fFi6IjYojvLm6daKEL73g1Az7HWxUKlZJV0wK5sZAgTcvaKuVmlQv10EOugtEJIV1p
         9I65i4j15jQpF1d5qa18nk8Ac8WWUWiJq/AwGGG4W6rt8UXmfnJCRFtCDoj9q7riSAk5
         06U/Yw95FX3fyWx+hTMrWCWL2i3+K2I2qksef2xAeCYrSeMjS7DaRVjUkbe44s4GLlJB
         uUO+Ax16Ma4H86LD+JeIjLgxYfxtKXDGKoLU1h2nHlAfKOmFFutfQyQgr/djDmsjXxJ6
         xwXO8yQIJnQ9A/M3dYKDPWtH8BSBUJ8zcaNXVtAcfZeC+O9dBGk5AWSp9TtEphhDJYQa
         bfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576008; x=1724180808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg9KmrQlFy2FwEIPZsQiUDiuIEJaRg2BBZMpmfdhcvs=;
        b=oXbHngr4/l0O/ZRysw3k7xRO9cnaCp/OudOnxucOMm4Cg7Os5cDRLuOt0wkTusU+Qa
         WK5icb/ddTMoG73L01cZKm2EpeRkK/BlI2K4qjN4LuEvq+dFiHDpLbsA4J+umAMHWYKr
         BWYDJSYel15dXyEamxIVvL2z86/jzsDD7F/igF6ZrQqKDXOHmyay5u5YbTxx0L0Rgf5U
         YkuG49n2IJq85NJwrrY5ZMGHGuNdgUa5MzCHXrjHF+THhtQ+MvMjrWGIwYmiodtLeevJ
         SZJBNo4pKIsuXgoxZIz7qwA6IOEXEhQCItAqvMZaVMCQQk7w3zzi2GhYeP/vxY5S2nWp
         RTkg==
X-Forwarded-Encrypted: i=1; AJvYcCViqnaBlLxgjiEjW/Ovh9qW6Doe5O1jYxG3qNKD8/RvACdq6kq1eMuX5x49X6TgiUaLdbQ/02M/Pwop6qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvE6uB9bC72BODr6fU3V5O5+wjXna6TWBY5xvTpCaApZNkazu
	jNcsrMU9yPM7gmWiHomMgxtzOYptW/DwzwyRpfAJknABrrQwMGbON9zwmrOEKg0=
X-Google-Smtp-Source: AGHT+IFVxOD+jBYuGHCHJ0W19t2ydGTgZjTUOL9/824YAHqF/+a1/eSq/vEvxY8cDZ1WRlxhpRUglw==
X-Received: by 2002:a5d:420c:0:b0:368:669c:3bd3 with SMTP id ffacd0b85a97d-371778096f0mr342475f8f.48.1723576007879;
        Tue, 13 Aug 2024 12:06:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93708asm11119358f8f.29.2024.08.13.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:06:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855
Date: Tue, 13 Aug 2024 21:06:38 +0200
Message-ID: <20240813190639.154983-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813190639.154983-1-brgl@bgdev.pl>
References: <20240813190639.154983-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
and bluetooth nodes to consume the PMU's outputs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 98 ++++++++++++++++---
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index a7c5a3f5926c..9a68f3f4e18e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -400,6 +400,67 @@ usb1_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&wlan_en>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b>;
+		vddaon-supply = <&vreg_s12b>;
+		vddpmu-supply = <&vreg_s12b>;
+		vddrfa0p95-supply = <&vreg_s12b>;
+		vddrfa1p3-supply = <&vreg_s11b>;
+		vddrfa1p9-supply = <&vreg_s1c>;
+		vddpcie1p3-supply = <&vreg_s11b>;
+		vddpcie1p9-supply = <&vreg_s1c>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -876,6 +937,16 @@ wifi@0 {
 		compatible = "pci17cb,1103";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
 		qcom,ath11k-calibration-variant = "LE_X13S";
 	};
 };
@@ -1207,20 +1278,16 @@ &uart2 {
 	bluetooth {
 		compatible = "qcom,wcn6855-bt";
 
-		vddio-supply = <&vreg_s10b>;
-		vddbtcxmx-supply = <&vreg_s12b>;
-		vddrfacmn-supply = <&vreg_s12b>;
-		vddrfa0p8-supply = <&vreg_s12b>;
-		vddrfa1p2-supply = <&vreg_s11b>;
-		vddrfa1p7-supply = <&vreg_s1c>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
 		max-speed = <3200000>;
-
-		enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
-		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
-
-		pinctrl-0 = <&bt_default>;
-		pinctrl-names = "default";
 	};
 };
 
@@ -1694,4 +1761,11 @@ reset-pins {
 			bias-disable;
 		};
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio134";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
-- 
2.43.0


