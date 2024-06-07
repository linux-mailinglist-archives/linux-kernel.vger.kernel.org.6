Return-Path: <linux-kernel+bounces-206269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716E9006C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B6BB240A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47841957E6;
	Fri,  7 Jun 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZhvjeDW"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F41194AC9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771097; cv=none; b=Yw9wcDXUW8e+DIGpDt963wQ4QYrgJRZNmwR2XtKdPvhXdpOTNsV/xMexBxB5JhErncGWqeq7ZCiXmxva7qPOBRmmdCeSd5RRYZsUKkAxwEPRc5Y80Vijb6dUEVqL27pOat01GzXavLBL9MA4CCcXqd0GMxR4A4c/sumE/sxngjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771097; c=relaxed/simple;
	bh=OeYhmkj8rPabzHFHZ/d3YrtJNSgyhhdKfUf73Jynf4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoXHttsMHK4QZvT5TcXZrw02+MDTxBiuLhkbBXJ47Z1NnAcSVetyUshyrUttPKpwE+3kH7Zz3AklZ7Jm5c1rvs5AOBJQ60lqX0sb5C8C9ubYcoGyqeM2szgZuuyqRcRQL6TsmpzHELYBaZMgW7ZaZ76ID1oJ9CJnV5OA0O9nj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ZhvjeDW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df771b6cf71so2441161276.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717771095; x=1718375895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVOnoBzoK1zAtvBRGWuYUP6Os8Y9dBiDXv9nnFzFCIo=;
        b=4ZhvjeDWtWj04dMlWW3wcqRpCDNQXwwAXUK+4fs8NA06CZuuHhoIB8LhokC6C/IWij
         QI99+YJB8FH6wNLt8z+VhTX6CZ0QqM7hWK/p/4uNQP5Neh5/d3+q13oM1LtuCRxOKadk
         yiRxvxezTE8wG2Tpv1JWBE+BIRzFqJAZNP7IsHHXVxLxfc/yg49Zik6+k9oVnyiAPXFV
         sVJSYN4CfDKVozizVvO1pWNQtpvX+u6VrzFwbcArplzIUP4oylEZ8k9P9wuiZUaNjB4E
         iq+reAprl/aS9XCkuhn70D0eW/lCTau38JqC22s0rzlRt8587PSI2MnNh2vxmbYmEJlZ
         xzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717771095; x=1718375895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVOnoBzoK1zAtvBRGWuYUP6Os8Y9dBiDXv9nnFzFCIo=;
        b=OYtIGKEJEB0M7ynlaQuKrHHNgE0KNcszoonpjIDPr7le/WeKy5UygsrOC27j7m0oE/
         NQsBQNBDWL5X7kzaD3obu3NuFLXTsTBJljG+3rXjhcIY1s+nj1KpMtv2BNupmZ9X9Q3p
         8VhC+UbxcUKxUFspt0ZsZZFQQihYgQ3y3nIHC7qrAC9GLbfuncB0+eQ1EaMNTWhbzR9d
         onoTRxu+HA7vI19rgRnoX5lqkehtC3cgyhCkwaHykWYvO/95FVA4Y3BY4r0zNuQBEbZx
         L68MvsdlB27l30i/TVToP2cD52QMP5G/dQa0oCU50SzeOpK/PmtXO2L+Dgy5T9U0JhGb
         y2vA==
X-Forwarded-Encrypted: i=1; AJvYcCUPK1lDKGlnARGKV04sdLB7PQXCGa5jj3HBNxmCcVnwHi9pL9+bFM8yIffrGBJTMhmgWRvPhERKfxFCEECqCOjWnSZfMUwxyS8aIDV4
X-Gm-Message-State: AOJu0YwTSC+vbZKo7JttuiDy/G9AS2FQw6GPzkz55l3imZ4slLFT8aVE
	FT05+RDm3rRyvqRq3QlpcQ79fr9UtId8XkKgAafFZz5iZCw5GIRMOb3zrqigeKhQbh83uB812rr
	oE9fj56zkct9td7/8uP57LtIUNL6KN4MZk8lZ
X-Google-Smtp-Source: AGHT+IEoKThZkHMiLLjP3WX0BoB3TWzKGwUQSKBSO7THX0AH5ExYgBlUbM4kN7MluTiitOjWmHibd+i9cZHc6WhpIps=
X-Received: by 2002:a25:8681:0:b0:dfa:fe79:8d9b with SMTP id
 3f1490d57ef6-dfafe798ff6mr1701678276.20.1717771094238; Fri, 07 Jun 2024
 07:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com> <20240531163217.1584450-5-Liam.Howlett@oracle.com>
