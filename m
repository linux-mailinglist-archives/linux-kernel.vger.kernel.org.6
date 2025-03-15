Return-Path: <linux-kernel+bounces-562662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087EA63024
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBBC189A4CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF22204C13;
	Sat, 15 Mar 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oM4FXyIf"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E41190678
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056905; cv=none; b=AegT4treySYbec6+a0iI44h3Ftu2bPIrFvz2FEr+G+4gsDv8xT0KpoQoPXAXsRXWp72BFLRCFmrKH9dp6h4duMTWpNH5ft+XwDeP3sadCGirsIOcAvXW/TprDhP+6Y8KnLla5QxDT0r0GD259S8nt6saKGeWujv6fCecy5+2rvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056905; c=relaxed/simple;
	bh=Z++6unUzD7r2i7Ald3FvHt8fiDQX2+T3QIsDOBUYxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2PpSyYtpzTcNXpZDCDs+zG4BGps9c+ZYKXtd4L9XLCk4/fq06atcH7GGdZAfUiuZrRDE4vIgqWg14r5IqaXM5D91o2GN1xo4wIliIfXJWA/NfDkQ7IIUROJsgswGDw+xAbtbN0JuigT54OTTVwKvi6OswnucAzqtOKoUR4kp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oM4FXyIf; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CB4D3F129
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056894;
	bh=a7gC6InKkSZunt4RwI6mh+p9wkYGFvKYJwvCSiCnLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=oM4FXyIfLsQjZ0esSxn5JlANaGWqXV7GGV6LM93AB+49f2gbzUAxJZ67sWfoJFOrT
	 wmdP5zfo+PcSEdMtEfrw6ftKBL7pg2De2MqlW+A2RwZKh+X/FsA94s3OnTP4Hf5d4w
	 8tK1GyRFM3eGTEES4uCxhwcAETmvWSy0ayLDV0xa11jPxFN6XE6mMnETARl6fIA9Jr
	 VwXv8JF5Dh3jUQmcZOcKJhJ2re7swZBSgUbvg/naw4kcgmN9GsfzOm0kyztjwt24al
	 XBN04otH9YxTrMtXdRRsd+yLZvs8LGa4/eJIjng6z5/0nYg919A3++7ypAK4aSs1uL
	 lw194/QlUu5bg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223a2770b75so58381245ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056893; x=1742661693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7gC6InKkSZunt4RwI6mh+p9wkYGFvKYJwvCSiCnLdw=;
        b=K4Mcj7UprBqQ4yNbEqUHnAADmDfw7hZEM6UpVdiigBDevHRuGCl/9gMtR89omSJ1Aa
         ip0vyuNi34RZNns7GT54LyXnJG8YtgYN1z4aq1rNpWyTvRoQnPu24LIlFF5h0bC292ST
         JKFJCvw6LpKfspgd4GDtcz62IlIm8LIzuvCMvvm7JOeVGTdYRa0ZOIwKE9AOBWq2TFcd
         4KJ/JOViO78njBzPtc9werxGLPbbaEUEfGBzBlRW0kRO2+Ll24HOwZrCkPWgF6pMEZuh
         f8yEw3ZSfHQmsJP6TC+h6nKtZ45g9x+fWvFKWYc3Pcbiyk48FKhe00/u0oJgZjGE9uH1
         9npg==
X-Forwarded-Encrypted: i=1; AJvYcCWaeomEoX4yxBG0jfQcSByLmZpWrOpf0l+MqVD/2dyKrNweJ/I/MTr8mdvou3xmFeIM2/x1RbuzBU7gnmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgVOZLavEGRBCIovNx9FlIjooTNP3UWCQd/hufyeuPypTw+wA
	8h2VrmV7J5CoC/kDUGWIFXJhahpn5wLa5lxI/orFwcdUmOMjA21Hv1M7X5X4Z7xsrA6AV3qE368
	1ayG59tqO0+r2fcrOO3jtjkJOZW/StZQSxNxxcudQfNMgdNRWW6kAY9M8VJMFImxSk37uSRnryR
	2vzw==
