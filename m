Return-Path: <linux-kernel+bounces-256926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7E93729F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19C31C20F75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69785F9F8;
	Fri, 19 Jul 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="b1i22ThB"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFAC147
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357757; cv=none; b=bdxE5C2s9lY1ZRzqKdKQmRe7TM9oB7V8wXnom72gxsiu8MX+9w9LiZBtDMSZI+pKDX7G/QxQQb5+EPyE1WCb367X5YSa4BEJAUTCDojPtfGy9ouegPTH8Dk5Cn1laaawwrMC5zEI1imqxZlmV6DI6MH20cyP/d1rlX51uAxlX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357757; c=relaxed/simple;
	bh=376oq4s/RAHN/ui1eV8N1i/hUAVngv9Xukgp7ciOSJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2uXgc+Ro3e7o0t3+b/1sx8Kh4dYutEImxrfcFbx2vL0Vg7QLOFrH7ZLKMfq5cWrBa6DV1+vWuv20ARf8nFJevzvdRl4FZ3ByU2eBgweuLDa2uuc4jxjmBsdSp9HIP86O1RXVsbaLCW5HOPI/RXBnbydSOFiH8Cd708Xjivb4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=b1i22ThB; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48fde3a2b17so423807137.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721357754; x=1721962554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIhpumDPm4fvOwY3jLHPpABCQS7IJTZrwNfks0Zro8o=;
        b=b1i22ThBGFOVq6eIw7vNJM+Fy723sAHA4rYJtUh75fmGxWqQempsJja3secg6Xwgy5
         GNeOQNZV4Ckm4AOWrUPBnOWandujfh5USeb/gDS8VwTd7H/zz5iJUKExUJWqRf/r3DnC
         GXjbpoEY57JxisbOA9gVXYLQdIiKpANsijzUi86WnqLTkPUXGGVZJYlMaARRQitNwXxg
         q4u45hPkYmBl3CNv0i+wec2qauDpWiq0qcCywqkMqegcDM5ndvhfSXuubGrZKoRmVEVt
         jfpopKm8n6MmjS48TEa8LFMgEB7dtT5hq8munwswhuoXVF4jLsY9icomT9+z3APrbK+H
         TzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721357754; x=1721962554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIhpumDPm4fvOwY3jLHPpABCQS7IJTZrwNfks0Zro8o=;
        b=JDhtVaMZ8p530R4ZRhBWq9yKb5BnwKi7ALLiZrDw5E5u5bj5lIMGJs57Eiu81pJN0f
         Bx6lMvauJu8AuYYjttNwEZz3KRjMW0lAEqH1DlWL26rNellgFBiBsxLs23Js6YZ4udFK
         NhhIxAn7suMYCMbIKuotd3XbdYiZRzgNWCXCgcb7NyY9IFu2Z9Rdv39lJjicbZgNvlgq
         tZ++SWYVqV8md7Y7px24kAYpXg8EGXH13rGSTwObJLmqbN7jGUNaVFHoYxEVOrseCqbU
         tzaFRPEKXQT2pNibfxpa4Ovz3jN2x/NGubPm4snX2l/79re1d8jzO3dDGOX1lZqU8A0I
         J2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW7r/FFg5Z9D1KoVpQ29fyStMm6Jnzx0kznvXMU1eKl3Qk84Rp95opqXRebV+QGBpCM8yxT3XOZ5xtShgYbnhlC9s2rZvBts2fn8Ogq
X-Gm-Message-State: AOJu0YwuYj/yzzOksF1H0n/A89LTmseDdrFfK2FLhvPjtT2YLoo8RAEG
	+1R+1acHTco+bfQ3D+4HIzhhOyK5Xe6Kbvgky0hucv+GmE6zJa5BM55xPaB4McKKnbclahyO+EJ
	zPLHj72O+WP+La63D28gYlBpMpcTYt5BaII7c1w==
X-Google-Smtp-Source: AGHT+IF9USjnlYvphL36rdSXytfyHnoWlCthQOZzmJ7NTCLIEur/EE/+i/CoA2/MuhlEZSKE5A/DrhXQKIDnwO6Rq+4=
X-Received: by 2002:a05:6102:80a4:b0:48f:df86:db3 with SMTP id
 ada2fe7eead31-491597faba5mr8705048137.3.1721357754635; Thu, 18 Jul 2024
 19:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com> <2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
