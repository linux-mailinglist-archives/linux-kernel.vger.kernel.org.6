Return-Path: <linux-kernel+bounces-524095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB22A3DF11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4687E3A319A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275B20D4E5;
	Thu, 20 Feb 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKnQhDYW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B79202C36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066270; cv=none; b=B1ggYCpSvNjzvECYCnjAr0M/pLQqUOczcB3YvxRUEVL7Qjqrmg9175X6k7lioTQShBpV5mYAoUZvw2lZBnDTLu/p6P6Ts1K4lBchElCOJmjpGC0ZaA7iTn7xR0uHMn+1+wZQDms10ei4sB1o3YlMNVJZIbhamd6uiMH4C8eTylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066270; c=relaxed/simple;
	bh=QaT8J47seIEi5/AqERBFPC5Z6bI3D140tXarK9vkgJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swmqi9MayrfSJiWGeEeubs7Vag+Ek87/IJa1mseAN0PUaCIKutI4070I38aNkMgaZ64XBksvLl8tMOAmt/bRWZXeTEp5VDhioAAbExC3TFAen8a19a4pX3vOQLGY+jBoAytiE3jYDArVjSt4prjZFYN+EJzLeBhTe8bOrH3RHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKnQhDYW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso166033a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066267; x=1740671067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GY/lZUViwVvA9Lc814pusY/ZYVJenJoYIgN/xOpSxU=;
        b=QKnQhDYWXi2sAe3KnMtIzwRq5760NsDiY9O26Hk1wx6uT/ZmgM0wMKdbL2AFa2zI7T
         hVuiCBp/PHD3tYOzwmm2bDfm3T7engUNuON5gHShRF1u3fFsujYkeqNf6ciQ9oCW5HUs
         htX7WaSYLfeh526f1PK9jNDZ5DvvQF8iz/sMl3qVWRtxqT3NFejDPAdoaWt89kEM8bDZ
         bwTueBdqXQDs0mCeibwFFm4d79LajNLIeP6Env42uAmiNtZ7gSW5MRbHs5wK4X6AHBrm
         HDwgqA/WkpLZiftcTzYU3Y9yPWEIGbKj7w//Cs6P4JfiopEnxqtS/Z2gn/TH0nL61TUb
         BfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066267; x=1740671067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GY/lZUViwVvA9Lc814pusY/ZYVJenJoYIgN/xOpSxU=;
        b=nniM3ebnUy4WA+VAidhHDuEGMocAro6yhn8mim/Jof6DAy3VvSm5uG/BO02CbN/g86
         +WlsOq5LDGAtZCtmH5LbtktopwNxdHdhV0oNiHTAK5tJh4cGMvywCLmlVfLnLox2S4Gh
         vwJ6cd0BllZVljEhuWaSQSgkVQ3YdliiOO85BoInqvWS08j2nNNhP+FXV91izQrmr1m7
         JrEFpfArcSB/MK5QnrNGLan/O6Myvlzg4qUVsSKXO6lUs0D2k2qczD37wf5wc9ncnk6j
         B/wL6eqKKYYo1mo57rgq90iKBeywfBGCVqUhZ12ELZNb8uinJiyXs5poYNcwc0yMzqgu
         K6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICegQyhU9X0exQ17G4uLPgdiyJbAUhZSSRuPRlZjfPcP1RPGnE/09xI4OEwRuaGF5cqVcBhADS7XMXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySwDYm4gBzIca1/m89Ul1wl4v7Kw1bENiRG+HwRA6YieHIcSF
	02id73xLZ+AqWTZs3EnSMtqN8tKoCcFGepWFFtMRl8Rw4cbHvAupiuy+RG1pVzM=
X-Gm-Gg: ASbGncsM3hGehsYNcU/8oVK/ZSDyPNIkednU8KdyJ3chgNNe/rvh+7FtHf4BrNAUyn1
	1zcT5U2xJZFaCIfhj1kxWpmcYoFM7/+qNCWFdS1q0jBJtt7q04q5CdyybWvKDTk5LkRu+zgGGYr
	5hhKl5TRN8PCRMLjwHe7Ofx3mrhSLAFpJMnR3MuulAP2p8CvJZvVdrAQqSYO8pVD4rVmWkloe92
	pOIY/8e43I1C++YJX3e6TMyFvFNZKfH1ityrLH1/bw5543l2wDGdDYrtJycXLIj2YL5lQDgAguv
	jJEl/zmwBoYtmz8xgxkQae4FgAGQz41g7sAkUltzQPdiN4Lcfi1T/+N/RUy03xxjRQ==
X-Google-Smtp-Source: AGHT+IHLTciDFqhxiwXeG0PLjQsh/Odlyfht1PecSHhE2+xPvT+0dQpZWOBYf/R0I1dg5b0HlvFtsA==
X-Received: by 2002:a05:6402:348d:b0:5e0:8275:e9dc with SMTP id 4fb4d7f45d1cf-5e08275ee92mr3309701a12.1.1740066266928;
        Thu, 20 Feb 2025 07:44:26 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2881b3sm12418151a12.77.2025.02.20.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:44:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Feb 2025 16:44:14 +0100
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8750-qrd: Enable CDSP and
 mention MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-b4-sm8750-cdsp-v2-4-a70dd2d04419@linaro.org>
References: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
In-Reply-To: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QaT8J47seIEi5/AqERBFPC5Z6bI3D140tXarK9vkgJ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnt03TRHmqfeq47U+kN6c7Hq+JWe0KuzC6smSPf
 FdLWNCLnYqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7dN0wAKCRDBN2bmhouD
 13NlD/9bAvhaQTy+BSphMYPGYWakfVJyYjbg/Hw8BOfOe8OT3CsAWQAVC84oPlkygrSY4PvvPtT
 9mLxmiEcAIp/4jYKMIbyY33vNCDGa6yTXDbsh7xytKjjLCj32fRpQlISuFuUKZg4w/myzfk6VWb
 ALXDIEUJ0yYSXlQELjUbg4v5IHyBu5zd7gGHuE1gYssyQdBz+bbva/3BoyPemKSDMQH3IKfKCB+
 fAGh6PrRBcputu10lo6/2K7Hz0/32y2LxuUyf/Qrj/AU6lGOBiucW8QxpbXEgDmBr2bEX/01dJD
 mdokMVpecAMxYxJOh+N0XGFQiEmfzzMXwdMMJ1RDZUChy+wgHDd8AjljO8dS462u6vp+NR1kXVO
 vu+Zftvun/v/6XCBVlSDrWQsLI+AtPQGaUUMAmfLCpLWZnNYO9S/SdBOpnpbJCdK8liOL5kjatr
 Cn1M9d0Zw+5/2HNbQQLhQ2R++mWQAL5hsfkFYNHjOle3AIc9JtyXkrOu7AADzZsGyFxyFEOCkUT
 SKeA/jKD4UnMbD5SIy8+I/F2HO9jmk7q9yAuISW5iEtLilJm49OM0JZ9wmJU0N/jO7xYplDaZV4
 SUEc2efv2o2dm76nRPuDqsBC9TMMlLB/N0l7/PPf2H8vtmGaJYEwkP+I0O2bldM18C7YkByCEo9
 aTlOk21NF5JqTjg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP and MPSS (modem) on QRD8750 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Not tested on QRD hardware.
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 341774bb042ff88af8acf49c2f0ef14f9994dfc9..840a6d8f8a24670a01376f8fce511da222159016 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -789,6 +789,20 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8750/modem.mbn",
+			"qcom/sm8750/modem_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


