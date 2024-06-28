Return-Path: <linux-kernel+bounces-233223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAD91B47F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D111C2173E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680EF1CF9A;
	Fri, 28 Jun 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qg2B1Vno"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275671B80F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536845; cv=none; b=riu4E91mwOzqWpKsLsxrTU51Ftx/hmI25q3w8Z5Ft4lqKB9nbRuLg+t/mvCjrhjTNIaHQn9C0S4N4N/9pOrPDpQJUctjQA4ELcKIaBsfelxaaUzASByHpwo/Eb+yG2aQq2wgCHjMo9wXPa4nuur4tjYcsaaA8z5tHX341saUzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536845; c=relaxed/simple;
	bh=eAsxPRlEzNTeurZUlbb1dRpSlSCLeJU/Bps8eIDqRWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGjbIE84dCzF8jVehY7n/kXxal4FZvoiMKgdfDZfE/68Kb6XRnwnu+2tu8tErxGSLSKlyRZLwHKivPXRdlSQCsSq/BunkK94qlkkIzM5WWTKSOfSWIy26NUYLcFIbLiqAbbqkbCUJc1Wr0zR6ykTFSjwPWoeAJAbf+siA+a6aQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qg2B1Vno; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42567ddf099so398275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536841; x=1720141641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8Cullp4heLq3j3LJu15lP4LYL9Xcky4j2OZDLvmJ7E=;
        b=Qg2B1Vno0FL8wBBbo1dszQ+DE6LcDB+7iaAYYF4QjvboPKQeK8Xow3V4/RDmBAbCkx
         ESeGs1eFBpB7v7VAA2EfCPhiqBxVygFrTtrA7ZB3GYzpVh2XTjPznL6BmnQkOHby5XNg
         aLPak+1WhmEscosK2YQ7SEnkKbZD+mA2ANj6ebQ3/WLUQNlL4uk6gX2AvFTrWk72vzbq
         SzBaM7qIR8zWRkUMjjxPzek6G1TAvQKLuCVomY8g4nAB9sF3iN7ZgCW+6BAM980pwUxS
         JBApRM//hpR2Ul+Cfvtom5TYgcgUJKPaAlLUqaufOgnQBJE9ILeWCgag43YJWH2KJarC
         EIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536841; x=1720141641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8Cullp4heLq3j3LJu15lP4LYL9Xcky4j2OZDLvmJ7E=;
        b=hgXRw9tk9zuFgR8DAjcnugX1CkvBnthyUjyWGzLo4ha4nA0nKCbIb2GRC3x/IDDYkD
         89chqzBh9MTQpL56l8leZgAt6MCaWoaxOsNMUJIBS1poVc966I7ZrntLITDOzD7gibkA
         NMYfVfP8FCYRy5aSeD4FqKzd250BnrIOOG2xUP4aeb0Cf6wyeYK6I9EdFayYvBLmZID6
         cHeOoFmZJZ8bukefZmIVGPAefFbvVZhqZlj8+V7432gDZqJxQeC0IUKUvORhOjtFAirh
         JEOtJWWr2CptuezqduDFRZnsOqQP3eP+Ag66GYxTQK9259r9OEYgeN5CiA3QMRvpf733
         L4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgAFByLmCsgwtoMewlrdYSVswfZtV+HunHb5KgcEAYNNtkGydKgBV1LZpmZnQDLLIWcmfkETHXDj+g+oLrlIixz1+hXuYcjt86ckRm
X-Gm-Message-State: AOJu0YyVkxP3m78h06rxgfhnvdj3/xZ/wki0i/Qc6O4KuTvNc1mQVkIU
	ToZ+qcBIWvPtvpTDvXnhb9pZKLuacDcJuXQUAwwdurC7Z00p5vCBeyR8mDWlwjQ=
X-Google-Smtp-Source: AGHT+IFE15Or4v64XjwbEff7c+MWOISRCnhFWtQM6ObQ3evXM/ffhHAIMMW/rwLFVOHlxMVgJL8Gew==
X-Received: by 2002:a05:600c:1504:b0:425:633d:926a with SMTP id 5b1f17b1804b1-425633d9463mr28806335e9.21.1719536841671;
        Thu, 27 Jun 2024 18:07:21 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:21 -0700 (PDT)
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
	alexey.klimov@linaro.org
Subject: [PATCH 5/7] arm64: dts: qcom: sm6115: add LPASS LPI pin controller
Date: Fri, 28 Jun 2024 02:07:13 +0100
Message-ID: <20240628010715.438471-6-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI)
pin controller device node required for audio subsystem on
Qualcomm QRB4210 RB2.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c49aca3d0772..3a9fb1780c90 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -809,6 +810,21 @@ data-pins {
 			};
 		};
 
+		lpass_tlmm: pinctrl@a7c0000 {
+			compatible = "qcom,sm4250-lpass-lpi-pinctrl";
+			reg = <0x0 0xa7c0000 0x0 0x20000>,
+			      <0x0 0xa950000 0x0 0x10000>;
+
+			clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 26>;
+
+			status = "disabled";
+		};
+
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-sm6115";
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
@@ -3068,6 +3084,9 @@ cpufreq_hw: cpufreq@f521000 {
 		};
 	};
 
+	sound: sound {
+	};
+
 	thermal-zones {
 		mapss-thermal {
 			polling-delay-passive = <0>;
-- 
2.45.2


