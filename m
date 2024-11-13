Return-Path: <linux-kernel+bounces-408302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A19C7D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445A6284032
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B12071EA;
	Wed, 13 Nov 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hZjSBke3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AE20513F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531188; cv=none; b=ZeLPrpPb45KSy1D/fDFSvN6PaABhqqBwE+2AB6jwaY46wWCuBzDkRz+vQDxJeHHbZzDYJoPe6iLv3siAsQRmTgD8gdDUPy5g6lrelo+DjuQZHwzcVCKq6O/6LwSd6QJARGPutRROC9w+hINc3EWLFaIVmq4ZhREwq32ZuZde0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531188; c=relaxed/simple;
	bh=DtbTaZaqvsc+KEoZ506Tbq06JxZmBBxce7BnJqH3AAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DqZJ854m2obaHPUuOUQiN3ghKPhsEhJvQZP0zy1gubXJvRx5z2RzAlYcZUKBspCMyIuWaDMdvZD8iQpkZsCyK6lSK4Et228zRCL1y4FIj+4g1d8henuNUuH6UzzMTfxQ6J5dyK47PzskJ0BovYDnjPCzJYCfWezXAEK8uzOwOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hZjSBke3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b153047b29so451421685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531184; x=1732135984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8TX+6GngybidWgUAxSJBaW9xrYOaSQ8y1fp7VpIsVI=;
        b=hZjSBke3zM6qChzXail2ZFTedtkXCZgwAH/nhwWBcFrvYGbjCJM54UphQsWe+xuDSg
         e8PjChXOwtExiq4dsEWJAiXLE/g3ivuVPMV3N8N7I56XW7i6ETkPtyGiFEXat8VOXWSi
         S1QYOC0bLshS/LefA0Q7rpDQ987+mdkG+J4q2lUkQy6wg15Kb6z3T+mlazL9Gno8CvUW
         5S2luULlFC7wPp3cuaeZapFn3LjHoYMcMV6D67EoX2w45Un4TX8VcyeuahDrkYlWm+FU
         CtvfJkpDdWFREaprfilKHBzYycPxsY4ie/GsZfVIQo4S79mpqrQwzjpY1qfLxkQ50q9O
         mi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531184; x=1732135984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8TX+6GngybidWgUAxSJBaW9xrYOaSQ8y1fp7VpIsVI=;
        b=OkR1HYysaUtXmFxbPoslUQTgdxUxJmYIPGGeL5BI1/UHyjIoe08a48N7pVEiQ7FIEz
         Okoo+2pIqx3qwGjdE/DGAWtgeGQyRQvN8EXxCvTqDjT0U/ZZFos2E9QOEhK3ovYhIjhc
         +BHnnVhgf3yGoW9UT0Rz5WdvkhwaoTCCkehNSskMrFPxPhpO1RRnMM2fmmkPzwGtVhMc
         NZC7DdqLNdIHCsUhcupmOe/rzyZABXRabIbYKv7kbKVVd+wcwr3dYK48o3oQDtJISgs/
         f0R7KdPCEIN+X0bdRbZV1PM1LO2h8UJbKtIiF4r4LWNoaWiE/+/os+PfPJJogbmXdc+A
         7i0g==
X-Forwarded-Encrypted: i=1; AJvYcCVV98eydqod0Nghpx51hB4ErMM6vYhz7BlK+WdT6H6i/BfyiSghhlxzWT6qf1qv6a3RF0pR+dZwAxSUheI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4EH5vQPFUTCF/YC7pceUEg0SxQUlgMytTkjzpjXZvL0N8oKl
	12Q//NBgBLEwPK4gkCjNh44PS+iYk68vaCeF7vuLfYmVtJfLHe5svBD4BD+dwno=
X-Google-Smtp-Source: AGHT+IGDHbpm275dmT0uFp7vyn9Rc4ogj5CY+nOREwoYatFkLfT1ahZRdzhfo/JHlSJiGdsA1FusWQ==
X-Received: by 2002:a0c:f6c9:0:b0:6d3:a772:fd25 with SMTP id 6a1803df08f44-6d3a772fd43mr211209176d6.21.1731531184261;
        Wed, 13 Nov 2024 12:53:04 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2f5sm88829336d6.2.2024.11.13.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:53:03 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/3] iio: adc: ad4695: add new regmap callbacks, timing
 improvements
Date: Wed, 13 Nov 2024 15:52:57 -0500
Message-Id: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkRNWcC/42NQQ6CMBBFr0JmbQ0doKIr72GIKTDAJLQlLWkkh
 LtbOYF/9/7ivR0CeaYAj2wHT5EDO5sALxl0k7YjCe4TA+ZYyjSxjtq0M1uh+1LdqzebxbtIhuw
 axE0XqBWqukMFSbF4Gvhz6l9N4onD6vx21qL8vX+KoxS5UPdaD2UlURXVs9XbzK2na+cMNMdxf
 AHUHSC7ywAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 driver currently operates all SPI reads/writes at the speed
appropriate for register access, rather than the max rate for the bus.
Data reads should ideally operate at the latter speed, but making this
change universally makes it possible for data to be corrupted during use
and for unexpected behavior to occur on driver subsequent driver
binds/unbinds. To solve this, introduce custom regmap bus callbacks for
the driver that explicitly set a lower speed only for these operations.

The first patch in this series is a fix introduced after discovering the
corresponding issue during testing of the callbacks. This is a timing
fix that ensures the AD4695 datasheet's timing specs are met, as before
the busy signal would sometimes fail to toggle again following the end
of the conversion sequence. Adding an extra delay in the form of a blank
transfer before every CS deassert in ad4695_buffer_preenable() allows
this requirement to be met. The patch also makes similar changes in
ad4695_read_one_sample() (while also tidying that function somewhat) to
make sure that single reads are still functional with the regmap change.

The second patch is an improvement that increases the robustness of the
exit message in ad4695_exit_conversion_mode(), this time by adding a
delay before the actual exit command. This helps avoid the possibility
that the exit message will be read as data, causing corruption on some
buffered reads.

For additional context, see:
https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com

  [PATCH 1/3]
  - Fix bugs with transfer timings and sequencing in
    ad4695_buffer_preenable() and ad4695_read_one_sample() by adjusting
    xfer structs and simplifying
  - Add clearer comments explaining why the temperature channel is
    handled as-is with the advanced sequencer
  - Add David's Co-Developed-by tag

  [PATCH 2/3]
  - No change

  [PATCH 3/3]
  - Fix bug where ad4695_regmap_config was passed twice to
    devm_regmap_init() in ad4695_probe(), instead of passing
    ad4695_regmap_config once and ad4695_regmap16_config the second time

---
Trevor Gamblin (3):
      iio: adc: ad4695: fix buffered read, single sample timings
      iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
      iio: adc: ad4695: add custom regmap bus callbacks

 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad4695.c | 208 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 165 insertions(+), 45 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241111-tgamblin-ad4695_improvements-7a32a6268c26

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