X-Gm-Gg: ASbGncszdMgEvJoQ/KFZnelZkX6bNDiFeCCwTyboYnO2SCaSoQdGtM+vMWX6pu5taCN
	8VPSHa/JmJrIBq5bJwi/RVT69Q0PqEZfhJhVmiSK1WqYpOTzZcNUNnhfdU7gxYdS+GC8q588Uer
	7eTpwAn4egUrRIXltFfogHWbgO6pquq6R4dkQTZk5TYKr3A+9iZ8qtPrrTTYuUVYGfgGpHQBAkb
	gart+pjqgIesIegOq/QNEyImvF17l57f8vow7ttT8fNwteGDmB4r+r1mwpteLF1rNx66ONjnxEV
	MC5Wuo2d68a5jnSe
X-Received: by 2002:a05:6a00:3981:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-73722380967mr6778386b3a.13.1742056892732;
        Sat, 15 Mar 2025 09:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuymFzG/Jpdc8Uehgh10jJ41sXtPIFgAmKjlQiY40nHN6Rd1NKGJR14VYZh8fQmO8mdBd6PQ==
X-Received: by 2002:a05:6a00:3981:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-73722380967mr6778371b3a.13.1742056892356;
        Sat, 15 Mar 2025 09:41:32 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:32 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] Introduce configfs-based interface for gpio-aggregator
Date: Sun, 16 Mar 2025 01:41:14 +0900
Message-ID: <20250315164123.1855142-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a configfs-based interface to gpio-aggregator
to address limitations in the existing 'new_device' interface.

The existing 'new_device' interface has several limitations:

  Issue#1. No way to determine when GPIO aggregator creation is complete.
  Issue#2. No way to retrieve errors when creating a GPIO aggregator.
  Issue#3. No way to trace a GPIO line of an aggregator back to its
           corresponding physical device.
  Issue#4. The 'new_device' echo does not indicate which virtual
           gpiochip<N> was created.
  Issue#5. No way to assign names to GPIO lines exported through an
           aggregator.

Although Issue#1 to #3 could technically be resolved easily without
configfs, using configfs offers a streamlined, modern, and extensible
approach, especially since gpio-sim and gpio-virtuser already utilize
configfs.

This v6 patch series includes 9 patches:

  Patch#1: Fix an issue that was spotted during v3 preparation.
           (Not present in gpio/for-next, so retained in v6.)
  Patch#2: Reorder functions to prepare for configfs introduction.
  Patch#3: Add aggr_alloc() to reduce code duplication.
  Patch#4: Introduce basic configfs interface. Address Issue#1 to #5.
  Patch#5: Prepare for Patch#6.
  Patch#6: Expose devices created with sysfs to configfs.
  Patch#7: Suppress deferred probe for purely configfs-based aggregators.
  Patch#8: Documentation for the new configfs interface.
  Patch#9: Selftest for gpio-aggregator.

N.B. This submission is targeting at gpio/for-next and is based on:
     commit 21c853ad9309 ("gpio: adnp: use new line value setter callbacks")

