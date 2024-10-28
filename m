Return-Path: <linux-kernel+bounces-385417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0029B36FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D525280E22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166B1DE3D0;
	Mon, 28 Oct 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="alGUQZX/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AD2746C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133933; cv=none; b=TlgKWkwCr5QAc5HkZgU/MCS2RslwtLNCw6uaDdUV1j6eg5heMoMON8EFcb1YWGCOh+GCVHfBYPYKAI+SYgPporhgyrWuOYBapNkPhAT/1yoO9wQ/lJBo/DnpuosKTGzdBW58UFLNEtej4YfsH999gg530lBTDzOWjuzk7DGfvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133933; c=relaxed/simple;
	bh=zdfdQxtGc/RJXxTOKIjeDKVVKkKI/IUU5K4fCUAyOEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=meHyHLN6GS1Oa95ioXmyz/BVuzaIk7Q0yCBbmaicLBhiz9CX3jL3udya1VLduws0tJj0YUZbz3uFenRUNCzvg7ukma0EfIV3Sn8CCwuHpIrYNJM6GmAfrX36s8PFSmyzcxJJj2Lz7UqyBMoSrpNKcLCvaifqkDj90KR7LIBwD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=alGUQZX/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso60756015e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133929; x=1730738729; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmWXrEm3lyFPdX71dB3yzVoYE0FoIWaeQjolTUcBnMw=;
        b=alGUQZX/u3P9+ezDcqasNfhR4+tcnZ2aPFWLxs6mXaX5/2JjRyLiYx5nIVHHXPNEhW
         sQQgRNEtqdxy2JIkRHMoPsx424J6serEfd17ECPIstA4tE0Wvt86hbX7HT6Vz7Kvb/6q
         EjjdA57mgsQTSnbTX7ZeKYWfBpjmAHjziUr9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133929; x=1730738729;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmWXrEm3lyFPdX71dB3yzVoYE0FoIWaeQjolTUcBnMw=;
        b=g6DJuKVPAQXnvX3p4zEIbCcVDlnSoo4P4Pd/gvFfH62jkgH4ikbMdrO98HvcCQEIne
         b+fXttAgHe7yPFssvf1cNs9Too8AePqAyQEZUPFchquBgcnGX4CQKswbtOMkwW1yQXQO
         Xar/E90aJerzGjEn0HTPwaExcbmuThxMAJUcSoc680exbvwdObj16bdaDCJZi8fycs79
         HzFxRtnggcu72Kfc+CaVJsCiYOZGPFNqCXra9sP/SNMM9gTDjGEe2QPb6xxmkxV2dXBy
         c40tTNrWj8ul5cQZe+MPe7vKKTSDqgPZ+CtQI4US0Np1WFZ899jx1EOrdCoGM8UrSNPs
         qb0Q==
X-Gm-Message-State: AOJu0YzWk9WD3w89EQ3uCDSHDm7dP9pdIRKZ2juD6z5nRHkxIvF/9rPT
	jWYdKnLWx1YzsbOvqBtVz1bcRucBzPOx2wevYPN7nsYql1qVhs4n+41Vyq2GxrY=
X-Google-Smtp-Source: AGHT+IGDmc4Nj3da5RwdXSW07Pb0K5vE44TuaF7sp7qFWDF6y/2qSBqq4EW0Bj/epuxBrjCU5wglzw==
X-Received: by 2002:a05:600c:19c8:b0:431:9a26:3cf6 with SMTP id 5b1f17b1804b1-4319ac6f6b7mr84060405e9.4.1730133928658;
        Mon, 28 Oct 2024 09:45:28 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4348sm9934333f8f.111.2024.10.28.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:28 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:27 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 00/11] printk: console: Per-console loglevels
Message-ID: <cover.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

v6:

- Add .rst suffix to documentation in do_syslog
- Add loglevel table to per-console-loglevel.rst and serial-console.rst
- Add newlines between multiline bullets in per-console-loglevel.rst
- Make effective_loglevel doc more clear
- Remove ignore_per_console_loglevel doc, it's not shown in sysfs now
- Use READ_ONCE/WRITE_ONCE for con->level
- Ignore/restore per console loglevel in sysrq
- Add new fields to comment above struct console
- Remove now unused flags field on console_cmdline
- Remove WARN_ON_ONCE(!con) in effective loglevel checks
- Avoid underflow in find_and_remove_console_option if val_buf_size == 0
- Better error message on oversize in find_and_remove_loglevel_option
- Reject if clamped in find_and_remove_loglevel_option
- Clarify level setting logic in __add_preferred_console
- Move console emission check to printk_delay itself
- Use console_src_read_flags in enabled_show
- Infer if extended from con in printk_get_next_message, don't pass args
- Remove misleading comment about early consoles in console_init
- Use a goto in loglevel_store to avoid setting level in multiple places
- Mention only @flags and @level are valid in printk_get_next_message
- Use LOGLEVEL_DEBUG for max clamp in sysctls
- Update for class_create interface changes
- Move sysctl functionality out to sysfs.c
- Purge default_console_loglevel
- Update sysctl docs for kernel.printk deprecation

v5:

- Fix syntax in boot_delay

v4:

- Change base to Linus' master
- Use SRCU iterators for console walks
- Override per-console loglevels on magic sysrq
- Fix htmldocs
- Fix mistaken __user annotation in sysctl callbacks
- Consistently use indexed names (eg. ttyS0 instead of ttyS)
- Remove "The loglevel for a console can be set in many places" comment
- Remove CON_LOGLEVEL flag and infer based on >0
- Open code our dev_get_drvdata console stashing
- Split out console_effective_loglevel functions per Petr's suggestion
- Make boot_delay_msec/printk_delay check if it would be emitted
- Simplify warning on SYSLOG_ACTION_CONSOLE_LEVEL
- Save/restore ignore_per_console_loglevel on syslog console actions
- Unify min/max level checks across sysfs/proc/syslog
- Add find_and_remove_console_option to avoid affecting io/mmio options

v3:

- Update to work with John's kthread patches
- Remove force_console_loglevel, now we only have global and local levels
- Remove minimum_console_loglevel control and document how to change it
- The minimum loglevel is now only honoured on setting global/local level
- Add ignore_per_console_loglevel
- Return -EINVAL if trying to set below minimum console level
- Add parser for named console= options
- Fix docs around ignore_loglevel: it can be changed at runtime
- Fix ordering in "in order of authority" docs
- Remove duplicated default_console_loglevel doc
- Only warn once on syslog() use

v2:

- Dynamically allocate struct device*
- Document sysfs attributes in Documentation/ABI/
- Use sysfs_emit() instead of sprintf() in dev sysfs files
- Remove WARN_ON() for device_add/IS_ERR(console_class)
- Remove "soon" comment for kernel.printk
- Fix !CONFIG_PRINTK build
- Fix device_unregister() NULL dereference if called before class setup
- Add new documentation to MAINTAINERS

Chris Down (11):
  printk: Avoid delaying messages that aren't solicited by any console
  printk: Use struct console for suppression and extended console state
  printk: console: Implement core per-console loglevel infrastructure
  printk: Support toggling per-console loglevel via syslog() and cmdline
  MAINTAINERS: Mark printk-basics.rst as owned by printk subsystem
  printk: console: Introduce sysfs interface for per-console loglevels
  printk: Constrain hardware-addressed console checks to name position
  printk: Support setting initial console loglevel via console= on
    cmdline
  printk: Add sysctl interface to set global loglevels
  printk: Deprecate the kernel.printk sysctl interface
  printk: Purge default_console_loglevel

 Documentation/ABI/testing/sysfs-class-console |  47 +++
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kernel-parameters.txt         |  24 +-
 .../admin-guide/per-console-loglevel.rst      | 111 ++++++++
 Documentation/admin-guide/serial-console.rst  |  37 ++-
 Documentation/admin-guide/sysctl/kernel.rst   |  25 +-
 Documentation/core-api/printk-basics.rst      |  35 +--
 Documentation/networking/netconsole.rst       |  17 ++
 MAINTAINERS                                   |   3 +
 drivers/tty/sysrq.c                           |  20 ++
 include/linux/console.h                       |   5 +
 include/linux/printk.h                        |  10 +-
 kernel/printk/Makefile                        |   2 +-
 kernel/printk/console_cmdline.h               |   1 +
 kernel/printk/internal.h                      |  19 +-
 kernel/printk/nbcon.c                         |   2 +-
 kernel/printk/printk.c                        | 267 ++++++++++++++++--
 kernel/printk/sysctl.c                        |  56 +++-
 kernel/printk/sysfs.c                         | 178 ++++++++++++
 19 files changed, 795 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst
 create mode 100644 kernel/printk/sysfs.c


base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
-- 
2.46.0


