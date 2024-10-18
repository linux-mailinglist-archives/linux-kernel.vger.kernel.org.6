Return-Path: <linux-kernel+bounces-372236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFC9A4602
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481D81F24753
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F82040A2;
	Fri, 18 Oct 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/3/RdRs"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAD20E312
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276731; cv=none; b=TBCfnpPeuzM1pJUA8jvjLw6gy0IxtRJiK01QKbrpMsERx+Rw41Fkp8rCzKDQiNIc/MFMuApk8ajO1gobfl+N5a0O8Ct4LjeXyrxdDXynHF9Ly+HLzS+YuTq/rNUK2bgGXTDImXtyJ5CqrVVrZNCTZGOnp65ekVpkUKHf/AZUcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276731; c=relaxed/simple;
	bh=kHo1OQsJrlXFRkJFmYFP6Us+kcML//OAoBCwZHeXeFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqz2BJ2mDD4eQgxbB5el92DF7uyvvuvcu7gE9xUHmD2HhEubH2Gg0QBjmlehOSC5XbgRir8mnoZuJEvWV1LWj68/nqw1JEtGX4ZxtWMtZUGgTEASszJ+gQwP9q+Lf8cTyoyLs8S+WvsGJp40Z91U3WsvSGmKokyBiJZEGWjTCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/3/RdRs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so3014310a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729276728; x=1729881528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMfpolUDz42PH58PTzjh3/JFNIGy2P822pqybTHMLv8=;
        b=C/3/RdRsyj9JQPvtVsC+8Vy9UCBCr7zpxRJV1Bn4UJt35QwfzFpdLC5J2p1K8KqOJv
         V1jcdFUwW59TqjhAnt8aRXgpJAoxdkCNz212FMPwhLrM4vy4HrlkQxB6h/R0CpCgydVB
         sf5eWzxrFPBYUbFOaBg9513iVSY6nuR+7I6EoEax8BnHV7BPaihCYZerMkhlry9YrkLC
         zMOMFus0XDJwcODSlfqvQ8uYoH6N21ydBMT2kPMhsZ4uItYD0iMwjDA6x3rx3bfgYIB5
         WKCAoGiCQPRhMpAId/LR6u6//t42i35jQn1zNfE1IzXUCBJbVMrb0fCPgx+G8++N5f5B
         eA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276728; x=1729881528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMfpolUDz42PH58PTzjh3/JFNIGy2P822pqybTHMLv8=;
        b=eybhGVm+opjnylZWwGJ1B20oK2PhVp3Pt9yqUJr3/bwf2MXXnm7yoe5TvyqebXlfH4
         BJuw8Nc5mJit+7Jeif6Nb5bd40+xJJidyU2/D9VG3UC9IhD91AoRoMkJICXCGaeFR8Ok
         Wy9ycurNvb6z1n9rkxyOWYwzFsLx5N0hSRRjxMms7tXQjhxFNCRdaL40gulqcnPorhBI
         aNi5zy3Tktct5exaIa0JD3Sc3a+Y2Ezn5F61Dz64vdWTZXrrDYAEyVvD5Yv3nHyEW1Vi
         EgMtzdiDNwQkM4PN+13AeidZ3VEspPk8OjfQ1wJ7VTxBWKwKZqnoPxKSiu1u+kipFtjT
         odSw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3rumyYRHm4VWoTWCVBe++OjJBWaFbMZE4vdiS6DkLhk8ExhPGas4rcGnxGOzfU1LRgQkFtzDSR9M4Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNHRYLYwnK8va+yUlhE70frNnbFWBiewjPXuYUTYRLBLJ0Uhl
	fs5HImhxFtCvuKehcr5yyZKtrmSWqih6YThO3uuRU1ne8aLoU5QNQrECpFkRXtEHIiEFnw2393e
	yUZp1jdGsJw8+98Qyk8Hzn2XZ0A4=
X-Google-Smtp-Source: AGHT+IGbuXK7Hr1PpEVHlJDYhACH9CtZunSYZeKo0Qsu6JeCnoos2F1D2b3QuxVhegVe8lgQsr6ZS5rsDxzUSELU78k=
X-Received: by 2002:a05:6402:d05:b0:5c8:8db1:1d55 with SMTP id
 4fb4d7f45d1cf-5ca0ac50dd0mr3200061a12.10.1729276727650; Fri, 18 Oct 2024
 11:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729218573.git.baolin.wang@linux.alibaba.com> <2129a21a5b9f77d3bb7ddec152c009ce7c5653c4.1729218573.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <2129a21a5b9f77d3bb7ddec152c009ce7c5653c4.1729218573.git.baolin.wang@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 18 Oct 2024 11:38:36 -0700
