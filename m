Return-Path: <linux-kernel+bounces-219571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCB90D691
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23C5B286C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CD1AB909;
	Tue, 18 Jun 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YquMQCKL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4513AD29
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719359; cv=none; b=t2Jvaq86DrR/Rf301wajZFpaFXixgadtNINFezB7OhiXCS2nnsqoGPXg3mYibEcta//NLnj9S0F3WYfE0mBSPYTJcXE4KEyd65zB1wjW9C6YVsJvaLs+PA8ONL01geKtUWD7ivlMp5rfG2YiAPiZqu7kLNvjQgLZJdZuyDeNsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719359; c=relaxed/simple;
	bh=dQxXp9Op1zTGeFN8lKe401hgz5qSQTwXXD+bvc/TFcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OzlDUOAkjH9QmBMrNJbundjBr2r+c5KPSaTdanYrJa+qva3w2Bx8txy/37CrVfMNm6UPpIvloBeX8xGt/RcArGO3ULeYT3fDSFcq4ItlgYbvsSX2cEm8d50OGeKz+64YEm8F+7cS1ck4v8psWdRqW+JxMHvJqgQZkGAKd3R8JCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YquMQCKL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so43097045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719354; x=1719324154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fySTWzP7+2Q4hnnSyXij3ZpjveKlFndsAqH5BZexb8w=;
        b=YquMQCKLSr+dQ5OqmcKk61B3NmSeoZK7G3VtifXDN/Yu5tfTV83njaPyt2wMIqyCo/
         gup6dqaL5rAGYWZjk5FoX5vyVaMtWh6cr9hNB5UjNj8qJerWZ+ln4Q0oIir5fMP4QQzi
         9IUu0KLtTPpBEr3ndc7PIRdLvtVuaDmqwrgrKi/NBo8RvSUYgD1M4rk/leAsM3T1ec3I
         cbjsTwsbuMYKfjUjc1svresGfHs1ovu0hxfU5+NjEMtOBTMUgOxqsxKSoCFq84xMo0v8
         zopspJRFb4ponLJ7xPfnypO39WxvcP4WJkbuIxrrMqDH8FoWjns19Kk04VHtbDRQJs4V
         QBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719354; x=1719324154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fySTWzP7+2Q4hnnSyXij3ZpjveKlFndsAqH5BZexb8w=;
        b=sFkxj8xHLrQRTPZ9i9jRAgPmIktaWA6U/v+liDPK/peFw3d9akJPr+6vmoXZZqwHP0
         ASNYXgXDxdnoSpOwI5MQzGPUpuSXfgnPPJMlzYW332WBQ2PTKuT9WCRkzca7y82BP4NA
         wvfVKp6Kli7cmNtlcJakNhjddoedITLH/+vCzjgDG4bST05GzS5NAc0yjm5d53X5tMZc
         iBX+16JqaV2eZ1cWXctYOGoGSmm7ReTAB7Rav1waL1/hyLaS9F7iJ26U2hX8+OlJV613
         Jc3Gy9au2om3BputBwAsN4iugkPTHC9HPMWeFDWfmyPF2Tjqz25vzCt1qX3g0XHyI2EY
         JCow==
X-Forwarded-Encrypted: i=1; AJvYcCXxCq0JPdm9CtxgF3lcuOPGnu7Mlg5PBWp1d9CYzgd+4rABxfBZ6uZy9gG7kVJcWqGmVIvqrvcQP0GsFe9FIwC36zCAgckARG2t/nCT
X-Gm-Message-State: AOJu0YwzwIrRSslgQ6OWn0hEUreU0nvRsszeZtKjROOnQ8QtL2jyYxL5
	bndL0H8/7tMRoJY1L6L2hb6Cl/XxXLRbw5+Djzm1NHsfRhNYDxZpIwAyzG8LGsY=
X-Google-Smtp-Source: AGHT+IFjv5B5zrwnrKG07bNRwmngFblZ30ls8fBQs0cX2uPWV+t6prLL9CNFqYpst13GA6h8bFeT5A==
X-Received: by 2002:a5d:550f:0:b0:362:fa8b:224b with SMTP id ffacd0b85a97d-362fa8b22c8mr15107f8f.47.1718719354290;
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:33 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH 0/9] iio: adc: ad7606: Improvements
Date: Tue, 18 Jun 2024 14:02:32 +0000
Message-Id: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiTcWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Mz3eSc1MS80gLdxBRzMwMzXUMzw1Sj1BRLC0OLJCWgpoKi1LTMCrC
 B0bG1tQDo3breYAAAAA==
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
Guillaume Stols (9):
      dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
      dt-bindings: iio: adc: adi,ad7606: comment and sort the compatible names
      dt-bindings: iio: adc: adi,ad7606: improve descriptions
      dt-bindings: iio: adc: adi,ad7606: add supply properties
      dt-bindings: iio: adc: adi,ad7606: add conditions
      dt-bindings: iio: adc: adi,ad7606: fix example
      iio: adc: ad7606: switch mutexes to scoped_guard
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 126 +++++++++++++++------
 drivers/iio/adc/ad7606.c                           |  79 ++++++-------
 drivers/iio/adc/ad7606_spi.c                       |   5 +-
 3 files changed, 134 insertions(+), 76 deletions(-)
---
base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
change-id: 20240416-cleanup-ad7606-161e2ed9818b

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>


