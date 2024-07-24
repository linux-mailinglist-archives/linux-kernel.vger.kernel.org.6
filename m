Return-Path: <linux-kernel+bounces-261546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42D93B8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD61C23A49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544FD13C8F3;
	Wed, 24 Jul 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="i5QU6qYf"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAC13BC31
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857047; cv=none; b=ZkAkmhRfQJzTOZ2zJCiGWCE9u3D6igMcpQFzYxzkergfY+JVKUkMMs7oKPKZnNKHjGIOmv7qV2cFhwLru/WXDqALliluK3G57qGae4GUchwsSd2xyIeQ6VuBO95gL8+QqF4WupGISskeQxwCYZb9cGQ4+QNLdnZ5T0VT94RRj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857047; c=relaxed/simple;
	bh=aQmaQ03WOOZXRXnBNNNLr6veCCZrh9NaZND3VbjLMME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGzTqsk8G0ORP1IHzv4NZhx+Ggzu4YHRl04kUlwHrTunVWesUtcGkBndpqfxDFjrjdWYivAM3y9ivuVMTUo8yZk1zhBxI7AnX8epmrAAxPxY/iYCpQK9hNrQh3FywDa02DM+16KpCulbsH2vs2TMMOqr6H6yk4OBDqfWa8JWBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=i5QU6qYf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so1770655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721857044; x=1722461844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSSTgQ5w2hw67L9Mcy84Ur9n6hJfVLNLfjLoLub8gmE=;
        b=i5QU6qYfzQgX7XDa4gwXfyiRLtI1V2Hhh6yUr8mI7ZeNY32GXMUf0TxXD6QrHWwY0x
         nRFnakl3thJVD09eWur/uRlwVDIwC7+ux94W9uRF6U3LhdnfoY6GIMIWKqGqkyvEuos5
         24W+/kFJy1lpMOanJ5y7JbyiDZoxQ7WBlUmc00Uf5VpYKryYQyoTCHjWIQe36VrD/pzO
         SqfSUFlWbjPX0Hp9LSQ3kZeZp+wACknzYl7eN8EAQwSGCNZGSQO73K/PtlYzw3ELVkhh
         ZfDSXht8SqcJ7aRfWfCbjuEf1682nZhHaUhcQLIWgkQxBU+hHTzE/UZTgs7qKoFDgGAZ
         +caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721857044; x=1722461844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSSTgQ5w2hw67L9Mcy84Ur9n6hJfVLNLfjLoLub8gmE=;
        b=FGZgL2f6I2ePJrBhRvBIjmaST1nf0t2+2EyqsWMY5kiPhepeGWO9gHbe3A0S7eg7OG
         3+MAcgcdOWzpWd9PX5Q2YKJ0Arxgqe5u/rhbFUYCzvgzs3EaVBDhyUpND9+s/1JsDEAw
         Czawq6rnWcFN4VxBB3q0u/fnRBLRbuc6btSzjU4Rv9CUGnI/bty9jmfNyP+Yi1W0tei+
         4UWhbKQ7TXPWejBiwA7UplnYAgztrzR28ID4ig4IuL06eG+mTr8/D+SqvVL7OVmsZHv6
         NL6ravJxi2p2wB3JgEGJoDn4ICfFfTGwRZ9uPBU86T6TkpLvUxvbLMy+UW0MchC0XNb0
         rjPg==
X-Forwarded-Encrypted: i=1; AJvYcCWSaxcw42upaiEvvX1yE+XOGof6Nyo1LzAvlf2rUMOw+6LLZLNn5y81wiGCJPW3Au/UZSzB2dm7dFvxy1MEXBTd9NEA+mrsFv1+7u+I
X-Gm-Message-State: AOJu0YxcUUdEh6WMuyRSE8ourGVk/zIKGbA2BovvqOx6TG/9kPU18AR+
	1ja00AFX1aCR0xu7q1HXAmT0hGwJJY1Jv2puGuoBEoc6/Wuh5E5oDuk3/+1d49M=
