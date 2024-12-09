Return-Path: <linux-kernel+bounces-437803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB189E98D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9B281C27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362C1E9B01;
	Mon,  9 Dec 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3y7NqoW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403441C5CBA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754498; cv=none; b=Cw6sjqq6uIkNUHeyUdfoXfO8H62gZRun3qpEXrbywhGtv54NXH/CiuorwD/D5g/U4LSjvfX5xJ0athAPkS547yLGw4xG8fuD8fithqfiBmVrZUbmJSo46RJR0cUdcfUH8Xjmebc7/EoJo/fMikCxUM74NtBjI3NI8hZmJX2r7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754498; c=relaxed/simple;
	bh=m0JRt1yAWsfjNKbVlgVQYTxcRzJBsIOwhATVf8sbhII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OANriAHq8Mcxyp6m+GGBCljCbIJ2g4LVpT6UpBnk+uH9k5KRTAgGncsfzC9IrTjNg3mfgSery4ac0wZeP6BoKFwjjvL3N+h/a7cBdbCDipyHDPhumVr7skrzmdbTtDHEQ8gDIrwg/J56rcz1iDVRtbtCG/8IjHSrQn4+FCDfQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3y7NqoW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e5c225aaso285660a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733754494; x=1734359294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpF4sxmPjFaBMoIz7MrnksfqhjJBtk/BSNuz7mOTvt4=;
        b=S3y7NqoW8mwTWrzJenAGRaMoLeNkzpI+9kMC2Dozwo+n3pGcNCafxFzWjUZG7itP2W
         m/ZJwdJvb5TZNJWvric0uGn144GSQXS+tXTLoA3MWDZWD7CZUoMI/hDuEqL0xVLiIb6q
         pvUvmdxqUZNLZZSmvSJEisgnTm+gbM5MSKMPF6wivnZHExIqWBCIqlGkcPDLMr1erhWO
         t7S9X8XEnE8oSoDQ0kZMebvQErTLyWZNkYYWr6shVg6ReAX4vWBG8eU19/cZvAnJhkWW
         Lys80kO2ktgn9Lzf05kCU28HFJKQc5WJR0hLwtNvmi6RS7qiXBfb8tUnYnHCgSk0syBu
         hpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754494; x=1734359294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpF4sxmPjFaBMoIz7MrnksfqhjJBtk/BSNuz7mOTvt4=;
        b=a3y0iZ6uNfYMaPGvtBBB2LgaM0VFxQbh1UlI3hqP1p8BmsiT+VbQ0Ts42wKD928h8U
         CR9Uyud0P/L1A0RXz6of4iHHMHM9aneSLgIvqAjIrPm0Xm6iNdT1jO1pTD6gKAsGDvQ5
         SGltbZJTvsFvN4EDWXB6NrPsiUTkvRQemk3ia5sGpADfWmwupLaFA1JMrZJZ6IlEPgi2
         H18p1eoC2ldIQgCyQCGmmW+BOjL/bVMy84rafDNi2iITIzPKQqqwmRgPaMREa1UwdOJb
         GU0m10VPQ9IRNd8hujKTowNQapf9Q9On0cnyDe7imPBtRf09CRLCfW/lPfDWntCFmQT4
         ypBw==
X-Forwarded-Encrypted: i=1; AJvYcCWy+wCCv67C0Izj1VRC8KU2aLGYkYIup97yi7FlHQSYYdOOmEaE48wLnCSZCm4CRVTLf+VbqQCGO3f3K9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsGcdrnp27xiCVq+VFjBaK/4tGdiOgEj16u+07q9+KBr5wBiP
	D9TML13zg+hvFXe3ePbMqt4M3aIJTyxHImQEsVBi8IP7DF2EE4ZaFs60x9IKrqM=
X-Gm-Gg: ASbGncvZNaBq/AqTwI0jedLncfoz/xvGUo7cKczNukEFC8lXC02ZLjDTc8faDHSQksI
	fJDyKgU7lqYa33dSH7zftqxyinZqj2cgbEAzY4rqsvY6e1UIZI26XDlx3E+E4PThbWnRW+muvFv
	w2ONOi5KYXObbs2IaIgwVCwtVbstxMh+lXD5bdvF4apNjfnELC9DxjwRGKcAX8ucyi3T4NXIyrG
	CALLyt1n/lWjlboDOzy0X6kF0CQWwa5MQCf6GoDadc7JBUqtR/dTr8fLuhTcCrXCA==
X-Google-Smtp-Source: AGHT+IG6hfXrt3hvSblfYqRULX6DPNyKDKRfmtd5xsNKFaYDrZhdtBXI/mAT7EM8nZSdNRA5dztggg==
X-Received: by 2002:a05:6402:51cb:b0:5d2:7356:e0f4 with SMTP id 4fb4d7f45d1cf-5d3be6b1320mr4599602a12.3.1733754494536;
        Mon, 09 Dec 2024 06:28:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb109bc9sm2887141a12.42.2024.12.09.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:28:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 15:27:59 +0100
Subject: [PATCH v2 6/6] firmware: qcom: scm: smc: Narrow 'mempool' variable
 scope
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-6-9061013c8d92@linaro.org>
References: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
In-Reply-To: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=m0JRt1yAWsfjNKbVlgVQYTxcRzJBsIOwhATVf8sbhII=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVv5yGQauxg5c5bYfzNG8tu0ldbo/Dw+zHJn3E
 83ron6hYf6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1b+cgAKCRDBN2bmhouD
 17jfD/0b/dA4aucjMR6lx7H4ZacY5FDvdKUBfKGqITx0jWDckMCN696DAGVLpTk3mGRY6LNui/y
 JwRjzqvlrzdveRYAUulCfB/d625LkXA2MpCI1+VW7PUISAL3jW4Sjk0vLzB/nNd1kG9fYflVaSM
 2BbhOoOs2SWQYJGcec0a9/TtdWMS6ZNDPdmEFt9hsoQuuwf2VTTrevsByU28FN7lL/KFIKYGdiQ
 GKjdTZuE5d2QFVS0NBtSh7mt+0VXLdPITmi5J8P47x7ngX1tf1Tlam1Pda73rt8PExR3wU91yhG
 mpBxHwaS2944mHAaErzIJ1vuWIQltJrfuAJth6BcsVLH84ODKzI6Tqw36WrazM0G85GbAvJzpb+
 RKwCCGn4aQjY1SmXyNEw9XnE5mmC7TX6iD1nt6+osQJrSs3car6kEqkwhhAPWQkd2kZoQIn9bgT
 Co9xX8rYYznpU715mSPXpY1FgRhJgioJH0WUVh4GbasoyKcqWNQplm9SAKfQqD5vngrqfFSe3fm
 0CdJGE97KP+9l74F5nUTB06EYh/3tnpf479L88LeeQUpQjxFqsGoDD6GfV3Qmvk+SqFncTV5LJo
 7BobCjwgBEjcwqeHNK3VXkxkEedhrYEjwOVWT0N3qJdPpHBeVKytO+e31lJFVDGLShZbYiya58z
 Tma8ut7loh/ywTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Only part of the __scm_smc_call() function uses 'mempool' variable, so
narrow the scope to make it more readable.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


