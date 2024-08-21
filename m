Return-Path: <linux-kernel+bounces-295888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D3F95A295
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DBE285D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053CB14EC7F;
	Wed, 21 Aug 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnQtSiRn"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07801146D69
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256969; cv=none; b=S2Gp9520Ldfa6EatN8mL90U5Ko2sBG/SKSokhgE5PZ0VCWh1Qr1nv5BHd6csMWjUV04VGKNMlXbwAEkVbElqrcdZeuX5TR9qeV1RaweCanamzXm4Try6Eo0Qz+ocYilsk93ztqZBb1MwGJIXc46U6PQnqMhtUu8qlGHwlPD5X+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256969; c=relaxed/simple;
	bh=3h6jrzsG49oXrzZkPXaS5Zys9GLAADcZ2Y19PT2dgvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqcIV6jqaihdXJVNyplL2XeolRH8dib+k8/XE6XgpWl/+kciF98suvUC0W21RDhznIAQvYE2sdBdsHT6YpM9B5QNbtg/xiBOsmCk1J3MNjFrJTgCE0RuKbvCmbnx1hgTqHwrqsnpaSAC3kNR+5LIf2Mk7gB4wUSo1+hz67cXzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XnQtSiRn; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db111a08c3so62483b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724256965; x=1724861765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay4N+X8xFligirN80qjTXFQAPlG4tThmp3+jBLmN5qM=;
        b=XnQtSiRnhHCEk31OoA4BsQ/qI1rGOK5zB7O06C1CZNhEIRAzZOFOgxz1doK4dHfooA
         VbKutW7s3a3qrp9L2EXsB922p2gqr+gtRfCWC7hhrXGtMl/p9S3QG+0qJEhYVJO7+Smk
         MsWMHHRxOFK291jcZKI14BGGGDBpswpULLAyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256965; x=1724861765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay4N+X8xFligirN80qjTXFQAPlG4tThmp3+jBLmN5qM=;
        b=SkW03OBZYJMEsaRrBYKx6cbKcLDsTNGrXyFrrgYA9gszyjLkq3k633jBXG0BGjzbq6
         fNoIlyauqNfRekWIflqu4DrdD51TueTNKvZppXsvtvJsf0nrzgXUq8yg+lculHuTvY9t
         fu8shjU5A0JyDjYJp6hlpg81M3PNpYVVHiTfM1xOIVtlNduJYKrVwb7+qUPT50vkWsld
         yj0ENsvPwYEiSTJgmOy184+TwdUea9CnrV7qOAGtELidDVK/v5/M4t8BvZB8oA+/a/KT
         FR/umMr46zcJXC0uFAyvqgQJer+2XEY626cAz2TDg4aqCykUxFsifPNfQsyfu6nNPapB
         IieA==
X-Forwarded-Encrypted: i=1; AJvYcCVWUuLi2rSnKK0l7h+BDEMdRwoBhtI6J5oc9f/pOyHKbpDMCLi0h/G92doCZjFJGwRCIJLHAJ77g4eerJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWx0HC6T8zSjsDonicowM6+tcQ8wml8RCSbXcKlvRLsc+LzgU
	h8ZGf2medJ0I9CC1RFCCrUum9NTPMDPusKIEv23MlrAOlQS0tgE/O6XvhfVGZOiAvkLVKWrpIHs
	Kl83earNBoahOFddJCicf74YV5pIXF5GHR6QD
X-Google-Smtp-Source: AGHT+IECN3jXMHQ89hKP+cbvp8WlOQnMNfhtIo6rfpsvat0UipyYBThpaC5bMpZj5d7hLc/B6tAUMQQDAMA7oJ9ZsQk=
X-Received: by 2002:a05:6870:65a3:b0:260:edbc:d7fc with SMTP id
 586e51a60fabf-2737eef29d7mr1841616fac.4.1724256964997; Wed, 21 Aug 2024
 09:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com> <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 21 Aug 2024 09:15:52 -0700
Message-ID: <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> We were doing an extra mmap tree traversal just to check if the entire
> range is modifiable. This can be done when we iterate through the VMAs
> instead.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mmap.c | 11 +----------
>  mm/vma.c  | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3af256bacef3..30ae4cb5cec9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>                 unsigned long start, unsigned long end, struct list_head =
*uf,
>                 bool unlock)
>  {
> -       struct mm_struct *mm =3D vma->vm_mm;
> -
> -       /*
> -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> -        * can_modify_mm assumes we have acquired the lock on MM.
> -        */
> -       if (unlikely(!can_modify_mm(mm, start, end)))
> -               return -EPERM;
Another approach to improve perf  is to clone the vmi (since it
already point to the first vma), and pass the cloned vmi/vma into
can_modify_mm check, that will remove the cost of re-finding the first
VMA.

The can_modify_mm then continues from cloned VMI/vma till the end of
address range, there will be some perf cost there.  However,  most
address ranges in the real world are within a single VMA,  in
practice, the perf cost is the same as checking the single VMA, 99.9%
case.

This will help preserve the nice sealing feature (if one of the vma is
sealed, the entire address range is not modified)

> -
> -       return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> +       return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, =
unlock);
>  }
>
>  /*
> diff --git a/mm/vma.c b/mm/vma.c
> index 84965f2cd580..5850f7c0949b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>                 if (end < vma->vm_end && mm->map_count >=3D sysctl_max_ma=
p_count)
>                         goto map_count_exceeded;
>
> +               /* Don't bother splitting the VMA if we can't unmap it an=
yway */
> +               if (!can_modify_vma(vma)) {
> +                       error =3D -EPERM;
> +                       goto start_split_failed;
> +               }
> +
>                 error =3D __split_vma(vmi, vma, start, 1);
>                 if (error)
>                         goto start_split_failed;
> @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>          */
>         next =3D vma;
>         do {
> +               if (!can_modify_vma(next)) {
> +                       error =3D -EPERM;
> +                       goto modify_vma_failed;
> +               }
> +
>                 /* Does it split the end? */
>                 if (next->vm_end > end) {
>                         error =3D __split_vma(vmi, next, end, 0);
> @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
>         __mt_destroy(&mt_detach);
>         return 0;
>
> +modify_vma_failed:
>  clear_tree_failed:
>  userfaultfd_error:
>  munmap_gather_failed:
> @@ -860,13 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct m=
m_struct *mm,
>         if (end =3D=3D start)
>                 return -EINVAL;
>
> -       /*
> -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> -        * can_modify_mm assumes we have acquired the lock on MM.
> -        */
> -       if (unlikely(!can_modify_mm(mm, start, end)))
> -               return -EPERM;
> -
>         /* Find the first overlapping VMA */
>         vma =3D vma_find(vmi, end);
>         if (!vma) {
>
> --
> 2.46.0
>

