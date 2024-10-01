Return-Path: <linux-kernel+bounces-346096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DECE98BF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F55BB27378
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA81CC8A3;
	Tue,  1 Oct 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3XgHC17"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213701CC89A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792005; cv=none; b=rkCW9s+oZ5xHRaZl9zuH277Tvnrqo14T3/BHsLX6Vo3QAjjZcRGB8ObYt52G4MfRFqNG9iiNiMKKxPAcn6/kAq5vNRGzN5nqPGNQJP0GN3fOfZNpmDbZe9Vp7DVIfXl2x9NeTY5ufx8Ue4wiUV9pdzwik5h/+KnV5rel/GTdni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792005; c=relaxed/simple;
	bh=T2UWeMkxT5kUo3xF05384MHT4Set4Ecqy/w+gdsiCnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Gmb04+YRe4JYapcSpHfaxMBUOaSI0tuJj59agf6LYkhUE9lARqHUEXfszj0WZB0LFU6FNNWvdk8EynDBIWp2CXeahwo/QFVebnN1eZPIWtnKSNKkOG/4EDK07iNK7LZKD4TN6/ZIOfrBdePhIPDbI/NteGi6wx8CJfXeSQC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3XgHC17; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so51666765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727792001; x=1728396801; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uAVLa6jHgMD7nykfCkBu85ErdpyyKq2zMpzHNmQ1oM=;
        b=s3XgHC17EbqfRvWiO3MZsNEbXFvAumhjw7KqOXRiJogsFuO7YPGKRLBrPOlGUk7hQ6
         aHPRfmnFCjBKR1Am1nULqBpCTgaVrNjHkNgx/S29Smo9+yPLSTzmccw5bh+DUu5TeHJx
         HEHVtizTNO7H8HxPJQUc1iHShj5tfOZaCmKRt4pPXnoASkdskjzZ3aKArvXXUQsFtFgB
         ifnDo7B6cPsh7Gdp8SOatJKa6cVgYZlY3GI80w1pXeMnLZOvFe2oShWzBn5XNhQIKvty
         5ed5gkuh34qPgUJibgdUsaJZVOf1d+7Qohw3goyFyUJmMc+FEciSF8zym6+jnvS7sUEL
         JZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792001; x=1728396801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uAVLa6jHgMD7nykfCkBu85ErdpyyKq2zMpzHNmQ1oM=;
        b=eFJ6G3FZJk2356i2F3zn0FVwiJfVwjVVXeXcm5CvbTK74QC5lV8LdxiFE2MKHE2K2K
         kOwIMk2JkGwC9lvBzD2287I4g8nj2hZA7lnbeHEMDSB11gqIuq+z7UVBd4WZjympo0RC
         3OLJx5EWwoXk/sbwVIvewSquIuPpPvQIGxbCWmDSP0KooXeuElv7GdehbwF5m5XxFfBT
         mOoA+zDC8mnOfe/QXST26ZUK8XzFK92J6x72WQnI6Gb4l75LUjK4hgN1WVgxjqII4w9Y
         zN3m33TQbuG5t6sMiwTmPUO8qUI/pKQanLyqzK+I88QxDyIi/wl+ao6QdfkaarVhKCRy
         6+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVlDGbfj6wsHmoCrI8repRJJVFj8vnKkeoPHh4T/tWOinJz8C2uvRiJqYTzXMB2SdsR+ze8RkE0apdvsFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH3LD5QGsuqf0tI23sJlwWsAgbZiT1FcP7iRnQrtfRrndwbPY
	/MMo1LVAvjiLOFMBwTQa2xunMUTA7Q75l6y5iXeQkIiWMVZIt66zckLxIfDnQA==
X-Google-Smtp-Source: AGHT+IHy9vdfFKIfNd5lOwMbJdbVdiWCHK+SUund/dNi85O4uaJatQmBcE7LpIoNvY8Etk65qBwgJw==
X-Received: by 2002:a05:600c:5125:b0:42c:b22e:fc2e with SMTP id 5b1f17b1804b1-42f5844b601mr126150115e9.15.1727792001106;
        Tue, 01 Oct 2024 07:13:21 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:72e:46e:f572:615b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm182122035e9.9.2024.10.01.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:13:20 -0700 (PDT)
Date: Tue, 1 Oct 2024 16:13:14 +0200
From: Marco Elver <elver@google.com>
To: ran xiaokai <ranxiaokai627@163.com>
Cc: tglx@linutronix.de, dvyukov@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH 3/4] kcsan, debugfs: fix atomic sleep by converting
 spinlock_t to rcu lock
Message-ID: <ZvwDevIahZ5352mO@elver.google.com>
References: <20240925143154.2322926-1-ranxiaokai627@163.com>
 <20240925143154.2322926-4-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925143154.2322926-4-ranxiaokai627@163.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Wed, Sep 25, 2024 at 02:31PM +0000, ran xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> In a preempt-RT kernel, most of the irq handlers have been
