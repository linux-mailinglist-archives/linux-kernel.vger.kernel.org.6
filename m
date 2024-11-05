Return-Path: <linux-kernel+bounces-396229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1069BC99B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D5A1F230A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4EA1D1E8E;
	Tue,  5 Nov 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYEs5Pts"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC561D173E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800289; cv=none; b=QKx7tgRw6gX2DyqHRc7xlAKbUZRBrKQqDtZWq4i+sKW+29gGBpLh75e6amBzDWe7Rj4ptcJyQzxnwoyLHAoilcDqp8Ujeal5+GnYs4IiiIsZO7DflIAFgIWSBpy+1hkx0cYsoxewJNZqeupmPnr3bCtFWd86LfaQD7YyYt9NvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800289; c=relaxed/simple;
	bh=DiMVoBncEgYMa7but05vCNbV01AUvtxNdO3CzysX5nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEulat4N7OvF4ICiKTHw96WI0cd9rzzE9RUhPZI7Xz82ZTIg/9ZPb5ldBdzQCot1FIadKTSh8HucsePk3Um3tYRlby4YRbTcpXXY+RqFRX6OxCnhSALD63APQqey0sAsUSyKrz3vI5+drSQPe7mOVT7NMhd6EXoRfyBZ4aTfok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYEs5Pts; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f3f1849849so201882a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730800287; x=1731405087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwaGk6EDoKX/mSWj1TE2Or6j7PpZkwghT6OhNz4FoQM=;
        b=FYEs5PtsDdx1shXws+dzRY4yNtEAWjirgNikCmYoh6UaDYiKJBTO7a5tSJ8584Zsxb
         ybeSH0lF3Sn0JSu6Sh6lgXKR2QICMrgDCgo6WlBqR2Q8XVJFi1EPBWg1CXS4nlgXGRDD
         h34kcFefzCZB6uWUNwWyxb6mno88ccl41rv8SDweTXOa+nKjSujtr8nJD2IvSmT3ZdpV
         +Q1UexFF4LFBwgHcc7vxoNfyfdoMISToX3UiS+XAMnYygjBFeaB43fPFuqk3bl1Xd6ED
         huUzW3oDxnNYGb2ZbsOUcgNb0v/za29MYAmBB+GJVNNeZWXQf5Z9qbrui9FyyV9NcrWQ
         3pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800287; x=1731405087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwaGk6EDoKX/mSWj1TE2Or6j7PpZkwghT6OhNz4FoQM=;
        b=HYmfJubjGIL9VVPkNrqOxWVwgqsrPwf/B4NGLo+VZR45RaBgXx8Kx+reys5AZt7pkI
         z99ojeOUrj/Lzmo5cDZj0bIBzRCjUJ2WjyW1GHk4xpJnrI5C5s4vVQC1nwXESdCpcX1W
         uUVHeHQkAsWv/RqBRrLvIhY8SKhWJiKgCNBSI9NLxZUp3w/PepfvHUkdiob2tZRqZuPF
         tcRonNHEGSphofoIjSATXSjXA2jr3wOsLmWvHbEMkdZk9jUZzGb9KAHBbiy8Z2pITd0o
         M9bk0jbCm7q/8yBMWYAAj/dNIGz2sNVZ2dkQtYqX/EfbR20EZymxmfcfB+lzKB0Le2jQ
         MxSg==
X-Forwarded-Encrypted: i=1; AJvYcCXz93QMATg7xKGmMiYcvkRfKsj4jM/XcAYa2c4luewhi+2E6IE1gRYWJX0/T8OgOVP6AU9dtZ0c3kHfYUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VlZYz2SY8Wi6RYvVpIiHcJ3dXum5QuXthSKCvD7skcjNEUCg
	vXcZVlOX426iPCNrVpMnXw/IqSec0K5CBU0Moi3q1seLp/s9t0fn/8lVEz5B3r/4ub/fVixA1hN
	39rH6k4bkX+p2VdZSc5Bd9kNEAGpsMYJSva92
X-Google-Smtp-Source: AGHT+IELWZ6/5ydwer85OSYd7JQkhgW7bdlQkuqTs9lSee8NpmsCwnosBKKVxD4aUQHXXnceZDJ5ZgoD0YK4AepujSo=
X-Received: by 2002:a05:6a21:78a6:b0:1db:d980:440e with SMTP id
 adf61e73a8af0-1dbd980462emr8904949637.14.1730800287064; Tue, 05 Nov 2024
 01:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104161910.780003-1-elver@google.com> <20241104161910.780003-6-elver@google.com>
 <20241105093400.GA10375@noisy.programming.kicks-ass.net>
In-Reply-To: <20241105093400.GA10375@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 10:50:50 +0100
Message-ID: <CANpmjNOyE=ZxyMEyEf6i7TX-jEvhiJN5ASFY0FTWRF3azDAB-Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in read_seqbegin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 10:34, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 04, 2024 at 04:43:09PM +0100, Marco Elver wrote:
> > During testing of the preceding changes, I noticed that in some cases,
> > current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
> > obviously wrong, because _all_ accesses for the given task will be
> > treated as atomic, resulting in false negatives i.e. missed data races.
> >
> > Debugging led to fs/dcache.c, where we can see this usage of seqlock:
> >
> >       struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
> >       {
> >               struct dentry *dentry;
> >               unsigned seq;
> >
> >               do {
> >                       seq = read_seqbegin(&rename_lock);
> >                       dentry = __d_lookup(parent, name);
> >                       if (dentry)
> >                               break;
> >               } while (read_seqretry(&rename_lock, seq));
> >       [...]
>
>
> How's something like this completely untested hack?
>
>
>         struct dentry *dentry;
>
>         read_seqcount_scope (&rename_lock) {
>                 dentry = __d_lookup(parent, name);
>                 if (dentry)
>                         break;
>         }
>
>
> But perhaps naming isn't right, s/_scope/_loop/ ?

_loop seems straightforward.

> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -829,6 +829,33 @@ static inline unsigned read_seqretry(con
>         return read_seqcount_retry(&sl->seqcount, start);
>  }
>
> +
> +static inline unsigned read_seq_scope_begin(const struct seqlock_t *sl)
> +{
> +       unsigned ret = read_seqcount_begin(&sl->seqcount);
> +       kcsan_atomic_next(0);
> +       kcsan_flat_atomic_begin();
> +       return ret;
> +}
> +
> +static inline void read_seq_scope_end(unsigned *seq)
> +{
> +       kcsan_flat_atomic_end();

If we are guaranteed to always have one _begin paired by a matching
_end, we can s/kcsan_flat_atomic/kcsan_nestable_atomic/ for these.

> +}
> +
> +static inline bool read_seq_scope_retry(const struct seqlock_t *sl, unsigned *seq)
> +{
> +       bool done = !read_seqcount_retry(&sl->seqcount, *seq);
> +       if (!done)
> +               *seq = read_seqcount_begin(&sl->seqcount);
> +       return done;
> +}
> +
> +#define read_seqcount_scope(sl) \
> +       for (unsigned seq __cleanup(read_seq_scope_end) =               \
> +                       read_seq_scope_begin(sl), done = 0;             \
> +            !done; done = read_seq_scope_retry(sl, &seq))
> +

That's nice! I think before we fully moved over to C11, I recall Mark
and I discussed something like that (on IRC?) but gave up until C11
landed and then we forgot. ;-)

