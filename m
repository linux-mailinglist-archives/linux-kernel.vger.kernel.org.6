Return-Path: <linux-kernel+bounces-418448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3139D61BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A2DB238E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6D1DE4E4;
	Fri, 22 Nov 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fws+ci9e"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A11DF725
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291946; cv=none; b=fKOnIvajNbHZf/bVRyEYrZ0bKkzgszYOqg171KJHKrLADFu70TwRP/Hwm0ehbQ28AGzhWHOvh3gXr3ENzmV0rtrf375lrmy44Xsnd/T9ArYY71vdiiOfPoxN7FPcKkpqgsFTJWJ9X0FGfDQvQ84zFH3zl8x616d/+X2j/IrIloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291946; c=relaxed/simple;
	bh=t+xHaPJn+aBO/1HexSeUaXRJXvU0uk3Kg5swCH1uZ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPs5Vjb6xylMpXJC6FLlK9SaPXPtJqHXa9ki5SMe65KXJv2AncYqpfeyY26FTi56NCI0Zm8fRPMyRzdTS1e33T4U/fnVsGlxLan9ceoWqHwy7ZrAG765qLjdm/xocQ86diyY4Ld5BdVZeLHW5oOYmrUR0QRNT+UaSFi1y2WBgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fws+ci9e; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so354581cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732291944; x=1732896744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiRWtemmqn+z4o6vwHxUm8iWulIzPxdfPpLxZXu/fmo=;
        b=fws+ci9esWqoDzIcphL9QDZUdXqWcsPydHo6rHHJdvV6GwIDyTlzcgal33GoFk4Wk2
         kS3IBhCVRYt3RITJW7PHTdSrXINrJsDTQcdxkP4UyBc8Y4hfpfwHzCyl4x+YZXzbNuSB
         in5JpTzbbpCyPt9leHm68p7eOcKQuz3axzeuI6VVnbApGHIEr0sg82L5P4v7+1UKf4Si
         bPr2gIkLPvekc9FROuFgj32VbtaV91Bz9LESZB9Iy+RoVg1RjB0FgevSSKLvbmVIhika
         iVnWsxuIkYVa8hslIc/MpAqgpfm+bc38WAJOhuT49sEwVu9dTQd7hZFjUTT13n9VG/CR
         MAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291944; x=1732896744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiRWtemmqn+z4o6vwHxUm8iWulIzPxdfPpLxZXu/fmo=;
        b=WrBHR/x8wqGMUscCXaXMnFd2efzmbV8bYYl1kfeqg5CBAOLdBpjabcqkYktuz/lqsz
         urx6fCcU7hHuIs5Tb0EiI9tOkW/+3MwXFeVlSPkjAKyIhqygbaBoOJK+LRve+ZyaiEhp
         F48cmQRrhc7p8RIWFkaUBEq0zS0pmYIOy6ZrtHwAj/TcQl7X5nf6W2k/Etq5mRSgJgHz
         QtnH+mljRQ3QLvhQ42w0PtK06Fg5L9ZWfi2njFDby2fDrTm6Z6L5Yx4oqvtawOIuuD97
         dVU4hOW4TqeRXqTAmDcxYHuEZs04dcxA/G5DQt8mV0VFIm1LQVWvDf9ZPPhb3AC+hKSM
         1USg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEPmC0GNP8K5H+8+H+c6ycNqf+16+L9JlIkgjo9dR8BmkTWFaDIyRtB9YxCZBYj84ceuH6T/xts/W4FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9q0vqnta7zLF+jcA3ihvK4rnE6d6o/ADM0r7pTP83K6CdDID
	fKc1Fq+D2VBOOpGNeh/AArNllnFXT1LA0qwC2MmDwgNgxqbKsEpwhzSICa27VBhVelKb1C/pdBf
	TlvQkM1JBaim97mtzWEfKeHsLP8fJACH85a7G
X-Gm-Gg: ASbGncsO8o1U0NYyrtJb2FZ+GXjX6khg0NKT5KvISTUNRK2l8loPNwHzK0UllglPYPy
	hmm8/znWxT9+dOmzCBxbQu0vNk7fJeBI=
