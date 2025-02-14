Return-Path: <linux-kernel+bounces-514794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12723A35BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C512C169BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE08260A4F;
	Fri, 14 Feb 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4tr1Eiq"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB025A629
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529903; cv=none; b=FcbgGOQ34TjWsW3jXyhF+EqfMF6nxBlJRiWFSOzAImksiLSpF94loybdgmTmBRSTcIy+U+R4L3gt1C4HHuB1Swpwk2EUGlUarYaEW7OkPlsLwVxez5mXt/qcSa+MnU7gnLDjdSQss/OxKSWYf33DM7A2VDYQsaSZgqpemgW4Iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529903; c=relaxed/simple;
	bh=iWCon8JfnUFKyrGOoz6QWiN80UhdNnCbJjS0ySkBhdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXZWnW5j/9tz7RTodn1lDom654ZSpxrYCAnz+JrNIBTtX2hGUPPSGgFaVmtHANmUuRyXqT0ouOzuDiD0Z4uYOm4cpO2E3MJ/0EPw4YuAgNcC8dZ+BQOZLYjDQO90Ap9Tk7Qq5sEq3YKjzcJsaYA7y5cza6vkiMP0oxKFoRuLcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4tr1Eiq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f7f1e1194so47200735ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739529901; x=1740134701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1nKggMID3OWjzPJGLlNPI+kvpL/CDhruykGzB2fMEo=;
        b=z4tr1EiqcunHYB2UUsMx+o+uyQtmM/8c+7cLMg38fWiOPflRUTzFTbQrV3Zz1areed
         VKvcW5vH1KPCIifAZM9r9Kd4/pyK/Jz/jhzHjRYly/DAzQ2ayW6qTbLBsHMK+0sExkcv
         mVLR4jR3c2YdgNsMIUwG7/pQR/jtBEJBhpw5qsck1zaYDtdOa2efazKsdm8iHBCPU/K4
         FhTCQ0IgKMh0ltJcqFN+ORrbp5sSqJwLwghDn52wcOHIr/S1gXEPlKm09Y9gVm9Z/SCH
         kHaCZumwu22/FhxWEuF9tD+d/dQ8DbjQ5qAAsQWL5ffse6Q3akmhjXKD5wynlT06nkGl
         95+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529901; x=1740134701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1nKggMID3OWjzPJGLlNPI+kvpL/CDhruykGzB2fMEo=;
        b=TO2TkLmCNmFKqCFCQeqQ2nWw5qBY1uUB2bEWv+KoHn/Xqx2thosB86Tn94O2P9/PY9
         N6jkJP/w390yD7gitshEZtdGjYoggKIw7MvDp+l5NV/JSEhX6bpJUibyH+z9eMXrjJ28
         NnyJ2hEr13RqIYlX1p1YRmShpRPHdNoAKy8S8k/vUSWba4vcjks9Z97ReuX87CfAKyxj
         d05P+QeyPr7rof5E1afWMZ+U7rgtNOlj6dEoLFXExVTRaiW05HHpbiUhGxOQK0TvPZky
         g0WqBA9d0WKCp9g6srJ4yexEAbjXMNIc5MDEi0XjLL8FRYP1AgtyNp3NY+Jh4HOFQ6qZ
         c4qg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Tfg4h/ykK5EIlmSXbrv/5iQ/D2vURKWt0UuUyNWClaz+jCS1qpu4/iCxs9zXaOa7ZBk75zA4dCdRFs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oME1kcrBGA3ThyLOkglVCZjY8AkCqb9gb1f6MzrYgBbxNukT
	1N2bDoFY7VY1oso+2e1C7dwDVVpH1d3AwLGFBv4E5nt/LPeOxbpYDBQP7/S4RvEvNNV9STGY6nC
	eTjsnHMwoUyonWfdVVqtIywZmTYoi2MbIjZrG
X-Gm-Gg: ASbGnctDmc1qF5XSjqNiWLHbym3vNPkjqkjnS+22KTFYPX9nyg3McVqnTsjKOdqhpyj
	lLtQpJ3DQQvvg1REt8CszEkTgc8bQeaUYdUTdj+x1u5nOmXpOrpD7LXuMsfG3ZP5oHVkZAniaYk
	HKutE/JCw2cR1gJJeoeqjXXKe6gIo=
X-Google-Smtp-Source: AGHT+IEsKu8y1Zb7bj7+r+uXKgPS4XznM9K9GuEOQJRwN4MDVYFthLeQOzyZ39+h9HKjeUnmmdlAuD1gDUC+dqhD6rw=
X-Received: by 2002:a17:902:c408:b0:220:bc9e:fd6 with SMTP id
 d9443c01a7336-220bc9e1783mr191326545ad.44.1739529901147; Fri, 14 Feb 2025
 02:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250213200228.1993588-5-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-5-longman@redhat.com>
From: Marco Elver <elver@google.com>
Date: Fri, 14 Feb 2025 11:44:24 +0100
X-Gm-Features: AWEUYZnWkxs8s2ZOaEuYd1RbG1DcAdDz7Uvyq0UrqfOFj1CPk6H-b44AgJXOrfQ
Message-ID: <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>
> KASAN instrumentation of lockdep has been disabled as we don't need
> KASAN to check the validity of lockdep internal data structures and
> incur unnecessary performance overhead. However, the lockdep_map pointer
> passed in externally may not be valid (e.g. use-after-free) and we run
> the risk of using garbage data resulting in false lockdep reports. Add
> kasan_check_byte() call in lock_acquire() for non kernel core data
> object to catch invalid lockdep_map and abort lockdep processing if
> input data isn't valid.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

but double-check if the below can be simplified.

> ---
>  kernel/locking/lock_events_list.h |  1 +
>  kernel/locking/lockdep.c          | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 9ef9850aeebe..bed59b2195c7 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
>  LOCK_EVENT(lockdep_acquire)
>  LOCK_EVENT(lockdep_lock)
>  LOCK_EVENT(lockdep_nocheck)
> +LOCK_EVENT(lockdep_kasan_fail)
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8436f017c74d..98dd0455d4be 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -57,6 +57,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/context_tracking.h>
>  #include <linux/console.h>
> +#include <linux/kasan.h>
>
>  #include <asm/sections.h>
>
> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>         if (!debug_locks)
>                 return;
>
> +       /*
> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
> +        * the first lockdep call when a task tries to acquire a lock, add
> +        * kasan_check_byte() here to check for use-after-free of non kernel
> +        * core lockdep_map data to avoid referencing garbage data.
> +        */
> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&

This is not needed - kasan_check_byte() will always return true if
KASAN is disabled or not compiled in.

> +                    !is_kernel_core_data((unsigned long)lock) &&

Why use !is_kernel_core_data()? Is it to improve performance?

> +                    !kasan_check_byte(lock))) {
> +               lockevent_inc(lockdep_kasan_fail);
> +               return;
> +       }
> +
>         if (unlikely(!lockdep_enabled())) {
>                 /* XXX allow trylock from NMI ?!? */
>                 if (lockdep_nmi() && !trylock) {
> --
> 2.48.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250213200228.1993588-5-longman%40redhat.com.

