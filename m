Return-Path: <linux-kernel+bounces-279832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC194C25D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6691F24298
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3818FC99;
	Thu,  8 Aug 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgI8nBpW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395B18E743
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133566; cv=none; b=HnWwd2W76k9O6i5v2/oz89d1ZkRFr5RyeoLmZ0W66bxtqInT0BvFn/uQeGSOqNEIW9sjO2+o1qyPA8sq1iFMpo4sqA1Ru3aNIuT0eXjwm2uNZGKyXuuSNVJZvKNzpc81qdk1CMymRtB+FV9jUJshpcL0UuEdsllFYbRqnsvdTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133566; c=relaxed/simple;
	bh=gyPAB3oe+L39mKF4x8mc84RHFko1+s6nUX5Si7AG7+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m70u1W8GHuAV3N/M0TVXXrP1rQXhDTSn97zsMozQGKywl9p81qH0LQj+WOtHp5ZZBhkaaXitCi9MrsOQD5/KaQguGs56MTu8eqHYVCt9no35PncIeeWaGpqjxEMpwNHTLCT/M/e2h0f4PaOIr0B8hWz5FxAaSSguSbY/dadKCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgI8nBpW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368584f9e36so512605f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723133563; x=1723738363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sMXnmSS5qxZThRe1pr+22qASOYPaMxsbUL8t/p0LOk=;
        b=bgI8nBpWHprHKfZcLs+IH+UMwx1WjbvCIMoN6kMCfTvg/XGWLJawQpHZSOzp9WUOAA
         bGcWK3+hZgIGm4hN23gJ5v3edumESjvOgQtWZ9/2/aAdK4df0+ZNoEdiHzQXywtOQpOv
         K/b/vo8TPXsoJBWYkdk0SSRgglEweaTMBPyW/qjL1wG6nt0s5sAGLhAsSy5RUyb98Xd2
         XmyGu1nzddxxLIoh22WLGVGvccHiX+rGWTp5V493yjxPC4ovgZ8eTrQWlHVuj3Z21cL0
         Z/LU5NH1ElQ/WNfn9f1JRWr/C1b8iUrsn5tX1r4RxFlGYmEt/hfQC2DP3LUk/OwG0aio
         Bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133563; x=1723738363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sMXnmSS5qxZThRe1pr+22qASOYPaMxsbUL8t/p0LOk=;
        b=jewGZE3uKHgzNPoNcJTYGaLLdNOxXcYalISFWOqX4ubo/2Jy7XyJkZ0idMoKHZaOWV
         UnIUsEC4EW37GAExy/f4yResNxpNjYouhMthGE6n2Uyn/j2SrKAe+LGnaP4BJAXmFFd5
         GqcXdNHlFFghtcAEUF0rdp6Zzn7vYhKSaDSPExbVMq2Ic27dnUIA0HkV/MdanhjFFIG3
         C9S/n1Ww/a6PONuCUUHwCbjyA12Kx1kV7/hK1LuLfWNB19ANDuLqbLolAjPK35IM98Dj
         MW2V7kIFXpQT/wQVa4AV2JDikjABcI63xNcZnLuhYfJC+jlHw1KolAfvW02jJLJmCqHv
         zHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1zyvbPMlezzjpboXtzAXFXzwjL2BnBLiGwCdrLnxLWfqxDlRJf2LLYV0L80qnB8x+jYvOGjL0EkmQx/G9Q7q4EVptCZl4yXpVKyxU
X-Gm-Message-State: AOJu0Yz0ts6wNGueixFBYjKfwQ0oC592btzT+qQZEH26YO2OZOPLCw2o
	jvdzp3gSMQtYYX87ZHzSjl/s3qhxSVsm87SfoD+ElCx6cO8rL8rIE9tn+lyhxteqJOyj63OQWR3
	gV9/Nivn/rCw2jwv7CpCvsY9aR9g=
X-Google-Smtp-Source: AGHT+IEdiZMBtJngrto1ht27v/5JHnPvqtCkJYl13Qwly4qrnmowSTl1Mh/8E4AvT5zWqzVDC+a/YACAR13VIfjPmrM=
X-Received: by 2002:a05:6000:e02:b0:367:9881:7d66 with SMTP id
 ffacd0b85a97d-36d2755f55fmr1539058f8f.41.1723133562567; Thu, 08 Aug 2024
 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808125430.1172152-1-longman@redhat.com>
