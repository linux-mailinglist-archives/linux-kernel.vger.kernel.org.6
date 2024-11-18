Return-Path: <linux-kernel+bounces-413043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1D9D12AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776F11F22983
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F719C54B;
	Mon, 18 Nov 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="avRdLF8J"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371019884B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938979; cv=none; b=Pg3uEuQra+oy7uq9lOy1eraa7BS+FOP3rHxS5XwkM1rilv6ZRpNutH1Q+ZJUfHkSgfmNGzv3O5aTlWsUsBn02EZuerpl1a0kKzCSdF4X5vHGqcZTy+SZkgol5Lg20ZIkQjkbrC6J0VlZYRVmU5wK7DPZ2V2hKWTSDSekBtKIU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938979; c=relaxed/simple;
	bh=RE/NVMKfNaF8ldUmBn0IjP+h7jSECtfYeB9iBlDl/3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pNs0xiFo6N+NDgr2moVBx0AwAgdEtRDiDstwIGnam8QorDBlVRRAqBRTlPxXm59JFcvbtKyDd7vzZrfnP2RR/nDtLDeQaoDpcMe2+UKceLVZViYDevU+df/rbIkS++E4rpSUR3Z9l+ujiBBIFdCr5cA0T61w0ozsGFpF+wu+c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=avRdLF8J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43152b79d25so25681585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731938975; x=1732543775; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWaOAz+pJukHYrAc/q7S7WPS/E+sLMA9XGUrGJDWhW8=;
        b=avRdLF8J1myIaSJmY9vpApHyEuxc1ZiXGr85e1gUu/G5Xsv/3VXiqlPuuqMkmLH7zv
         QmeJDtIOnrr43igWKXF1sA3mzjZ2pDpQF4c6kxbl8z1SB3PgOK3S7m1AHwQJVO++UIih
         PyXDQ7Eh8HY+oaysOhYjHXmiCI1EbVzdkISz9ut2JVFgXmV64sQ9AgfZn4nn/svRXa5H
         vyTORvIcwNXwoKVR4t3Y2sQnjww1YoErKcrtSDF4VtiT3weVWUT/uPq+k3UGKcVm5QV1
         EHhTTOByWSghRuab8fwfYxb8OUqN9OA3RIkPPECyksu8bWUWYDhQ0oMqyiRO8Ir/zrGE
         y6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938975; x=1732543775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWaOAz+pJukHYrAc/q7S7WPS/E+sLMA9XGUrGJDWhW8=;
        b=SpPb1gU1Vgz9Yot0MlCxf1uj9QMsF6nZeAD2WyHdIko+lyRv+lKQdLFkzjALdxWRdu
         /Q8dso6V8tkcUldYdb1QfuaCIvwQkbKFUoNs7T2FJ7ir+RNBo40aMYlvlVjqb9ZZ0PEM
         pMH4dE+7xUXM/A5R9r/DiV7yy3mHo910XiZ9nfMmf3W7ml+a0/lJ7k7teRaUkyL9p1Lz
         kE6dm7zScHZkV6I1oTqjiMN2phC60BOyiM6K+idaqj1G4LWsSvCR2R8NXlVnDBd3NIyL
         fCw7Qf9+Lnc+rY3tD6XzY3jXsDpZXAqMSBh6CbIiZQXsdRntEtnCQGxI5tVod0Ytehqy
         L+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVx+VaH6YRfjzWtmrRKDjwzl5wKjDuHc1rdfQhG6tTNtPSQPUPqg4CarEI0mcC7lt7/FvEFE3NjgBxTDKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpivbolxxykZYeDHVkLTWpT28xtzP6ssp05PHlhcEIt4dOU+3
	SiAY+2X6vt8SxrigWmRhxQMPPvH7Ni6Q45Il931xSrsOVdWp6AENgMe5LHvpSwQ=
X-Google-Smtp-Source: AGHT+IEGLzkOTgk1lUR0k3w1x4/tC7rYx3qA1FKnsVRwzvZYxcXfMC7nXE2CuV8uzkADVmU7n7mA7A==
X-Received: by 2002:a05:600c:3d16:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-432df792c47mr111011665e9.31.1731938975250;
        Mon, 18 Nov 2024 06:09:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161b5sm13171824f8f.74.2024.11.18.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:09:35 -0800 (PST)
Date: Mon, 18 Nov 2024 15:09:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.13
Message-ID: <ZztKnBcca1OtwAcp@pathway.suse.cz>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.13

=================================

- Print more precise information about the printk log buffer memory usage.

- Make sure that the sysrq title is shown on the console even
  when deferred.

- Do not enable earlycon by `console=` which is meant to disable
  the default console.

----------------------------------------------------------------
Arnd Bergmann (1):
      printk: add dummy printk_force_console_enter/exit helpers

Isaac J. Manjarres (1):
      printk: Improve memory usage logging during boot

Marcos Paulo de Souza (2):
      printk: Introduce FORCE_CON flag
      tty: sysrq: Use printk_force_console context on __handle_sysrq

Petr Mladek (1):
      Merge branch 'for-6.13-force-console' into for-linus

Raul E Rangel (1):
      init: Don't proxy `console=` to earlycon

 drivers/tty/serial/earlycon.c | 23 +++++++++++++++++++++
 drivers/tty/sysrq.c           | 18 ++++++++---------
 include/linux/printk.h        | 11 ++++++++++
 init/main.c                   |  5 +----
 kernel/printk/internal.h      |  3 +++
 kernel/printk/printk.c        | 47 ++++++++++++++++++++++++++++++++++---------
 kernel/printk/printk_safe.c   | 18 +++++++++++++++++
 7 files changed, 102 insertions(+), 23 deletions(-)

