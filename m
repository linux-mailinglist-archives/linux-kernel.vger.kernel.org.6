Return-Path: <linux-kernel+bounces-510839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED805A322B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161F13A51E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E41EF0B2;
	Wed, 12 Feb 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f8XvIlzS"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83331EF0A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353565; cv=none; b=AdvfRjNIAdDr50Ow8xlIH3gEl+VpJTNf20fXb4hnIcqKZu2nV0spVtzYPm/kUTXgnTDFk7HHepqZwtG4V9nCMNptqiLVnYlDGoAhKVHt45NsjuSny35IGoxgBYZ58vEJcPwT0A4xNsTWgoMSTAkP21pqe2GmXhynJh45iVAxeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353565; c=relaxed/simple;
	bh=1plww5LSeApsiHW+Lk50lqZF27WN3poyYwcPpo1ejyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zv7CqJPkCYjYT06hNcAaybZHv2mGTirs4pFojLqMajoLBdpRxQ6iQqnc3IJkkXo4GM8J5wiW132LiIr4yLwP3bafkO2MyMBmh4u2UWpMCwyI+QHoAb6PzeCpfnYdl4AH4MwyI/F0JnT29Qc9gyMNH+FVlOlrYNxWTW3D0aMcpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f8XvIlzS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3404340f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739353561; x=1739958361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zuOOH+cqbW5sfzyGH9UF9miBvxPH8Nl8TrZbDwlVwE=;
        b=f8XvIlzSqlNwV37zfu9VVoyFvwkNSd30CNr796GaOfiSzvXgRoHTy0Vuz/PfJ6oYR0
         QyYknjoFGQiqkwECId/aVTjIVDakLdrTHSKbeMUkUr4jpG4TqyIZ83cQ0MBg8MV73tqH
         hIU+eX+s4vueddkrU6+t6QnMFPMIDMIOgAZCqx1qd4kRs/wBaLoEXZYEPVRI3hZHOLIS
         M8UWS5QysJ+yAWqqxY0wZ9bPRJUZBp4/Ju7l/XuRzelIF9miKiKjx6mDR8gjd892cdHm
         WBq3XPd4uln11qSwaveFpWGWLDnYbAPC3VlKqZUhVcSN9gKV5dMUIpf92tJMaS/VMX/n
         WK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353561; x=1739958361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zuOOH+cqbW5sfzyGH9UF9miBvxPH8Nl8TrZbDwlVwE=;
        b=NF2jQ4P8qcsQEhxOZxXtmGWCT18/Heo3EI2YM9AVGa9Ey7uTehFNAmzoF1Ziwc0GHo
         3MqLK60cHHqHI1wJAkbWsg6y3c3cAb7I+iDmtU/6tlvNjgMc0HzolPc6YvVdWR6vY0wv
         FdsCNwAypa2wy4zm5dJpvNAkkgnSaoHxO8xrYlVmShwb1edlSXoLhx/XhV9bEhCN14+3
         xm3szXA/UBrVEsyaWEBAm9LdHK7vmQxxN+jcZV5zX0tnjsIUoWnebEG4+iI9WT9Sqvg8
         r9OvQS0yPRG5NqD1SnqRW/p+3ci6UWFgrTsPdL5BMzuUU/WPVmvQhJ1F/haDCr+5b81R
         /+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMyzSA4TCkyfMFL8fo40WC8paF6JeVggB6aalRJQ55t/WarWGknpNqcHMqa1vYCfufD7nJ+uj/9VFi6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65l3xM1SdUw4dyyBTbbYYWDs1frdRW+fDL4AZyw+xKd4qupwi
	BOQnrKqIHcQivu+Ne1kr6/Aa5aWIakVOS7tuyCb1IWIUWZjjCFsQdc+h8Gy7J8M=
X-Gm-Gg: ASbGnctQ4z7XRjh3dsb5im9DaKJyJd6q4oDiYhsnYBusXVJbevWfiml1QkQfiZKsDxF
	K9qNelssCfGxmjAW87sXv/iyVCLzZ2WBnl+9ZLyltD0BNLheFY42PdqljHELYuEloRAWsODT3ur
	8zzRVx8ac3yfx8NvOs6zcZy+48WzsGCCSDCobuavoPGnzpAiV6VjQzr8+2Yq60pcwBLZQ79xBnp
	ydviXlc8W/H/DAofhrBBaZ055mxp+F4wEw75lLjYgOf/y0g2AdBRBJSQmbeyReMsVX+rtQy7QQh
	LZlGfux9fwAWRRA=
X-Google-Smtp-Source: AGHT+IFpt/tGI0C0Llxj6yqwoW6+UDGvasbspWqNSw5lXAH/EOQlfLcMUFUUZtUM6+ncdDrcGoubYA==
X-Received: by 2002:a5d:47a4:0:b0:38f:2065:3f20 with SMTP id ffacd0b85a97d-38f20653f83mr612508f8f.17.1739353560896;
        Wed, 12 Feb 2025 01:46:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a076496sm14262795e9.32.2025.02.12.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:46:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [GIT PULL] gpio: immutable tag containing gpiod_multi_set_value_cansleep()
Date: Wed, 12 Feb 2025 10:45:46 +0100
Message-ID: <20250212094546.11895-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi!

This concerns the patch series from David Lechner[1].

I applied the patch adding gpiod_multi_set_value_cansleep() to the GPIO
tree. Here's an immutable tag that maintainers of all other trees affected
by this series can pull in so that the entire series can land for v6.15.

Please pull.
Bartosz

[1] https://lore.kernel.org/linux-gpio/20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com/

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-set-array-helper-v6.15-rc1

for you to fetch changes up to 91931af18bd22437e08e2471f5484d6fbdd8ab93:

  gpiolib: add gpiod_multi_set_value_cansleep() (2025-02-12 10:29:27 +0100)

----------------------------------------------------------------
add gpiod_multi_set_value_cansleep() to GPIO core

----------------------------------------------------------------
David Lechner (1):
      gpiolib: add gpiod_multi_set_value_cansleep()

 include/linux/gpio/consumer.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