Message-ID: <CAHbLzkoEtyKjUCChaAizAAnEXet3519q7Xg4nOm7aE4QdfeFjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: shmem: improve the tmpfs large folio read performance
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:00=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> The tmpfs has already supported the PMD-sized large folios, but the tmpfs
> read operation still performs copying at the PAGE SIZE granularity, which
> is unreasonable. This patch changes to copy data at the folio granularity=
,
> which can improve the read performance, as well as changing to use folio
> related functions.
>
> Moreoever, if a large folio has a subpage that is hwpoisoned, it will sti=
ll
> fallback to page granularity copying.

s/Moreoever/Moreover

>
> Use 'fio bs=3D64k' to read a 1G tmpfs file populated with 2M THPs, and I =
can
> see about 20% performance improvement, and no regression with bs=3D4k.
> Before the patch:
> READ: bw=3D10.0GiB/s
>
> After the patch:
> READ: bw=3D12.0GiB/s
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

The patch looks fine to me. Reviewed-by: Yang Shi <shy828301@gmail.com>


> ---
>  mm/shmem.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 93642aa8d1aa..cbefd9801f6b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3107,13 +3107,13 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
>         int error =3D 0;
>         ssize_t retval =3D 0;
>
> -       offset =3D iocb->ki_pos & ~PAGE_MASK;
> -
>         for (;;) {
>                 struct folio *folio =3D NULL;
>                 struct page *page =3D NULL;
>                 unsigned long nr, ret;
>                 loff_t end_offset, i_size =3D i_size_read(inode);
> +               bool fallback_page_copy =3D false;
> +               size_t fsize;
>
>                 if (unlikely(iocb->ki_pos >=3D i_size))
>                         break;
> @@ -3134,6 +3134,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>                                 error =3D -EIO;
>                                 break;
>                         }
> +
> +                       if (folio_test_large(folio) &&
> +                           folio_test_has_hwpoisoned(folio))
> +                               fallback_page_copy =3D true;
>                 }
>
>                 /*
> @@ -3147,7 +3151,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>                         break;
>                 }
>                 end_offset =3D min_t(loff_t, i_size, iocb->ki_pos + to->c=
ount);
> -               nr =3D min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE=
 - offset);
> +               if (folio && likely(!fallback_page_copy))
> +                       fsize =3D folio_size(folio);
> +               else
> +                       fsize =3D PAGE_SIZE;
> +               offset =3D iocb->ki_pos & (fsize - 1);
> +               nr =3D min_t(loff_t, end_offset - iocb->ki_pos, fsize - o=
ffset);
>
>                 if (folio) {
>                         /*
> @@ -3155,10 +3164,15 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
>                          * virtual addresses, take care about potential a=
liasing
>                          * before reading the page on the kernel side.
>                          */
> -                       if (mapping_writably_mapped(mapping))
> -                               flush_dcache_page(page);
> +                       if (mapping_writably_mapped(mapping)) {
> +                               if (likely(!fallback_page_copy))
> +                                       flush_dcache_folio(folio);
> +                               else
> +                                       flush_dcache_page(page);
> +                       }
> +
>                         /*
> -                        * Mark the page accessed if we read the beginnin=
g.
> +                        * Mark the folio accessed if we read the beginni=
ng.
>                          */
>                         if (!offset)
>                                 folio_mark_accessed(folio);
> @@ -3166,9 +3180,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>                          * Ok, we have the page, and it's up-to-date, so
>                          * now we can copy it to user space...
>                          */
> -                       ret =3D copy_page_to_iter(page, offset, nr, to);
> +                       if (likely(!fallback_page_copy))
> +                               ret =3D copy_folio_to_iter(folio, offset,=
 nr, to);
> +                       else
> +                               ret =3D copy_page_to_iter(page, offset, n=
r, to);
>                         folio_put(folio);
> -
>                 } else if (user_backed_iter(to)) {
>                         /*
>                          * Copy to user tends to be so well optimized, bu=
t
> @@ -3186,8 +3202,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
>                 }
>
>                 retval +=3D ret;
> -               offset +=3D ret;
> -               offset &=3D ~PAGE_MASK;
>                 iocb->ki_pos +=3D ret;
>
>                 if (!iov_iter_count(to))
> --
> 2.39.3
>

