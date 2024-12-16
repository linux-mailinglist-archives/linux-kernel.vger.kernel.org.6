Return-Path: <linux-kernel+bounces-448087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B99F3AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122441888710
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9B1D47A2;
	Mon, 16 Dec 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Azplt655"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F931D31AE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381472; cv=none; b=K4G26mHAhaTq580f9942UJonYfru9tdX35N0mF41RK+qW2jza/rZabb54U3KcBB4ElMuVk4xTz9i2k1p6ShtWpzwKD8VILsa221TABdPY1rwWJh2AkpBl/vnT0Iz/u1OZFjtxOvZ2PF8sK1T9L9HwA0PmvCsPXHZ0vJ3ckOMrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381472; c=relaxed/simple;
	bh=iVCmsO53/XGy4jvlMhHXrY4JB3K8lYaWVgXdiHkbpVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g1JYJd3d0gid6ZUrPZhD5XYmltovmoMkln+ZknfwtemYNzyt/ew9qsIhGD3GUOuk1YwUveAJHzjsjaTEqRRPAW6BB5ce6etH/WKDKh24oVaVhD7a3xHAJfFvN7Eg9ggA7LXYaggEyxPa3uRj53DSrrk8ccjuyUy5z/V8Uq9Q4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Azplt655; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43621d27adeso31762705e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381468; x=1734986268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDig5j+/O/4f0Wndg1xc17b3h1tURQz0MNAvDRCrMqM=;
        b=Azplt655gqVzyic9iXnohWHGJOSeohmwwV4DWtOzvJWe/voil1n+NYxnOMegtc948o
         eAZL6ENi9h5RP8DAaOTsQc5UGnl45d8RhatZXobO789rGEqBeryvgW7WEmwLXqDHlZC9
         b3sACGJPhIXwqli8FfGbdCZ6JgzDkAKJmW5zBy0dt5JRqOK+xwr03MM7Am2NtutzxGcL
         cA/TVYDBQwUzC9nUcVbNFxDOHqw8TaFQGsi2K1MSJQT36PZWuCL4ZJe+iTtMJeNu3WuB
         9i8bgbZWa1B2BpJ1ZSzQuEGX5wvjYrdySSyqXIqdYYpEX1tIlgwKnYnoSx3KPBc1yR3p
         9Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381468; x=1734986268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDig5j+/O/4f0Wndg1xc17b3h1tURQz0MNAvDRCrMqM=;
        b=UItxSHYQQTN+6x3ncfohUzPW8rSBZpRRJDtUZAt91+G+6Dwmye9KX1juKTqK2QHc1U
         CLCeN2DK8Tae8fXn6lDmPFO1lVlwkO7pPEvWOXAyV9QfPw+dFAsXIamBmg4omMaGHrpb
         QVhBbo9mmevQ+q3xoLATAjMnGxL1A3LnM7g7dOXukSEj95nR//MiCESzrH70Olz313Va
         nBEuw9cWpc9FviuHbSK4Smo1uhQxkNNgzuJPXEGquXmcODkS7VBST47x3tBrpR80tuPj
         oGA2RAc2O8kh8t+EqJjk5vlJGdyRtBghzVjrJ+qWStlzbkjW28RD6fMwF3M+PJVljzDS
         aCQA==
X-Forwarded-Encrypted: i=1; AJvYcCU50WMF5tHHp4wxTrNWsdLsGdiyRiR0+XUBv9RerpQrKGOLDeK9iAr3aQWa5OmzzLHnQsyjoNZgU2fxW5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cj+ZvTvmdd42Qz1H9O978Py3u4qMd6cV87XdbX01OPWRRKd5
	KFq9KoeyAFIxsazws3mbCPwkd+VPyOi+FkldZ/6k1VP+XZDqcp0dEX+9fkL63QQ=
X-Gm-Gg: ASbGncsJ7gxzhx1WgOhdyn+7JTxdnprxqLvpjCHKzkghk+CKcraCE4DV9/h/IDAdMnx
	O3NrCKpwFcMGZI2wPvprXU9RWUktwdN8c7GzaWxHm+0u+UjoBZiWv1CQysmzMvfW/zYZIVGCfXs
	KCBjrP4D9XyG/hpZ+u+qvJ4VdRv+dQur7GcVGEJYGI9Q54OB10+k2V7WwoqHlI2RpTqNLbzwnPU
	4e57FOnOBwwFRigV6XMcU0URAvKuZ6XQQ8BIZZesMJfZ5QJat4yYagXIG3LSSZP0RXLGgrmiiOr
	uviBi5b+hyyFE/43KcbKHQf+mFGX/uBMOg==
X-Google-Smtp-Source: AGHT+IH0M44jPrchVIDJu2Ik2dUUUEgDxJZpsSq4mVHR3g+WHZM/OM6bxkHERFrZ+7udSbphMbcKyw==
X-Received: by 2002:a05:600c:4ed4:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4362aa589f0mr131042225e9.14.1734381467096;
        Mon, 16 Dec 2024 12:37:47 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:46 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/8] iio: ad3552r-hs: add support for ad3541/42r
Date: Mon, 16 Dec 2024 21:36:20 +0100
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESPYGcC/x3NSwrDMAwA0asErSuwnLq/q4QuXFtNBcEOUkgDI
 Xev6fJtZnYwVmGDR7eD8iomtTTQqYP0iWVklNwM3vkzebrgV2Z8TRhzH4JXjJvg6lCk4sK2SBk
 xRZ2qIdE9X2+udyEFaLlZ+S3bfzU8j+MHOFK90XoAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>
X-Mailer: b4 0.14.1

This patchset add support for ad3541/42r, 16MUPS, respectively
single and dual channel DACs, together with some minor fixes.

The ad354xr connect through a DSPI bus (while ad355xr through
QSPI), so a new fpga HDL supporting bus mode switch has been
developed to support them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (7):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag
      iio: dac: adi-axi-dac: modify stream enable
      iio: dac: adi-axi-dac: add bus mode setup
      iio: dac: ad3552r-hs: exit for error on wrong chip id
      iio: dac: ad3552r-hs: add ad3541/2r support
      iio: dac: ad3552r-hs: update function name (non functional)

Antoniu Miclaus (1):
      iio: backend: add API for interface configuration

 drivers/iio/dac/ad3552r-common.c   |  49 +++++-
 drivers/iio/dac/ad3552r-hs.c       | 305 +++++++++++++++++++++++++++++--------
 drivers/iio/dac/ad3552r.c          |  36 -----
 drivers/iio/dac/ad3552r.h          |  16 +-
 drivers/iio/dac/adi-axi-dac.c      |  57 ++++++-
 drivers/iio/industrialio-backend.c |  42 +++++
 include/linux/iio/backend.h        |  19 +++
 7 files changed, 414 insertions(+), 110 deletions(-)
---
base-commit: 5f8c6f117400b7b21ad248959ae2cb6e0d634e97
change-id: 20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-119d780305c5

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


