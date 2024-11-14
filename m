Return-Path: <linux-kernel+bounces-409990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D69C951C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E933C281307
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC31AF0C9;
	Thu, 14 Nov 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="C6PylkxI"
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836331AC45F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622664; cv=none; b=tAtniP4menJr3tgOxT6QpCpGnQ4gF3fNPIPqfb5IVRdohaGjRu/oHJUj1ucxxDjN6X/6/mUFBpLtL8Im31D31VZrFuGox4XK2p6TCUgE8IqkXjAsmNZrYUg2oOOKWwSChYPvp2D4zL+kfCEXJK41swMfK+qSR/v7WSX8LynZFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622664; c=relaxed/simple;
	bh=8JzMaKrWlHH5Cvl6LgJr+4ysWctwILSWMc8f7gCR6pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:References; b=lmKJxfOAWiEXBlXEGpIKwR++JlISQQAXmmupf6Wj6pkGOijDuObgZ9sXsAW30zeRisF3I4rDfB7t2XwZbefQmGFoCT4YHf4ZSn/OqIOpfro7EKZpP6R7g6DQQvTmOMyJTt95x3Oj38QqzVgmDvFXxAxQfl6EB7ReFZGWNU/nGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=C6PylkxI; arc=none smtp.client-ip=87.248.110.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1731622659; bh=VUBlByHueXDmXb9r+9Fa/bqlDMIi1BWz7KWtmRZf9Fs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=C6PylkxIsDaAZEqXMpBBKLBF7n8fPVINgk8KUdv5Tps2ltr9mJY3KfP5Mb+RHMMlQqJYS12UtzfUfjRaEFDfazRYJ7qKxpai42R6loXpp6W0v4TM39kj4QubdBAg6P3xx6J6xOjmaOR6Ze/9rBJsC6gb4R1AEKutF96Yo7IiaD8bvK5LgMMfO9dpyvPPesfjWtVFHYPPSY/ilCDQ/8eeebVTzT0iwaSQGu3udcrrpNxfSm+nohXo20ytaXQjebFe0jDIol25vgFHDOxe+scUNdGCSeN+GL7hza6l9MtI4djkY6o6XWGWHE5pAFH6KH33FV3yrEZaCOgkT2pRZI5bFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731622659; bh=Ze8pOL9sEoVJR2O8Vt6GILy+zWfqGq2unalvG2RttF9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C7eImqjpQPJi3y+1oFNNpQXhnOXWUU98Kh//x1bi+lBqBaCLNG8GooHhU+IS7KjS2YS4Cp97flzzktzYManSChpRw8fVTwg2rnZmOzdCsaMR8HGITM7c0O3zKrbQstxlU8Y+sbGJPMPIo4ZSX98ut03BGNWrXnHY+A1/8UaFOdWg6x8HlGB6hdPaOIAfvC32aMuFD0+MQEZlS3vRfhnfv/OHyoxeDKUQ8NbcX2nVWChamEVZX+YZOqRp7bdFGVNz2wtiVUn3ci7Y0bfOiQGmaBuqZlWL2AAu0SMj0g1EIRdOL853XUvQN1bCkzPU2sBr5poPez6olcc7cTG2qwAoEw==
