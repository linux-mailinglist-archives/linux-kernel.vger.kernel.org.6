Return-Path: <linux-kernel+bounces-512163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B10A334F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89F51673DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3918635E;
	Thu, 13 Feb 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tia9btoE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532531372
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411354; cv=none; b=ss8TUHCMEolUGL3/bAcpbtC5j7ieUMwmIJfNlmyhWjppYJCxtD1+w+LCnEysM+kgiSlyMG361NtkmseFJJ+i/znC0CketB78oEjCcJESNZQVV2Fj0VGE+pN95Djj5kyKcbuFxxk0Oy90C6R32pry7Y9YRSaf1CLP7MRY663AspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411354; c=relaxed/simple;
	bh=juPaH15AHN+x7sI2jVZWJMtV7lT9zU/prxKVp2l874k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp65WHTSvT6jww5zsRbqISWC/suPHBxHL2pbRD6Bu6GqjwGUUU0lPy8qgBnrpqt9SR4WzEGW/q3KROD2aF1Y1kbWv88nxfM7EZwzUKHNBZFvTbJRHmWt1QhS1KJcLThaFX/c1u3vdas/cJCzpI98xeAdALA+g90FPekrfbBQC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tia9btoE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43957634473so3741685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739411350; x=1740016150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wY4wXs5+HLRneqjqUBolpxhGqLVUYvpAwoIF6j/MLQ=;
        b=Tia9btoEinjJc2WehEsldrAEaPgdFsJ4bbxn55mdyNFH/TMQpLDgIQRv6B9tfaq67I
         0lHhcGA1gltDgM/QZ+i+0WZ5ryv2ybpa90dS+mRlJ0Q+A9LfNc7QB5oQebsRNXxnf5Gt
         qirEUKLZt3931zJO9qdQxY5kuOsq0oxxt1ey/vQFT2ZcFoAvCA3iexUHxtthh2S8/wR8
         VAprKa1h0mkwbMjhO1xJygqMlv7wAb+4ifG2urKzuBJfGOSKAnE22QxjGuD7Pu++FxSU
         gYzt4+wNDfqXs1rdI5ArAUUiRqSZbTt5a2FCFUrcSfw2804QTvDG1Ss5bBc2nCq7CY/f
         waEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739411350; x=1740016150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wY4wXs5+HLRneqjqUBolpxhGqLVUYvpAwoIF6j/MLQ=;
        b=tn0xZc2czDZx8oEluRKuLeYq3kWEVinh9f+cEJQ01uaSYs8cQBj2badz56lSVIG4GC
         wCiMpCW2AWaamnzrBr1U4uk06y8pIjsHWx5jMXQ0/3NmEns9a4xSF9DTDlv9gnyOQ7Cy
         1t8s1klJ48hoNYO03iLis1sR5vQHZp0j/kXGVUc1jEVwZqJvNYO+MZAJjyXyJTVyVVe0
         Ijgawi2LP4d1FUTFMzIHSoKpVWN68AOme2alb9VPHB+Kuuw2/rIp67UTT9AQnYXXnXy0
         U69ra8qKVIPMN9BCgEREU9OHnM73kSSbSlM4WUGn3wKUtYQofG80fblXIo2eG3ve98+J
         1d5A==
X-Forwarded-Encrypted: i=1; AJvYcCUbU4f4pHAvC1NjgYvENGOQqn5yDt9oG56cJbv42B1xWZbLzxb6vEMFN5w0Sf6yMdFsVxduWaFOIbZkAcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxiz/u5MMg7jXyiWuMR5PJgWtUes3b9pa2W8pG2KFWYdIXNSoZ
	STvBULD5g2lNUNVDjvLG3nCRdmsdBRdmA9HRQBSdwvb6eqnRGjqH6/bKzZL6DodYzPaUcT8mmMT
	g8u6x8Afw3ba4jBGVWXzWm7jL9ks=
X-Gm-Gg: ASbGncvDb1VwwrXpJXACaI3Md7m0DCVi4YnDGxxSS9ripnUv8PUDKbDfN3JwB8McPgJ
	SATUdRCv7VjvKgXz05eR2vGAuuCDgNkyQ2B9io3thHVK7jIfgonvpB7ULrGiH5u8Sh3+qO+vmUf
	o=
X-Google-Smtp-Source: AGHT+IGsexwhGjEvQnmXxS/PprXAz9+JEzr7OrPin2TezEcpsjL4WY4sUa5E3qCz5q59GrohfZFhC8yZjHvgGdZoZ1o=
X-Received: by 2002:a05:600c:1d9b:b0:439:60ef:ce94 with SMTP id
 5b1f17b1804b1-43960efd0ffmr6349015e9.21.1739411350285; Wed, 12 Feb 2025
 17:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212162151.1599059-1-longman@redhat.com>
