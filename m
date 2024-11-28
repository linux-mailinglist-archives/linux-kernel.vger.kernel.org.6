Return-Path: <linux-kernel+bounces-424916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF29DBB33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C786282B20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994331C1F27;
	Thu, 28 Nov 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUe6tDkW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B41BD9CF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810917; cv=none; b=jDIQyjGStjt8nwMIag/OiBcAMMYbX3oOBZwf0JPEmVdnUyWnUeABk2Ermj03zpU4lQ1fwtAdMShQBm0kf5FrRTufEPUSWYa7mmETJ8y22b9lLZWxBfWhuDys5dJvH+miaxbmsjK+TBKrId6RXQdm4XO3Q82MzHJ5UKMnkcSaGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810917; c=relaxed/simple;
	bh=uHwu28kexnpu01U+BQLqCIx+XHvsd7tHdfHAO+9X+fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1phMbr0kIJDuZoRX2XQz/5k4B8HL2DWFJXFdLhDS0rl1BDoSNnQ2nwGp+W4khvngbKDzV2AR4NGFGP0odFMtuOHnAF4qUzaXJXBJlfxxZ6R4bcAwP6+hMSzEwjPY+kABoyFz4yqUEPub/NLER498EPdeA+1CMHn9HdyjXyLUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JUe6tDkW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso256272f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732810913; x=1733415713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2ByW5LJaVgwbGGu4xqa6JYQJaVynxhc9VtK5XpZNd0=;
        b=JUe6tDkWypzDArBQdaQW35vaIWtolgUuBBj+czhkEJRL8AumtxZ8KU5avJjnopWI3z
         et9hnm0Vi2qk8A1FQrC91FhKnOhmVN45CbWa9cygE3ldd5v90VLDh1pvpUviQBhVdJm8
         rme0tMzCFUm2gV58Tn6iAUJ/JwvsG38DnmXcxw7UPmE41BddyRrOZajHOReoU3iBVVGG
         wlHQNmL3QaHt/tjwkMmeJkKVSaEuG3nrpr1oymEfpya9cuZVghlbkT2HWS6ymsUi9fkH
         5khdPYM1jSzCOXICc3NaP5uJ3RlAo25sM50TNJlkYLJyDVPbz2sdCTwTzuCdPB7wuzbK
         V1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732810913; x=1733415713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2ByW5LJaVgwbGGu4xqa6JYQJaVynxhc9VtK5XpZNd0=;
        b=TF0Ap1mMrbk7DTEkALzIzROM2TgPsSj3cIYReIpcev/FI1f83yePrH8qgJOM57IasP
         FpRu3Dr0e/N6WfzldrVRltQH1lwg20zsih0taaa10LjNZrD2jCeuw34RdpWSQOcqsbNM
         tte0K/0ueIMIRGG6pkrS3Ix5W4qZHAacYhJ8YnZDhmuQJTYsxbZ52jl45IY+HQEQZlvV
         HhejPXugDad2eSTGHx5V+rYJN/K7nhxoMtiQrJnYLOzilpfXKYkn5q3FG4eeuwQ7W30o
         MxmWFuPyiOEKIeO1z0u6HIE0++ghmlULehIDpUDM6GPu7KznFZZSlSxahbm4EgpdZ+mL
         D2cA==
X-Forwarded-Encrypted: i=1; AJvYcCVVMdtyAqi/LC2h+buFDnWaFoHRq4brQESHNcQyNd+KmNE97SKkfZX2oro+DWfqAUOh0iDjd9/dwDe4VPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLNbx4ucM9ItfTUD1tEeQyJkg3+36j4sCYotoAmenWGJloANK
	qg/zjRrik7LNRhzJH4SJ0bW6vQiy6jZwuB/lmvg0v4kOcNPPtsHeufwjcXDrpP8=
X-Gm-Gg: ASbGnctBnoYTxZF+w32wD4FEPJdUCqryb/GVhlm5wCkfvThGzn7+hIaCZvbrbg2cCZO
	68+s9LDNG17bTDQahuED/E97D7yflAcd88hQzUuvJyGhIE1kYTl3chrRRJIqF5jqKelBM2NHojE
	AaIN9E/3xQKj3SWWAn/FKP9kxSxm2llR6e/HnYG/M6Nq3RY54ASuvCeGcwWVDJRIVc9DvtSXUI2
	Gl3Q9srNhcNBqJ8jsfa76St7RPxMhp2OBIb/e/30UikqbAKSjSD4x2j/S0=
X-Google-Smtp-Source: AGHT+IGGiN8vBkxi8NX+D9sBUXrGPX4zuLPArfsKyiosF573lLbt37akFeV+XcprEbuk25Cn/bUWfw==
X-Received: by 2002:a5d:5f53:0:b0:382:3f77:8584 with SMTP id ffacd0b85a97d-385c6ebb9ebmr6891625f8f.32.1732810912756;
        Thu, 28 Nov 2024 08:21:52 -0800 (PST)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d9csm27004545e9.38.2024.11.28.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:21:52 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 28 Nov 2024 16:21:50 +0000
Subject: [PATCH v4 2/3] media: venus: Populate video encoder/decoder
 nodename entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-2-fd062b399374@linaro.org>
References: <20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-0-fd062b399374@linaro.org>
In-Reply-To: <20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-0-fd062b399374@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
 quic_dikshita@quicinc.com, konradybcio@kernel.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
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
index 8a085611443cfda89ae71496e320dfc1f02ade88..1a408c1c2277d77c5fcb67cb94baff6b98c26a2b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -672,6 +672,8 @@ static const struct venus_resources msm8916_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl msm8996_freq_table[] = {
@@ -881,6 +883,8 @@ static const struct venus_resources sdm845_res_v2 = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.2/venus.mbn",
+	.dec_nodename = "video-core0",
+	.enc_nodename = "video-core1",
 };
 
 static const struct freq_tbl sc7180_freq_table[] = {
@@ -929,6 +933,8 @@ static const struct venus_resources sc7180_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.4/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sm8250_freq_table[] = {
@@ -984,6 +990,8 @@ static const struct venus_resources sm8250_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sc7280_freq_table[] = {
@@ -1046,6 +1054,8 @@ static const struct venus_resources sc7280_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct of_device_id venus_dt_match[] = {

-- 
2.47.1


