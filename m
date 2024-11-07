Return-Path: <linux-kernel+bounces-400159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290D9C09B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964DA1C23B50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60865212F00;
	Thu,  7 Nov 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzsaKJuy"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC80213140
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992243; cv=none; b=qqM+rS98KoOjbwQxz+RDjsk2vzxD5dCfXoxc49QH6wupjo9lRh+Tv3zwXNsMWg7mxlSdPPyljhD/LyENoVSq16uKiAB2u0MDInPlSDoNy6kndmzNgP1PnsHV8lFOpADp2wkitBMk5LkNWixiw81v0AGo+dpcw02Kwdo4UqddTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992243; c=relaxed/simple;
	bh=QknDFhNYUcBaifmU1XtPJ8fGhCQcNRSPymYyDljX9g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYaRxl00pAm24Zq7+KYrK1W2eNPsqIMIuLTpcHshLF/wuuii6IR/HIIjjX19Z4p7T0diWp5B+AEq3lx7JVlf310gGt/+6vVO1Ed8R7yGRHwUVDLOkakrxJZDa6wiE9Q3CJmAwdXLWebFj9K92zJgB9Dyscw/ynb9z4qi+Mkdggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzsaKJuy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608dddaa35so347281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730992240; x=1731597040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rECoRGHgSDvZMIu1ke3wsM/2ntlxOGnMeqpylrFrZyc=;
        b=AzsaKJuyHCke3zIFkjxjwo7SjKFu+1uvyAs7o6UCpLXQ3UuOYZZhCtRs8i4UCEbKB1
         nsGxodr/HEaBHgnxpGkr2qW7+8KNiANF3ArAVzBX0mQ9Wf84tUCrZU0mBxxW/d44v+0t
         TSnLYD7E4rE3DpIP64p7vSdeh06m4m8Q2xzRsFpI+G8dlYsvmgACJBR2pyL9lOASvv4r
         a+TWU64/m7it7whidoWskYh2F0S0kYc/BbQbuiVgiJT2bElmqUMNTYR96hqFGw+cE6KP
         SmgSTv8yq5sxgsBEDJIvKo2HfR+sqe/0BriYTJxgulJLS6prBC8q+mteMiQmkFvGi9nt
         c5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992240; x=1731597040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rECoRGHgSDvZMIu1ke3wsM/2ntlxOGnMeqpylrFrZyc=;
        b=uPgR7guvr9xJKyMq8OB29iZnkNY/6iIv+wN8V1sxxsuZ0jqV+BoasWdoF7nTz9fq4i
         Hp1pV0LsFFu9onL0WqUXmYQY+M/zA/w4W8IGs4BltitxDs6ZlsoEl542AKGqdsjBY7lB
         UAj4TaYke3vMbIfOLWSjLk6zFK3+qxNFh152VShKXPPwGUOJEAISDgBQ9zYg9V5qw+8s
         a2JXYWtB0wh6aV9OiYLgsKyOiZLUMDsEP7CUJUlTRB8iaAVsnxBnkyA4Y5tq3FAu/t/a
         XwvnAT5OcvwQeTq09WBX1kG4VZvhAuTas3K80M9BehBDb8lD8Dv3eR46mPIYKUU/CRer
         Hb9A==
X-Forwarded-Encrypted: i=1; AJvYcCVPkSuyJ5nvKf8mot6GxW2nR4RQWnZ7gaomkk4+4+xekJwx3nXX5//+mwgQTLQ/FfZqEMYJBYlLHqaXFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZFSUXGfaPT2FNiEfX3gyKg377eQx1Ws8FR+D5A5wPeoLo+rE
	m53AcUcBxghdupbgO17tjb9ABhwDnpg6mX71qHgRtc3M0dIKMDy+6GVltXrzgjotXYKcquNQWRR
	choGST5BpCHGw4EAgDsaM5NLsdclG3W9VX7l8
X-Gm-Gg: ASbGncsTr2SWyWC1odhEJVsouFYEgIUooYZRY/KrLd0KwiqEvjSF4ZcEkWUKuxGiV3A
	2jVL5o7RSJGLAQ4NUG9nidS4TpTeeqdoDndm3btG4SUokRq+I6xJrsuzI6Q2j
X-Google-Smtp-Source: AGHT+IGsHIRNpHvfkKtMpQLCLi66RlGi+x8YwqmM5CEQuwjYqTwAPWSXtPCK5+9+Gg8IRiu5d5WENkoC1DVzFEtxbUs=
X-Received: by 2002:a05:622a:189e:b0:461:39e0:5ece with SMTP id
 d75a77b69052e-462fa56633fmr4756901cf.1.1730992239371; Thu, 07 Nov 2024
 07:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-3-cmllamas@google.com>
