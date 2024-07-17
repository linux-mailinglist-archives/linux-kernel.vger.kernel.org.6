Return-Path: <linux-kernel+bounces-254674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB8933627
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DFC1C22668
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A43B67F;
	Wed, 17 Jul 2024 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSDwVO31"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403FBAD2D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192612; cv=none; b=NQPhA+Zl3ujJ7ADM2cL+iSUYubHm/uLGDkdYSWlqPvN1CUvWYHhhAprDOkJglkPSynF0Oy1iMUaaHtnbJO5uKLbzX/SGRA/3aMSFLb6MAUqh5lztyo5Jw7I81Zlt65g6FLfvSm+1Kz5bgFHnmi33SRTMk6WwL6tqPfhPOnqVrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192612; c=relaxed/simple;
	bh=WNCB9VxIcAmqcQYlkbc4iNn0x2YbNMrn8SKePAtP0Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR5zJre40DjHHkrv8EWfGzGFe/LyzZfaM2oX8QAh7WYntkycl9YgBOy4/qs2+c9+UdX+NZvaDYVjFBoW5HX3Zky8FlEcWw2LO4553El43czQ0fsk6sNSIyznrv7QAXToVodGZ7LpamuRV0k0xHticlLUVOPgYnWmMQvR7ZBO4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VSDwVO31; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c9fea3b566so230712eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721192610; x=1721797410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3t0cpldr8avZY/NqlGsEsmnOCiLCe/YleshAynmYw0=;
        b=VSDwVO31j4Ls0sMzXTwynkOa0zDb+X7Eunt4ZYzUTDWH5UwqW6SGp+yRdgFT4fnSrK
         +/k/SonZ0EdQLDLp0AAbdhNRjXmRH8/M9pMm/izldkxVGxTbY8kEfDwlxksJf8MzjXAW
         ZN4Srm9OX6UpYMdHlhTwMPXVU9BIRaaUN8eEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192610; x=1721797410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3t0cpldr8avZY/NqlGsEsmnOCiLCe/YleshAynmYw0=;
        b=VyV7eciVq55EttvL5CMAuWVILvIgN4remdhKKEqRrAzmzoKnqe0kXgux/D+cKb8J4v
         rM9Z+CpnIpU/NL0Ht+wi/mh7LLIOdaytghTi85Jul6SfyebAQ5j13N/XHbjY43/Ifift
         qvzjsp3j6CokopxgGXkAGINtIfPHxPusmvX3ZGxObFSnLTmB6LyomvKqdpkj6EZ8ghMf
         0Cd4TuN71Si3ATkJbGfngJvSuVXDL7XG9Oyqvr+s4KZXA9WxVnpdCjIb0kp1OMDWo0gO
         eb8HfYk6Q/2XARJF0oribsTbh9UHs1Bh28kS7TJkRxmJZvfriNaXl39bwNGT/1WyLCFA
         IhEA==
X-Forwarded-Encrypted: i=1; AJvYcCUs75/GykKz13rumRecxJrBDOH46D/gGHSYl50JcODnYN2KZOP1Aw6jJNsLCe0jTMvr0AGXy2bQ5Phkg/qf9xoonY9hBfGW+Vz7ubA4
X-Gm-Message-State: AOJu0YzZqd0e2d4Eqvq9gPJyurEAgD/zbZjvPyPnAuurViS7XrfLe+7C
	cpSbb87zv8Nutw0UPvUWDeL7vGjGtmBXmEc3c9wnUrrw3tY4ohdQpdzmMoMkG5Qq/RW4hWRYbsz
	Ur5F5XXRoZCyVxt+IH2Z1wJUkaZRJY+xY70pI
X-Google-Smtp-Source: AGHT+IGIj+nvmd6+BGaHjWYUDOS/oSOs0/w40qyu6AVhGQgkRyzFVKXUiYa/4jBMWxcQAEUJb7E9Yp1BvaSO/or+gyo=
X-Received: by 2002:a05:6871:9c15:b0:25e:b984:22e9 with SMTP id
 586e51a60fabf-260bf33fe21mr1906964fac.5.1721192610224; Tue, 16 Jul 2024
 22:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com> <20240710192250.4114783-19-Liam.Howlett@oracle.com>
In-Reply-To: <20240710192250.4114783-19-Liam.Howlett@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 16 Jul 2024 22:03:18 -0700
Message-ID: <CABi2SkXLM2oXNLz-kMy=3LWJjkOPGbS2Vc2P4nfZzo4r=_MUJw@mail.gmail.com>
Subject: Re: [PATCH v4 18/21] mm/mmap: Move can_modify_mm() check down the stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 10, 2024 at 12:23=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Without an arch_unmap() call anymore,
Is there another patch that removes arch_unmap() ?
Can you please post the link for the patch ?

Thanks
-Jeff

> the check for mseal'ed vmas can be
> moved lower as well.  This has the benefit of only actually checking if
> things are msealed when there is anything to check.  That is, we know
> there is at least one vma that is in the way and needs to be checked.
>
> Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
> case of mmap_region().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mmap.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index df565f51971d..c343366b3ad2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2849,6 +2849,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         struct vma_munmap_struct vms;
>         int error;
>
> +       /* Prevent unmapping a sealed VMA. */
> +       if (unlikely(!can_modify_mm(mm, start, end)))
> +               return -EPERM;
> +
>         init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
>         error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
>         if (error)
> @@ -2899,13 +2903,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct=
 mm_struct *mm,
>         if (end =3D=3D start)
>                 return -EINVAL;
>
> -       /*
> -        * Prevent unmapping a sealed VMA.
> -        * can_modify_mm assumes we have acquired the lock on MM.
> -        */
> -       if (unlikely(!can_modify_mm(mm, start, end)))
> -               return -EPERM;
> -
>         /* Find the first overlapping VMA */
>         vma =3D vma_find(vmi, end);
>         if (!vma) {
> @@ -2963,13 +2960,15 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>         if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
>                 return -ENOMEM;
>
> -       if (unlikely(!can_modify_mm(mm, addr, end)))
> -               return -EPERM;
>
>         /* Find the first overlapping VMA */
>         vma =3D vma_find(&vmi, end);
>         init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock =3D */ =
false);
>         if (vma) {
> +               /* Prevent unmapping a sealed VMA. */
> +               if (unlikely(!can_modify_mm(mm, addr, end)))
> +                       return -EPERM;
> +
>                 mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLA=
GS_LOCK_MASK);
>                 mt_on_stack(mt_detach);
>                 mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
> @@ -3341,13 +3340,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>  {
>         struct mm_struct *mm =3D vma->vm_mm;
>
> -       /*
> -        * Prevent unmapping a sealed VMA.
> -        * can_modify_mm assumes we have acquired the lock on MM.
> -        */
> -       if (unlikely(!can_modify_mm(mm, start, end)))
> -               return -EPERM;
> -
>         return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>
> --
> 2.43.0
>

