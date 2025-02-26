Return-Path: <linux-kernel+bounces-534017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D7A46185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A781884FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4822171C;
	Wed, 26 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJty9foa"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D73221544
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578355; cv=none; b=jLyUUD5QpyjdkmJexkmT4JxhX1DVtJ/zZBpcShdDOiuZ/+n6T8lbHJ49fDY61iT6TU25IFI0NCFFrOIR4+7rGDzSmvEXtM1QbMx0LR+eGfXH5ZkGL0X8L5cdFtnO6EoqEGm5Z1FISujj10ZL1eYF8g+tGxTh6r5huQUVfp7ijMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578355; c=relaxed/simple;
	bh=B6vNRR24vZm7iSTdEc4QXuLRyq/IRPqoeXQGjK0c00E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOmYhLKRtQUpJFPjTaUPym9t2hGvIgJP2xdEEa1Mb7K71VlzlTV0R1JfBud+yvvXvLqja7GOb4mrTD+3IrFji0OaQcgqrLxILzmr5dRHSol2ooMef0+yI2feTmwXPwPB/6EEH86WKKidlbrMWC99EbFpPWnqtirCCuoOZGyFEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJty9foa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abee54ae370so239959166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578352; x=1741183152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=436GsJyLmwRgLe/Pi/bM1GPjpxKDesYcznC8EJvTAV0=;
        b=AJty9foaOFCNTcFISDPOiUln1DzprL/0pvfUnI4hP/loPrclGot4zA3rANemzNkXLW
         At/kJmMf+ASZyzFMurB56acxTTvx4+jG+Yo2oImY7mCAAmCrDhCqgWZYPM7fegBkHpjR
         VVKK7AUNHZ8QHoqRkQhh0V7NREkjgfx7NIIwwHa8S2uQIXCso+u/bIi6yAEoG4wFo077
         lVl+umbE0gC/nOjI0G9MflIyJi1g2LUh+AZ0UnsaQgbSOlzete1zsMYz5QlqKyKkdaRO
         WS98/aBa26lAiPTXX7Lon6MPjiTt6TDMY3LDbk4HHycPkAOnckio8hkF43xbta5UeKTA
         lAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578352; x=1741183152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=436GsJyLmwRgLe/Pi/bM1GPjpxKDesYcznC8EJvTAV0=;
        b=lliVlPNFu7TcmLdxsPLDcSEg3a2bsV4QXz5QMAr4ry66QPQJmJv7baK4qQFaVYRDBY
         lVDsMtW5QkRWGe9pXmeY9oXF8GU+uOYlSaeKLpGkXjQ5QKThQkTIfaeAdBz4slqcubw4
         UIKRyjpBQQnuii4j2J0xOrHcrYYHjswepyR8L7abJKklBuVwiOzP90MyXblMJNttwdJ/
         8OhquUB+2jMxuBCLsQO4MBYExkd7FggEWaDNYc8PG+I6CI2uaysj+25KqoHIOVkj/J07
         zxIaRsdBtuwk+2CzYcDGsB+SqxCcIPjZ7q6oUl+2iJl+0tbYPBLJ8qMr+j8va29o8oNN
         pcQg==
X-Forwarded-Encrypted: i=1; AJvYcCUw5PlA7lYKeVUQq/kvS4pFn43lPYGWPMwqShoRX9592KNgjK8ADA73FtdYwpOlx2hw3xVQzHMSo8a7SUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnI8aHba7xI0Rg4CTjNW2Ugx1+wMjVih0QvghqlS7ig/QHDxE6
	s8TsfKSLYCHm+jzWeDcXfIqjYgJrrdzc0KYebdKer1+k1x6yrpwjiGjzJ0+IUSA=
