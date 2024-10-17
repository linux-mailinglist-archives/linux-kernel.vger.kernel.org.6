Return-Path: <linux-kernel+bounces-370180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4639A2919
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860C21F21261
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77811DF27F;
	Thu, 17 Oct 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzpdJA6Y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3D1DF276
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183021; cv=none; b=OTWiwyWOfHPc6ScHtq6+b+cw5fQslyGiIbFMfljSiKcQAqzNrt+bb/LccBEAG3+vCRfqhDSb2LvC4XlUV8zcgrz4WhMJik8UaL/s6uoZNUViJcLJwYpsTyp7sX+fHROWyrkYqMGgdrppqoCZJafcozQJFy4TosnHjpTy+fu2nUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183021; c=relaxed/simple;
	bh=cqJ8YXSL/6G8nBCjbPilRI7C8VZJG7pdQBTkoAIYBrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwUmu8Ag3Dw0EXITRtNLv+jcxaW3P+Ni11dp95+1cj4LqINqbmShPCdMD5VPym1pifPQLjFXt7mqiS18WcErOFV797JlgBgahIgspo7L6yrD89E9RrDoB4O1TJYnAW1CqzhIYPlL16E+IAWIO1xZT80XzcuQVBx4qQINuRA8rM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzpdJA6Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43115887867so8461795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729183018; x=1729787818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg01EDslkFVUhzMkkUb4hB5z0mSu8A5C2uHNCojkyKY=;
        b=YzpdJA6Y1lk+4j43KOFHjcbPs9p1BCskRb9jBTxdxe/Vyw8oXuTTgPzwFhGwvQso3c
         ir/hBRsZbBoUv7OCeDJ8h6QUbTCf2vqscdp2/0nAfXbuDWSEy9lNaJHKu6GOrcBUS/HW
         7ZigLN8v18y1N3T46HmLm2wNScmnlwYFNpl03DWiipo0oXotrT8ZkIRbv52mwqjpc1JC
         Ej9HXjSH39VbfGWaN8eJC0pjNLbDNozqUPtWZ1tSmABCnMnPcEaubZKYopR06fzGysvG
         5ygeNSPQPJIj1yOcoyTEuV78YtBM9Bxtq86RaNT2fHSqPrVPG6EB5H2GYKqV6Ymy7gtf
         a13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183018; x=1729787818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg01EDslkFVUhzMkkUb4hB5z0mSu8A5C2uHNCojkyKY=;
        b=ukcBfJiBBXw/HLPK5lmgEoL1MsjEhqWi4CkTtLk8Nn5jOuPpbP1mn3FxhJr5JIHDUF
         khVeCqdvMBT/ml/ijgwoBgt+URTUyYrhLXiAW4YPkEGDNH/L0tEinjmzmBLhwBypp7nT
         NCLZ6FXlxnWRXpqQ0iMH1yZ3fzSz8WGY34nMcKbz9PsaaptGXcBkgrYRNofHnsWqEVoR
         whLnnoKQiAHIzkXkfOSNka0T2CFFM5Mm+jJtResE4tK03RUaQ5oY2Ri1PH7ijBVrlv6A
         IKdKhvXthdoxSZs7vXNdw0Wq/cRib8jqdm8EZLGHCTqZOfr6wO7mHYx8pZLWUNftKLC9
         ZRvw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYmtVaF/QuL4jlMZ0Ynabhz+zU8DiCKflA/XcfiXVmVp0KnDWP+IyMxqf8qLaUZIBJvzfPhPUSA31uJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyxy2x6oy5gbE5xyQRnCHkWMWoKjyIfW+QgV4hdaRYbehgjRRq
	d2Ouqo4Z0/ro99+cJycEnITaK52/tiqoKqTxdmIKRXA5WNzM5bHb7BeRyMAf4tc=
