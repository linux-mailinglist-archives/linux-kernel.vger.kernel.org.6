Return-Path: <linux-kernel+bounces-400760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FE9C11F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565B5B20ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC04218D62;
	Thu,  7 Nov 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VauOJNu/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA7218D94
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019207; cv=none; b=Jj+ogrL9jV4TSyVsPvbzBenOkHlCc9H+2ebW+r5BbQmnB+fLCygG6Euqld93JpAw82cdrcl5osssUPDzjTT+bMhHm46+j2cBvJWISOaZxdwLiJIEb56Iy03zHLeKBvN3pIGlrxa567TvOMX+G0CPuiVV27L3m3BATTFfvD2f0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019207; c=relaxed/simple;
	bh=Zw17VeLesDKacO9ESBlHG8+1mcqZmCC2e3TPVI5dNes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LarN4OJRfQSpMLxja7sVs0Jpo1G9kJxmeEbyFfXvOIjETBkhBpy13Xhv+VjF6e74wWMSYvA7Lkj3xpnpWUtgETTBEcdeUyRknghFPyf9QufLvidmb3VoqRxLPkXPfs3XQEz3/ZnYa3e1M5a3ARZ4HAQZ5SrbaWWbE0xKAXvrIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VauOJNu/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so2482a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731019204; x=1731624004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm9XtGoVZGjDnNc7scPwmrts+2k/UDr2+BKl8zXfWhI=;
        b=VauOJNu/Trg68eeyR2H4S5nVicLAKvUvyWKXMYHFG3v3iTXN5xPPLsTUeLD4sbT2vC
         GXk5UbTirUGAcrQZuoU1EJua/oh460TFdXnvR/MzXzmScgXKcwqkBgSOqQkTewA5XESf
         6EgPVDT8McRbq0lQBYOSRca4NxbNRo3R6zTCwhoJ+psljTKJoQOBZk4NGD0+4EWiyJGw
         39n/wrH5OHas3dlhNRHf32BVIWM2Qqv3UjqL5vLUu69zhpknCVFUiKfDsJ9KDevgjaiz
         XIVd/RbSpIx6qu5liRqaNyyEagrmtQW9EsX/k/iT11xJy/vaUJe3+3yfZbuH/9DWXb5Z
         sHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731019204; x=1731624004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm9XtGoVZGjDnNc7scPwmrts+2k/UDr2+BKl8zXfWhI=;
        b=YtYTfVe5rWtMzoQpMTbMEuZtL7qpzSJqWCEO9cBCORNTFJlsfF0Sr0mEDnohxkE//k
         rambag1GdBMFYDjLNdlJNmWo3/nRzVne5KjQww8zsgfV5RCWGagjF7tjw064BgdghfRq
         cfDhtsrS5yXUZCyGoK1cwOHZy9iuzhV2+aJ9Cy+e5IacS7X+hyKWQpV1Gs69pDkBPU5j
         AvIraWWm+x2vwti+biUmeJ0tjSkdz65o0rOaOn3M1BIGh7q98uXTO/AiDDOobF+KQVd+
         rd/GfmVrsIcAOGxd1DQQIq4Al/yTA4U+r3rP+KtVe7R73aS3yebCtdSGR+N02vpaOuPh
         VCvg==
X-Forwarded-Encrypted: i=1; AJvYcCWQLd7yQdzyE6SJ6GoVkMhiKnNIx/bAShpGzSEEnBmKm1slKUSDjzgfRIkomofKTrGUHyZpJmebxxVRFoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakxnmrvRVLuqdz3mWHhKDDClMkhpip7PA3mK/CNvt9xPU6lRn
	u5sxJFGW8Kgw0n+j8FG1Ix1ClGFp+Kvw5WmkCQ0bhT+79nJn1ZLb08GmniCqXQC+dv/ioeqoDc5
	639XKNhcrPhc3dWrhvXl8riLGfh0btzzlzXr9
X-Gm-Gg: ASbGnct8mPI1dsnWs0OPQeGa3NoweR6Wu0VZj1Q4NKFefUjWJrZOmFU2mm5IrH23pPq
	uwlF9FgYpqXW1GmY4b4dE6GmHxmsE9rN2HpB67REQ6uh4zUU/MFG3ngOl+q8=
X-Google-Smtp-Source: AGHT+IHnaGDzQMWBYcCYG3yaMekZaelSPBjxJdmWZAfVTRJcrb+2r4VRBXTFJH4aU6FmM4Biyjn79l1Uv0V7ZDuPUeg=
X-Received: by 2002:a05:6402:1cb9:b0:5cb:6694:a4bd with SMTP id
 4fb4d7f45d1cf-5cefbc29fdamr843031a12.1.1731019203300; Thu, 07 Nov 2024
 14:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Nov 2024 23:39:27 +0100
Message-ID: <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of
 semi RCU
To: Qi Zheng <zhengqi.arch@bytedance.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+x86 MM maintainers - x86@kernel.org was already cc'ed, but I don't
know if that is enough for them to see it, and I haven't seen them
comment on this series yet; I think you need an ack from them for this
change.

