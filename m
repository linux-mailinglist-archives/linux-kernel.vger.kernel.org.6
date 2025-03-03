Return-Path: <linux-kernel+bounces-541643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E987AA4BF92
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3543E3BA7F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472520E012;
	Mon,  3 Mar 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GR2fYYdF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8920D4EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002797; cv=none; b=l4e1u15pFtQx+V603AkLMV9u7Mg6FHIqfvlnNxlA8JJGjH1mdBBCzJcecSVX3FqJSo68YpKqYFVVm9ROxfzC2mx4fjtw3tCZO7ujDLlqkzR8avBxvUbccZUn+7+omB/kDMCwlI/TCHnF1qc87c7N+PrxpBSISBWIpHV4goLc1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002797; c=relaxed/simple;
	bh=p7hkdHG3Uk3MNaKmI5KRSyrO6nMtHV/TriUgNA5ZLkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcSPYyke6bEnCOop+z0zRBUix/flPhjQjyHwf1Yag4KiB6tp19O/qnb4ppzq28fuE9c3vJ6ofzreXACLM6DRVAOMwl1QWrlP5FDk+s7EwgLgz9LgWDYe4X2KrykuWE2Mjl8CI8WRkRNA6BgkVUHeWcb+xTVgSu+QXsMVcWn3CYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GR2fYYdF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e57c81d5d0so503808a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002794; x=1741607594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egcF/0fSfpEIM9jKlb06PQtyWEHsWxmve3UKG8E7nkQ=;
        b=GR2fYYdFVQ8cWKiQEgcWR3zWYB6YYoUR0uCifv6xlrL7rMy0cGHfd8b4lnEOqMWMbS
         WzyDYhsT8FcKRADZhvh4Kx5dhKHdG0MMBC1nRbtaszCG1+Br/RseS6NNqSsaGDsiNKnB
         IzC4oGZTSwPsjBTmP/84paPJXyQVTUu8DMWq5TLMWtxFPwa2iGzGt27VoBt3f6f68vsD
         B+VWl4l8LsXxQMdlXmvdaJOgr9Hcn99BpmkJ67gqi8ybWdRPBi0CtsyJNmqsAdZ1NgPs
         IT77d7PPXQTZxdNQYSX0iI1VCohQMlcKO7Bpz5w8Rmy7PwjxC2VLIy7bZIhgAStisJe6
         eiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002794; x=1741607594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egcF/0fSfpEIM9jKlb06PQtyWEHsWxmve3UKG8E7nkQ=;
        b=sG4vBPohb58OFRr74cTZLdUZ6JbO4wfKUj8iQ76OCWv2yWmqoMHm+4jMEko3tMTFlL
         1BUghy+1X2rEizTo843KlKj9DslBALpOCVCK67IpvIirv/Khmyttd/LYWtgB3F+EJPTu
         goJeNB6XORGMCGQrncKtW7/Opf+T55NPtdyYqzA1abhfvKwhrjyaJrqThvRlCXXq7T7f
         sH0vmI63kS+xHfxdENCkY8l2Hp7+ThHMiWHdF9aCFCVWytC5XHV2af7ClXv125Dl/X6i
         14Yw6gnntFiDUZZCt+PNosf6m8WRa+WkqOQM0ClwPqElobgEdCXpHw20Rd19+BOLieBm
         83iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAEuuK7VjginYKFcDTYA4agsIrSO+ZNK19IBUiO3aRu0dJn/WWUOMG4ST91yN7Vfwv7FfdaGsLGRy4/i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OfVbLoJKoqTH5uphUUB/Erq7laXTvH6Do8Ba4/SsaddKk7z/
	eaGZBMfXm11LauL0zaa91/cm78+jdM9o7BrgOv4vtQoOT4YjedOmCPZhpOetzRs=
