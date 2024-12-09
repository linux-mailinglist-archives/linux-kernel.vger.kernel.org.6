Return-Path: <linux-kernel+bounces-437409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834059E92E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C002218813FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F97B223709;
	Mon,  9 Dec 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVDatnvf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3B221DB0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745181; cv=none; b=ey9bc/tYQjnEd4T3eBsQsRtrH56ZzoiO6oPjb7AoVuoWDQfqnEtlnZ+ZLMy6ivnmbHPOUZdlCMB+ECDrWY6wM6ke8pJMbgE/lXPa8U/f2wkZefS242ZvIb2CWFWZlcSJJkmGZ/NNKdbTp7tclIV0FfNZs2eEkzpnZ0fUD/WCS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745181; c=relaxed/simple;
	bh=pf4aKmzgi3RBLEJZUi/1R8tLQs1HmFlgFYPDOVq6wOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pznHxMJY7v9ndQ2dKEbLNO5rgsgazvlIqyseXHwoIWHnaMLB020UYAKXYJlrVtVt7kCzymxEZMzXHGZsxxpoLMgLaMtIGoiIrsB1xoPQ57yEh9NbXftLIVqHW1cBlzcFBFMgXNsdYw+Y00pMeZlG368TsHtSeueL26Hq8OPUBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVDatnvf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e44654ae3so683223166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745178; x=1734349978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ss0In4eAnB21GaaJYNQJneoRBodNwxSKbh+KMZRPV4=;
        b=XVDatnvfBMdi6nK2Qd2P2XUS32nDIY1UW428Tp+9D4Yemxeoci7tcxsoQITJcQigJ2
         XhLsB/HIMnz4dh54jyBfhJgUS++iKg3yY8CUa2RCuDRhLOy3tpOU6sHgUpLax3qiY5aO
         jXVJh4muVWEVAbgkzg0dZt2qIDt00OE61qjwqpb+9xiGHiXEUnMkT8RG+UfTShtFKRkx
         eZzQ4UMsDPxi+1v75+OHRnOoBxG4LH5Xd0aWXlvYBJ37dLg8mFi+YAiUkPsIpmmL/gcv
         NQvdLGzSHsF0vG2G6yza2NITpRg1Z22Vyd9ZfCFMZFLfK6yF2Zf+We7GEwhpSlynyk9Z
         lgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745178; x=1734349978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ss0In4eAnB21GaaJYNQJneoRBodNwxSKbh+KMZRPV4=;
        b=I8WEgjsJl7KGRaL+mJ6RfzMpTyCp3Mub/eGZ4G4p2dlFAYxz0xph+hO3ZJ985cjj3S
         jMfKS+57hsJjJePzvHEPcFXaoBcN1NqnHLYkNNTdGcsCBKx2Mg8zlk9mfkgcycscXs4t
         uyoMCcPyqBerRMMPNIuVzwEqPF28nL4CU1PYzXDonTNcmEyJXWOCvRUy+twxexFQr5C+
         fp0yO078NYQu58ZSdq+g1JKy2he4C2caxIvdLN2gANeBvzLQgwm0e5CI4I2TVDIpdqTc
         IHmiMPEFqSgtTAK/hJyhRJI1vXn2Nk9NHo4LDJPOx/OnNMOP+ftogo76vkrN9K+40h05
         NCdg==
X-Forwarded-Encrypted: i=1; AJvYcCXKVVHc+Dn3j8NJS4hC7AzRVrMppplxYpeDwEtiyCCjWNz3sMyT2NEqTqTFsSBQsvYnMdlxaFu5vA+ipm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTqWdVQTI31RzX+rfcBGH35WQFg8ivNENWt2aQff8dQPGJ6Wc
	x8TDBEnF5skcYRWeD6vBt2P5jZoBrOuJnyfITPbdr0E14j60zEtirNP2ttJ811I=
X-Gm-Gg: ASbGncur3FNxH02KxdnqDtq+0S/LsDdnR/xSYNfGdedvwpA4zVSvG0UyTfxYDJbw9Z7
	6PPpWGGRnY1kSw/fWxTt0sd91SwG+er6mU799oMeSWHyZpbmvrPSEb6qkHiacXaA0zDw2Id/LG7
	/OH3osED2h02Nnc14iGY8GzgyG/cigE/guh4Sifub4O3gp6qmVKN/vsZNAnfpYlo18dwKJBMIw8
	roglYzciN71f5pDuomfyCdNgHhd8QEmDacX8DBjerkw6Nf4Ci/wgUS/TWc=
X-Google-Smtp-Source: AGHT+IHnAeVlLcy4h5Agfr3CS9r8pCDCnLWpdgEYvJe/AP2380juCNdkfMUgMdq1nq6aK1DAonfJOQ==
X-Received: by 2002:a17:906:3291:b0:aa6:98b4:ba50 with SMTP id a640c23a62f3a-aa69ce22164mr1753266b.40.1733745177943;
        Mon, 09 Dec 2024 03:52:57 -0800 (PST)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa677968cdbsm247614266b.125.2024.12.09.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:52:57 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 09 Dec 2024 11:52:54 +0000
Subject: [PATCH v5 2/3] media: venus: Populate video encoder/decoder
 nodename entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-2-ef7e5f85f302@linaro.org>
References: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-0-ef7e5f85f302@linaro.org>
In-Reply-To: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-0-ef7e5f85f302@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
 quic_dikshita@quicinc.com, konradybcio@kernel.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

Populate encoder and decoder node-name entries for the upstream parts. Once
done the compat="video-encoder" and compat="video-decoder" in the dtsi can
be dropped though the venus driver will continue to favour DT declared
video-encoder/video-decoder declarations over static declarations for
compatibility.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 88dfa9f240dc6d18a7f58dc06b1bf10274b7121e..deef391d78770b8ae0f486dd3a3ab44c4ea6a581 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -674,6 +674,8 @@ static const struct venus_resources msm8916_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl msm8996_freq_table[] = {
@@ -883,6 +885,8 @@ static const struct venus_resources sdm845_res_v2 = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.2/venus.mbn",
+	.dec_nodename = "video-core0",
+	.enc_nodename = "video-core1",
 };
 
 static const struct freq_tbl sc7180_freq_table[] = {
@@ -931,6 +935,8 @@ static const struct venus_resources sc7180_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.4/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sm8250_freq_table[] = {
@@ -986,6 +992,8 @@ static const struct venus_resources sm8250_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sc7280_freq_table[] = {
@@ -1048,6 +1056,8 @@ static const struct venus_resources sc7280_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct of_device_id venus_dt_match[] = {

-- 
2.47.1


