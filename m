Return-Path: <linux-kernel+bounces-247863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A392D5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D394C1F23973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFA1953BB;
	Wed, 10 Jul 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3KpqVPMl"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFB1922C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627634; cv=none; b=uY9TxiO1WlBj4Da0OxuFLZmJeUWyOD3VQBeBAeXU0cppt63eiuOa8et7tS6Ff9LeYA6TCOs724iR1d0H7rWqFWgpS1BPytqd+u00mNE3icEgP8c548gRRnDIuRD84L1sv7zxnwPdkQyJiRXEEZ9Kg4yWxr9wvCLUcvJPK+GtffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627634; c=relaxed/simple;
	bh=TwqYCsNUzO27pl3d35gnur7jhA1rqJCcNh/XtSoFgQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diVPeuvEZtASRd0ZJPWd63qeiS6JnqgbIDjg4vbDht2SwrxkHq0/hekkpKZscGNoGNS9WCC3Ooi3riyiSzT5oYy/yfLb9HZku8+wZYVuHgv/vbjNGSRajTADHmAczaBfdJ6V5FClfE3ICXVk39iZsaZ2stfOMtY/U+P4IrKJSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3KpqVPMl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7036f1f3434so1715561a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627632; x=1721232432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjVbji5CrCqJ7kcfK3q/blM1DKJ1iwhRu2WNPrIdCio=;
        b=3KpqVPMlY44dhpVs9HGEC0kvlEhRfL0ZIe7m77fU4cpRgY/5vxrZebzdBaKEJb/cqP
         FMlelDIljtXuAD1jaBB89Ejzt4eLhwVuF+HdPHgIvkMLUNQVRNTb3F3RHf+wJAvS71K4
         cZ5AlNnZ6khmwIIjPm2fY18SchdXtQhit59wK5yJYDt92udKKZZhVO0Au72tNS378rdB
         G4klI+5e99X5DHwOT60Ii0GCcXKoybx9oqpPrLdYGfJN0jcVmXma4RcIAVSUOxGiSAJm
         87qdxK5R3qURHirKWwBfiBK+WB+i3uWNrJFDLZKhtzYwN6jMh4cQT7YRKxTzQoC4UCqJ
         szXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627632; x=1721232432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjVbji5CrCqJ7kcfK3q/blM1DKJ1iwhRu2WNPrIdCio=;
        b=Ql2ie2bBTbIFmSAJShpC4u7io84eTINz0ALWDF2oQ1aXlJIbNMuQQvXSwXiM6peze2
         5WNpwN7ZXcQQFsNDPR0pgQveba8S6QaYRzAZTX2uoLX8e4VhoZcTlT4lagOEJCNFH0qw
         7oLCxIr930xqDrB0DLyFcCiYuAgpi5B9P02rE97k2qDcuO2BWUhanJGJsuxSyYuj3tS+
         /lhJrvQbauo8EMRsHQHzGb3Vb+a6Uwqt3qo27vUiMsUzI87fVCUeAw3FRVpkVa1la8Gw
         JFrQGKOrYVHbR4cQHhBHsdi4sPCB+GRqcZvgUYGf6HaMAMHD/fVGs7g2Pcmj0cuIUYZO
         sjdA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5uagqTvKO/7BWodu1ghaZ9iC7SOT9OjCVtUfDE2NhXuS9latUh4qprGJv+k37oDj/bmeaNIpoefgDALsn+PBOqPnfWbtToiFoqp1
X-Gm-Message-State: AOJu0YxCRNrVFp+laCIibLFnRKRqtHz3ooaiY/jdGp7tZbIvRa6gdha1
	YGVem9vzoRy0VAGoeuQVTiI0gTUB6HAqJ8UDzqCiVu4dbVaP8U9zJLF4MpoM2geyvaVZLovGp1p
	tU8Nryem7sQvsfFYa7/hdRBYANwZOtycuuqWd
X-Google-Smtp-Source: AGHT+IEGuarjvl5P4EGO1WQRi2n+KDiCzE7RxqIQt9FVliErglbbA/aZXJxMQ5n6Ec63O5U9XcMPQHJgipWfsXpCYtQ=
X-Received: by 2002:a9d:5912:0:b0:703:5f9f:82f2 with SMTP id
 46e09a7af769-70375a0baccmr6882491a34.18.1720627632042; Wed, 10 Jul 2024
 09:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com> <20240704182718.2653918-4-Liam.Howlett@oracle.com>
