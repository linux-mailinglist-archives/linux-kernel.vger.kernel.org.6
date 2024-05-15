Return-Path: <linux-kernel+bounces-179817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AE8C65E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E8328487D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16376EB51;
	Wed, 15 May 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dpnhGAMY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5186D1B2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773591; cv=none; b=haBMWTBciKBTZeAu9KUTZD1/TLbvAfVk+Brg4my6+JG+d3dvG4LdjaL6FO9wEQGnS42j0Bj/9OqciMtg7qW/rsgwCeTVCa3o/ecXegw9bWw8rAqsFZkMdNBH0JiUe3nZqxBOofGmScReU9bbNXSnmb9yIRh+ifO9UnTSBd+PqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773591; c=relaxed/simple;
	bh=sKgfRtCURBuTyyVpaWvY7gIhKNdMOm0tncaGT9inkDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TnjcOc92kPm1ls0V6dZJ0bFUCobrQILUHdQcKcvzsTIvKTY8NNPz8RzjbZa+vhmzc4tqnu97PyCsOsOTCTUCE9yXAivn+9xi99qALzPAtfoNCZQjMZ/59zpt/cUeGwC4hNVSzPY3KMpJNQgFr+nB/3tN8KQQQcHkjMCgKRZeZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dpnhGAMY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so1623435a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715773587; x=1716378387; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rz4fcLeFlI0068MqGQOf+3ncJoh38q1T3OEokCEPkMc=;
        b=dpnhGAMYG5uG1DK20MIyrHH7NS9CXcK/NW+dyetAbFKPU3gKsiRPf+TTKQNfvh1JiQ
         8bHI69hkNqfOp/cFbz730TjarJILTUgJz1w5StFX1B8gjDDjjwAw0qOr4tbHh1Whx0px
         /+IKeLjH66pHq35KtNPQdgor7SGB/xH+hmCOnT9w2k82DFJG7FEwupFga3hwBJO4aR9P
         JlPKpYMxSDsZ8LMgc64xQsQxsCNshVxvd7iuoS//ezVqaFI1KrdojDQyhg7f0J8erhpt
         Udg7LgEa/bnSItY87zDAWbHf2kOmqS2a+ZqlsJ/QprgYq6jP4zoBC40+SZZPi5AjDqAN
         78Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715773587; x=1716378387;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz4fcLeFlI0068MqGQOf+3ncJoh38q1T3OEokCEPkMc=;
        b=eKrSAxT4V/EvIbD4jToLZ5ZSPMjIkUHnyoHLN/vpk3i3MjimlV8myscC3F+m8yApwd
         DbrqhKyg26OVJr3+oVvDjxdZ3SHDEmHcI7ZtcDX3y87t1L4qHZ/ptm1WPA/YSoTJ1Lds
         hbEDkxm7jeeCsCMg7h0t2UZsPTdnOHGXdduF5vwcnk5kgJSBp5x+gvyTlxvgdymyg0yk
         CPVhfwFUSBbIWCqLeazKAu5S2HcfZEHOJcUunSHUaAWG3ozrtsls5qsoB4JorxRg7c29
         cu8naYv9DT/tIkJgMSj0gK1rRyn8z6xqZIjv5/6pCaufqsQFGGNDnAHnxWkt/KHclGJm
         TKsw==
X-Forwarded-Encrypted: i=1; AJvYcCWCKb5AevuWalyef8dPOvf1acBO6lhZJRLvd8zQhI2/sGkaCHs8U92vNnMDfTrTwuXwz1N5YA+LGX7h0CeC8oC0Un5hBOL5mOJH3kjQ
X-Gm-Message-State: AOJu0Yy+5+NvWqeBCBnokiOeMiHipPCfXw6ItA70eBBd7pdLRnmSMsnS
	h28WRrxvyrk+d/EMK0Y4HSNh7Wk+fV2nhxQNBTN4HfQJdu6v2E31k0qnzUZ49x2WnVg2/Jx6+PR
	f
