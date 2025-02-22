Return-Path: <linux-kernel+bounces-527505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E53DA40C16
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D20E18962E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263A204594;
	Sat, 22 Feb 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZFI4kg9"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2E1FBC9F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265736; cv=none; b=jKZVEp+FEJDusDjEHOUfvs0o5KlyLQtcPksl6oa5dtHVaUhXHa4/wiDpj0ArnQa+b/lM7c4Yw2/3CS8OX7HcMnqNv45ECVdbGD/+LwmM5CZenrbtygQAFj30rYuaezy6h5wEOZ9Owm1rXWxOhw8VQNyXzyX+1DWAZgQcPJtgwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265736; c=relaxed/simple;
	bh=DBUvfpa2sUtiN7jBdOm63BFjitId/hds2JyQRSjgDLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbmORFL/Ftp3tAZdWyKUcHc3MypBSxWEidrZ/9lsH7iZ/BHJhRVl8f17Qexo3hRKFE+HTpVfGKGk/7dX+8+s/1G3N+LBuj73AKrVKYjCm3lVK1Hffsi+UN7mlIqxROkRK5OY5i5s7CtJkPxkvOkHoxCzQwcWq7pz3+aIquQgpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZFI4kg9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472098e6e75so220271cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740265734; x=1740870534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Th+w5zeXQufZOVmAeN72xK4zjFpK20IFV72ncsNhk0=;
        b=aZFI4kg9TbjDuTeQtRkwLOqNMu2DPcDwCjbaGwVRf1Y0E5Oy9rQwwzTCTqtmuGklDZ
         sn2QHc4sCJj2Vnu1Cw5MVZ356hFlBH2gQAb1pT9CjcosZdPAnRcR6ba6nebOfPmeLMWF
         IHd5snfJdYqnslXTAgk9t/2eRer1wtS8j/jIy6wMuPXmpZPlr3CIPQ19hp66RlybNRcJ
         +Py5wMRV2PsylxVF6SrG6OYBCOHDHaxDAlOBddImnyAuyLQrLsSBu67ND+piCd4xtKHQ
         Ub0U5BTG1bGxbczapLcutRpr9b1QapZGIyuTnyxMzQ6Q4oE8MMkaxB8l9otXXcnmOsIo
         8hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740265734; x=1740870534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Th+w5zeXQufZOVmAeN72xK4zjFpK20IFV72ncsNhk0=;
        b=ekFPIiYtN6G1gEXiy4X0R0orM31/gntodiqZ3oArs4vbM2056znW5Q8sEoBIQRI0Gc
         QVe/mMmytXOhUN0QUFfi0OP7CCYKa/YaSna45HFDaJWMeafu59+aN9uYRuPPgmwr6cGB
         Cay4FZpcYtAwvSDvZacGZNwBus2dJmGL3V9tC/jVv3sj3PhSuxC45KZIIPfnYYlzh2uY
         L/VAWeBnwPI6IXLdoIms5FmQcr6YGGS/nuOyFPXInyC4ssjIqfXXGN3EhZKyXPYhZ/+h
         uL/Bm/MTI2fnAuqQ7ySsxjTwHwUSwB9yeCv+mTWixBRyfmmQu4uTSM6uN11U2ZU+onuf
         7y2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWljXz7vU/cedk3LctNGIE0gi01owwDsLe7Z87J3b0YmVzLm7BrNEGsDwRWQ3mwLTNnX6CgjiYy66nVq98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWeNWoxsVzarl14tVmYK3h+IXEwgPXmuScQn+9Emk+fUvXtaB
	cOSv6f9w6DcTT6TzsEiQlMYryuuA1Y+WHajv8YfjenRGFWdRJIWfutYCYwCSJ9/mUIF6cFjtyNg
	+g5qdYjmdoi3kJELCHp+dI0DrGOjnBsePC1ub
X-Gm-Gg: ASbGncuJ7hox4U2dDytQ+fIDD5kSYw40jIiXbF0HiEQNxrZMDIXdNMvmI54c8Qc96S3
	t6LNtYVJFpfTTrKJAmb65TX3d7u52ZDSe+Bkk8yL70esLfEx26ZpnBbHM7yU1e/T91pUlXalZ2P
	+LJR1b5iA=
