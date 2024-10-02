Return-Path: <linux-kernel+bounces-346932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527D98CB2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59B81C21CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDA36AF2;
	Wed,  2 Oct 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbdT/x6c"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D32F44
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835630; cv=none; b=aWhzoRK61V/RabHNYLL/IXflbpegkjur80rzmXzM12hC++8raM0jCdy6M6ZfmGqaEOLzMiLTDK7PJ4G6Pb+GdQPQlltZbK+PUK/DHTZwuEoQZVONZ31QtKvA/Ew1V2zRixOEt33uYS413IcyCdFVIDs8PuCTwQRLtAPA9SDMdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835630; c=relaxed/simple;
	bh=KJ/XBCfRYMGGmoGw6pT+HzGpgHNM0HqU+ZU6WmeHwTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CloLOjBdxUJr++89/Sl9JlGHzqL68u0WUYCVldLh/5W6ZiRWogBRYVg6kDLPxeDJsFluDlIl4VgfUPjxqqkVgGKm60DfFytzne0k3tymYWivSjbvb2MUL2BBrv5+gz3sv1aXKGlD2js8r8NZh4imFFMXQ1iEYV8UFVf87I7nSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbdT/x6c; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so106980366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727835627; x=1728440427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6tt3oG2r1wMqarycN8kg/XqfelGZiLqlb3bl/K/iuU=;
        b=XbdT/x6chzSaPJIxDfWUqWJSYrH24odQ9WVoytBepNrzwfpkbu/gIhZz9bQd2gkndP
         4JLcVOjUV2fi2FVa2JmlKyaUaSQl/8E4jJyUA9LPbfFaqDLX4jxfqKZrVf/9whIlSZci
         KcmfKaz96eMZTvprEqlCGEtjqbCGKsqkyKl9CVL/bQkKarloIqDtJNvwPBWLp0EcsvEF
         f2RTf07b8GZpHkOMJ6ENtAgwQvy74PgNRtcqcknKChBFIan/kq+DKjLoqAQ7naLMeeJ1
         sHsBs2SPC1cPguwgfGywFIvXAlycTjFJtxYRuA9vWkZ/UnMrueAJ6DnqOuOvANsUfIPJ
         kxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835627; x=1728440427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6tt3oG2r1wMqarycN8kg/XqfelGZiLqlb3bl/K/iuU=;
        b=X6aIy9rx3mVR+xxpfd0OQrZyvvcKsMj8bwgAA4vVLKdPvEOPru59+VQROnBgLz2L1v
         D2LnOheoUzav9zXCbkLsbxeGQodPdCh23WWLArT6yu9ELpaLfDLcHMes8nu3iu5QPzlt
         4yOjxTBTvhi23eRwX+fzJmBaF/aB20D7jfJxgx0HfTeqse92n7iihcAuHAverkeLV13p
         Ou6sgItFgHmffIoEU8U1rtL34FFZOMlq16L5iRyfhfC8YpBQshvnrR8WcVMcB0rVcGDo
         FhVCkJrqdx4nvzTrMu9mNn7D8oTjiug4pUYTdBoOjs6ItOQZW/KAIaFfWSnQ9bBw4B4L
         NKAw==
X-Forwarded-Encrypted: i=1; AJvYcCXpZ/nHXt5ee4nKfrXcq3w3HX8Zsqsf4IUzXptASC7LV40wogSqBqZ0wIdkzpits6VOhQYx4dY53c6onZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZUx7tXVN5NuSJRW3IOtRiEPZX/yX/CNzOMT7Q6zVb5u716Zn
	Z2GnbH0JHycGCsKruThCnzj6Pv4FwT7PCFCNskCJYTM7mTeh0/YaPisveR9TaxU=
X-Google-Smtp-Source: AGHT+IF7DSxO6S/zg0dV87J7CmDUxTyQGbSW2llz09R6q945EHLqQDNzRVtWVZkaJVui3r1JoBLxgg==
X-Received: by 2002:a17:907:848:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a98f823904amr119175766b.24.1727835627397;
        Tue, 01 Oct 2024 19:20:27 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2945f2esm787518866b.117.2024.10.01.19.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 19:20:26 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com,
	alexey.klimov@linaro.org
Subject: [PATCH v2 4/7] arm64: dts: qcom: sm6115: add apr and its services
Date: Wed,  2 Oct 2024 03:20:12 +0100
Message-ID: <20241002022015.867031-5-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002022015.867031-1-alexey.klimov@linaro.org>
References: <20241002022015.867031-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add apr (asynchronous packet router) node and its associated services
required to enable audio on QRB4210 RB2 platform.

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