In-Reply-To: <2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Jul 2024 22:55:17 -0400
Message-ID: <CA+CK2bB4RELLHExbkL444ArTtUnqiYVYKJ1rLQGarLyenY6WxQ@mail.gmail.com>
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Jul 18, 2024 at 08:26:11PM GMT, Pasha Tatashin wrote:
> [...]
> > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/tas=
k_stack.h
> > index ccd72b978e1f..65e8c9fb7f9b 100644
> > --- a/include/linux/sched/task_stack.h
> > +++ b/include/linux/sched/task_stack.h
> > @@ -95,9 +95,51 @@ static inline int object_is_on_stack(const void *obj=
)
> >  extern void thread_stack_cache_init(void);
> >
> >  #ifdef CONFIG_DEBUG_STACK_USAGE
> > +#ifdef CONFIG_VM_EVENT_COUNTERS
> > +#include <linux/vm_event_item.h>
> > +
> > +/* Count the maximum pages reached in kernel stacks */
> > +static inline void kstack_histogram(unsigned long used_stack)
>
> Any specific reason to add this function in header?

For performance reasons to keep it inlined into stack_not_used() which
is also defined as inline function in this header.

>
> > +{
> > +     if (used_stack <=3D 1024)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_1K]);
>
> Why not count_vm_event(KSTACK_1K)? Avoiding header include recursion?

I could not include "linux/vmstat.h" into "linux/sched/task_stack.h"
because it introduces some dependencies such linux/mm.h and
linux/fs.h, uapi/linux/stat.h, and when all of those are added it
still fails to compile on some architectures, so it was just simpler
to stop resolving the conflicts and use this_cpu_inc() directly.

>
> > +#if THREAD_SIZE > 1024
> > +     else if (used_stack <=3D 2048)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_2K]);
> > +#endif
> > +#if THREAD_SIZE > 2048
> > +     else if (used_stack <=3D 4096)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_4K]);
> > +#endif
> > +#if THREAD_SIZE > 4096
> > +     else if (used_stack <=3D 8192)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_8K]);
> > +#endif
> > +#if THREAD_SIZE > 8192
> > +     else if (used_stack <=3D 16384)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_16K]);
> > +#endif
> > +#if THREAD_SIZE > 16384
> > +     else if (used_stack <=3D 32768)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_32K]);
> > +#endif
> > +#if THREAD_SIZE > 32768
> > +     else if (used_stack <=3D 65536)
> > +             this_cpu_inc(vm_event_states.event[KSTACK_64K]);
> > +#endif
> > +#if THREAD_SIZE > 65536
> > +     else
> > +             this_cpu_inc(vm_event_states.event[KSTACK_REST]);
> > +#endif
> > +}
> > +#else /* !CONFIG_VM_EVENT_COUNTERS */
> > +static inline void kstack_histogram(unsigned long used_stack) {}
> > +#endif /* CONFIG_VM_EVENT_COUNTERS */
> > +
> >  static inline unsigned long stack_not_used(struct task_struct *p)
> >  {
> >       unsigned long *n =3D end_of_stack(p);
> > +     unsigned long unused_stack;
> >
> >       do {    /* Skip over canary */
> >  # ifdef CONFIG_STACK_GROWSUP
> > @@ -108,10 +150,13 @@ static inline unsigned long stack_not_used(struct=
 task_struct *p)
> >       } while (!*n);
> >
> >  # ifdef CONFIG_STACK_GROWSUP
> > -     return (unsigned long)end_of_stack(p) - (unsigned long)n;
> > +     unused_stack =3D (unsigned long)end_of_stack(p) - (unsigned long)=
n;
> >  # else
> > -     return (unsigned long)n - (unsigned long)end_of_stack(p);
> > +     unused_stack =3D (unsigned long)n - (unsigned long)end_of_stack(p=
);
> >  # endif
> > +     kstack_histogram(THREAD_SIZE - unused_stack);
> > +
> > +     return unused_stack;
> >  }
> >  #endif
> >  extern void set_task_stack_end_magic(struct task_struct *tsk);
>

