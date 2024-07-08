Return-Path: <linux-kernel+bounces-244635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D792A72F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB6D1F2110D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23D146D6D;
	Mon,  8 Jul 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBQC9k50"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582B145FED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455748; cv=none; b=exTXwbm7z9k+usSZFKXRP7vQQMwNmzSDdd2krAsoujY1vG3m1MwpyEtjt8mI8QgmSsx/DbnDi6XawfvHqhBk3HP29Vcw/cvhPULqC2+xbWJq0C7pLGk6xsOJytjsK588LQ4a+06vre5sR91GXTLlgX7P+N5n8GBUZtiN6XRv+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455748; c=relaxed/simple;
	bh=Kb4uD9b3Bqo07piU1hPIoxI9IclEtM1sO7/x460nUdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef6ZqasPvEpLs6JCLN36MuELaf5nEc2gNmtciROGROuE4IocSpOg34WKrO+tk11ZDB5I+mbfhWvIoEr0F/zLW4Xmb9w0nyNOmTtyPxCtqEkbs7g55MtybjdMC87HV5FbcNMDzlwlFyxrfBvFBcIhUuyMqUauLw8zUpJlYH5VXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBQC9k50; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso29568325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720455746; x=1721060546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SK/XJxm6s7NT4IUsZERmOXrFSWjVcKdHe6ZMonvKwM=;
        b=VBQC9k50PeKAm9eTG4YIPyo78icOgl4QZRoT/usEgfJ5VwtWPjQUU5ljGxKMVMGhd5
         h/qhBtlf+LQudH4FCu6TvKh3Q7ux6O5pBhe25LKRHW08rTeZaBtBrZsJW4Khhq3RZfLb
         FT3qFC9rXqAU8ncfB6wKxIV6JITb0YBeNUFqgXcQObX2oFa4D6gCWc5k9cTRInaaE2q4
         WlpMaQ3vUS8dPGZFlrkedPfKrf8Q6fbWpDU+lxxnDUkaGAT1TEqE6WAPm4U1hZH/0ptE
         /BxY/hobHW66Yxw4x2tTcESwiYD2QjUosCMwF9sfDyWp9ARqxKs2eM7x+nMW1k3UQarc
         im6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455746; x=1721060546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SK/XJxm6s7NT4IUsZERmOXrFSWjVcKdHe6ZMonvKwM=;
        b=mV9WlmVOHvY2B83k/E+tNZi8pKFpheQzTOAAiVswvC/t2VT3NcLj9WdEnNVdxolN9E
         2lQJNzpYYEsqUZrmyNiTegVLAkIZpnI1uvJhq5z7Tpf8Icb+gjRxg8IaBWUrlNSwgemB
         qzou2gv0u5BMT/MuGmAPyBikfBiTNypWT3qzfUOtG28VVt1WRhPvdJ5ndC2oOqyn0MFn
         biywkP5bQVhor5AYwPMq73dck0tK6KYNZCo6HA03oJiucqawPdxzgNC7csf3VTqp+GIq
         /63nxLN5J2cPF1d5Jxn6QlDNvFv2sFprlw0R6erkKZg6UrGI/PiSeD3aFtL2Leno5Y29
         G0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWjdWqfy+Am1KNX7eIHZ3Gx4lGrSNWpF4LEjyGha9uyBCxagUn7S9LHYl8gxV2GmNAg3K+kevHx/wdvxMxLfQ/sF4QQhtrnNQsqy37I
X-Gm-Message-State: AOJu0YwFfflakNBwt2GO76cYoU42Rh3GEtMWt775DQ0wN+QtlYAFgywy
	vb7+RDuUDv9pqATOQLt+d8SQ9ZU7mHpRQnrqKKfFVgPwOF15z/Iyh2PNSrUcfl4=
X-Google-Smtp-Source: AGHT+IEI6Ya/+5e6ZDEl1UbGIv9OioEdW7NMFi+xRROfoN8e1S4TKdfbKmC4pzXgJ46cY+4nad1RXA==
X-Received: by 2002:a05:600c:6c51:b0:426:51e8:5192 with SMTP id 5b1f17b1804b1-426709fac0bmr393605e9.41.1720455745669;
        Mon, 08 Jul 2024 09:22:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:d237:f5ca:52b6:108c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0b6bsm4466875e9.3.2024.07.08.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:22:25 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Jul 2024 18:22:09 +0200
Subject: [PATCH 1/2] soc: qcom: pd_mapper: Add X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-x1e80100-pd-mapper-v1-1-854386af4cf5@linaro.org>
References: <20240708-x1e80100-pd-mapper-v1-0-854386af4cf5@linaro.org>
In-Reply-To: <20240708-x1e80100-pd-mapper-v1-0-854386af4cf5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

X1E80100 has the same protection domains as SM8550, except that MPSS is
missing. Add it to the in-kernel pd-mapper to avoid having to run the
daemon in userspace for charging and audio functionality.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index a4c007080665..ff6aa3e521bd 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -517,6 +517,15 @@ static const struct qcom_pdm_domain_data *sm8550_domains[] = {
 	NULL,
 };
 
+static const struct qcom_pdm_domain_data *x1e80100_domains[] = {
+	&adsp_audio_pd,
+	&adsp_root_pd,
+	&adsp_charger_pd,
+	&adsp_sensor_pd,
+	&cdsp_root_pd,
+	NULL,
+};
+
 static const struct of_device_id qcom_pdm_domains[] = {
 	{ .compatible = "qcom,apq8064", .data = NULL, },
 	{ .compatible = "qcom,apq8074", .data = NULL, },
@@ -545,6 +554,7 @@ static const struct of_device_id qcom_pdm_domains[] = {
 	{ .compatible = "qcom,sm8450", .data = sm8350_domains, },
 	{ .compatible = "qcom,sm8550", .data = sm8550_domains, },
 	{ .compatible = "qcom,sm8650", .data = sm8550_domains, },
+	{ .compatible = "qcom,x1e80100", .data = x1e80100_domains, },
 	{},
 };
 

-- 
2.44.1


