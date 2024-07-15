Return-Path: <linux-kernel+bounces-252495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53299313E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75785B2367C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4EA18C336;
	Mon, 15 Jul 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kClym+ZD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7E18A921
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045770; cv=none; b=pps4BboylkubazUSL+mP+8VoboqMc8qRCMm2qd6itfXjAmSQ/YdoBYtftsg0QTRWwuwK4eF5j03zcQ/z5mdecmPd4c6JLjj+5fvP10Z5noDsB5pDDApUAXqOxqzraOp4YO+D+amLmbbIG933kz0MZfVutn0DvMazwd2YbpYoPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045770; c=relaxed/simple;
	bh=us5vFbV1oXrFQ1IRmJFjWmuvUJ7Mz2t9/i5d0K/nxWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfWvM4H8N7wFQUhg0yki70INi98x+fN7JY5Rt1ycZbiIuJ1IA6NqA3SxTnwV3QSaDLHC1M12MzVCFIrggRpMnk62OkNGM3Ki+gvoHkbLsUfOythva1EOmHTHODhH8DZSq3e9xqsPyBgFys8FxokCcnYvcoEg5U+quoHn0Od4SSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kClym+ZD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so28062745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721045766; x=1721650566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4zewyPEhlNFFIG7IewHHr+zZpf0Zw7H1PjOS7/qftA=;
        b=kClym+ZDk2qJRRmPpHLGp01d73dPEUrnBzUe10NhIWj1PTHpD2+JUj6L6o+aKXkdQI
         iTv9chTm18X1y4P5pc01TDu2dd/c4Uh5279v2RC2KMU0Bi9B73Q2rl9O2uSo5imMX0Uj
         kLMBjCMlFw6O0+pVs/ImgcYZvvk4enNMwtiX1R9Y/cD6pQCFaX0gR4UpuhHAZthbMV0n
         D7IiBvn+yjxSnli/aE+tZ8SyaoJ71HnF5/q6SyVaFVkkRZ6oGqZmwELHflfelsm+vM2D
         e3M74eaf95kDjspy01yQBLOUF7E9+77wT0Zm2fJiHlhbUZBztFoTbDwtGXx5PfBGspyO
         gtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045766; x=1721650566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4zewyPEhlNFFIG7IewHHr+zZpf0Zw7H1PjOS7/qftA=;
        b=KY2CZ5+Rr6nSRk9BFriQnLmeBdKA5jrhZpVSOLqHLpHUCiGZ7FcYJBFIf+tZjGL4bD
         Mw51DcEL83eatnv1s5JyBQdik/TjsuojlqUQGXUWkGl3JdLCHIhwSBiUSEAFUkEMGXuH
         2vROX7shQemKyClurUCUUz9sN8Q1L3wpsX4Ts0HC0NsH4Rx5D27U14bvUH6QlB77BTXG
         7vmIIFLbRdkfub/f1lk0tF+r/aXwu6ihaq4wHMQ7ZuVmiDquixdiPWofq1EIvTyxyxLp
         W7lkE6KZn1+ypOy5QE4xMZfd9thSCsDO055EIMZ+rKaF1qwVoOplvbUpXq7DIGoQHlFp
         cGbw==
X-Forwarded-Encrypted: i=1; AJvYcCX41kYSBQNF/itBIAiJ9BGm46XSGqQz6u8XO0KmjFLuWsPs5RLI8eg7rEMWLtYpBtIcJA7/xnWfklSF82zSc58Y1Y/5U5z9wyp9nrhQ
X-Gm-Message-State: AOJu0YwjXM7eTRhr89U7kGHBsz2oKZBHthB5YcADjemWmTppvCatmA/5
	Jg9aF3Ht04ndZuKp9nWfKYj01hnXRb53kkeMLrankIqb+LctQcmtYZzRd/fdzfI=
X-Google-Smtp-Source: AGHT+IE1hOML28f+XraJzEd8SFOSIj91LonNL45CkfZTFsChgS0t1o51jq4Yctj5be3mCBmPsTXBdQ==
X-Received: by 2002:adf:ffcd:0:b0:367:9791:2939 with SMTP id ffacd0b85a97d-367cea6b804mr11785800f8f.21.1721045766633;
        Mon, 15 Jul 2024 05:16:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:886b:1a3a:7569:3d95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680d9771aasm6369201f8f.0.2024.07.15.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:16:06 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Jul 2024 14:15:38 +0200
Subject: [PATCH v2 2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.

The panel should be handled through the samsung-atna33xc20 driver for
correct power up timings. Otherwise the backlight does not work correctly.

We have existing users of this panel through the generic "edp-panel"
compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
partially in that configuration: It works after boot but once the screen
gets disabled it does not turn on again until after reboot. It behaves the
same way with the default "conservative" timings, so we might as well drop
the configuration from the panel-edp driver. That way, users with old DTBs
will get a warning and can move to the new driver.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3a574a9b46e7..d2d682385e89 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 
-	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
-
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),

-- 
2.44.1