In-Reply-To: <20250212162151.1599059-1-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 13 Feb 2025 02:48:59 +0100
X-Gm-Features: AWEUYZlva8wcqIGZAMNqHBqIKxnv5SeuKq11Lnse6U1bm1Vg8g3HRUGtElXJDM4
Message-ID: <CA+fCnZdbW1Y8gsMhMtKxYZz3W6+CeovOVsi+DZbWsFTE2VNPbA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 5:22=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> The following bug report appeared with a test run in a RT debug kernel.
>
> [ 3359.353842] BUG: sleeping function called from invalid context at kern=
el/locking/spinlock_rt.c:48
> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140=
605, name: kunit_try_catch
> [ 3359.353853] preempt_count: 1, expected: 0
>   :
> [ 3359.353933] Call trace:
>   :
> [ 3359.353955]  rt_spin_lock+0x70/0x140
> [ 3359.353959]  find_vmap_area+0x84/0x168
> [ 3359.353963]  find_vm_area+0x1c/0x50
> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
> [ 3359.353972]  print_report+0x108/0x1f8
> [ 3359.353976]  kasan_report+0x90/0xc8
> [ 3359.353980]  __asan_load1+0x60/0x70
>
> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
> The print_address_description() function is called with report_lock
> acquired and interrupt disabled.  However, the find_vm_area() function
> still needs to acquire a spinlock_t which becomes a sleeping lock in
> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
> changing report_lock to a raw_spinlock_t is not enough to completely
> solve this RT kernel problem.
>
> Fix this bug report by skipping the find_vm_area() call in this case
> and just print out the address as is.
>
> For !RT kernel, follow the example set in commit 0cce06ba859a
> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
> inside raw_spinlock_t warning.

Would it be possible to get lockdep to allow taking spinlock_t inside
raw_spinlock_t instead of annotating the callers for the !RT case? Or
is this a rare thing for this to be allowed on !RT?

>
> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/kasan/report.c | 47 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
>  [v2] Encapsulate the change into a new
>       kasan_print_vmalloc_info_ret_page() helper
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..9580ac3f3203 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -370,6 +370,38 @@ static inline bool init_task_stack_addr(const void *=
addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> +/*
> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kerne=
l,
> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
> + * to WAIT_SLEEP.
> + *
> + * Return: page pointer or NULL
> + */
> +static inline struct page *kasan_print_vmalloc_info_ret_page(void *addr)

No need for the kasan_ prefix: this is a static function. (Also the
_ret_* suffix is something I've never seen before in the kernel
context, but I don't mind it.)

> +{
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEE=
P);
> +               struct page *page =3D NULL;
> +               struct vm_struct *va;
> +
> +               lock_map_acquire_try(&vmalloc_map);
> +               va =3D find_vm_area(addr);
> +               if (va) {
> +                       pr_err("The buggy address belongs to the virtual =
mapping at\n"
> +                              " [%px, %px) created by:\n"
> +                              " %pS\n",
> +                              va->addr, va->addr + va->size, va->caller)=
;
> +                       pr_err("\n");
> +
> +                       page =3D vmalloc_to_page(addr);
> +               }
> +               lock_map_release(&vmalloc_map);
> +               return page;
> +       }
> +       pr_err("The buggy address %px belongs to a vmalloc virtual mappin=
g\n", addr);
> +       return NULL;
> +}
> +
>  static void print_address_description(void *addr, u8 tag,
>                                       struct kasan_report_info *info)
>  {
> @@ -398,19 +430,8 @@ static void print_address_description(void *addr, u8=
 tag,
>                 pr_err("\n");
>         }
>
> -       if (is_vmalloc_addr(addr)) {
> -               struct vm_struct *va =3D find_vm_area(addr);
> -
> -               if (va) {
> -                       pr_err("The buggy address belongs to the virtual =
mapping at\n"
> -                              " [%px, %px) created by:\n"
> -                              " %pS\n",
> -                              va->addr, va->addr + va->size, va->caller)=
;
> -                       pr_err("\n");
> -
> -                       page =3D vmalloc_to_page(addr);
> -               }
> -       }
> +       if (is_vmalloc_addr(addr))
> +               page =3D kasan_print_vmalloc_info_ret_page(addr);
>
>         if (page) {
>                 pr_err("The buggy address belongs to the physical page:\n=
");
> --
> 2.48.1
>

