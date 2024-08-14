Return-Path: <linux-kernel+bounces-285954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8639514CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159121F24B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE323136E2E;
	Wed, 14 Aug 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQojRAo4"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B8374F6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618216; cv=none; b=mL+HKEAqYmIpvI+AcclLAItYzDIsWv9oZfVCr7BhgLKCZdbUV1PRLgrD6ZYTkaQLVqzIfYFPqOCSkO17QFo2aTIFhW2Pk+2K8r3GsfeXyGrw32i3h5M1XZV6sj+TNiYIhrF/H2Fht5SUI1aua0AmbJ6XNyBn7sfFHFnvDGBwRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618216; c=relaxed/simple;
	bh=tI3YSprpxFwaGUO7fY5Qo3W39AYnaYwT3a6Cf52O4Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7PprlXqjonilBOxmCrNk9TYAIwWN3KKbku6zvsdrpxx/iw5pRPPx4KR38lM9BmFcR6A9YL35Hh+IXTPOvyuVs6wXbTXwrJv7IYJAbkgVBZ3QyUhTLNAWl/TuhSQ8VITwnOBz33Ax2piALFy4QvHdec4EQ9bIRPPoIKYTSgzkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQojRAo4; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4928fb6fdceso2061406137.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723618213; x=1724223013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kGYIVRMx7xSAnTXSGLiynA60xaTatAN/kEWNV4u5Zsk=;
        b=vQojRAo4zh4+SGCXVptE07pvAv+omUtvD2SOT4/Wox72UJn7hybltVZUqvzIPi/8E2
         0kCzLN5kEctCNXUwbGTW2zdjgemLwswlgIaK8j4PGYyMMI4raqAdIj7TsuTjSgznSwhn
         xl1JFICJpozFo2MFq+Obhc574YX0eUIKIxpZYvoxBQ54JWLa3U5mlWXOezqqRONBG8aM
         W+c48naWxFDaBMoZez6Acq9By33jE8rKAMlGHjnCu1W8hS2UoFzCydxE+oPnQM2e0ed1
         9Md9MfRxShDLeb/Mz2f4hFoAoVijgfVjehIl6N3WYGot/U7Ff7JG3C8m/C6N55Mm7jsd
         R3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618213; x=1724223013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGYIVRMx7xSAnTXSGLiynA60xaTatAN/kEWNV4u5Zsk=;
        b=wNcN1BxNE5anXH1K6rn0nmE2uSfA5ldPshWKYkiDjb9MqTvhjKS0mN1wDayHKvwJ1o
         Rp9bUApYf3SJMyVcsqp48XtBzd2Mj4ve7l7nUfg1/R6prfcO5cNR/otWH6eq2fPj43VQ
         l+OZ36DTgxvnte99DD4fyqO1Ufa5ZRjAmNR2ARwUWOXGMdXEUdxSxQZXIxv6Fxk1vlo9
         o8mRcy9jhov4GgbUvTf0GB6kHzj6K3fd9fuYS4fv3TmPZlMtWwFWFXlVQB5eUuwQ+oHy
         +E0dMfcakO+cMcNtBfucwQEn3q4H1vwVMIi+B1UvYRce3yzbdw0Z/nKwvfa/eCva4N2E
         Jebw==
X-Gm-Message-State: AOJu0YxTFrp+lmJ4ig8duME0suj/7pIiXp816iYeeQM6oIXUFkxdZ9XN
	TRrCqsGjYAqGur9+nHiiahZ5f6e9TVIhF0pkLrY3nJ0g9B7N/rhhgXXIA4ndeRaytHuB0eNzDrf
	L9LJAnaCaFAl7JsyaE2sCT6YBc1rqf3EEbU4U
X-Google-Smtp-Source: AGHT+IHFef/Y7C8vlNKsrswVF7Px7lxQgeUBx+R+dkNvPnYvcUA1CJlMFcH4ruFwu/5f65IQU7ns0H8DyCAc3UM8/UU=
X-Received: by 2002:a05:6102:e06:b0:493:de37:b3ef with SMTP id
 ada2fe7eead31-49759913349mr2343105137.13.1723618213265; Tue, 13 Aug 2024
 23:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812095517.2357-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20240812095517.2357-1-dtcccc@linux.alibaba.com>
