Return-Path: <linux-kernel+bounces-550298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE72A55DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B505F177FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504D17E45B;
	Fri,  7 Mar 2025 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bZRyMzK"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FC1624E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314534; cv=none; b=W9zVLcfGMkAb9w+LH2RJfa6vGnZ14KvDWmdoOMpbOUs0DYPLTdlPYNiYFf9yCppilrS3+vMemSd+YMidPUfEM0pITojnVPIWfsw+/u1b5D3HIqJ7D3GSuf3Z8Z5SELFmjZH8aUKdbe6H1OgUDZdlU53E7Mq012dPK0a3A18zGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314534; c=relaxed/simple;
	bh=PHNRBklgQlxovQ84UyrbxxvlR1CbdJB09I/jjJGSSFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaLfiKFKLZkq452pNZdnKDZMiIw4aLSu1Kkhm4rsPWtK3537ROiYMaWWdcvY1Fdi/sLF1wFEyjrXEs3WRHXFrISIpkBzqX0nIFbr9mOUy5rKijJdeeJPcARH11ctXkxu8M9pbttBCLnUTMR3m/R7rOc95dTjqKHfKzXos6gK8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bZRyMzK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-474fdb3212aso166541cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741314532; x=1741919332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeaol7dKf5hDCsXX8j5PIosUqB5cxOjG0nyihsM76BM=;
        b=3bZRyMzKDYbYDJvxyV5dHWHn+WPoEqxQrbDLEDzDez12VbmvO6241fwfPNwfvbwc3C
         tD3/uRu7aqdOFySYoMDW3AljFf/Nm791sX1D0UEfqxA4LV82EP5xYCuCGxN+sRjEOC79
         WBQetGRIQMRjlMJTKw2VYN8hxQbG0TEJLvn9EAr+cbSaUgNCl7Dz0hgANQ/jk9DTyUtS
         vBewduhGyjun55wN50gAs0kg23vtIn2nXFhLHbewlCUDRJ0lJyDv8X9C966QEGobYQqn
         4/B8QmF5FtzpIkEu1XkYFmCYaHHsz5ylMOzoEtGXDfDEMIQFYGJIJg9Je6VE7fre2dxj
         5QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741314532; x=1741919332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeaol7dKf5hDCsXX8j5PIosUqB5cxOjG0nyihsM76BM=;
        b=IcIoGWSQ707aQwxZkI6WPKAQWEI62SAJeGSUOjQSXKYAGVFDBolssGYYbfdPegyaAn
         UvSb2jo+d9PG5xacPr0jIgYOSm/kp53HKf0hckDor8dqp6nZa07DwNzjuaZkymUarSkD
         SxZQ0rxWdt1x5ReDwkYFYeeO6vSxFPn+NL8zVZZ1roCWAq7wEzzHdp0goeQzePp1m1nx
         BrSE5VliIRQky1gXUyQUfwYuR6JiLPd2v46S+/s+p4V5rjDpElqh3Zt7tOz3Xbg7ufGp
         S47AdqVnMrO/aJ5eXbAnBNB6OKPjabDAJ63IU6YAV6vs9eisUjWHmAkGduULOXaSyuQ/
         kyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbyYsIARw+htUBunR+cn7JIf4gMhzeEoRoChY+HM8AvdcsB7P8sQI4O59gAXDaDGC4//k0XWY9Ox5xvxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyb18X1YGb7E63vqORhYwzzjuuNtbLxe2srf7vu4HBqoVqztU
	XmL8rQa859DxteBuUSjX+cLL4tKgiwu+Y51gy3g3SLT8FLMLfaMO22FR6HQzuhhxKTYMWyiSpzq
	iDrJGxRikyByXYvuW4A3fX9l3P/EXhplJPRl5
X-Gm-Gg: ASbGncue0OStcxgiNeEEwfINTx+madfqxVzAs/d3OeNLUBfpbA8umLmqUvquzbDvPOc
	yZFPkjsYPNHRrBsSpzMTorXrKqAxNkKURRN25B0zWqbkh9nq4QL8dkIErdY9upJ9r2dFIDXXFxy
	iDYMW/MVak41QWtKuPJ59mwg0dvg==
X-Google-Smtp-Source: AGHT+IEcdFFqgoC5v5nk1CqtfLvnIwlJrlCR79p6l3ceXCbmRcL3l4QYeOtwzNSmiBPLUOn0epow5zQ8pU2CygP8kjw=
X-Received: by 2002:a05:622a:48d:b0:46d:f29d:4173 with SMTP id
 d75a77b69052e-47620f3e2dbmr1917281cf.16.1741314531920; Thu, 06 Mar 2025
 18:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com> <848301db8f05$a1d79430$e586bc90$@samsung.com>
In-Reply-To: <848301db8f05$a1d79430$e586bc90$@samsung.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Mar 2025 18:28:40 -0800
X-Gm-Features: AQ5f1JrGamsGt3IZusMGXc8vrCD2-uzcdGon8NJXEfXnTsNUgJLtgPe59GfjDWc
Message-ID: <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Sooyong Suk <s.suk@samsung.com>
Cc: Jaewon Kim <jaewon31.kim@gmail.com>, Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:07=E2=80=AFPM Sooyong Suk <s.suk@samsung.com> wrot=
e:
>
> > On Fri, Mar 7, 2025 at 12:26=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org>
> > wrote:
> > >
> > > On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> > > > There are GUP references to pages that are serving as direct IO
> > buffers.
> > > > Those pages can be allocated from CMA pageblocks despite they can b=
e
> > > > pinned until the DIO is completed.
> > >
> > > direct I/O is eactly the case that is not FOLL_LONGTERM and one of th=
e
> > > reasons to even have the flag.  So big fat no to this.
> > >
> >
>
> Understood.
>
> > Hello, thank you for your comment.
> > We, Sooyong and I, wanted to get some opinions about this FOLL_LONGTERM
> > for direct I/O as CMA memory got pinned pages which had been pinned fro=
m
> > direct io.
> >
> > > You also completely failed to address the relevant mailinglist and
> > > maintainers.
> >
> > I added block maintainer Jens Axboe and the block layer maillinst here,
> > and added Suren and Sandeep, too.

I'm very far from being a block layer expert :)

>
> Then, what do you think of using PF_MEMALLOC_PIN for this context as belo=
w?
> This will only remove __GFP_MOVABLE from its allocation flag.
> Since __bio_iov_iter_get_pages() indicates that it will pin user or kerne=
l pages,
> there seems to be no reason not to use this process flag.

I think this will help you only when the pages are faulted in but if
__get_user_pages() finds an already mapped page which happens to be
allocated from CMA, it will not migrate it. So, you might still end up
with unmovable pages inside CMA.

>
> block/bio.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 65c796ecb..671e28966 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1248,6 +1248,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>         unsigned len, i =3D 0;
>         size_t offset;
>         int ret =3D 0;
> +       unsigned int flags;
>
>         /*
>          * Move page array up in the allocated memory for the bio vecs as=
 far as
> @@ -1267,9 +1268,11 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
>          * result to ensure the bio's total size is correct. The remainde=
r of
>          * the iov data will be picked up in the next bio iteration.
>          */
> +       flags =3D memalloc_pin_save();
>         size =3D iov_iter_extract_pages(iter, &pages,
>                                       UINT_MAX - bio->bi_iter.bi_size,
>                                       nr_pages, extraction_flags, &offset=
);
> +       memalloc_pin_restore(flags);
>         if (unlikely(size <=3D 0))
>                 return size ? size : -EFAULT;
>
>

