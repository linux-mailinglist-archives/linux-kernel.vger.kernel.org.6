Return-Path: <linux-kernel+bounces-515139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A681BA360BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615F43A7800
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A72264FB0;
	Fri, 14 Feb 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGFKSavt"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02402641F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544307; cv=none; b=TgOe0ziuXB/o3MbE7V2T1MX+3avorzEFLiuNM7y7iwqy3Vffzctku7PUggqa7j7afNz0pxaWPVdz7PyWQoyGZL4Ok2UZAAXOUs0Hn/1W8CqF1FDj+XqJ3ofrtIZ+1gdtFwD3pxT4E1QpeyV6iONeKHYCq/o2b9WmqAfY31SL68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544307; c=relaxed/simple;
	bh=rfrcrSb1plBWHOhZleJtEKvBZG2koFNI2c/CE5LuOEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRelbmHcHQ/hOkJCWNlf6cxMDOrWAWP5gqx/qI4tlHOVoo2GLe1UVubGQHMtBafABwwUyPWcySCMZ1N0Fmec0+EtCgOSX3/u6xXkO8P698kC6A8oPlaVcUtRjCaRtyDgRUYx+KvGG/MWAruIt1Molavrug7m6MMFWnv+dorqZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGFKSavt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so4063355a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739544305; x=1740149105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAfs/2wWZw1nrswKtLLAZKfz4qKwgA4SGanKMqohMA0=;
        b=OGFKSavtKQVOGOatc7Nh08w6HM7iVFFW0URdzvmAKdiLuNUQFxj8Twq/OW7XzvRd8C
         p4A7U2EiEAx/2LmVdPxqZt2Gnk7WzPCIvv5/iOI2mCD4qgGN79r5REBQGHMN/9dwXxjc
         uKfMMnJceP44wDn6euQNA5VCefe4bIRCn72180XdGH/sH+LF9r/XFpE1wv1H6C0lN7XE
         tuV3fe2CFZGsVNJVDOdKl3gNxDIwQwQK/3rsI7S4rIBCiSwPnpCT3sJ42DZQHXs1/Epf
         o1PmEpoHIcApbjqMndrfU3O7g2yxZwX5Zo0PnNPhWK5zv3uDlEccyC9QOE5ZdmInETUG
         fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544305; x=1740149105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAfs/2wWZw1nrswKtLLAZKfz4qKwgA4SGanKMqohMA0=;
        b=eTfweXGmIY2FKaXObZiPqD+ocJwQk2iiLkq0PA+dcEu7ByVwEFHMwhhL+4ZD3j8hE8
         56JiD2aF5EkMvFG+VNFlqD0S6/PK/fuFGLXXenfNV/7BbykYzdbvYOZ9jnfDT8xd6oAT
         ZhAyrpWAIupeGhDpsUA6L+Mvu67qoWNALS9k0rruBRO4Z+/2js0YedHMXztwGX6ma+49
         Acnvm/PsFZeEFf0xZ4KwrvkjIvqRZ32vlqB51IcyOWgDMNC130BVwSff3FMtICUJovDV
         VFKvMZ+iY7dMHXqs5pa66RAU445VHGKnUCOS7NKDlcwXL0svgka6veeOyle7XvPcvuLG
         n8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWkxoSoQnI7FxaE7PN4JG+JDsCZ1eleQnPDdnynkcP8KvsmZ/mHZ+AM8khNssbqJtXtePaFok58/s2UXuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aHQekVgh5Pgv4kHqSQZSvNwFndA8yvY2yyhEbNrn20Yyamx5
	+S/favtSFy30It/rVXOrqbtS1nv9xYvrbSrRvVhK+ef4TABGa8aKB9lrC+WRTcuOa67rG/d35/y
	cIYIa863cwakk3+XyOrmHLU7syo2uMSbNVOMJk53Pf0IA3ZUvFg==
X-Gm-Gg: ASbGnctvcuVHZE898h8I7m6/LjNFy8cD73ebS2k4OHqkGK7+Kk5p5imp51S8om57puX
	mEkJwa4cWGJWQvC13E4/lQUWOWKxz3wWf+NrpLwNRg1B5eIVz3UjCph+RZLJeKb80wUv1GA2FDE
	Z47vML9/2GJGxTXdJdt8oni6tWc9Y=
