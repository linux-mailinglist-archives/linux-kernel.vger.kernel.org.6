Return-Path: <linux-kernel+bounces-525839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24EA3F623
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6636E3B6228
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9FD20E038;
	Fri, 21 Feb 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lLZ83f2r"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879C20CCF4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144921; cv=none; b=GB4VXivfJL7XzMrqnCg9x5NiB1sXIZHZBLXq5BzFSYgjZCFlbzWPMJFe3OitD5F17wpSJb1uVV69sa0hPh9bmUcfocSoy4XzxX+2AjJpLysfIlfMi7XJUW7e/UwvmUCDVkVbJBzH+6fRboeo7hBO0puiTN7be5623GK87EyAGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144921; c=relaxed/simple;
	bh=JCwBGCIWQQYwvBo1RGFgynH2V74O4Vo5jpW5Ascsdwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7JiYGVm0FbQ5VesdQoOIBY7D52pY5Gzo/Y1dv2UoRHBn5J2KzKba15KETll6KgmzyCX9VGYI4o7nFC+TizI96yJ/7zl3RrW200kVmmzCJQg/+nekIM8S8d750SaAPrArfWcBqBQwGsXdHQ+0WuHgV/MGwUIHYWDzakF71dsPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lLZ83f2r; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D473D3F473
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740144911;
	bh=4mV4RIbIjlD+y6YWR/tN/fQ+WDkZUX/byyo07QreGuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=lLZ83f2rIkkxGeJc6ujLF4y8yxOs3NPTiAKDEq2eanmXFmD78NuJS/z/64NPPTx72
	 CMKxjOUrXZc6kwLPrLbzW91bZDcJ9OYdW0envaE0d8+nG1T+IaYiG1oUlhvXAEwXeE
	 6Y7YkcwtVmAIFpbABBxtAGc9fBS8I1peqeLyTnBOGXXTt4P8DHoGFrOA/XRqePWQ7u
	 EaUw1HvJZeS11+sf6jJaFnFgI1X86AyXiYKg2Lesbrf6h1aJh+zt0M26c/Vnzk9127
	 qN21jVw/uxPe+Tgemr1p3K1g6aGYMtxOn8GYnukVP4Su9xvXa96sUlY7aSjQ20sP+7
	 G71GYGQb9Bi+A==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220e7d654acso52452565ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144910; x=1740749710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mV4RIbIjlD+y6YWR/tN/fQ+WDkZUX/byyo07QreGuM=;
        b=Rq9s1nf76zyx3Rybh0a25mAeSc1ggnEUQvwtzAInyyKdS0OSuHT1vOy/qjMRD1vjlT
         S1QwidL0Bb4WR95UzGSTASUd9td1kFRK7KoTdmFkG33jKXEdHTdomJ29Brv/Z3FuW8Tv
         uaFPmPIyL2sQA1Ibg+rsb8TJ5SRoZkTzw2kTmBHhO59f6Lt4zIxqFtkpnd8/bvn/7S/t
         ESBUkZbDLRSlB4Irq5GtMJMTpGNz155Nqa8Ah54S+AsveK1xxL81yo5lg6MGE3FtKOAa
         E6RHKjNOkErUsTxIZ+8DVMb0mieldKh5JE2gnwpc30fzMpipsUffxEFROuKsfd+i8Zp7
         F+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTq4KV+To0Mdd5oe6vN44d0D3iIppZTlKfAVjjPiLh2Im7JYeUIeugrwEcZbI8eoXGw3zFva7CfmIg53g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wTW5av9tvsyYqJan5gpkxXsGyfiBGHjTfEbPRw3wcoOtxd9u
	rhCZyk1Jm5Rlqhz/RT8cLRQBnLCcnB0JJuzQ1bUykn2LE5Es6M3KMgiFQQjws3LnvOrYwc8rws1
	6xLhz7RPtWvv+JRJawKn5So74wa4jqRQ/eNEGhGe4xqSsCt4j0wBMjRh+phne2vLb8F/C3PQBxl
	MGpp1LEXfv5Q==
