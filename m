Return-Path: <linux-kernel+bounces-546881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F98A50029
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220C43B501F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342D24EABC;
	Wed,  5 Mar 2025 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLhj82Wi"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0324E4CE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180166; cv=none; b=Ix14KbImyExgR86qb/SojYp6pOBIZq/LIVmGRr/lP7OnGqtGji6ZhWCgSizaSBgz/6DhgG7FtrhE0rBQP2gJsXze2NMhta9GFHMiC10DaN6EaiHS9l36rNrr0pSQ78qc50QBY4XgJiKHYzJXa5SIUp7n+FLUfECaeyatbyR3ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180166; c=relaxed/simple;
	bh=Eq1bUZ4m4TVPmwJacH2hB5Rk4tv+onhgteqnFi1naTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeHGFQJy1pu9PjZfnkGpD8drPLrGaRfUTu8qESIc0HbnWxDQ73OIeXuNaFrFJsUnHX7Gg6ePxa1q59lBrDzr0aXXxdmMKFVXI1DS2Ll1jRZbvIqc/mhDiCe3Eka/rhENYl6tYBG0YtsV16kmX0+BPZYvAQqdCqs/GwIVUVjc1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLhj82Wi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso5817204a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180163; x=1741784963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcNAMtiD9LVF+KKMJbcPRKQCGnvjpmsaBrM/UNlzjhM=;
        b=vLhj82WiNs90VWFXANTm1J2lICOPcC3LknedLmAzuSQH9/HwuyjbxiLveoDPb0zo8O
         YctFGKwuOh8HLJu+pfGM46KDRxQkPKLmbL6KkrgZnOdI7zHbWe7M/gwFwSzE6jyNmeKQ
         QY5f/IRcRsJu5fl4bQHvYn1g4MFs+beKhlB79e8XrHuujBvkJ+tPPjKQoAtzzcJIuGJ+
         e29EZEA3Lf+5bny5MiMwIFBy0LVv9IEulQiMUoc9KZsep8tuK468Xb7VkBf2fL/zPEYB
         fXqQQLgB62sqD47YRmrNK0MwlAxfbhJRsQJErK1/qn5t/EWw+HUgT1Nlb3Lb94n1LSr6
         sGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180163; x=1741784963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcNAMtiD9LVF+KKMJbcPRKQCGnvjpmsaBrM/UNlzjhM=;
        b=SbZTUsNxCUifaOZM8r6IJXOZUYDIvkN9b18BfSMYvAH+p1dgBvVHZBd3HMxNHyDkF6
         XxK5dVuYaGXfzgs87T4wA2T08Qxs4/FE3x3cvRqMOPWClK0b2DNDYxh/6oaeLIKEa4xk
         xAa42n0IfTgQ3piP4mhmjkvOk5YuDMsWF8BBjs/IkrvDFm8E2adO8T+hHWarKuJIjvz3
         YdjFUFB5YckTAY6RlgIWbtViUCPNKBFWD7dq74v+Zi43nq8XBvHvH3P4rbLXbfOdjQbe
         XQeDdiaGxf35Mz5B1eOXHBbcr344K5DVVRtxLucX5Y0HChc4Rs7PeyNlrvOqsNk8so1U
         1vqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6c+eCMgr4u8fSKPXkB6UxxyxcOov5prBCpjtmcW0P8AVkKCaU15Tqg6VTu7IAKrNQFuIg87mOYddbwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrh8jCZ9ji4uGpCiSkwu+465EfJhF7XkP4LU9f3jA1xcTozTOL
	ZPHm6rrQ+OX9Bpa9udvY9jethdj6WTm/MV4RT74sPPm8o9fEz6c9vAqbp8rO5Mk=
X-Gm-Gg: ASbGnct/LZwsOg72ZMtS4e0p+M5OUmSRHr9u891lw1trOGfnTyOS+sByUSAasMoT9vC
	PUf+bQrQJfcIwDVMcp+jMDA5FEAgV+Mmg6kTcwukZAL+VdoCauHLEJpSmzLRZxUbtUSM/TFjf0w
	FeJBG60iiv2nwKWErAHMAg3Fqrat5rb0DnRHMfaxNvvyUnyGrthEV7dnTNxTAmr5Q2XI41Uo9sq
	dEhiNCOFnIViNKm6n9U4HPOO4roTPTyMWxgBdaPv0PkaMzV7wXkWgz1nzuZcpNUhYVJASGSCbTt
	UgBGHS1OG32FqVrkPumrcaA9a+Hd79PP+Ku+s0Z9DE4=
