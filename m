Return-Path: <linux-kernel+bounces-431319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6B9E3BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D92166C42
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F571FBEAB;
	Wed,  4 Dec 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzVk7SSB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F811F7083
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320835; cv=none; b=WDfkq1uhyiGWfvzmG1jETmhfCDjoMKZeXid4xuIsQZxG2mCSwG8UrYcK6QvC5ry3iWv8MwWDbuRIeyFyjMumni7qp99RJDGbshDbzPnhHegMlAd2eN/FiI2K3OGg+YONka0cjVWxURNe4iVp4Af9fcjiPSCl4dEqQ3fVZiOSAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320835; c=relaxed/simple;
	bh=Y88dxKTEB84Sy5sor9WVb8Lb3Eunx49GPWiCvst3MDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETfkJZGCTs9L3ffamkpEldjmTLRN3ejSQrEZ7iLW1bbqPAoicwqBgwfq1feSh6xQRxOQ7CCxdxQjL7IA4sO6KH2DqCeEh7boAhtPdAc+6rNhEMoHQAR4zmYkH1vrFmoa3sLAAHHQFsmqKW74ko2VWjpUi0dVYjTxVyyyGdGLsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzVk7SSB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so3010493f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320831; x=1733925631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNkMnvZSHVbHckJCKRyiqgolyEylIkwRfPR/FWi1wBE=;
        b=CzVk7SSBmlUhWOo6Uu1wiMPaqBawFLry0OzsNUKhGvddJUhkXZAMIvDCGAC1AIfD46
         0Jdu9CpMHFyUJJ7dHxNiFEHonYSC9Z1IyddIMkHKmEwc7I51n/pDxCgCQeHFozia/HJL
         Sp557ummHYc5A7sW1CkNIEt11TK3Hq5Gr37ubLN5inxFslunsF6qtOGdgLgyBWEPtxZl
         WKq26G7vL4PVPWd2MSxw5Dt71S0k44i1znshb2Xg8eZAaGFqI5Aj8kK4cb+zl+KFQ+g4
         i7vRXGmGIIX6R2Y5UcizmyaRHq5nm5LhfAuU0TmQEUVCigDVhaeGNM82LZZNKvIqkj8V
         /MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320831; x=1733925631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNkMnvZSHVbHckJCKRyiqgolyEylIkwRfPR/FWi1wBE=;
        b=LGxgWpEiMyvhG5lwAvQHaBgtajszV/Nb9jDJSCRZ380hRittNmkJeBLKhqtjOI/W6u
         TfNP7J6AVmOTgvrmJyevbXD0//0lPIMI0f7NR7DvwXONbOX0t0j7OehiPIsI5LsafVDA
         J3AxoRmPQ3+aSthPj7yL0+VK7L0tzENwvhh87ERT9C703jqxEOQnTrQNqmRR0oG2eplW
         JjTLTd7DoAZJKiUojIXWVzWu7IcIo4jrwBOHp99Y+GWlKAg0Ju6ei16AUVndDLJZXDJ2
         /+aQSnGsdPnuSVKHcaVEuldr/qGmuF8VP5oxN1fZBLnsmWwKUlG/GVO0zecpYzH3PtKt
         St5w==
X-Forwarded-Encrypted: i=1; AJvYcCXX7YIvtcjSL64gJ8/WSNXaHDEF0i9jo1ocpqv62TQCPCqhxtew0MnqR1qjS+Uenru8rhV34ZPjVp32b2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFq3KBJMozUI8NWT9YMWa1s3BCSNOW2R6fdZct74Ts9EhipC0
	ZGysyPyRhMijzd90dFhn/xbIoldt9yyGmoABrHAnu8o57XV8t1o50GhvIoHEKd8=
X-Gm-Gg: ASbGnct1Wl6bY29hTeuXm44fwOYfEpWZbjWt56xoao5WPk2BCM0lbgOUbYCvGzFFoQW
	X+8CUl0bLVXrgm/1VLJD19nygMFwEiytJdCnZFQMQqNM+J21sZ6Nh2sv+J0j9ZSi3cM3j7HmZpv
	KO9dtZAoKnvOaol8BpVrK+Z6BFpReALpZTgZHqZ9VQr5zRkGwde34cTvhy68A3qSvMOkZKads7G
	UrWboELvZBIne+pYWuzt3owGscvkMBsji7Y5/6YA1ifFpKXzzva4BnWtY6ObZF8a+eWAAU=
X-Google-Smtp-Source: AGHT+IFLm3mAtpQU8RqFuHUpb0/Y6Czk2iuRyOThmoKrp6zlYXL4Adntsv9jCROsNU0P1ZXKV67r/w==
X-Received: by 2002:a05:6000:2aa:b0:385:f349:fffb with SMTP id ffacd0b85a97d-385fd42a35fmr5359588f8f.45.1733320830981;
        Wed, 04 Dec 2024 06:00:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:2381:fd67:101:8e2:966d:36c4:3579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13689978f8f.49.2024.12.04.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:00:30 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	a39.skl@gmail.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] arm64: dts: qcom: sm6115: add apr and its services
Date: Wed,  4 Dec 2024 14:00:24 +0000
Message-ID: <20241204140027.2198763-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204140027.2198763-1-alexey.klimov@linaro.org>
References: <20241204140027.2198763-1-alexey.klimov@linaro.org>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 9b23534c456b..816b8331933d 100644
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


