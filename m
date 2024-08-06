Return-Path: <linux-kernel+bounces-276566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63181949555
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3B91F25828
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D136124;
	Tue,  6 Aug 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8uuWB1r"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B6DF71
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960842; cv=none; b=ONhNgp1nG0QCU7d/StNbXKJvj1YEUWjz1GgEI3tSKMF1C/Tu0yT1UOLqR0ThqMTi1bDk/HaWoQGBYV2WvMnMumnSLq7+F5e2uQ7Wbub+jwgiZO3FQmT4VkYmDFsX5EnWF2JNBptflNaEoSbr5Y+PXq3zxOKLrrc1litmgn3GoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960842; c=relaxed/simple;
	bh=9rfWxmaQdCuJldr9R81UXATYIvKwfKmV1awJwd6fJ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIUxMH4OgqNC86T+wRBj62pbBMkjybkfLd6h1UHS777Xc52S7Q3MPf81UpyEYYHNhKdjTMFOH3gbBbRPmlqTgRqDYYn9SnVNgv1fYJsQJ/AII0+3pesPQv01DVUJZ1Ur9th5NVGSGshuDsEg6chF1TT/l2/khTnxFWpxvqGeqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8uuWB1r; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0bf9602db6so810924276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722960839; x=1723565639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flHyanDSyOW3E9RQeJ9pSCPkgNyeeM0BzJyFB+YwtSQ=;
        b=D8uuWB1r70Y0tGxUZsOmux4I8zAM17Eq5TVg2kuTuGj6xzG6FQQO6w330j+zTuktE6
         d3nPi0w232da5oips2bHE/tJt1se/HekoJ+j/nL69/xkPDbuuAssZ5X2Nk2MDMHpw2jj
         mxtObIObmC95KKEMRjTx9mgxVbGF3LIfwaFR3TX1jC0I7z5cqb3YdIzaf0wlF2Cs+7nZ
         +P8cW8w4SZSPXe9jSwBU+Wpw41bLyBgWUvedD0nLRBeYq4n1o60V74+CMutjiSVwTlKN
         IqyF1VRy692CoN85RhumLHtrJgS8/xrXSalRDio+68GgI/b4Gm9VjHqEp87OVkwGNOCK
         jEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960839; x=1723565639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flHyanDSyOW3E9RQeJ9pSCPkgNyeeM0BzJyFB+YwtSQ=;
        b=Ex9qQ6cWyT6TwqRi59Z37aOJEVQcKONFpbTLKycQJzFP91GLqndZKlcKSLJ+PpxYIO
         hATuSmf6A8BnQmeNtKtxqPr4TJ1JhYzl7CpmVqXZk7b8eoTBHoL2mFKzPsztnR2mxwCa
         bQnDmC7TMM7Yy/b7lnLVk7hZDqPjj7MBMWmxP+D0rHgmA0j/V0opTHT0rnp+9vi6FsmG
         mfQ4oapum3XBkXHFTehDzrW/XZnvypy9qzEwM0jjL+XkqhmXlEbuUFYQ6+5HsHcXzhps
         NVHh7KwKk5iM30a0KSfRhQ/53Ez5b2JrDjmv+udSz5pkltp3dPoTNHi+/YyeDOUZBthV
         jsbg==
X-Forwarded-Encrypted: i=1; AJvYcCUXWvm5U10kjEXe5xSEbcDUZwEYlNZz+UBlcBMLsIyM8bHvDR8qs/utJktS7hEnPYp9Tay3vf2h+gimAucrvkqdouatVFsp1N2QkKUz
X-Gm-Message-State: AOJu0Yyvpp/4PHYlygbwJPD6ToTEJirhLOJVLB3May6rOJUKRTBmvrws
	3eg0oEjtmfhEPVMzPdfJ4GBh2ZwMOfjEDPpHcWUHVJHdJW/2MKI7t6haGvHtuPoA8wRsDAGQ6OG
	u1o5hQ5JyLVcYBEZIcPDTQgEWsaime0wCeVhl
X-Google-Smtp-Source: AGHT+IFIR7KB3qC95IwE99Ecy1X9S4TKWbi7I5lgIk7hVv/EXJ2eNsSamr8zi6SVuWSu0NNUtVbJv6C43PAZ39oOiJ8=
X-Received: by 2002:a25:918a:0:b0:e0b:c402:b03f with SMTP id
 3f1490d57ef6-e0bde34c22dmr12985019276.27.1722960838924; Tue, 06 Aug 2024
 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-fix-vma-lock-type-confusion-v1-1-9f25443a9a71@google.com>