X-Google-Smtp-Source: AGHT+IG8aNYb7u/GE0f9qm35hzg+RW6Ht1Y2jf5CbOp+ChSTkRZk1MIS83VFp4Lte6OUyFlcjOMzu6K6u6cofPWNcJ8=
X-Received: by 2002:a17:90b:5687:b0:2ea:77d9:6345 with SMTP id
 98e67ed59e1d1-2fbf5c5ec93mr15482217a91.22.1739544304873; Fri, 14 Feb 2025
 06:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250213200228.1993588-5-longman@redhat.com>
 <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com> <3d069c26-4971-415a-9751-a28d207feb43@redhat.com>
In-Reply-To: <3d069c26-4971-415a-9751-a28d207feb43@redhat.com>
From: Marco Elver <elver@google.com>
Date: Fri, 14 Feb 2025 15:44:26 +0100
X-Gm-Features: AWEUYZkjFehohssArY_udscwBKWHL2QvdhXQ1Ql8mqX56GdhkL6wCNSxpM9NVHY
Message-ID: <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 15:09, Waiman Long <llong@redhat.com> wrote:
>
> On 2/14/25 5:44 AM, Marco Elver wrote:
> > On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
> >> KASAN instrumentation of lockdep has been disabled as we don't need
> >> KASAN to check the validity of lockdep internal data structures and
> >> incur unnecessary performance overhead. However, the lockdep_map pointer
> >> passed in externally may not be valid (e.g. use-after-free) and we run
> >> the risk of using garbage data resulting in false lockdep reports. Add
> >> kasan_check_byte() call in lock_acquire() for non kernel core data
> >> object to catch invalid lockdep_map and abort lockdep processing if
> >> input data isn't valid.
> >>
> >> Suggested-by: Marco Elver <elver@google.com>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > but double-check if the below can be simplified.
> >
> >> ---
> >>   kernel/locking/lock_events_list.h |  1 +
> >>   kernel/locking/lockdep.c          | 14 ++++++++++++++
> >>   2 files changed, 15 insertions(+)
> >>
> >> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> >> index 9ef9850aeebe..bed59b2195c7 100644
> >> --- a/kernel/locking/lock_events_list.h
> >> +++ b/kernel/locking/lock_events_list.h
> >> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
> >>   LOCK_EVENT(lockdep_acquire)
> >>   LOCK_EVENT(lockdep_lock)
> >>   LOCK_EVENT(lockdep_nocheck)
> >> +LOCK_EVENT(lockdep_kasan_fail)
> >> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> >> index 8436f017c74d..98dd0455d4be 100644
> >> --- a/kernel/locking/lockdep.c
> >> +++ b/kernel/locking/lockdep.c
> >> @@ -57,6 +57,7 @@
> >>   #include <linux/lockdep.h>
> >>   #include <linux/context_tracking.h>
> >>   #include <linux/console.h>
> >> +#include <linux/kasan.h>
> >>
> >>   #include <asm/sections.h>
> >>
> >> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >>          if (!debug_locks)
> >>                  return;
> >>
> >> +       /*
> >> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
> >> +        * the first lockdep call when a task tries to acquire a lock, add
> >> +        * kasan_check_byte() here to check for use-after-free of non kernel
> >> +        * core lockdep_map data to avoid referencing garbage data.
> >> +        */
> >> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
> > This is not needed - kasan_check_byte() will always return true if
> > KASAN is disabled or not compiled in.
> I added this check because of the is_kernel_core_data() call.
> >
> >> +                    !is_kernel_core_data((unsigned long)lock) &&
> > Why use !is_kernel_core_data()? Is it to improve performance?
>
> Not exactly. In my testing, just using kasan_check_byte() doesn't quite
> work out. It seems to return false positive in some cases causing
> lockdep splat. I didn't look into exactly why this happens and I added
> the is_kernel_core_data() call to work around that.

Globals should have their shadow memory unpoisoned by default, so
that's definitely odd.

Out of curiosity, do you have such a false positive splat? Wondering
which data it's accessing. Maybe that'll tell us more about what's
wrong.

