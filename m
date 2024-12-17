Return-Path: <linux-kernel+bounces-449101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F79F49E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F536188B8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5291F03CC;
	Tue, 17 Dec 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc29Dblk"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCF12C80C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435093; cv=none; b=B79HnEq5thyEozKCMk9J+M5ttV+KN60W/EuA3X38YuPhAYgudwSp3s2T1YMYg4iRCZIiasyCzAR/YpRgK8qhGdAkt+c1N6vlsCqgfqiZ3aYeLIVKVno9asT1Wl8xHVWrfSPU+74YaSjFGqhQ44n2Mf4XtqUOuQ6zJe+9YY6zevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435093; c=relaxed/simple;
	bh=NrV7zWa2cOX+jQ+iJwEyDxFKODIfF/wIulqOnUlHeg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbMdfQDf98y4NjTIl7rX2MK39fvLwqxZ6INRJxSHPGjdLoNjF9fhTbCXWeFjZrAeMzWq8X4c10P5gRzawASe4yPVGZmYp9VGkxIBvUNhYLAa6HMAyUthceoLC4o+mk9x6L/zhI+RVBm66qt+4iX+Ix7Sci4cJo8MG8guda+piAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc29Dblk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467896541e1so224161cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734435091; x=1735039891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD8eqn9xKjeqPVrsxuP1cvZSPzizQuDJa3iQ6IuBE7k=;
        b=jc29Dblkxb7KWgJnS8I88lZbX0uFVJVcPLZRsVI7ZMPUDSdV25ZHVEccsodtPdYBkF
         5IW5FKinXYr20pVAmuuYvxVXyhWbzUQQ9R0DVnxNDdOv/oHWaQ8mMjyyI8EacDJEJ1BW
         jahkXPBj1vTBYG8sfCc6yMyHMU/HTm+fDARj6X6U1x1oXS+kMiYUzp2gHUXIMUvTdqXF
         HasoRR2txsXKwbg7AX5U2w8dQkTw+fSP/O+2tfebPRe/ffMWs1dmu9C/02et8bV8k7RM
         i2+jzEjG7VXVok+CiNuuXomrd8mP3Uwz4bJzxq19VdEwbG7DdODPJ1DXHliF0s8SdWaq
         CsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435091; x=1735039891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD8eqn9xKjeqPVrsxuP1cvZSPzizQuDJa3iQ6IuBE7k=;
        b=vUBw78gs7Fa3JlBjphftF0yU/pxPY1JJEcm3I7bMpfntNCsP9mq8Mp79bON+bo6AUG
         5czQ6Q+9eIMatCpICI4Wc+1Wpeh7DRcNhjtxOZIfd/I3F6IZ0/vLgkwALQq4P9EdRNR8
         yVPeVM0kw6ORB3MVliJ/MamMaLgYiijcTrKeJq3uGs0zl1dIzeYlqs0GhPDKeJ2VXSrl
         5Eng5/jlzpV6tClqPurCSS92OGB2jHjr4vQHZiZ7u7zM9q5E1GKAIV6chlzx3zCqpjBR
         fzguzRhEjD4y3rhREAnAjqSaCA2eIv8z38iUu2piVZ9WaEwZB2Mj8Xa+txWBLJ+BfLOB
         cHVg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Od8a9qp5yp1Xl0ggr4Or0NoAYuxdyX/hUjZPbLqJcYhkAUF2p3Xs/n/Sk0EBRUU4W31CJGOnvvrgQ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/r97QU04W1RRyV5W62KU3Z06dLnPfIUfsvCg0GWrM/BXSosT
	32d87Zo3vOc2G/EwjdLQRqU2xdPMRta6I6aOOnEA7hD9PdcKQprG+FUhOBar1qM+cCTGFupFBgm
	lZfG1/L9Sbxlz0iGpuIn1wWY56D+r6mkvgYo1
X-Gm-Gg: ASbGncv+XKjW6wwi0vnL2uFK54mPkUWHB8PnZApRr7WYmiVFfYffiNVtBRRnkWQBBfl
	ES9HG0r3qYdKufBM3dS7e51aEG4dfersAEvrx9Ow=
