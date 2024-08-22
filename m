Return-Path: <linux-kernel+bounces-296791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661F95AF34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ABF287CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705416EB56;
	Thu, 22 Aug 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="khvyZ1f6"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4E14A4CC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311267; cv=none; b=p7tDBcX5a54UhK++3eootQc+ydrYMfgH1fjrzDNWmdVGyk8UKmxaK3e6QYLXI0uGv4aqSd3QBliEK5NAjyfiXvkzC3GmyBM5WSr+sezSwBHv1hm4fcOOGMRDohKIXXSfZXdBQwprAKpV3xEKM1o4mh4+Czp2kdR5uKDYHl/9VE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311267; c=relaxed/simple;
	bh=M4sKtqMWIobIpaGBrg0ryW72yXKbUhAhsh5HLa7K/gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k28N/OXjRzIo+pZNmXcw1RyaFcBf23y0yEJt/rz9ST4COniUzvPiTij7bJXRxtR1pUneik8ImpUPnYkw8CjWdkLktILyf+pZTBjBWbEr4mID6vBLC8TmsG5aUDuygiInSIcXekOeMqszyg0L3XUopBMAx9hJt0bMqQC5vYt4W6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=khvyZ1f6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd70404bd5so167249a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724311265; x=1724916065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GUNDCzUdU5ekIrWfbAr3wba/qpZf4h7cx4bxmyaZXw=;
        b=khvyZ1f6p13itqEBcc5k8lMiCpXegaX2pR/VCpJPdDLIE6vn5jxnhKNcIMDG9f3TiZ
         8wdtFYeSM2WnFUY+TSWoV2tgwySBxJgukPzIhkehhHpHt1jseY54sBW9faK2UBIkP4Id
         v47NXaBNgcEeunwL71/IkySiBBdoy0qUZeTZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311265; x=1724916065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GUNDCzUdU5ekIrWfbAr3wba/qpZf4h7cx4bxmyaZXw=;
        b=sxGTg7AI0G7J918G8P3eF/YNmcG6+co4A/nZ5COLLbHHdlzG4YOcCvHuo0PyCnOD+o
         CetMZnFMepEOU2yw1SYmJ6Q/2ZBA3TErzXiTDTP6OOaty3FhTwmlSID7shY6e/yxXMCy
         FAJWdAtx/zAEpwOYGfVjSoYd8gjcsAnvZvqQKeBpTIlwaew1HNpWXUroKUBkjhxH9MXL
         8gzbknO7gbERSDaI9XhJ9eM1Bsnkuth4uR+jUWlDkpJM4ZRkwzj/E1zB4VNyx/VpfOd/
         SzAyRL1sp46i94O3RVaE+oh5tTENTNmoC8Bq9wQDJalAVyOoq4ffsB4DFM8dPAUQT1hq
         jQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdMwoGI+Fe6Q0wKEcQM+jUVlj5Fqur/4pk8P/KAxRT8FPEDn9BDCP5AbXN/0da2MWQVXD4sXhCTbnl6l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwbk7QlEWNxIHrNp6coRzHBC+BReDXE2SFtglTfy9sKiheStf
	xA62uGxwmGmAocKWHLIG4S3jJre3dVgPZnDPHooYI7vZknit4nbasvYFXBhOl9rgMBhUbSSVN2U
	=
X-Google-Smtp-Source: AGHT+IEGeT4MNDGST4qPH20EYpmQ5MQMaoo/kwC3GHirkZLPGoC6/6RjmNsU2lTWPtLin2scsYkQiw==
X-Received: by 2002:a17:90b:3889:b0:2d3:acbd:307b with SMTP id 98e67ed59e1d1-2d60a9363b3mr3133033a91.10.1724311264866;
        Thu, 22 Aug 2024 00:21:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e8e9sm615901a12.86.2024.08.22.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:21:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] regulator: Minor cleanups
Date: Thu, 22 Aug 2024 15:20:43 +0800
Message-ID: <20240822072047.3097740-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are some cleanups for some bits that I saw while reworking my I2C
device tree component prober to use of_regulator_bulk_get_all().
These are not directly related to that series, so I send them
separately here.

Patch 1 makes the regulator_get*() function misuse error message easier
to understand.

Patch 2 makes of_regulator_bulk_get_all() pass out the error code from
regulator_get() instead of replacing it with -EINVAL.

Patch 3 makes of_regulator_bulk_get_all() clean up *everything* and not
touch the passed in pointer on error, and explicitly documents this
behavior.

Please have a look and merge if possible.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20240808095931.2649657-1-wenst@chromium.org/

Chen-Yu Tsai (3):
  regulator: Clarify error message for "id == NULL" in _regulator_get()
  regulator: Return actual error in of_regulator_bulk_get_all()
  regulator: Fully clean up on error in of_regulator_bulk_get_all()

 drivers/regulator/core.c         |  2 +-
 drivers/regulator/of_regulator.c | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.46.0.184.g6999bdac58-goog


