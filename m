Return-Path: <linux-kernel+bounces-515029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB42A35EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFC31713BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E7266561;
	Fri, 14 Feb 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymAM7X1x"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B193264A95
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539086; cv=none; b=sES+0xEhIG8lTTf2nw4WcFGioKn2HIk86jSEu24JTBZbq4h/8xddn3beTkWHtPe+g91pqOAr+AmSm8jUa4/1ssHFw39g0qTSVyPuA5HBOIwYWJLyXeaVAr+GiEwMK8hjwhH2Z1iY8Rza4wlk7pFUI474Q8+t643TJNPZH7I50K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539086; c=relaxed/simple;
	bh=d16enuUHr2tsjXZlT4oW1ZXn1HEuh8ApCU8a6MrU7bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoaEcz+JDGiynUyFEi/dpjVj/QMdj46o85NH7DkEKH9LRt71HAIPNi2PyzpxaUy6kXlVCdXkKo/con88AxJjo00aRa5R6rVlifIlZg92rZ52813Om53INM4NPmBlGUzUpBxHvXKiJ2FK+POxHq482IYa0qBLBLyi2w9chDK+usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymAM7X1x; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38c5ba0be37so107592f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539083; x=1740143883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WI6/TNYNauOLLkWpwha0LbPDDPCCxmIwr+Pcoxb9Ezo=;
        b=ymAM7X1xvxcY73UAQRU/rT8BRyPGmJ5i8g8zM6mAe39eOpyChE1ZPOHS6pt17swi8g
         JyXhMC6ye+df8b/8ihZzkYlpqtZnDzpFzCUWdyvYQrO+rM2D8Qy723uNrpZYw1P/oPZ7
         raiu8PScXzY8swtJZa5RMhUkYThEPyEwT9lvG2V90KqggqDjOUmwHYXcdqwQCpilUwTo
         RjxYfcgroR+1yUOOGCwCmnuuxGKDwgBYAsmsn6mI3WnV3Sy2Zl7anDSMwJKUNtVZ5irx
         bEw2W1I6Ut+w1elOIDBDCxW6K7ccyvWWx5vRXUEZP4BnNpD3yrKS8wXLWbFDXNXUsukC
         kNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539083; x=1740143883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI6/TNYNauOLLkWpwha0LbPDDPCCxmIwr+Pcoxb9Ezo=;
        b=HHnt9xBIU23vzImuQMZ1IgA6HUaUEhev29kHBF3iDg98BgSRIzrFtHBYDcfH9P4XPP
         evGQ1wBFWDIR4PSeN/1+6WVX8lwVHbtxMxy6k8yVqvjdGle0RxCg7gG8xoGTvLdtpo6d
         JMPnBgnfYU0w0jvSDA/lI+eQROWzoXFO7DIEURDJIIQ/3isWLVQEXbrUQ3CDugQ0mzWj
         JjlvV+cPH1vBDXcjz1LNeeHuhJ3hSqEj48ctOfoAMxYxE4FWioau9u2uUv6yZtbaFqLM
         E6AOL05tYZLgwatWXXKCYr/DtVhP7tYERJvSqwI/7eqsEUdx8qe20hAhvIOyAa53+7UG
         cSDA==
X-Forwarded-Encrypted: i=1; AJvYcCU62CTIUXGQJCYSKQY+g0QAx2lwLIQOm7tv6Eh1y4n+hxJlcgO7Y2qMHSpIIIaWVarSo8ZvramOXXzomzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9KyS6zoBmXhN11fd2rAkpofp95jCxPKPkfNCJfSdbFmRyVSc
	7E64QPskGVnBhrTVKtjeo1bpXcqMFKMf5ZRW6rXt+Xv3NTbIDBpOAV4zOOBrzR0=