X-Google-Smtp-Source: AGHT+IHKHu1IRkhxrihYEwIoqAnGLbuaLzSRpS59Zb04zfEsWUbH7MON2gLm1HCEqY0IL9x+918vOzmCLcWI+leDoFU=
X-Received: by 2002:ac8:5816:0:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-468fb0a6adfmr2640361cf.3.1734435090631; Tue, 17 Dec 2024
 03:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-7-surenb@google.com>
In-Reply-To: <20241216192419.2970941-7-surenb@google.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 17 Dec 2024 03:31:17 -0800
X-Gm-Features: AbW1kvY337jQ0-Qj_UJ_IHTN8osVIPvR_DR3TuoCbJLAyvPh6j1Kj7s-4brW2z4
Message-ID: <CA+EESO5BiPvHSxLtsc-3k4Sv2B09J1MsWzGvCwG-eBh-7rdCyw@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] mm: allow vma_start_read_locked/vma_start_read_locked_nested
 to fail
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:24=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> With upcoming replacement of vm_lock with vm_refcnt, we need to handle a
> possibility of vma_start_read_locked/vma_start_read_locked_nested failing
> due to refcount overflow. Prepare for such possibility by changing these
> APIs and adjusting their users.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  include/linux/mm.h |  6 ++++--
>  mm/userfaultfd.c   | 17 ++++++++++++-----
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 689f5a1e2181..0ecd321c50b7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -747,10 +747,11 @@ static inline bool vma_start_read(struct vm_area_st=
ruct *vma)
>   * not be used in such cases because it might fail due to mm_lock_seq ov=
erflow.
>   * This functionality is used to obtain vma read lock and drop the mmap =
read lock.
>   */
> -static inline void vma_start_read_locked_nested(struct vm_area_struct *v=
ma, int subclass)
> +static inline bool vma_start_read_locked_nested(struct vm_area_struct *v=
ma, int subclass)
>  {
>         mmap_assert_locked(vma->vm_mm);
>         down_read_nested(&vma->vm_lock.lock, subclass);
> +       return true;
>  }
>
>  /*
> @@ -759,10 +760,11 @@ static inline void vma_start_read_locked_nested(str=
uct vm_area_struct *vma, int
>   * not be used in such cases because it might fail due to mm_lock_seq ov=
erflow.
>   * This functionality is used to obtain vma read lock and drop the mmap =
read lock.
>   */
> -static inline void vma_start_read_locked(struct vm_area_struct *vma)
> +static inline bool vma_start_read_locked(struct vm_area_struct *vma)
>  {
>         mmap_assert_locked(vma->vm_mm);
>         down_read(&vma->vm_lock.lock);
> +       return true;
>  }
>
>  static inline void vma_end_read(struct vm_area_struct *vma)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bc9a66ec6a6e..79e8ae676f75 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -85,7 +85,8 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_s=
truct *mm,
>         mmap_read_lock(mm);
>         vma =3D find_vma_and_prepare_anon(mm, address);
>         if (!IS_ERR(vma))
> -               vma_start_read_locked(vma);
> +               if (!vma_start_read_locked(vma))
> +                       vma =3D ERR_PTR(-EAGAIN);
>
>         mmap_read_unlock(mm);
>         return vma;
> @@ -1483,10 +1484,16 @@ static int uffd_move_lock(struct mm_struct *mm,
>         mmap_read_lock(mm);
>         err =3D find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, s=
rc_vmap);
>         if (!err) {
> -               vma_start_read_locked(*dst_vmap);
> -               if (*dst_vmap !=3D *src_vmap)
> -                       vma_start_read_locked_nested(*src_vmap,
> -                                               SINGLE_DEPTH_NESTING);
> +               if (!vma_start_read_locked(*dst_vmap)) {

I think you mistakenly reversed the condition. This block should be
executed if we manage to lock dst_vma successfully.
> +                       if (*dst_vmap !=3D *src_vmap) {
> +                               if (!vma_start_read_locked_nested(*src_vm=
ap,
> +                                                       SINGLE_DEPTH_NEST=
ING)) {
> +                                       vma_end_read(*dst_vmap);
> +                                       err =3D -EAGAIN;
> +                               }
> +                       }
> +               } else
> +                       err =3D -EAGAIN;
>         }
>         mmap_read_unlock(mm);
>         return err;
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

