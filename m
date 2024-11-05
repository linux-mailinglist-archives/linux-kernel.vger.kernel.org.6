Return-Path: <linux-kernel+bounces-396883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D188D9BD39E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91554286485
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67D1E378A;
	Tue,  5 Nov 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xBQ7446r"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691BEAD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828480; cv=none; b=dGHwV32oIwNrLBp6eoz/TfIfrl30LUp7FCPAfRXa6TFcAiEYoHmWbGz/C1jeHqAOMhXnRdfS1pDAdyBihe08ApxhZ+J8u9Sizidyj9cd+52CEQWHf0758MyY3foNpAse6/L/uyPq6MYsVB2ck1MoIhNywZRwZss7Q2MvY2IwOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828480; c=relaxed/simple;
	bh=qpTbufCwzH8I25DiwP2Bsp0OfQgYMi1mBz9M6K3WF48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbIkXxpOghgNL/qTK7rm50fFnTbBJzzYYfbZ+wMI+3DapODHb0M2Wk8ObsgVGsepI8mFV54RvTpRVfJ0AhTjH0PUQyp29qZTdFQqF5v/Qbk0iAXzdbNUMIbJYsIvu2NUZ6COXMV2zWvoNdf1zR2eaTsRVVw6SR4VJ8M3fq5cNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xBQ7446r; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso300745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828478; x=1731433278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0lJpoKJj2EK5cJjiPDReD4fq+ImZCdH+adMojPVPqY=;
        b=xBQ7446rbI86bCNa04PAmv52B6BATfE3kARAa4ctnj8VUO4K3nTGC8TkERRBnjYuSD
         PdZ8n0LHuH7Zu0RIAxsrkNEx+sR9hAtL51ebwmZvOB3+LBS7qKiNEqhA8cduES/YCtv1
         LVDcVQuTAnNXXZAK1jeQXAEV30si81bQ/xg87GkblmiJ5MEGEudgGOPBJUOmS062FoqR
         ipkrrRRDS+ZQAnDxxHuvkeLl+bN1XSrJ2w44AimQcy3+uiUlRKZq++02AmsRuWh58067
         UMquMEd1MxZ7EXVo3w4dsQn5dsk/D3CDmolAP6y1cYCcUjKjaTmp9lKvArHmVGA8xSod
         2Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828478; x=1731433278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0lJpoKJj2EK5cJjiPDReD4fq+ImZCdH+adMojPVPqY=;
        b=pvFt/IIaGQIPA/dXgIROI0fozlN4lfYvW+W9femJaJaKV6XkzisSfrH4NbqqI0cpzI
         IXmSAUSqi3jroQ9qO1gwtd8Eu5U8GHZFZqBtedzF2aFWZiUYgFDD7taGgDC/HlGSAmbc
         dIEe9Agbmn7DyrPQxjSoqneLpoBzLm4VoQWjqw5PoK1uq/dCkOPEseumOXWCX20jXpaF
         mkdXOJA34VctmzGj+qDe80nUSjT/DmbxnuGl+096qJFsP2twPmjVdU/LGYQ/kyOckBLE
         J27ZHY5NiUUhnsWT0NrPuYLjp90gZ0Z3JJWshxvetYOnb0l2ZrE4iFxCpBImwXSm9M/f
         G5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtTlq5Xi9Py1e9rGoiA2A+8BaibVJ1mf3Qf00NE8xQbI6x4W3X0Y6ohRQQ+sQ/kaj0jQWyIojkGYfBU9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OYVxWArdBhK9yU0BvGtl+JMB1Gqov6ne7Bh1uXpNGurVuIdq
	puTdo98iT8n9iTWOasYK/wWVO8L6XdW5GUHtgXEAJNkIQlKcrAuO16r0mRIGiup8AxsVOIJVbEN
	rtEDxNoYBUfIFf6gpvRN+cOmvYIlYB/Tmi46m
X-Gm-Gg: ASbGncuJdajG5JYILu2QHrpnv+nkRKpXQyxvyCgq0ax8g2k7oqSK2uuakxdEueKrTFf
	Swj6w+em+M1edE7zLrBxx4vTw1W0NOzyU
X-Google-Smtp-Source: AGHT+IGTvwqqYkeTtirjxSdFHrxdcw5lIc7C0xy3BIx18v0NkSra6VHHJ/ScxATVbz0L5aGGhIxNLX0/HPWm5ouD4D8=
X-Received: by 2002:a05:6e02:12ca:b0:3a0:44d1:dca4 with SMTP id
 e9e14a558f8ab-3a6da95f94emr4550175ab.6.1730828476469; Tue, 05 Nov 2024
 09:41:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105172635.2463800-1-namhyung@kernel.org> <20241105172635.2463800-4-namhyung@kernel.org>
