Return-Path: <linux-kernel+bounces-204186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E98FE58B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30FC1C229DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D6195F38;
	Thu,  6 Jun 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="za1MHZIB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E922195B2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673774; cv=none; b=NO/Lps0YLgDIVpR9TNg2Pd8TBsdr1qLS+hKBNP7Rkj3avhF2iyugQw9LXStv7YiLnUAfJq7LPKtJzFFmTIove5rAZirfj9Ygrbljmmalw8ENd/Wj+oCAXsm2F8iEPd0vpsiRrBsq3CNyhgL4Oinx5yJb1L0J+Enfnx+OD5ph3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673774; c=relaxed/simple;
	bh=836LbL/aePNRW0HFxVtuyVyeX07tYHWWbwxRLU++CbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Db3zK/PgGF6qqtcKMYqpdz59/b+QTp1xNdVXnJBrmdjsEOA1m8w3N4dayWgIVAgBSsxZrvsU8igR2GBiBL7oSlzfA4yA/wzaa73u5XOhJhwcqfZrJhX9g/wBkGzhfkN9ucTSYkBR0IH00R3kV/fkvFhP4U87TGrd+lCvyGknxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=za1MHZIB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a6985ab58so497603a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717673771; x=1718278571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loZHqDm8kINRNyYefPKVZGA6IUrwIO9fG8uZ/m6eZKM=;
        b=za1MHZIBS7y1xuxxQEdMIfid5epZlR8ZLyci602IKjKByVY7djDwpGBcWQ7Lbo/cwN
         NAYq600DEawz/sJ12mtn9G7gFSJEnyJiCY/p8kq9Oxyt4No5aIqYfjwTfR0ctd55Y+an
         GDe1SSJEnvkmvqvNPlVpe3QdMK6zdwfVkSOV9u47CcZAIeM9BonQfSQ7OPgluGLT4YRe
         DlVkAF5bJRAhfiwZratux4I8YG3vrY2MOCoICQS4SsHJRQ6pe8+xuY7F+gZx0HSEy3ox
         i1RJmenhh7BzlLAl5kNhBulAPSpHWrwF4mRLipxMKxLKI6oMQVFg6cbWlnXWR9PunQr0
         IcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717673771; x=1718278571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loZHqDm8kINRNyYefPKVZGA6IUrwIO9fG8uZ/m6eZKM=;
        b=Rd3TKYr3QN6QSmUQ8bkOLforZsZSghEJciVs4YgLvV2gTVKTiKXjkJad02CkjPeo8N
         9FsZCMIy+QPDcz7wVO4H2hqZv6ciL6/C/C+FbalQhAkHo366BEZcetHawRVCq/n8qc68
         rWNLV5y2yLuFVbKoSrr2uwj63ewUFsVK8EaqEwkPbx6ezY7PFC7COqKELQCl1ftZ+Ib+
         zoH5rbr0EFuYjeBpcLJe32eWCSHnwzPt4kx44RY3NXk9+zOI5v6IlTn+PnkpO+bunUGZ
         2Q86QH1SdxvOJaFwQHTMfOFwdneKuoEJIJP8NuT/gmTP7tmBlOZKjYGIK0Fherce2QPa
         Y/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUYeYB3U6abKAcPYUHafBeUVFzRs9l1+bCfhbkm4ps1IyVPpj6Tysi5rvs3uqNhCU4NU6DC1WjDM+dDBvgYysuhsj4nDiWHbFDiKDTJ
X-Gm-Message-State: AOJu0YxtThIqoG0ZJUmPZ5RiPFekdWu7OH+4TBqxlOVsrP11GJd+8hXX
	hDrIU7MXS5cm7T37DhilZofidD0TmjrQRrM7wpsrkPr1YxZkx9uirxpo+9lB4h4=
X-Google-Smtp-Source: AGHT+IHjqqdfwmZhFGWcU5/JtZSNSUKoz5xOrkBqV/yd3DfVS2jWpCaPOT2LQVY60HfIKPr1P3R6uQ==
X-Received: by 2002:a50:d61b:0:b0:57a:22b1:b02c with SMTP id 4fb4d7f45d1cf-57a8bc9a178mr4683626a12.27.1717673771563;
        Thu, 06 Jun 2024 04:36:11 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581c05sm84014866b.7.2024.06.06.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 04:36:11 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 06 Jun 2024 13:36:04 +0200
Subject: [PATCH v4 5/5] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-rb1_gpu-v4-5-4bc0c19da4af@linaro.org>
References: <20240606-topic-rb1_gpu-v4-0-4bc0c19da4af@linaro.org>
In-Reply-To: <20240606-topic-rb1_gpu-v4-0-4bc0c19da4af@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717673761; l=915;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=836LbL/aePNRW0HFxVtuyVyeX07tYHWWbwxRLU++CbI=;
 b=RhzJDw+hairhy/yq1ZYOGYxYGjnX3/H9iekx82yl6hPvCrHqS/Gxcf4zNcgNp9N3xWgsgmiJE
 dL7v0+LGON9B1BrpmG8XZ7zq+LKLEt3nEjUUrbve0vtCRmpo6KkiXei
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).

[1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index bb5191422660..acecef743941 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -199,6 +199,14 @@ &gpi_dma0 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/qcm2290/a702_zap.mbn";
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.45.2


