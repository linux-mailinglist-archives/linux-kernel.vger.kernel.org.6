Return-Path: <linux-kernel+bounces-288331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3E9538EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34455283279
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059C1BB685;
	Thu, 15 Aug 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DJvmMZsW"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C91B3F2F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742541; cv=none; b=C8SDG7E61OwYbnd4GUHpf3qntyiFxFWEUer61PvBrwu+WmcFO9JOc31z5Pqb6cDdvA85F4lvOl4UdAzYMdYDseLW9FLamZ0ufSf07ywm7h7o6WZIvcKCIRl4jSMVScs4MnhCam8l3lfJojXBkRPCJtcV166n/lF/MYJYsS9f3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742541; c=relaxed/simple;
	bh=D4UwZUQ81I5vLXXTS5znzAKk9dzOv8liLoig0hVVJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wl1RzaerH6TQrOVVMhcWSyg640F0ptY1VEEAe6MHtRmx7V6G7h4DCJCFYmcDZ0IvKVDF9AfVBkCfqRApV1jezYP1VzMz7U87UxqJN5upOUBOFUQrS2qDtnoTTNg97bxX1OrO7nmyYnQeNmRAss+ZACqQznl0LcrCefMH1GALSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DJvmMZsW; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db23a60850so736030b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742538; x=1724347338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYo8NEWGJIdtw9pJBLY1QEQbt1FShFOkJGNXlVqgZP8=;
        b=DJvmMZsWjY7zmSE2CTJXf6WfAhFgwNCKgZYzd6OHd4SuhraCH22ZFkTNPmxLJW6pLr
         jRCZ3r6HHkJ5oPoRYg+uYFhyKAl8X+H+Y2FeZ+xzwyafkNKtsTvISz73jz41S/xAfLiO
         W90f/PElk2heyF27jozZDMsaMTy/frJ9WsFVmyWW552g5XuOIYwfHB8+PSfcqtallJES
         d4dS24rrr+WnuYqWiVCb7CZBYQoNGx274cZXnZFv43LMLWxLce4o2aZ6dr/DusxTQjeZ
         7ZNRietBb+xtd7J/S6JWzw7UBBi6e3L8sCkszt6sG/pzz/T3ri97oxLpgLSZ/pvfBIZu
         17rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742538; x=1724347338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYo8NEWGJIdtw9pJBLY1QEQbt1FShFOkJGNXlVqgZP8=;
        b=Bn/Jx1J4oP2HL6ruiz/8gCaT6xvlcXo1piHA+OGv2HQs5OPGnQDkWT2+8he46fkk8i
         cEL9D4KkWPAzkvEK5Fhnr64ipiZKwCyrEDj/mni9dyVgQKF27e0/KbclhkbzVda1ohZn
         Yr1QpLMSJldizvk7zMLkhT1Kc+noM6Ipb5TV2aZDJCo9SZ+FyjU5edBy0nxbsPSV0nPY
         qpPZx5Ulil5EdI4CowjoFiUyZj6jX6vHI484aE2DDXruQJHr3kcvdemNUEIS6SXxij6o
         CRWOQ/zqBj8jWYVyCLrcloc3BYSE0bN5P8muvvLvs3NxXZYxr4D+EFxd9PkI29sO/207
         okyA==
X-Forwarded-Encrypted: i=1; AJvYcCUTyw8WkBLwrJ09xyBcBGZd0L5s7AlTHRpxZntS39Iyr5wm37ANYSIIGR95kY1CkFTLQrzwgC6Z+zMQfqZobj7sS1ctXnt0gZWeDcGw
X-Gm-Message-State: AOJu0YxYXfftCG3PgH6DZUqc/Ji+wPfsO8RuG9vIMI0lIPhTtdqrXr2g
	BY/M+H9vvjveMskjpPuT9DvkNiVswtrvQrpYwk3bs6jQGLyqZNNiaVBjwZZ7CoA=
X-Google-Smtp-Source: AGHT+IEr2pJX4B0DWbzhh7aV0O3Fjoo7uLRK/CK6MZwkprR+TAigHIXKquq4qfr36D6u7mbE2e606A==
X-Received: by 2002:a05:6870:d185:b0:25e:1edb:5bcf with SMTP id 586e51a60fabf-2701c34553emr282901fac.6.1723742537955;
        Thu, 15 Aug 2024 10:22:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: ABI: audit calibscal and calibbias attributes
Date: Thu, 15 Aug 2024 12:22:09 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
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

While preparing to add some new variants of the calib{scale,bias} and
calib{scale,bias}_available attributes, we noticed that quite a few
of the existing attributes were not documented.

---
David Lechner (4):
      iio: ABI: document calibscale_available attributes
      iio: ABI: sort calibscale attributes
      iio: ABI: add missing calibscale attributes
      iio: ABI: add missing calibbias attributes

 Documentation/ABI/testing/sysfs-bus-iio | 64 ++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)
---
base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
change-id: 20240815-iio-abi-calib-audit-fcc21b1c6892