X-Gm-Gg: ASbGncv3740NZCMUzwJxOLSj3IUW2WYCS9l9WmTuQaq+6s1xPr5Pzf2HhhQOsww9x3C
	tqZ/yOq3K8YTP0OaM2HGR+xHq8w32sbiRfFcVkELLzQwlJ/3PYuzgmQ1VYhMPbBnq6EZjiwkIb1
	kDhc8Lv8oqf7RYGIvwDzgLRIGIfzvrsM0aEHiCCSdK+Pb2rMO4/M3hWvMS7/VZ8sw0KqZ4dtapY
	85hh+wdDNDa/I1H4a1T2R6IBoNhvMV7MObse89gBqm5Sbeh73kusnY54OS4QftAG3Mq2BYpt/S5
	2fRz/YB/TadtyKTpVNZ3V9XaAd8ZKuA=
X-Google-Smtp-Source: AGHT+IFL1PyC7Gr+eB+jAKZETUep7XKaMZD3nNdLMQxR8ZPDBgf5ouh3/XF1rDv2ZuwsE2CUo4Jr1A==
X-Received: by 2002:a5d:6484:0:b0:38f:2685:8457 with SMTP id ffacd0b85a97d-38f2c5e60e5mr1589269f8f.0.1739539082916;
        Fri, 14 Feb 2025 05:18:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm4607690f8f.77.2025.02.14.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:18:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 14:17:47 +0100
Subject: [PATCH v2 4/4] drm/msm/dsi: Drop unnecessary -ENOMEM message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-cleanups-v2-4-1bec50f37dc1@linaro.org>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
In-Reply-To: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=d16enuUHr2tsjXZlT4oW1ZXn1HEuh8ApCU8a6MrU7bs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr0KCwJWc8DDG4UnvVS1DRfS8YoAu1sErX0eRq
 9XLMHspTXeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69CggAKCRDBN2bmhouD
 1wymD/0XLt6GJCvc0hRmyqQAQeQ2Xl6T5oInv1r89dudN+E6TGz+0kVkW66XvIlulKZ5QbZZeZt
 XLP1rhSZTNo5C4hsYZJ1FXXS6vFbrpiJHMfXtrDAFebnrfp0oGDCaoPfj+2JuCPPh3EId3Fo2pV
 zgKF6maGiUM1mfNUQ/TzH/wRuMKhVM7d/efMHMf/lAtZcRkra4lSoH4slPLQF/iBN1dHa3cIQaJ
 R6pJwOQ501mGT9ovA26GCWVN3a68CfGlgO8q+NQv7ZTcP3/cMEIGmoI5RUUnhfUlf4G886LbPaT
 nLlZUg6neWgVaCkcAYry6hPxjx74KuWlJ+7QIVeumlWICWwCRDNAoMMK2Hx56xG7z/z1RvxSPF/
 ECVYAUoz6x8S8yp4tfSsxN1/o4FQqH1rYX8L/AslqjaUxcog0B+PdIuRmPRrCTBWir2DSJr+IUM
 oVPxb25Dc8eZV+jjjkmXjbkitDNLYwGdEbst4YLnf9vo3u1CphW80Em4SF7Lsgh+rQ57IgWnsRm
 Siweuta9/F+p9n0frosueEF0hVXodaPwyq3iQ7EHaARqq1qDrSFFalI45hxFiMpdq5GlmZPKARq
 fD4AZ1bLjVVQ43zSmqGTq8a5F5AWnRsKF8ZVcyQS2Ym0bQY9b48rsBFMXfBQSTN7bQBuTMITJzV
 P4QTwq+mvFuP70Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Kernel core already prints detailed report about memory allocation
failures, so drivers should not have their own error messages.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 051e26ae1b7f20d47969c3aff4e7fc6234f18d1a..2218d4f0c5130a0b13f428e89aa30ba2921da572 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1910,10 +1910,8 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return dev_err_probe(&pdev->dev, ret, "%s: unable to initialize dsi clks\n", __func__);
 
 	msm_host->rx_buf = devm_kzalloc(&pdev->dev, SZ_4K, GFP_KERNEL);
-	if (!msm_host->rx_buf) {
-		pr_err("%s: alloc rx temp buf failed\n", __func__);
+	if (!msm_host->rx_buf)
 		return -ENOMEM;
-	}
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "byte");
 	if (ret)

-- 
2.43.0


