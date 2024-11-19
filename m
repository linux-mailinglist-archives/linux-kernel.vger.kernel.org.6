Return-Path: <linux-kernel+bounces-414846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D29D2E13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B81F22A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C1E1DDC06;
	Tue, 19 Nov 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ED5oRwHq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF11DD871
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041229; cv=none; b=eAR1LAdgWKhzKz3Diyx8KkkwEsE4SU3ij3slwUiVLg0gPa81e3az8L2IX4sL4cipfQOcslGThyRpsD8NcjxLsAGdydnCroOezljbuEAxCcSm8JD0HOj3kO1yNuLfWScGh5ezDLgURSuLonGQFq0qDPT3qZ+SwqfMrRh02f2ApUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041229; c=relaxed/simple;
	bh=sXmaBm/EfJtd8mtGNHFuhr5vkWmohAC+J7HluLurjEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQpyYbshSaaD9+yEOVZNyVGxfqLJl2Xs1AXN40WywK7VQwTjETcMHU3WvgNdlmrRRtbCOiubY9E69ZEhOx+ZaNw9hx3hdS2DZXg8graNLLQa7Nk36eQiG5PM72hqWXsuZ441iG4BRLRJ3CxZymPOVt821y8P0A9Yvvuwx47QMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ED5oRwHq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so3484015e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041227; x=1732646027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEuzfplamO9MTc2aT52efgHBGucpvCvsmLRhDItr6G8=;
        b=ED5oRwHqp5TEGbotiLV9Uwg761XJSc8rW75PvZBrwGiQw7evVq9658JqyiLTcE7tH7
         NF96BgtICU4qN3A3AY3CT023aoc70lO/C2ehdYXlCOMHuK0c6lxGeskml8ulYA0tOS6M
         Z6lQDArOKR0iuLOP6y3h1qDE4R5JcsxRMqI3S9FSyVep6ILGvrknPozguGyeYKUYEYLf
         byExR5K85wu2RQmdNnzypP4+yssfn2J/n/f1jqlk4eFXLBvHnCzUzAIjCyU7ZXYW05gZ
         2C0EvqfmktLQBPYh0/+iwVKA7WdeRVLrr+EVW7OpHI/SKB02d7WW1FfVmiypPBAG9330
         VmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041227; x=1732646027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEuzfplamO9MTc2aT52efgHBGucpvCvsmLRhDItr6G8=;
        b=FNFMZCukD1pjDsXgaReBCWCBszWOcDUjZvByh64wbk0wPifTc6gLFBwVM5EFdlqFKn
         mUiezG4EC1KErQrIGie2euzHE5PY2HQg5YQCM6x+qQIPjtS10e0yznKZapX/DZDW27kp
         yg6hKA3YHfhs4BaJ52tMcfGmMwANsdthG74wccyqKnWMYkitkZCFm6g99OQpLhW7W12U
         7GlrDRJtbsHBZcMAmATOrU78opm5K2n2iPT5t/7Yzzf94lIv36R93klsNB5Eqh2hLeQD
         vdylLNycr/aHHlBD12VFu9rGpYslBk3MmbR8w7eNORhLH1LFE4OmbBGPcjTHQvUNPwx+
         3XAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBSjLv6H6kOFMrKYcVxBfDEnOCugWrzPcOxVwM+2w4tQ4+leQILhoC+I2LNCt+NAkfKx1FFNSJVJsMdg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Mp/EYTbfFsblh07t9/+UlRz8CHqUnOel5+yYGezt5ftf0Qkm
	rtnualUNERnF/4BYxV9ERo9vLH5GrFLsS4GWXlBjVyqkuAzUrkY0OrMFNjAHnzI=
