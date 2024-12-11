Return-Path: <linux-kernel+bounces-440785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869759EC438
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA61679F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8861C1F0F;
	Wed, 11 Dec 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkGWcqwJ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01E1C302C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894682; cv=none; b=heq3QCRWQMz1BKRD/82x4ZsT6iQzikqNSdLhb/jjsmpWobUdBybGF6zQp7lT/PvF9TfG9Q5fATpgmXFXju+j+Vn8hjI/Er4/qBQ7CoaA6ax6weCHyouLYOX2wP/pTmIatE+Bx7q+1e9R1GCuOMzfNIcj+tyhqiV0AErN/E5t0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894682; c=relaxed/simple;
	bh=+efDKya3CkWC3cbEilmzGyCa1TNXdHKJ49CvMGeuINw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX8utlzkEiE7/5Qus4Pt4YgW+ygkHVScYm4kw2bEguwH6vf3Wpg/5aAdAoMZhYkFRMl0PvH+CuoaNM+9nIbmD4xiqfX67/1GOb7On+pTjc2WGA52S0LojFgZ4h1tEj9uDcVHYxmBjKxz2a0cvKq/yuXEOlCAbrIg86hwIhKzqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QkGWcqwJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725c86bbae7so4052820b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894680; x=1734499480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VajpwNXgLRwnVxUzuVzg5zr/x+BvIvcxvW3/imNa1GE=;
        b=QkGWcqwJ1g2gkeBdLUQaKfWeGMxKNqJHLMutWzhBWnL7F27i5m6fD1uElGbWlQzj0i
         Ra+QfjHY7QvSm3oAH7cqLuK8Njfrn5OW217ke4a3LQJRisrJQbwVyJ/UoXHfkwaWYAOA
         BunmCT8BaWxxMdcYdZCYc6uKVQoapsXKKNY+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894680; x=1734499480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VajpwNXgLRwnVxUzuVzg5zr/x+BvIvcxvW3/imNa1GE=;
        b=VjULLkrrnWGuyOH0srMALMflADjeX68ZKVCcgDMY2mhjkCRq2i9POJiN2rwDuOc6Be
         FpSNi3Or3hiT0vez08LZDjAGPyGkNVLVyioR6GShh2Tjq0fBWPAVONAiuQfXqD6/hiSv
         wqf2Wcgip5gWCvDzONHvMAfEPa6+sfx+8nnUkugoTndPiZSorwhM4cpOLZN6GWxKgsFL
         W+JX+GfSzo1RFvw+E3SUMD/ebKdgViY5OGrTv2NbyDJ7wBKiPNr1Et9ijpE6TjiZ2Sq/
         hutxYJowKFfEIuO5dIrWKYS/+0OJS4ss2nYk5pzaGmkc9nfNB2bflqXW2Gf9bKdiyrcQ
         7Nwg==
X-Forwarded-Encrypted: i=1; AJvYcCW681HHD6eTHE30CdBeqKmGsqa2RLS2KoEoPM73VEI9iXT8PtxBJ+i4L3mlD718DRne5r/7R2hGMCjGRdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrgSbLB5hjmTJyu/CPLXxX9g+UeZ/axZKNyYyPr+mB5mOSUDw
	9Fq85BB13qBSBE5Jc+f08q5lBMhmw4Ug0Wt/FYfTFw9TnH2yE016C463nm65tw==
X-Gm-Gg: ASbGnctvkejtoBKHHCDJwhHSpLeYTI+j+8aoXFGwedNI0V3pJCi26XDTLgb59e8RfYM
	70gaqTVdegOIy2mz2cfcY3R6B6ClYGuKfRkYSnScweabqyvc557zXnjDJANuPHWnCmzBKxoTDtw
	1OFLDUw+SxX2NqvSZ6QEO64rxntNkozWTKe6lSHiUG4cp8pUxAh6Yfl17q5igIkk4KP6vCGo2rC
	xAJh8LjX4HPqtlMYJx+MHyNvtMLh7KLThz1nJ6GoXZQ3Vmm1Uw+joD/AbbST0DhR2R2987S
X-Google-Smtp-Source: AGHT+IGHa9pLW8AmgWmPpkt2d3AMc62yA8lmyj5k97y8xXtFztxBU4CrT22oxWpzrhhtYTUKJaIAkg==
X-Received: by 2002:a05:6a20:d50c:b0:1e0:d7ec:5aae with SMTP id adf61e73a8af0-1e1c126ef4dmr3311686637.4.1733894679722;
        Tue, 10 Dec 2024 21:24:39 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:39 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:20 +0800
