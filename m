Return-Path: <linux-kernel+bounces-512131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADBA33484
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E903165117
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462D80034;
	Thu, 13 Feb 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBxP72GS"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C52B2CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409634; cv=none; b=t0C8tyLREsXCCPzdrkNW9tEzbTzp2szXn5CfNKGSotrShX1/7MDNohC+8zTcs84WPBz7ZKEJAH+P3GN0Tu55dC0NguflqgQMruH/mN3Mr/re0Xrx+aJWdSOoUS+pGGPRF+gBNkxxPI5J9PEUDMFsZFOR8+v+ajf3wIHZKtBdZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409634; c=relaxed/simple;
	bh=rddLN22d+/1D/2o2/F804ZOaB7V9MqCThiWg6yyHFnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spyQSWOsZAwR6Q/vbVIqEfuhSsZ+LiF7T4FRWIBT4dSByUV0H8kl1Bfdhk/vI+0ZA+lNbW01DcuZQX5vrR9ZEskzXH0iJI5opaWwPvys4eGn8dduHIjd/ZxHDGMNxrwEzSLXYkzZLGhq3mFfp/RqvduZIMrjQJU5EmbKTqee4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dBxP72GS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so579918a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739409632; x=1740014432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5yzcW8oX5WUcT7aJd3CF5Y4NwhpvWpkNhi9XuFS/SQ=;
        b=dBxP72GSiNGc96Ya8RdVj4rjminyhCqIth6cOhubHrmV/G/Jo5gVO2PlhKRpoxaeC7
         Ovp/ILvmqGaSAGqXE+2kVeW2VfFPPApCTB39sb0nueIpjtiecrMC+zvN15/jlkdKywo7
         22le2dg+QID2XMuBaKlD6Pc+CjelvJs+4DYYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409632; x=1740014432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5yzcW8oX5WUcT7aJd3CF5Y4NwhpvWpkNhi9XuFS/SQ=;
        b=qkMel88ixsFSE5OcP0D+tB4w/wQE4Bvbsbtm3bJPuvL8oxEa+0+llmsqaf7yyjx0X2
         kzB7voLe+Bj/TFIBM2bsasqbG6SE1ew0gl0WX8ehXY+X0L1yUtNoyHSDIQka+rYsIm/M
         cyU84Xa3MU79oF9T3WZwm7OW0Mpb7ANyqAAZLE9jnXMy1JqLwcnz4/efzLj2PH/srF+9
         5qbEPR3NdBmglbXRAcmOdKQJqLaUnF6k4jMfJehraxp2HkY1d25bTP/btLmPWDhHx5cQ
         5TpT5puF+nRCewZNnt1CkXPfhQPWuYYzQiT13jrKhy3psR8mDX4Jx6aeM5vzp79AUc7m
         vPxw==
X-Forwarded-Encrypted: i=1; AJvYcCXunUlQf2SkCxh0A8xhYhidi1eTtRLOfDYvrGeDjLeSGfJO0bI6srOeTr5mSrFm6y7mq8MFiuibbsHNoQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7togi6y22kmamWTfpRdghq4tzifv9k+WbmR1ziQWN2kEMx3l
	6i8qpl0nNcH+zL8uejuCUOK1jGUmoFdPnzTqhWALX89m72PeIRODpVANucX0Wg==
X-Gm-Gg: ASbGnct1NgxgpNq4+RvO5wkzYZ/Kt11mGLpQHOdWz4IjDUS8Vk4pBUc3wZZmhpzsbte
	adNGJp+HAJBU5z3ZG6Ef1Qh1pyAtR1ElWSRevXcLgJGouhbAhotwe6JFQNErGf0QIiazRQClkjL
	23GHIC1ng2tPket8V1mmH8uo56OYfUA9b7XnMN9j24Tko6KqXieELtsmj6xK7FuNd/y1Ni8Plqc
	Y1s8JfbYZ1NQwrHbPnPGFkwC/EAyMQaAjP1g6KKwEMJVtBf6lQHenpE3POU8+gY4RZsOtUMlU3P
	Nqmw9Ud3m2rYU95xQ2w=
X-Google-Smtp-Source: AGHT+IFz78SukHoa4AyFSSbifesUTDX5mA95Vm0b7xBenCGTT8D1XDGYUmY9XlGjCsqa6H9V082PRw==
X-Received: by 2002:a17:90b:1b0b:b0:2ea:356f:51b4 with SMTP id 98e67ed59e1d1-2fc0e2c967bmr1874970a91.13.1739409631957;
        Wed, 12 Feb 2025 17:20:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ac0a84sm91974a91.16.2025.02.12.17.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:20:31 -0800 (PST)
Date: Thu, 13 Feb 2025 10:20:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Message-ID: <etumn4tax7g5c3wygn2aazmo5m7f4ydfji7ehno5i6jckkf27e@mu3fisrw5jcc>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-13-senozhatsky@chromium.org>
 <Z6zXEktee8OS51hg@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zXEktee8OS51hg@google.com>