X-Google-Smtp-Source: AGHT+IFRSodLproKws30Fwmeh9U5gZJ48F5btqXXPZbS12I3VrKrnbwPTFo3tKyGKXkjTmOb9njy7w==
X-Received: by 2002:a05:600c:1f12:b0:431:5226:1633 with SMTP id 5b1f17b1804b1-431587173a2mr26093615e9.6.1729183017642;
        Thu, 17 Oct 2024 09:36:57 -0700 (PDT)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc11aefsm7710376f8f.93.2024.10.17.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:36:57 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: jassisinghbrar@gmail.com,
	krzk@kernel.org
Cc: alim.akhtar@samsung.com,
	mst@redhat.com,
	javierm@redhat.com,
	tzimmermann@suse.de,
	bartosz.golaszewski@linaro.org,
	luzmaximilian@gmail.com,
	sudeep.holla@arm.com,
	conor.dooley@microchip.com,
	bjorn@rivosinc.com,
	ulf.hansson@linaro.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	marcan@marcan.st,
	neal@gompa.dev,
	alyssa@rosenzweig.io,
	broonie@kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	vincent.guittot@linaro.org,
	daniel.lezcano@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/2] mailbox: add async request mechanism w/ a user
Date: Thu, 17 Oct 2024 16:36:47 +0000
Message-ID: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds a simple mailbox async mechanism, similar to the one found in
the crypto subsystem. It empowers mailbox controllers with hardware
queue support.

It then adds a user for this mechanism, the ACPM driver.
ACPM (Alive Clock and Power Manager) is a firmware that operates on the
APM (Active Power Management) module that handles overall power management
activities. ACPM and masters communicate with each other using mailbox
messages and shared memory (mmio-sram). The shared memory contains
channel configuration data. It exposes at a specific offset into the
memory the channel ID, message and queue lengths, pointers to the TX and
RX queues (which are also part of the shared memory), and whether the RX
queues work by polling or interrupts. It resembles in a way to the
arm-scmi driver as that too uses mailbox messages and shared memory to
communicate with the firmware.

The set is marked as v2 because the mailbox core patch was already sent
for review a few weeks ago:
Link: https://lore.kernel.org/linux-arm-kernel/20241004165301.1979527-1-tudor.ambarus@linaro.org/

If everyone is happy with the current form of the set, we'll probably
need an immutable tag/branch to be shared between the mailbox and firmware
trees.

Thanks,
ta

Changes in v2:
- add the exynos acpm driver - new patch.
- extend the mailbox request with rx and tx len - let the client decide
  how much to write and get back from the controller. The controller can
  verify the lengths by comparing them with its channel length.
- extend the mailbox request with flags, in particular with
  MBOX_REQ_MAY_SLEEP. All requests that don't set this flag are
  considered in atomic context.
- remove a dereference that was done before checking for null.
- update the commit message, rebased on top of v6.12-rc3.


Tudor Ambarus (2):
  mailbox: add async request mechanism to empower controllers w/ hw
    queues
  firmware: add exynos acpm driver

 drivers/firmware/Kconfig                    |   1 +
 drivers/firmware/Makefile                   |   1 +
 drivers/firmware/samsung/Kconfig            |  11 +
 drivers/firmware/samsung/Makefile           |   3 +
 drivers/firmware/samsung/exynos-acpm.c      | 703 ++++++++++++++++++++
 drivers/mailbox/mailbox.c                   | 127 +++-
 include/linux/mailbox/exynos-acpm-message.h |  21 +
 include/linux/mailbox_client.h              |   4 +
 include/linux/mailbox_controller.h          |   7 +
 include/linux/mailbox_request.h             |  33 +
 10 files changed, 888 insertions(+), 23 deletions(-)
 create mode 100644 drivers/firmware/samsung/Kconfig
 create mode 100644 drivers/firmware/samsung/Makefile
 create mode 100644 drivers/firmware/samsung/exynos-acpm.c
 create mode 100644 include/linux/mailbox/exynos-acpm-message.h
 create mode 100644 include/linux/mailbox_request.h

-- 
2.47.0.rc1.288.g06298d1525-goog


