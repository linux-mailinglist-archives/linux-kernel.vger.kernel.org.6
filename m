Return-Path: <linux-kernel+bounces-370364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D99A2B84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C652836F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE141E0B84;
	Thu, 17 Oct 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YhC/taOD"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE081DFE1A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187741; cv=none; b=kUJNFuZZpKQFsCpZsSx4vvgJPax8CcBGjvVpcQrnu7AVvftS1YfGOtY4SimhOA/PtFPmTCooQtw4Q5ovl6vl79ZDgqZbi2R0/AvSDYhq/gxlYxW5oB+xQxlAMRVCScX+x+fQnATzFB3XM1GMTab05NcruLfPhnNfownwdcwg3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187741; c=relaxed/simple;
	bh=STMCOKdYDrxhAKPIY0TpjnuIkv4jnXIKSv8Ay+ovgds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ98xfLQ7sIfX0odcMcXGpP8sPzbk9f1Eswc+y3RwBnMVicONY8L6zRuik0/iW6m0UqZg23UfJzbn+XF9xUisk5oLi4Rv0OVMUB6B6sLvkSmiywCrqVFgTIWGSHLjM1VU1QZ0dnqLaaVyCypyjmYNnsbXJeLVeAeI393AVGiFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YhC/taOD; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2888bcc0f15so151016fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729187739; x=1729792539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV2LniEWLkPH855nUnsCCG7rJyx0sg20S+d0YeGEkUg=;
        b=YhC/taODDpe6B5NzumgTmgAaIK74yfrG4Q7zIPy3VdgqSTDC5QaQgp5MutJzgHzE77
         RFGqOcqDvSglUx+8NNaR5SPLNO4ofUUQD3xtizmU9GVZOrwqJVllEbo8Zw5xpCOGyw+7
         y0INERdS/Q+x6l204Ps33ryQWy0djwJaDd3AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187739; x=1729792539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV2LniEWLkPH855nUnsCCG7rJyx0sg20S+d0YeGEkUg=;
        b=nrKYisVkJXQMHhTKxagSQTTJTTs6jTT/EaA4kEwNWgmgCdAX8XKICULa4QC8hkoLXb
         +y0ISFSdfQSAtaYFT3rSyuyVLjbD0SsiRM5jePSgXTzlsd9t0sGtIJrQcZNln4lb/MU6
         fSvhMQStWnL2mDDtm3nOO/5x6DyjorgmrHegUcM94bqxF6/g3tnHjH1hjdHCrf6F0Obc
         KymJHuO+EOlP8z8Lt/8Rkpv3920N8q7xhJMdGIhV2p/y1Gn3vDflcm6v24evy2yQVnrj
         +gMhxbBj+htZeZjiCb5q0GI0ybVvWQJ/T197C0lr91m7//isdRqAyFucagGy6mGnRaAo
         OUXA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxGlNke6F5UPSdwChUWKBONyFek3+NSewTGA9EJdGrQIFz6jcZ2M0Ui7cMLWtLGWsx1yhMnkarWNENlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEtjUdF2xQ5KI2b352svs7E1wCY15zFALHc1a30aoS8O72WqI
	UF3pBzJ3R57YgoXE6lc8NrgUzRc8wSDkstmFxKNlBzWasNBqqmRrfmIcVDDa1ZEdY9GoI3sjAA0
	zJfQDcsvVmcrb1CbaUEaaXDT+Gd+iZTl6pXsm
X-Google-Smtp-Source: AGHT+IG1jnuyXq9h1zekOO3y6RFjOI6Iala9ya9n67hTOr784Ns2zKDWY0KFsm5CsP7P3OWhBSUD6pMkFv9SEFlmAEM=
X-Received: by 2002:a05:6870:89a5:b0:277:f3f6:8c5b with SMTP id
 586e51a60fabf-2890c66ed7cmr1087574fac.4.1729187738983; Thu, 17 Oct 2024
 10:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com> <20241016201719.2449143-2-Liam.Howlett@oracle.com>