X-Google-Smtp-Source: AGHT+IHufYeDkA/wU9vixBkuUm14Xg3lFP8mtf5G7ytKOT/kHQOq6xbhgMIahE8wZbxor6+EY6TzWw==
X-Received: by 2002:a05:6402:90d:b0:5e0:60ed:f355 with SMTP id 4fb4d7f45d1cf-5e59f3eb5b9mr2725004a12.18.1741180163099;
        Wed, 05 Mar 2025 05:09:23 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm9627341a12.14.2025.03.05.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:09:21 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 05 Mar 2025 15:09:04 +0200
Subject: [PATCH v4 1/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for normal PWMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-1-bfe124a53a9f@linaro.org>
References: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
In-Reply-To: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Eq1bUZ4m4TVPmwJacH2hB5Rk4tv+onhgteqnFi1naTA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnyEz6yxGG4W8W8lfbmr6z6mnETV/rEmvQ8yVgY
 G7BBo+F+nCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8hM+gAKCRAbX0TJAJUV
 VhvGEAChmuA4/EM1mgcYBO47BtE91XKVFccRXrY5LHj0bYO8QYgr7oWwtoYL5gC9Lel4x0kzVK1
 sdEkQrAM1CjwzoBHcWktSt3a17aaj9+asBl0AE3QiEKkXqH4X8K7EYsww/gr+KvOIMMeGSySDEX
 laZE6qIgo+FqWhz0UYEwuBuR5571josV/pGKqCoPgMs/IRhIYljhzf6PFq0l6IWWxMgd/HycHX9
 9KfC25SFrmBzLFZ3upAOs+NY7bKY/r09ia2VSxJ31vkUTimueq1YKBoFCzwpopQQW7pEA3JbI1i
 fSbrtvbvWZecCwF2hnmHa9xe8+Eht6dbD8iNztblsBzYhyFeydoKq2TG8mkHJpBTjzs5Uj7etcb
 Q9QWABD3tQYZnPlRvTGJmcFelgiKWTBoMB91rfwoFB1aSYUZnvZRcIaEFymNOEj+zbfcN5sQJQG
 8Wk8ivm8kslbIjMPD6m5xH69P2F0iXwC3yBkiE1zz8iye3DrWhKK2EJHhFQZ34LatilRxBnO1/L
 61pmisZis4rdJwSyY/rWgGt8OwY753XwfK7zjDa8Zh3V4cDjhvPRg4wXJdHDfBtjv43KX/OpH7I
 zkWUvKBvnpg+KxGBurA6RgC0GDrHMFf+NqbyvUakFPdoOhFTLmYxWOGlo6M0KNY+Plzuhe0jBqt
 zjXITFnjj4atfkA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Ideally, the requested duty cycle should never translate to a PWM
value higher than the selected resolution (PWM size), but currently the
best matched period is never reported back to the PWM consumer, so the
consumer will still be using the requested period which is higher than
the best matched one. This will result in PWM consumer requesting
duty cycle values higher than the allowed PWM value.

For example, a consumer might request a period of 5ms while the best
(closest) period the PWM hardware will do is 4.26ms. For this best
matched resolution, if the selected resolution is 9-bit wide, when
the consumer asks for a duty cycle of 5ms, the PWM value will be 600,
which is outside of what the resolution allows. Similar will happen
if the 6-bit resolution is selected.

Since for these normal PWMs (non Hi-Res), the current implementation is
capping the PWM value at a 9-bit resolution, even when the 6-bit
resolution is selected, the value will be wrapped around to 6-bit value
by the HW internal logic.

Fix the issue by capping the PWM value to the maximum value allowed by
the selected resolution.

Fixes: 7a3350495d9a ("leds: rgb: leds-qcom-lpg: Add support for 6-bit PWM resolution")
Suggested-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4e5c56ded1f0412c9913670699e912b24f3408bd..4454fc6a38480b61916318dd170f3eddc32976d6 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -533,7 +533,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 		max = LPG_RESOLUTION_15BIT - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
 	} else {
-		max = LPG_RESOLUTION_9BIT - 1;
+		max = BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates[chan->clk_sel];
 	}
 

-- 
2.34.1


