Return-Path: <linux-kernel+bounces-212949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1B9068B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AC1B25EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EC13F421;
	Thu, 13 Jun 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GNKFMSUW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351213E038
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270925; cv=none; b=m7Wh3MuGDu/8EYBSTwPXJKLsjnrjvCKnrCXZLk457oACn6Zv07H5+Qw9nExgZhOIsNRByXMSRYGZBrO5EcS1R902g6AutfuXYINtVCxXdIDLXWOYZO8nsBnpM9o2vFrs7spTrwyJZKeri3f1noLwlIsZ7QZDnTTE8soyj5za8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270925; c=relaxed/simple;
	bh=vG4qRDV6pQg/Th6atlB32vTGlz7L1/BU8b4zcWJlXT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BC0t22Vj7Jguo1nVavIePHidWfhiRq0B39hYYYlS08Jdvpy6yNbqWAK8U8cBjddVrOseFJv54BRm4W0ZfExISzsfzg7Q+f3DzraDs9Z8EUy8q3ElpelqI0EdrYWqxCji2mrJQ/DkVasbTUVo0v1cbvkapw/Y9dvw80vwISluQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GNKFMSUW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so8489415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718270920; x=1718875720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTL7AN68DXuCJK85qnCP9b24mcfMbuTgeoppKNKx4+E=;
        b=GNKFMSUWkWy9RL8bJX1e55EBLWJlwKz5eK28rqMTmbqIHWBldOxrDsAoKr1g82bOxm
         59j3NULqHmCmQBrBWcl/hpGwE820D2JbCK10zP+9U5Sdx7UmjdRbGK/AzyYtHs2QZB+L
         qgBMFOkX4Th+MK3Tsky9obDv8umao1dsDel6hzmbfqBBn3iCsDmxH+eSnOuR16oAoplS
         kygN/W1NjIoF8MJBOhFeQB9SCxMINt8vKeoZ2WYfHz8Q02DMdpjIAA4enKv/swlqLEmE
         bjTPVkOCu6++iiLhY7JNok4KV636NfrppOACCyOjRDz0CICQSPyVg1ujdF+nxkDfD9K+
         pNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270920; x=1718875720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTL7AN68DXuCJK85qnCP9b24mcfMbuTgeoppKNKx4+E=;
        b=pCxmZBGoDePuW0zDcsXejFkjhcN8jC2ORF3P4UhyC2xQl4WGj+PzfziwjFeUig06B7
         L7MIao3FzL0/NFHXEsKJG1IkGMZLQKcRyAqwFIPMfqFP0N3uW19rWRhg4KAeAfxTSNPr
         DWMqsZELl7Gi/CuKFBhYWhGIrtuPwZFIXxEUJ8CI94US0sHLLQmG8yC9YFMwF2esUB3E
         3T3ZDXc9qVfTC75kBpJhkpvvD8vhvqKvLiDpBMYHa8FPWXpPsXx5G4fuS+uojC7Tn4zs
         G+9HtP3RYu08bTuw17TXVK1eroGfdr3zSmWc5HJMzGNdtFT7RXCG2SOuuKVRah78a4Po
         o+5A==
X-Forwarded-Encrypted: i=1; AJvYcCWYsbLQ2oRWvudLpTpNYkWg+OfvCo5LNBTLvuiiIQiuFboHXbagDL9hPZZU5fUqA8UZQQ6IOdqEduM7pbvb2zatdQwDXS9SM/nrj6Tm
X-Gm-Message-State: AOJu0YwX3aRcjtAaFicqUNFyDPdD92SfRg3HZioFYhVjI33kFjYS7YY+
	cVr57jlspoht6k0Y565XPOs2CSa3tsxWvVCBXEbkhQo4nlbO7VDBuvEP6SxPIeU=
X-Google-Smtp-Source: AGHT+IHyJhmfHkwmz+c60I80UBc53UKeGLW66TsVm0UYMnuExWwyR8x8YdHhjF4yErR5gdcvD6NbTg==
X-Received: by 2002:a05:600c:470b:b0:422:52c3:7fe0 with SMTP id 5b1f17b1804b1-422864aef80mr42455395e9.22.1718270920108;
        Thu, 13 Jun 2024 02:28:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:875c:e292:3280:ccac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73e8sm54990205e9.43.2024.06.13.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:28:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 0/2] misc: add a virtual driver for testing the GPIO API
Date: Thu, 13 Jun 2024 11:28:28 +0200
Message-ID: <20240613092830.15761-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPIO subsystem used to have a serious problem with undefined behavior
and use-after-free bugs on hot-unplug of GPIO chips. This can be
considered a corner-case by some as most GPIO controllers are enabled
early in the boot process and live until the system goes down but most
GPIO drivers do allow unbind over sysfs, many are loadable modules that
can be (force) unloaded and there are also GPIO devices that can be
dynamically detached, for instance CP2112 which is a USB GPIO expender.

Bugs can be triggered both from user-space as well as by in-kernel users.
We have the means of testing it from user-space via the character device
but the issues manifest themselves differently in the kernel.

This is a proposition of adding a new virtual driver - a configurable
GPIO consumer that can be configured over configfs (similarly to
gpio-sim) or described on the device-tree.

This driver is aimed as a helper in spotting any regressions in
hot-unplug handling in GPIOLIB.

v7 -> v8:
- move the driver to drivers/misc/ as it's not a GPIO provider and so
  its place is not in drivers/gpio/
- rework the data structures to make them more compact using unions
- use correct string helpers for given use-cases
- drop dependency on the gpio/driver.h, string.h and kernel.h headers
- add a patch exporting to_ext_attribute() to be used by this driver
- various minor improvements suggested by Andy
Link to v7: https://lore.kernel.org/linux-gpio/20240527144054.155503-1-brgl@bgdev.pl/

v6 -> v7:
- this is a complete rewrite of the original idea, the entire interface
  has changed so it warrants a new round of reviews
Link to v6: https://lore.kernel.org/linux-gpio/20230817184356.25020-1-brgl@bgdev.pl/

v5 -> v6:
- initialize the flags temp variables at declaration and hopefully make
  Andy happy finally :)

v4 -> v5:
- add the gpio-consumer docs to the admin-guide/gpio/ index (reported
  by kernel test robot <lkp@intel.com>)

v3 -> v4:
- fix the toggle value assignment
- use guard(mutex)() wherever we can return directly from the subsequent
  function call
- use skip_spaces() + strim() to avoid having to do a memmove() when
  stripping strings off whitespaces
- DON'T try to save a couple LOC in ifdefs if that makes them less
  readable (Andy :) )

v2 -> v3:
- use cleanup.h interfaces
- add some clarifying commets
- more minor code tweaks

RFC -> v2:
- add documentation
- fix various issues pointed out by Andy: use struct_size() where
  applicable, improve the logic when storing the 'live' property,
  improve log messages, remove commas in terminators, etc.

Bartosz Golaszewski (2):
  drivers: export to_ext_attr()
  misc: gpio-virtuser: new virtual testing driver for the GPIO API

 .../admin-guide/gpio/gpio-virtuser.rst        |  176 ++
 Documentation/admin-guide/gpio/index.rst      |    1 +
 MAINTAINERS                                   |    8 +
 drivers/base/core.c                           |    2 -
 drivers/misc/Kconfig                          |    8 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/gpio-virtuser.c                  | 1790 +++++++++++++++++
 include/linux/device.h                        |    6 +
 8 files changed, 1990 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-virtuser.rst
 create mode 100644 drivers/misc/gpio-virtuser.c

-- 
2.43.0