v5->v6 changes:
  - Addressed feedback from Bartosz:
    * Resolved issues spotted with lockdep and kasan.
    * Added kselftest for gpio-aggregator.
  - Fixed a memory leak in aggr_free_line() (missing kfree(line->name)).
  - Fixed a bug I mistakenly added in aggr_parse() (misplaced scnprintf()).
  - Eliminated a potential lock inversion deadlock by removing
    gpio_aggregator_lock acquisition in gpio_aggregator_remove_all(), which
    became unnecessary after the upstream commit 12f65d120350 ("gpio:
    aggregator: protect driver attr handlers against module unload").

v4->v5 changes:
  - Rebased off of the latest gpio/for-next, that includes the patch series:
    "Add synchronous fake device creation utility for GPIO drivers"
    (https://lore.kernel.org/all/20250221133501.2203897-1-koichiro.den@canonical.com/)

v3->v4 changes:
  - Split off the introduction of gpio-pseudo.[ch] and conversions.
  - Reordered commits to place a fix commit first.
  - Squashed the trivial update for gpio-aggregator's conversion to gpio-pseudo
    into the primary commit "gpio: aggregator: introduce basic configfs interface"
    as it is only meaningful when combined.

v2->v3 changes:
  - Addressed feedback from Bartosz:
    * Factored out the common mechanism for synchronizing platform device
      probe by adding gpio-pseudo.[ch].
    * Renamed "_auto." prefix to "_sysfs." for auto-generated
      configfs entries corresponding to sysfs-created devices.
    * Squashed v2 Patch#3 into its predecessor.
  - Addressed feedback from Geert:
    * Factored out duplicate code in struct gpio_aggregator initialization
      by adding gpio_alloc()/gpio_free() functions. Note that v2 Patch#7
      was dropped for other reasons as mentioned below, so aggr_free() in
      v3 is unrelated to the same-named function in v2.
    * Removed redundant parsing of gpio-line-names and unnecessary
      chip->names assignments; squashed v2 Patch#4 + v2 Patch#5 into v3
      Patch#9.
    * Updated to use sysfs_emit().
    * Updated Kconfig (select CONFIGFS_FS).
    * Fixed typos, coding style issues, missing const qualifiers, and other
      minor issues.
  - Resolved an issue that was spotted during v3 preparation. See Patch#2.
  - Reordered resource initialization order in gpio_aggregator_init() to
    both eliminate a potential race condition (as noted in the source code
    comment) and simplify the code. See Patch#8. This enabled:
    * Removal of v2 Patch#7.
    * Merging of aggr_unregister_lines() and aggr_free_lines() into a
      unified function.
  - Disabled 'delete_device' functionality for devices created via configfs
    for simplicity. It was mistakenly allowed in v2 and proved buggy. See
    Patch #8.

RFC->v2 changes:
  - Addressed feedback from Bartosz:
    * Expose devices created with sysfs to configfs.
    * Drop 'num_lines' attribute.
    * Fix bugs and crashes.
    * Organize internal symbol prefixes more cleanly.
  - Split diffs for improved reviewability.
  - Update kernel doc to reflect the changes.

v5: https://lore.kernel.org/all/20250224143134.3024598-1-koichiro.den@canonical.com/
v4: https://lore.kernel.org/all/20250217143531.541185-1-koichiro.den@canonical.com/
v3: https://lore.kernel.org/all/20250216125816.14430-1-koichiro.den@canonical.com/
v2: https://lore.kernel.org/all/20250203031213.399914-1-koichiro.den@canonical.com/
RFC (v1): https://lore.kernel.org/linux-gpio/20250129155525.663780-1-koichiro.den@canonical.com/T/#u


Koichiro Den (9):
  gpio: aggregator: protect driver attr handlers against module unload
  gpio: aggregator: reorder functions to prepare for configfs
    introduction
  gpio: aggregator: add aggr_alloc()/aggr_free()
  gpio: aggregator: introduce basic configfs interface
  gpio: aggregator: rename 'name' to 'key' in aggr_parse()
  gpio: aggregator: expose aggregator created via legacy sysfs to
    configfs
  gpio: aggregator: cancel deferred probe for devices created via
    configfs
  Documentation: gpio: document configfs interface for gpio-aggregator
  selftests: gpio: add test cases for gpio-aggregator

 .../admin-guide/gpio/gpio-aggregator.rst      |  107 ++
 drivers/gpio/Kconfig                          |    2 +
 drivers/gpio/gpio-aggregator.c                | 1155 ++++++++++++++---
 tools/testing/selftests/gpio/Makefile         |    2 +-
 tools/testing/selftests/gpio/config           |    1 +
 .../testing/selftests/gpio/gpio-aggregator.sh |  723 +++++++++++
 6 files changed, 1800 insertions(+), 190 deletions(-)
 create mode 100755 tools/testing/selftests/gpio/gpio-aggregator.sh

-- 
2.45.2


