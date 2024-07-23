Return-Path: <linux-kernel+bounces-259903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F24939F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927C828339B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFE14F9E4;
	Tue, 23 Jul 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjN/OuZG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B914F9CB;
	Tue, 23 Jul 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733216; cv=none; b=O9ishY0XUFa3up7vZqgepSQue+D8GfRlqd28dxelzSYpDqTF/R9W0x7B9So0gMwE3odnXVy4ux5kwSubfyZ5TIien7WcfzKFokPIy71DLJEt1iQPSdrwvYZ2wzfUX02Yl/v706gHIt3lbx5HOICZcZjyv1sZD0rx2CBEzrltPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733216; c=relaxed/simple;
	bh=/VP364EB4ts+jEbJ8tPULy9KkrE7/dWdaq9sLnzMBh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKwzuYah3olYMrXYmzCZ6caXNDlIgRrljaA/+aocN+huZiRCGyYqGVZi+sta86Sprgiz9dyJ7edXGkenWKbcQqwxCJSZBm4YG+jRcKewyp6Oz3iLvjUmiYko579ShDOG+fYN0G3LzqZpv22alAZURR8ZXeu8D15v9StOmYmwjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjN/OuZG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so38250215e9.2;
        Tue, 23 Jul 2024 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721733213; x=1722338013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StDxslIq6LIFif2h0qWipzvfrvRcZo7bNP0JTSLo/Vg=;
        b=GjN/OuZGqCyoAFjD1HriGXeMV6I2JKwRAEMSQVCu3MMQ6HSxT5BTzYx4kGAM9gqwfD
         QAx5dRaDEpV1KfTHTUc9/m/zxEoYcrWv0dfy9aWJbkzE/SOgmucBYy46bOUfDd5N2S7V
         HC2h0IChm8sFHgilfTdEFP1hgUtTwihNH4yO4XyMVA/iUoO7jKqq+60rPhsYIuQ8gUlP
         iQzx6Od8sh+bXjqMD7DIWZWW5RLgW0PgEiXXq79us7TJsw7wHPEF2mjh1lUEFZU1iNhC
         ZZjn5GcVPyPbjggn9WonxFKLBMlf1lc9LHB6XBbNQu7cTBEnX6rm6fSNijgsi7jIptPd
         6KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721733213; x=1722338013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StDxslIq6LIFif2h0qWipzvfrvRcZo7bNP0JTSLo/Vg=;
        b=SVX8q+nVkSjtcSEZoSNnfPWxmasQCgAkZULYqU7BL2b/6S3CiDkhLxNM1xRS5cAzo7
         i+v9KgFxEuEqYO1LbV3TUZrn0503dlUagVQT7bGWWxZNvfr0N/Bw+myDdb7fbYeH9DpH
         uQ1abydKvMR5RTI5grUL2wNBfn7VQYD/BCVwVqIvpugb9yJev2KoiAk4aljMtoIiY8lj
         +Nf0YueYLA4pGBrPj5Ay4P59nu4V55n26yBQ6slm/UcXwQOqY9oiC+kZIyiS9jV03E1M
         al4NoZMDyMB2sSP6bFwRvQtFCsF5YUlkGvpHpHD6xGk16YulCgXGWqCVNdiaQiNSYxKh
         MPEA==
X-Forwarded-Encrypted: i=1; AJvYcCWxf6BGZXS1QTFE0zWoZHNInNSlWlhqm6aFs6Kf9F/IHexH9g0hC6i5rSFO+7ZowOjfC5FtjiLnv+d8ASPyq5ilAoa5MPsQSoEe93cS7aW2nj7BIxQmtW6eleJtq0dQ22KOwGDaECIy
X-Gm-Message-State: AOJu0Yw4YJCNWGckaDNzqm4/LLU9lwgDpeoYwmExaaeJhGH/IPpEfQTI
	+xERXHBpjPBHrO/J81MOxeCA20BtC4kjuiFJFfIPrzAjyLxfq+tOGg0TZ4E4lMQ=
X-Google-Smtp-Source: AGHT+IFVGqHVEGhXOKM9KTyvp9ZeJZrbyJDneGqDpt7a+fSOwiM+Zc1V7mpA7ynh2FDJaMhdkYIRSg==
X-Received: by 2002:a05:600c:3c88:b0:426:6e93:4ad0 with SMTP id 5b1f17b1804b1-427deff7426mr52495205e9.17.1721733213033;
        Tue, 23 Jul 2024 04:13:33 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878811bedsm11266597f8f.117.2024.07.23.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:13:32 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
To: mitrutzceclan@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	dumitru.ceclan@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7173: Fix incorrect compatible string
Date: Tue, 23 Jul 2024 14:13:22 +0300
Message-ID: <20240723111322.324947-1-dumitru.ceclan@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrong compatible strings are used for AD411x devices.
Fix by adding the missing "adi," prefix.

Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9544bf7142ad..a854f2d30174 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1435,11 +1435,11 @@ static int ad7173_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7173_of_match[] = {
-	{ .compatible = "ad4111",	.data = &ad4111_device_info },
-	{ .compatible = "ad4112",	.data = &ad4112_device_info },
-	{ .compatible = "ad4114",	.data = &ad4114_device_info },
-	{ .compatible = "ad4115",	.data = &ad4115_device_info },
-	{ .compatible = "ad4116",	.data = &ad4116_device_info },
+	{ .compatible = "adi,ad4111",	.data = &ad4111_device_info },
+	{ .compatible = "adi,ad4112",	.data = &ad4112_device_info },
+	{ .compatible = "adi,ad4114",	.data = &ad4114_device_info },
+	{ .compatible = "adi,ad4115",	.data = &ad4115_device_info },
+	{ .compatible = "adi,ad4116",	.data = &ad4116_device_info },
 	{ .compatible = "adi,ad7172-2", .data = &ad7172_2_device_info },
 	{ .compatible = "adi,ad7172-4", .data = &ad7172_4_device_info },
 	{ .compatible = "adi,ad7173-8", .data = &ad7173_8_device_info },
-- 
2.43.0


