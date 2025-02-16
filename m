Return-Path: <linux-kernel+bounces-516581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62728A37448
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F0169A02
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507F191F84;
	Sun, 16 Feb 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZcyZa6Ve"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D033190051
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710718; cv=none; b=MedIXBc+zx+L2+q8l+3VPu2inb+S3d2G0o1Eu1dF7heyPCOdZpvI7KTPFsLpL1qpGGp3fP1qawvmAfcSu1fZtObOH7z1UrEHb7msqyzNjXyVW8ipL2er/gNekr5L7mF6TBTy/KT+Yee9qpn0TGHzqJRU5Uf/3RfG8tfHIT+VDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710718; c=relaxed/simple;
	bh=Y3Eq5npod820HDDk+whumboey0KpP+cmOx47ILQ2Mn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z26nNYUohMhlwFF8fjrYQGLheJikRbb+HLzZyTX3G0RJXM9wzY91gyOtmTWlEbW9VeEi3RlJNxXvM3+MDkzx7tDCrfIp/yLd/w1kmBY0o5I9NsAgGiUmZuvfbTcCMgMRJ4pM9KqIJeqaIyOXq+g1l362rXPZVoVwH/VR/yN57WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZcyZa6Ve; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E3683F175
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710708;
	bh=PGgtoygEZyqOFgPwIgdXQ26igU8BH6DrWQjW4Xtuubg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZcyZa6Ve67ywZ6pUZe/mjRnTB0SXhdrjl9UyBoXevZxODdVozMNQeuymifht8gpmu
	 4LQ0svN9erH/+NRupuk7YqPaolq4UeyFYucnK/wpw7b0FK1WpneMZOlX+Bozscjk8w
	 2isiUqEngMfkrTYtH1xI1mUk376EQEIY1E58Ei0IvmFeFqcgbSixJmEK1sHOrZz6KL
	 zeJEW/6EvwWeWiGfNOfHgW0H+nOjLgwwZ95VNrUlRlPf6KzWvpiTUyFNWVMCq2JH8J
	 Zh2rQd8aqzvdfRVRWjFy7sqHmjlxJHFFvbVGW6B7WGgycFZ8iF1UOyEYk24L5D0C3t
	 M9Hp60xgDOReQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc45101191so1655779a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710706; x=1740315506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGgtoygEZyqOFgPwIgdXQ26igU8BH6DrWQjW4Xtuubg=;
        b=QffVrQwkWR3QDgu7ZJLsWSi0+p2CNT2h2B3UYmEMh3IH1bMwuMeXE1UgLNI72IiO9M
         abrU6UQG4tF1zlxvHJdEiG9x5ZTz3ufUx6yCw7n2DCRAwVoDNXD5VL2Z4sUDBVN9uvRw
         xqpaM0cVuD0eEit/e1DYWaw/WW+9sT3V3JY1T+5AVxNEOTRxR4le1LPVDgT2EXSBEp2w
         I8trL6c8jiydYiDeFqh2T19SRGxL4oz4xiTep6DrD2ZdDZpcqUAfSg4ItJTTszguOCLc
         12ghfBV3RnCEUmbh2HQcrrFvAE2nAHXl3fEGlm0Br1Ub5/1T4PQTLlEaJs5zj1CZi4Yq
         OKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk9jiLIKQkoAtBD26TIXx6NO8QGJjCWBy/EgRNANMH+22lTwLWBSajWpzQRebRzTQJC1A3xcgVJ5nsHBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLf/UMD4DYGqwWO3u9LHiWL2x0nghxIcneE+Lf172Mfv/UQbn
	aYpVgmT8sJn4O1SeOc3JKMurp3Ze4qTIEP2Qd39z2sP17HkqGBxeVCrTE3sHaxepc8dmi+VFQcd
	3rOzgBxp+Ot+NTOzNYnbk5WOdmgWJhdh6LB37nQsoFzxQXMYe+gSvypkO5oXAoUNtzPtQCt/JZO
	L0oA==