In-Reply-To: <20240805-fix-vma-lock-type-confusion-v1-1-9f25443a9a71@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 Aug 2024 09:13:45 -0700
Message-ID: <CAJuCfpEy1QV-9uTUtrFvN-6eS5KFw-ZyQothQbLqXFyUaJ4xgQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix (harmless) type confusion in lock_vma_under_rcu()
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:52=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> There is a (harmless) type confusion in lock_vma_under_rcu():
> After vma_start_read(), we have taken the VMA lock but don't know yet
> whether the VMA has already been detached and scheduled for RCU freeing.
> At this point, ->vm_start and ->vm_end are accessed.
>
> vm_area_struct contains a union such that ->vm_rcu uses the same memory a=
s
> ->vm_start and ->vm_end; so accessing ->vm_start and ->vm_end of a detach=
ed
> VMA is illegal and leads to type confusion between union members.
>
> Fix it by reordering the vma->detached check above the address checks, an=
d
> document the rules for RCU readers accessing VMAs.
>
> This will probably change the number of observed VMA_LOCK_MISS events
> (since previously, trying to access a detached VMA whose ->vm_rcu has bee=
n
> scheduled would bail out when checking the fault address against the
> rcu_head members reinterpreted as VMA bounds).
>
> Fixes: 50ee32537206 ("mm: introduce lock_vma_under_rcu to be used from ar=
ch-specific code")
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for fixing this subtle issue and clearly documenting the rules!
Not sure if we should CC stable? It is harmless but it's still a bug...

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> sidenote: I'm not entirely sure why we handle detached VMAs and moved
> VMAs differently here (detached VMAs retry, moved VMAs bail out), but
> that's kinda out of scope of this patch.

Yeah, technically in both cases the address space is being modified
and we should bail out and retry with mmap_lock. I just think if the
VMA got replaced while we are calling lock_vma_under_rcu(), it's
reasonable to retry the search and try finding the new VMA if it's
already established and unlocked.

> ---
>  include/linux/mm_types.h | 15 +++++++++++++--
>  mm/memory.c              | 14 ++++++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 485424979254..498cdf3121d0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -657,58 +657,69 @@ struct vma_numab_state {
>
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
>   * space that has a special rule for the page-fault handlers (ie a share=
d
>   * library, the executable area etc).
> + *
> + * Only explicitly marked struct members may be accessed by RCU readers =
before
> + * getting a stable reference.
>   */
>  struct vm_area_struct {
>         /* The first cache line has the info for VMA tree walking. */
>
>         union {
>                 struct {
>                         /* VMA covers [vm_start; vm_end) addresses within=
 mm */
>                         unsigned long vm_start;
>                         unsigned long vm_end;
>                 };
>  #ifdef CONFIG_PER_VMA_LOCK
>                 struct rcu_head vm_rcu; /* Used for deferred freeing. */
>  #endif
>         };
>
> -       struct mm_struct *vm_mm;        /* The address space we belong to=
. */
> +       /*
> +        * The address space we belong to.
> +        * Unstable RCU readers are allowed to read this.
> +        */
> +       struct mm_struct *vm_mm;
>         pgprot_t vm_page_prot;          /* Access permissions of this VMA=
. */
>
>         /*
>          * Flags, see mm.h.
>          * To modify use vm_flags_{init|reset|set|clear|mod} functions.
>          */
>         union {
>                 const vm_flags_t vm_flags;
>                 vm_flags_t __private __vm_flags;
>         };
>
>  #ifdef CONFIG_PER_VMA_LOCK
> -       /* Flag to indicate areas detached from the mm->mm_mt tree */
> +       /*
> +        * Flag to indicate areas detached from the mm->mm_mt tree.
> +        * Unstable RCU readers are allowed to read this.
> +        */
>         bool detached;
>
>         /*
>          * Can only be written (using WRITE_ONCE()) while holding both:
>          *  - mmap_lock (in write mode)
>          *  - vm_lock->lock (in write mode)
>          * Can be read reliably while holding one of:
>          *  - mmap_lock (in read or write mode)
>          *  - vm_lock->lock (in read or write mode)
>          * Can be read unreliably (using READ_ONCE()) for pessimistic bai=
lout
>          * while holding nothing (except RCU to keep the VMA struct alloc=
ated).
>          *
>          * This sequence counter is explicitly allowed to overflow; seque=
nce
>          * counter reuse can only lead to occasional unnecessary use of t=
he
>          * slowpath.
>          */
>         int vm_lock_seq;
> +       /* Unstable RCU readers are allowed to read this. */
>         struct vma_lock *vm_lock;
>  #endif
>
>         /*
>          * For areas with an address space and backing store,
>          * linkage into the address_space->i_mmap interval tree.
> diff --git a/mm/memory.c b/mm/memory.c
> index 34f8402d2046..3f4232b985a1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5996,23 +5996,29 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
>         if (!vma)
>                 goto inval;
>
>         if (!vma_start_read(vma))
>                 goto inval;
>
> -       /* Check since vm_start/vm_end might change before we lock the VM=
A */
> -       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> -               goto inval_end_read;
> -
>         /* Check if the VMA got isolated after we found it */
>         if (vma->detached) {
>                 vma_end_read(vma);
>                 count_vm_vma_lock_event(VMA_LOCK_MISS);
>                 /* The area was replaced with another one */
>                 goto retry;
>         }
> +       /*
> +        * At this point, we have a stable reference to a VMA: The VMA is
> +        * locked and we know it hasn't already been isolated.
> +        * From here on, we can access the VMA without worrying about whi=
ch
> +        * fields are accessible for RCU readers.
> +        */
> +
> +       /* Check since vm_start/vm_end might change before we lock the VM=
A */
> +       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> +               goto inval_end_read;
>
>         rcu_read_unlock();
>         return vma;
>
>  inval_end_read:
>         vma_end_read(vma);
>
> ---
> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
> change-id: 20240805-fix-vma-lock-type-confusion-0a956d9d31ae
> --
> Jann Horn <jannh@google.com>
>