X-Gm-Gg: ASbGncttG90JcqD4MCiEAJdCDiNyBWl5RRaNW/hES7yUKtX91KfscLEWa+gg6DoYwUz
	+rRwBdsDsR7XOLEU5MutjBpSC+lBgVzAoCGFggWeAc3ZgU+6i7E2LENuTYiceL77dgGyMRnNNIq
	HcuW1laSVZtKl1fHCYfPwqC1ruY5g5sA4zYdJIDh1cmZCpUqis6QSIlNFw0IYQZf9r1chM5GFS/
	OLIuFEzn5yVqlGzSCKW/XlRhoDIpRIo9v6pDm/owB/ye4dyK0eZ+hB8yKAkVqyoY3mERhtWxKPd
	1bW7psekNgwW2h7J1y6kaRSy
X-Google-Smtp-Source: AGHT+IE5ZCJikWYBQYNCfYeCZ7i01fPaQ1YL5PYutRrdkWV8ZfElsYhJmfpfgT7H3II/AP9b0v/4mA==
X-Received: by 2002:a17:907:7706:b0:abb:c7d2:3a65 with SMTP id a640c23a62f3a-abeeef64485mr389483966b.39.1740578351780;
        Wed, 26 Feb 2025 05:59:11 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm335378766b.56.2025.02.26.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:59:11 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 26 Feb 2025 15:58:55 +0200
Subject: [PATCH v2 2/2] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-2-7af5ef5d220b@linaro.org>
References: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org>
In-Reply-To: <20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=B6vNRR24vZm7iSTdEc4QXuLRyq/IRPqoeXQGjK0c00E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnvx4qQlcZWrwEMBg5/sca45Aic4oiGh3wo+wat
 QxqpZiktruJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ78eKgAKCRAbX0TJAJUV
 VpcOD/9avCUtmDTMHZbfSFIgp5PcEQzz734ZCCgByqtIk66s8J7P8Ssk5NGSJ2FdPbW1rnKkd9k
 qUdvQBApJpc6D23MzZURiVTANNCrnK6g/VyPHRPHI3LHwBN6pmgPUzaDQe8zPPqOEouXXToFcxm
 bHGP8OaM+isg2DJyL5+KXRCG1LuMOqFVDOBQT1g9TeMdE1QXwWj4uQfUOL73tAhXaYjXRMiButy
 tPMx9Tk8lDmfpKqJJ3T9BXv0NRkLJLsbhRnEzhWqvcpu1Dpa95OkzfduDzMmD9zkpc+9NmMPhyA
 BBBxRHYNuU6xuIEhTjentojQGNJyN6FSvh4QPF/bZX4QG404U+Hp/vfpZEvaT92IcUtx9sWZB/4
 mdvPjal7XDY1u5hW7HD1d9nfLNvv/v9DPyL7MBYDXcv55JeIabLdQM2oaTQ+wg4HPoqWglAJkIq
 bLIAGRbwuEcYFjbbjPYL28XzWKKYtRUpoU3UZdHVWyet8HpOAtf7M7eSPmAHMHXLzmD7jEnqlRp
 b8b6ijyCibnOMivunZWBbFA34qMVdi+a6+jEYN8YuLHIXs4dNQxq9R8tISx39iKxE5PZ5jzpCSn
 yi0XbiH2/NC/yC2MpdR89E111LpqkptQuElxYqIf78UohQyelGaoqXm9LbwMm9fnDj9nZ1CoMnc
 afCK0DsTY7N4UyQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

When determining the actual best period by looping through all
possible PWM configs, the resolution currently used is based on
bit shift value which is off-by-one above the possible maximum
PWM value allowed.

So subtract one from the resolution before determining the best
period so that the maximum duty cycle requested by the PWM user
won't result in a value above the maximum allowed.

Cc: stable@vger.kernel.org    # 6.4
Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 146cd9b447787bf170310321e939022dfb176e9f..5d8e27e2e7ae71c19637b90cc15eb363c53317d9 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -461,7 +461,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+	min_period = div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[0]) - 1),
 			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
@@ -482,7 +482,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 */
 
 	for (i = 0; i < pwm_resolution_count; i++) {
-		resolution = 1 << pwm_resolution_arr[i];
+		resolution = (1 << pwm_resolution_arr[i]) - 1;
 		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
 			u64 numerator = period * clk_rate_arr[clk_sel];
 
@@ -1291,7 +1291,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolution) *
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
 						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {

-- 
2.34.1


