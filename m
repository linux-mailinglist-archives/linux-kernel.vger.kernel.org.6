Return-Path: <linux-kernel+bounces-189078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92B8CEABE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03484B2160C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816105336D;
	Fri, 24 May 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QGHThyLD"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF78493
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581901; cv=none; b=iYYkA3WVvRKXUpY3HkBegM4yW2MF6xiLbpfVI63khMKcEDLeHnYAzldCloevTP1AC5KMwlgKjuzWE6g3v1E1bfP7Bd/E9XIzFH7SR62uiTaVio8j4OtOED2wwYYXqoURdI7Affi6bPVLrJaIG7reFbm1wKps2wLJOCwdFLEsKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581901; c=relaxed/simple;
	bh=p/NRncoY56p0bib/WzzDXctsmUiON69N127T2VCB9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cYmTd9w6B9GkSgft7d68ZF5CfxEIfIDHgO2i7g4R7MZ7dyatI2ow3sZPVkbaS4zoNL/YAEqSNHJEiyjsueXdgX5akjdYSFdZaPvqhQJtU4t+Y3Mjrm7+P4aLJ2O1hxVRJtLQ9k8cx3yMl4bN4QgM648GHuSrPjEIW2eXnqzM3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QGHThyLD; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24d8b372911so327116fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716581897; x=1717186697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HalOAyLkDzegc+4kX0OIEOAwPaY/uhF+wibqleOrnyU=;
        b=QGHThyLDGzZ3thvfFj5KGruOyj0pqLiQssZwSPRShlcPTwKB9K3YHbnAAEhGNBd0NP
         JWBwJTYKiFf/n1lq7E5T6K+0UE1RRaAuFd6UXVYiDHaZA7fh0Ykb4/AvJVR/zAaj2c1u
         mkvoxboOr2DZ0pV43iGdtuLp2TNRVKss3SSmLJHfLHccwlC6KBfIgw2xn/XC5/3F9cau
         6CoHqJhMlh2YyLfgl0tfmWl9iIMfbHnex5Fjlhe0H8JEtEDKiNAm6+3YJfXcwVALwzbx
         3lvQFez71gJ+t7QeGaLY5sCFtjHdIMB3EVWT+/U1dyd1bgiUCOJAr5FBPB2WewnKNnKc
         STyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581897; x=1717186697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HalOAyLkDzegc+4kX0OIEOAwPaY/uhF+wibqleOrnyU=;
        b=MjFGLfDUQ+sY7/Y9JmYBjBXUbl6KmsE/7cFQ8j5LMC95TamSzrK7XJqq2NUssFy7b5
         DGo0+4UM9b4tvaZQQLb6FOtSGcZJd/upu6ZvIyieUxNy/dAPrOCBo4aJWUvwNnj5WFV4
         TPla2JO0JCkZCvGE5NRb5Ajd669+7L0wCTrG/clPEk76Hup79remgMxRb0i5NqoySurm
         Nu3BqwuxgtIo4UiGTSaJFOU4myJJjkoNM25MzNK5q+v8tEuP2Z21wZMRCTYPph11yvH9
         F1HUhmSTg87S9IboiaRe9LZgVvzGbeUABBL6rZ7fNnlXcyOinxifQzLjZv5ONeBHWX6f
         OCAw==
X-Forwarded-Encrypted: i=1; AJvYcCUUuLOztYfi3IhjPM1jiyLV4+j9vmrHUasq84OKfBS7uZfNaXNtroQvZbhGY4uoqcczo4p1K9Wpj0DknHvAUcalOFG+Rqj0X/yEk4SB
X-Gm-Message-State: AOJu0YyI8E/OPAgusaOI8dNIrJNCE++zyHs7r3BgiCKa1WtI6Sx6NMi9
	BawBpFrFhqAtA6UvjQqo1Jp+0MJaXjvmZHEyiGrJdcKMYY086Pu/55raId2GPzw=
X-Google-Smtp-Source: AGHT+IEEm310HUA19zQ7ahDsUmBpRn0zbL0JH1ZmvUCVnEHDH2QRw6nh3//N3jOz6mDMfKmDdb2sDQ==
X-Received: by 2002:a05:6870:b24f:b0:23c:3c37:a4ef with SMTP id 586e51a60fabf-24ca121d841mr3869731fac.29.1716581897398;
        Fri, 24 May 2024 13:18:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca2840481sm516737fac.57.2024.05.24.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:18:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: add support for multiple scan types
Date: Fri, 24 May 2024 15:18:06 -0500
Message-ID: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Up to now, the IIO subsystem has only supported a single scan type per
channel. This scan type determines the binary format of the data in the
buffer when doing buffered reads.

For simple devices, there is only one scan type and all is well. But
for more complex devices, there may be multiple scan types. For example,
ADCs with an resolution boost feature that adds more bits to the raw
sample data. Traditionally, for slow devices, we've just always used the
highest resolution mode, but for high performance ADCs, this may not be
always practical. Manipulating data after every read can hurt performance
and in the case of hardware buffers, it may not be possible to change the
format of the data in the buffer at all. There are also ADCs where
enabling the higher resolution can only be done if oversampling is also
enabled which may not be desireable.

To allow for more flexibility, we would like to add support for multiple
scan types per channel.

To avoid having to touch every driver, we implemented this in a way that
preserves the existing scan_type field. See the "iio: add support for
multiple scan types per channel" the details. The first couple of patches
are just preparation for this.

---
Changes in v2:
- Use union for scan_type and scan_type_ext.
- Dropped ad7380 patch - those changed will be squashed into the next
  revision of the series adding the driver for ad7380.
- Temporary updated ad7380 patch for reference: https://github.com/dlech/linux/commit/64be3de241e73b43c5a5daa44b6b97f35f0743bf
- Link to v1: https://lore.kernel.org/r/20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com

---
David Lechner (3):
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel

 drivers/iio/industrialio-buffer.c | 91 ++++++++++++++++++++++++++++-----------
 include/linux/iio/iio.h           | 85 +++++++++++++++++++++++++++---------
 2 files changed, 131 insertions(+), 45 deletions(-)
---
base-commit: 6c46802cc0c4ff878f07139f7b7b8774fd43ce3d
change-id: 20240507-iio-add-support-for-multiple-scan-types-f4dbcf4c2cb8

