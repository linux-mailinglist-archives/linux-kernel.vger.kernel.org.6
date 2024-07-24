Return-Path: <linux-kernel+bounces-261272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9E93B501
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E4FB20F79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8EC15ECE7;
	Wed, 24 Jul 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4Fkg0DK"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB72E639
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838608; cv=none; b=TxNwc5v/xqoOt/Q0+cBmYxC/tpTIE5/XdRdc8MQzQFVJ4oiQJC8mkCzw5VRjW+OXfSWh9qkqilSILomI1aQoCIhzoLJIz8/acvO++Y7QH5qSvJ598RX3HSKi1rpENj8Im7ogBkP9Xy5p1p2tKX18NCT3Q1IgfuqfjcdVI4wcTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838608; c=relaxed/simple;
	bh=tYVe7xtxs+6Ozagku33GS/kQkY3ilWBU+/QqjT05Ncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtVsAWOquB+K/4zd8k1u6k3Md3Bq2Rm7cd+Xei1gbg8dKellBmLKOAzufre4Xoq52vDmlJxKr9dspxIMz1v6v9GZK2Tw+er5d4la+wQEV0uQaYMXtU/K0/NubIWzp/2w1Vg8GiOHOkugqMAoAz9B4J3iEYL5T45UNAQVH1wkMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h4Fkg0DK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-264988283a3so267516fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721838606; x=1722443406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7lztNYuEo9tOgjlTQamOhpPHgaWKhp9X0WW2dkz7Ls=;
        b=h4Fkg0DKFslA4ukcyLxsUIY51NXRs12qHEQ+xo2+3BB2ADwLFrE1oVucLWZMWuG8K2
         Bjgsfmsp9FQYwtprNrSuIu4b7cnFcHA7lbbXHsBaMljrPm+TEENvvHWSkw60ORv26V4/
         okqY2evIhZWEfYCHlBHxAwF7p4gQ2DWamK1I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838606; x=1722443406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7lztNYuEo9tOgjlTQamOhpPHgaWKhp9X0WW2dkz7Ls=;
        b=R7ABD40gy86ahyj1kDObMMLE/h2YNzDg4+WyB0PPrqiHs3pa0i+o5JfSWarc+OypNG
         NyWICxSUTtZ+HP4iyl/cnzH1jlh0Z6A8SWpKhSOckDnDwSg/I0XLVbRwUic88HtU3GJZ
         8uzk46I/o0tV521Et/nsE8vVswCawl2KA9kJvgMQDINFBW/gXr64+Oglehxh+0RqaAfq
         SdujEfH/wOt0jSk2UKIbNswZwafq5n/CUHbVXC6GCVM0A6zysRVkQ7Re0W31u45zD2AL
         yW4xrxZjOOvifOKa7in9qb1ZrMJnt7LNXXdrO5dE5xs2CutLW6HSbW02UakJYeF0g7t2
         oi/g==
X-Forwarded-Encrypted: i=1; AJvYcCUBuGmwYA6LMhARzv8B0ejqbJAIG2uPL3Cs/jX4ODzoDv6PW1QdZ6L42NXkDBw5viE5pCZwaDftH+ZxWkoHIjU2oNr3VHrD5TFhl7AA
X-Gm-Message-State: AOJu0YxMafQ5Hjh0vQs5xALNAR44WML7DSfPyxn9GIpZZ3marzVfPuEU
	LTv+O3uTdI1Dd1SnC3tZ0GYBjTCt33KipsfpQQ0q0B33fY6ubloupMvJ2nRc8i8A9jFzSIEW2I4
	9/+Q8is8t9MOiCKePsVoMYm60RIzNM8cerMqx
X-Google-Smtp-Source: AGHT+IGTs9hbXCcXTvWGTuOfb3UV63tLQO/iESik52wc/sl1W1vgwk59lj8KonlEInLeG+Ynz7uDRPcWurMwZ0i5H2s=
X-Received: by 2002:a05:6870:ac11:b0:25d:ff4c:6772 with SMTP id
 586e51a60fabf-264a0b7ef07mr52142fac.3.1721838605745; Wed, 24 Jul 2024
 09:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com> <20240717200709.1552558-19-Liam.Howlett@oracle.com>
In-Reply-To: <20240717200709.1552558-19-Liam.Howlett@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jul 2024 09:29:53 -0700
Message-ID: <CABi2SkWmapK-_BpFsh_z8WAkARLjURDSkF+iCE1kTdhn3uYMSQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/21] mm/mmap: Move can_modify_mm() check down the stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Without an arch_unmap() call so high in the call stack, the check for
> mseal'ed vmas can be moved lower as well.  This has the benefit of only
> actually checking if things are msealed when there is anything to check.
> That is, we know there is at least one vma that is in the way and needs
> to be checked.
>
> Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
> case of mmap_region().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Jeff Xu <jeffxu@chromium.org>

> ---
>  mm/mmap.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 117e8240f697..a32f545d3987 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2877,6 +2877,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         struct vma_munmap_struct vms;
>         int error;
>
> +       /* Prevent unmapping a sealed VMA. */
> +       if (unlikely(!can_modify_mm(mm, start, end)))
> +               return -EPERM;
> +
It is nice to consolidate the check for do_vmi_align_munmap and
do_vma_munmap to single check.

>         init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
>         error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
>         if (error)
> @@ -2927,13 +2931,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct=
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
> @@ -2991,13 +2988,15 @@ unsigned long mmap_region(struct file *file, unsi=
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
So the optimization here is : when no vma  found in the given addr
range =3D> no need to call can_modify_mm.

>                 mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLA=
GS_LOCK_MASK);
>                 mt_on_stack(mt_detach);
>                 mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
> @@ -3370,13 +3369,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct=
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

