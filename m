Return-Path: <linux-kernel+bounces-369737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBB9A21F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D1D2826EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D31DD0DE;
	Thu, 17 Oct 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nTQd8n36"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909E1DD0D6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167294; cv=none; b=efsSciKOV2NS70pjYe9aVmN33jeTZG8T/Us1WoNR3raZQevE4JowRP4dNm+GPPmTU8IWxkMScSiNXRdQcegY/HuiWlDfO1OVlI7uwZw3BAxqnUi28GyZZhGYUlXJ9/fiAUPmA2DMCUpcnTjvbB1H0v/IAXhKmwYONYeEOf8Sud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167294; c=relaxed/simple;
	bh=EiEsIa7uzb/EJrDvk09DtCg4aPtoR/JNxYMIeuY2138=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7jA9VFCt/NYKZ8hi55VIiJrlCMqTj2j3v9DkT5ssfITrQmXddDZVsD3dwCoa75kDpAq6CVRvaK4SOebZ0BB04kUVabrOUsOJBk0jrpRQ/Gre3q94lrPPxJ25p53fvtxlCRFLAFmijy0zSXoFaX097lho21bijmC4YXPn0KTJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nTQd8n36; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so2822405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729167289; x=1729772089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ9MubZQbPmIWw0TP/sAI/QCOBR9Sgwv17kzjyNhAvM=;
        b=nTQd8n36+3BUH0rACFIvX8Ls5LLlyScj3fBhSIoF55WL1rsNiD85m804yY3IQOJnsv
         CqNJoUSVGcbYgGri+DTboLfUtJlv6GzZe1UD7VYCpKMDtF1BOUe/iGaXqIiSnr4LB+dR
         ezav6dpJqakoDuAAlOULxWAujy6Wn5t9On0SYZQVoJjVbdlYSrJJpFmricD1Au2bfjHx
         2kMYuEy3rqnhSiJTJug3QSNTpUJlnuURmdzA1oC8H4Yuduj8ip7++zHIXue1TLQLJlBe
         tbDXYTuOk/MkDLnVoB2piAUsiaqTEI8nLkeh09+NWlJRAeZ/qNAEwKvCzXnaaCJzZ38n
         qQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729167289; x=1729772089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZ9MubZQbPmIWw0TP/sAI/QCOBR9Sgwv17kzjyNhAvM=;
        b=gOS7rKdbbZ6p+BnkGrulO+CzWxNrzhdyDq5eWSnnnNpIdBp58WXm20cd8Sbp6Ivzwh
         0rwnpIXvCfSC/Kl2nNWhvkwrKSgojXR7dGgTx77bMv3ZmzXDvPtYIdbUcAfcD1kWjRAW
         izmmLE77CxFyl1j3+sWWFAzY7wWfU3sC4bJJYgYB+7uC5VkOo5d2QDrhH1y51gEa6Sdr
         kcgW7uTI3NJ/vSQI84itWpvCmyoiyKCVDasJ0ne580e1PutrdJ45bV4uUFYKu4B5a+1b
         WrFJEPwdjxt1Wqivmjct1Ox3u9ltORJ9tHx6GBMMJlHHQTjmWgOzHzcS/76A13m8wc3Y
         XJtg==
X-Forwarded-Encrypted: i=1; AJvYcCVrLHWpVe9JdmMODUbilqBWizmWCBkdxFU61KnNSUoyBq5xtPG2YZxpeHMOjfcfgOmLZeJN8yjMY4dt3s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOY65KZSifzq+3ozpGTIn3QHzckMneQfJriY9uKDv9Fd9LUXB3
	BRjI+XjJx5LLSP8bNtkacL8PLlhO0dD0QHg7v7XqIuRkLVb+qWLq1TtngaiuLbU=
X-Google-Smtp-Source: AGHT+IE6TUfYPXsAbNZ+/l4g2e1jNYJVBi4RJpfuHlxC/fWasy6zFuXt9VgRiltQrBxozp7XjaFZZw==
X-Received: by 2002:a5d:5192:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d86bb6740mr4289221f8f.7.1729167289470;
        Thu, 17 Oct 2024 05:14:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87b5dsm7057299f8f.40.2024.10.17.05.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:14:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: max730x: use devres to shrink and simplify code
Date: Thu, 17 Oct 2024 14:14:47 +0200
Message-ID: <20241017121447.73754-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use managed variants of gpiochip_add_data() and mutex_init() to drop a
label and lose a couple LOC.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-max730x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
index 701795b9d329..e688c13c8cc3 100644
--- a/drivers/gpio/gpio-max730x.c
+++ b/drivers/gpio/gpio-max730x.c
@@ -165,7 +165,10 @@ int __max730x_probe(struct max7301 *ts)
 
 	pdata = dev_get_platdata(dev);
 
-	mutex_init(&ts->lock);
+	ret = devm_mutex_init(ts->dev, &ts->lock);
+	if (ret)
+		return ret;
+
 	dev_set_drvdata(dev, ts);
 
 	/* Power up the chip and disable IRQ output */
@@ -206,17 +209,11 @@ int __max730x_probe(struct max7301 *ts)
 			int offset = (i - 1) * 4 + j;
 			ret = max7301_direction_input(&ts->chip, offset);
 			if (ret)
-				goto exit_destroy;
+				return ret;
 		}
 	}
 
-	ret = gpiochip_add_data(&ts->chip, ts);
-	if (!ret)
-		return ret;
-
-exit_destroy:
-	mutex_destroy(&ts->lock);
-	return ret;
+	return devm_gpiochip_add_data(ts->dev, &ts->chip, ts);
 }
 EXPORT_SYMBOL_GPL(__max730x_probe);
 
@@ -226,8 +223,6 @@ void __max730x_remove(struct device *dev)
 
 	/* Power down the chip and disable IRQ output */
 	ts->write(dev, 0x04, 0x00);
-	gpiochip_remove(&ts->chip);
-	mutex_destroy(&ts->lock);
 }
 EXPORT_SYMBOL_GPL(__max730x_remove);
 
-- 
2.43.0