X-Gm-Gg: ASbGncs/snNCISPifZybdcSizLCN+0DCJzOGTT9jVg333yECfNRaotWhhj5SvRXGz+K
	19R/4TBsPBkSSd/jXchwgBhf51cKQCFQf79iG7Vj/smi/LdN5I2g34RYQmm+EyPMgktjKjSD0Cq
	MN59eAWAAGBlybQbEh7pDjTZS3GVAYvksbDcqfWBFfeOS8iT84lYLLCRtcBDZneejz3KwEzNT6Q
	DNytyAUavepakRicyIEk1rZvsfU32itZPxa1uVUChcrY9Ur383LvfM1CEjD/CLzj7t6vLn7EXZb
	dPMejg==
X-Received: by 2002:a05:6a00:2351:b0:732:564e:1ec6 with SMTP id d2e1a72fcca58-7326193a7e0mr8265463b3a.22.1739710706560;
        Sun, 16 Feb 2025 04:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0qbE/n5mu0tASnF+5N8DQzEYSJ5Kf7UDRAQHhn/CvgBZfi+nSdGNEDxZcHiqN8kWwHjQUqw==
X-Received: by 2002:a05:6a00:2351:b0:732:564e:1ec6 with SMTP id d2e1a72fcca58-7326193a7e0mr8265441b3a.22.1739710706210;
        Sun, 16 Feb 2025 04:58:26 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:25 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] Introduce configfs-based interface for gpio-aggregator
Date: Sun, 16 Feb 2025 21:58:03 +0900
Message-ID: <20250216125816.14430-1-koichiro.den@canonical.com>
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

This v3 patch series includes 13 patches:

  Patch#1-7: Prepare for Patch#8
             * #1: Prepare for the following patches.
             * #2: Fix an issue that was spotted during v3 preparation.
             * #3: Add gpio-pseudo.[ch] to reduce code duplications.
             * #4: Update gpio-sim to use gpio-pseudo.[ch].
             * #5: Update gpio-virtuser to use gpio-pseudo.[ch].
             * #6: Update gpio-aggregator to use gpio-pseudo.[ch].
             * #7: Add aggr_alloc() to reduce code duplication.
  Patch#8:   Introduce basic configfs interface. Address Issue#1 to #4.
  Patch#9:   Address Issue#5.
  Patch#10:  Prepare for Patch#11.
  Patch#11:  Expose devices created with sysfs to configfs.
  Patch#12:  Suppress deferred probe for purely configfs-based aggregators.
  Patch#13:  Documentation for the new configfs interface.

N.B. v3 developed based on the latest gpio/for-next as of this writing:
c88aa6829739 ("phy: mapphone-mdm6600: use gpiod_multi_set_value_cansleep")


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

v2: https://lore.kernel.org/all/20250203031213.399914-1-koichiro.den@canonical.com/
RFC (v1): https://lore.kernel.org/linux-gpio/20250129155525.663780-1-koichiro.den@canonical.com/T/#u


Koichiro Den (13):
  gpio: aggregator: reorder functions to prepare for configfs
    introduction
  gpio: aggregator: protect driver attr handlers against module unload
  gpio: pseudo: common helper functions for pseudo gpio devices
  gpio: sim: convert to use gpio-pseudo utilities
  gpio: virtuser: convert to use gpio-pseudo utilities
  gpio: aggregator: convert to use gpio-pseudo utilities
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
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-aggregator.c                | 1129 ++++++++++++++---
 drivers/gpio/gpio-pseudo.c                    |   86 ++
 drivers/gpio/gpio-pseudo.h                    |   24 +
 drivers/gpio/gpio-sim.c                       |   84 +-
 drivers/gpio/gpio-virtuser.c                  |   73 +-
 8 files changed, 1189 insertions(+), 323 deletions(-)
 create mode 100644 drivers/gpio/gpio-pseudo.c
 create mode 100644 drivers/gpio/gpio-pseudo.h

-- 
2.45.2


