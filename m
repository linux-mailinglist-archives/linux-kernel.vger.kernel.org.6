Return-Path: <linux-kernel+bounces-200710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8B8FB3DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BB31F23B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB0146D7F;
	Tue,  4 Jun 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCyPO8aP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBA146A9F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507913; cv=none; b=sXkomD8C1wyRC4OXO97g/veTy62JywqvlCaovsNhZgOB301p4be+6WvHHncSxKNoPLOd3Ke58/FfUZCTSSJCkDHYMbbR/Ra8Mgn+ZJXTmhXv59sYUu4k3km3kNkB/cMUetobdgtlMEbnNu6Q44dLOZmk+eecgb0xgNSjgMDhu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507913; c=relaxed/simple;
	bh=GOyu6VoV1+EqQHivq4531ORRicJi6ri8IsacL/5ud00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+7cnAhPjX2enyfhmblH0pBcbayW64aAc5GqeTV+jOy3fQuKyLz7HT9KeImXzj126fouLiwADAjQzCOGzi6MhK93noFKTSbG5BeRt9Rdm8q+w0NAyls6OtF3WLl9c+Djv5Lu8AVKajLdFryACOIyaA8Kv8tmc0mLZzluZ8PDVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCyPO8aP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717507910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NTg4cLU414MePoyscLxCqohMFZ4JgKreHROINBa29k=;
	b=aCyPO8aP4ol26ROPpfxpLO+2+JJbTcm3+tZArfhF+f7JpB7amQvTZR48IfA3fInCGkLkfI
	I4mS8yHbKdIefWeefZAMtGlGNxH+8Wk4HcfqPXP1gC7/ro3sMNtZcZm4h25ZT6D33H2oqS
	ge2IqsHsYHnr/R7erPWAU9ADC0DTGQ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-4HScodJVN8CbuDcbTLnnGQ-1; Tue, 04 Jun 2024 09:31:46 -0400
X-MC-Unique: 4HScodJVN8CbuDcbTLnnGQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcb574515so682375f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507905; x=1718112705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NTg4cLU414MePoyscLxCqohMFZ4JgKreHROINBa29k=;
        b=wkefyWwSEOvE6g4FzjodhbHHuiy86PFZIVGdR9Lxlf8SZl5rbxQTdXNh/pD10+E5SH
         6jibgPuOGKlTwkLh7149hltF64U2gLSEaPCgaGmp3BB8re2PTC0eMs35iAGLOpOJZG4D
         jX9c88aRQwrDmOtBJ4lNQi4u6uv2jmhtpiVKslyMrBXyu9kVv1wGdRU7ApQ7TMFd+cPK
         gH62cL0qP7PRM5gjtuwbBbncwfagbS+1HUEEd/gGXdQyBOBG4SBFTeZUIbM0dcVE9eUz
         4UXY4E/gIbzoCRFms56ZHabiDI9/g1KGv2ugSAH7h1dQyaxcDrdgPNhksKILZPrhbA2w
         cMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/EbhIgSuSWN6ehA3Sc3ox+EUQZHFAXKtffB7yrWwsFDfclLgcZuIcdhsFRAaW2kGJZRz10hACWXhlBUQrU39v5G3oJ7gd8rF62K5X
X-Gm-Message-State: AOJu0YwtjJufyp+KMaBRxa/UhZ1A+U5cDsqfiF4sxDo10nE2/tuc4yNt
	7JltavRjygTjQjDShaV30eFEsQ2GcFqI+O8svHU2Zj3EGucY4hEB8EL0PelAkjDvqD/EHF5M+VB
	cM4HrWLjgT1ntIPAxMrVb7/mmq3gQBS0Pab++B+CWD4Z9FXcZPKwkwpas9pMQKw==
X-Received: by 2002:a05:600c:3d96:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-4212dff7d3cmr100598615e9.0.1717507904942;
        Tue, 04 Jun 2024 06:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7eaFWdN5jDf+LCOq1NkYpFGX7x9QehvuKgllc5QQK1pfiasQ6ZxSQSpSUhiSAG/QCorMIGA==
X-Received: by 2002:a05:600c:3d96:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-4212dff7d3cmr100598165e9.0.1717507904444;
        Tue, 04 Jun 2024 06:31:44 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215425d599sm14468455e9.6.2024.06.04.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:31:43 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:31:41 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sreenath Vijayan <sreenath.vijayan@sony.com>, Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>, 
	Tomas Mudrunka <tomas.mudrunka@gmail.com>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH printk v2 00/18] add threaded printing + the rest
