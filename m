Return-Path: <linux-kernel+bounces-227673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD7915562
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329EB28186A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18BFC08;
	Mon, 24 Jun 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VHGrcv9C"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C1125D6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250276; cv=none; b=OaZNBpilJ9kTJvPTEH//QXPlZm+DNhYkYp2hsIaNIA7IHz82V+Y0QyT5jZOF+t1mTPAAlr9+wHEZ5KdRVM7tDRkZkNMJe8AoQUJZ3KixV6JSSdSLw/f9S2/bhwwqpjAQviRrHRmclxePbq1aFJ1Iuf0e/2DuBj0owfbAeU5aYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250276; c=relaxed/simple;
	bh=mI5kS1HCJJ7WW1Oy+YtN1Y3anfqpSihlvEVZxueVrhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYkIeRmk/Qsv+Tc835B6/HTQq3OfGhNf2hAVrcP9RlAwNVTx9EfIfURMhMhmSk7g7Pxe1bYk2kpGuEYt4tyBLWb4u7RrJudcALyDGQxydK9WGrYaOZvsxns+fPZhGvwccF9/fmBiIRZ4bFbLQDKevJGk9AyEHjcac59CP6gi38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VHGrcv9C; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ce0140416so2177530e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719250272; x=1719855072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPcbUebpH9a97qWXq4TA9VXjoMaci8v0q9yhJMVEHEc=;
        b=VHGrcv9CT0cp+StcHUnLhVrPiqAwLhYifZ9sX/NnwIUEYIMWPCHaxmmX0e9TgvOwjj
         66u6CdY8q5/mNLKubvSNHh1kur9LOLw5cVByXgh4AfiptScyGKXDZS/tgZj1Lk/+Z/lO
         /RD5V9ZY/cmelqaQxuJubN4j80uCVVXGyu1OeZ4WIfIDZuScHX7u95RHh+vv9HszeDjL
         BkxgeYm4TqVxgfnfgWcW76gF6X14rlTv10qqK7fRwEPUFY5mSL8iTFgkMNNEEEFkkZsD
         8LksNVC+dM/8HZ7wqDD8IyZDJ5BGmPSYNSiV35pV+kIPIodC50/Wl6kUZSGqY0cvZ4Z/
         u8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250272; x=1719855072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPcbUebpH9a97qWXq4TA9VXjoMaci8v0q9yhJMVEHEc=;
        b=StdkiSVNjJAwC+KvxdbDwI7CimQS884hOYjBXr2MXqBanhxkjfreH0MHaULny8eCFF
         w2JfzvGft0G8fKmfpM0e/qUT4eHDofJdZoKOU7x6nq223ivUhAUDj0bVmJhrMrhWa5w0
         zXF5UHcNnjSx2EHuta7BxYWvMxyPN+GX3pIwK39VUeUhwkyM+qnpIii7mhNBkvH2cAFs
         vaqRKPwoyPOmH9uh7MVoXEqJ9Dj0L9XmK3V6wsvDWCLS20+9lACYIr77ENJiiFIT/Rrm
         c09n/iaNHWyJIupiE+PbEOjJK72NGDodb3vPywtP/+2GHJKaEvTQ2yZM0+Z77f0jEVYW
         ++wg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgcxafdVB0M0iHA6PVRu7VA4axsEpUiNRec0exHvFuWGdfKpY6thpQA0ohDLMHFoNIXObdpc3fDkOskzXd1QZmnz7ZFItmhVMS7JP
X-Gm-Message-State: AOJu0YxXhB7I60IkbICBlNekqjeAe/kx7B/V9GU97uTHkjTlcfCAbqFX
	wYTORsub6K4qxBZOBPYhuYI3CQCni7G8qNu5elzUfRdkkTDEndHO8AKIQA8msTc=
X-Google-Smtp-Source: AGHT+IEE048c9lMdvxS1C2GH7HGqg2NC8yP2EE4vRfM+rV8ty+EL0J/9Kf/sLSBChaan4EUIwSKmjw==
X-Received: by 2002:a05:6512:6c3:b0:52c:83c2:9670 with SMTP id 2adb3069b0e04-52ce0646e8bmr4645039e87.69.1719250271980;
        Mon, 24 Jun 2024 10:31:11 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e4ee:e6f8:8fcc:a63b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d210ff9sm183742385e9.39.2024.06.24.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:31:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock measure
Date: Mon, 24 Jun 2024 19:31:01 +0200
Message-ID: <20240624173105.909554-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add support for the HW found in most Amlogic SoC dedicated to measure
system clocks.

This drivers aims to replace the one found in
drivers/soc/amlogic/meson-clk-measure.c with following improvements:

* Access to the measurements through the IIO API:
  Easier re-use of the results in userspace and other drivers
* Controllable scale with raw measurements
* Higher precision with processed measurements

Jerome Brunet (2):
  dt-bindings: iio: frequency: add clock measure support
  iio: frequency: add amlogic clock measure support

 .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
 drivers/iio/frequency/Kconfig                 |  15 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
 4 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
 create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c

-- 
2.43.0