In-Reply-To: <20241016201719.2449143-2-Liam.Howlett@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 10:55:27 -0700
Message-ID: <CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:17=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> vma_to_resize() is used in two locations to find and validate the vma
> for the mremap location.  One of the two locations already has the vma,
> which is then re-found to validate the same vma.
>
> This code can be simplified by moving the vma_lookup() from
> vma_to_resize() to mremap_to() and changing the return type to an int
> error.
>
> Since the function now just validates the vma, the function is renamed
> to mremap_vma_check() to better reflect what it is doing.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mremap.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5917feafe8cc..648c29f568af 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -826,17 +826,12 @@ static unsigned long move_vma(struct vm_area_struct=
 *vma,
>         return new_addr;
>  }
>
> -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> +static int mremap_vma_check(struct vm_area_struct *vma, unsigned long ad=
dr,
The original function is vma_to_resize, and mremap_vma_check is
missing this context.
Maybe mremap_vma_check_resize is a better name ?


>         unsigned long old_len, unsigned long new_len, unsigned long flags=
)
>  {
>         struct mm_struct *mm =3D current->mm;
> -       struct vm_area_struct *vma;
>         unsigned long pgoff;
>
> -       vma =3D vma_lookup(mm, addr);
> -       if (!vma)
> -               return ERR_PTR(-EFAULT);
> -
>         /*
>          * !old_len is a special case where an attempt is made to 'duplic=
ate'
>          * a mapping.  This makes no sense for private mappings as it wil=
l
> @@ -847,37 +842,37 @@ static struct vm_area_struct *vma_to_resize(unsigne=
d long addr,
>          */
>         if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
>                 pr_warn_once("%s (%d): attempted to duplicate a private m=
apping with mremap.  This is not supported.\n", current->comm, current->pid=
);
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>         }
>
>         if ((flags & MREMAP_DONTUNMAP) &&
>                         (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>
>         /* We can't remap across vm area boundaries */
>         if (old_len > vma->vm_end - addr)
> -               return ERR_PTR(-EFAULT);
> +               return -EFAULT;
>
>         if (new_len =3D=3D old_len)
> -               return vma;
> +               return 0;
>
>         /* Need to be careful about a growing mapping */
>         pgoff =3D (addr - vma->vm_start) >> PAGE_SHIFT;
>         pgoff +=3D vma->vm_pgoff;
>         if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
> -               return ERR_PTR(-EINVAL);
> +               return -EINVAL;
>
>         if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
> -               return ERR_PTR(-EFAULT);
> +               return -EFAULT;
>
>         if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
> -               return ERR_PTR(-EAGAIN);
> +               return -EAGAIN;
>
>         if (!may_expand_vm(mm, vma->vm_flags,
>                                 (new_len - old_len) >> PAGE_SHIFT))
> -               return ERR_PTR(-ENOMEM);
> +               return -ENOMEM;
>
> -       return vma;
> +       return 0;
>  }
>
>  static unsigned long mremap_to(unsigned long addr, unsigned long old_len=
,
> @@ -936,7 +931,13 @@ static unsigned long mremap_to(unsigned long addr, u=
nsigned long old_len,
>                 old_len =3D new_len;
>         }
>
> -       vma =3D vma_to_resize(addr, old_len, new_len, flags);
> +       vma =3D vma_lookup(mm, addr);
> +       if (!vma) {
> +               ret =3D -EFAULT;
> +               goto out;
> +       }
> +
> +       mremap_vma_check(vma, addr, old_len, new_len, flags);
>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>                 goto out;
> @@ -1114,11 +1115,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsig=
ned long, old_len,
>         /*
>          * Ok, we need to grow..
>          */
> -       vma =3D vma_to_resize(addr, old_len, new_len, flags);
> -       if (IS_ERR(vma)) {
> -               ret =3D PTR_ERR(vma);
> +       ret =3D mremap_vma_check(vma, addr, old_len, new_len, flags);
> +       if (ret)
>                 goto out;
> -       }
>
>         /* old_len exactly to the end of the area..
>          */
> --
> 2.43.0
>

