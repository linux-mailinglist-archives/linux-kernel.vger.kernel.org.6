Return-Path: <linux-kernel+bounces-402178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AC9C24BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70912820E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54732198E85;
	Fri,  8 Nov 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="23rrlFR3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D05B1FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089913; cv=none; b=Gu8+bmuOHUbom2XAqHfWsTwrTdMvTy34Zx8e5UDTBRvr2g8GlbOd5SECpJ8E5tANrYfs1d/Efp82Cd3qaHn+TIHQqYiq4F542ktY+mKbUdzmeAhN8FndVztarUF8lu3/XPKjQhVyywexIny/Gupr1OR+XA+duOe79cTVXKziFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089913; c=relaxed/simple;
	bh=cjRKdYHBHNVHP6Fotye3+v8JOF2asOuCY4GPsoQWFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ree3Pq57PBusqmlNJQa6GkfZyS9kIPgcWKNzoczjMEiHqySfL5g1SnZEKK6DTma3A60+oz68dXJFXZIEPqfZ7yLm425Ay12okZwkFGeFV9GCkSHunNep78KUWEdk2LAD5DMcV9U+ZouEMGOv5sfAxG0o39n6x1f0cS5M0QBcDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=23rrlFR3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so1498953f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731089909; x=1731694709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXROKBTRhfzx82tvNGW7LzVaWoVZjpDaqjC7g8WHMCQ=;
        b=23rrlFR3Y9XWvdrH3e6y4dnhYz5eWZoFv+WgwyxMq9jlYrFx8YqeqbF/ihqTceH/tA
         wMzGKxM3srRrXZGA18RJU9qi28b/RzH8ejwITrXT9wTvwhhC5/r2xYVq489tB6SM9h/+
         Jyux2FBrU6lUiPj/DxgfMfjz/jycm9fXXB1CAawEqwVbth50qO0iTZfXz65+KYhEhgdZ
         49cH9wHyMDkimDuL+KDvsVGo01KE5z+lecR6r7FOTI6d9qoLJQzdldHs8RWOVDteSDo2
         fp3CIrDygL90EweubgZgwteJZvXPDyXnVCAr++IKHtKsMlIjLmFZgy74wnaZo6JATvEl
         Vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089909; x=1731694709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXROKBTRhfzx82tvNGW7LzVaWoVZjpDaqjC7g8WHMCQ=;
        b=at7GmLCt0ft79qqVTgEmn6S/p0oY2cyrqls+DTSzFW+72ek7mr5Tuj48ZUDdssNGGG
         bRiG4Nm+Z/bafF7e3J5wvBHYiWDqWETPoFeUD870Pj3b+dggAu2+YpIwhoXW4vcgzE6O
         6PVvmCi9UhYJeX2Yph2q91yhTDhN4AApa8ZgGSaZxO1prktbdIJKDj/cSLvAAjgUbQPt
         G/GfaXAfF6/9CEEjUAKA5Jik5kpsUdyPkRtCQV0qX5TeBSatgJ5fUdwkHyenAetP9EfL
         KlztlFBXv4HHeH1p7+sUPKvuf+8VdQ/pJh6dnQKsl2Iqil4ookkOQSdj1hm1bnHPu84g
         w5hw==
X-Forwarded-Encrypted: i=1; AJvYcCUroyZ1WpEPMFfSWNGGyqDtQzAQVuTGxEHwAxbgS6GderJE40Lk+yQMV/XyMkbM+5ZuDoyrvxPgoMwjisY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPliOCT8A8QTWr68pe6y3IpRMng1eX43dZJmrUoaovcoxN0nn
	K2R2GxDuC6BZi5dWEoVLwIljl7UB+3dU1+lQOeHO8FPFROwuU/dk4depmXcPMHk=
X-Google-Smtp-Source: AGHT+IE81tirHxVLXKF1FlPHw0TZSSkGzDKWjP9p0nY6/149orxHmtthAP8CMk9oJc7uvQECHWgFWA==
X-Received: by 2002:a05:6000:789:b0:37d:3e5b:feac with SMTP id ffacd0b85a97d-381f1854128mr3406333f8f.59.1731089909392;
        Fri, 08 Nov 2024 10:18:29 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b60cfsm112703025e9.7.2024.11.08.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:18:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad7124: Implement input validation
Date: Fri,  8 Nov 2024 19:18:02 +0100
Message-ID: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cjRKdYHBHNVHP6Fotye3+v8JOF2asOuCY4GPsoQWFqY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnS90GevJVLCjXu1NmbMnnqv23Lj6tqZCeJS4ed9pl2du mfa3YjOTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAm8mAF+z+7otMTdyncTnNa suuF5eMei8OHlxyQqTybmjnp1dlkkzXGgX97M+bs7dkVN6t3mmOmc8KnDWszV/X4Lqqz26PMdt4 jelW54wHpdJUYxqMiZbmcc4UleWy2H+eb2GPEteCdbtOPiv1XU5Y7rn5daZQszTJlx4cFJ4oDX4 teeSadzuf1LajH9JgK53Ll5AnKlqd4w/8p/3kzv1w8vvDjfB0e5RjfqdLa5/zrLn/Kl9c2ck5SW cUcknr/qEB6c0rEsfhN0nbRmbeE29l8uZnPrGJO5lPM2mex7E4H86nHbxLV31mmuEt4JCy3LHNa sDmT58wiJ4sW5XIZ17Ubd+izCC3T/lUYuKJFciJDV1EkAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here come two commits that add some input validation of the number of
channels and the diff-inputs property values. The first limits the
number of iio channels to 16 which is the number of channel registers
for both hardware variants and so is the maximal number of (logical)
channels. The second commit refuses invalid channel numbers, that is
8-15 for ad7124-4 and values bigger than 31. The initial driver refused
all input specifiers > 15, but this limitation was lifted by commit
f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation") with
the intention to allow values 16-31 but dropped all checks.

Note that at least some of the input specifiers in the 16-31 range are
different and using these yields bogus properties. E.g. 16 and 17 are
for temperature measurement, while using these in the device tree
results in a voltage property and the respective scale and offset
properties are bogus. Still these were explicitly allowed in
f1794fd7bdf7, so I didn't refuse these.

These patches don't conflict with the other ad7124 patches I sent
before, at least git can apply the series in both possible orders.

Best regards
Uwe

Uwe Kleine-König (2):
  iio: adc: ad7124: Don't create more channels than the hardware is
    capable of
  iio: adc: ad7124: Refuse invalid input specifiers

 drivers/iio/adc/ad7124.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.45.2


