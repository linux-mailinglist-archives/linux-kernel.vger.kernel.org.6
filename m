Return-Path: <linux-kernel+bounces-205628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5568FFE44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9274281763
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D715CD46;
	Fri,  7 Jun 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w4m3BL4B"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1515B57C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749894; cv=none; b=hqtgW5+zpJ5+ALqLklkyOGLmD5nZQUlblZ3Bz4Yy6nx24a4KZz5ha7OF3GrLJrwKautacC0KeUUrO6wfDqeG8n/vbOikE0Q+o/U8uVUxYxshVGkUiSu9/eAiNz0drPLG7TCKonTJKPEUdMpueZOIYAKM9VijoSlGzsOMc5rZSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749894; c=relaxed/simple;
	bh=pYHQOtcajlYkO2UvuypDcCFMuwwUrbjcEVKx/JUgZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFj++1/yNOETgPD9bmglVLMU/Aab7Q1vF9gHypf0oqanxLM2CwyqwZFT/Gn+p0QYeuIZQQIDmCIhoUqmjsV6GLBZBX4O64hFNEmOhwR+CWvZSaWvjHjdCltteHyXk8yr2Ggvv/hOcu8vvThc3j9iJQ/07GPWGBfqih+ykkd20uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w4m3BL4B; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35e5604abdcso1862004f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717749891; x=1718354691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ12BO1Q3zqF+jbfOVF1AOWg2ZgELy6bEhZ4o0FIEbs=;
        b=w4m3BL4BfRhRcDleFpxxX/fntOvM5UPXs+rb21CDZIXGZ7DjTUurRHp+by1mahPdRO
         gmt3uC/XD1eB7iXwp8YhiTUiYI9amKO38XPoRAfqem7JTvCfGOQ6AXNMDztygIF9a0PY
         YhEsAtVETWdgkkm1oWQ4IffNqsrTeQgYks91lu4sbZa61Sv8F8R6xNCyC9GrdU5giW0l
         Vy1Tx/Nr6BBnU3IC/POAsJuio6FPU0QjO31YDy8ls9DNFuZdgjp/BCbb8Q6i6bqWFP+0
         4cDC4Q+x6eqOfi8+wFXwOKfUzk/q9YtqVkMUYE6KJCtP3hYoThPoUKOK7U6Nz+4OOhoQ
         mSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749891; x=1718354691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ12BO1Q3zqF+jbfOVF1AOWg2ZgELy6bEhZ4o0FIEbs=;
        b=qNNz8gxEPI/n0ElQld+BjyU6UvT6y2hrVSP1oGQOln+zEwDCtfKy3+q3I+yo31gdyM
         SlFTiuFD88+b+w+PTN9mBhYa2fATdreMipB9BnJRic9/w9JU2RMqdX4+YGiIxkvN4tMz
         ZmHH0iMzgZtbZbefCmExbf9zrXtyhywrE72GWtBKlrh8d3BtI9xSoQWxjg3UejB/6AVZ
         8WgW3Qm5qIoFeONbmLTqVbA+UCgliMaLRVkkqIgGOQg5VvOEKyJG47XoEvuBte0SZJRV
         hNW7sWcrWQ1FAZrYMl9nYJHBnurZ0gtevFJv7VFdmADdIomUU2pCvNXmmrJI5S3YGU/b
         yStQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPkODTVsugrFHDefJ8icKfEf2sd2vHC81/FxFHyDyQ6gUy23oc1gMJUdME/PJMqS15FCk/keT6bEAR6eY280hWwPgoaVFchD9GEgG
X-Gm-Message-State: AOJu0Yw4pxKY25XD8cf9z6d4u4NZJ7cZPZ53VVZlIz+MYUeHs79CUWTR
	kzsowK4JgRF4VepTj1OXDtQvzewBeKO9gD03Yh/pJ6z14wksunvAY1E3kzw58SVQXLMj5ENEAX6
	VmLg=
X-Google-Smtp-Source: AGHT+IGh+kuwHiLuK1bBWArmsRsE8afQG4h3QaPIej4FO6gC44YuXramv8tXWjYamNgw2BeRjMBf3g==
X-Received: by 2002:a5d:6d05:0:b0:351:ce05:7a33 with SMTP id ffacd0b85a97d-35efea5f084mr2365877f8f.24.1717749891224;
        Fri, 07 Jun 2024 01:44:51 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29df7sm3489453f8f.15.2024.06.07.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:44:50 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pwm: Make pwm_request_from_chip() private to the core
Date: Fri,  7 Jun 2024 10:44:17 +0200
Message-ID: <20240607084416.897777-8-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=pYHQOtcajlYkO2UvuypDcCFMuwwUrbjcEVKx/JUgZzA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYshtQF5fPNcDJuPUg0vnYZs3ok++9svfh1Uqo mX/jnRq9OKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmLIbQAKCRCPgPtYfRL+ Tk9XB/9zXuL9wQM2r1dDBlKHUbAlzqxNseCpsdYJQ/3XPf3g3SZi98SghVxrfer0cZIT7i27Q+f vqlOJTkg5J+EsS04l+IWs28TWnwQDFQY3vrD73nlfZETANSqWtfHXLs7dRy6WK8GCi/b+EzCIQ1 oFD40pBPwZJReo4CTtggqIpBsiHXoJ8CQB164ERUe8uRDEOTvqe6XEh14lzdEFlwf/Df8Bveakj 2adlrP3rG0/OjNDG9HS2FZ6OxhX0hYq8QTUohTgAzqKhFH9wxQMnTKEjKOCI6AlrlKolfFQZKRX N0U7mdlPhEFR7mlubRCeRxPAkf7AlaEsxBWS/CoWhTv0vKVH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The last user of this function outside of core.c is gone, so it can be
made static.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  |  8 +++-----
 include/linux/pwm.h | 12 ------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 18574857641e..76969d5052af 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -394,9 +394,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
  * chip. A negative error code is returned if the index is not valid for the
  * specified PWM chip or if the PWM device cannot be requested.
  */
-struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-					 unsigned int index,
-					 const char *label)
+static struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
+						unsigned int index,
+						const char *label)
 {
 	struct pwm_device *pwm;
 	int err;
@@ -414,8 +414,6 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 	mutex_unlock(&pwm_lock);
 	return pwm;
 }
-EXPORT_SYMBOL_GPL(pwm_request_from_chip);
-
 
 struct pwm_device *
 of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..3ac1a04acc0e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -407,10 +407,6 @@ void pwmchip_remove(struct pwm_chip *chip);
 int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
 #define devm_pwmchip_add(dev, chip) __devm_pwmchip_add(dev, chip, THIS_MODULE)
 
-struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-					 unsigned int index,
-					 const char *label);
-
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *chip,
 		const struct of_phandle_args *args);
 struct pwm_device *of_pwm_single_xlate(struct pwm_chip *chip,
@@ -505,14 +501,6 @@ static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
 	return -EINVAL;
 }
 
-static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-						       unsigned int index,
-						       const char *label)
-{
-	might_sleep();
-	return ERR_PTR(-ENODEV);
-}
-
 static inline struct pwm_device *pwm_get(struct device *dev,
 					 const char *consumer)
 {
-- 
2.43.0


