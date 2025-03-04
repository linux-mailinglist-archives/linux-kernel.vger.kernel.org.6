Return-Path: <linux-kernel+bounces-544210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620BA4DEC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EDF188D489
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D041204F87;
	Tue,  4 Mar 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLIMuJvg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EC2046BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093639; cv=none; b=iLrA/ZbAwUezg4AZwP5PeJDLMKMeLpv/BT7CA0viowsyslLlE6Hjfnp7OHYrpcW6xIn92iQiqbNyJv//tBW3sy6xdXQNZn7FeCyP3Ln8CUf/EvA3dR/39dSvc9Dhn8uSRVQwE6F1WaGQUiUJpS/oODuzlSZiGk+Mo64+b4qO2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093639; c=relaxed/simple;
	bh=eVAsey3JxdTzcp2dytGoCKkDVWArrUAtGBxSzsk01Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwDt4ZwAukKtjcybUfI8xdNy1t7XJdMMPbFPVZOjJAFZLnv+Yi2Kzm9Ry5y8LydYgzRVjnhH0dWAWvbFHSrUb/EfnwS16vHW7c1WmNHccOAUzJMxnYDmqSKC118OAz91iur6Xdo1J8uUVegChDOfH7S648X8w07YCCd7IDvPb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLIMuJvg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f69e71c8so2336431f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741093636; x=1741698436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuQPD4WHO0oVNRv+mxZovyBbMl3mHwOGIxiQAqnpkUE=;
        b=NLIMuJvgH+cc55I8VqOQYO6oHtM8h5SDDLFlxoZOFgmYOBBKC79kivJqLebm5TH2jY
         tPju7WC3wlIuNFhE0cAp75EtmRNBiqXNXBhrgg/XdhdzxAPuSZHcgv6EgBbAzR2KiALp
         OCqX64qZ2wSOwFtdqYXzwIGPZUBIKYvyDnKUv9l1r+xA4ZdTc9X4SYyRmjMezSNBNB4b
         bmOTk3UO4bX0+Z5f4ukZaCuA2cF/iFr24+p2+9neZimHvWjV7+sY/US+bh0JnhL650jD
         lQmYfWJajC2CJ+NpWaYi82EAmasWeKM5eZAsEQgrdyI5Hkyopnm9uzS+gY8LJoNxi6MO
         O5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093636; x=1741698436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuQPD4WHO0oVNRv+mxZovyBbMl3mHwOGIxiQAqnpkUE=;
        b=uodHgn9uHL7KmhFywUS4wpzlnvePxmo09l53mimShnsb5jjdzh1AgJBJ5vKLgEOQUd
         55mJHDOaaSrIhFU4PSoCg5uTAwKiEzB2YrgTnAOeLxXWW7lKXvxwD5aZDAQK1+I7VYn1
         d82+qPOnhnSgH49xR8HyTUFGx9vPrjG16/LVH3tI/Ias2n/s0sfDkrK94JePj/C+6lbM
         z7T8O0Qpwq/Pq2JG+qJZzjk2T7SZZa6RsG7Ky0y23aeNKjogwjSvNjmgyVXSKBFl7F0J
         L4Jc2FaoGUwRgCtzwX2+o1Oc3eG/Skaue7ItnydFDnZia/HePGaq2buqHipEWebTWFfv
         8vBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXGpOk0KQyMlB3SOZUxh+ZEI9lNWBDWZ/7SZkqi/KcTBEaUUigvtKnyswVzyURSd6/diDwp2ksiatyVB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv9QFuEI7UI4lqF5fICLbx8r0h6jc8hw31poRNLXFCABI/cdu
	n4KUEYbbuyMwSxTVvi53m3oBOOqR1t5ttvtA19sBg3mia2kllkeMlcvzd1dVc1I=
X-Gm-Gg: ASbGncuza1EO9fj1SW+c7H9dJmOjZugs9zAslcN4v6v9lRfJxKkP/cqdyXo8RfAAxQn
	H2onBFpNRT2QW7xH5KBYNqjlPyLjz74rYxU0sm4O7OPqbwHP6ibAx0IcfRTcL6T2B8mO2TvdY1H
	1tUxMwoVlqmmXlHvECcpVCsj3IY9HFQ88WEU8RZKfpGbuFzqpa7Z1DIkSmBnXJf3a+ImSYU9x2s
	wW0pgeuS/GhE+2YKgYur+rU0GQDQmzNvbQFtXcTKtcIDqgDKWQQx+Inzb+2g6HmRp1LfPFAE/Ze
	+hvy+Ml4paPU/qILuit2LtPIH16LVrWG791kJI+I3vetGCXu8jUOiOcRgWYrwgKPTh7Lk+VDJrQ
	a2JNYgw==
X-Google-Smtp-Source: AGHT+IFHR8q/L6pe4BnBXKTY1Ga7eFmSDtcmLdUHWlgfJfHC/2yz9FYNMzKiIzY6WUs6i/rWq/DfjA==
X-Received: by 2002:a05:6000:2a81:b0:38f:2c10:da1e with SMTP id ffacd0b85a97d-3911561959fmr1840760f8f.27.1741093636048;
        Tue, 04 Mar 2025 05:07:16 -0800 (PST)
Received: from [127.0.1.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17401715f8f.44.2025.03.04.05.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:07:15 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 04 Mar 2025 13:07:11 +0000
Subject: [PATCH 5/8] media: venus: core: Add SM8350 resource struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-5-279c7ea55493@linaro.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15-dev-33ea6

From: Konrad Dybcio <konradybcio@kernel.org>

Add SM8350 configuration data and related compatible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230731-topic-8280_venus-v1-5-8c8bbe1983a5@linaro.org
[ johan: rebase on 6.9-rc1; convert vcodec_pmdomains ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
[ bod: added static video encoder/decoder desciptors ]
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 93e5b9e1f70cc..dbce635f9fa45 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1012,6 +1012,46 @@ static const struct venus_resources sm8250_res = {
 	.enc_nodename = "video-encoder",
 };
 
+static const struct reg_val sm8350_reg_preset[] = {
+	{ 0xb0088, 0, 0x11 },
+};
+
+static const struct venus_resources sm8350_res = {
+	.freq_tbl = sm8250_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(sm8250_freq_table),
+	.reg_tbl = sm8350_reg_preset,
+	.reg_tbl_size = ARRAY_SIZE(sm8350_reg_preset),
+	.bw_tbl_enc = sm8250_bw_table_enc,
+	.bw_tbl_enc_size = ARRAY_SIZE(sm8250_bw_table_enc),
+	.bw_tbl_dec = sm8250_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8250_bw_table_dec),
+	.clks = { "core", "iface" },
+	.clks_num = 2,
+	.resets = { "core" },
+	.resets_num = 1,
+	.vcodec0_clks = { "vcodec0_core" },
+	.vcodec_clks_num = 1,
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
+	.vcodec_pmdomains_num = 2,
+	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.vcodec_num = 1,
+	.max_load = 7833600, /* 7680x4320@60fps */
+	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2,
+	.num_vpp_pipes = 4,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.dma_mask = GENMASK(31, 29) - 1,
+	.cp_start = 0,
+	.cp_size = 0x25800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
+	.fwname = "qcom/vpu-2.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
+};
+
 static const struct freq_tbl sc7280_freq_table[] = {
 	{ 0, 460000000 },
 	{ 0, 424000000 },
@@ -1086,6 +1126,7 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res },
 	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res },
+	{ .compatible = "qcom,sm8350-venus", .data = &sm8350_res },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);

-- 
2.47.2


