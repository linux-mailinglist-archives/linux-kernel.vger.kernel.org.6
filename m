Return-Path: <linux-kernel+bounces-219575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AE90D571
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3873B2E359
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DC1AC770;
	Tue, 18 Jun 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yKpwXGxa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7F1AB902
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719363; cv=none; b=MeE4qeuDG3MWqVViBJ5OaLLyu7XmyrkLVJV0aDsagWI+ua+wOQSno4qt1A8HLkcGu3m7NkReOJcAINQ1s8sqE+81VweW3IHFfr+R4czPNDKQSw8lXnl+b+FKOhFqDEstvn+ERQXwrGmUdu/tN/ups/3ZE5YZt8b7CNtvlClxsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719363; c=relaxed/simple;
	bh=G0IEsc0YuwIVNtNFERXBYcEqbj6ugCGmrYZUFWavEKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbwUlN5w26YhlNr4Cba6UKv1E9iFBFNjKyK5f0rUyaWSrMJRi9Q9a59NXNmdqPJFXOUoUBeFnJxGG4mQ7Pi1entml6jOspUOMdpl6hYskFMZMltu3sRQjKWXb4PrEN5Bp/SaTJa7+5AXxd59n2zmdvmY/O1OJT/i4Odu1HkrkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yKpwXGxa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4218008c613so41593275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719359; x=1719324159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4plLXWkBuN6eMxbghss2+pJl9NpmXZN9/hM9oRoKCA=;
        b=yKpwXGxavEO16aGtNkPyaQeDdXMa8Mao3TIaEK/2WeAXLnmbkT/F9Excncq8FhncnG
         7bz5He/bOYnAgw/Fyx5/ZRY73Nk2BbhLk0hjTtwOo7SS0J3qPsvn1ASOnV3XwfFAsRvv
         iWIRUaD8a77HuQyhz1irKVMU6z1adgkS15FdF3JcFU3VqIHucPaebrZYIkbUYY43CSsQ
         +tuqn5z8NkKxH2Pu/AXampd2EE1xIwJNoMKKGOWGQW1XwHgFNEBga3q0lRdUWHSabhHi
         gFJxwGyEH6CS/3j3lhzmwdOHlbIVJzQQiEysGmFIYYI5DqW87FH/wqRA+ardR3D6eOQj
         mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719359; x=1719324159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4plLXWkBuN6eMxbghss2+pJl9NpmXZN9/hM9oRoKCA=;
        b=SAcxl4rvf7TMdf0aI4Sy8B7MEQDXSZ/CSBfeDKa1Xjzei5sya0FGsEx2dCWh+Jl9hE
         4tZ3PM2HvRLIsy5WHASr6sI3vZJ8pvvapvQr56FFw2kyERhSWN1NhKClz9N2tED2Vh0J
         qqflz81kJpf/bQ9yopt++bk3fBaJ3STp7yUy8/i7PY8snRMU/0WfELcKgT+iUWmbfn8s
         Sp1y2u2mE5NHIInknmoEjwfnt1vQF1IIjzCK733izYfKZZoYZUTs1T4Bn7GzGDvLZdEm
         w2SXoRTZSDTI/8WF+nrIEvdDVG/eEcebGzGMcNkMjnckKaQ2E3fesxFdDRChJMWUp6Sv
         p70g==
X-Forwarded-Encrypted: i=1; AJvYcCUIn82qkBszGQV5brsbZcS9kr1vbZ+mPsBqAvjzaMFUpnC3nu1SgbWKff0SoOVj/VJNibMPz/uBs6lesZALuNE/4yKb06os0QoiTLz1
X-Gm-Message-State: AOJu0YzLwoxC1YqCfkc5lRWaO57iocj0oI5m41lx5HzX2VwBX+2Dl0ej
	lqKZKoNleiI6Ou2BCjYasJgXxCu107EsCx+oBZ52RnWzsfhjdULr59bumgl7A+4=
X-Google-Smtp-Source: AGHT+IHk8eAM+xd2EgGrv4q4Al8sZ5/FlQ4l+KMnzE7MbVO9g2hq92wev9EA4GAAkpJE4kMFyryK/A==
X-Received: by 2002:adf:ea48:0:b0:35f:1128:250d with SMTP id ffacd0b85a97d-3607a7842e7mr8900419f8f.68.1718719358881;
        Tue, 18 Jun 2024 07:02:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:40 +0000
Subject: [PATCH 8/9] iio: adc: ad7606: fix oversampling gpio array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

gpiod_set_array_value was misused here: the implementation relied on the
assumption that an unsigned long was required for each gpio, while the
function expects a bit array stored in "as much unsigned long as needed
for storing one bit per GPIO", i.e it is using a bit field.

Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 4 ++--
 drivers/iio/adc/ad7606_spi.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e3426287edf6..502344e019e0 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -235,9 +235,9 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	DECLARE_BITMAP(values, 3);
 
-	values[0] = val;
+	values[0] = val & GENMASK(2, 0);
 
-	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
 			      st->gpio_os->info, values);
 
 	/* AD7616 requires a reset to update value */
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 263a778bcf25..287a0591533b 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -249,8 +249,9 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned long os[3] = {1};
+	DECLARE_BITMAP(os, 3);
 
+	bitmap_fill(os, 3);
 	/*
 	 * Software mode is enabled when all three oversampling
 	 * pins are set to high. If oversampling gpios are defined
@@ -258,7 +259,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	 * otherwise, they must be hardwired to VDD
 	 */
 	if (st->gpio_os) {
-		gpiod_set_array_value(ARRAY_SIZE(os),
+		gpiod_set_array_value(st->gpio_os->ndescs,
 				      st->gpio_os->desc, st->gpio_os->info, os);
 	}
 	/* OS of 128 and 256 are available only in software mode */

-- 
2.34.1


