Return-Path: <linux-kernel+bounces-292093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787C956AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F45281015
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6516B397;
	Mon, 19 Aug 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e1DTwYe3"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859A16848B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070923; cv=none; b=UM5EplzRAJzPX32FhQQurkOaFQfAhnumn4ZxVifQcu2hI2OQ1YcALXLeOQyTs/Kd4RtZHIrR1RuMPTb/9hyR9SFNj3ynFZ1nHZ1xYgGjWfvxYOdFz+dJgQUSk4vMMBuM8s7SEVnwQYjoxnObc4pZIKByNzdxhoZPTaQvzCGD/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070923; c=relaxed/simple;
	bh=BQbdpXbqWxx6gzrVlI8oMfXwx+CUGDzsVbyAFqMevjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KhPMa+2ugvwz0SW4AJ2tagXiG2PqqGZQYmB/+3w653DSaoAVoW8WzuXxFZL+kb1sLKK1pxWnsq/LyYqNAQcsh3xnlWJxll8s34Vs0n2IUHY+pW8VKKOhpsRnq1BONi3QUdmcqEHHyV8KNJ8SxJmzVFJEjkVJE7WGeUxifdpDNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e1DTwYe3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4231849a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724070919; x=1724675719; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2ChLO6xpyIbB4YY4SmrjC7nGfsaA1IbzrMqdohZBhs=;
        b=e1DTwYe3pMhQtpXDisPBjCAATGcZWIJGHR+MLGB4HYM84ZvQT1FtNgkwMdNqTwuJRJ
         1u61QGS9jwv4hCRzteS9zqAZwd+9JqIF5ue9l54fzo6ll1ku4e05kvr0smCdNY2151e8
         S0rRftNQGuThoaTh4aC7extzn7msPpVBwBeaJDB+wp6ML6p2D/N2GZSTqUNhcsZ0TEsj
         o5hjhtRsm2P96NLdETN/UMcAxBJz+Jkv9k3Sd0p76+Vopboqgrj+A2qyc//6shQP6qFG
         jnh+okgtFArB0o9744p5hbSz5b6KuqwHxU5nO8hiv89xSgHARgdL4UGhb0TV7ATl+erx
         N4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070919; x=1724675719;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ChLO6xpyIbB4YY4SmrjC7nGfsaA1IbzrMqdohZBhs=;
        b=Q+H7L2Un5PNNmhfazpZnKo1BKO7+dmZjwhQiQY9be52bgEHEXG38LhKnWa7JRpdzyw
         iwjgNb0qGc+zNmaOhEK8Q7FKG8XPUExlWA/4s5WlkFQD02NtKAb038+2ItZyzsmR9Dme
         99Kzdk1o5RdURz0/Tm3z+fdywLfawIOMUjzYgjvB93dyaD0PjzTKmOYQJsPb5LRWVi0P
         zXaoaoKaZDSqhQfhZvRO0tpyNcQ7TYICpxLjxMqRqmZGjBu50JkwwWczEqqufr13Id6c
         aZg+CrOqBr4PM1YSf4jgM9WpOxrIVxYVMLlhOjOmJJngYJi7/neFQ9uYAGi2UDeqvYAx
         lPoA==
X-Forwarded-Encrypted: i=1; AJvYcCU0MpGUzEgH1Hf75sMGsf+j3hyfBwYS9+B0FlCLNIt381H3B3YuqeISiePW96K+XQIhN1qi3BL5PMbCDiQJAHxdqb446xp42beSNqbk
X-Gm-Message-State: AOJu0Yx1HYHsBa/DEWfh5xy0ZCLdlN5hyzJzQgIuX5zn/jWnBEzZRWo6
	kZv7m0b2Whmp69iTO0Tt6rx0jH7cJO2OBKUvwBt8cqaz6SO6Xnz9uIzpVgq0JfI=
X-Google-Smtp-Source: AGHT+IGsB94DTJ7/u+HQB5eCIi7UrZR0IO6Hwuq0ar/Ya/C5G2jKOy3f+PWvzs4gz4FcN4+zblnFRw==
X-Received: by 2002:a05:6402:348b:b0:5be:e999:18ab with SMTP id 4fb4d7f45d1cf-5bee9991c77mr4251417a12.23.1724070919095;
        Mon, 19 Aug 2024 05:35:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f05dsm5537916a12.78.2024.08.19.05.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:35:18 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:35:17 +0200
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
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [GIT PULL] printk fixup for 6.11-rc5
Message-ID: <ZsM8BVQ7l5RQiVIW@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a regression fix for 6.11-rc5 from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-rc5

=====================================================

- Do not block printk on non-panic CPUs when they are dumping backtraces.

----------------------------------------------------------------
Ryo Takakura (1):
      printk/panic: Allow cpu backtraces to be written into ringbuffer during panic

 include/linux/panic.h  | 1 +
 kernel/panic.c         | 8 +++++++-
 kernel/printk/printk.c | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

