Return-Path: <linux-kernel+bounces-249033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92892E54C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DF21C20F93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376415A84A;
	Thu, 11 Jul 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP/sSE1b"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AA15AD9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695543; cv=none; b=YEmWpZWR3271pfxCapmYIOXaFlz/lGXbv0MYHtzwWsi3o9NBRDa6klhPWQD/1fhTkEiTNfQ7pYidKMRVoEmO42ENuFAXUsmUt15a/gedvHZicYzyukXK/wm2AuBqeVex/jcFnCb2EE84l/EvhDCFoQ28oNBOxRzdE1Dx3QHlj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695543; c=relaxed/simple;
	bh=qd4l+1zLIfKPyejVC5a86QPcVgnizG//KpLwQhuGEPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjixL2H9nKC+QKs8ELkrjScIXhlJsi/xsYuKx6HEPdYmDI3/RAp422NU2TywNszBxd0oU1UnJ+BcvaTvEN/Vy3yEfYcQu9XpJm9WejYdRBHzN/IdqB48yYsjjXPqkXDMygOLu27DA393O8qQOVt5R9/8kElXJFo3gf2NQR7OiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SP/sSE1b; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so1217988a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720695539; x=1721300339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNYgTmSSdNoKuplswpKP8hOzb826ZcABJ6Vp53iyqy8=;
        b=SP/sSE1bsiACHrc0Puv8a7l3zvGg02Cngql8JpD+kfSaJ7J/BempowwQJaJAZ6nGHX
         LqvrQcGrKptiFVDZ7jtC2prJYAq8HSobyk+sfCNoGTnZCf7ZEBtX3geyMkkuOLW+qvhZ
         g0kInLEI0eWZgRPaQc0/pljH3Omyhfx+fuprXIOphBU90xvJAQ6m/7gvtt0I3ijMoqrd
         Yi0W35OVbTI/fgIMYMG7czez98qG9Un3ovcKWH7jBrKzDNHpjv1o4+ZhyqXwNtkjklkd
         YbCc2jwczjGc8vVgK4quLPgv6w+vcZCEK/o0KUhIpn26qGuYgxVk8Pv2x9Lkq3wn4+qv
         zbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720695539; x=1721300339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNYgTmSSdNoKuplswpKP8hOzb826ZcABJ6Vp53iyqy8=;
        b=Ldshap60COus1Hio1FVeDktCsPdjZqeDgeY0yd4ghkZIKfwS23Ft9Mh5kl7CAUCleE
         fSSoTYRdj7pLKMxeZ6HXhAIIsH/uMJeZSA9dePKPINJSUUW0Ky1ngJVFiNo8J1lNk7KQ
         ROhR2FGeDh+bzaXeWnpZSMAW7XLLY8bI0a4sVMhDf8ZISHrtbkB/p3uj1pdIogdL3WHb
         gaZpVa4qRkGSD1mFq06f0ipfgx106jWshcKUKTSCUe+CeYqfxPoi+hwuguS5LlqnZh5g
         rJ37+r5OeFlUsBB5tocYJs0JEuCsZPAWeAnij89WsGFF+dJdMAMcKfsMW2398CtRK0+p
         aThA==
X-Forwarded-Encrypted: i=1; AJvYcCXhRfEBcrrRT6o6NbKLmsM549gxzdUp+kzEQGkx3zBhr/NBTVpJ2kt8h3PcAnFchV2k35j8xcD+nzLGoPrHjyOQQoFEc8+Kunkr4N2k
X-Gm-Message-State: AOJu0YzFPuxElSTliUvhkhHg2VIqx/kVh1UYsqO9iT/qyAFerXdKj9Pc
	iJn/wm46ChZt/z4HS4eS+f4Eqdpq5Nz7h7+qmQOWNBrSFtHv2klVBTK8w4DuJeg=
X-Google-Smtp-Source: AGHT+IEcuNhgMukDyP03M0BmgINaqQouk44TmnI3HD6cVsvz8p3rUpUo1RaLhKUYXiVChuzSTWu49A==
X-Received: by 2002:a17:906:f0d4:b0:a77:cbe5:4135 with SMTP id a640c23a62f3a-a780b6b1ce4mr476482466b.20.1720695539419;
        Thu, 11 Jul 2024 03:58:59 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f2fsm244209966b.202.2024.07.11.03.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:58:59 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 11 Jul 2024 12:58:47 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100: Disable SMB2360_2 by
 default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-topic-hhh-v1-2-a1b6b716685f@linaro.org>
References: <20240711-topic-hhh-v1-0-a1b6b716685f@linaro.org>
In-Reply-To: <20240711-topic-hhh-v1-0-a1b6b716685f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720695535; l=3525;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qd4l+1zLIfKPyejVC5a86QPcVgnizG//KpLwQhuGEPE=;
 b=Sjq8cqwOgiLjvCLlOXnQNPFpaOZMBKuKUdbY1aNQaeHRhLjU/28zu9OVhTiNFhoE+FOpPLsUu
 dyHKwnsf7SeDGc5y8X8Ia9o5CQW6cuEzSzqzvER1dR90vfgcnA3hxqS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It's absent on (most?) laptops that only have 2 type-C ports (of which
there are quite a few, and coming upstream too).

Keep it disabled by default and re-enable it on actual users.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts  |  4 ----
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                |  4 ++++
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts |  4 ++++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi             |  2 ++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                | 12 ++++++++----
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 7fb980fcb307..ce2b12afb749 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -488,10 +488,6 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
-&smb2360_2 {
-	status = "disabled";
-};
-
 &tlmm {
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 6152bcd0bc1f..7b90c9e40e37 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -821,6 +821,10 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
+&smb2360_2 {
+	status = "okay";
+};
+
 &smb2360_2_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l8b_3p0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index fbff558f5b07..8d6222dd80e7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -689,6 +689,10 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
+&smb2360_2 {
+	status = "okay";
+};
+
 &smb2360_2_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l8b_3p0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
index e34e70922cd3..a5ca0fa4e5ae 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
@@ -509,6 +509,8 @@ smb2360_2: pmic@b {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		smb2360_2_eusb2_repeater: phy@fd00 {
 			compatible = "qcom,smb2360-eusb2-repeater";
 			reg = <0xfd00>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 72a4f4138616..544c9cd72f2c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -715,10 +715,6 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
-&smb2360_3 {
-	status = "okay";
-};
-
 &smb2360_0_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l2b_3p0>;
@@ -729,11 +725,19 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
+&smb2360_2 {
+	status = "okay";
+};
+
 &smb2360_2_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l8b_3p0>;
 };
 
+&smb2360_3 {
+	status = "okay";
+};
+
 &swr0 {
 	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
 	pinctrl-names = "default";

-- 
2.45.2