In-Reply-To: <20240531163217.1584450-5-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 7 Jun 2024 07:38:01 -0700
Message-ID: <CAJuCfpEfUpXD5Zas7CBT1tqKsF363fOZ9hBMY0Rf=KaX1emnsA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/mmap: Change munmap to use vma_munmap_struct()
 for accounting and surrounding vmas
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Clean up the code by changing the munmap operation to use a structure
> for the accounting and munmap variables.
>
> Since remove_mt() is only called in one location and the contents will
> be reduce to almost nothing.  The remains of the function can be added
> to vms_complete_munmap_vmas().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/internal.h |  6 ++++
>  mm/mmap.c     | 85 +++++++++++++++++++++++++++------------------------
>  2 files changed, 51 insertions(+), 40 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 6ebf77853d68..8c02ebf5736c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1435,12 +1435,18 @@ struct vma_munmap_struct {
>         struct vma_iterator *vmi;
>         struct mm_struct *mm;
>         struct vm_area_struct *vma;     /* The first vma to munmap */
> +       struct vm_area_struct *next;    /* vma after the munmap area */
> +       struct vm_area_struct *prev;    /* vma before the munmap area */
>         struct list_head *uf;           /* Userfaultfd list_head */
>         unsigned long start;            /* Aligned start addr */
>         unsigned long end;              /* Aligned end addr */
>         int vma_count;                  /* Number of vmas that will be re=
moved */
>         unsigned long nr_pages;         /* Number of pages being removed =
*/
>         unsigned long locked_vm;        /* Number of locked pages */
> +       unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
> +       unsigned long exec_vm;
> +       unsigned long stack_vm;
> +       unsigned long data_vm;
>         bool unlock;                    /* Unlock after the munmap */
>  };
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 57f2383245ea..3e0930c09213 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -482,7 +482,8 @@ static inline void init_vma_munmap(struct vma_munmap_=
struct *vms,
>         vms->unlock =3D unlock;
>         vms->uf =3D uf;
>         vms->vma_count =3D 0;
> -       vms->nr_pages =3D vms->locked_vm =3D 0;
> +       vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
> +       vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
>  }
>
>  /*
> @@ -604,7 +605,6 @@ static inline void vma_complete(struct vma_prepare *v=
p,
>         }
>         if (vp->insert && vp->file)
>                 uprobe_mmap(vp->insert);
> -       validate_mm(mm);

vma_complete() is used in places other than vma_shrink(). You
effectively removed validate_mm() for all those other users. Is that
intentional? If so, that should be documented in the changelog.

>  }
>
>  /*
> @@ -733,6 +733,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
>         vma_iter_clear(vmi);
>         vma_set_range(vma, start, end, pgoff);
>         vma_complete(&vp, vmi, vma->vm_mm);
> +       validate_mm(vma->vm_mm);
>         return 0;
>  }
>
> @@ -2347,30 +2348,6 @@ struct vm_area_struct *expand_stack(struct mm_stru=
ct *mm, unsigned long addr)
>         return vma;
>  }
>
> -/*
> - * Ok - we have the memory areas we should free on a maple tree so relea=
se them,
> - * and do the vma updates.
> - *
> - * Called with the mm semaphore held.
> - */
> -static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
> -{
> -       unsigned long nr_accounted =3D 0;
> -       struct vm_area_struct *vma;
> -
> -       /* Update high watermark before we lower total_vm */
> -       update_hiwater_vm(mm);
> -       mas_for_each(mas, vma, ULONG_MAX) {
> -               long nrpages =3D vma_pages(vma);
> -
> -               if (vma->vm_flags & VM_ACCOUNT)
> -                       nr_accounted +=3D nrpages;
> -               vm_stat_account(mm, vma->vm_flags, -nrpages);
> -               remove_vma(vma, false);
> -       }
> -       vm_unacct_memory(nr_accounted);
> -}
> -
>  /*
>   * Get rid of page table information in the indicated region.
>   *
> @@ -2625,13 +2602,14 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
>                 if (error)
>                         goto start_split_failed;
>         }
> +       vms->prev =3D vma_prev(vms->vmi);
>
>         /*
>          * Detach a range of VMAs from the mm. Using next as a temp varia=
ble as
>          * it is always overwritten.
>          */
> -       next =3D vms->vma;
> -       do {
> +       for_each_vma_range(*(vms->vmi), next, vms->end) {
> +               long nrpages;
>                 /* Does it split the end? */
>                 if (next->vm_end > vms->end) {
>                         error =3D __split_vma(vms->vmi, next, vms->end, 0=
);
> @@ -2640,8 +2618,21 @@ static int vms_gather_munmap_vmas(struct vma_munma=
p_struct *vms,
>                 }
>                 vma_start_write(next);
>                 mas_set(mas_detach, vms->vma_count++);
> +               nrpages =3D vma_pages(next);
> +
> +               vms->nr_pages +=3D nrpages;
>                 if (next->vm_flags & VM_LOCKED)
> -                       vms->locked_vm +=3D vma_pages(next);
> +                       vms->locked_vm +=3D nrpages;
> +
> +               if (next->vm_flags & VM_ACCOUNT)
> +                       vms->nr_accounted +=3D nrpages;
> +
> +               if (is_exec_mapping(next->vm_flags))
> +                       vms->exec_vm +=3D nrpages;
> +               else if (is_stack_mapping(next->vm_flags))
> +                       vms->stack_vm +=3D nrpages;
> +               else if (is_data_mapping(next->vm_flags))
> +                       vms->data_vm +=3D nrpages;
>
>                 error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
>                 if (error)
> @@ -2667,7 +2658,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
>                 BUG_ON(next->vm_start < vms->start);
>                 BUG_ON(next->vm_start > vms->end);
>  #endif
> -       } for_each_vma_range(*(vms->vmi), next, vms->end);
> +       }
> +
> +       vms->next =3D vma_next(vms->vmi);
>
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>         /* Make sure no VMAs are about to be lost. */
> @@ -2712,10 +2705,11 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
>   * @mas_detach: The maple state of the detached vmas
>   *
>   */
> +static inline void vms_vm_stat_account(struct vma_munmap_struct *vms);
>  static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>                 struct ma_state *mas_detach)
>  {
> -       struct vm_area_struct *prev, *next;
> +       struct vm_area_struct *vma;
>         struct mm_struct *mm;
>
>         mm =3D vms->mm;
> @@ -2724,21 +2718,21 @@ static void vms_complete_munmap_vmas(struct vma_m=
unmap_struct *vms,
>         if (vms->unlock)
>                 mmap_write_downgrade(mm);
>
> -       prev =3D vma_iter_prev_range(vms->vmi);
> -       next =3D vma_next(vms->vmi);
> -       if (next)
> -               vma_iter_prev_range(vms->vmi);
> -
>         /*
>          * We can free page tables without write-locking mmap_lock becaus=
e VMAs
>          * were isolated before we downgraded mmap_lock.
>          */
>         mas_set(mas_detach, 1);
> -       unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vm=
s->end,
> -                    vms->vma_count, !vms->unlock);
> -       /* Statistics and freeing VMAs */
> +       unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> +                    vms->start, vms->end, vms->vma_count, !vms->unlock);
> +       /* Update high watermark before we lower total_vm */
> +       update_hiwater_vm(mm);
> +       vms_vm_stat_account(vms);
>         mas_set(mas_detach, 0);
> -       remove_mt(mm, mas_detach);
> +       mas_for_each(mas_detach, vma, ULONG_MAX)
> +               remove_vma(vma, false);
> +
> +       vm_unacct_memory(vms->nr_accounted);
>         validate_mm(mm);
>         if (vms->unlock)
>                 mmap_read_unlock(mm);
> @@ -3631,6 +3625,17 @@ void vm_stat_account(struct mm_struct *mm, vm_flag=
s_t flags, long npages)
>                 mm->data_vm +=3D npages;
>  }
>
> +/* Accounting for munmap */
> +static inline void vms_vm_stat_account(struct vma_munmap_struct *vms)
> +{
> +       struct mm_struct *mm =3D vms->mm;
> +
> +       WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages)=
;
> +       mm->exec_vm -=3D vms->exec_vm;
> +       mm->stack_vm -=3D vms->stack_vm;
> +       mm->data_vm -=3D vms->data_vm;
> +}
> +
>  static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
>
>  /*
> --
> 2.43.0
>

