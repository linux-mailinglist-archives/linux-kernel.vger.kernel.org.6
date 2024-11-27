Return-Path: <linux-kernel+bounces-422950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BE19DA055
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAE81663F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA28481CD;
	Wed, 27 Nov 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7j7oq/0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566B1DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671255; cv=none; b=tCmiYNhA/Pf3YazQSN0i8HWdg7UZS3ekpFqdHJoKwx1Yh/+LE8I8X5L5QiLQl0k8/6qDLuNAB8oXqLd9wHgYZM6PKiFqyFh2KRAf+LMaE/lFskqqDwIo3XJrvUPbALpowJL+35O7PeJwTZFON3765PVDp+EkSEixoT3Qnxvst8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671255; c=relaxed/simple;
	bh=n/Zg82OIAdQ1zSRL1nM0L3fiC40R4jKjjiYiNFRjz48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hsf1BeN00nXMBh1esukqm0404ZIlaQRP61mkEh2WqOT4DazvIQnl0JCGSCZ3UHeUjlNm6zNyqjE8axgKqkhu3xpl/RE5Ww8p0MAbuBXHtyGV7Slb1cJhLllKG8zq35yiK57UCWDa3uD3d3QLIokapKCfu4mLttB9oLdWNZNhojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L7j7oq/0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso26183475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732671252; x=1733276052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEBpGyzD06mzAtSx+cExNdQcs2BIj/GrC5hry0530ds=;
        b=L7j7oq/0NC45asyJ6OFtiWYizy2Md+0R0vTc1jpX4EWk/Od0SvFstKX3pSlsOLKyQt
         8ZLfRsMuV8zifAN8tKv7+15gTcYakxDz6XTmiZlV3zg19Po+9gWKVwTdlIyBB4iNCDxL
         z+3UwuFM3OISGIF1qOYDCXWFiNc6DxRKzvmmBOEg6HHABUVWlpdy69kAIiWCke0osVl4
         O81AqexDemjE+e+YGYdpinNsa7xsSaAPRdQRAl1SRo+n9MkChU1pBmYScKsUhK8wIchC
         kwA4MpxhmXsbbuqSCzoQRhdBwsLzGNHK1qnX1eFVG/YHaBerRyJiTOGCq+zIJUFWp1Wg
         Updw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732671252; x=1733276052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEBpGyzD06mzAtSx+cExNdQcs2BIj/GrC5hry0530ds=;
        b=PYghM4Hwq6QqNKFLPOesHw+5GHpk+awHqwTtqLYkvmekx6U4QmkR7yBfqEQ6RZEKe7
         v013JEZoRCiCzI/kUybuEwEyCnKLlcHoeyl7UR72gSze8LKtmgEP0FQcTIgOdDkC77kn
         0fllWWwtoNbx9+oBCuy4pQn00FDj02lHCpPGkz9+1HjzLjs/NOlE17LoabFJwVO7r272
         XL/RhN575fWjalglULouSlDjQZKp2PGGQarqfNIiuAxr7kL1a8jJZRdFQ4jiXhhCGB25
         2fVDnwlC70/47dhmoZp9OU0WXv9bq1FsQxFPTNW5F/QwDb50gOZDI366P+B55hsVfXWQ
         cJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUp0EJ8Dp3+sJEdrw+9RCJt14X60V32QL1oPOzdxucqCof0QExBpneKnseUK/6xTxiLO5F2Lc9w6jMac0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJGqXgQWyRw/mFBxBllwQFTdTyjjECI5Ux+MEkZZE0b9U2GsB
	9MTB1T74CB4B/UVrua9ynCuz+eqFk7bUeWEEQ1ZktM1To2/xoqkU5HYqJjJLc78=
X-Gm-Gg: ASbGnctJPLSWzNKOi0jDRBaXRn8H13y+k2yPM7p042HRDVgNu+6HOuI8l1NzLh8SaTE
	KtdWgFpAU9UKhpiVToL/gGTIacyaVZFv0k35tZ4sVrbR1roi2WiHbkFqg79lifEmizqxavt5JEh
	idwSWjgaJg0it7aad7cs1x3tMb3pnw2UaTrJdqE81VPPfYFUhcgX8choTh9znN6u9fffz0xdJSz
	a+9tv7eqqZ0q3LbDf7O+1VP89lXLcFFmUVKIt8iHbfSHH0m+aLEyj3VGQU=
X-Google-Smtp-Source: AGHT+IE5xTm7ROTDuYuNzFluAr2l+MF3IkEv+n/JLAXU+hq8JkCM3MR+EuvaGqZCy0XPE4SfoOyW2A==
X-Received: by 2002:a05:6000:4819:b0:382:464e:1ab4 with SMTP id ffacd0b85a97d-385c6eb850bmr754283f8f.3.1732671252341;
        Tue, 26 Nov 2024 17:34:12 -0800 (PST)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc42b3sm14848641f8f.68.2024.11.26.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:34:12 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 27 Nov 2024 01:34:05 +0000
Subject: [PATCH 2/3] media: venus: Populate video encoder/decoder nodename
 entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-2-99c16f266b46@linaro.org>
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
In-Reply-To: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
 quic_dikshita@quicinc.com, konradybcio@kernel.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
index 28fe31b8251cc0efacf43d63cb2296cf8a9c052e..af874e20d01ca572a76af003630b465cdb5b5948 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -639,6 +639,8 @@ static const struct venus_resources msm8916_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl msm8996_freq_table[] = {
@@ -848,6 +850,8 @@ static const struct venus_resources sdm845_res_v2 = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.2/venus.mbn",
+	.dec_nodename = "video-core0",
+	.enc_nodename = "video-core1",
 };
 
 static const struct freq_tbl sc7180_freq_table[] = {
@@ -896,6 +900,8 @@ static const struct venus_resources sc7180_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.4/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sm8250_freq_table[] = {
@@ -951,6 +957,8 @@ static const struct venus_resources sm8250_res = {
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct freq_tbl sc7280_freq_table[] = {
@@ -1013,6 +1021,8 @@ static const struct venus_resources sc7280_res = {
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
 };
 
 static const struct of_device_id venus_dt_match[] = {

-- 
2.47.0