On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
> Now, if CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, the page table page=
s
> will be freed by semi RCU, that is:
>
>  - batch table freeing: asynchronous free by RCU
>  - single table freeing: IPI + synchronous free
>
> In this way, the page table can be lockless traversed by disabling IRQ in
> paths such as fast GUP. But this is not enough to free the empty PTE page
> table pages in paths other that munmap and exit_mmap path, because IPI
> cannot be synchronized with rcu_read_lock() in pte_offset_map{_lock}().
>
> In preparation for supporting empty PTE page table pages reclaimation,
> let single table also be freed by RCU like batch table freeing. Then we
> can also use pte_offset_map() etc to prevent PTE page from being freed.

I applied your series locally and followed the page table freeing path
that the reclaim feature would use on x86-64. Looks like it goes like
this with the series applied:

free_pte
  pte_free_tlb
    __pte_free_tlb
      ___pte_free_tlb
        paravirt_tlb_remove_table
          tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
            [no-free-memory slowpath:]
              tlb_table_invalidate
              tlb_remove_table_one
                tlb_remove_table_sync_one [does IPI for GUP-fast]
                __tlb_remove_table_one [frees via RCU]
            [fastpath:]
              tlb_table_flush
                tlb_remove_table_free [frees via RCU]
          native_tlb_remove_table [CONFIG_PARAVIRT on native]
            tlb_remove_table [see above]

Basically, the only remaining case in which
paravirt_tlb_remove_table() does not use tlb_remove_table() with RCU
delay is !CONFIG_PARAVIRT && !CONFIG_PT_RECLAIM. Given that
CONFIG_PT_RECLAIM is defined as "default y" when supported, I guess
that means X86's direct page table freeing path will almost never be
used? If it stays that way and the X86 folks don't see a performance
impact from using RCU to free tables on munmap() / process exit, I
guess we might want to get rid of the direct page table freeing path
on x86 at some point to simplify things...

(That simplification might also help prepare for Intel Remote Action
Request, if that is a thing people want...)

> Like pte_free_defer(), we can also safely use ptdesc->pt_rcu_head to free
> the page table pages:
>
>  - The pt_rcu_head is unioned with pt_list and pmd_huge_pte.
>
>  - For pt_list, it is used to manage the PGD page in x86. Fortunately
>    tlb_remove_table() will not be used for free PGD pages, so it is safe
>    to use pt_rcu_head.
>
>  - For pmd_huge_pte, we will do zap_deposited_table() before freeing the
>    PMD page, so it is also safe.

Please also update the comments on "struct ptdesc" accordingly.

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/x86/include/asm/tlb.h | 19 +++++++++++++++++++
>  arch/x86/kernel/paravirt.c |  7 +++++++
>  arch/x86/mm/pgtable.c      | 10 +++++++++-
>  mm/mmu_gather.c            |  9 ++++++++-
>  4 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 580636cdc257b..e223b53a8b190 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -34,4 +34,23 @@ static inline void __tlb_remove_table(void *table)
>         free_page_and_swap_cache(table);
>  }
>
> +#ifdef CONFIG_PT_RECLAIM
> +static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
> +{
> +       struct page *page;
> +
> +       page =3D container_of(head, struct page, rcu_head);
> +       free_page_and_swap_cache(page);
> +}

Why free_page_and_swap_cache()? Page tables shouldn't have swap cache,
so I think something like put_page() would do the job.

> +static inline void __tlb_remove_table_one(void *table)
> +{
> +       struct page *page;
> +
> +       page =3D table;
> +       call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
> +}
> +#define __tlb_remove_table_one __tlb_remove_table_one
> +#endif /* CONFIG_PT_RECLAIM */
> +
>  #endif /* _ASM_X86_TLB_H */
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index fec3815335558..89688921ea62e 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -59,10 +59,17 @@ void __init native_pv_lock_init(void)
>                 static_branch_enable(&virt_spin_lock_key);
>  }
>
> +#ifndef CONFIG_PT_RECLAIM
>  static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
>  {
>         tlb_remove_page(tlb, table);
>  }
> +#else
> +static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
> +{
> +       tlb_remove_table(tlb, table);
> +}
> +#endif
>
>  struct static_key paravirt_steal_enabled;
>  struct static_key paravirt_steal_rq_enabled;
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 5745a354a241c..69a357b15974a 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -19,12 +19,20 @@ EXPORT_SYMBOL(physical_mask);
>  #endif
>
>  #ifndef CONFIG_PARAVIRT
> +#ifndef CONFIG_PT_RECLAIM
>  static inline
>  void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
>  {
>         tlb_remove_page(tlb, table);
>  }
> -#endif
> +#else
> +static inline
> +void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
> +{
> +       tlb_remove_table(tlb, table);
> +}
> +#endif /* !CONFIG_PT_RECLAIM */
> +#endif /* !CONFIG_PARAVIRT */
>
>  gfp_t __userpte_alloc_gfp =3D GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
>
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 99b3e9408aa0f..d948479ca09e6 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -311,10 +311,17 @@ static inline void tlb_table_invalidate(struct mmu_=
gather *tlb)
>         }
>  }
>
> +#ifndef __tlb_remove_table_one
> +static inline void __tlb_remove_table_one(void *table)
> +{
> +       __tlb_remove_table(table);
> +}
> +#endif
> +
>  static void tlb_remove_table_one(void *table)
>  {
>         tlb_remove_table_sync_one();
> -       __tlb_remove_table(table);
> +       __tlb_remove_table_one(table);
>  }
>
>  static void tlb_table_flush(struct mmu_gather *tlb)
> --
> 2.20.1
>

