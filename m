Return-Path: <linux-kernel+bounces-515337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F303A3635B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A973F3ADEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257A2676E8;
	Fri, 14 Feb 2025 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLaNPYTz"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AB8635A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551455; cv=none; b=h/xzukmB/nz8ANaqpukGHkPB3YjWUIi75cCuDT23buHQ8125V6JoTB0YjeJZ6zIXwJ9vF3WUZFelE6b0hUeXMZeQGwZUZOvy58XYCf6nU703xtp8OMHc9jErxanGbyMu/Hz8W0DH4tYb5xDZJ8ySPm+l+aweOZMtR1wlhTH6xGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551455; c=relaxed/simple;
	bh=VDFiejMUnw/DtOjJtb3Srtkq8VX8gIjaGAC8zqYWng0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGTC91Y4kL4Lr2LUuE+mnhPps3z5V/55kzh5JmMA3qFun6dixg0DtE3C3Y198HwEt6zWLImHnDMd2aziPn3HEfMj9rVUmn2rbj3hL0ziJqPT40diC2UbYyoaui+hMsLqML5dhsI5r8sVIka9lynHguugiAO/pAVDCLpJORHYa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLaNPYTz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f44353649aso3417823a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739551453; x=1740156253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oO9d0oAKrGz4vkv7SRxKDd5I1l3i0mTcuTEqRSmTOSM=;
        b=pLaNPYTzge/WNCp3thHJJJRKspyJTPC+PNNPZMPk4pbmsT8i2nbc/dt5cSb7VRfpFB
         FtS0+oImtnfFy4CCCMI8Qwi7XhTZXkVv0fh6dcHHU2GUfYMUhGt0EZzI/pgphCaTEy1Y
         12LcbeJyE94RFI1j9DSZOqv0FyFlFiyNqF3pY2vyKwrsyzP9ImU2veDB3GdXwuQM8rTF
         o+B+Xvox3i92zbV6QZPbBH45zqAPpOUwnwMks8Qy/UqL8HPBA+PZaukVTTn6zrQNfqpH
         iavJG9hQTRIwpTZCcr5eRF+RUZSdia3elgANuSzGkbHaV+7X45miwCFUjtM/PqGnFNXn
         dZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551453; x=1740156253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oO9d0oAKrGz4vkv7SRxKDd5I1l3i0mTcuTEqRSmTOSM=;
        b=vu2LzAJBk1KxagYPONG6HfOF9ciYUtfKm1/EvJSL0h/QnKkRkclq+vswBwSBNpD4C7
         D+hd/Sa1zmgPQa/JaWzVcMnk1VN952mpfIeoYlHSz1UMq+SxaM7VvNiMaX85Q20wZkXm
         6uDRyqFtq+NwwjNHJxHjJhG2bTOaZzyASDKlniTqxkPcRu2UIFed5gyFMrvlHTi6FXOL
         TRVA5UTgq8UNcX9Kwu+fwH4MU44g13AfVMoIKEK/XEdA2AkpnYI6pVIq4bOXmUsJYQ5c
         wVEx/n0b5I82xrgeFrYYt0TJFl8wInmQ7TbroR5g3cHlG2dhYjZP8vLU1hvsfupHI2aQ
         VifQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC7HOGvXNI7BpGeNd/0pOooVufQwpCodG1/cM46hSyHkfSA60OC3xp221fuQrgyn6R7vy2P4zMQsqewZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAbcHRqTEIF2UWoPZqyVy38fkZrG37AhoEIZHZM2aAtDJyVqS
	a3V+EaQNnd0Qh5BsEOg92cTCDOFuUgQ6eYWTjN0zhwKhqSl9c5/VXiVOCyMtdNdgkVXPHA5AeAY
	dQtkczpEaytXOx5Kn9bfxWGbkq4/OVBSMR7D/
X-Gm-Gg: ASbGnctq4KMtlB6Ud3UIpCftEKAqfuNwbi0FCqnWcGiwpVlUKSdTwijUyiwZ69PvDXn
	1lMI3HM+xy9ZclN/D2uFKlO9MSqCqA5sENgp3jxuPAJhuxFd/YXTKSDWpz6IbdpEiqvlgu9ZG3G
	BFqVE7QQGARLS02WuKv3SZfHfogfsX
X-Google-Smtp-Source: AGHT+IHsxXgR7VSiG7/7i3Y5aqSfDn5igt/FPuXvtlbRSQZKc/y9AhuaB5Koc9EAhdG+mw8ENuEbMJV5EK3MSwztfWU=
X-Received: by 2002:a17:90b:23cf:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2fbf8f32e01mr20276708a91.12.1739551452914; Fri, 14 Feb 2025
 08:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250213200228.1993588-5-longman@redhat.com>
 <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
 <3d069c26-4971-415a-9751-a28d207feb43@redhat.com> <CANpmjNNLn9=UA+cai=rL+6zsEQyppf6-4_YL4GAFi+dLt+4oSA@mail.gmail.com>
 <f2f006e8-3987-4aa2-b4f5-114b4e869e86@redhat.com>
