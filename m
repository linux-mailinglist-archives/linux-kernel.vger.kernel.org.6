Return-Path: <linux-kernel+bounces-418606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB899D636C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E33B2342A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F741DFD97;
	Fri, 22 Nov 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LiqAoj7f"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFD1DF98B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297216; cv=none; b=I3gox2yOyonSlYkdFYuUVj6+upBDAStAtV99AuMk2GFSBToK+yKhDCSqow+sV+kLslKHQcDi+K1Fof7ckCpSpdIQg9SgfDke2ipG8M/HKTYDy7H9EtqPtXjDQQSExrFJwCiYjh7+lEQ4jOfwUiBXIOVX+iEhzaDmR9l4oGMcsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297216; c=relaxed/simple;
	bh=nGDugsEzMYyjVhn/ciMakXTGY0HkUfo5USR3UzBZaCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eNUwE0qTyvjzsivY+SiOCe7k/Qxbdn+JeLdtfLzuETK68e3St+fOT+gqesK4144/3a8Swcze9FngvZnU7y3uaWDT7URlA9YxLSkn9ir4oXtgW+0K1iF/hGssEFFoIH2VGn+zmSAWoaN2B6HcAz+Fg+61uGnLjv5iviRh2LLt+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LiqAoj7f; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f86e59f1so1408821b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732297213; x=1732902013; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50h61GxOnKL1zzYHFyxBVUOS1MIjlLhbcFhOTWLtMk4=;
        b=LiqAoj7fHbA6YqYaHDq8tK5++WTTSMzcVZ56t5U12ZnowpXAR+J7WtlY+p0xoWG8oG
         XjxbQ9/+qnFETBPWzc1/KS0+u/7RhhBDZYRsbDW1XLep6rJNo4kclJTKcQdTAGjYF+dm
         VKhbXOxsYth7eFG6NPH51A33eMVI14iSAgb+J7k1BcNksIWlvfz2InaITKNG5XL0in7Q
         xCo9ylg0qnK044X6g1p1bTwANMfGR+1YzEYJENpW3NHslkWIkITBsF6L64q6vRB8O7fd
         ApMV5q5beupzH5n0GHdmBJwaeUAHZt2bhnyult7rwwqMYXstnHLxdoEt4jY1HG/k4uzK
         cSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297213; x=1732902013;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50h61GxOnKL1zzYHFyxBVUOS1MIjlLhbcFhOTWLtMk4=;
        b=Y4lzbQcpVhdYBQmQ0uEP3RlZqZ+0vKk9muzfPLCzLGQPsDGsmxNw1liSYMxRWpYJ0g
         dnVyJ3jr+rG66tH5qHMvYX7FGnv1kz3HzjRwu3VkFBCnnfx8hLPvXzr63KybFNpGuZlT
         aXu1kHdpmSa/TFSWGdC5VTt7jAaLTe+etlJ4Z37ZeJ92wN9VcvLOJWKhvDFf81wFAk5k
         ws3gaKpC5G4k0U/Zi26O2fbg72pobwMoe67HTWbJjq/20QUcBshlKySerU3qPx5nJvKH
         IubjT5G73+3YA+joSRV/JGa51MxUAxogW3jIxxfiQxT5Q83NvaBqo0neMhCTd9dfQspr
         WO8g==
X-Forwarded-Encrypted: i=1; AJvYcCXROr4E7QFyywtJP4nTKBL+hEI4aZ7JD7oy9JGDP0eAPf6GciqxH4sS52c0NH6gU87jMIxfyxUvCtKhQzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSKji/XI0wiSlXKB7p98fguUH0mjuNVridTx80TTUc1jjx2FY
	EOFQtTlr5COL/WjJNrX6kqfngZNJT9v+zF9T/3FcYtAkpV5t3OGqgmBjeg4+VFU=
X-Gm-Gg: ASbGncvGyzxcZmXL4VsCxo+CSRgJiqf37BXfNhPOqfL1zw/4DSgSvVx2rmiYsr6Ck4l
	RtYQ93Jt5wdaUNpBgclpPFv249YeTsgWebuNBC9ohEYHHZynoOBt2nnBzyrl4G4UOZBzBey05jN
	OiczKZWkbS09GTPynTvefLp0NiF0+MO2ZBZfujfiK3ugPTPK4Okqiwdz8Z1Ifk706jjzY9Bc70p
	1etWXUy2lvVlo/fr+Gh7LcNWl25pxLdAfn1vkImcAHSX8HBzkHqjDzbqOq+WP4aQONkm8W+/sTx
	iQrM8Q==
X-Google-Smtp-Source: AGHT+IE4alabHlRI047UT+eD20FUNGJWTu8qAkN+2f0dKKvzxLm2hJ0MTx09OXWOMHkrJF8SKfiZww==
X-Received: by 2002:a05:6808:3509:b0:3e6:2169:5a63 with SMTP id 5614622812f47-3e915aa513bmr4539214b6e.31.1732297212852;
        Fri, 22 Nov 2024 09:40:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0381c976sm494572a34.50.2024.11.22.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:40:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad7313: fix non-const info struct
Date: Fri, 22 Nov 2024 11:39:51 -0600
Message-Id: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOfBQGcC/x2NQQrCQAxFr1KyNmBSRcariIs6TTWbRCZjEUrvb
 nDxFg8e/28Q0lQCrsMGTVYNdUuhwwD1NdlTUOd04COfiJhR1XGaa3IZacRFv2huWN2io9riGL1
 9asfCci6PQiIskHPvJhn/r273ff8BJz62AnoAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guillaume Ranquet <granquet@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

While working ad7124, Uwe pointed out a bug in the ad7313 driver.
static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
and was being modified during driver probe, which could lead to race
conditions if two instances of the driver were probed at the same time.

I've made an attempt to fix it, but it isn't exactly trivial and I have
only compile tested it. Guillaume has access to ad4111 hardware, so it
would be good to get a Tested-by from him to make sure this doesn't
break anything.

Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
David Lechner (2):
      iio: adc: ad7313: fix irq number stored in static info struct
      iio: adc: ad7173: make struct ad_sigma_delta_info ad7173_sigma_delta_info const

 drivers/iio/adc/ad7173.c               | 476 +++++++++++++++++----------------
 drivers/iio/adc/ad_sigma_delta.c       |  14 +-
 include/linux/iio/adc/ad_sigma_delta.h |   5 +-
 3 files changed, 264 insertions(+), 231 deletions(-)
---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


