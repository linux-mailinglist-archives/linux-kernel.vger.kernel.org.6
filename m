Return-Path: <linux-kernel+bounces-370868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D19A3311
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99F51C23449
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9716B3B7;
	Fri, 18 Oct 2024 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmRy08T3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5513AA3F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220101; cv=none; b=gTDSVGfYCQ6YZx+pxlrnZ9MkwxEgrBvSAzae9DLs1DZSotT4N+QbPMJ7pWPYhPutWuSdNEDsfn81ReezcekY5/8/gZNNc7+sOgd4WLuxJ/vCY88IPJXkoVAM1qi9kJd1xsxkhVIr+B6mLBxowcRL9Ja6b8FhN2v6ugAcKCNXoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220101; c=relaxed/simple;
	bh=cHZgetbXPWgeOCxSwhPIInm/1PEkFkr8Mi+cb0BC4ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUIwTRNqvYKxluLdpE2GdobCTEYAVn8VZVUxrDck8FXyJvTJykQhwXK1gQMvqMPvsqE6qSBlUxAooeA0C64NFlaKVuOJsFDGAcHHXg8w4SHuRAuMt/jqo2cNpFtyVfAv8K0s2iiZTAGFQ/fS0oG7+R01IXbwx3A3TcxhXmzHStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmRy08T3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314f38d274so21389945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729220098; x=1729824898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY0P3VPSjLSHfvMT72jrd8ND+SsNFP9CUC8xBRQ9Gls=;
        b=KmRy08T3II4nCtuoMa5Xca/Kt/8IUZ+RgtwjuYvE+jPGzzgpX4KorPCx99d1sfZ3h2
         dA4slkj903N0OAXhPCsYPxEHcp8jpnz7+xOYXUenEQqAJ01K9x0fkoQ8GuItp4522mPj
         vKoQGif9DjgXH4ALRyOxKNpzxilNUcXpSd+IHLxoctK/jze6kZHrHZfQjCF33m8muGBs
         kIiqdJPVc13mTujIZk5ZfFvvEe7r0fv9qkDQHz2m47A7ohSUU80tosvKkCjOUDzk7+6A
         sXccoseOfdvf3mmOVSmtLMjr3+kgH4xlDX8hLcfC3dPrOt1r0zaRqsACOwEkFZNWBmUa
         ZEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220098; x=1729824898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY0P3VPSjLSHfvMT72jrd8ND+SsNFP9CUC8xBRQ9Gls=;
        b=IDjMJ4yi+f80cIlXd0P1TJKoc05hhMC4yX8i+mfGMdEvjgSZ/EQVIZqe1MSFJCS7/J
         rSs6i4ENqbKPe4z6yf8XeM/h1uU+c7OU5Ojb3dgxKK7dQg/WCG0wKZZxuvrhNy8g7Moa
         QbkAJwJwxbwa2/MykiG3g72PXeo42zQ/bDRTn/2mmVp6oShQVFqerNXfIOtWHamE7hxY
         VIQmomrR2TqrkCQftlmbi1wRNc7DsUQW97wdA/EJfTIvqrI3JvpdDnB1D9WOWPpzrFDD
         rAlvE8gstX85f/AvpUjphqYSa5xdi7nJrrCg45jdxVQoRgtg/ReHKu6wcIT/6KqT3sMf
         zUkA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJMtNmIkDBXHaJDi92nsMIJT7U5h38z9Gz+X9JXaZXDz387lzu0VlMjEMgt5k5ZVP2HPSDPhAJwo2HGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze36l0xrYHbJg+26VZUOyoYcaN5H0GycTg8pcYr5OXavqBdIwV
	F9LDdv0PjyPh8bM8BK4QeOJrAB1qhIrdJ3sdLc4C4cxqIlPqDOm+1kHATqhgt9Y=
X-Google-Smtp-Source: AGHT+IEEdszq2utAiaIdNu7RQTOuLxS5DpzAHRwm6FsrKTRLc6/fA4KPYzS36a/2YnofJP3f32b4lw==
X-Received: by 2002:a05:600c:4ed2:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-4316158fd55mr6918445e9.0.1729220098167;
        Thu, 17 Oct 2024 19:54:58 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed599sm596135f8f.69.2024.10.17.19.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:54:57 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: [PATCH v3 2/5] arm64: dts: qcom: sm6115: add apr and its services
Date: Fri, 18 Oct 2024 03:54:48 +0100
Message-ID: <20241018025452.1362293-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018025452.1362293-1-alexey.klimov@linaro.org>
References: <20241018025452.1362293-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add apr (asynchronous packet router) node and its associated services
required to enable audio on QRB4210 RB2 platform.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 41216cc319d6..b211a49982d6 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -14,6 +14,8 @@
 #include <dt-bindings/interconnect/qcom,sm6115.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -2701,6 +2703,76 @@ glink-edge {
 				qcom,remote-pid = <2>;
 				mboxes = <&apcs_glb 8>;
 
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1c1 0x0>;
+
+							dai@0 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
+							};
+
+							dai@1 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
+							};
+
+							dai@2 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
+							};
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
-- 
2.45.2


