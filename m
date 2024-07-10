Return-Path: <linux-kernel+bounces-247978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15392D6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F531C210B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8283194AC7;
	Wed, 10 Jul 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLeK+XYs"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA5190472
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630097; cv=none; b=EhZ0AlvLn3mXgG6bHNuzPT0QmTVmq/eEI/TqJ2OU1BrRnPwwdY7/DFhgdDswqKngbPCgnDtKTrBY/u4GXZLI5htA0r8yp+9tXWcm00a716vZWwYg+bo9OXBcuUBRrPP42Acel9CDDnieCOzdLzyYfU33qoNaSMS95a22TAugTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630097; c=relaxed/simple;
	bh=aBr2yYvTYdJys4Svg50j/p4d7tTDXOblJFbpEv5+QJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Konw0PECrzk2BFgTsKGtnev67IpS69aApED0Jh/iV9SkPtzl5g2Nu7iKMNRebnICkqBps5WI1xg+adxQAKyn9PbdMpFHh6WrbRBZDPwXjNJOCfi/ZglsebZkjoGfkbg0yXOM91IBmtUxUCArXmJy9AbFnc1rwZWPAdW8UJThuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLeK+XYs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64f4c11d2c9so52718877b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720630095; x=1721234895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuDM3Oavg7a7aWkCZ/CY2yFe5Ng8yBclNy+WY2KUGrU=;
        b=MLeK+XYs+8ABg/TdK91UKMhz0GlYCV61XbH5wMd4OzN0tBsDA9S8MK0jy93R5kRqdt
         4l/wcb2zuCviTEsEmn7zx05k0a9eX2WJxSKL9AWScQUXG5ZFqlO35N/Ddp9laxf6r+Y/
         J+BbJ6Ij+jxHSfBQ6IIQVZNopc6deezqDnym+7t2a+t/2+Y4Shhyu0WEFrcDCG32H0Fv
         228mpB7L9ZBXTFMaXiH2IJxpnvQHa7TGOjOuBjYXk6+V3nJDKlmsr1qmzMzYR9oJyWba
         WB4gU8kjIa0mesp3MfN2oHqFAkVO9DbWXDSrfEQyoTL4CIB8uOKIfPyDsVi4sxV1ahEk
         Zpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720630095; x=1721234895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuDM3Oavg7a7aWkCZ/CY2yFe5Ng8yBclNy+WY2KUGrU=;
        b=gHvrkKX7TGHvKliO7V86Sqs+oJQs7BevdntXePHIL2TbZs5plAZUqDrlZkBRtFn79L
         1QiTfzc8rkm/j5chZQGDPshAgU8I4SPzyhbJC+hJLAwWajujahMJ3MDco6QPxyS5soDM
         JTTNj2sB9+vhI+Qd6ffwExesNB5nSy0jJD5VJlpUtwUD6reTCrrF7k1e5VFbZXIzGZKK
         Nrmpaqo4UfOit10PLEaBssOw8KJEhGSMcG8J4KXeRmEp/c72xCnqV0ykEni9/J6CDOFr
         ENRKW+UNrPzmxYk8lr22PXSqb4Ete/TUwdg24789o0KaOvJdun17vFtNNxzsU06e19Mw
         XOSA==
X-Forwarded-Encrypted: i=1; AJvYcCWPG3w/aV4+FBbwa74jSyShvancejFRFLj6TjMh8Co9ajECtfIfFhqPE/cbVQPINMgUUQzMXUZJuS6NjqmhbVLHjpUXK3oWfVSXRHJ0
X-Gm-Message-State: AOJu0YzRAJqwDAzl5IZpt3eUB6DHsd2uyMsdqfqpqyXaMhu6CZdWbpKb
	mKGgp8QzbmOruJt1bxeO6oaqy13ZtRVGg4qmgIzGLwTMi/OSCN7udGIOebF6jh+GQBJogtCeYbZ
	7fBkrOLcY8W5u287/2kFEAbOfpRPwYD7IPpK9
X-Google-Smtp-Source: AGHT+IEJvx0em+H6LCIgYPFqc5wzIKIKb8/L9hMaxZp+TLpsllYvO+qfvhu+Db/DSgLHIYpVSH8n7AdwjCO1O/h8wRM=
X-Received: by 2002:a05:690c:6112:b0:631:ffc1:4397 with SMTP id
 00721157ae682-658ef34a2e9mr80983457b3.29.1720630094523; Wed, 10 Jul 2024
 09:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com> <20240704182718.2653918-11-Liam.Howlett@oracle.com>
In-Reply-To: <20240704182718.2653918-11-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:48:02 -0700
Message-ID: <CAJuCfpEqJi30kz7Q0ZAJqkDuQH4ng8Wa+x0sK10wVbtQ9wF6dA@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in mmap_region()
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
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of moving (or leaving) the vma iterator pointing at the previous
> vma, leave it pointing at the insert location.  Pointing the vma
> iterator at the insert location allows for a cleaner walk of the vma
> tree for MAP_FIXED and the no expansion cases.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f5b33de4e717..ecf55d32e804 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>                 vms_complete_munmap_vmas(&vms, &mas_detach);
>                 next =3D vms.next;
>                 prev =3D vms.prev;
> -               vma_prev(&vmi);
>                 vma =3D NULL;
>         } else {
>                 next =3D vma_next(&vmi);
>                 prev =3D vma_prev(&vmi);
> +               if (prev)
> +                       vma_iter_next_range(&vmi);
>         }
>
>         /*
> @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
>                 vm_flags |=3D VM_ACCOUNT;
>         }
>
> -       if (vm_flags & VM_SPECIAL) {
> -               if (prev)
> -                       vma_iter_next_range(&vmi);
> +       if (vm_flags & VM_SPECIAL)
>                 goto cannot_expand;
> -       }
>
>         /* Attempt to expand an old mapping */
>         /* Check next */
> @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>                 merge_start =3D prev->vm_start;
>                 vma =3D prev;
>                 vm_pgoff =3D prev->vm_pgoff;
> -       } else if (prev) {
> -               vma_iter_next_range(&vmi);
> +               vma_prev(&vmi);
>         }
>
> -       /* Actually expand, if possible */
> -       if (vma &&
> -           !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next=
)) {
> -               khugepaged_enter_vma(vma, vm_flags);
> -               goto expanded;
> +       if (vma) {
> +               /* Actually expand, if possible */
> +               if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgo=
ff, next)) {
> +                       khugepaged_enter_vma(vma, vm_flags);
> +                       goto expanded;
> +               }
> +
> +               /* If the expand fails, then reposition the vma iterator =
*/
> +               if (unlikely(vma =3D=3D prev))
> +                       vma_iter_set(&vmi, addr);
>         }
>
> -       if (vma =3D=3D prev)
> -               vma_iter_set(&vmi, addr);

Before this change we would reposition vmi if vma =3D=3D prev =3D=3D NULL.
After this change we don't do that. Is this situation possible and if
so, will vmi be correct?

>  cannot_expand:
>
>         /*
> --
> 2.43.0
>

