Return-Path: <linux-kernel+bounces-247864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2229492D5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84348B24291
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B119580C;
	Wed, 10 Jul 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMILGtge"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252821922C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627643; cv=none; b=mwq/rR2NW8DAHeaAi16PEtxSOFtm+28g72hEIYJ3PnK6Qmr2gFYS6Pir3y0/qhMVOoCmXDjEezX4psGuF1/RiUSbHIqD/bTh4aqna1D+YXrWijQ+t2r20+EcYzTXhuOq6fXA1ZNC2u/cJ5XHP3jFOdR6Snpi7oyIPuBE0LFYW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627643; c=relaxed/simple;
	bh=S3ViMiwB539QvvsBUKXOhdUzccwenRP0IV4dHvQLo44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXuh9ePRINAxFEpobkYM+JpCkxTBfpDkHCzJosV1iub7MPCZY1kq2GT7/yq+dj23Q8S+cupLpbhSNVwfUmHxxgfJzEf2Np2f4ZJance1BLajNFwmaNSkQt8vQR9YSOyY3sJu15DJBF69c0kbis6NO0MzwQOB5zFVT8ZWTAbFuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMILGtge; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-650469f59d7so58497677b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627641; x=1721232441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSQUshmSdhXe881WB/NNrPxsfE0Hz+Zz8a2QxDP5NDU=;
        b=yMILGtgeTh3zGTqocsZbYsQIxqCAdm/mjwKPGmF2PvUGCiz/pHPlyAYlPKA0DN4Hz1
         w2/9gO2iNI8inzYEffW5iTrtlQsZDaWVE12dw5kEm1zkecTTitNs4+Iur/v6p+7z4nRN
         kTnHXz/TFdvni4n2Bp6f+IRQ1CcPUUGLFwcUMwKfyNA5G8EJ6Upt7tyZSoAiEJYpVy/C
         iGvvk5VccH5TQqzAa0ksgjY63J35jlvLPHDyLQmMhZFPtt90dIRHw2hLtkWXinx21hPb
         eHg0JcWAjVGTAgGTBkckZ0XR8rA6NKk9P/ZvjluwF0s+3ect4vzLSrxQx850VoGoddq1
         IGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627641; x=1721232441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSQUshmSdhXe881WB/NNrPxsfE0Hz+Zz8a2QxDP5NDU=;
        b=QM7dlxmL9dZwl+MO00W34U+DgqpnzJPRefWzvCyGUVYkeKxucNkxE7UT93NE64kzZH
         NlxFE0x/L34M0iXexmdC8baDyrJuoMh0F4RYh7Fb1guMzhxG1PHs8JGoajsfd2fjTJVw
         vSRrgonmROy3wl5dtforYObI3ADsM7s09/Pm8ISikoBp96VKOtccHf/3tFdGwZFyan0i
         kYHFO9NUVt5cLxQN1lIjjJ4Ppf+5bjGZoRYaCUVa0yRacMKbihl6HV7qIBfY8PGJGnRf
         ue+wqkKq9QM58xjfViu2Fit5gwe0xrZDeK9Vi0y/7Ilbqpfz+WgkgTi4MCvXYysBQXhM
         TSNA==
X-Forwarded-Encrypted: i=1; AJvYcCXMYjBv6gquL0LNdeD1vkneIT2sNfjWz9mh8qAP15sIhhNCVlv2AQLFHnh/2o5WihOIerV7ZOINmVYPSUvCJDaAv28bDQs20ZA/o0uK
X-Gm-Message-State: AOJu0YxhRhHuKvoD5btsfdRB4pKhVzoZRHKAOwP1YAkvP10rzBXXwkyP
	RfFWCdcpXVLFsWGqpzPSa0ZWOru1JsCLNkTGMHn/vWzQw6acpTg6n+OmXxxr6i6xwToEu66V5f4
	BInC4YimHbnugdGWE8cvAzJYPlJtbApkE4p0W
X-Google-Smtp-Source: AGHT+IFSykq+WyrWdT6Uv/EHdnZgmAh2o20rzvf6Nwh0G62ITLVVLQ8XZ8JteXgDLTJ5bYm4oUeM2YtLoJxpK+Xw1+c=
X-Received: by 2002:a0d:f6c5:0:b0:631:2219:a441 with SMTP id
 00721157ae682-658f08cc76dmr60471887b3.48.1720627640761; Wed, 10 Jul 2024
 09:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com> <20240704182718.2653918-5-Liam.Howlett@oracle.com>