In-Reply-To: <20241105172635.2463800-4-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 09:41:05 -0800
Message-ID: <CAP-5=fV3JAJD_beASNdP_Sxh=oAFv-yh_cqW=P=Bc9FabddUpQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf lock contention: Resolve slab object name using BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:26=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The bpf_get_kmem_cache() kfunc can return an address of the slab cache
> (kmem_cache).  As it has the name of the slab cache from the iterator,
> we can use it to symbolize some dynamic kernel locks in a slab.
>
> Before:
>   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -=
abl sleep 1
>    contended   total wait     max wait     avg wait            address   =
symbol
>
>            2      3.34 us      2.87 us      1.67 us   ffff9d7800ad9600   =
 (mutex)
>            2      2.16 us      1.93 us      1.08 us   ffff9d7804b992d8   =
 (mutex)
>            4      1.37 us       517 ns       343 ns   ffff9d78036e6e00   =
 (mutex)
>            1      1.27 us      1.27 us      1.27 us   ffff9d7804b99378   =
 (mutex)
>            2       845 ns       599 ns       422 ns   ffffffff9e1c3620   =
delayed_uprobe_lock (mutex)
>            1       845 ns       845 ns       845 ns   ffffffff9da0b280   =
jiffies_lock (spinlock)
>            2       377 ns       259 ns       188 ns   ffffffff9e1cf840   =
pcpu_alloc_mutex (mutex)
>            1       305 ns       305 ns       305 ns   ffffffff9e1b4cf8   =
tracepoint_srcu_srcu_usage (mutex)
>            1       295 ns       295 ns       295 ns   ffffffff9e1c0940   =
pack_mutex (mutex)
>            1       232 ns       232 ns       232 ns   ffff9d7804b7d8d8   =
 (mutex)
>            1       180 ns       180 ns       180 ns   ffffffff9e1b4c28   =
tracepoint_srcu_srcu_usage (mutex)
>            1       165 ns       165 ns       165 ns   ffffffff9da8b3a0   =
text_mutex (mutex)
>
> After:
>   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -=
abl sleep 1
>    contended   total wait     max wait     avg wait            address   =
symbol
>
>            2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   =
&task_struct (mutex)
>            1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   =
&task_struct (mutex)
>            4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   =
&kmalloc-cg-512 (mutex)
>            2       859 ns       617 ns       429 ns   ffffffffa41c3620   =
delayed_uprobe_lock (mutex)
>            3       691 ns       388 ns       230 ns   ffffffffa41c0940   =
pack_mutex (mutex)
>            3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   =
text_mutex (mutex)
>            1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   =
tracepoint_srcu_srcu_usage (mutex)
>            2       362 ns       239 ns       181 ns   ffffffffa41cf840   =
pcpu_alloc_mutex (mutex)
>            1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   =
&signal_cache (mutex)
>            1       215 ns       215 ns       215 ns   ffffffffa41b4c28   =
tracepoint_srcu_srcu_usage (mutex)
>
> Note that the name starts with '&' sign for slab objects to inform they
> are dynamic locks.  It won't give the accurate lock or type names but
> it's still useful.  We may add type info to the slab cache later to get
> the exact name of the lock in the type later.