Message-ID: <aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>

Hi John,

On 04/06/24 01:30, John Ogness wrote:
> Hi,
> 
> This is v2 of a series to implement threaded console printing as well
> as some other minor pieces (such as proc and sysfs support). This
> series is only a subset of the original v1 [0]. In particular, this
> series represents patches 11, 12, 15 of the v1 series. For information
> about the motivation of the nbcon consoles, please read the cover
> letter of v1.
> 
> This series provides the remaining pieces of the printk rework. All
> other components are either already mainline or are currently in
> linux-next. In particular this series does:

Our QE reported something like the following while testing the latest
rt-devel branch (I then could reproduce with this set applied on top of
linux-next).

---
... kernel: INFO: task khugepaged:351 blocked for more than 1 seconds.
... kernel:       Not tainted 6.9.0-thrdprintk+ #3
... kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
... kernel: task:khugepaged      state:D stack:0     pid:351   tgid:351   ppid:2      flags:0x00004000
... kernel: Call Trace:
... kernel:  <TASK>
... kernel:  __schedule+0x2bd/0x7f0
... kernel:  ? __lock_release.isra.0+0x5e/0x170
... kernel:  schedule+0x3d/0x100
... kernel:  schedule_timeout+0x1ca/0x1f0
... kernel:  ? mark_held_locks+0x49/0x80
... kernel:  ? _raw_spin_unlock_irq+0x24/0x50
... kernel:  ? lockdep_hardirqs_on+0x77/0x100
... kernel:  __wait_for_common+0xb7/0x220
... kernel:  ? __pfx_schedule_timeout+0x10/0x10
... kernel:  __flush_work+0x70/0x90
... kernel:  ? __pfx_wq_barrier_func+0x10/0x10
... kernel:  __lru_add_drain_all+0x179/0x210
... kernel:  khugepaged+0x73/0x200
... kernel:  ? lockdep_hardirqs_on+0x77/0x100
... kernel:  ? _raw_spin_unlock_irqrestore+0x38/0x60
... kernel:  ? __pfx_khugepaged+0x10/0x10
... kernel:  kthread+0xec/0x120
... kernel:  ? __pfx_kthread+0x10/0x10
... kernel:  ret_from_fork+0x2d/0x50
... kernel:  ? __pfx_kthread+0x10/0x10
... kernel:  ret_from_fork_asm+0x1a/0x30
... kernel:  </TASK>
... kernel:
...         Showing all locks held in the system:
... kernel: 1 lock held by khungtaskd/345:
... kernel:  #0: ffffffff8cbff1c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x32/0x1d0
... kernel: BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/345
... kernel: caller is nbcon_get_cpu_emergency_nesting+0x25/0x40
... kernel: CPU: 30 PID: 345 Comm: khungtaskd Kdump: loaded Not tainted 6.9.0-thrdprintk+ #3
... kernel: Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
... kernel: Call Trace:
... kernel:  <TASK>
... kernel:  dump_stack_lvl+0x7f/0xa0
... kernel:  check_preemption_disabled+0xbf/0xe0
... kernel:  nbcon_get_cpu_emergency_nesting+0x25/0x40
... kernel:  nbcon_cpu_emergency_flush+0xa/0x60
... kernel:  debug_show_all_locks+0x9d/0x1d0
... kernel:  check_hung_uninterruptible_tasks+0x4f0/0x540
... kernel:  ? check_hung_uninterruptible_tasks+0x185/0x540
... kernel:  ? __pfx_watchdog+0x10/0x10
... kernel:  watchdog+0x99/0xa0
... kernel:  kthread+0xec/0x120
... kernel:  ? __pfx_kthread+0x10/0x10
... kernel:  ret_from_fork+0x2d/0x50
... kernel:  ? __pfx_kthread+0x10/0x10
... kernel:  ret_from_fork_asm+0x1a/0x30
... kernel:  </TASK>
---

It requires DEBUG_PREEMPT and LOCKDEP enabled, sched_rt_runtime_us = -1
and a while(1) loop running at FIFO for some time (I also set sysctl
kernel.hung_task_timeout_secs=1 to speed up reproduction).

Looks like check_hung_uninterruptible_tasks() requires some care as you
did already in linux-next for panic, rcu and lockdep ("Make emergency
sections ...")?

Thanks,
Juri