In-Reply-To: <20241107040239.2847143-3-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 07:10:28 -0800
Message-ID: <CAJuCfpGAr=Tm=JJtnrJ0ipFo2yqYSEVAMtx5aUU-k1F6prjYjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] binder: concurrent page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	David Hildenbrand <david@redhat.com>, Barry Song <v-songbaohua@oppo.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:02=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> Allow multiple callers to install pages simultaneously by downgrading
> the mmap_sem to non-exclusive mode. Races to the same PTE are handled
> using get_user_pages_remote() to retrieve the already installed page.
> This method significantly reduces contention in the mmap semaphore.
>
> To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> operating on an isolated VMA. In addition, zap_page_range_single() is
> called under the alloc->mutex to avoid racing with the shrinker.
>
> Many thanks to Barry Song who posted a similar approach [1].
>
> Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.co=
m/ [1]
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 7241bf4a3ff2..acdc05552603 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -221,26 +221,14 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
>                                       struct binder_lru_page *lru_page,
>                                       unsigned long addr)
>  {
> +       struct vm_area_struct *vma;
>         struct page *page;
> -       int ret =3D 0;
> +       long npages;
> +       int ret;
>
>         if (!mmget_not_zero(alloc->mm))
>                 return -ESRCH;
>
> -       /*
> -        * Protected with mmap_sem in write mode as multiple tasks
> -        * might race to install the same page.
> -        */
> -       mmap_write_lock(alloc->mm);
> -       if (binder_get_installed_page(lru_page))
> -               goto out;
> -
> -       if (!alloc->vma) {
> -               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> -               ret =3D -ESRCH;
> -               goto out;
> -       }
> -
>         page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
>         if (!page) {
>                 pr_err("%d: failed to allocate page\n", alloc->pid);
> @@ -248,19 +236,47 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
>                 goto out;
>         }
>
> -       ret =3D vm_insert_page(alloc->vma, addr, page);
> -       if (ret) {
> -               pr_err("%d: %s failed to insert page at offset %lx with %=
d\n",
> -                      alloc->pid, __func__, addr - alloc->buffer, ret);
> +       mmap_read_lock(alloc->mm);
> +       vma =3D vma_lookup(alloc->mm, addr);
> +       if (!vma || vma !=3D alloc->vma) {
> +               mmap_read_unlock(alloc->mm);

nit: instead of unlocking here you could have another label before
mmap_read_unlock() at the end and jump to it.

>                 __free_page(page);
> -               ret =3D -ENOMEM;
> +               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> +               ret =3D -ESRCH;
>                 goto out;
>         }
>
> -       /* Mark page installation complete and safe to use */
> -       binder_set_installed_page(lru_page, page);
> +       ret =3D vm_insert_page(vma, addr, page);
> +       switch (ret) {
> +       case -EBUSY:
> +               /*
> +                * EBUSY is ok. Someone installed the pte first but the
> +                * lru_page->page_ptr has not been updated yet. Discard
> +                * our page and look up the one already installed.
> +                */
> +               ret =3D 0;
> +               __free_page(page);
> +               npages =3D get_user_pages_remote(alloc->mm, addr, 1, 0, &=
page, NULL);
> +               if (npages <=3D 0) {
> +                       pr_err("%d: failed to find page at offset %lx\n",
> +                              alloc->pid, addr - alloc->buffer);
> +                       ret =3D -ESRCH;
> +                       break;
> +               }
> +               fallthrough;
> +       case 0:
> +               /* Mark page installation complete and safe to use */
> +               binder_set_installed_page(lru_page, page);
> +               break;
> +       default:
> +               __free_page(page);
> +               pr_err("%d: %s failed to insert page at offset %lx with %=
d\n",
> +                      alloc->pid, __func__, addr - alloc->buffer, ret);
> +               ret =3D -ENOMEM;

vm_insert_page() can return EINVAL (see
validate_page_before_insert()). Instead of converting other codes into
ENOMEM why not return "ret" as is?

> +               break;
> +       }
> +       mmap_read_unlock(alloc->mm);
>  out:
> -       mmap_write_unlock(alloc->mm);
>         mmput_async(alloc->mm);
>         return ret;
>  }
> @@ -1091,7 +1107,6 @@ enum lru_status binder_alloc_free_page(struct list_=
head *item,
>         trace_binder_unmap_kernel_end(alloc, index);
>
>         list_lru_isolate(lru, item);
> -       mutex_unlock(&alloc->mutex);
>         spin_unlock(lock);
>
>         if (vma) {
> @@ -1102,6 +1117,7 @@ enum lru_status binder_alloc_free_page(struct list_=
head *item,
>                 trace_binder_unmap_user_end(alloc, index);
>         }
>
> +       mutex_unlock(&alloc->mutex);
>         mmap_read_unlock(mm);
>         mmput_async(mm);
>         __free_page(page_to_free);
> --
> 2.47.0.199.ga7371fff76-goog
>

