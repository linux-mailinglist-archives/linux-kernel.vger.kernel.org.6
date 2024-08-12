Return-Path: <linux-kernel+bounces-282745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC294E815
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379132827E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0915C13A;
	Mon, 12 Aug 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4DOEm3h"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E213E40F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449025; cv=none; b=GBZkwsC0iVsMwU2Pu1W5RvwxOTlRkMUQ76w1FTf5jaJQ2GH9ZpaAx7LAejYRo4Kfbdm0rMCmlxwklqMEOwE8gpaCb9x35cVID3VKOfm11oQiGcSkse8+LCkMQVGCjMGsX/9pO7ZSLexlUIF2VggQ0EQpa6Y9BiY4PPMfPgrP9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449025; c=relaxed/simple;
	bh=DMXURrSII8qfDi/svNeUQKdI98djREy+IM3T7wiSyU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA7/oblXuIy1TzpH62uuPuYVvXT40lLhNUD7G0gloRzL8L9DqVp5fpmHLvoFLlXm3t4RWwzq9QDxW+eH+e/Ppzc91vNrzmVgahkOACleZ5pADc5/LUX5yOxNBH3bUhibp2nS0Spu/NN0tiiAMFbcQ1v7m5ER7XC3Ih1u/ZRHvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4DOEm3h; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso1426338e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723449022; x=1724053822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNeSHIzdgWmMCemefh68BQT/5kHreTgtwMQZzfT5sLM=;
        b=G4DOEm3hlr8gbIOppeYmKtno6WfhvEzBz/fSZ2iGe2drtE+Keky5zj1d3ONZaLWj9A
         5qNAhjrwb6urJhw7WQw8ga2moWG/9TiJtcOz9fNqtR7RJdLTKt2gGxTtfGFsQuQlK2pY
         vcpVnv1JevFqE2GWfW2IAevsN4YtaraAFMXnzQK3uQZGHftJ0k6QzhWUU8/0mSRd6T/w
         LdiLpr7RLLy7Ycq2RT9TC4eC0TSjwNJRU56kNASxDfRGiEv+7YeXq1FYTbM0GwGRVtDC
         tnvlTCElpQJk/f+HVJf1Pr4/T1QvAqp8IQGQhSuwmxlZULcx0NjfxM00INsuP5JO72u8
         E7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723449022; x=1724053822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNeSHIzdgWmMCemefh68BQT/5kHreTgtwMQZzfT5sLM=;
        b=sDjk70sz8xo3CuKi5qMuG8mc/QQMecfg2wzwPcYfX8x+XzmyLkyA0B09GcyDVc/GQs
         2VLtJD9NXNs0U9BUb0xRViV2uYQBCJ+OjcoG41FX5N0U1nFZtthj3vC8hDHvoMIlDeWC
         ZOVjSLUn0EPuc9fNIwKjOzEcTR19DsZh0km9THlf9vI+/hvneg7cj2UVkxolL/Q8rjCV
         Z/J+N+3zy9S9C46ZEPcmGNuPA06Km1I5ND885hw0KC2wN1Re0EPS9xbmX+XpuzdJj2i1
         jD/HxELK9prZiB+mgTx+SW9hlXAIc9N02+Fko8Q7AtmWiE72h7eXhihg/dAozeSz5ogR
         15Lg==
X-Gm-Message-State: AOJu0Yyc590HxJmCePknzj3+l8nyUffPF8vBVrzgCkhFkN/6YEdQw9Le
	15OON4B25Jwk3gWqhL2RQcXery/BnL0q8EkWIP07/wYG+HH2Pmt/n/WxVZzgrYc/Ggr//raBe+p
	M1tcGUf8c4Ibld25OO/75DAMh7/JsxLfUhtIE
X-Google-Smtp-Source: AGHT+IHTJnjUSPBN+CfGx+G5M2Z5lfVPzD8EIRYV5yFos8rnXRJ6CM7SH4G6bx4AVIh64bgFcr45GIZSGR6RtRfBdb0=
X-Received: by 2002:a05:6122:3d0b:b0:4ef:5b2c:df41 with SMTP id
 71dfb90a1353d-4f913064ca6mr11172513e0c.9.1723449021974; Mon, 12 Aug 2024
 00:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812065947.6104-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20240812065947.6104-1-dtcccc@linux.alibaba.com>
From: Marco Elver <elver@google.com>
Date: Mon, 12 Aug 2024 09:49:45 +0200
Message-ID: <CANpmjNPT5nm7vMiBXgf2b2EuCcyfM2hNKP=Cro0Vjo9qngS5aw@mail.gmail.com>
Subject: Re: [PATCH] kfence: Save freeing stack trace at calling time instead
 of freeing time
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Aug 2024 at 09:00, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
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
> ---
> I'm not sure whether we should keep KFENCE_OBJECT_FREED info remained
> (maybe the exact free time can be helpful?). But add a new kfence_track
> will cost more memory, so I prefer to reuse free_track and drop the info
> when when KFENCE_OBJECT_RCU_FREEING -> KFENCE_OBJECT_FREED.

I think the current version is fine. In the SLAB_TYPESAFE_BY_RCU cases
it would always print the stack trace of RCU internals, so it's never
really useful (as you say above).

Have you encountered a bug where you were debugging a UAF like this?
If not, what prompted you to send this patch?

Did you run the KFENCE test suite?