From: Marco Elver <elver@google.com>
Date: Wed, 14 Aug 2024 08:49:37 +0200
Message-ID: <CANpmjNMm3CkfW=BPWR3w37Dfo=MFReD9wxHejDy4=ibwhe33yA@mail.gmail.com>
Subject: Re: [PATCH v2] kfence: Save freeing stack trace at calling time
 instead of freeing time
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 11:55, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> For kmem_cache with SLAB_TYPESAFE_BY_RCU, the freeing trace stack at
> calling kmem_cache_free() is more useful. While the following stack is
> meaningless and provides no help:
>   freed by task 46 on cpu 0 at 656.840729s:
>    rcu_do_batch+0x1ab/0x540
>    nocb_cb_wait+0x8f/0x260
>    rcu_nocb_cb_kthread+0x25/0x80
>    kthread+0xd2/0x100
>    ret_from_fork+0x34/0x50
>    ret_from_fork_asm+0x1a/0x30
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks for the patch!

> ---
> v2:
> Rename and inline tiny helper kfence_obj_allocated().
> Improve code style and comments.
>
> v1: https://lore.kernel.org/all/20240812065947.6104-1-dtcccc@linux.alibaba.com/
> ---
>  mm/kfence/core.c   | 39 +++++++++++++++++++++++++++++----------
>  mm/kfence/kfence.h |  1 +
>  mm/kfence/report.c |  7 ++++---
>  3 files changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c3ef7eb8d4dc..67fc321db79b 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -273,6 +273,13 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
>         return pageaddr;
>  }
>
> +static inline bool kfence_obj_allocated(const struct kfence_metadata *meta)
> +{
> +       enum kfence_object_state state = READ_ONCE(meta->state);
> +
> +       return state == KFENCE_OBJECT_ALLOCATED || state == KFENCE_OBJECT_RCU_FREEING;
> +}
> +
>  /*
>   * Update the object's metadata state, including updating the alloc/free stacks
>   * depending on the state transition.
> @@ -282,10 +289,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>                       unsigned long *stack_entries, size_t num_stack_entries)
>  {
>         struct kfence_track *track =
> -               next == KFENCE_OBJECT_FREED ? &meta->free_track : &meta->alloc_track;
> +               next == KFENCE_OBJECT_ALLOCATED ? &meta->alloc_track : &meta->free_track;
>
>         lockdep_assert_held(&meta->lock);
>
> +       /* Stack has been saved when calling rcu, skip. */
> +       if (READ_ONCE(meta->state) == KFENCE_OBJECT_RCU_FREEING)
> +               goto out;
> +
>         if (stack_entries) {
>                 memcpy(track->stack_entries, stack_entries,
>                        num_stack_entries * sizeof(stack_entries[0]));
> @@ -301,6 +312,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>         track->cpu = raw_smp_processor_id();
>         track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
>
> +out:
>         /*
>          * Pairs with READ_ONCE() in
>          *      kfence_shutdown_cache(),
> @@ -506,7 +518,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>
>         raw_spin_lock_irqsave(&meta->lock, flags);
>
> -       if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
> +       if (!kfence_obj_allocated(meta) || meta->addr != (unsigned long)addr) {
>                 /* Invalid or double-free, bail out. */
>                 atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
>                 kfence_report_error((unsigned long)addr, false, NULL, meta,
> @@ -784,7 +796,7 @@ static void kfence_check_all_canary(void)
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
>                 struct kfence_metadata *meta = &kfence_metadata[i];
>
> -               if (meta->state == KFENCE_OBJECT_ALLOCATED)
> +               if (kfence_obj_allocated(meta))
>                         check_canary(meta);
>         }
>  }
> @@ -1010,12 +1022,11 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>                  * the lock will not help, as different critical section
>                  * serialization will have the same outcome.
>                  */
> -               if (READ_ONCE(meta->cache) != s ||
> -                   READ_ONCE(meta->state) != KFENCE_OBJECT_ALLOCATED)
> +               if (READ_ONCE(meta->cache) != s || !kfence_obj_allocated(meta))
>                         continue;
>
>                 raw_spin_lock_irqsave(&meta->lock, flags);
> -               in_use = meta->cache == s && meta->state == KFENCE_OBJECT_ALLOCATED;
> +               in_use = meta->cache == s && kfence_obj_allocated(meta);
>                 raw_spin_unlock_irqrestore(&meta->lock, flags);
>
>                 if (in_use) {
> @@ -1160,11 +1171,19 @@ void __kfence_free(void *addr)
>          * the object, as the object page may be recycled for other-typed
>          * objects once it has been freed. meta->cache may be NULL if the cache
>          * was destroyed.
> +        * Save the stack trace here so that reports show where the user freed
> +        * the object.
>          */
> -       if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
> +       if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU))) {
> +               unsigned long flags;
> +
> +               raw_spin_lock_irqsave(&meta->lock, flags);
> +               metadata_update_state(meta, KFENCE_OBJECT_RCU_FREEING, NULL, 0);
> +               raw_spin_unlock_irqrestore(&meta->lock, flags);
>                 call_rcu(&meta->rcu_head, rcu_guarded_free);
> -       else
> +       } else {
>                 kfence_guarded_free(addr, meta, false);
> +       }
>  }
>
>  bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs)
> @@ -1188,14 +1207,14 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>                 int distance = 0;
>
>                 meta = addr_to_metadata(addr - PAGE_SIZE);
> -               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +               if (meta && kfence_obj_allocated(meta)) {
>                         to_report = meta;
>                         /* Data race ok; distance calculation approximate. */
>                         distance = addr - data_race(meta->addr + meta->size);
>                 }
>
>                 meta = addr_to_metadata(addr + PAGE_SIZE);
> -               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +               if (meta && kfence_obj_allocated(meta)) {
>                         /* Data race ok; distance calculation approximate. */
>                         if (!to_report || distance > data_race(meta->addr) - addr)
>                                 to_report = meta;
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index db87a05047bd..dfba5ea06b01 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -38,6 +38,7 @@
>  enum kfence_object_state {
>         KFENCE_OBJECT_UNUSED,           /* Object is unused. */
>         KFENCE_OBJECT_ALLOCATED,        /* Object is currently allocated. */
> +       KFENCE_OBJECT_RCU_FREEING,      /* Object was allocated, and then being freed by rcu. */
>         KFENCE_OBJECT_FREED,            /* Object was allocated, and then freed. */
>  };
>
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 73a6fe42845a..451991a3a8f2 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -114,7 +114,8 @@ static void kfence_print_stack(struct seq_file *seq, const struct kfence_metadat
>
>         /* Timestamp matches printk timestamp format. */
>         seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus (%lu.%06lus ago):\n",
> -                      show_alloc ? "allocated" : "freed", track->pid,
> +                      show_alloc ? "allocated" : meta->state == KFENCE_OBJECT_RCU_FREEING ?
> +                      "rcu freeing" : "freed", track->pid,
>                        track->cpu, (unsigned long)ts_sec, rem_nsec / 1000,
>                        (unsigned long)interval_nsec, rem_interval_nsec / 1000);
>
> @@ -149,7 +150,7 @@ void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *met
>
>         kfence_print_stack(seq, meta, true);
>
> -       if (meta->state == KFENCE_OBJECT_FREED) {
> +       if (meta->state == KFENCE_OBJECT_FREED || meta->state == KFENCE_OBJECT_RCU_FREEING) {
>                 seq_con_printf(seq, "\n");
>                 kfence_print_stack(seq, meta, false);
>         }
> @@ -318,7 +319,7 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *sla
>         kpp->kp_slab_cache = meta->cache;
>         kpp->kp_objp = (void *)meta->addr;
>         kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
> -       if (meta->state == KFENCE_OBJECT_FREED)
> +       if (meta->state == KFENCE_OBJECT_FREED || meta->state == KFENCE_OBJECT_RCU_FREEING)
>                 kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
>         /* get_stack_skipnr() ensures the first entry is outside allocator. */
>         kpp->kp_ret = kpp->kp_stack[0];
> --
> 2.39.3
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240812095517.2357-1-dtcccc%40linux.alibaba.com.

