Return-Path: <linux-kernel+bounces-285388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF5950CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431E71C23824
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7711A4F02;
	Tue, 13 Aug 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RoYTUhmi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5E19D8AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576080; cv=none; b=mqAK7hVTz9OKZwO0CgZsJskqwdgb4X5+du6f/JW9csOyyyFeajnsxfMCDmtDjQ0Qp+7Lw2jkT4WHOglk2wOwfRB78GZbRcN4pTr0Fc1AZqF9GMAi4KplOY0kvlaHWZT3UfLa/odTOvFx/jYVXaF7iy0AaEZn8aRko5KVibGgd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576080; c=relaxed/simple;
	bh=tCTZNvks5Dji/DPwbWp4D+2JRZzPE8RQGWlJqbCRBro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFSAd2jJtrPTlRDXpS1IYFNjWKpFqKXITxYUiPHFp7hpRwfKjCtSf55Ls1uLFZZjIFh2UU69pDFSLY19ld1QVAT0ajtPiKv6Q4oc3Czv/9I7piSzw7Umy6uK4jMqvD+qyK8XdQ/EdPgI/SX1nASxoyfjOuzkXd5r2h8JAao20cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RoYTUhmi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928cso41131635e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576077; x=1724180877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fucHxJDb4WTy1/fQWLrG2cUypxevB2ecHl2m670aBzg=;
        b=RoYTUhmiqUcHo8W1aqKF2+V6jXj59xGfzBUipTmZ4nQz2sZdQ0Rb2v3QEmRA3SXQRh
         3z1pR+gfl+GawQMpnWJ0RtveY4Pq4Ad/yPu4flYpIE7a0Zaspck2rcTFe2G5ulN5dCxH
         5M+O1bubwoTwGDpFkR7bxUiWazN19mp7dvRhsKESTz8H0J8ohVgsknesxMYolND0G6Zx
         Nwm2HZ3P677jrOPd2weR7gLY3QBMDQJheFzFLGHo8MF5sCHaM8DojPOedGZR5KGvcLGW
         LV/cY0mM2WnibzqF3xbcNg1m/2HvdqTA5d+KmVqUM081VsoCaRPNQMJBWOKzrirCrwhF
         XlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576077; x=1724180877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fucHxJDb4WTy1/fQWLrG2cUypxevB2ecHl2m670aBzg=;
        b=fwncvDME77AH6ywn5J7zyd2d3jua/4ID0OtBsoC5OOcGLDihvpWY6hrQy3PZVZYN6m
         JVgPSS2mRpGPYudFLhOBk9/zcF7xiMU/AKAj7ZBThSROv8hghGah5RW6Or/GD8K3krMC
         LtKYnepDRWFnH1NLF+8Vs8q/SMCclibPKpHMI9NqxZ8DNHHpdtrD5aG67UXRl3y5o4Up
         dbTfAyIluQy3oW6W02F6dvobx6TujQ42+Opo5GSoRUqK5AZ8JNOAchdRjvIuFvG4Ozi7
         MUB5YFbvRWVotApyj23P5L8gYmmr3d9qsDLb+BVqjdi3OjjQwIQomX4DC003pSMqozp0
         rfgw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEQOE/kHt6vypHIjfK2dIJyIB124UtEvLeWAV6e9UyRk2RNBJIDwklVQiidP4+oOyOO2XF81BWvM+zJc9y6uwKyuoOloY1c5xsGso
X-Gm-Message-State: AOJu0YxFiU+OuMWwn/qca3SfNw6GLzej+t2+YEhkjiy8NM44mEjoRpR+
	OCX66R53EtrWr7Uai49j+XZH2R7p362ti3fbgtZuSyfXRu7WCjWtS8qa5xPlbME=
X-Google-Smtp-Source: AGHT+IFTP18Ooy0kSjMn6g0+8tTiFH/zU/vjmiHh0vzWvZVyA8mCxrmn/32VyAcijblo13De+va+vg==
X-Received: by 2002:a05:600c:34c4:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-429dd268d25mr2897265e9.37.1723576077196;
        Tue, 13 Aug 2024 12:07:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffb1esm149147985e9.5.2024.08.13.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:07:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH] power: sequencing: request the WLAN enable GPIO as-is
Date: Tue, 13 Aug 2024 21:07:50 +0200
Message-ID: <20240813190751.155035-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the WCN module is powered up before linux boots and the ath11k driver
probes at the same time as the power sequencing driver, we may end up
driving the wlan-enable GPIO low in the latter, breaking the start-up of
the WLAN module. Request the wlan-enable GPIO as-is so that if the WLAN
module is already starting/started, we leave it alone.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 42dacfda745e..d786cbf1b2cd 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -283,7 +283,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 				     "Failed to get the Bluetooth enable GPIO\n");
 
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_OUT_LOW);
+						 GPIOD_ASIS);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
-- 
2.43.0


