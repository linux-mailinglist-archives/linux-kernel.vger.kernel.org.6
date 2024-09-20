Return-Path: <linux-kernel+bounces-334579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20097D933
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641DB1F20F36
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92660185937;
	Fri, 20 Sep 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aQkYC+x3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E54184549
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853615; cv=none; b=M3OV2P7NQZ/ZD1DrNT1trDFAMVkOhm09jgrJJtGRyt8NoCnCXWRPGpqQ9Lk2m9IqUVvJ6De973uyf/8DGrrLlekQqR5cvmLX5kC38XRtiiie1tNi95eNEzCyWDe0UN7xljNLwqs/uVUgqYK79Al2bxs7jA6Ki5DBg9rJpm5Nz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853615; c=relaxed/simple;
	bh=MT8c2AhQeYsYs8cmaeLRhGYDwFnuTuG5PMmK88lsU/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVmWBRYcmHhXSCKVywq5zHOc6Mr7e9S7kYPELwcJz1nhp+LltgRyv3M7YltmKfiR+hUze9oKliZqAQsyi+HioJO9QpxmDm/cKvgy7GV0kh3+J1HB1538Lc2XGsocKInMvUbbAm4HnETbngt2iHl26kuYZWjS788lQ7nTjP7Xjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aQkYC+x3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso18662155e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853611; x=1727458411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvmqOfkNyg3mbwnmFu/TPFnKJdY4EPfohFTJPCL4F8Y=;
        b=aQkYC+x3nmYkQiwfkLLlrAY9myG48sneyTRn7dc8Vlb+2yhglq7xGY+jPiyVvA9AG2
         Bxwvhe/gt5rnLT6F5fELA+/KKT7yM3ZBnVK2xr+bzXrSpd6Ry6SqVEwEAeSIAW38LMNv
         LkDENwkjdNTrmsMahz1Y6CF6i1bqnBwSUiWecje5190/JTP+LrzXKX52DmSb0yGNn8MR
         Y+YnbmjxW9EhaH/jYyUPAQ2Dp93f7zMsOG8F1NmVwFYt7yu2kuCr260XTd6lXa76XXUD
         T90eNh23Xs58zGtIWJO5E+cdBPVFW1sHPGhDbDg0vC2ql0BibVWoBvLoX8tl7QRg40tC
         MYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853611; x=1727458411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvmqOfkNyg3mbwnmFu/TPFnKJdY4EPfohFTJPCL4F8Y=;
        b=PWkSlB+XdfGO9t9LXEAyFiQAYD30sSUXgw51wWNa5OzLac/LYJ1j2u2Dr0w+vYE9oy
         SOAL7xoVIh8u5wKGFXDJz6RYW45xToL2Bpb7yWh0hSzLfJiSqZxQ59ltCGuwrINodKcL
         RWyWBZImbwKl172ENN4aryv1DMv9I5LGsuq1KjPs72HhRvGxwhJWgrcWCvbXgUNTX/Mv
         b5u/lso2s39tWIqkDqndJu6hKGndofUTewWyirxlEd35c01K3HHHCzS+AkRWFcDDXV/k
         YzfE6/sWmC0CqCq48Xkm97qXVUp015jel6PBhE58bEucLE7Nw/+Kym4fqcSnvDXZEqr3
         kOng==
X-Forwarded-Encrypted: i=1; AJvYcCXGPswWwrdeMTIUzXmLAKTS40m6IsGPYNqBW3Sr+L78p7rK6EysrfcTz9ZgMfFxSBZp5lRSZmpZBNY2fP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYo8OiVSmDtK9JG50IH8n6dGQXLCEMI/AJ1h+lQGsmuKknjcG
	Wv3oF4mZiCW5NoakS4dKNbaRRr5Uagu4iNkPi86cevju/GM5v9ypLlsvqNDhEEo=
X-Google-Smtp-Source: AGHT+IGelVRMsQTQSU+xPNgg15Ho2GXpbX1Ln0t5hXane5n5dnYSSMSr6M1qKp+vzCMN00YqqNJH7A==
X-Received: by 2002:a5d:64c1:0:b0:374:c3e4:d6c5 with SMTP id ffacd0b85a97d-37a431a7142mr2209005f8f.57.1726853610516;
        Fri, 20 Sep 2024 10:33:30 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:29 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:25 +0000
Subject: [PATCH v2 05/10] iio: adc: ad7606: Sort includes in alphabetical
 order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-5-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=1335;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=MT8c2AhQeYsYs8cmaeLRhGYDwFnuTuG5PMmK88lsU/w=;
 b=RzKFmBn040UGa7yTM6JsY9KvnbH6tbRt6zQy0B5hwTYpOEClvNSZL5i5J1VqCH8LtQie0TnTj
 KJNP6vwN65QAQSfYhmEy1TLwWy0uoRdjGXz0EvvNOQOcvsKe8ZRPfaM
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Some of the includes were not in alphabetical order, this commit fixes
it.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606_par.c | 6 +++---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 02d8c309304e..d651639c45eb 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -5,13 +5,13 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/io.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 62ec12195307..d3fbc7c7a823 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -5,10 +5,10 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
-#include <linux/err.h>
 
 #include <linux/iio/iio.h>
 #include "ad7606.h"

-- 
2.34.1