In-Reply-To: <20240704182718.2653918-5-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:07:09 -0700
Message-ID: <CAJuCfpFHK+Bw8H1r5691yjgB+OjUEd1cedDydsfqp8zJwfRb_w@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:27=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
> detached maple tree for removal later.  Part of the gathering is the
> splitting of vmas that span the boundary.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 58 insertions(+), 24 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 411798f46932..8dc8ffbf9d8d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
>  }
>
>  /*
> - * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
> + * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple t=
ree
> + * for removal at a later date.  Handles splitting first and last if nec=
essary
> + * and marking the vmas as isolated.
> + *
>   * @vmi: The vma iterator
>   * @vma: The starting vm_area_struct
>   * @mm: The mm_struct
>   * @start: The aligned start address to munmap.
>   * @end: The aligned end address to munmap.
>   * @uf: The userfaultfd list_head
> - * @unlock: Set to true to drop the mmap_lock.  unlocking only happens o=
n
> - * success.
> + * @mas_detach: The maple state tracking the detached tree
>   *
> - * Return: 0 on success and drops the lock if so directed, error and lea=
ves the
> - * lock held otherwise.
> + * Return: 0 on success
>   */
>  static int
> -do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
> +vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                     struct mm_struct *mm, unsigned long start,
> -                   unsigned long end, struct list_head *uf, bool unlock)
> +                   unsigned long end, struct list_head *uf,
> +                   struct ma_state *mas_detach, unsigned long *locked_vm=
)
>  {
>         struct vm_area_struct *next =3D NULL;
> -       struct maple_tree mt_detach;
>         int count =3D 0;
>         int error =3D -ENOMEM;
> -       unsigned long locked_vm =3D 0;
> -       MA_STATE(mas_detach, &mt_detach, 0, 0);
> -       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK=
_MASK);
> -       mt_on_stack(mt_detach);
>
>         /*
>          * If we need to split any vma, do it now to save pain later.
> @@ -2720,15 +2717,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>                                 goto end_split_failed;
>                 }
>                 vma_start_write(next);
> -               mas_set(&mas_detach, count);
> -               error =3D mas_store_gfp(&mas_detach, next, GFP_KERNEL);
> +               mas_set(mas_detach, count++);
> +               if (next->vm_flags & VM_LOCKED)
> +                       *locked_vm +=3D vma_pages(next);

Uh, this was confusing. You moved locked_vm/count accounting before
mas_store_gfp(), so if mas_store_gfp() fails, they will be one-off
because we incremented them but failed to insert the element. Only
later I realized that if mas_store_gfp() fails then we never use these
counters. The code is still correct but I'm wondering if this movement
was necessary. We wouldn't use wrong values but why make them wrong in
the first place?
In later patches you account for more things in here and all that is
also done before mas_store_gfp(). Would moving all that after
mas_store_gfp() and keeping them always correct be an issue?




> +
> +               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
>                 if (error)
>                         goto munmap_gather_failed;
>                 vma_mark_detached(next, true);
> -               if (next->vm_flags & VM_LOCKED)
> -                       locked_vm +=3D vma_pages(next);
> -
> -               count++;
>                 if (unlikely(uf)) {
>                         /*
>                          * If userfaultfd_unmap_prep returns an error the=
 vmas
> @@ -2753,7 +2749,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>         /* Make sure no VMAs are about to be lost. */
>         {
> -               MA_STATE(test, &mt_detach, 0, 0);
> +               MA_STATE(test, mas_detach->tree, 0, 0);
>                 struct vm_area_struct *vma_mas, *vma_test;
>                 int test_count =3D 0;
>
> @@ -2773,6 +2769,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         while (vma_iter_addr(vmi) > start)
>                 vma_iter_prev_range(vmi);
>
> +       return 0;
> +
> +userfaultfd_error:
> +munmap_gather_failed:
> +end_split_failed:
> +       abort_munmap_vmas(mas_detach);
> +start_split_failed:
> +map_count_exceeded:
> +       return error;
> +}
> +
> +/*
> + * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
> + * @vmi: The vma iterator
> + * @vma: The starting vm_area_struct
> + * @mm: The mm_struct
> + * @start: The aligned start address to munmap.
> + * @end: The aligned end address to munmap.
> + * @uf: The userfaultfd list_head
> + * @unlock: Set to true to drop the mmap_lock.  unlocking only happens o=
n
> + * success.
> + *
> + * Return: 0 on success and drops the lock if so directed, error and lea=
ves the
> + * lock held otherwise.
> + */
> +static int
> +do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
> +                   struct mm_struct *mm, unsigned long start,
> +                   unsigned long end, struct list_head *uf, bool unlock)
> +{
> +       struct maple_tree mt_detach;
> +       MA_STATE(mas_detach, &mt_detach, 0, 0);
> +       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK=
_MASK);
> +       mt_on_stack(mt_detach);
> +       int error;
> +       unsigned long locked_vm =3D 0;
> +
> +       error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> +                                      &mas_detach, &locked_vm);
> +       if (error)
> +               goto gather_failed;
> +
>         error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
>         if (error)
>                 goto clear_tree_failed;
> @@ -2783,12 +2821,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         return 0;
>
>  clear_tree_failed:
> -userfaultfd_error:
> -munmap_gather_failed:
> -end_split_failed:
>         abort_munmap_vmas(&mas_detach);
> -start_split_failed:
> -map_count_exceeded:
> +gather_failed:
>         validate_mm(mm);
>         return error;
>  }
> --
> 2.43.0
>

