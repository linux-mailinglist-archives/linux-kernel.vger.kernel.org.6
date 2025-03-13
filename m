Return-Path: <linux-kernel+bounces-560430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE88A6040D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEEA19C28E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793C11F7557;
	Thu, 13 Mar 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFKDWPf6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2A1F0997
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904044; cv=none; b=XAz0K73KYaOn6crHeIQTFEOkpWKCxHrYa12xXdKUSa7M7tE9QyM093BJDfdHNFlMXS/Yu0bKsF33Vpz5J8WJws9U8r/0vmvJpQqr1vD4ykWY7VIe8JLU0k6X04M4XB9dR941mDT6kWfpI1qIQgBbJQAiM4J8D0pCJh3hgbHknRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904044; c=relaxed/simple;
	bh=aqzz6gRlNqkTmL/f6FfSmbIDbSn75wcypCgYACV6W3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMbu6/5J8pmEKVlHNtwBvYZUR0dCYsQvvdR6tEpUUuoSNjcCTP4LBIcpF0Ys/WUP1+OsxXhHDInn8uDVdYDTAFYKbnVFX6viir97dUUgRoxEXAp7Z1JoWDRF2BiSaZbbQryttf+oBgUMdihFRWqCGZFj43fpQLfhLdgrvIOt204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFKDWPf6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so859829f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741904041; x=1742508841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFZ/h/Ot6kwr0Q5y2v+z1nEA3Rw6jKO8iMDvqxUU+ls=;
        b=cFKDWPf6uWidJU5sjk3HPiyA9RWY0Tepa6Ypti+9TLDQtLtgiDML+MgqLwcrbNQRUi
         JiVH3JTmW25VxoLRwFrudcg4iUcgFd/LQAjrpOyugNVOG0xYzhau6VZRHs6kdNWy3QMU
         dxKvO7fD3KpRYFHoyNt6FTFIh/v/9H725KTsQ41/kOUiXsymBIwRDSjYI00c1/IzCcnz
         C55qz6Ht8AgNz884pF1mHjKurzXyIXxYmp4Ia24JKyiEqj30THpI9RgB8mT/hX6em/JO
         7bfmBOY8NCd9TsL5qnqTXdOAnFxRgeyV3Lz2ssS0Mn+3GL+vW+EgnCQ/PHOMqIamI/pf
         tzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741904041; x=1742508841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFZ/h/Ot6kwr0Q5y2v+z1nEA3Rw6jKO8iMDvqxUU+ls=;
        b=NeBEzFXZVUVl4iIZOZydko4NSpteniXb/ary7VsqoaG/7D5JohyucCHYMUJlDX4QFA
         mpUv9oKKFArqyh81kl8FD+bjv+13hLeky+8QGHu9irQhFFMB32EWXLRLE74XIlLC9bOk
         So+utqQSww6yr82lrVsTdfl3hyVt53u4x9G4jWpI4cRB0j4BsQTBiaOP37MuvFSlcxlP
         o32oZWqqTqDuV347tBHOEOhwcdIQ1djHBuu3DzYxV58pv3HOYYnu4erCdpq+YKzKaco6
         eeNzL4UzdjWVh6Njd1/Ug/y44UNDtU6mdoSDlNOxNNLxz5v3s5W4ygYqe6s8jmxIK5Sa
         cDRQ==
X-Gm-Message-State: AOJu0YzkWrD6UI8OtkkVrRIx8vKHsQsz1QaaMXywRUB6VtOqZcJ9nKE0
	7hplU3+uxir0yQaQu9Z1S4v4RDe1dOgxXRUmKIRvIwrwzlf/PveE
X-Gm-Gg: ASbGncukSvSRMSRSySznnIeyxCp1XJ3TCC4J0gmp0WKIzmVYPFcew5ty2DNWPauQIZX
	aE7Yi60VNuS0cd50Mzi6o0s/hxiufscfAdyeXjh5NTrUU0c5Y1WLvVmZ+SF/GaOYKSPrMzlxK5p
	btp+AZN68H5KBVT2tGCrxhIOW52RTsM+h9iA5e8K1km56CK25Qy1NdWUgYWkasfec9TQgE60knb
	0HBRMA9sEZIkVMvCyDCNx6iQf1KUNF6ERSWNIwChFZbIxvqQIEbO5WvjmG2E8Rj7+R0NGAzEZ+o
	DJtf5DS/hT5WMkhn2/NrZIia6ImyezAhoktw2pJjc88tNRj1p7qWzdUBHZphYWNV8pMxQFdq6fP
	05beUli0=
