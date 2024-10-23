Return-Path: <linux-kernel+bounces-378105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56F9ACB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765C51C214EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264831B6556;
	Wed, 23 Oct 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bi1jmQbS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A51459F6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690790; cv=none; b=GVIMxgFw4VYry5yWVNndQBPoKyfwdUmbPQa7Zp4764p3zUexAwI/1Ww0wRR2ZBPziDjfj+4r2YQ0xwmdZgFgWduOPQQcJtxE13G/ZSCkhR+jULwXFMriFMZpWJH4+0Yx7aI+gxMnaACPp4a/RxcXBSZ5opaccWzLFQDVUYkTL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690790; c=relaxed/simple;
	bh=utKFdkdjq0xMRyp+lW25/4LBehAW3zy6wl4Q0VbobbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZGBSpmzpWZf2E/vscjZlcO9RSLZeX2n5VspzHqRhgzy6BSzFjLlRJKsagMd5mrtrrb5/tMpB8oZ6VL0nO1KRkQpQtzvlY+25ijcZKFAxQDwcWU6oM5+TXKAsQvqoq6hhArfv6GfbJ3IZkPWCE00l6UvJ5vXiYxFbawotnqscdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bi1jmQbS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314b316495so66360715e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729690786; x=1730295586; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUlJoqDYE70A1gpRbWu72Eu6LvCFd2GVUQe1MqOiVh4=;
        b=Bi1jmQbSl5+PJZ4eCKiV87PNu5xGFJWRuk5qiJOe7PazwttXnmT7KWAyNIEcp07ZQa
         F5mzbf7w7GDAZHbQoBdxQhrpP2ajrLPJkHDw4dtIL8D9/CSxMaT/c/7MxkA7itkUxzXU
         Na7XArHh6XLpDCo/JcYxy4lyH9xB7Swlo8t0dAw6al/2Cb4Rpre/t9O0BqjbWeCQuJ9p
         Y9saUOLeolwfLW7moCCoipNG6hw2bd/5sxHHX48fyOAcngyqWsCMqXI5zOHgUhc2q1k7
         OTzDErlXf6YG8Ty/LdXS5/01FKL3wkVDFa5auBGoGbSmbatHdiyKcX7eej+nqSc20u4n
         vXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690786; x=1730295586;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUlJoqDYE70A1gpRbWu72Eu6LvCFd2GVUQe1MqOiVh4=;
        b=OIVyEFh70GwvaTFRjjRsfjF5SeWhz6o6VW/SxtMhJeLbHHDubjZe+oxS+Ay74OLvWs
         Lr8BWFjFaDaQbMw8CePN56iD0zKfNhdO/wjmU8CXWjmpKpbztnbC45bhLPDmb/JzRLHb
         ywwVgc8ov85qPuJIZwpC1wRIiJLfIgC8SiQweLvcpMEqJT+uIv5QH5CoJTxhL+ik1GWU
         kHzYXUYerBm5OADBftav4PiF6GOa5JwvKf63rMbB01+/Rdx01+MfwMaZAIgq/3W2a0d6
         zw8KrAIZ4xL8JqaCV1tX16/OzuzxTFqSjYYm0IS9EVMjHq7bd+E9srbuoUyKrMKgBXxi
         XilQ==
X-Forwarded-Encrypted: i=1; AJvYcCViLYc6LWysUfapUxgD0qLBSX0p+DReuEq6iqmTyYIzE0S+3MyHid7xsFWeM1FXpdQ8zut22Ep0wroCEnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTTV9p4eNh0Zf+5XWh0aDwT6S80z1iwPNEeCZP+a0yoPZIxgN
	lJf0Wz74kaGbYV/es7f3jC//xWOF2PwdwsTBVY+CsV8W7JRR/Kz77BiNcN0mISU=
X-Google-Smtp-Source: AGHT+IExswePHkNE0dR4iXJ9chlIEUNAaME1pWtSUYeDKO2T2oUNoJmlM9/XGeRksrNxlUpMxXvZzw==
X-Received: by 2002:a05:600c:1d27:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-43184189bf9mr22925705e9.26.1729690785563;
        Wed, 23 Oct 2024 06:39:45 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ae36sm8949860f8f.43.2024.10.23.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:39:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 15:39:40 +0200
Subject: [PATCH] iio: gyro: bmg160_core: remove trailing tab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-gyro-bmg160_core-remove-trailing-tab-v1-1-9343c7dc4110@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJv8GGcC/x3NQQrCMBBG4auUWTuQxCLEq4hI0vzGAZvIpJRK6
 d0NLr/Nezs1qKDRddhJsUqTWjrsaaDpFUoGS+omZ9xojTuzSOX81cpxzvZiHlNVsGKuK3jRIG8
 pmZcQ2XpvxgTE5EE991E8Zfuvbvfj+AFbEbIXegAAAA==
X-Change-ID: 20241023-iio-gyro-bmg160_core-remove-trailing-tab-19904deebd9e
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Remove trailing tab

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/gyro/bmg160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 10728d5ccae398d15c1d51e0380306042675d5c0..9ae03631090a4ac68ffab92726ee8b8e9c1bb401 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -444,7 +444,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 
 static int bmg160_get_bw(struct bmg160_data *data, int *val)
 {
-	struct device *dev = regmap_get_device(data->regmap);	
+	struct device *dev = regmap_get_device(data->regmap);
 	int i;
 	unsigned int bw_bits;
 	int ret;

---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241023-iio-gyro-bmg160_core-remove-trailing-tab-19904deebd9e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


