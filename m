Return-Path: <linux-kernel+bounces-517855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F129A38699
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2184918852CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E822259E;
	Mon, 17 Feb 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="igW3WC+o"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A421CC6E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802963; cv=none; b=pJ/VhnF7mY3IXk5lERWk/clHSz6eYDyHGVTPqDNFa8qWKMSfPGOSngU9tWoADMdglsc5tecUz0iw33VtDMvjvlWv0isX2yPq+r5XdpKjUi61Wv5ZNXqsnZl4o1czQ7QOqcU8jvNHZqSgiVEYehBGiQxjfbfTl5uDrmoUddiDNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802963; c=relaxed/simple;
	bh=BM2CSxb7N5pqm6p42nJmt/YYjT9Qumv4OkJPFTX5QIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSXpSyRv6BzopKMiSYfQFPYCbue6MmYIj0Z/EocQJpxrylZ0qY49xCQRz7TYUGpVX7GjmoHxG0XASDzposNibCEzGJfhCy7Bu0zVudfQ9W9UYiXTZ+3t5lOStxK8FH4YzVZVbOn9XWAHF/7NIhu1juZNF4G/9cHykcznsoTSctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=igW3WC+o; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 66CCC3F87A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802959;
	bh=dMBLgDkz0A5YbnEhUGrVChjAwgvWPge21MGfIezidWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=igW3WC+odbfvzYf77Age0a5RXV0wTk7e0N5UzApUdX2Y+jDnb/CBpaZ7ijfps24sw
	 WUgzOBsSUnbaYY4txxAV4vRvI+1iKIDWnNvDnKwm86Uf/YKuCRZBOYcDhIqgyj+Epa
	 +aJcYsk6XhcFmCA78sX0neTTwpL0oH6czm0bgsI/wer53qdPqpzhJ6/5nOP7aqr53G
	 Pn/JZOV7Z//YQElRjzkkNXZtjiWUoMLPYoVpN5NvjOVrcE0QQPt59FZ+H1ea78bX8s
	 y9rHB+ZHQ2y6JWmj5LBtQgGTwXCThtaF0Zz1V8wnRZDmHRmmT5cYDymdX+YjZyhFEO
	 ejQ6Clo+thcmg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc45101191so3526790a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802958; x=1740407758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMBLgDkz0A5YbnEhUGrVChjAwgvWPge21MGfIezidWg=;
        b=tt9d3fnG3KdexsxbVY6irqYYD/90fUk82btN3CvmE3uEdh+Wb6QCyrXFhJG7R0I2wd
         wnCba9dcZ32XMD8NATnVdAN8N9kmsmikXTvQMGmw/5ebfSd9kkfIOcipCngjwqXS5+Rf
         7HPy1zB3ZE63hPJWrOgdDWVjjwqt6qL9gQ0nXEZmppmzWb+Jk7auJT7jMve2lOBNATuj
         x+ldlY2LIZUIo5w5YZpz30iC6Y5zWo29Hn/tRJaDainlRxfxYSQzkCtHUnF1/XRvLjMU
         q5rT3LAo4IBsiroc4l9jaZCw8GBk1UlQOxU/68KQ48OBJDbrhnBlCrFq8KkqNdXIwUIf
         tcqA==
X-Forwarded-Encrypted: i=1; AJvYcCXcRE4+E118n0C8zdaisN0aUO5PL270bEsmXfWQ/THjHeR2/A/jDo6/gs4E0DrsCr1nQHc0+vNP+aAvfQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92tVFZpDFZZDVS5tqACU/ygBsdTDDZqwYKMoViIznps5OYcU2
	MFq7A610mjII+6g5zB5oc8UYmhc0fDWAPrwee1kSTU2KBvhc48l2OVZF2PNU7Np8WqhxiE4ABhz
	a7EKRKiJAvozIUGK8gkz9s6iHOK6svtkjCIm2Lfgwxrm6KXQULsmKsU3bffsivfU7a3si+x3RE0
	4jYA==
