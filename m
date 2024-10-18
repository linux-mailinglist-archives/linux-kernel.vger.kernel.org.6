Return-Path: <linux-kernel+bounces-372182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E169A455D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22F5281022
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0C20400F;
	Fri, 18 Oct 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnaIJb93"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8D8472
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274508; cv=none; b=c3i6eIVA6rFWPeB8c6cc4RyNAcNekPtiX0/kUdJKnS4GTthirciN3vwWjrv6yYFS6WcnqoKSyVydJ7VF6DGJDne9DSPl9820lF3sXOWf5SZUAR+xgwAdgE2zDWM+DxbrK33BJ11tYPK2gBKtpEJd2Bq4zRLJNP+7qqPVw8O0DIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274508; c=relaxed/simple;
	bh=K9iP6PdeQgdWCq3Rbuk861TAHFq5xMTtm7aZZ9cx9B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/R++Jt+XpovD0QK+DsLWdPQ7UFX18fgXwK0xQryelCHFagGFualim1tT5hteiyPRrCrlDUEjaDMp4rYp7tvqcBhZe5LO2ZrDNwtiZdzofetaQVPsKNnAvwEaYYRe1NJWo3lofrCy0mkwNgv7f24TqIDPqHsT9uIgSt/sex2ZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnaIJb93; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a628b68a7so238126366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729274505; x=1729879305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZP1PTg8KCruR+VGTNIQOL+OxzWxissRAP6zaBFG7zk=;
        b=hnaIJb93PPiW099TQVkNDQogKMOJoPNDRxaYToYGlUo98Qmb9juBEAZOLfnc1UIkba
         /himX4x/6Gk4YZkao5TzzsjVrCGd4z69eX47473apu+y2b0olU7z5igwVMlOdkx/phXi
         gG+BbxvoE1OSkmcvUAjeJZfoCDRrPXIhTLs+BPqcFrmhnUZ05Qd2fHsEEb3foghq6oL8
         uyv5yVmoWbX/xU6I+mtx8SwhgHhqmN+ZSLAR/1k4Uk9AXCAFGjw5JK0qEh8DsLSTKgy8
         rNyePKqjGGHDmxhnCYNxg/Ua8gcoCpcmlXndSIzEOiGd6aLlSMsVKvT3mNACh4Hq6O4E
         fmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274505; x=1729879305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZP1PTg8KCruR+VGTNIQOL+OxzWxissRAP6zaBFG7zk=;
        b=vg2Vgd9iekX6Ppc7EFUKU4AOX0OYPigo0p7LNpb8xzQo7z+/PqouLiCO436eJwDelZ
         rJKikTvbC4s0VOFqsgPdqIa2dWfR2PrKbNb8jiCeOHVSqHdwB8wFrBnJVjglKVzwHYHT
         /i0ZVCpr+gh/9cmqo4iLPjJn9FmdHf+LIR47Q7mHnrqF8vqpiyM2x+lzSRAcpCwnbqjq
         kET9NIm8lPh7jY9EWkL0rzMV0tqLxOJgjFPosEpwUhhbsEpF3HwaSSJjb71SeKqTBKDr
         CcUcZ+hJDRLtpm1IeeQ9cZimwDRojPSdjYsY5YHeKWtTRPn60g9v+n/Sae/a7DOKdFk2
         CSjA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZQSzimsJfziCGKhvf8PNVKv2qo03T8HomhhIf8BqdFC4Vyy0qrW/LErln7MhG/HXK+7f/2g9+uTmQCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lwYb75Y5Qk+J4ZTUoMwemm83ydaw7MCoMGiztSq9TAs/YCe8
	GX+ybNu7wR8RWFGq+MgC3piB3c114I6/xFxBmi1G3199C2JMLxuOLrPx9VPAkPHADhxoCai2Wrq
	w08ObpR/MOjm9/CjlMx4TDRdHhT8=
