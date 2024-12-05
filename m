Return-Path: <linux-kernel+bounces-433195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E389E54FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ACF166967
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF1217F54;
	Thu,  5 Dec 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r+XJP+7Q"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981421773D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400384; cv=none; b=Pt7YGHwZW8QorKjYUnTAOSjcVvAcZ7aAcU0+kWm7GUZujkZTxe1rH0Mx8aJmKmYahA8Ju5RNvboKancySFuWFNCo5LXjoBLWLQF/r+LSHCFK3mxyWmCvxkfQub3Re/QMpogxOIwWJ/3XrW00I6AJnqIT/kCxxuz9AFoD12vBclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400384; c=relaxed/simple;
	bh=Bn5nh3l4ebh5/olUofQ4qdBb2ptYnUXgTMoMswxG7Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvqsLy3sUfHtiTniup4y43e/HsR8MHrdWmMO/34+C6bKzx+iD5AZPNFE4aGzWh9BchM9Xn/P3G5aXxAUeeR+ymbKAeXy02lfrS8N1mk6HroyECI5FAz9LItCR0Y1itBWHTF4pFT4izS0xuxgbD5QWfBbc4XP8kS9t/jRneybVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r+XJP+7Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a2033562so8464945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400380; x=1734005180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUEfRaEMpC37FH4e73tDnuIDcsomn+OI0n1MlB9szUo=;
        b=r+XJP+7QXzi2npInt0NWAwuYM2oUIaBnB6FjrkJYZvmRk31ygCtrV7k/BeeJUO4EfC
         rXixwztz7T7Y8nFZvY6d+RlzvAVtw/B8TIfyIk5KbkfHFf5uBdzr7zr+F88N8XiauQwJ
         RQioPk5T7pptwxQTQBn2blsxdiutb1oyffqqNgGhFwhpYmmdnwAllBZyMf9kt1U9OsS3
         DS1E/oNP9WAdmDwwlgIeLi0m5PCpz4enbYlQpkepTWIbF36ApTD04Y100NbvqbzeRRpp
         LZcREr+70eRGJie6ToPLPM2VpbqnyetpuFThN7Vt6Cfmoax4qKr3hnQ5blcXR5s98kGk
         7Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400380; x=1734005180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUEfRaEMpC37FH4e73tDnuIDcsomn+OI0n1MlB9szUo=;
        b=UnvO5tLwOmc/0roFJllhNwHTH+zSwSlf76y0bTFeUqjlHfrsle8ssjFhbk0XKEh1ZD
         0CcbjadizXb8kuetYdIURoQFF2AsPm7HiMSskFL+UY4c9LENQlqsuxs2Uoh5A0YIFhMd
         EH0FvfRsVqG12goqewl34b8uEf+VMzOfv9yW+REzsQ9dtVVc6HGaF6hn9yhXXU2jgYSU
         fiWfFM79E4QNs5OyNR+Lro/sGLwLGe5c8liZm0hEhaChBqZ5oYzf8K6/EcYV8yev7HHa
         1b84Vj+dXY+1dJ+0PKq4/ceKmTnkFtMnnEkihq4xBfE9ZE/VmJ788M3OyDgwRnKURFbm
         4LIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV83Uaz6cZk0TW/yz98Iiyryg/AvhUdrVhxKGcHyxgvWv5wuR5cgRWbYzz8s+tlFEfPGnGISyaCBFpAed8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKN0so2ax5J1ACrn4xV+cVklARlVhUB/aX7h2Cit+CQCeceLC8
	x1JEI+7xKILrlRcC2kwl7QgiJazlFN1m7ddNGpsXv3S1yTgnG89yADcaPECAWvQ=
X-Gm-Gg: ASbGnctywLQH+PrLHsPC55wHV4Jnwm7/qgOPn5Unn39U7aMzponvZkoFfQB5+Kv7fNx
	j+AIWr5nkpqLVGiYMUcMafz+8EMjS84RPLM2Xb41n2nk+DMIgXIx0jHJbuNOeIb7SjFJjSvahMa
	MR0piDMIjf2KfANOEHgrxwr3nl2ngIMN3afUYd+jfOMa8Jzh6ukFv5qvJQTmX2RGLn+JsHBB+it
	f5tXcZUWK7sW4sWgodnTHPFj3w986IKpcxn8XGuTDZ4o+c5
X-Google-Smtp-Source: AGHT+IF+ZQJT8y1BDmiiQQKVW9pOPfo74S02/fDg2OSwbblovWA/gnmYx8QoRpzq3stAqcTA8YOZ3A==
X-Received: by 2002:a5d:5f45:0:b0:385:fa26:f0d8 with SMTP id ffacd0b85a97d-385fd3f20b9mr7586700f8f.8.1733400379667;
        Thu, 05 Dec 2024 04:06:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm21934095e9.35.2024.12.05.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:06:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andrew Davis <afd@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH v2 2/2] gpio: omap: save two lines by using devm_clk_get_prepared()
Date: Thu,  5 Dec 2024 13:06:10 +0100
Message-ID: <20241205120610.40644-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205120610.40644-1-brgl@bgdev.pl>
References: <20241205120610.40644-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We can drop the else branch if we get the clock already prepared using
the relevant helper.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 54c4bfdccf568..57d299d5d0b16 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1449,13 +1449,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (bank->dbck_flag) {
-		bank->dbck = devm_clk_get(dev, "dbclk");
+		bank->dbck = devm_clk_get_prepared(dev, "dbclk");
 		if (IS_ERR(bank->dbck)) {
 			dev_err(dev,
 				"Could not get gpio dbck. Disable debounce\n");
 			bank->dbck_flag = false;
-		} else {
-			clk_prepare(bank->dbck);
 		}
 	}
 
-- 
2.45.2