Many variables may reference a lock through a pointer, should the name
not be associated with the lock or from decoding the task_struct?
The '&' looks redundant as the addresses are clearly different.
How are >1 lock/mutex in the same struct handled?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_lock_contention.c         | 52 +++++++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 21 +++++++-
>  2 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index a2efd40897bad316..50c3039c647d4d77 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -2,6 +2,7 @@
>  #include "util/cgroup.h"
>  #include "util/debug.h"
>  #include "util/evlist.h"
> +#include "util/hashmap.h"
>  #include "util/machine.h"
>  #include "util/map.h"
>  #include "util/symbol.h"
> @@ -20,12 +21,25 @@
>
>  static struct lock_contention_bpf *skel;
>  static bool has_slab_iter;
> +static struct hashmap slab_hash;
> +
> +static size_t slab_cache_hash(long key, void *ctx __maybe_unused)
> +{
> +       return key;
> +}
> +
> +static bool slab_cache_equal(long key1, long key2, void *ctx __maybe_unu=
sed)
> +{
> +       return key1 =3D=3D key2;
> +}
>
>  static void check_slab_cache_iter(struct lock_contention *con)
>  {
>         struct btf *btf =3D btf__load_vmlinux_btf();
>         s32 ret;
>
> +       hashmap__init(&slab_hash, slab_cache_hash, slab_cache_equal, /*ct=
x=3D*/NULL);
> +
>         ret =3D libbpf_get_error(btf);
>         if (ret) {
>                 pr_debug("BTF loading failed: %d\n", ret);
> @@ -50,6 +64,7 @@ static void run_slab_cache_iter(void)
>  {
>         int fd;
>         char buf[256];
> +       long key, *prev_key;
>
>         if (!has_slab_iter)
>                 return;
> @@ -65,6 +80,34 @@ static void run_slab_cache_iter(void)
>                 continue;
>
>         close(fd);
> +
> +       /* Read the slab cache map and build a hash with IDs */
> +       fd =3D bpf_map__fd(skel->maps.slab_caches);
> +       prev_key =3D NULL;
> +       while (!bpf_map_get_next_key(fd, prev_key, &key)) {
> +               struct slab_cache_data *data;
> +
> +               data =3D malloc(sizeof(*data));
> +               if (data =3D=3D NULL)
> +                       break;
> +
> +               if (bpf_map_lookup_elem(fd, &key, data) < 0)
> +                       break;
> +
> +               hashmap__add(&slab_hash, data->id, data);
> +               prev_key =3D &key;
> +       }
> +}
> +
> +static void exit_slab_cache_iter(void)
> +{
> +       struct hashmap_entry *cur;
> +       unsigned bkt;
> +
> +       hashmap__for_each_entry(&slab_hash, cur, bkt)
> +               free(cur->pvalue);
> +
> +       hashmap__clear(&slab_hash);
>  }
>
>  int lock_contention_prepare(struct lock_contention *con)
> @@ -398,6 +441,7 @@ static const char *lock_contention_get_name(struct lo=
ck_contention *con,
>
>         if (con->aggr_mode =3D=3D LOCK_AGGR_ADDR) {
>                 int lock_fd =3D bpf_map__fd(skel->maps.lock_syms);
> +               struct slab_cache_data *slab_data;
>
>                 /* per-process locks set upper bits of the flags */
>                 if (flags & LCD_F_MMAP_LOCK)
> @@ -416,6 +460,12 @@ static const char *lock_contention_get_name(struct l=
ock_contention *con,
>                                 return "rq_lock";
>                 }
>
> +               /* look slab_hash for dynamic locks in a slab object */
> +               if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK,=
 &slab_data)) {
> +                       snprintf(name_buf, sizeof(name_buf), "&%s", slab_=
data->name);
> +                       return name_buf;
> +               }
> +
>                 return "";
>         }
>
> @@ -590,5 +640,7 @@ int lock_contention_finish(struct lock_contention *co=
n)
>                 cgroup__put(cgrp);
>         }
>
> +       exit_slab_cache_iter();
> +
>         return 0;
>  }
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index fd24ccb00faec0ba..b5bc37955560a58e 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -123,6 +123,8 @@ struct mm_struct___new {
>         struct rw_semaphore mmap_lock;
>  } __attribute__((preserve_access_index));
>
> +extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
> +
>  /* control flags */
>  const volatile int has_cpu;
>  const volatile int has_task;
> @@ -496,8 +498,23 @@ int contention_end(u64 *ctx)
>                 };
>                 int err;
>
> -               if (aggr_mode =3D=3D LOCK_AGGR_ADDR)
> -                       first.flags |=3D check_lock_type(pelem->lock, pel=
em->flags);
> +               if (aggr_mode =3D=3D LOCK_AGGR_ADDR) {
> +                       first.flags |=3D check_lock_type(pelem->lock,
> +                                                      pelem->flags & LCB=
_F_TYPE_MASK);
> +
> +                       /* Check if it's from a slab object */
> +                       if (bpf_get_kmem_cache) {
> +                               struct kmem_cache *s;
> +                               struct slab_cache_data *d;
> +
> +                               s =3D bpf_get_kmem_cache(pelem->lock);
> +                               if (s !=3D NULL) {
> +                                       d =3D bpf_map_lookup_elem(&slab_c=
aches, &s);
> +                                       if (d !=3D NULL)
> +                                               first.flags |=3D d->id;
> +                               }
> +                       }
> +               }
>
>                 err =3D bpf_map_update_elem(&lock_stat, &key, &first, BPF=
_NOEXIST);
>                 if (err < 0) {
> --
> 2.47.0.199.ga7371fff76-goog
>

