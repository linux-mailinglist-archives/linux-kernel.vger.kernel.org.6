Return-Path: <linux-kernel+bounces-518049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B753A38921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06EE188A1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2A22578F;
	Mon, 17 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaVW6V9t"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1838225769
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809741; cv=none; b=kU+kmI3RJUK7l2OMVIizy/7ZBPvTfBcA55tlCPU6/feB1LIO1XHBdxG607gpcui/yrE8lWZuuIo2XXBz2fb1KpmNHSwal0d7IXkY05nrVGI8URk8W/5Q6gtzrVnVwCtziW34VLUuvZSpW/9GgCS06uFIjebbWXgPrNmw2P2bclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809741; c=relaxed/simple;
	bh=v9fV8PkvFONyM8/7CBAhWHz3Ffg21SCq8PHP14B/kzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvD0aZwDpYRq85qYakP5drL4CJF1uY/1Qc3kFHq4yDjVelHzYuImIbnNaQT1T8PG+cyyrcSiEDWUb2t5KTDZFrwo1BJ/kgyIXG/p8aNZwYEsuLnfy3BuBIH8dEUOd689igJ4P8B/ubufHpgdo7RThG+k6U+FYhkmj9HIgTYjGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaVW6V9t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f3ea6207cso1234456f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809738; x=1740414538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz5eSSbGmek/6y/tsCBF0vwN+yx7lRsH/SSKw++UQXI=;
        b=GaVW6V9th4ltZumjoqqKIl5LuopfP1B61MUKi1f6IGdWjj+uQ3TsrIzPIUB8q/3bDB
         h3dNqnPoZ9pODqH5ag8vhlMxkYFGv7gxSKq6lSIUPQ5Eep6z0MzIpzwtW5AG83z6Ejfk
         e68Oj1vxOYiEOKKkWuesGYFgrEO9uEJ9M5AJWY9RhFHOc50+ocmIxf3dHgwdmuSnUkQl
         HBgw2BMatIgefs4ZxQamEana4pM68qemtnEhXj82KqtRlVDhFQvMRiONuGX8g5HaIgA2
         T33wx+W3MZplIcAZBzWW584i5E+LN2B4mzJ+zCTI9Ax350mpzzcXUIkFkrbXlOc2hjrE
         E5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809738; x=1740414538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz5eSSbGmek/6y/tsCBF0vwN+yx7lRsH/SSKw++UQXI=;
        b=enrv/n2X8GOF0xjRCBstYiyVoAMKOFNq6UMWXEWBhS4OvSWiIbXQldsCGlYI0xJbOX
         eUt63ObGlhmYA4RdmjyDFfFIr3+FfBcJzRxSx8QlX9a+gsnYkwplRkvReFQg4XCQi9Go
         XOZm8VBDyBvGoGXU8L5hQOjeEj2TjRg2xn6K76aFt/E00oRwdmigZIDy/ASZfsHzGgwx
         W800+LU6cvxsAlABd6Ut34WNEWtCrVYhTeXMY2zUf3vMWbzMzsmtYa7k33Fo2GtKHp4v
         76Uf+k6t1KpzdYWnoFSoJOVIx3Bcy/gvTb1q/zrfujLxz2GEre6BuEFonF2DGgGf8J2l
         k1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUkmfamWkEQVhDyjTW8m06YH2s+jvtToX080P0cHSwrHx7FycdFJaVInQTwYwKvfwigiVPwyhQSeBoRMbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY73jxTvAaWiXolTFRWAst3sIy1QWtVoevsu5UdHvqpH9Cz9+A
	DniSZO4ypj4M45edUcpBniNdlznmPYIK8orknvpLg6WA9gukkakMF7pd3LXNSsYeA8c6e0Zdj/O
	acA4kwzQ51+wGdtpntwpq4SXoQZY=
X-Gm-Gg: ASbGnctLkzR3jxAjdZmaNOJhYpEsFCq7BRsJPBubGpyVgUTn8GBohBxTNaOdaGj9nq+
	nQ/M0LUfGG490e3LqK1TFKouVTUIYj3NF+Ioh9DSkJgtsAd89DQCKzfW2TJdoXa+4CQ7gNRvpuW
	k=
X-Google-Smtp-Source: AGHT+IEPuRn8oRyxtXUQAo68jc/IBOxP+D9vVZ6bGu1LAWQCU9Qytan12Krv6Qaacj6NLJ4/0DOTG24ArEI/XoTia0w=
X-Received: by 2002:adf:ec03:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-38f340676b0mr8083238f8f.34.1739809737912; Mon, 17 Feb 2025
 08:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217042108.185932-1-longman@redhat.com>
In-Reply-To: <20250217042108.185932-1-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:28:46 +0100
X-Gm-Features: AWEUYZkOCsf3Lwl5kZxqhWvK51MQBU8TFE8a7QrsCXHmnwBN1EdOJpdIiaaxzBA
Message-ID: <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:21=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
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
>
> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/kasan/report.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
>  [v3] Rename helper to print_vmalloc_info_set_page.
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..7c8c2e173aa4 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void *=
addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> +/*
> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kerne=
l,
> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
> + * to WAIT_SLEEP.

Quoting your response from the other thread:

> Lockdep currently issues warnings for taking spinlock_t inside
> raw_spinlock_t because it is not allowed in RT. Test coverage of RT
> kernels is likely less than !RT kernel and so less bug of this kind will
> be caught. By making !RT doing the same check, we increase coverage.
> However, we do allow override in the !RT case, but it has to be done on
> a case-by-case basis.

Got it.

So let's put this exactly this explanation in the comment, otherwise
it's unclear why we need something special for the !RT case.

> + */
> +static inline void print_vmalloc_info_set_page(void *addr, struct page *=
*ppage)
> +{
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEE=
P);
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
> +                       *ppage =3D vmalloc_to_page(addr);

Looking at the code again, I actually like the Andrey Ryabinin's
suggestion from the v1 thread: add a separate function that contains
an annotated call of find_vm_area(). And keep vmalloc_to_page()
outside of it, just as done in the upstream version now.

> +               }
> +               lock_map_release(&vmalloc_map);
> +               return;
> +       }
> +       pr_err("The buggy address %px belongs to a vmalloc virtual mappin=
g\n", addr);
> +}
> +
>  static void print_address_description(void *addr, u8 tag,
>                                       struct kasan_report_info *info)
>  {
> @@ -398,19 +426,8 @@ static void print_address_description(void *addr, u8=
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
> +               print_vmalloc_info_set_page(addr, &page);
>
>         if (page) {
>                 pr_err("The buggy address belongs to the physical page:\n=
");
> --
> 2.48.1
>