In-Reply-To: <20240808125430.1172152-1-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 8 Aug 2024 18:12:29 +0200
Message-ID: <CA+fCnZdWgAD1pu4yyjON0ph9ae1B6iaWas0CbET+MXLNNXt5Hg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is enabled
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:54=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> As said in commit 02754e0a484a ("lib/stackdepot.c: bump stackdepot
> capacity from 16MB to 128MB"), KASAN uses stackdepot to memorize stacks
> for all kmalloc/kfree calls. So stackdepot capacity was increased 8
> times to accommodate KASAN usage even thought it was claimed 4X should
> be enough at that time.
>
> With commit fc60e0caa94d ("lib/stackdepot: use fixed-sized slots
> for stack records"), all stackdepot records uses a fixed size with
> CONFIG_STACKDEPOT_MAX_FRAMES (default=3D64) entries. This is merged to
> support evictable KASAN stack records. Commit 31639fd6cebd ("stackdepot:
> use variable size records for non-evictable entries") re-enabled
> the use of variable size records for non-KASAN use cases, but KASAN
> (generic mode) still uses the large fixed size stack records.

No, since commit 711d349174fd ("kasan: revert eviction of stack traces
in generic mode") Generic KASAN doesn't use fixed-sized slots.

> With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
> stackdepot space had been more than double than before. Assuming an
> average stack frame size of 16, a KASAN stack record is almost 4X the
> size of a non-KASAN one.

So this is not correct.

> When a wide variety of workloads are run on a debug kernel with KASAN
> enabled, the following warning may sometimes be printed.
>
>  [ 6818.650674] Stack depot reached limit capacity
>  [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 depot=
_alloc_stack+0x39e/0x3d0
>    :
>  [ 6818.650907] Call Trace:
>  [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
>  [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x5c0
>  [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
>  [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
>  [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
>  [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
>  [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
>  [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
>  [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0x350
>  [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
>  [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
>  [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
>  [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
>  [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
>  [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
>  [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
>  [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
>  [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
>  [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
>  [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x400 =
[xfs]
>  [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 [xfs=
]
>  [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
>  [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
>  [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
>  [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
>  [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98
>
> With all the recent changes in stackdepot to support new KASAN features,
> it is obvious that the current DEPOT_POOLS_CAP of 8192 may not be
> enough when KASAN is enabled. Fix this stackdepot capability issue
> by doubling DEPOT_POOLS_CAP if KASAN is enabled. With 4k pages, the
> maximum stackdepot capacity is doubled to 256 MB with KASAN enabled.

It is possible that the stack depot runs out of space due to a truly
large number of unique stack traces, but I would first make sure that
is indeed the case. The one thing to check would be to dump all the
stack traces from the stack depot when it overflows, and check whether
they make sense. There have been cases in the past, when e.g. the task
context part of a stack trace from an interrupt didn't get stripped
properly, and thus almost each stack trace from an interrupt was
considered unique by the stack depot. Perhaps, something similar
started happening again.

>
> Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
> intention.
>
> Fixes: fc60e0caa94d ("lib/stackdepot: use fixed-sized slots for stack rec=
ords")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/stackdepot.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
>  [v3] Include <linux/minmax.h"> to avoid potential undefined macro proble=
m.
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ed34cc963fc..1f1673b357b5 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kmsan.h>
>  #include <linux/list.h>
> +#include <linux/minmax.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/poison.h>
> @@ -36,11 +37,12 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>
> -#define DEPOT_POOLS_CAP 8192
> +/* KASAN is a big user of stackdepot, double the cap if KASAN is enabled=
 */
> +#define DEPOT_POOLS_CAP (8192 * (IS_ENABLED(CONFIG_KASAN) ? 2 : 1))
> +
>  /* The pool_index is offset by 1 so the first record does not have a 0 h=
andle. */
>  #define DEPOT_MAX_POOLS \
> -       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> -        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> +       MIN((1LL << (DEPOT_POOL_INDEX_BITS)) - 1, DEPOT_POOLS_CAP)
>
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata =3D IS_ENABLED=
(CONFIG_STACKDEPOT_ALWAYS_INIT);
> --
> 2.43.5
>