X-Gm-Gg: ASbGncuTIXprPUhAgPAoS+Pr+JLUW6lapoNJSPtgK4p/W+BlGsGswPMPpexZXFj69w9
	7iKkqP4KALJRcv6zjVs+UHUFP+2FK9WZVDy6qrc9TsFjsMlLuFGFpD89heN2Dt4iUxWpRvPqEBK
	ZkQnb74QgmHf3gBdJuon8xIPX9Y5S1+IRNjQJW2sUQ0//dEu6MHII9ByHgHBMtzWotqFiIQSyAq
	u2lpVt6MnPhf9Oouai8n24o7JUMI3LZe2Uqf8/8/e6q62KuHb2a1j0/JDkD+gR6okaM90VmQ3jm
	wl+rOkP8O8mDToXfUE3XoRid/g87pQGzM8GAIBinEYk=
X-Google-Smtp-Source: AGHT+IEn2yl+zGSi0lGbr7GuumDLDA2KQKipUpCk7GYI/B361NHJGLE4LlExFZMYijY48JcoBPBUsg==
X-Received: by 2002:a05:6402:350e:b0:5e4:92ca:34d0 with SMTP id 4fb4d7f45d1cf-5e4d6b4bb17mr36004144a12.20.1741002793949;
        Mon, 03 Mar 2025 03:53:13 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1de83fa49sm86833866b.158.2025.03.03.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:53:13 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 03 Mar 2025 13:52:52 +0200
Subject: [PATCH v3 3/3] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-3-62703c0ab76a@linaro.org>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=p7hkdHG3Uk3MNaKmI5KRSyrO6nMtHV/TriUgNA5ZLkc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxZgiyqHWf1haD9iRgMsk0Qyq6WO/KweHfvpfz
 xnu5vHbyv6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8WYIgAKCRAbX0TJAJUV
 VjQJD/wP9bczE8rW6CvDOvpJ+sOXg5GTtEI66RM3uKAPtmvc8+Soxy7rJchtalzl21sjnm5MoUH
 cgTwF1YrC/eq8jUEMozsg95EO2PBAa/H364bFDQN0a/EvUrjliKxytPRJu88qNZU8BRE3xfgm9+
 vvu7mnVg1HVnyp0BWberU7hwOHL8uUXe1XcIuGLS1J+g4Ug3ZPHRip+Cpw1BKYZJrHeGZDOKx+f
 bct27pyLFk7z0JKMCkxByvQf3RdPpFYYUZC9rROEOosJxf/ce/f3gbreCqwj4WoYpzt+vOHBIMV
 rMZ6dfk2/UUHUudnH/5YHpS2kVo+8e3776TxDMPs6xJYuimIA1aKocK+XsrGMADCgXoMktCLBES
 Z1kNaBOLHjbPYKzNU6DLgtReKI86/z6yhfoTbKNgxw3xMegwo+FAaQhPYyGIJi+GcsbZKoq0HsV
 fjk87QUBjx+dA12MVWLQzRRVdMDwaNLVXm4sx6t4bX4uTUIKV8mlU3NmhCb05uZzcrry55L/0hR
 oUw8xUAuJq8CVsiKCRiFdA4W2EXBNwaBsj8EIAKxxHykqf0G/B6VngjiIh9fOaFgt93FWlRmiV7
 2wE1ixoR7eYwPKszb5nKJcf1uWtQIXU8uzsWQqWJRDVh8X/BnPWMhm9rtgztO2oRxQf8cW0Carq
 SaUVL5zmGZTrO5Q==
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
index 0b6310184988c299d82ee7181982c03d306407a4..4f2a178e3d265a2cc88e651d3e2ca6ae3dfac2e2 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -462,7 +462,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+	min_period = div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[0]) - 1),
 			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
@@ -483,7 +483,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 */
 
 	for (i = 0; i < pwm_resolution_count; i++) {
-		resolution = 1 << pwm_resolution_arr[i];
+		resolution = (1 << pwm_resolution_arr[i]) - 1;
 		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
 			u64 numerator = period * clk_rate_arr[clk_sel];
 
@@ -1292,7 +1292,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolution) *
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
 						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {

-- 
2.34.1