X-Gm-Gg: ASbGnctlMt4Xpfk227NEDvrODu+W1oz2MuHqXsafOslXS7WKjbKoo9gNbR8+M/p0TRA
	Zcf5byW7uwCwwzz8LvuDOWmkkJzq3CU4ol7PPjIoYHXdRpZ4HL+WL1Rz10m88nIl49IfS1sWdwW
	ZssQ7ZGb54XOHqjUmvbGDAwKIRQLvCI+Hh8TjAvPivCTlqeTSLbYwaYYCfuMBI9DSPvaj7GuEWE
	+lXImOzQLr+AfuXM+Z7U++vpRos61+VXejILskukw0ZCr0vPuAaizw8tyETCdN2Zg==
X-Google-Smtp-Source: AGHT+IEbHBp77Yd6c68qIRswrIHwNemz/LP46FQZao0WEifvrkkZhQW6J5+adg160ciW6LtYS87ayQ==
X-Received: by 2002:a05:600c:4f4f:b0:42c:bb35:b6d0 with SMTP id 5b1f17b1804b1-433489861cbmr48655e9.1.1732041226661;
        Tue, 19 Nov 2024 10:33:46 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:22 +0100
Subject: [PATCH 6/6] firmware: qcom: scm: smc: Narrow 'mempool' variable
 scope
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-6-7056127007a7@linaro.org>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sXmaBm/EfJtd8mtGNHFuhr5vkWmohAC+J7HluLurjEY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn8rIB+XBSdKxZJHA0MgPDAuwj/K2aS2hOzc
 gDc2EAOQcOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ/AAKCRDBN2bmhouD
 11WiD/0br3gwbDJTHdnKByah6j9dURjMn3ou5Kz8DxwRZzqBfSfwonWfwXuC95p/xgLY/gAx/6R
 ytsnr6GGMaDtPH+djW51iLom1RFxUL+clgh7qe+6linxTxP+ZLHzFuvLRDxO1qZ8zNG0XlAA+Dh
 fBN+xjNW/tcu4Rkl8W96g5bJJNarojOtJrQNyz4w44rRTIA+ZrfTZ+lHqtVr5Kqsip17JllwRvx
 p6Xn8FMZMLnX/0D+1NjUvNBHQcRAZOjo1PioiGshRVuqh+X0u2BY8Qlgo5AH3v7Ax17jv4nrE2O
 QyxU8v3FnvnHxTZ3cjNY+k+l+4q5lN79w9s51FNJBBehh3BAsL8OekpRr4dEYu2OrLasQvJzQqp
 hc/kwvyiz5oCsMefFJjtyz4zaPJ5lD0+ZwcxxCRWqrDrhApZguP+krdtZ2vjKE4Zzh4E3RmIfFs
 KhZQvKFqFnXaFI1mPeYB/ttbivht5/ZVSYcmfUhS0Gs7qbqqim8073JoeP3KRZ7prrChSDZ/7C1
 dvuFLmqy9ws/1ESJuZtdkh+FahWPtrU0yVvRnYLA3V4ayS8YKdxsdRi5owtV1jdmoGWH4kpBDLA
 SoWO6oVl5bmFruHPZm1cYdSOs9A8a9RpRZk10ljty7kb/JrlzuU970/45NWZLk7KLW1YWrXkFlq
 ycJH4MySyymhzHg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Only part of the __scm_smc_call() function uses 'mempool' variable, so
narrow the scope to make it more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm-smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 3f10b23ec941b558e1d91761011776bb5c9d11b5..574930729ddd72d98013770da97cc018a52554ff 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -152,7 +152,6 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		   enum qcom_scm_convention qcom_convention,
 		   struct qcom_scm_res *res, bool atomic)
 {
-	struct qcom_tzmem_pool *mempool = qcom_scm_get_tzmem_pool();
 	int arglen = desc->arginfo & 0xf;
 	int i, ret;
 	void *args_virt __free(qcom_tzmem) = NULL;
@@ -173,6 +172,8 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
 
 	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
+		struct qcom_tzmem_pool *mempool = qcom_scm_get_tzmem_pool();
+
 		if (!mempool)
 			return -EINVAL;
 

-- 
2.43.0


