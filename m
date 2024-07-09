Return-Path: <linux-kernel+bounces-245045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCF92AD81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F36B28244C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA58364AB;
	Tue,  9 Jul 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IQzxJMXc"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBE273FD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487148; cv=none; b=Os03vW8mn++gY+BuqnVbwTFtGMl4MeF3O4/u8krpo/62HTu9QbR2WeySUjY3HMFwIp7j/2pfWSstq+UYhqtFPh1ZZL0FvwU+BmNwGNuC5n3VWlULhRMbYsJL13jYgvlCcfNbvlrscFUJwlUPh+YaGyD8++6dVc/u9XMfXc+zJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487148; c=relaxed/simple;
	bh=M7LRgkaNmx6cnCnudVhZnQbgoD0BVwpnWMNXohLHIrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kGBcg7CPCoAZ7UE2o0+fjjkVAjCAL7cbVc67MuitiuW0eqNDOtbFL5RLgaHNUzjYoLhjiUrnIntzzUr7NZNEy1OMx4OsdmwEyAzKk9CqsPwSJSyIBv8FSROEfni39ETcaRIkYfi2ZfPnfIvSA11XDfBBfWrYXwxlaN8mrdeONMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IQzxJMXc; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d92d1a5222so843261b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487145; x=1721091945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUmXmIi0wIB5nv67DJMBi6G1BRAl7VuLPPuHIOFf9Lo=;
        b=IQzxJMXchfQ4Rov2HYxyZp4vJcAk6YV9y37jHKlBTrXRKDTOicX7/z7hQoBDikenqh
         qkY74lh5U8qzTv9GqxOk2Bb1dCzciUNkBDQQE6W8519EyFjRnJS18GWJn07APgQznuBe
         IZEd2IIo4gYn9iWC+ABou7aU7wnyCFalcmLm0xwfksLdpZaLxyJrrNYPcblOiufg3jyE
         PlV8EnzWbvVRYKu54yoGknkWAatGkNtQwg/Xcc/yk2qATDFv/NZc9CklLsrfTp7sRync
         +Eb9gVK2GzIJLLd4XW5lQfXuYN9bCdXwlqSgM+ocyzgY2iUu7ZXisorvdoLfb23D/Vvn
         Zecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487145; x=1721091945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUmXmIi0wIB5nv67DJMBi6G1BRAl7VuLPPuHIOFf9Lo=;
        b=BovEs51sKVAmVFSHfDU9HMoWc2SZTJd1b1qWDQ6hEzEgp/+4MZyKhYmXF+4jYR7h9f
         ZQKV662IerAqZ2NZKdJ3M5J/RA8VCKe+vlX5qvz3/G6+780HbGDhAAKMsqdPFYx44jee
         6EscF4KApthk0j69G87JCp/Bcm8pVUdCQo+KEHJHrI/fG/frHwCjHleLh1niAdvMSrqu
         TC7DowXM9leiGPybI4zKD/iyIxJBKApBUPGzf/KNrFhti2fLDJeM3a3iWKo1UXSzHzqc
         rfuK1GhIte0CZ8XrVCe8hrfrX/ECksXj6Xi6mlTz1Bd4zWZzFHDoLuraT848hAPaRiUO
         FQtA==
X-Forwarded-Encrypted: i=1; AJvYcCXAUelDqWLdw0rth2Gr+w/92rXqEuVO5nRgoXPNg2Kk8O9oy0VtZ4BZuWGs3/iPS4ZYCjvfGtEkD6XGF9sSU4PgKp8hwMiSD60wHLpY
X-Gm-Message-State: AOJu0Yz1HJxaXqaQ2/e6lTt8FHdIHH2yuJLGR+polrrBWjpheGmQnCqW
	F/NjJhRt8bm8Bkb9WE21QHiWxjFKuQUlKx4n8hwAWnJOVtzP7NZ0BzpYqVopm1E=
X-Google-Smtp-Source: AGHT+IGjduiUwM4WHvei9UTCutfk5BRCFZbHJcxcwcdVw9lkpBbNopOOOkm9JMMhXyST2YjIQV7cVA==
X-Received: by 2002:a05:6808:1b07:b0:3d9:35df:8f2 with SMTP id 5614622812f47-3d93c02dca9mr1080753b6e.28.1720487145053;
        Mon, 08 Jul 2024 18:05:45 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: fix spi-mux/spi_optimize_message() compatibility
Date: Mon,  8 Jul 2024 20:05:27 -0500
Message-ID: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Since the spi-mux controller driver is doing unusual things with SPI
messages, it needs special handling with regard to spi_optimize_message
and friends.

The main fix along with a detailed explanation is in the second patch.

The first patch is another unrelated general fix that I noticed while
working on this.

And the third patch is not exactly related, but I needed it for the
particular peripheral driver I was using for testing the main fix.

I tested this for both cases when spi_optimize_message() is called to
pre-optimize a message and when it is not.

---
David Lechner (3):
      spi: don't unoptimize message in spi_async()
      spi: add defer_optimize_message controller flag
      spi: mux: set ctlr->bits_per_word_mask

 drivers/spi/spi-mux.c   |  2 ++
 drivers/spi/spi.c       | 20 +++++++++++++++++---
 include/linux/spi/spi.h |  4 ++++
 3 files changed, 23 insertions(+), 3 deletions(-)
---
base-commit: f42920e81a8f5f9fdf4a46b233ae14c22996e52b
change-id: 20240708-spi-mux-fix-6e2da5b5673d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


