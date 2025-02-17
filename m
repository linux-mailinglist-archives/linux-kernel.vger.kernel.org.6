Return-Path: <linux-kernel+bounces-517076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D67A37BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B2F188D5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD81917D7;
	Mon, 17 Feb 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Iu5lZhp"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E318801A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775628; cv=none; b=MUc9rjla53AGRCTjZfxpSuGyjTPwlauDx83+lnkBZM5DESvuJ0s4BidHE9kY6isWoQQVjwDFlKW+D/N5guVM3QumEs8oAUQToqrUPI16XUouvBFZgW0TcmvL6d3+zPuAjmNeP+Q+ML6wDNZ0ttCnRaFGUSMnQ1UQrC8yhzIyEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775628; c=relaxed/simple;
	bh=5ku9a0cNd6n1jVDY2opaLBcc6omI+m94Vuf0uuS+FK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SV34/lptf6frRFOwaHe/cvtJVFunyrU9WryakXA+Ac36mJcDwBjctZdwn54IaBhTYHBn00TYr2lAWqw+i6laave6L0DvulbjfUjM9d4/KvJ5Y2oHtv0thtrVcslJnIX06rAT4ODB9264QSNBjv7L6q6vL+SyEeEHAHsL1t9FqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Iu5lZhp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc3a14f6fbso2822812a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739775626; x=1740380426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/kidt/+m/QUXKGxp/hFK00u7EvOABsDl7T7sblEpXY=;
        b=0Iu5lZhp3oLwNXOWDpAh9qG4reljezTP6+Ugp0Y21NRZP6kaEI8hRR6UwB5R5eA3tM
         RbLeJBI4Wa591x0TXv9oCRRjd62tRnkuqsmJaQn7+2ylVVuNWoQGoXwMWGCQbaKZM8cq
         ti88dvtvqp3gBbVxe2BnPVlDUAAUZJGq3V9zDBlz8oFy38CxpQdOZoxpGpvki8XmPc4G
         PAEE7RFe0UM5KI31Uejma7+r1I1IRrNEqOzYhIE5xkMrT6TzCcKjE0T44A0qwTJH4LUg
         bEOy1O+qmuhDvFuY/MZdi2ZY7t9W22pulxloias2jGcf0xG+FTahRQo4HMZckhdN6mHm
         mA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775626; x=1740380426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/kidt/+m/QUXKGxp/hFK00u7EvOABsDl7T7sblEpXY=;
        b=eXNlUchPQ0howGywM8B3jXgMAVX84I5bdOvfpLrXhanRdm5emecoxXRWeaNV48dvk7
         3H+u99+oqz3uVyJHQu9YobrRsg2i/o1+Qhc7yEGwsdJ1lyroPbwPe/M05t/7RFJDoQHA
         e37MuyaJQQTvEmLIkT4xth66HfOh40BJKXy7zGssXRz6R7hZAv6ztGo/dD9PpAijaSDi
         9s66qO+LISar4x9h8kidpQuOB0PEy4pBwGKzf89WN4jivT3oqKCuSOdXfkCTZab3PML4
         tHrU77WdIC2+pEZhDNMJJTZajvqJwL2V9mb/GIXXi6w8fcHJYMVG69+dZhh9fi3TMztE
         PUug==
X-Forwarded-Encrypted: i=1; AJvYcCUySUenCwaW4vMctBGRrOF69J/gw2TF1IEkbtGDL+63kjkCJ2MI6bfRDmbmutvK97MHwaO1ydwWjJ3RyI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHHPyCQyQF473g1t5yuqmR5A+Lz9VThpF2SVdxjm0e2Wl35zJ
	8mRTkzBiJlG6EldO7kv/3FTKe9KU6aLEeygIEc4Od45o4oWL0jhb4ukMqN8WvG7trJg0xUqAvrd
	KgAFGOaCweoJsKv+JDwZAFXsMcg70kXDildnm
X-Gm-Gg: ASbGncsrPUm2PzLy2jTcGBu48lwSwQ+7v7gFfOeOn6F26buU/eXDQHBMNswkaIqti1/
	CrqS24SOVKNSkM735bwhQdsf+5vThlvj9tCLfngvoDBeO3ePlboEKZ7tGInMBcbvQvyTQM9Jl50
	3ZAA1FyU6i9mNmnZwnlNdogkhl5DId
X-Google-Smtp-Source: AGHT+IHD12v4dEhaZ62sRSteKflMrr3lpwkcPBcQw2wsLcwG7ZT2n4vyQUXQL25K8qzbpy/wSsxQInpfI87dALr0jmY=
X-Received: by 2002:a17:90a:ec8d:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-2fc41153decmr12093928a91.30.1739775625488; Sun, 16 Feb 2025
 23:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250214195242.2480920-1-longman@redhat.com>
In-Reply-To: <20250214195242.2480920-1-longman@redhat.com>
From: Marco Elver <elver@google.com>
Date: Mon, 17 Feb 2025 08:00:00 +0100
X-Gm-Features: AWEUYZkyCYAFeX-s3finstA3GzhMKKZ63CjP0dxLIlHJtFCqcCRgDj5s5rXnCbc
Message-ID: <CANpmjNOMnSXGBUWyycUziKcxcN=Vb5_qvyrrATHZoKgVacpAgQ@mail.gmail.com>
Subject: Re: [PATCH v4.1 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 20:53, Waiman Long <longman@redhat.com> wrote:
>
> KASAN instrumentation of lockdep has been disabled as we don't need
> KASAN to check the validity of lockdep internal data structures and
> incur unnecessary performance overhead. However, the lockdep_map pointer
> passed in externally may not be valid (e.g. use-after-free) and we run
> the risk of using garbage data resulting in false lockdep reports.
>
> Add kasan_check_byte() call in lock_acquire() for non kernel core data
> object to catch invalid lockdep_map and print out a KASAN report before
> any lockdep splat, if any.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/locking/lockdep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8436f017c74d..b15757e63626 100644
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
> @@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>         if (!debug_locks)
>                 return;
>
> +       /*
> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
> +        * the first lockdep call when a task tries to acquire a lock, add
> +        * kasan_check_byte() here to check for use-after-free and other
> +        * memory errors.
> +        */
> +       kasan_check_byte(lock);
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
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250214195242.2480920-1-longman%40redhat.com.

