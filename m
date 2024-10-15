Return-Path: <linux-kernel+bounces-365294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7799E017
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6713A1C21B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE93D1B85CC;
	Tue, 15 Oct 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oaXmON88"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032F3A1B6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979239; cv=none; b=N6PWZliq8n+bpgcv3T3z54GTKogliVuXHeoqt+o8pMNLk78OoKx4loMIsMaTzIktP+3y8a7mvPqubafQzDQvsF1wSxqdjjOtJ/cczdvPreQA6RSRNpiln4x/ctGptscj38+6E65aaL0o2+UK0+IZudbuRcU0DIHOPIvRTSsarYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979239; c=relaxed/simple;
	bh=e5v16J0sipNx+aDLI74gwY8wRKJaBVQip8tsOK77+BY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XLM596AR7FmHzFsWTTMoV4VxVU9n0bSTImmLmkOUYFAv67wTkCjYIZ7z6fXsNt1OLUrsolNAtmLPEnm2fQz4fSfPl4FOK7mdT7P+Za+bIsdHankvPYo+7WZ+WhScTG8OT0pLTtxwaImKSp1fWSRgsQFKVfFiWgmZRkH25pSIPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oaXmON88; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4311420b675so46464105e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728979235; x=1729584035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CY4FKmj2YMMF5zf9TZeG3DVrkbZ9+e6ZGAQCNvDc0GA=;
        b=oaXmON88Pt1q88LcaJhnyGmvIw6HRbaA4jH5/vpB5czPckTLdO2uDPEnRERkch6rB0
         6npsdudr+vSHWmOZ0hXLckt8ciGAS9jJS08wH1MMFWkZSfWwKIdM42rrrEjAVp/RwOcK
         HMcMJXQSh2nXX0rC8gRkBJ/RqiNQSxNFRYSFPs6UBPQ8uF5k1zMu7YfCwHFeYFSKdk7w
         3LtmYd7DRnzmDC1TTDpQbPlesHVEajdQ18xaDWOrbbWCyMkAZRu+4CDIVL48PpvqhVqN
         uR+RXi28viW7Wy0bd0AB5S4cV0hSib63Xw+I/6z4MP8epA58Ex3kLWzIsXYk5GK4pAv9
         3gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979235; x=1729584035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY4FKmj2YMMF5zf9TZeG3DVrkbZ9+e6ZGAQCNvDc0GA=;
        b=E6sSG4M3nBn0t46JuuKTuDZT4Z+SY9gDDZ8z+KbeEyxnbyBToGpcAeJd345sWOUF2k
         cwgWCB9MOJhq/Qw4HRkwoObJ9WGsYvD6P17f4MA0Jx1ij4TtSZ2quy5LoXNQ4PNBaa7w
         tt8BO61i1crKMyGaBkxFKu4VA6KBzW4kIdiqQUH5oa4QMWHTxbJpsTMQUG4Fiuvtj0nl
         qUbgCF/wiYrwFsC28hcpxfzoNGXxTCFBAE5k+Ydu8o5PcvJJOinYbAUwFfllYB0Xrkmf
         oUyv75ZZivCswdhb3dWTYX9c6EiSR0Rq6uB1vZ0dQGHNFp8nBHZw+L3Y9rKZtQMnTqcf
         q+AQ==
X-Gm-Message-State: AOJu0YwVZoyMGH1UkzF/HOEmXWl3CBP1NCVdsF6R7L9hAfVBOwOQbXKf
	tt/VqW89w7L5+iW9xaTjWhWDbnhtBoVMoE1dEtyMm2DVQk8LPfRBWh3czOb2SZ8=
X-Google-Smtp-Source: AGHT+IHyhmW/ilrGHruKB1dH3jgSRq7HaLgnqCuA5mHdPU2Ga6qa0XjiZ9PpKb2vRaDgmVOiY+J5tA==
X-Received: by 2002:a05:600c:6006:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-4313927d1c2mr24601355e9.2.1728979234620;
        Tue, 15 Oct 2024 01:00:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5531sm9962385e9.46.2024.10.15.01.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:00:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] gpio: create the /sys/class/gpio mount point with
 GPIO_SYSFS disabled
