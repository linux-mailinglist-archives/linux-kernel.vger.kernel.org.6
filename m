Return-Path: <linux-kernel+bounces-227979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E118691593A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD781C22E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07C1A2564;
	Mon, 24 Jun 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHwY5I/4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B581A2550
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265632; cv=none; b=DawTvI4fJFWkWYkL0z9LU5PaoA9q1mN3/MJSw/DAWk5oFu4/hWfrE07HT9fB72E4fygzJFu2tyxuwmIfUpth87vvgTWyUiAeTRt2LMyDuguJhRkFSZmadSaUhUctNS+SR8TNlAqT47ZZaA3Z/8MTeVJXLTwPOAkkNFM8xWnNxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265632; c=relaxed/simple;
	bh=PfU00K8ld15e3Ct7J5mqMcyH+tXcb47splfu3HxcPsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWDqmWS+a2ee3CSMLrnSxb0S81ezME11gtIW7YUOColp97mAFSxoMMtiv4XhDe3+NypELkYgxeLiPmZcAGUUliJsXzAutP3Gg0KIA+BWXhej1cYAuAxQ5VB5qtjdhVoqBL2F/VnTd208fNFLtZ7U/LKsOpAD9woyHe1FEGQrmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHwY5I/4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so191999966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719265628; x=1719870428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpHFOryNWFijkyNTFyyhIbAri5hCaElrVf1pJKE/RaA=;
        b=mHwY5I/4r09BrKmXt2lj8LDXAhzQjRdEYUbANB8zqEPK1ginnf3LFHm/1kXwk+Sb8f
         bUvHexHSG2atdHd8QXLqGjusaQVITUAERUv/qEdD8tT/pG28BH4e+P7779nAPe9AwhUJ
         5lhWnQN3ufb9UZpyoY26Qx0PE4goFzbWF0rgFqHm1OC+YVSQszF++I96e37ueSK5qDWU
         DZAwTtWOXxi934owmfhPp7+rk8hYjwu3+LO3K/ebOhSWF13CGlfNyxVNSM9Gu/YYbMik
         VbYo7eB2q1SCIm1sSAlwuEy6pkxNa/K57QvnIZYs6E0+BKgbtiImtHl2xVrvDmwipAIY
         K5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265628; x=1719870428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpHFOryNWFijkyNTFyyhIbAri5hCaElrVf1pJKE/RaA=;
        b=HUAMe8wO2PeRemseP53t734LT1rSV9wsH6+n2klt4g979nCoGjlRLRY8sED0g2OsrH
         XmYmSVHE68DQPWhJ+96/NyWSBDrRHE75O+3Og0U56vvkSrVMbwVwRkYwsAxANpRHlYhd
         Tlct8ZXFByJsj7RQ3WELdugQGAd2Rj5haDWRZXjOiLpZH5odRqy/aZidbZPe/IDO/Ts5
         UzYLSaZ84fzc5lxgk0NbrfQVUxy37QCEJ+yUHnQooimQAXWn9f+42sNjr8+u8SoqlRxB
         7nlzDb06IUPb185fzp2Fc72bvpjFoDNwpbzloxE0SstqgdIGiuUqgOo2FeJCZzkCYuUE
         S+lw==
X-Forwarded-Encrypted: i=1; AJvYcCUzhmDVBvb1sjWTCquQ6FGg6zpq4VTqA+oUpxa5O24jKOeTKtoBJDuaZtKR1Ob0gybC81ekN4j2NJzMF1AbGynxz/D6vsIvueJm893N
X-Gm-Message-State: AOJu0YyQwhN9amnAR03ktyo9syeEjL6gJpT/oKJSJm/Z/PA2ite+ol8t
	cUzb5LG0gv/oHD7dCt7+4cvVkcPCu+ZHzrOkaxV3kBH4zDwfWIlA8Ac63C2lhYmOhttifaRjZ7n
	XetFi+Z71eQH73X38+fKB5aq6W2n9gF8qUZpy
X-Google-Smtp-Source: AGHT+IHfhIsQTn+36KvpTzSGdeSCdIpE31rK5PjUqd1FQKDYFZ2fswFe52Q+Vqr9RBc/Or+ypFOJY+v7hR2sCbTdb6M=
X-Received: by 2002:a17:906:374b:b0:a6f:af58:efac with SMTP id
 a640c23a62f3a-a7245b8f348mr356555966b.25.1719265627320; Mon, 24 Jun 2024
 14:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621054658.1220796-1-alexs@kernel.org>
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 14:46:30 -0700
Message-ID: <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:42=E2=80=AFPM <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> According to Metthew's plan, the page descriptor will be replace by a 8
> bytes mem_desc on destination purpose.
> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
>
> Here is a implement on z3fold to replace page descriptor by zpdesc,
> which is still overlay on struct page now. but it's a step move forward
> above destination.
>
> To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend t=
he
> zpdesc to zbud and zsmalloc, combined their usage into one.

Please do not focus your development efforts on z3fold. We really want
to deprecate/remove it, as well as zbud eventually. See [1].

For zsmalloc, there is already an ongoing effort to split zsdesc from
struct page [2].

[1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3i4bN=
ndqF+3+_Vg@mail.gmail.com/

[2]https://lore.kernel.org/lkml/20230713042037.980211-1-42.hyeyoo@gmail.com=
/

>
> For zpdesc(page), z3fold just uses the 5th member zppage_flag, which
> match with page.private. Potentially uses the first member flags for
> headless PG_locked, list_head lru and page.mapping|PAGE_MAPPING_MOVABLE
> for page migration.
>
> This patachset could save 26Kbyetes z3fold.o size, basely saving come
> from the page to folio conversion.
>
> Thanks a lot!
> Alex
>
> Alex Shi (15):
>   mm/z3fold: add zpdesc struct and helper and use them in
>     z3fold_page_isolate
>   mm/z3fold: use zpdesc in z3fold_page_migrate
>   mm/z3fold: use zpdesc in z3fold_page_putback
>   mm/z3fold: use zpdesc in get/put_z3fold_header funcs
>   mm/z3fold: use zpdesc in init_z3fold_page
>   mm/z3fold: use zpdesc in free_z3fold_page
>   mm/z3fold: convert page to zpdesc in __release_z3fold_page
>   mm/z3fold: use zpdesc free_pages_work
>   mm/z3fold: use zpdesc in z3fold_compact_page and do_compact_page
>   mm/z3fold: use zpdesc in __z3fold_alloc
>   mm/z3fold: use zpdesc in z3fold_alloc
>   mm/z3fold: use zpdesc in free_z3fold_page and z3fold_free
>   mm/z3fold: use zpdesc in z3fold_map/z3fold_unmap
>   mm/z3fold: introduce __zpdesc_set_movable
>   mm/z3fold: introduce __zpdesc_clear_movable
>
>  mm/z3fold.c | 190 +++++++++++++++++++++++++++-------------------------
>  mm/zpdesc.h |  87 ++++++++++++++++++++++++
>  2 files changed, 184 insertions(+), 93 deletions(-)
>  create mode 100644 mm/zpdesc.h
>
> --
> 2.43.0
>
>

