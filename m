Return-Path: <linux-kernel+bounces-262286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BC93C378
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812FB1F22B48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57067199386;
	Thu, 25 Jul 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eUhTYKPA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAAF1EB2F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916053; cv=none; b=CSu3SpPK4FvC8h3DGA06iZxdMCXi3AFR3nLMgdBbQu6UtiX5/857+z1zx78pf6h7JHbvIaqbrGggdP20xTQGkmu/85gNBp3P32muEup2lDzFLJWYA48mxoDBQmFSFttjKQsXyG1MhKJAEtig3AkkLdo17MfdkJhexRCPmhRd6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916053; c=relaxed/simple;
	bh=1v5L9eagXn3JYFfgNDx3RGBYoJMQ7wAlWPwZbrFisnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4ECjeoZno3VCXXgFQ+slFkZ2kdBgrKPsn5CZgyXHXU8uEG7RoUDwYBPoH4KQZjzrVW3XwDPL8cyw3qOZiwecYkXRQ41lEmPqH3z7Grhx5LQJauTTwVrIV1AYGlWx1DVB0dVDUv8xIzFJ66iDaJUiSsHz/H0nib4QgTqUEoF9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eUhTYKPA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1201225a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721916049; x=1722520849; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV/zIwekuhDM+wUzRyeZaY6IHzhNtmyLf5VUmxp4/8c=;
        b=eUhTYKPAfaEpRTLSNmyLSoPuwzjChRcOxvfCcDEOFPaA+xwF1a/A5E1fFsIpkzDXjm
         3gfMEcXyqwrQbRgXhvkLhTg5mdhCSvD8Oy6QYEFVDyrRCgecNie/UfY4GDBSwdi46Nhp
         gUU3/xf/IUqfpPwQ5bFQCRIQT05iVQObbtzG0ZrR1JcpLxAThdr8YcUmtNX4lFzy3kMX
         AqB3MWLlVTCMtqs7ATVv5YOcWsZZVddy7BWfik/+4zZAowF57YpFOTqaz2ZjL264AxHd
         +f+aqD5SqFmsyp8BN3AI3xuPP9M2CpDdGITCXP23RiOTGuMax8ZdAcUJKo3MaMEUfoll
         nDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916049; x=1722520849;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV/zIwekuhDM+wUzRyeZaY6IHzhNtmyLf5VUmxp4/8c=;
        b=q3BiwBHD3epCU/ejTyEkMPuMTCsytQ8la97ysUriR+eKuknjynBzho/mPEjVDWefeT
         Ar3ZVHZFZZckY8kNkNA47WopeN7psidy9UDHuZA/xV81BqqvmpzrPqjzYNN7heM9CApa
         0V4Whzx1bu3Wyp64RJ5+9LDaPinW/6Pg+p7GrAt2U1uudTJiGSM9ogd2P/l/ewGIuOMK
         XJ56c1VsxI5VutPZO2Isy7Kxoh5xbWmfh8byjYLymHOQt7019c8j0bvID21VGdaYFY/o
         PfkO5hqVRt/M/oqwnSNUCvpPO4h/Nf5vSAaZGV3wnv59yfrYzOLOL+QvucxOVWwbbsXW
         oAbg==
X-Forwarded-Encrypted: i=1; AJvYcCU8i3qTo3HupeE0ZneCJQfM86+0rfo4S7GxkxDn1gjNCGHJ3uTCLdce4njQ3PfbWV13pcUTtcEU91Uqqr3vUrrs7z3cDUAPciPEh/pp
X-Gm-Message-State: AOJu0YxDfE0HZFGbf/NYEImcCHcojGYbwyIn+nWt+Z2YvnIHGS5cDaVv
	Fh2kmtGM4l2sw/tpvsIDV0DOSnrEwyOZSWqmyDooM7SdISNpYRmxTFPOLYReA10=
X-Google-Smtp-Source: AGHT+IHIs/Di9Drq7CO21ZcLllV9jbDR1v3rs/SwnWLXNj54OIpB+b2ZwYJGAfX9QhutWNJyB8rJDA==
X-Received: by 2002:a17:907:97c4:b0:a7a:a30b:7b95 with SMTP id a640c23a62f3a-a7acb38ef6dmr176615966b.2.1721916049502;
        Thu, 25 Jul 2024 07:00:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm75723566b.201.2024.07.25.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:00:49 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:00:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [GIT PULL] trivial printk changes for 6.11
Message-ID: <ZqJajyj-qaf6eCk8@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the two trivial changes for 6.11 from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-trivial

========================================

- Misc clean up.

----------------------------------------------------------------
Jeff Johnson (1):
      vsprintf: add missing MODULE_DESCRIPTION() macro

Sreenath Vijayan (1):
      printk: Rename console_replay_all() and update context

 drivers/tty/sysrq.c    | 2 +-
 include/linux/printk.h | 4 ++--
 kernel/printk/printk.c | 6 +++---
 lib/test_printf.c      | 1 +
 lib/test_scanf.c       | 1 +
 5 files changed, 8 insertions(+), 6 deletions(-)