In-Reply-To: <20240704182718.2653918-4-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:07:01 -0700
Message-ID: <CAJuCfpHPWm2Bj+CZJyZQrwOBEP76M_xsdH3DG8CuUS=Onv+c8w@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] mm/mmap: Introduce vmi_complete_munmap_vmas()
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
> Extract all necessary operations that need to be completed after the vma
> maple tree is updated from a munmap() operation.  Extracting this makes
> the later patch in the series easier to understand.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 79 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 26 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d572e1ff8255..411798f46932 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2605,6 +2605,56 @@ static inline void abort_munmap_vmas(struct ma_sta=
te *mas_detach)
>         __mt_destroy(mas_detach->tree);
>  }
>
> +/*
> + * vmi_complete_munmap_vmas() - Finish the munmap() operation
> + * @vmi: The vma iterator

You are missing vma and mm documentation. With that fixed

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> + * @start: The start address
> + * @end: The end address
> + * @unlock: Unlock the mm or not
> + * @mas_detach: them maple state of the detached vma maple tree
> + * @locked_vm: The locked_vm count in the detached vmas
> + *
> + * This function updates the mm_struct, unmaps the region, frees the res=
ources
> + * used for the munmap() and may downgrade the lock - if requested.  Eve=
rything
> + * needed to be done once the vma maple tree is updated.
> + */
> +static void
> +vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct=
 *vma,
> +               struct mm_struct *mm, unsigned long start,
> +               unsigned long end, bool unlock, struct ma_state *mas_deta=
ch,
> +               unsigned long locked_vm)
> +{
> +       struct vm_area_struct *prev, *next;
> +       int count;
> +
> +       count =3D mas_detach->index + 1;
> +       mm->map_count -=3D count;
> +       mm->locked_vm -=3D locked_vm;
> +       if (unlock)
> +               mmap_write_downgrade(mm);
> +
> +       prev =3D vma_iter_prev_range(vmi);
> +       next =3D vma_next(vmi);
> +       if (next)
> +               vma_iter_prev_range(vmi);
> +
> +       /*
> +        * We can free page tables without write-locking mmap_lock becaus=
e VMAs
> +        * were isolated before we downgraded mmap_lock.
> +        */
> +       mas_set(mas_detach, 1);
> +       unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
> +                    !unlock);
> +       /* Statistics and freeing VMAs */
> +       mas_set(mas_detach, 0);
> +       remove_mt(mm, mas_detach);
> +       validate_mm(mm);
> +       if (unlock)
> +               mmap_read_unlock(mm);
> +
> +       __mt_destroy(mas_detach->tree);
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
>   * @vmi: The vma iterator
> @@ -2624,7 +2674,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
>                     struct mm_struct *mm, unsigned long start,
>                     unsigned long end, struct list_head *uf, bool unlock)
>  {
> -       struct vm_area_struct *prev, *next =3D NULL;
> +       struct vm_area_struct *next =3D NULL;
>         struct maple_tree mt_detach;
>         int count =3D 0;
>         int error =3D -ENOMEM;
> @@ -2728,31 +2778,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>                 goto clear_tree_failed;
>
>         /* Point of no return */
> -       mm->locked_vm -=3D locked_vm;
> -       mm->map_count -=3D count;
> -       if (unlock)
> -               mmap_write_downgrade(mm);
> -
> -       prev =3D vma_iter_prev_range(vmi);
> -       next =3D vma_next(vmi);
> -       if (next)
> -               vma_iter_prev_range(vmi);
> -
> -       /*
> -        * We can free page tables without write-locking mmap_lock becaus=
e VMAs
> -        * were isolated before we downgraded mmap_lock.
> -        */
> -       mas_set(&mas_detach, 1);
> -       unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
> -                    !unlock);
> -       /* Statistics and freeing VMAs */
> -       mas_set(&mas_detach, 0);
> -       remove_mt(mm, &mas_detach);
> -       validate_mm(mm);
> -       if (unlock)
> -               mmap_read_unlock(mm);
> -
> -       __mt_destroy(&mt_detach);
> +       vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_d=
etach,
> +                                locked_vm);
>         return 0;
>
>  clear_tree_failed:
> --
> 2.43.0
>