X-Google-Smtp-Source: AGHT+IGNmc3p+y2LRfccUPqS/dEYqzeVeZnJMCY+O0oWmFmdfIWdyts0kUci8NBzSSMS6XMIVzXdNfQnoRCVW8gkc6s=
X-Received: by 2002:a05:622a:1306:b0:467:7c30:3446 with SMTP id
 d75a77b69052e-47234cc8f6cmr2083641cf.25.1740265733382; Sat, 22 Feb 2025
 15:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-2-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 15:08:42 -0800
X-Gm-Features: AWEUYZmJu6rhsB0CYiL4W_PcRtfIH2WDT70rCYAHCu0JXCyZCkXAvuLC2iVFtIE
Message-ID: <CAJuCfpH+sKs6j02j_hFALTT=ccrGXkny1=aUvuHZKKjtgr1fmA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/10] slab: add sheaf support for batching
 kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
>
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put in in the barn, or flush to slab pages using bulk free,

s/in in/it in

> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
>
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() machinery.
>
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
>
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too?
>
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab.h        |   2 +
>  mm/slab_common.c |  21 ++++++++
>  mm/slub.c        | 151 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  3 files changed, 170 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 8daaec53b6ecfc44171191d421adb12e5cba2c58..94e9959e1aefa350d3d74e3f5=
309fde7a5cf2ec8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cach=
e *s)
>         return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACC=
OUNT));
>  }
>
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> +
>  /* Legal flag mask for kmem_cache_create(), for various configurations *=
/
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ceeefb287899a82f30ad79b403556001c1860311..c6853450ed74160cfcb497c09=
f92c1f9f7b12629 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1613,6 +1613,24 @@ static void kfree_rcu_work(struct work_struct *wor=
k)
>                 kvfree_rcu_list(head);
>  }
>
> +static bool kfree_rcu_sheaf(void *obj)
> +{
> +       struct kmem_cache *s;
> +       struct folio *folio;
> +       struct slab *slab;
> +
> +       folio =3D virt_to_folio(obj);
> +       if (unlikely(!folio_test_slab(folio)))
> +               return false;
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +       if (s->cpu_sheaves)
> +               return __kfree_rcu_sheaf(s, obj);
> +
> +       return false;
> +}
> +
>  static bool
>  need_offload_krc(struct kfree_rcu_cpu *krcp)
>  {
> @@ -1957,6 +1975,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>         if (!head)
>                 might_sleep();
>
> +       if (kfree_rcu_sheaf(ptr))
> +               return;
> +
>         // Queue the object but don't yet schedule the batch.
>         if (debug_rcu_head_queue(ptr)) {
>                 // Probable double kfree_rcu(), just leak.
> diff --git a/mm/slub.c b/mm/slub.c
> index c06734912972b799f537359f7fe6a750918ffe9e..40175747212fefb27137309b2=
7571abe8d0966e2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -350,6 +350,8 @@ enum stat_item {
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
>         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
>         FREE_PCS,               /* Free to percpu sheaf */
> +       FREE_RCU_SHEAF,         /* Free to rcu_free sheaf */
> +       FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>         FREE_FROZEN,            /* Freeing to frozen slab */
> @@ -2569,6 +2571,24 @@ static void sheaf_flush(struct kmem_cache *s, stru=
ct slab_sheaf *sheaf)
>         sheaf->size =3D 0;
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf);
> +
> +static void rcu_free_sheaf_nobarn(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +       s =3D sheaf->cache;

Ah, that's where you are using sheaf->cache. Maybe you should
introduce it in this patch?

> +
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       sheaf_flush(s, sheaf);
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
>  /*
>   * Caller needs to make sure migration is disabled in order to fully flu=
sh
>   * single cpu's sheaves
> @@ -2598,8 +2618,8 @@ static void pcs_flush_all(struct kmem_cache *s)
>                 free_empty_sheaf(s, spare);
>         }
>
> -       // TODO: handle rcu_free
> -       BUG_ON(rcu_free);
> +       if (rcu_free)
> +               call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
>
>         sheaf_flush_main(s);
>  }
> @@ -2616,8 +2636,10 @@ static void __pcs_flush_all_cpu(struct kmem_cache =
*s, unsigned int cpu)
>                 pcs->spare =3D NULL;
>         }
>
> -       // TODO: handle rcu_free
> -       BUG_ON(pcs->rcu_free);
> +       if (pcs->rcu_free) {
> +               call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn)=
;
> +               pcs->rcu_free =3D NULL;
> +       }
>
>         sheaf_flush_main(s);
>  }
> @@ -5192,6 +5214,118 @@ void free_to_pcs(struct kmem_cache *s, void *obje=
ct)
>         stat(s, FREE_PCS);
>  }
>
> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> +                                    struct slab_sheaf *sheaf)
> +{
> +       bool init =3D slab_want_init_on_free(s);
> +       void **p =3D &sheaf->objects[0];
> +       unsigned int i =3D 0;
> +
> +       while (i < sheaf->size) {
> +               struct slab *slab =3D virt_to_slab(p[i]);
> +
> +               memcg_slab_free_hook(s, slab, p + i, 1);
> +               alloc_tagging_slab_free_hook(s, slab, p + i, 1);
> +
> +               if (unlikely(!slab_free_hook(s, p[i], init, false))) {
> +                       p[i] =3D p[--sheaf->size];
> +                       continue;
> +               }
> +
> +               i++;
> +       }
> +}
> +
> +static void rcu_free_sheaf(struct rcu_head *head)
> +{
> +       struct slab_sheaf *sheaf;
> +       struct node_barn *barn;
> +       struct kmem_cache *s;
> +
> +       sheaf =3D container_of(head, struct slab_sheaf, rcu_head);
> +
> +       s =3D sheaf->cache;
> +
> +       __rcu_free_sheaf_prepare(s, sheaf);
> +
> +       barn =3D get_node(s, numa_mem_id())->barn;
> +
> +       /* due to slab_free_hook() */
> +       if (unlikely(sheaf->size =3D=3D 0))
> +               goto empty;
> +
> +       if (!barn_put_full_sheaf(barn, sheaf, false))
> +               return;
> +
> +       sheaf_flush(s, sheaf);
> +
> +empty:
> +       if (!barn_put_empty_sheaf(barn, sheaf, false))
> +               return;
> +
> +       free_empty_sheaf(s, sheaf);
> +}
> +
> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> +{
> +       struct slub_percpu_sheaves *pcs;
> +       struct slab_sheaf *rcu_sheaf;
> +       unsigned long flags;
> +
> +       local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +       pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +       if (unlikely(!pcs->rcu_free)) {
> +
> +               struct slab_sheaf *empty;
> +
> +               empty =3D barn_get_empty_sheaf(pcs->barn);
> +
> +               if (empty) {
> +                       pcs->rcu_free =3D empty;
> +                       goto do_free;
> +               }
> +
> +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +
> +               empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> +
> +               if (!empty) {
> +                       stat(s, FREE_RCU_SHEAF_FAIL);
> +                       return false;
> +               }
> +
> +               local_lock_irqsave(&s->cpu_sheaves->lock, flags);
> +               pcs =3D this_cpu_ptr(s->cpu_sheaves);
> +
> +               if (unlikely(pcs->rcu_free))
> +                       barn_put_empty_sheaf(pcs->barn, empty, true);
> +               else
> +                       pcs->rcu_free =3D empty;
> +       }
> +
> +do_free:
> +
> +       rcu_sheaf =3D pcs->rcu_free;
> +
> +       rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
> +
> +       if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> +               local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +               stat(s, FREE_RCU_SHEAF);
> +               return true;
> +       }
> +
> +       pcs->rcu_free =3D NULL;
> +       local_unlock_irqrestore(&s->cpu_sheaves->lock, flags);
> +
> +       call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +
> +       stat(s, FREE_RCU_SHEAF);
> +
> +       return true;
> +}
> +
>  /*
>   * Bulk free objects to the percpu sheaves.
>   * Unlike free_to_pcs() this includes the calls to all necessary hooks
> @@ -6522,6 +6656,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         struct kmem_cache_node *n;
>
>         flush_all_cpus_locked(s);
> +
> +       /* we might have rcu sheaves in flight */
> +       if (s->cpu_sheaves)
> +               rcu_barrier();
> +
>         /* Attempt to free all objects */
>         for_each_kmem_cache_node(s, node, n) {
>                 if (n->barn)
> @@ -7927,6 +8066,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
>  STAT_ATTR(FREE_PCS, free_cpu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
> +STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_FROZEN, free_frozen);
> @@ -8022,6 +8163,8 @@ static struct attribute *slab_attrs[] =3D {
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
>         &free_cpu_sheaf_attr.attr,
> +       &free_rcu_sheaf_attr.attr,
> +       &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_frozen_attr.attr,
>
> --
> 2.48.1
>

