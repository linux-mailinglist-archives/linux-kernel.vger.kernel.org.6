Return-Path: <linux-kernel+bounces-234053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B768E91C181
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B3C285728
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721961C231D;
	Fri, 28 Jun 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lo/xOOIm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C43FD4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586122; cv=none; b=VZ6n3BoMMb/3sIuxpe3XF+HQsvrtXfGwD7DEiy6dN7C43IG+F5Gb/DXbw5SplfcoUSHdDTGM0tqrPfHEvS1oe+8UbGYlIbZkYBWla1RYfEs8YN7rMddR8PR1il3vW0TslqqudTloQgn1c+LETLk58jOiIOQ1JCLUwsYa6NyOHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586122; c=relaxed/simple;
	bh=xQKsa9t92njbc/chm5592/HjD087mzDws4h6aDIF+3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sHlO9qEvgKR3A14Ns0nthG82qXdJlbLk2MKcR9z5PcnCuxGv/MjRhKLFoCTaWP5rvgeZ7SKO6so5hoL+PvsNMWYNLIrNOlN09NOXh0Q3ih74nq0zoClLLGzI6IwQjyHrLqRGtV35edW4z/btFXE7ARF1IpCIde32jz9bLB23oqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lo/xOOIm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so8689681fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586118; x=1720190918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4WuBSs6L6RPbG4uwMfQbCjEpmJOYbZ1BJPiiArdN6M=;
        b=Lo/xOOIme48WV+zhjOTVtAgsPbIKHIL5zwD7hM9LYikXTB57yNDZDh1P0WhOus1AeG
         /Uy8XbT0d4Euk7YZ702WpoCq88+HKtZT9EmXPhAKdZW8TC1wo/KUkjD4YEXGin5550eN
         0e0+3ybZHzL8wjNqh4XmD0lvSbBuNlBtVAvCSeJCon/nIobshiBovdWkaPVJqs0wY8+q
         LTr6UQgiBvE4Rj+Z1JRc5BZnqDdS01w2QYzxY8r1tSshhf7XR3eKiCAPMFhhg541Wad0
         TnXwXlOf3ERyiYSCs6ulNzpocyFl7k+ldD/63Ig72YslEKm6Wx0ILcWZistb7o+IDpYF
         CPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586118; x=1720190918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4WuBSs6L6RPbG4uwMfQbCjEpmJOYbZ1BJPiiArdN6M=;
        b=AvNW1pU2ZpmZCtPGb1iZJRUKLedapX86Ib1tZ0CfQNQuORQrU2AxuNvHvODcUaKTIe
         44cKjsA36A0tsFOqYu0KBXINIgMR5ivTjTipA6mmeVk8qCtgAm7wakjQSM5R9xjomzfP
         vVwC9TfHHA24D7dsf2z3Uvf0RVS7SGWFaZ1XT5RZ/GaME75NqZhv3MIbCvCe94k8RUVi
         dKyGNwu/GkE446kF6gZie7LvkMSB+N5DWtjQ7194MpJRUlH7yLQOIZnIe1gKSCZJtIcH
         wiEBnPBSTUu0dj3mCNW9D6yOh9PYfu0uqwLKuz77o+AiAyuvnmipQtmMYsDqTk/5n+Xx
         +YVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNWy5n+gqypSfcvZEhc28fgIVkCRxcw6LhW9i0DKfkXV5HOScNmhviblu0U8vXEShDMOrG7gvegsZ2+Lx9yJVoql71UHpj2MMOF47I
X-Gm-Message-State: AOJu0YyhpYSeSM3oW5bb8779Yqh9ikg+Ag4rwxdrWfEm0Mjz99DAYtUj
	W7LAr0aQl8T/YbCKlNTyoFuYQNu01nZlkJIJtIgFFFbkgIqT+zWjdx9Kp8rgmD8=
X-Google-Smtp-Source: AGHT+IHGkAthhS0PQojYyViGRK3B3neRWRYcvZOsj1Kpf8gTHXSMNXCGtItzD+9u7B97uPwYqUznUQ==
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id 38308e7fff4ca-2ec5b318000mr98393981fa.7.1719586117563;
        Fri, 28 Jun 2024 07:48:37 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:37 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH v2 00/10] iio: adc: ad7606: Improvements
Date: Fri, 28 Jun 2024 14:48:18 +0000
Message-Id: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLNfmYC/13MQQ6CMBCF4auQWVvTaaAUV97DsCjtIJMgkFYbC
 eHuVty5/F/yvg0iBaYIl2KDQIkjz1MOdSrADXa6k2CfG5RUpSxRCzeSnV6LsL7WUgvUSIp8Y9B
 0kE9LoJ7fB3hrcw8cn3NYDz/hd/1RGs0/lVBI0aOpSl+5um78tbPryF2gs5sf0O77/gFijguWr
 wAAAA==
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

This series adds the following improvements over the current AD7606's
driver implementation:

- Fix wrong usage of gpio array
- Fix standby that was documented as ACTIVE_LOW but handled in the
  driver as if it was ACTIVE_HIGH
- Improve dt-bindings documentation
- Switch mutex lock to scoped guard

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Changes in v2:
- Change scoped guard to guard(mutex)(&st->lock). This was tested with
  Rob's bot condition, and seems not to generate warning anymore.
- Reorder the commits for avoiding bisection issues and respect commit
  priority rules.
- Add vdrive-supply to required properties.
- Separate cosmetic changes from content ones in dt-binding
  descriptions.
- Move maxItems changes (and plural in descriptions) to the commit that
  adds conditions.
- Link to v1: https://lore.kernel.org/r/20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com

---
Guillaume Stols (10):
      dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
      dt-bindings: iio: adc: adi,ad7606: comment and sort the compatible names
      dt-bindings: iio: adc: adi,ad7606: normalize textwidth
      dt-bindings: iio: adc: adi,ad7606: improve descriptions
      dt-bindings: iio: adc: adi,ad7606: add supply properties
      dt-bindings: iio: adc: adi,ad7606: fix example
      dt-bindings: iio: adc: adi,ad7606: add conditions
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation
      iio: adc: ad7606: switch mutexes to scoped_guard

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 129 ++++++++++++++++-----
 drivers/iio/adc/ad7606.c                           |  68 +++++------
 drivers/iio/adc/ad7606_spi.c                       |   5 +-
 3 files changed, 131 insertions(+), 71 deletions(-)
---
base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
change-id: 20240416-cleanup-ad7606-161e2ed9818b

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>