X-Google-Smtp-Source: AGHT+IHDMHRPGo84VP5CWo8PnsW4160k2iMq1y9HSZu4vllU0pjJ0mBn2D/MEZh6jC9LPKzOYfQ5yg==
X-Received: by 2002:a5d:64cd:0:b0:391:300f:7485 with SMTP id ffacd0b85a97d-3971ddd8a0fmr19749f8f.8.1741904041170;
        Thu, 13 Mar 2025 15:14:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188bb213sm34001855e9.17.2025.03.13.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:14:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:13:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Cyrill
 Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 14/18] posix-timers: Avoid false cacheline sharing
Message-ID: <20250313221358.26e270db@pumpkin>
In-Reply-To: <20250308155624.341108067@linutronix.de>
References: <20250308155501.391430556@linutronix.de>
	<20250308155624.341108067@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Mar 2025 17:48:42 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> struct k_itimer has the hlist_node, which is used for lookup in the hash
> bucket, and the timer lock in the same cache line.
> 
> That's obviously bad, if one CPU fiddles with a timer and the other is
> walking the hash bucket on which that timer is queued.
> 
> Avoid this by restructuring struct k_itimer, so that the read mostly (only
> modified during setup and teardown) fields are in the first cache line and
> the lock and the rest of the fields which get written to are in cacheline
> 2-N.

How big is the structure?
If I count it correctly the first 'cacheline' is 64 bytes on 64bit
(and somewhat smaller on 32bit - if anyone cares).

But there are some cpu (probably ppc) with quite large cache lines.
In that case you either need to waste the space by aligning the 2nd
part the structure into an actual cache line, or just align the
structure to a 64 byte boundary.

	David

> 
> Reduces cacheline contention in a test case of 64 processes creating and
> accessing 20000 timers each by almost 30% according to perf.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
> V2: New patch
> ---
>  include/linux/posix-timers.h |   21 ++++++++++++---------
>  kernel/time/posix-timers.c   |    4 ++--
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -177,23 +177,26 @@ static inline void posix_cputimers_init_
>   * @rcu:		RCU head for freeing the timer.
>   */
>  struct k_itimer {
> -	struct hlist_node	list;
> -	struct hlist_node	ignored_list;
> +	/* 1st cacheline contains read-mostly fields */
>  	struct hlist_node	t_hash;
> -	spinlock_t		it_lock;
> -	const struct k_clock	*kclock;
> -	clockid_t		it_clock;
> +	struct hlist_node	list;
>  	timer_t			it_id;
> +	clockid_t		it_clock;
> +	int			it_sigev_notify;
> +	enum pid_type		it_pid_type;
> +	struct signal_struct	*it_signal;
> +	const struct k_clock	*kclock;
> +
> +	/* 2nd cacheline and above contain fields which are modified regularly */
> +	spinlock_t		it_lock;
>  	int			it_status;
>  	bool			it_sig_periodic;
>  	s64			it_overrun;
>  	s64			it_overrun_last;
>  	unsigned int		it_signal_seq;
>  	unsigned int		it_sigqueue_seq;
> -	int			it_sigev_notify;
> -	enum pid_type		it_pid_type;
>  	ktime_t			it_interval;
> -	struct signal_struct	*it_signal;
> +	struct hlist_node	ignored_list;
>  	union {
>  		struct pid		*it_pid;
>  		struct task_struct	*it_process;
> @@ -210,7 +213,7 @@ struct k_itimer {
>  		} alarm;
>  	} it;
>  	struct rcu_head		rcu;
> -};
> +} ____cacheline_aligned_in_smp;
>  
>  void run_posix_cpu_timers(void);
>  void posix_cpu_timers_exit(struct task_struct *task);
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -260,8 +260,8 @@ static int posix_get_hrtimer_res(clockid
>  
>  static __init int init_posix_timers(void)
>  {
> -	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
> -					       SLAB_ACCOUNT, NULL);
> +	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
> +					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
>  	return 0;
>  }
>  __initcall(init_posix_timers);
> 
> 