X-YMail-OSG: Q5hDKeAVM1kIdEWwfSbfZU5EqLlTt7208ibXW4yWSK6P8CnODAtAQ3rBrxBT.9m
 5L8xwbK6XDV5fyAYQHrs38e0PG63Ye0iR2M4L0vau8V1316kIqFqULxJ87LlPQZKROGAMkJICaz1
 o5iNZm_5AKhxPHR9_ED9l.YExtYFSCJEfFMgNsPdoZ71ADc67U.TLIXiCMykeW.fDLuTCuuRs9vd
 k0bF5cL3SP7Wf.qMpScuYKBSVfgsu4V5tkN1MUJTrf2a9AujJJWIDPG96p_oZXC9vakm7WBisFKL
 Ym9pxyvySkk1drMx_B79Dun0gRr3A5ypQX5ktrUdviCrrnS.Ez_lEZlfZ64EUqXoYgywoQC6lYs5
 esRab8Ljz3oFIm_fB8dd22dYLfktjVtJFUgsem2u50vTamqwnI2_96M4GJN.xONy_eAZkfPyzUpv
 JfUIUR08KVZ7E4Moh8JZTRMSI9gLO8YLvtuHMN2i777uwyppVm4LUADxdjF6LbsmomFJqVzw9o0u
 yFoE2xCJWHW5smKPhfWkXdZyMIdFXhtxF2KSK1bxoJUkR5RQaRO3EA3kNIi9B7n_qqDeNKpgv4lT
 lH_p0eIk227_1TQXtzaHdbiKeD5eNdzyTXfSrMtYWKb5Klh_TwkwVbmYpJptuBhaPbmwTFpZ3hvM
 RrrHP6RnzR2D8BWMVRvmeVse4_EvL2AYWPHLpvElIUhHBZJIdUJE3.xgxww.m120bgxUf.b4dfVy
 YcGTEGlwEkZ1GahHOKLqUaOwNIPM6AGpk23VVzXokYnJcydLhWVl3VnjiPOZt6zZesq9JGOvfI.1
 ZtoNqdkHYNB8aqD8ogu5RzZA.wJ.tBIbAZiZmjAKL5i8OLuE0qmlhDy2b9TTahs6Eef.4hJWGngv
 Q8IplUrMAlHFlq3_.H80TuQtvtvkj6CaH_iApTlhgek99DygXyGFgOfkdbZg7URsxwGoTeY61.j_
 x6Q2f_9jpNCnRKftkrLl4FkeLb4o2skI9tTqKXbkhE9NF9XL_cMSt4uEKVwiyr0MSGPm.Q.D8.Tj
 eD7V_cSnngbTUbS7WQX4Bp3rTfHW11K9IdO5ECzvFXxf.k81Mv2jO1N87cW7mrlyBi3RqupL.P00
 RCLN.C62AKxJX_YjYdVo1Qd3it_NjNuFU3BxQgqeyAHvssM2I2yp5HsxtTSJwr85_ZZeRL.7AA_P
 8UrnH8CaW2sjckjEOOXcK96YqsaxS.dHMdukkbC1CqUky3tHlQMdK9OVIDgZTSUxGSniBGnl_Tb6
 REm6nkNGJ0ikvpH8mxBj5D5xrGHc4.hficfLDXnI7hUUVD4A.bCKabHliEaZ9fvSg9Jjef7LrZzD
 GD76xBAKSlA_p67et7XFqTyaNum4bjsD7U0OyUNJuGOFDHGhS5A_r99iiakhtk_59kN8H2aGmZ.b
 3Y.TeEcGeJkyhuYYg4lZ2ANgGvrwV.J_TpnsQZ66SPPHPmbW3G3pMS0HuVZcJrKbIwG7hfsU2JVw
 ZMVjQlSo0S9Wbx5Xu3h1t20jObAvlTplU8Xe49GXdDS1q8GR1xNit6h2v4eGRlvKd1QUN3DrSstJ
 vg_GU_do_hyqr6emz5DScy28YTUT..PpbLI0dlmIHRBnfhAOhfgfv2j9JsLacrQ3Yb4yzq83lpdT
 cedTSJdtWoHIBBvwSTuqQpmmBvoq4Ooef6KPg04V_BVGh1JRksam4iEo64PzGU2lAhV7OW9XBYst
 klS.6S8hl7.S9QIrHK0kKn1rpej_1PnC0UWz1XMLOd0TRftL7t8h8Q0XU2xmVpkzb.hGoA7ZZpbQ
 GL6vLgLL1g7iFfg2pLuNqt9HlB9CJTTp9M_hI_ctoybQCXl8HxGzjotrXxeGY5rF1NnbBDL8dd5S
 KSNubgqsGhOw9md6XJoQCdq4j1QDHr.YKc_8ROkxk7x9uZFuPRhQ259jJPWVcJo4IQcSe8cXsRVi
 YymSiuEFYzzVHz7Ip_sPoMRIMcfZ4zm2JPurrOph2wl52fzgl4bwIhjJquOrGJidH3gc0yxbOugh
 SOlpqTxDm8Nf012Dm6TTUg.1kEzIV77S4A8DEo.MeMMM05DP1DlfOEJCLGprrLP7Rh81u1.h2xtD
 lefhal02VEmW.1Cd_qTqY6uAXggKKnQheCWw_HEyw00eSZSdNaAp98zzn6Rszv.cOxAyJbRNCKtp
 xD35gidCwJ5vH7XUGfoM.PRY7vpy2vp44CuA0PqjqoPKKRGIrQuZNziyEW8uqFZSAvcgm4XScwbj
 3xGptjnV8tOlW2WdeLyGg7oe3Bd.hzYbSmtlNF27omIsfYjuqltZUNKfms0VVVI7iUNvChYNPAMa
 lXz5tsL4sj04mYE9un1XTEBZyGfmZH9_FwewnLCw-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: cd958c09-780b-4501-906f-d67165ec7c2a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 14 Nov 2024 22:17:39 +0000
Received: by hermes--production-ir2-c694d79d9-mr45v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60a5376110f1aceebb11253fa288c199;
          Thu, 14 Nov 2024 22:07:30 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-serranove: Add display panel
Date: Thu, 14 Nov 2024 23:07:18 +0100
Message-Id: <20241114220718.12248-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241114220718.12248-1-jahau.ref@rocketmail.com>

From: Stephan Gerhold <stephan@gerhold.net>

Add the Samsung S6E88A0-AMS427AP24 panel to the device tree for the
Samsung Galaxy S4 Mini Value Edition. By default the panel displays
everything horizontally flipped, so add "flip-horizontal" to the panel
node to correct that.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Co-developed-by: Jakob Hauser <jahau@rocketmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
Patch base is kernel/git/qcom/linux.git current branch "arm64-for-6.13".

The panel driver was recently added to linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c?h=next-20241101

The associated dt-binding in linux-next is:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml?h=next-20241101
---
 .../dts/qcom/msm8916-samsung-serranove.dts    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 5ce8f1350abc..caad1dead2e0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -321,6 +321,41 @@ &blsp_uart2 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mdss_default>;
+	pinctrl-1 = <&mdss_sleep>;
+
+	panel@0 {
+		compatible = "samsung,s6e88a0-ams427ap24";
+		reg = <0>;
+
+		vdd3-supply = <&pm8916_l17>;
+		vci-supply = <&pm8916_l6>;
+		reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
+		flip-horizontal;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&panel_in>;
+};
+
 &mpss_mem {
 	reg = <0x0 0x86800000 0x0 0x5a00000>;
 };
@@ -330,6 +365,13 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -425,6 +467,22 @@ imu_irq_default: imu-irq-default-state {
 		bias-disable;
 	};
 
+	mdss_default: mdss-default-state {
+		pins = "gpio25";
+		function = "gpio";
+
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	mdss_sleep: mdss-sleep-state {
+		pins = "gpio25";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	muic_i2c_default: muic-i2c-default-state {
 		pins = "gpio105", "gpio106";
 		function = "gpio";
-- 
2.39.5