> converted to the threaded mode except those which have the
> IRQF_NO_THREAD flag set. The hrtimer IRQ is such an example.
> So kcsan report could be triggered from a HARD-irq context, this will
> trigger the "sleeping function called from invalid context" bug.
> 
> [    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> [    C1] preempt_count: 10002, expected: 0
> [    C1] RCU nest depth: 0, expected: 0
> [    C1] no locks held by swapper/1/0.
> [    C1] irq event stamp: 156674
> [    C1] hardirqs last  enabled at (156673): [<ffffffff81130bd9>] do_idle+0x1f9/0x240
> [    C1] hardirqs last disabled at (156674): [<ffffffff82254f84>] sysvec_apic_timer_interrupt+0x14/0xc0
> [    C1] softirqs last  enabled at (0): [<ffffffff81099f47>] copy_process+0xfc7/0x4b60
> [    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    C1] Preemption disabled at:
> [    C1] [<ffffffff814a3e2a>] paint_ptr+0x2a/0x90
> [    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0+ #3
> [    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
> [    C1] Call Trace:
> [    C1]  <IRQ>
> [    C1]  dump_stack_lvl+0x7e/0xc0
> [    C1]  dump_stack+0x1d/0x30
> [    C1]  __might_resched+0x1a2/0x270
> [    C1]  rt_spin_lock+0x68/0x170
> [    C1]  ? kcsan_skip_report_debugfs+0x43/0xe0
> [    C1]  kcsan_skip_report_debugfs+0x43/0xe0
> [    C1]  ? hrtimer_next_event_without+0x110/0x110
> [    C1]  print_report+0xb5/0x590
> [    C1]  kcsan_report_known_origin+0x1b1/0x1d0
> [    C1]  kcsan_setup_watchpoint+0x348/0x650
> [    C1]  __tsan_unaligned_write1+0x16d/0x1d0
> [    C1]  hrtimer_interrupt+0x3d6/0x430
> [    C1]  __sysvec_apic_timer_interrupt+0xe8/0x3a0
> [    C1]  sysvec_apic_timer_interrupt+0x97/0xc0
> [    C1]  </IRQ>
> 
> To fix this, we can not simply convert the report_filterlist_lock
> to a raw_spinlock_t. In the insert_report_filterlist() path:
> 
> raw_spin_lock_irqsave(&report_filterlist_lock, flags);
>   krealloc
>     __do_kmalloc_node
>       slab_alloc_node
>         __slab_alloc
>           local_lock_irqsave(&s->cpu_slab->lock, flags)
> 
> local_lock_t is now a spinlock_t which is sleepable in preempt-RT
> kernel, so kmalloc() and similar functions can not be called with
> a raw_spinlock_t lock held.
> 
> Instead, we can convert it to rcu lock to fix this.
> Aso introduce a mutex to serialize user-space write operations.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
[...]
> -	spin_lock_irqsave(&report_filterlist_lock, flags);
> -	if (report_filterlist.used == 0)
> +	rcu_read_lock();
> +	list = rcu_dereference(rp_flist);
> +
> +	if (!list)
> +		goto out;
> +
> +	if (list->used == 0)
>  		goto out;
>  
>  	/* Sort array if it is unsorted, and then do a binary search. */
> -	if (!report_filterlist.sorted) {
> -		sort(report_filterlist.addrs, report_filterlist.used,
> +	if (!list->sorted) {
> +		sort(list->addrs, list->used,
>  		     sizeof(unsigned long), cmp_filterlist_addrs, NULL);
> -		report_filterlist.sorted = true;
> +		list->sorted = true;
>  	}

This used to be under the report_filterlist_lock, but now there's no
protection against this happening concurrently.

Sure, at the moment, this is not a problem, because this function is
only called under the report_lock which serializes it. Is that intended?

> -	ret = !!bsearch(&func_addr, report_filterlist.addrs,
> -			report_filterlist.used, sizeof(unsigned long),
> +	ret = !!bsearch(&func_addr, list->addrs,
> +			list->used, sizeof(unsigned long),
>  			cmp_filterlist_addrs);
> -	if (report_filterlist.whitelist)
> +	if (list->whitelist)
>  		ret = !ret;
[...]
> +
> +	memcpy(new_list, old_list, sizeof(struct report_filterlist));
> +	new_list->whitelist = whitelist;
> +
> +	rcu_assign_pointer(rp_flist, new_list);
> +	synchronize_rcu();
> +	kfree(old_list);

Why not kfree_rcu()?

> +out:
> +	mutex_unlock(&rp_flist_mutex);
> +	return ret;
>  }
[...]
> +	} else {
> +		new_addrs = kmalloc_array(new_list->size,
> +					  sizeof(unsigned long), GFP_KERNEL);
> +		if (new_addrs == NULL)
> +			goto out_free;
> +
> +		memcpy(new_addrs, old_list->addrs,
> +				old_list->size * sizeof(unsigned long));
> +		new_list->addrs = new_addrs;
>  	}

Wait, for every insertion it ends up copying the list now? That's very
wasteful.

In general, this solution seems overly complex, esp. the part where it
ends up copying the whole list on _every_ insertion.

If the whole point is to avoid kmalloc() under the lock, we can do
something much simpler.

Please test the patch below - it's much simpler, and in the common case
I expect it to rarely throw away the preemptive allocation done outside
the critical section because concurrent insertions by the user should be
rarely done.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 1 Oct 2024 16:00:45 +0200
Subject: [PATCH] kcsan: turn report_filterlist_lock into a raw_spinlock

<tbd... please test>

Reported-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..5ffb6cc5298b 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -46,14 +46,8 @@ static struct {
 	int		used;		/* number of elements used */
 	bool		sorted;		/* if elements are sorted */
 	bool		whitelist;	/* if list is a blacklist or whitelist */
-} report_filterlist = {
-	.addrs		= NULL,
-	.size		= 8,		/* small initial size */
-	.used		= 0,
-	.sorted		= false,
-	.whitelist	= false,	/* default is blacklist */
-};
-static DEFINE_SPINLOCK(report_filterlist_lock);
+} report_filterlist;
+static DEFINE_RAW_SPINLOCK(report_filterlist_lock);
 
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
@@ -110,7 +104,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		return false;
 	func_addr -= offset; /* Get function start */
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	if (report_filterlist.used == 0)
 		goto out;
 
@@ -127,7 +121,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		ret = !ret;
 
 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 	return ret;
 }
 
@@ -135,9 +129,9 @@ static void set_report_filterlist_whitelist(bool whitelist)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	report_filterlist.whitelist = whitelist;
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 }
 
 /* Returns 0 on success, error-code otherwise. */
@@ -145,6 +139,9 @@ static ssize_t insert_report_filterlist(const char *func)
 {
 	unsigned long flags;
 	unsigned long addr = kallsyms_lookup_name(func);
+	unsigned long *delay_free = NULL;
+	unsigned long *new_addrs = NULL;
+	size_t new_size = 0;
 	ssize_t ret = 0;
 
 	if (!addr) {
@@ -152,32 +149,33 @@ static ssize_t insert_report_filterlist(const char *func)
 		return -ENOENT;
 	}
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+retry_alloc:
+	/*
+	 * Check if we need an allocation, and re-validate under the lock. Since
+	 * the report_filterlist_lock is a raw, cannot allocate under the lock.
+	 */
+	if (data_race(report_filterlist.used == report_filterlist.size)) {
+		new_size = (report_filterlist.size ?: 4) * 2;
+		delay_free = new_addrs = kmalloc_array(new_size, sizeof(unsigned long), GFP_KERNEL);
+		if (!new_addrs)
+			return -ENOMEM;
+	}
 
-	if (report_filterlist.addrs == NULL) {
-		/* initial allocation */
-		report_filterlist.addrs =
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-	} else if (report_filterlist.used == report_filterlist.size) {
-		/* resize filterlist */
-		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
-		if (new_addrs == NULL) {
-			/* leave filterlist itself untouched */
-			ret = -ENOMEM;
-			goto out;
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (report_filterlist.used == report_filterlist.size) {
+		/* Check we pre-allocated enough, and retry if not. */
+		if (report_filterlist.used >= new_size) {
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(new_addrs); /* kfree(NULL) is safe */
+			delay_free = new_addrs = NULL;
+			goto retry_alloc;
 		}
 
+		if (report_filterlist.used)
+			memcpy(new_addrs, report_filterlist.addrs, report_filterlist.used * sizeof(unsigned long));
+		delay_free = report_filterlist.addrs; /* free the old list */
+		report_filterlist.addrs = new_addrs;  /* switch to the new list */
 		report_filterlist.size = new_size;
-		report_filterlist.addrs = new_addrs;
 	}
 
 	/* Note: deduplicating should be done in userspace. */
@@ -185,8 +183,10 @@ static ssize_t insert_report_filterlist(const char *func)
 		kallsyms_lookup_name(func);
 	report_filterlist.sorted = false;
 
-out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+
+	if (delay_free)
+		kfree(delay_free);
 
 	return ret;
 }
@@ -204,13 +204,13 @@ static int show_info(struct seq_file *file, void *v)
 	}
 
 	/* show filter functions, and filter type */
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	seq_printf(file, "\n%s functions: %s\n",
 		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
 		   report_filterlist.used == 0 ? "none" : "");
 	for (i = 0; i < report_filterlist.used; ++i)
 		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 
 	return 0;
 }
-- 
2.46.1.824.gd892dcdcdd-goog