Message-ID: <20241211052427.4178367-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "regulator-compatible" property has been deprecated since 2012 in
commit 13511def87b9 ("regulator: deprecate regulator-compatible DT
property"), which is so old it's not even mentioned in the converted
regulator bindings YAML file. It is also not listed in the MT6397
regulator bindings. Having them present produces a whole bunch of
validation errors:

    Unevaluated properties are not allowed ('regulator-compatible' was unexpected)

Drop the "regulator-compatible" property from the board dts. The
property values are the same as the node name, so everything should
continue to work.

Fixes: 16ea61fc5614 ("arm64: dts: mt8173-evb: Add PMIC support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 23 ---------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index bb4671c18e3b..511c16cb1d59 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -311,7 +311,6 @@ mt6397regulator: mt6397regulator {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
-				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -320,7 +319,6 @@ mt6397_vpca15_reg: buck_vpca15 {
 			};
 
 			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
 				regulator-name = "vpca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -329,7 +327,6 @@ mt6397_vpca7_reg: buck_vpca7 {
 			};
 
 			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
 				regulator-name = "vsramca15";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -338,7 +335,6 @@ mt6397_vsramca15_reg: buck_vsramca15 {
 			};
 
 			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
 				regulator-name = "vsramca7";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -347,7 +343,6 @@ mt6397_vsramca7_reg: buck_vsramca7 {
 			};
 
 			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
 				regulator-name = "vcore";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -356,7 +351,6 @@ mt6397_vcore_reg: buck_vcore {
 			};
 
 			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
 				regulator-name = "vgpu";
 				regulator-min-microvolt = < 700000>;
 				regulator-max-microvolt = <1350000>;
@@ -365,7 +359,6 @@ mt6397_vgpu_reg: buck_vgpu {
 			};
 
 			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
 				regulator-name = "vdrm";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1400000>;
@@ -374,7 +367,6 @@ mt6397_vdrm_reg: buck_vdrm {
 			};
 
 			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
 				regulator-name = "vio18";
 				regulator-min-microvolt = <1620000>;
 				regulator-max-microvolt = <1980000>;
@@ -383,19 +375,16 @@ mt6397_vio18_reg: buck_vio18 {
 			};
 
 			mt6397_vtcxo_reg: ldo_vtcxo {
-				regulator-compatible = "ldo_vtcxo";
 				regulator-name = "vtcxo";
 				regulator-always-on;
 			};
 
 			mt6397_va28_reg: ldo_va28 {
-				regulator-compatible = "ldo_va28";
 				regulator-name = "va28";
 				regulator-always-on;
 			};
 
 			mt6397_vcama_reg: ldo_vcama {
-				regulator-compatible = "ldo_vcama";
 				regulator-name = "vcama";
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <2800000>;
@@ -403,18 +392,15 @@ mt6397_vcama_reg: ldo_vcama {
 			};
 
 			mt6397_vio28_reg: ldo_vio28 {
-				regulator-compatible = "ldo_vio28";
 				regulator-name = "vio28";
 				regulator-always-on;
 			};
 
 			mt6397_vusb_reg: ldo_vusb {
-				regulator-compatible = "ldo_vusb";
 				regulator-name = "vusb";
 			};
 
 			mt6397_vmc_reg: ldo_vmc {
-				regulator-compatible = "ldo_vmc";
 				regulator-name = "vmc";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
@@ -422,7 +408,6 @@ mt6397_vmc_reg: ldo_vmc {
 			};
 
 			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
 				regulator-name = "vmch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -430,7 +415,6 @@ mt6397_vmch_reg: ldo_vmch {
 			};
 
 			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
 				regulator-name = "vemc_3v3";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
@@ -438,7 +422,6 @@ mt6397_vemc_3v3_reg: ldo_vemc3v3 {
 			};
 
 			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
 				regulator-name = "vcamd";
 				regulator-min-microvolt = <1220000>;
 				regulator-max-microvolt = <3300000>;
@@ -446,7 +429,6 @@ mt6397_vgp1_reg: ldo_vgp1 {
 			};
 
 			mt6397_vgp2_reg: ldo_vgp2 {
-				regulator-compatible = "ldo_vgp2";
 				regulator-name = "vcamio";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <3300000>;
@@ -454,7 +436,6 @@ mt6397_vgp2_reg: ldo_vgp2 {
 			};
 
 			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
 				regulator-name = "vcamaf";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -462,7 +443,6 @@ mt6397_vgp3_reg: ldo_vgp3 {
 			};
 
 			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
 				regulator-name = "vgp4";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -470,7 +450,6 @@ mt6397_vgp4_reg: ldo_vgp4 {
 			};
 
 			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
 				regulator-name = "vgp5";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3000000>;
@@ -478,7 +457,6 @@ mt6397_vgp5_reg: ldo_vgp5 {
 			};
 
 			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
 				regulator-name = "vgp6";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3300000>;
@@ -486,7 +464,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
 				regulator-name = "vibr";
 				regulator-min-microvolt = <1300000>;
 				regulator-max-microvolt = <3300000>;
-- 
2.47.0.338.g60cca15819-goog


