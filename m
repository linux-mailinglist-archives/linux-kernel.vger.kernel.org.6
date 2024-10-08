Return-Path: <linux-kernel+bounces-355560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE899540A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE6B24733
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B651E0DF8;
	Tue,  8 Oct 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U2G5rSeu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B41E04A9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403669; cv=none; b=eX8j44NCCxctlzU28Jhy6F1wqq8FfEv2gOF3oGB5X4YVKh3sOwFogH7U5LFHY6Cma2owpsMknOagD6Iv2rOzQ8oDYUHzOPOpZRbzYsIOxKRzshmjlqthA5rqUBAiot6OuP/EznnNzCxwhKvOsHrW8qkWwNUWDAV+41kzrsXxBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403669; c=relaxed/simple;
	bh=lhQuXcRpY2zHnZo6m9Qxj7Tw4rIjXk5y2hUFVH+Dy1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAdMJpQjdhs1xmSAlPdD1cKIYOvomXeY/Yi+7Zas69oaujGSHSKI5jPb4MmxTn8mejmLkIpuGWkQxwv5hsSWwxwmLwqNNtKYow3UrQzimaGud/9goMpgzqxZyJJHngb5rpo7a91nUpXxRUV2d5CtkxR+8QNhVY1lbrSCWQmFH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U2G5rSeu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so54534925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728403666; x=1729008466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lC1VrxWqIvFqRnkCBrcDqdtLVemDPB60EJSOvaq1Zpc=;
        b=U2G5rSeut+uj2qcUz0jKI7/PO9e+SnvQNh4q85gtxvCYL8ojwsDfm4CUZHrComWYU4
         OykMnSwe0KFev6bX6jlm08Nq5iYwQeS5ExraBxDfQw/wzBWnu1pTJ5jENGWRaJJD4tQp
         ryL5hyRzaWawo14WqAv4iH+xPrGymxbLAJFG7xOICXf+4lLyTXfy8RoHcLZjQNQhi+xb
         077lfhJDMAgIuSd8kwWumDr6aJZPBxOCojVeClh1BmyxJCW5Mk0mrzy3ykti+fEtbaMd
         RLwvUajemkllvG9rX64duecI9f0UvTV9RjzL5g3IeVVNVg43i8aGfHZNglm65O3fqJQK
         FqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403666; x=1729008466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC1VrxWqIvFqRnkCBrcDqdtLVemDPB60EJSOvaq1Zpc=;
        b=et0DZ8glV1LEssNsvCXpYkZTJ/E6lgpiZTl1W+bqATRw+XSkpld4LGTLpTaS73cjKy
         SjM7ZFcUD1u2oj29wg0B0gu8ZkXnG+cLUv3PV4RbJqugYH9ZcCvrLvZr5qQ+tQ4EYdg7
         F4PYwqT627q0stL40yUC+tl8k7r/bjoi0J5FAn6d89LAFMCVF0Xg8GHDr5k1ISGeAfm2
         VpBO6o7Wil/FbpoBCG1tvaRlJIlAe1UFdqnuzTE3qfhr2OFqZ/yNrNhSW+tXRZgxtbmC
         WybE3BO7atT8XrngeH1aCq0aT2DVMAqPeODyVCjZctvLgp79xov6uYKNKpuZg48GtHPb
         GG3g==
X-Gm-Message-State: AOJu0YxOXBWjvCVF1l6/wPITqJ02kL56PA8RPZmUONmdFW0PjH34upaU
	Gtx6/dFn/CF2SEuetaQn4tKDGjYSuHzu7FfhuPWgbEFtoGkVLWOySLSYrMonXQIw5PdW4N16f57
	19ks=
X-Google-Smtp-Source: AGHT+IFXn9rIZ7Zyl5lyazE5zgUqEmf9anBv84CvL08pKjCuiZVMxUzf/36RMadg3qcFPXnGSeKGIA==
X-Received: by 2002:a05:600c:1e1d:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42f93d5f286mr43325985e9.20.1728403665924;
        Tue, 08 Oct 2024 09:07:45 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86a20537sm131509375e9.15.2024.10.08.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:07:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Oct 2024 18:07:03 +0200
Subject: [PATCH v2 3/3] regulator: core: remove machine init callback from
 config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-regulator-ignored-data-v2-3-d1251e0ee507@baylibre.com>
References: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
In-Reply-To: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=lhQuXcRpY2zHnZo6m9Qxj7Tw4rIjXk5y2hUFVH+Dy1o=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnBVjMeuDhe5M14Gpc1xxDstYhvTFU2hM3oHNQ2
 8Rl9NHrNAyJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZwVYzAAKCRDm/A8cN/La
 hbiWD/9x32PlqF7Bk9HQ6byyM6fvBKt/e0o5VrmJ+u+fWaXKUsqqDrk/0KHkhqCWEfoAkFMREiw
 sllDQ4NM1uAm1NDDgjSAAunGyMjtDCxAiigW7HdS1fyEizfN2u9r2VUbxZIxNLPMBr1qrvZQkRY
 wXod9iHgJl/lyZgjZ/1dzQwCXvvQAQqAv6oBEFzWXMGCBZAHFzZ4/gjunwaE8Y/nY1lnBkPTxMo
 OPjUCeyhfa+0v3p4Wyz1sdDoMgT/IYiV1vnKyDPjtNOXPaJ+FAYe+mofbaaUfMOzhQaYmNCHuf5
 cBPnkQX5lkP1i5baqhMWP6irevJXqKEnqwnLHb7SaGPyqKO4Ht9nbnApGfgHXW2P+G0q7JJX5hv
 l3IhchPu5hbudqvnrCyhyU/PF6V1ni0IEPg/CF7pUD1ST8MqWuFIVsy3vN/SuVQ6y+eJ4UEtCZj
 EN5vVZEzqszvZhAOMykPbMfbZyLpqrPXTd1A/Z2YEZaZK1JMhG/GBOFpnSNxlcIBLdu0XjJWpT9
 0+mCda/HChZVaQSnNjSpD/Rch1XGpdu33/Eq5uP8sgU7tTSah7QhJLCfpBU3AMSov8gFxw5kaln
 cKkIVQmw62IUzp/ZT3AWanMQbZUjs1Fio4LbHogmU9v7T54HQni8x7HkiGpz8BNu6yQmjQxCAJt
 AoBZneUbsKWAfqw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The machine specific regulator_init() appears to be unused.
It does not allow a lot of interaction with the regulator framework,
since nothing from the framework is passed along (desc, config,
etc ...)

Machine specific init may also be done with the added init_cb() in
the regulator description, so remove regulator_init().

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/regulator/core.c          | 7 -------
 include/linux/regulator/machine.h | 3 +--
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f8b5d596f59d..e830230c3f39 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5775,13 +5775,6 @@ regulator_register(struct device *dev,
 		resolved_early = true;
 	}
 
-	/* perform any regulator specific init */
-	if (init_data && init_data->regulator_init) {
-		ret = init_data->regulator_init(rdev->reg_data);
-		if (ret < 0)
-			goto wash;
-	}
-
 	if (config->ena_gpiod) {
 		ret = regulator_ena_gpio_request(rdev, config);
 		if (ret != 0) {
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 0cd76d264727..d0d700ff337a 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -285,8 +285,7 @@ struct regulator_init_data {
 	int num_consumer_supplies;
 	struct regulator_consumer_supply *consumer_supplies;
 
-	/* optional regulator machine specific init */
-	int (*regulator_init)(void *driver_data);
+	/* optional regulator machine specific data */
 	void *driver_data;	/* core does not touch this */
 };
 

-- 
2.45.2