X-Google-Smtp-Source: AGHT+IGZ44anXLhHUZ28NxKBH31ZqRaXFtBonich+uDZLtBgQ1AQa2zbPcfX7utnzYulvJaeNlvWjptZ3Rcie9K/Jes=
X-Received: by 2002:a17:906:4788:b0:a99:d797:c132 with SMTP id
 a640c23a62f3a-a9a69a6605dmr279322866b.16.1729274504774; Fri, 18 Oct 2024
 11:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729218573.git.baolin.wang@linux.alibaba.com> <e8863e289577e0dc1e365b5419bf2d1c9a24ae3d.1729218573.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <e8863e289577e0dc1e365b5419bf2d1c9a24ae3d.1729218573.git.baolin.wang@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 18 Oct 2024 11:01:32 -0700
Message-ID: <CAHbLzkopxqo+5BTcqf_M7Enn2+0K1TvtTeW2wiLicySac3B1mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: shmem: update iocb->ki_pos directly to
 simplify tmpfs read logic
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:00=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Use iocb->ki_pos to check if the read bytes exceeds the file size and to
> calculate the bytes to be read can help simplify the code logic. Meanwhil=
e,
> this is also a preparation for improving tmpfs large folios read performa=
ce

s/performace/performance

> in the following patch.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

The patch looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/shmem.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 66eae800ffab..93642aa8d1aa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3106,27 +3106,19 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
>         unsigned long offset;
>         int error =3D 0;
>         ssize_t retval =3D 0;
> -       loff_t *ppos =3D &iocb->ki_pos;
>
> -       index =3D *ppos >> PAGE_SHIFT;
> -       offset =3D *ppos & ~PAGE_MASK;
> +       offset =3D iocb->ki_pos & ~PAGE_MASK;
>
>         for (;;) {
>                 struct folio *folio =3D NULL;
>                 struct page *page =3D NULL;
> -               pgoff_t end_index;
>                 unsigned long nr, ret;
> -               loff_t i_size =3D i_size_read(inode);
> +               loff_t end_offset, i_size =3D i_size_read(inode);
>
> -               end_index =3D i_size >> PAGE_SHIFT;
> -               if (index > end_index)
> +               if (unlikely(iocb->ki_pos >=3D i_size))
>                         break;
> -               if (index =3D=3D end_index) {
> -                       nr =3D i_size & ~PAGE_MASK;
> -                       if (nr <=3D offset)
> -                               break;
> -               }
>
> +               index =3D iocb->ki_pos >> PAGE_SHIFT;
>                 error =3D shmem_get_folio(inode, index, 0, &folio, SGP_RE=
AD);
>                 if (error) {
>                         if (error =3D=3D -EINVAL)
> @@ -3148,18 +3140,14 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
>                  * We must evaluate after, since reads (unlike writes)
>                  * are called without i_rwsem protection against truncate
>                  */
> -               nr =3D PAGE_SIZE;
>                 i_size =3D i_size_read(inode);
> -               end_index =3D i_size >> PAGE_SHIFT;
> -               if (index =3D=3D end_index) {
> -                       nr =3D i_size & ~PAGE_MASK;
> -                       if (nr <=3D offset) {
> -                               if (folio)
> -                                       folio_put(folio);
> -                               break;
> -                       }
> +               if (unlikely(iocb->ki_pos >=3D i_size)) {
> +                       if (folio)
> +                               folio_put(folio);
> +                       break;
>                 }
> -               nr -=3D offset;
> +               end_offset =3D min_t(loff_t, i_size, iocb->ki_pos + to->c=
ount);
> +               nr =3D min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE=
 - offset);
>
>                 if (folio) {
>                         /*
> @@ -3199,8 +3187,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
>
>                 retval +=3D ret;
>                 offset +=3D ret;
> -               index +=3D offset >> PAGE_SHIFT;
>                 offset &=3D ~PAGE_MASK;
> +               iocb->ki_pos +=3D ret;
>
>                 if (!iov_iter_count(to))
>                         break;
> @@ -3211,7 +3199,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)
>                 cond_resched();
>         }
>
> -       *ppos =3D ((loff_t) index << PAGE_SHIFT) + offset;
>         file_accessed(file);
>         return retval ? retval : error;
>  }
> --
> 2.39.3
>