On (25/02/12 17:14), Yosry Ahmed wrote:
> On Wed, Feb 12, 2025 at 03:27:10PM +0900, Sergey Senozhatsky wrote:
> > Switch over from rwlock_t to a atomic_t variable that takes negative
> > value when the page is under migration, or positive values when the
> > page is used by zsmalloc users (object map, etc.)   Using a rwsem
> > per-zspage is a little too memory heavy, a simple atomic_t should
> > suffice.
> 
> We should also explain that rwsem cannot be used due to the locking
> context (we need to hold it in an atomic context). Basically what you
> explained to me before :)
>
> > zspage lock is a leaf lock for zs_map_object(), where it's read-acquired.
> > Since this lock now permits preemption extra care needs to be taken when
> > it is write-acquired - all writers grab it in atomic context, so they
> > cannot spin and wait for (potentially preempted) reader to unlock zspage.
> > There are only two writers at this moment - migration and compaction.  In
> > both cases we use write-try-lock and bail out if zspage is read locked.
> > Writers, on the other hand, never get preempted, so readers can spin
> > waiting for the writer to unlock zspage.
> 
> The details are important, but I think we want to concisely state the
> problem statement either before or after. Basically we want a lock that
> we *never* sleep while acquiring but *can* sleep while holding in read
> mode. This allows holding the lock from any context, but also being
> preemptible if the context allows it.

Ack.

[..]
> > +/*
> > + * zspage locking rules:
> 
> Also here we need to state our key rule:
> Never sleep while acquiring, preemtible while holding (if possible). The
> following rules are basically how we make sure we keep this true.
> 
> > + *
> > + * 1) writer-lock is exclusive
> > + *
> > + * 2) writer-lock owner cannot sleep
> > + *
> > + * 3) writer-lock owner cannot spin waiting for the lock
> > + *   - caller (e.g. compaction and migration) must check return value and
> > + *     handle locking failures
> > + *   - there is only TRY variant of writer-lock function
> > + *
> > + * 4) reader-lock owners (multiple) can sleep
> > + *
> > + * 5) reader-lock owners can spin waiting for the lock, in any context
> > + *   - existing readers (even preempted ones) don't block new readers
> > + *   - writer-lock owners never sleep, always unlock at some point
> 
> 
> May I suggest something more concise and to the point?
> 
> /*
>  * The zspage lock can be held from atomic contexts, but it needs to remain
>  * preemptible when held for reading because it remains held outside of those
>  * atomic contexts, otherwise we unnecessarily lose preemptibility.
>  *
>  * To achieve this, the following rules are enforced on readers and writers:
>  *
>  * - Writers are blocked by both writers and readers, while readers are only
>  *   blocked by writers (i.e. normal rwlock semantics).
>  *
>  * - Writers are always atomic (to allow readers to spin waiting for them).
>  *
>  * - Writers always use trylock (as the lock may be held be sleeping readers).
>  *
>  * - Readers may spin on the lock (as they can only wait for atomic writers).
>  *
>  * - Readers may sleep while holding the lock (as writes only use trylock).
>  */

Looks good, thanks.

> > + */
> > +static void zspage_read_lock(struct zspage *zspage)
> > +{
> > +	atomic_t *lock = &zspage->lock;
> > +	int old = atomic_read_acquire(lock);
> > +
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	rwsem_acquire_read(&zspage->lockdep_map, 0, 0, _RET_IP_);
> > +#endif
> > +
> > +	do {
> > +		if (old == ZS_PAGE_WRLOCKED) {
> > +			cpu_relax();
> > +			old = atomic_read_acquire(lock);
> > +			continue;
> > +		}
> > +	} while (!atomic_try_cmpxchg_acquire(lock, &old, old + 1));
> > +}
> > +
> > +static void zspage_read_unlock(struct zspage *zspage)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	rwsem_release(&zspage->lockdep_map, _RET_IP_);
> > +#endif
> > +	atomic_dec_return_release(&zspage->lock);
> > +}
> > +
> > +static __must_check bool zspage_try_write_lock(struct zspage *zspage)
> 
> I believe zspage_write_trylock() would be closer to the normal rwlock
> naming.

It derived its name from rwsem "age".  Can rename.

> > +{
> > +	atomic_t *lock = &zspage->lock;
> > +	int old = ZS_PAGE_UNLOCKED;
> > +
> > +	WARN_ON_ONCE(preemptible());
> 
> Hmm I know I may have been the one suggesting this, but do we actually
> need it? We disable preemption explicitly anyway before holding the
> lock.

This is just to make sure that the precondition for
"writer is always atomic" is satisfied.  But I can drop it.

> >  	size_class_lock(class);
> > -	/* the migrate_write_lock protects zpage access via zs_map_object */
> > -	migrate_write_lock(zspage);
> > +	/* the zspage write_lock protects zpage access via zs_map_object */
> > +	if (!zspage_try_write_lock(zspage)) {
> > +		size_class_unlock(class);
> > +		pool_write_unlock(pool);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* We're committed, tell the world that this is a Zsmalloc page. */
> > +	__zpdesc_set_zsmalloc(newzpdesc);
> 
> We used to do this earlier on, before any locks are held. Why is it
> moved here?

I want to do that only if zspaage write-trylock has succeeded (we didn't
have any error out paths before).