Date: Tue, 15 Oct 2024 10:00:22 +0200
Message-Id: <20241015-gpio-class-mountpoint-v2-0-7709301876ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYhDmcC/x3MQQqAIBBA0avErBsoMYiuEi1MxxooFaciiO6et
 HyL/x8QykwCQ/VApouFYyhQdQV2NWEhZFcMqlG6bVqNS+KIdjMiuMczHClyOFA509tOe+NngtK
 mTJ7v/ztO7/sBaJWZuGcAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3172;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=e5v16J0sipNx+aDLI74gwY8wRKJaBVQip8tsOK77+BY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDiEdTi+n199Z4FaR2Gd6NG4jKhbNN8jSmd+k7
 NisKqncbW+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw4hHQAKCRARpy6gFHHX
 crQWD/98xWmRdCHVUK/+q8cuyu4XbbX92vVFfaI44vl9PeJxO5+x/oMUyTub4Axa9CEI3vZXQgA
 MAEBM7bx+4WxcMF2nidSpiIAGapmUgm1HffBFSzv2Jw7aXQm4++SFieONdRq32hwG+UY5WFXoKG
 +yVkIuWoH5VZRKhC2sueuIwH65Czuip7H9eZKqeOATXSJW5EvDGuzaU7mS+hY9pcEemNEBJbJej
 uMkRPbzc6lFzGgWTMZGZmQFc8AKBPyzd1hQCCAH9pvQjmKTHaswYz89luN99qDl8/FeTrXqnZpS
 5S1BpZjJahTQYIqNB7CoNPbvts+/7xlsypH3hR+47BoT4zI95ScTL/mt7bB+I0s3KSArNpfVdSr
 m12yc+BaoXgSEXVyD+q/4FSQMQK5tfODsbJi0pPbyfxSIzUmi5xxhiH1E8CUUtZstiQKY/6R9KX
 PDs+Gf5lo4QwImlqFLfzTgPkBMDR6987op7ZoH2B7mQQ1hutBGtyJUodWAXxvokMcpJX7xQ/2L9
 myY7pz9d8/miEGIRdYlFa01kvLf485uuuxPThCOeXhyuFIy90Pz2KjRekTAbw7Uhg1cXWOprKKU
 MIFR1yM07X/ISxRgTeqAk8TiZKVn+JOVU/ZcLU0L5ImY8S40JyaMnXTQfy0jfwAz/ONlOmLxphD
 yssOp8W8y50zEcQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Greg, Rafael,

The first patch in this series is small but may be seen as controversial
so here's a little backstory.

We have two sets of GPIO APIs currently in the kernel: the legacy one
based on numbers and the modern one using descriptors. Our goal is to
remove the old one from the kernel to which there are two obstacles: the
first one is easier and consists of converting all remaining in-kernel
users to the preferred API. This is tedious but it's all within our
control, just demands a lot of effort. The second obstacle is much harder
as it involves removing an existing kernel uABI that is the GPIO sysfs
interface at /sys/class/gpio.

Despite providing a number of user-space tools making using the GPIO
character device easier, it's become clear that some users just prefer
how the sysfs interface works and want to keep using it. Unless we can
provide a drop-in replacement, they will protest any attempts at
removing it from the kernel. As the GPIO sysfs module is the main user
of the global GPIO numberspace, we will not be able to remove it from
the kernel either.

I am working on a FUSE-based libgpiod-to-sysfs compatibility layer that
could replace the in-kernel sysfs and keep all the user-space programs
running but in order to keep it fully compatible, we need to be able to
mount it at /sys/class/gpio. We can't create directories in sysfs from
user-space and with GPIO_SYSFS disabled, the directory is simply not
there.

I would like to do what we already do for /sys/kernel/debug,
/sys/kernel/config, etc. and create an always-empty mount point at
/sys/class/gpio. To that end, I need the address of the /sys/class
kobject and the first patch in this series exports it.

The second adds a Kconfig switch in GPIOLIB and code that creates the
mount point.

I proposed creating an empty class stub in v1 but figured that a proper
mount point will work better.

If this is ok with you, please consider leaving your Ack or taking
patch 1/2 through your tree and providing me with an immutable tag.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Changes in v2:
- Don't create an empty class but use sysfs_create_mount_point() instead
- Link to v1: https://lore.kernel.org/all/20241014121047.103179-1-brgl@bgdev.pl/

---
Bartosz Golaszewski (2):
      driver core: class: expose the class kobject
      gpio: create the /sys/class/gpio mount point with GPIO_SYSFS disabled

 drivers/base/class.c         |  6 ++++++
 drivers/gpio/Kconfig         | 18 ++++++++++++++++++
 drivers/gpio/gpiolib.c       |  6 ++++++
 include/linux/device/class.h |  6 ++++++
 4 files changed, 36 insertions(+)
---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241014-gpio-class-mountpoint-2da8c54fafbe

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