In-Reply-To: <f2f006e8-3987-4aa2-b4f5-114b4e869e86@redhat.com>
From: Marco Elver <elver@google.com>
Date: Fri, 14 Feb 2025 17:43:36 +0100
X-Gm-Features: AWEUYZlhsid88jbBXlrCRzO_gVgGmSd_N7t21Ty9NLxBg4_xXnC-cahHoi81xvE
Message-ID: <CANpmjNPYFjv4TTCG+t0zyr2efCtjPKV7zQQu-ccsgX5XtGtDLg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 17:18, Waiman Long <llong@redhat.com> wrote:
>
> On 2/14/25 9:44 AM, Marco Elver wrote:
> > On Fri, 14 Feb 2025 at 15:09, Waiman Long <llong@redhat.com> wrote:
> >> On 2/14/25 5:44 AM, Marco Elver wrote:
> >>> On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
> >>>> KASAN instrumentation of lockdep has been disabled as we don't need
> >>>> KASAN to check the validity of lockdep internal data structures and
> >>>> incur unnecessary performance overhead. However, the lockdep_map pointer
> >>>> passed in externally may not be valid (e.g. use-after-free) and we run
> >>>> the risk of using garbage data resulting in false lockdep reports. Add
> >>>> kasan_check_byte() call in lock_acquire() for non kernel core data
> >>>> object to catch invalid lockdep_map and abort lockdep processing if
> >>>> input data isn't valid.
> >>>>
> >>>> Suggested-by: Marco Elver <elver@google.com>
> >>>> Signed-off-by: Waiman Long <longman@redhat.com>
> >>> Reviewed-by: Marco Elver <elver@google.com>
> >>>
> >>> but double-check if the below can be simplified.
> >>>
> >>>> ---
> >>>>    kernel/locking/lock_events_list.h |  1 +
> >>>>    kernel/locking/lockdep.c          | 14 ++++++++++++++
> >>>>    2 files changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> >>>> index 9ef9850aeebe..bed59b2195c7 100644
> >>>> --- a/kernel/locking/lock_events_list.h
> >>>> +++ b/kernel/locking/lock_events_list.h
> >>>> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
> >>>>    LOCK_EVENT(lockdep_acquire)
> >>>>    LOCK_EVENT(lockdep_lock)
> >>>>    LOCK_EVENT(lockdep_nocheck)
> >>>> +LOCK_EVENT(lockdep_kasan_fail)
> >>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> >>>> index 8436f017c74d..98dd0455d4be 100644
> >>>> --- a/kernel/locking/lockdep.c
> >>>> +++ b/kernel/locking/lockdep.c
> >>>> @@ -57,6 +57,7 @@
> >>>>    #include <linux/lockdep.h>
> >>>>    #include <linux/context_tracking.h>
> >>>>    #include <linux/console.h>
> >>>> +#include <linux/kasan.h>
> >>>>
> >>>>    #include <asm/sections.h>
> >>>>
> >>>> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >>>>           if (!debug_locks)
> >>>>                   return;
> >>>>
> >>>> +       /*
> >>>> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
> >>>> +        * the first lockdep call when a task tries to acquire a lock, add
> >>>> +        * kasan_check_byte() here to check for use-after-free of non kernel
> >>>> +        * core lockdep_map data to avoid referencing garbage data.
> >>>> +        */
> >>>> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
> >>> This is not needed - kasan_check_byte() will always return true if
> >>> KASAN is disabled or not compiled in.
> >> I added this check because of the is_kernel_core_data() call.
> >>>> +                    !is_kernel_core_data((unsigned long)lock) &&
> >>> Why use !is_kernel_core_data()? Is it to improve performance?
> >> Not exactly. In my testing, just using kasan_check_byte() doesn't quite
> >> work out. It seems to return false positive in some cases causing
> >> lockdep splat. I didn't look into exactly why this happens and I added
> >> the is_kernel_core_data() call to work around that.
> > Globals should have their shadow memory unpoisoned by default, so
> > that's definitely odd.
> >
> > Out of curiosity, do you have such a false positive splat? Wondering
> > which data it's accessing. Maybe that'll tell us more about what's
> > wrong.
>
> The kasan_check_byte() failure happens very early in the boot cycle.
> There is no KASAN report, but the API returns false. I inserted a
> WARN_ON(1) to dump out the stack.

I see - I suspect this is before ctors had a chance to run, which is
the way globals are registered with KASAN.

I think it'd be fair to just remove the lockdep_kasan_fail event,
given KASAN would produce its own report on a real error anyway.

I.e. just do the kasan_check_byte(), and don't bail even if it returns
false. The KASAN report would appear before everything else (incl. a
bad lockdep report due to possible corrupted memory) and I think
that's all we need to be able to debug a real bug.