X-Google-Smtp-Source: AGHT+IHxyEu6XDaUe6E5/O/ti2ZJ+Zq2UF8NgvQ7RAEgPsm6Nw77tpqzyjgNHrWmlsbprqB15BLpBA==
X-Received: by 2002:adf:f40e:0:b0:368:4ed7:2acc with SMTP id ffacd0b85a97d-36b3638148cmr6859f8f.5.1721857044110;
        Wed, 24 Jul 2024 14:37:24 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced28sm15366726f8f.88.2024.07.24.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:37:23 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:37:22 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 0/3] Clean up usage of rt_task()
Message-ID: <20240724213722.4fcmambn4ry23qhw@airbuntu>
References: <20240610192018.1567075-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610192018.1567075-1-qyousef@layalina.io>

On 06/10/24 20:20, Qais Yousef wrote:
> Make rt_task() return true only for RT class and add new realtime_task() to
> return true for RT and DL classes to avoid some confusion the old API can
> cause.

I am not aware of any pending review comments for this series. Is it ready to
be picked up?


Thanks!

--
Qais Yousef

> 
> No functional changes intended in patch 1. Patch 2 cleans up the return type as
> suggested by Steve. Patch 3 uses rt_or_dl() instead of 'realtime' as suggested
> by Daniel. As the name was debatable, I'll leave up to the maintainers to pick
> their preference.
> 
> Changes since v5:
> 
> 	* Added a new patch to s/realtime/rt_or_dl/ as suggested by Daniel.
> 	* Added Reviewed-bys.
> 
> Changes since v4:
> 
> 	* Simplify return of rt/realtime_prio() as the explicit true/false was
> 	  not necessary.
> 
> Changes since v3:
> 
> 	* Make sure the 'new' bool functions return true/false instead of 1/0.
> 	* Drop patch 2 about hrtimer usage of realtime_task() as ongoing
> 	  discussion on v1 indicates its scope outside of this simple cleanup.
> 
> Changes since v2:
> 
> 	* Fix one user that should use realtime_task() but remained using
> 	  rt_task() (Sebastian)
> 	* New patch to convert all hrtimer users to use realtime_task_policy()
> 	  (Sebastian)
> 	* Add a new patch to convert return type to bool (Steve)
> 	* Rebase on tip/sched/core and handle a conflict with code shuffle to
> 	  syscalls.c
> 	* Add Reviewed-by Steve
> 
> Changes since v1:
> 
> 	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
> 	* Improve commit message readability about replace some rt_task()
> 	  users.
> 
> v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyousef@layalina.io/
> v2 discussion: https://lore.kernel.org/lkml/20240515220536.823145-1-qyousef@layalina.io/
> v3 discussion: https://lore.kernel.org/lkml/20240527234508.1062360-1-qyousef@layalina.io/
> v4 discussion: https://lore.kernel.org/lkml/20240601213309.1262206-1-qyousef@layalina.io/
> v5 discussion: https://lore.kernel.org/lkml/20240604144228.1356121-1-qyousef@layalina.io/
> 
> Qais Yousef (3):
>   sched/rt: Clean up usage of rt_task()
>   sched/rt, dl: Convert functions to return bool
>   sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()
> 
>  fs/bcachefs/six.c                 |  2 +-
>  fs/select.c                       |  2 +-
>  include/linux/ioprio.h            |  2 +-
>  include/linux/sched/deadline.h    | 14 ++++++-------
>  include/linux/sched/prio.h        |  1 +
>  include/linux/sched/rt.h          | 33 +++++++++++++++++++++++++------
>  kernel/locking/rtmutex.c          |  4 ++--
>  kernel/locking/rwsem.c            |  4 ++--
>  kernel/locking/ww_mutex.h         |  2 +-
>  kernel/sched/core.c               |  4 ++--
>  kernel/sched/syscalls.c           |  2 +-
>  kernel/time/hrtimer.c             |  6 +++---
>  kernel/trace/trace_sched_wakeup.c |  2 +-
>  mm/page-writeback.c               |  4 ++--
>  mm/page_alloc.c                   |  2 +-
>  15 files changed, 53 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> 