X-Google-Smtp-Source: AGHT+IGXbe+Ue8/4QWXiMsR58H556gIwLAsTAOv+QAHDfMFJ5mfBQ//pwjbwp4LdMLcQkJtmcuC4hWmnsc8oJ8AGsLU=
X-Received: by 2002:a05:622a:1190:b0:463:9616:c1fa with SMTP id
 d75a77b69052e-4658aaed9e3mr3045961cf.7.1732291943605; Fri, 22 Nov 2024
 08:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com> <20241119183250.3497547-10-cmllamas@google.com>
In-Reply-To: <20241119183250.3497547-10-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 08:12:12 -0800
Message-ID: <CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEGzTSyoHFYPA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] binder: use per-vma lock in page reclaiming
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:33=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> Use per-vma locking in the shrinker's callback when reclaiming pages,
> similar to the page installation logic. This minimizes contention with
> unrelated vmas improving performance. The mmap_sem is still acquired if
> the per-vma lock cannot be obtained.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index aea35d475ee8..85753897efa1 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1129,19 +1129,28 @@ enum lru_status binder_alloc_free_page(struct lis=
t_head *item,
>         struct mm_struct *mm =3D alloc->mm;
>         struct vm_area_struct *vma;
>         unsigned long page_addr;
> +       int mm_locked =3D 0;
>         size_t index;
>
>         if (!mmget_not_zero(mm))
>                 goto err_mmget;
> -       if (!mmap_read_trylock(mm))
> -               goto err_mmap_read_lock_failed;
> -       if (!mutex_trylock(&alloc->mutex))
> -               goto err_get_alloc_mutex_failed;
>
>         index =3D page->index;
>         page_addr =3D alloc->vm_start + index * PAGE_SIZE;
>
> -       vma =3D vma_lookup(mm, page_addr);
> +       /* attempt per-vma lock first */
> +       vma =3D lock_vma_under_rcu(mm, page_addr);
> +       if (!vma) {
> +               /* fall back to mmap_lock */
> +               if (!mmap_read_trylock(mm))
> +                       goto err_mmap_read_lock_failed;
> +               mm_locked =3D 1;
> +               vma =3D vma_lookup(mm, page_addr);
> +       }
> +
> +       if (!mutex_trylock(&alloc->mutex))
> +               goto err_get_alloc_mutex_failed;
> +
>         if (vma && !binder_alloc_is_mapped(alloc))

On the previous version we had a long discussion about this
binder_alloc_is_mapped() check and that it works here only because
binder does not allow to map the same buffer more than once (the
alloc->buffer_size check inside binder_alloc_mmap_handler). If not for
that limitation the following race could have happened:

  Proc A                          Proc B
                                  mmap(addr, binder_fd)
  mmget_not_zero()
                                  munmap(addr) // alloc->mapped =3D false;
                                  ...
                                  mmap(addr, other_fd) // mmap other
vma but same addr
                                  mmap(other_addr, binder_fd) //
alloc->mapped =3D true;
  vma =3D lock_vma_under_rcu(addr)
  if (vma && !binder_alloc_is_mapped(alloc)) // yields true but wrong vma

I think adding a comment before binder_alloc_is_mapped() check would
help to avoid confusion in the future.
Other than that:

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>                 goto err_invalid_vma;
>
> @@ -1163,7 +1172,10 @@ enum lru_status binder_alloc_free_page(struct list=
_head *item,
>         }
>
>         mutex_unlock(&alloc->mutex);
> -       mmap_read_unlock(mm);
> +       if (mm_locked)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>         mmput_async(mm);
>         __free_page(page);
>
> @@ -1173,7 +1185,10 @@ enum lru_status binder_alloc_free_page(struct list=
_head *item,
>  err_invalid_vma:
>         mutex_unlock(&alloc->mutex);
>  err_get_alloc_mutex_failed:
> -       mmap_read_unlock(mm);
> +       if (mm_locked)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>  err_mmap_read_lock_failed:
>         mmput_async(mm);
>  err_mmget:
> --
> 2.47.0.338.g60cca15819-goog
>