X-Google-Smtp-Source: AGHT+IHD8K++9d5loxZubQvDOzNjezuo/2tkbX3vLajiQ6BbGYVZbNLlUxltridr26MyXfnL74+jEQ==
X-Received: by 2002:a50:9e81:0:b0:570:1ea8:c50a with SMTP id 4fb4d7f45d1cf-5734d5be76cmr10101859a12.6.1715773586895;
        Wed, 15 May 2024 04:46:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323d3asm8806609a12.90.2024.05.15.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:46:26 -0700 (PDT)
Date: Wed, 15 May 2024 13:46:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.10
Message-ID: <ZkSgkFYVXTxJB9Fm@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.10

----------------------------------------------------------------

- Use no_printk() instead of "if (0) printk()" constructs to avoid
  generating printk index for messages disabled at compile time.

- Remove deprecated strncpy/strcpy from printk.c.

- Remove redundant CONFIG_BASE_FULL in favor of CONFIG_BASE_SMALL.

----------------------------------------------------------------
Geert Uytterhoeven (4):
      printk: Let no_printk() use _printk()
      dev_printk: Add and use dev_no_printk()
      dyndbg: Use *no_printk() helpers
      ceph: Use no_printk() helper

Justin Stitt (1):
      printk: cleanup deprecated uses of strncpy/strcpy

Petr Mladek (1):
      Merge branch 'for-6.10-base-small' into for-linus

Yoann Congal (3):
      printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
      printk: Change type of CONFIG_BASE_SMALL to bool
      printk: Remove redundant CONFIG_BASE_FULL

 arch/arm/configs/collie_defconfig                  |  2 +-
 arch/arm/configs/keystone_defconfig                |  2 +-
 arch/arm/configs/lpc18xx_defconfig                 |  2 +-
 arch/arm/configs/moxart_defconfig                  |  2 +-
 arch/arm/configs/mps2_defconfig                    |  2 +-
 arch/arm/configs/omap1_defconfig                   |  2 +-
 arch/arm/configs/stm32_defconfig                   |  2 +-
 arch/microblaze/configs/mmu_defconfig              |  2 +-
 arch/mips/configs/rs90_defconfig                   |  2 +-
 arch/powerpc/configs/adder875_defconfig            |  2 +-
 arch/powerpc/configs/ep88xc_defconfig              |  2 +-
 arch/powerpc/configs/mpc866_ads_defconfig          |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig          |  2 +-
 arch/powerpc/configs/tqm8xx_defconfig              |  2 +-
 arch/riscv/configs/nommu_k210_defconfig            |  2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |  2 +-
 arch/riscv/configs/nommu_virt_defconfig            |  2 +-
 arch/sh/configs/edosk7705_defconfig                |  2 +-
 arch/sh/configs/se7619_defconfig                   |  2 +-
 arch/sh/configs/se7712_defconfig                   |  2 +-
 arch/sh/configs/se7721_defconfig                   |  2 +-
 arch/sh/configs/shmin_defconfig                    |  2 +-
 arch/x86/include/asm/mpspec.h                      |  6 ++---
 drivers/tty/vt/vc_screen.c                         |  2 +-
 include/linux/ceph/ceph_debug.h                    | 18 ++++++---------
 include/linux/dev_printk.h                         | 25 +++++++++++----------
 include/linux/dynamic_debug.h                      |  4 ++--
 include/linux/printk.h                             |  4 ++--
 include/linux/threads.h                            |  4 ++--
 include/linux/udp.h                                |  2 +-
 include/linux/xarray.h                             |  2 +-
 init/Kconfig                                       | 14 ++++--------
 kernel/futex/core.c                                |  2 +-
 kernel/printk/printk.c                             | 26 +++++++++++-----------
 kernel/user.c                                      |  2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |  1 -
 36 files changed, 73 insertions(+), 83 deletions(-)

