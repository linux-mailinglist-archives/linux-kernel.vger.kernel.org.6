Return-Path: <linux-kernel+bounces-387676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD09B5474
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5A91C2095F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72992076AA;
	Tue, 29 Oct 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZglEin4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED212201279
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234974; cv=none; b=nr0BaPzcIanwe29OMaxYL/tLCZ+nZCJHkuR77h7UmyR3DT2y4ridxb57UuwJI4elxTy7oTzpqTndZYcJNMUwwog/gTpy7Ze+PTBx2yHQOjPY3DfvU2DYG7/5moG7Mufa1ctHv/mrO/8y2HCJyta/P4wct+Mj/QzeovtUBPEVDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234974; c=relaxed/simple;
	bh=ywvhNwjFOyXe9VTFe+2IOrlDHxmNE3sYhPOwqz4SHf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdYk5ralPwohFNec4dq18IKGw8jNb9EHpbIJzQmeS74UNbFD19lAJq/xkmY/yTK/zFnVCWdPXZqn0zcQ3JlxsVeSgngd2ui3NhC5tIAkkMRrgMZISrDelt24KVzcEXLQd/GVjXAn4ybEm1rhiMrPrlwDZPXY7LIpJcF8bsiO6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZglEin4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so1703015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234970; x=1730839770; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAvGabJbVQ0MLApUMZF9EFIEnk5suR68XuTbaLM5KAs=;
        b=UZglEin4Kw52eirtY9/NFSfnQlzvBsqfzOy0sEFF6TnaLAwGrWrhJlHCJ1kmbbGGC/
         zOfXnViC5z2ldQA4K7kva2tCVOBU6dtq5QSw0cb/rnkP1cENu6oKJDTad8fWikzFP6eL
         4kK4bslDfo+eqSv/ftakiYNtnkO9g2pvZcWyvrFzh7BPbd0zwZVeA0leObNiDNKCu3jI
         LnpYxU9T8Y8AtA2KXARGIdLEz8mTvKlQ+6aKZ6wvxfNX7X9OwmjdNcYa236lj6Z29uni
         binlBQDB+Yg65dDh3s5MrhGjYCoZduy24SoK0ZpOfenchXAe1mrKm9TTMzGGCQ0z+0H5
         BTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234970; x=1730839770;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAvGabJbVQ0MLApUMZF9EFIEnk5suR68XuTbaLM5KAs=;
        b=ANqEH2vmm/fs2b5E6ol5KHmcLtYj7GGzvXvTS2N2Qwr3r8iAMvOqjzueMsQ1lneaQM
         NjX0YMOyCeRJZMmlkDj4pAfeOJdcymCr9Nf9kKZQRFe5vofQzxwPHPR2zqu+zmApTPgU
         nvuOH26JC5g/7H1yavGTEqv5EGuAcflnZO4UFD9faysHNUhL22/uaMLOGaZYPx4pBsGU
         Hr/BxkKb6cQGTQSO6nedbdaGdzn6BNLImX3XyFvbovE+2wXhaLU89Mave4SvzogpI1aa
         zdwnvyzbdgZLrOj9WoCkKEEFidPMFB7LImHhk8E9ad+RjO6cORBKSavER+6vHx9i+Wgw
         o1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxggxQfa8F0wuXDBSIf5XuQ9zNFbr4luM77h+4x1cH+EouMAexKUaUzr1KuT+x8N2/m30zj5kfG5Ac+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qsdlk60KfUNqhL8INrHsxfoyWhePBzzCaOLVDVSxImetgJVZ
	bt1B5TdVhFG8Y9lfRUcxwm6SS0bKfLYKOob7FTR8/RIaDAVZYKPhe0hBosn6lw==
X-Google-Smtp-Source: AGHT+IG+jfqUfnV3NYLX10iVdIS1AD9jWUchFd2nFUkxAgCNXoHEPd80MyvsCr2XX4KFrBAIqWpJ2g==
X-Received: by 2002:a05:600c:3594:b0:431:9340:77e0 with SMTP id 5b1f17b1804b1-431b5727b99mr32087645e9.9.1730234970120;
        Tue, 29 Oct 2024 13:49:30 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:7cc7:9e06:a6d2:add7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd98e7e4sm305295e9.39.2024.10.29.13.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:49:28 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:49:21 +0100
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
Message-ID: <ZyFKUU1LpFfLrVXb@elver.google.com>
References: <20241029083658.1096492-1-elver@google.com>
 <20241029114937.GT14555@noisy.programming.kicks-ass.net>
 <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
 <20241029134641.GR9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029134641.GR9767@noisy.programming.kicks-ass.net>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Oct 29, 2024 at 02:46PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 29, 2024 at 02:05:38PM +0100, Marco Elver wrote:
> > On Tue, 29 Oct 2024 at 12:49, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 09:36:29AM +0100, Marco Elver wrote:
> > > > Reviewing current raw_write_seqcount_latch() callers, the most common
> > > > patterns involve only few memory accesses, either a single plain C
> > > > assignment, or memcpy;
> > >
> > > Then I assume you've encountered latch_tree_{insert,erase}() in your
> > > travels, right?
> > 
> > Oops. That once certainly exceeds the "8 memory accesses".
> > 
> > > Also, I note that update_clock_read_data() seems to do things
> > > 'backwards' and will completely elide your proposed annotation.
> > 
> > Hmm, for the first access, yes. This particular oddity could be
> > "fixed" by surrounding the accesses by
> > kcsan_nestable_atomic_begin/end(). I don't know if it warrants adding
> > a raw_write_seqcount_latch_begin().
> > 
> > Preferences?
> 
> I *think* it is doable to flip it around to the 'normal' order, but
> given I've been near cross-eyed with a head-ache these past two days,
> I'm not going to attempt a patch for you, since I'm bound to get it
> wrong :/

Something like this?

------ >8 ------

Author: Marco Elver <elver@google.com>
Date:   Tue Oct 29 21:16:21 2024 +0100

    time/sched_clock: Swap update_clock_read_data() latch writes
    
    Swap the writes to the odd and even copies to make the writer critical
    section look like all other seqcount_latch writers.
    
    With that, we can also add the raw_write_seqcount_latch_end() to clearly
    denote the end of the writer section.
    
    Signed-off-by: Marco Elver <elver@google.com>

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c1190ac7..311c90a0e86e 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -119,9 +119,6 @@ unsigned long long notrace sched_clock(void)
  */
 static void update_clock_read_data(struct clock_read_data *rd)
 {
-	/* update the backup (odd) copy with the new data */
-	cd.read_data[1] = *rd;
-
 	/* steer readers towards the odd copy */
 	raw_write_seqcount_latch(&cd.seq);
 
@@ -130,6 +127,11 @@ static void update_clock_read_data(struct clock_read_data *rd)
 
 	/* switch readers back to the even copy */
 	raw_write_seqcount_latch(&cd.seq);
+
+	/* update the backup (odd) copy with the new data */
+	cd.read_data[1] = *rd;
+
+	raw_write_seqcount_latch_end(&cd.seq);
 }
 
 /*

------ >8 ------

I also noticed your d16317de9b41 ("seqlock/latch: Provide
raw_read_seqcount_latch_retry()") to get rid of explicit instrumentation
in noinstr.

Not sure how to resolve that. We have that objtool support to erase
calls in noinstr code (is_profiling_func), but that's x86 only.

I could also make kcsan_atomic_next(0) noinstr compatible by checking if
the ret IP is in noinstr, and immediately return if it is.

Preferences?