> ---
>  mm/kfence/core.c   | 35 ++++++++++++++++++++++++++---------
>  mm/kfence/kfence.h |  1 +
>  mm/kfence/report.c |  7 ++++---
>  3 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c5cb54fc696d..89469d4f2d95 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -269,6 +269,13 @@ static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *m
>         return pageaddr;
>  }
>
> +static bool kfence_obj_inuse(const struct kfence_metadata *meta)

Other tiny helpers add "inline" so that the compiler is more likely to
inline this. In optimized kernels it should do so by default, but with
some heavily instrumented kernels we need to lower the inlining
threshold - adding "inline" does that.

Also, note we have KFENCE_OBJECT_UNUSED state, so the
kfence_obj_inuse() helper name would suggest to me that it's all other
states.

If the object is being freed with RCU, it is still technically
allocated and _usable_ until the next RCU grace period. So maybe
kfence_obj_allocated() is a more accurate name?

> +{
> +       enum kfence_object_state state = READ_ONCE(meta->state);
> +
> +       return state == KFENCE_OBJECT_ALLOCATED || state == KFENCE_OBJECT_RCU_FREEING;
> +}
> +
>  /*
>   * Update the object's metadata state, including updating the alloc/free stacks
>   * depending on the state transition.
> @@ -278,10 +285,14 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
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
> @@ -297,6 +308,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>         track->cpu = raw_smp_processor_id();
>         track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
>
> +out:
>         /*
>          * Pairs with READ_ONCE() in
>          *      kfence_shutdown_cache(),
> @@ -502,7 +514,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>
>         raw_spin_lock_irqsave(&meta->lock, flags);
>
> -       if (meta->state != KFENCE_OBJECT_ALLOCATED || meta->addr != (unsigned long)addr) {
> +       if (!kfence_obj_inuse(meta) || meta->addr != (unsigned long)addr) {
>                 /* Invalid or double-free, bail out. */
>                 atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
>                 kfence_report_error((unsigned long)addr, false, NULL, meta,
> @@ -780,7 +792,7 @@ static void kfence_check_all_canary(void)
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
>                 struct kfence_metadata *meta = &kfence_metadata[i];
>
> -               if (meta->state == KFENCE_OBJECT_ALLOCATED)
> +               if (kfence_obj_inuse(meta))
>                         check_canary(meta);
>         }
>  }
> @@ -1006,12 +1018,11 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>                  * the lock will not help, as different critical section
>                  * serialization will have the same outcome.
>                  */
> -               if (READ_ONCE(meta->cache) != s ||
> -                   READ_ONCE(meta->state) != KFENCE_OBJECT_ALLOCATED)
> +               if (READ_ONCE(meta->cache) != s || !kfence_obj_inuse(meta))
>                         continue;
>
>                 raw_spin_lock_irqsave(&meta->lock, flags);
> -               in_use = meta->cache == s && meta->state == KFENCE_OBJECT_ALLOCATED;
> +               in_use = meta->cache == s && kfence_obj_inuse(meta);
>                 raw_spin_unlock_irqrestore(&meta->lock, flags);
>
>                 if (in_use) {
> @@ -1145,6 +1156,7 @@ void *kfence_object_start(const void *addr)
>  void __kfence_free(void *addr)
>  {
>         struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +       unsigned long flags;

This flags variable does not need to be scoped for the whole function.
It can just be scoped within the if-branch where it's needed (at least
I don't see other places besides there where it's used).

>  #ifdef CONFIG_MEMCG
>         KFENCE_WARN_ON(meta->obj_exts.objcg);
> @@ -1154,9 +1166,14 @@ void __kfence_free(void *addr)
>          * the object, as the object page may be recycled for other-typed
>          * objects once it has been freed. meta->cache may be NULL if the cache
>          * was destroyed.
> +        * Save the stack trace here. It is more useful.

"It is more useful." adds no value to the comment.

I would say something like: "Save the stack trace here so that reports
show where the user freed the object."

>          */
> -       if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU)))
> +       if (unlikely(meta->cache && (meta->cache->flags & SLAB_TYPESAFE_BY_RCU))) {
> +               raw_spin_lock_irqsave(&meta->lock, flags);
> +               metadata_update_state(meta, KFENCE_OBJECT_RCU_FREEING, NULL, 0);
> +               raw_spin_unlock_irqrestore(&meta->lock, flags);
>                 call_rcu(&meta->rcu_head, rcu_guarded_free);
> +       }

Wrong if-else style. Turn the whole thing into

if (...) {
   ...
} else {
  kfence_guarded_free(...);
}

So it looks balanced.

>         else
>                 kfence_guarded_free(addr, meta, false);
>  }
> @@ -1182,14 +1199,14 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>                 int distance = 0;
>
>                 meta = addr_to_metadata(addr - PAGE_SIZE);
> -               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +               if (meta && kfence_obj_inuse(meta)) {
>                         to_report = meta;
>                         /* Data race ok; distance calculation approximate. */
>                         distance = addr - data_race(meta->addr + meta->size);
>                 }
>
>                 meta = addr_to_metadata(addr + PAGE_SIZE);
> -               if (meta && READ_ONCE(meta->state) == KFENCE_OBJECT_ALLOCATED) {
> +               if (meta && kfence_obj_inuse(meta)) {
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240812065947.6104-1-dtcccc%40linux.alibaba.com.