X-Gm-Gg: ASbGncv5xxFWXxEQBc1RFDFGctj6lrSNLvL4JwFhuQlzhW3EwH/ohdWtOz2r3Dhg3wk
	TgAOMzAohdTN0P5+05eAKj7NTf9Ctuood0xDzU4+24WPEBMze/3GiRodBdYgdEM2r6mRKumzsSW
	bUTbuIKCH2xs83qf0MTh+cPje6HDDmkBxpE3ZACBUrmGUZpEx9gmZXXbStsISd6ilxwXJyN2S8g
	6OdLDqS74+J3h27riyR/UyJbM+1zwHus6WCk01X0ITg5NybP0QBJG98/F2iuPp0rKsxKiqt/4IZ
	piuqmeJSFoRVbG4N+xPtrzQ=
X-Received: by 2002:a17:90b:1b46:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-2fc40f2348fmr13617189a91.21.1739802957940;
        Mon, 17 Feb 2025 06:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFftwwq+71n4gUy7mQf/w0JWNAP8EgVRNmSYeagqnLqCAIOKagB39UyHmiXqX21wm0Ic9SYJA==
X-Received: by 2002:a17:90b:1b46:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-2fc40f2348fmr13617159a91.21.1739802957529;
        Mon, 17 Feb 2025 06:35:57 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm10057757a91.6.2025.02.17.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:35:57 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] Introduce configfs-based interface for gpio-aggregator
Date: Mon, 17 Feb 2025 23:35:22 +0900
Message-ID: <20250217143531.541185-1-koichiro.den@canonical.com>
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

This v4 patch series includes 9 patches:

  Patch#1: Fix an issue that was spotted during v3 preparation.
  Patch#2: Reorder functions to prepare for configfs introduction.
  Patch#3: Add aggr_alloc() to reduce code duplication.
  Patch#4: Introduce basic configfs interface. Address Issue#1 to #4.
  Patch#5: Address Issue#5.
  Patch#6: Prepare for Patch#7.
  Patch#7: Expose devices created with sysfs to configfs.
  Patch#8: Suppress deferred probe for purely configfs-based aggregators.
  Patch#9: Documentation for the new configfs interface.

N.B. This v4 is based on the latest gpio/for-next commit as of writing this:
     * f04867a5d0d3 ("gpio: loongson-64bit: Remove unneeded ngpio assignment")
     and depends on another patch series on top of that:
     * [PATCH 0/3] Introduce gpio-pseudo, common utilities for pseudo GPIO devices
       (https://lore.kernel.org/all/20250217142758.540601-1-koichiro.den@canonical.com/)


v3->v4 changes:
  - Splitted off the introduction of gpio-pseudo.[ch] and conversions.
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

v3: https://lore.kernel.org/all/20250216125816.14430-1-koichiro.den@canonical.com/
v2: https://lore.kernel.org/all/20250203031213.399914-1-koichiro.den@canonical.com/
RFC (v1): https://lore.kernel.org/linux-gpio/20250129155525.663780-1-koichiro.den@canonical.com/T/#u


Koichiro Den (9):
  gpio: aggregator: protect driver attr handlers against module unload
  gpio: aggregator: reorder functions to prepare for configfs
    introduction
  gpio: aggregator: add aggr_alloc()/aggr_free()
  gpio: aggregator: introduce basic configfs interface
  gpio: aggregator: add 'name' attribute for custom GPIO line names
  gpio: aggregator: rename 'name' to 'key' in aggr_parse()
  gpio: aggregator: expose aggregator created via legacy sysfs to
    configfs
  gpio: aggregator: cancel deferred probe for devices created via
    configfs
  Documentation: gpio: document configfs interface for gpio-aggregator

 .../admin-guide/gpio/gpio-aggregator.rst      |  107 ++
 drivers/gpio/Kconfig                          |    2 +
 drivers/gpio/gpio-aggregator.c                | 1129 ++++++++++++++---
 3 files changed, 1050 insertions(+), 188 deletions(-)

-- 
2.45.2