X-Gm-Gg: ASbGncuPCuhmjpKwxs2jJfRXWaslCHcnEt2jx0768Sb5yL4MWBn0E0pZnCoM9qdqp4b
	ooYRS0cQyuMHgJinMt77uZjTvPXwV1+NjWIuDbrCHYzV9jKgAnf46gne0u04cFPDoyfqMplwC5G
	9Tyq5rBwDtY1mnwBkxxCoslzptNpmkV3IjOzE6uZ6dpOVbiXVY1G6+bg0x00bcXiv8GxDocO/1h
	vTEHQECR8J9g4b7mUUaROM/5KvoQwZ6IQtYX5qH/a1SGbynkJ5vir9cGCwaaaNLASoetDHTZlSG
	sJz3lYRkfecGKbto
X-Received: by 2002:a05:6a00:2e14:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73425ca201fmr5092583b3a.7.1740144909756;
        Fri, 21 Feb 2025 05:35:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9cThE2TLeyZ3v29gmKIYQTJjFCHfD+VOXkksuQsyP1lmxTtH9LYVHO1h/J0OAS+61OnPX5Q==
X-Received: by 2002:a05:6a00:2e14:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73425ca201fmr5092533b3a.7.1740144909269;
        Fri, 21 Feb 2025 05:35:09 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:2777:7867:71cd:dd56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325d65619bsm12565459b3a.113.2025.02.21.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:35:08 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add synchronous fake device creation utility for GPIO drivers
Date: Fri, 21 Feb 2025 22:34:58 +0900
Message-ID: <20250221133501.2203897-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a utility for some GPIO devices to reduce
code duplication. There are no functional changes.

In this series, only gpio-sim and gpio-virtuser are updated to use
dev-sync-probe, as the current gpio-aggregator does not benefit from it at
all. A follow-up patch series that introduces a configfs interface for
gpio-aggregator will convert it to use dev-sync-probe as well.

This work originated from a suggestion by Bartosz:
https://lore.kernel.org/all/CAMRc=MfcooZXBqVpbQ0ak+8LGsPDzwKSN3Zfb0eZDx1Bx4duzQ@mail.gmail.com/

N.B. this submission is based on the same (gpio/for-next) commit as v2:
f04867a5d0d3 ("gpio: loongson-64bit: Remove unneeded ngpio assignment").


v2->v3 changes:
  - Fixed Kconfig (hide it from users with removing 'depends on', move it
    outside of 'if GPIOLIB ...').
  - Dropped an unnecessary comment, an unnecessary line break.
  - Fixed Copyright (Year 2025 -> 2021 for Bartosz, add mine) + add my
    MODULE_AUTHOR.
  - Renamed dev_sync_probe_data fields ('data' -> 'probe_data') for both
    gpio-virtuser and gpio-sim.

v1->v2 changes:
  - Renamed the files (gpio-pseudo.[ch] -> dev-sync-probe.[ch]).
  - Renamed the helper functions and a struct.
  - Fixed Kconfig (correcting bool to tristate, etc.).
  - Fixed Copyright.
  - Added some missing #include.

v2: https://lore.kernel.org/all/20250218160333.605829-1-koichiro.den@canonical.com/
v1: https://lore.kernel.org/all/20250217142758.540601-1-koichiro.den@canonical.com/


Koichiro Den (3):
  gpio: introduce utilities for synchronous fake device creation
  gpio: sim: convert to use dev-sync-probe utilities
  gpio: virtuser: convert to use dev-sync-probe utilities

 drivers/gpio/Kconfig          |  5 ++
 drivers/gpio/Makefile         |  3 ++
 drivers/gpio/dev-sync-probe.c | 97 +++++++++++++++++++++++++++++++++++
 drivers/gpio/dev-sync-probe.h | 25 +++++++++
 drivers/gpio/gpio-sim.c       | 84 +++++-------------------------
 drivers/gpio/gpio-virtuser.c  | 73 ++++----------------------
 6 files changed, 152 insertions(+), 135 deletions(-)
 create mode 100644 drivers/gpio/dev-sync-probe.c
 create mode 100644 drivers/gpio/dev-sync-probe.h

-- 
2.45.2


