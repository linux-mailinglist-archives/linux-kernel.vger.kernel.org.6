Return-Path: <linux-kernel+bounces-280163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4794C67C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A73C1C220BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88BF15B0FC;
	Thu,  8 Aug 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYgWMHU5"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417C155A59
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153965; cv=none; b=G7q5sAxmdsNrv2IuS0a0c41Oh60VAriasvc9Y7pqXQV6j1zULIRSseabF1LaRda+YJdjdu2E2JXQWSpZ01ikMQJrsFvLqTIvJXx+BefNUYS3ea7/iYokVH/AWj2O9AOwECGrOAtqjweOs3nAZFHQqvCC6Tqh7t/QG7UK+VDDx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153965; c=relaxed/simple;
	bh=n1ciUhKaReCbIoIp2AATMkvQ4WDZoryQ+o/3wGZjNfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJU6SSzG+hZUWWyP8TIDRYxyIXqsO7lTpBHF+xvnLZrcuwW0YR6063Ps7r9Nnv4+XNwilNTdD2+MwoBYuMqRiF2a1J+mNf+OhiMuGR3hoYltn6+CluDywS9b+xg3RVHqxlwpPSV1FnLLejKFbsk787dFkJq5s/9BIIFzB1Wq5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYgWMHU5; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f8b5e5671bso562764e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723153963; x=1723758763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPpfNVrH2MkNchUISULx8fD/VEpEq0fygt8tZKRjEsU=;
        b=XYgWMHU57SUH3C15b/TM74hKuWLEYZHjKiOHJqaD8/+IZbA+E9eY/fCcMWictfWUSA
         330Yd1DIjaWXJAbzgjgIPVMIX/W18l7WX1DqiW7OQEet0klnVayIewVfoDtJaHdrjGlJ
         oW8jBIOqcthbkwpBhwTrTPJYMp0986CxK72awmUCt7UKVjpMgqB0aEeY3ieJZfx8xTcC
         TLY5lqWECGO9y1kNjMIGtKS2Ap40QNgI39LzKR75bDX+jpKWsoVxspgOnLyz9V2cI6dw
         TiAYoUfHra3YK4a7cBnK4wn1QzEJA4S6jlYcpmIzB5uUba5kOSdPwQMJiMb8w1EfzfTw
         rLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153963; x=1723758763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPpfNVrH2MkNchUISULx8fD/VEpEq0fygt8tZKRjEsU=;
        b=iCNuPIqKmc2fg7ArLrLIc2acxpHZdvoYZYDSMPTnOcJuJwohri2QXVKcHfID22fQpe
         XZMhFGUj6QQjEZrnSSlNIj7+ss+l3xhRF4WEaF7ra8R/ZZ4n3FlMxA9AdPRURV+RPRBP
         jdEI2PLqv8ovFY+b48McUtsO8vTp/De0BP9Q87psgNhuKWJUuVyRHyeOc8yy8il0SrN4
         ovVUCfCYXn62TwgS7Aw+wpzS7mJUnoHbiyIS1QfqahvX2wHRy3aCyRLFf3eCkXLmF8X6
         Dxpy9XJ5W4z6e4POT+bMTezPLe1F8M5ozfFGC/4y+gSL4+WYTr/oo/4maqMOI4REZVS2
         A9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySyxdYkoBN+YrOagCirnG2G8fcoRNU5bHq4GH+3Ms72eZwKxKX1917FVmc3NyvU3fJtuo3PXftwXmsaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfmmLqXx4Gw37Uwur63FSVlJbQJ3wVTYJcvcgjPcCBg/4POhN
	2x6N94fQ8PnOy5FyRxNbZS21ACuEHWUWoTVutXLNWZ/hhxrHHb0tPDHKo1ex8Zb8IuQ1lfG2ypA
	7bBl8BjiWXf3zPEfAuvR1wmmcKJY=
X-Google-Smtp-Source: AGHT+IFRFIkowlP+xzoy5xCnMmjEGt1/1LyRlpnqrSHuxpInxb90Pj2BISdIV78amQBmHP4XTxLemUG9rhJLzpGCoKs=
X-Received: by 2002:a05:6102:2ad0:b0:48f:4bd5:23d9 with SMTP id
 ada2fe7eead31-495c57162eamr3837973137.5.1723153963086; Thu, 08 Aug 2024
 14:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808125430.1172152-1-longman@redhat.com>
In-Reply-To: <20240808125430.1172152-1-longman@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 Aug 2024 09:52:31 +1200
Message-ID: <CAGsJ_4wXnB_bz32hVcK5OWPBge5dXNThfSAozb_koWMkz_-6VQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is enabled
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:54=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
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
>
> With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
> stackdepot space had been more than double than before. Assuming an
> average stack frame size of 16, a KASAN stack record is almost 4X the
> size of a non-KASAN one.
>
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
>
> Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
> intention.
>
> Fixes: fc60e0caa94d ("lib/stackdepot: use fixed-sized slots for stack rec=
ords")
> Signed-off-by: Waiman Long <longman@redhat.com>

Hi Waiman,

I am getting this issue on ARM64:

lib/stackdepot.c:44:9: error: implicit declaration of function =E2=80=98MIN=
=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   44 |         MIN((1LL << (DEPOT_POOL_INDEX_BITS)) - 1, DEPOT_POOLS_CAP)
      |         ^~~
lib/stackdepot.c:66:26: note: in expansion of macro =E2=80=98DEPOT_MAX_POOL=
S=E2=80=99
   66 | static void *stack_pools[DEPOT_MAX_POOLS];
      |                          ^~~~~~~~~~~~~~~
lib/stackdepot.c:66:14: error: variably modified =E2=80=98stack_pools=E2=80=
=99 at file scope
   66 | static void *stack_pools[DEPOT_MAX_POOLS];
      |              ^~~~~~~~~~~

I've temporarily added this to get the build to pass, though I'm not sure
if it's the correct fix,

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index beeb70b57710..f210e3202927 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,6 +36,8 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>

+#define MIN(a,b) ((a)<(b) ? (a):(b))
+
 /* KASAN is a big user of stackdepot, double the cap if KASAN is enabled *=
/
 #define DEPOT_POOLS_CAP (8192 * (IS_ENABLED(CONFIG_KASAN) ? 2 : 1))


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
>

Thanks
Barry

