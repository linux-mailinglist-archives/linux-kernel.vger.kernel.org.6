Return-Path: <linux-kernel+bounces-525943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59960A3F7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3165A1650EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12911BD9E3;
	Fri, 21 Feb 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uU7Z6Lc/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174353AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149282; cv=none; b=HDg6VFLclRwOh0ZziXpQKiPN5lKRehhYcccCiVyhB335Je5g7LCW0wrpjU15J2ZqstUd2B792CIaJm3odvb2sbvM/S9PNnzK0UW46z+x0b1Ee0hXYIcX8e6Nmn09/5RczllrmswZr/k3t1t5eg4xAe2qz1pb0hXGlj6Kq6eAsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149282; c=relaxed/simple;
	bh=VJc2fD5OV7xtJnzZHXcMaP4k2Fxqrl7cLt4EomVW+yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoHtNRRiHzh02badJJLpcX2SWtsYoobs75EZGhLPiFOCwWQabB8F3oazaMSBasWn7u0DmHdWgbDx8MTMZNAJAK93YvDyLvSLh7C9/ok+VA60i+va7wv30vXN4EGoVkYkbw9BpGDHYaPJp30p1w7ybIYtYr/6y5eQ6rXu7rdGORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uU7Z6Lc/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so19132095e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740149278; x=1740754078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHIl+3dGIE27mXpj3uMGQAy606qGwuorLow6X3a4wQA=;
        b=uU7Z6Lc//HK/B+fyKRd9vNxCF8psr3VBmDzlhyn+lu7FSjWbmWH9Fr+5sWoIdFqRZn
         TYx6TYFCISuYrZElVqAUYnXLZaz3D3fcJJuFZynxqKPEwLcWv4X/XgeYSaPWtMP9c7Bf
         povI1yVtD8d0DwCEZD0hVL+093hef1OGWJirICBFwsi9gfs0xZkX8XyHW83IXp7MQVZx
         SWJvv8ul82eMRWhoGQqRA0GkfeedrE20PIkOGyAu4Zo9HsjlxFtMP1p+NQNrmCgfGt/G
         7C9j66E/LE7xWJVNQh81qh88wGiYHyVJPtVY9h9MNfUJJmZUn2jksXa/TlSvUSX++Yya
         pCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149278; x=1740754078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHIl+3dGIE27mXpj3uMGQAy606qGwuorLow6X3a4wQA=;
        b=jmEnag8vqb00cISU1XMHSfxP33bt4YYfnRCPHHBBn9x3Q/xVCnNkEdWGAn7d83aLGj
         yq3slN2OamMd/Zk2wlhLiWTakEhjWkmc/J1O6IlJsjsjh70C6vW3aL1Fnr+8J2QVD8WO
         c2Ju5isK4ygYMlepgYNY7N74aD0WEFzLMoMHNjTt3D+shW6keMgaO3T7IpEf2/5oNj3Z
         jseZ1hI7enf39oDZjLGJS8D9NYWVX+pIDx3UYTaIm8nRd1xlc/7Et0qGBOLsG4mvh6oD
         m9itgkQuL1hxtiiBTHwa9YwPe+xGn1ZIikR9rsPPWSRcd1r2ogjyXhVTbcj+ovk+kA0j
         SxZw==
X-Forwarded-Encrypted: i=1; AJvYcCUQpXm/MQvunz7Q1HLcMHKs9iFi92EndgJpRizumy9doZbtMfypKxIogm8OgPnRKc7ViWFVasl8MVsugmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeKIjYfZya28vv6JIXAEUQyPxqT2MOEWSjV2a8vt370pdFSvr
	6XhfnjjEKiUdJi0jYgfg9a4C056jQ1rWAwpxQBqR+NzzWgE0yTeBgyilpSHmj2g=
X-Gm-Gg: ASbGncto7y92uem/oHlEy9tsatuJFSVBt7UQ8naG8MtIkFlJdzSzLV8hjuuLrtFjKW4
	YkbTCbSvdqdPYJA6HIdmzHP8cywNxQ8JQM5RvUVVOWwVCRr7HD9+sANnFYZynK66vU/1GNOyhwG
	09OdpFZkuZY0y3rtyhChq1+VS4C6UURsfyUId5rNYgv5j7fQfYr75vdLkQq45O4iHAoIHv4cgOG
	VECJddIcnSMbJysLeUO/3qEaq9EaSMhO6QD1Ssa4rLZlNTqgHOKtTPpdIAjuAPrS5HAjg6v+0XH
	jBXYi6hgb9CGXFwqROBiOgdunQ==
X-Google-Smtp-Source: AGHT+IGZ83OKySBHkM2i7Fteix9HZI2XYcQ7YK7UCGOFlxTyWB4ysreuxLKAdoAc9mvwA33dt4t4AQ==
X-Received: by 2002:a05:600c:4f91:b0:439:98b0:f8db with SMTP id 5b1f17b1804b1-439ae1f1903mr36508685e9.16.1740149277752;
        Fri, 21 Feb 2025 06:47:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6cbc:77f7:6f0e:5a7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399be79d92sm57998475e9.0.2025.02.21.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:47:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.14-rc4
Date: Fri, 21 Feb 2025 15:47:50 +0100
Message-ID: <20250221144750.108147-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the upcoming RC. There
are two fixes for GPIO core: one adds missing retval checks to older
code, while the second adds SRCU synchronization to legs in code that
were missed during the big rework a few cycles back. There's also one
small driver fix.

Best Regards,
Bartosz Golaszewski

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.14-rc4

for you to fetch changes up to 96fa9ec477ff60bed87e1441fd43e003179f3253:

  gpiolib: don't bail out if get_direction() fails in gpiochip_add_data() (2025-02-20 14:08:18 +0100)

----------------------------------------------------------------
gpio fixes for v6.14-rc4

- check the return value of the get_direction() callback in struct
  gpio_chip
- protect the multi-line get/set legs in GPIO core with SRCU
- fix a race condition in gpio-vf610

----------------------------------------------------------------
Bartosz Golaszewski (3):
      gpiolib: check the return value of gpio_chip::get_direction()
      gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set
      gpiolib: don't bail out if get_direction() fails in gpiochip_add_data()

Johan Korsnes (1):
      gpio: vf610: add locking to gpio direction functions

 drivers/gpio/gpio-vf610.c |   4 ++
 drivers/gpio/gpiolib.c    | 100 ++++++++++++++++++++++++++++++++--------------
 drivers/gpio/gpiolib.h    |   4 +-
 3 files changed, 76 insertions(+), 32 deletions(-)

