Return-Path: <linux-kernel+bounces-297752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F595BD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12D8286B44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F51CEACD;
	Thu, 22 Aug 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcYoVPa0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC321CEABB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347575; cv=none; b=TPeZFs66ywyujHDQX32GGTHSrlmu1qpJVL/5iYlqgyacsDMEL1TY0hrtWO0tHpBOEI8f3rmVUL6YSpmYHvoxarZKu+2awWlW7FwJPzxCCfojZ5j5oSM4TLk4f5oV1/drA4erwf5V0qMXRK9WTUOQU+CVydc7roXDTq4/V7m4A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347575; c=relaxed/simple;
	bh=hKMUPw6CH8HDs2xK6jGuQ6sxfGqOmsDNo9juK18wuQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=df8w9Oq9KT8ySP/+0KYpxthN7pUM1OjS1WE9GNOJIHwEpUDUDSiXcm3tNq8iQqUO5EGQqIflTDxuSZCv92Sz4n40CItdnc/HY2zsSJN1CumZO0V7k3Y9PrNYejOY3F0jrJ2Hqmmvwv1AlwnZ4OG1QxgBy7ITUMCfZU/eqOM8EwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcYoVPa0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3719398eafcso530066f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724347571; x=1724952371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4DO9awebiGfQkb+GVLhK+nasDGzkupYiz7rKh68ig4=;
        b=xcYoVPa0ojpCJ+9FaV4FA1myQC3JqBJ5OILH+oF0P1pyh1Kj/zXDzjr5ntq9PqJuOk
         yBcigwuLC2MT8CyAOsKJ6rTfbiD8J2QFin5JrqJGDoOjafNnSsE2AWf7VWiy+fQT7Md6
         S+wY9Pb+Dnuv5FzRHpQlFfha9mFnNLJl346aOpVAHrb/5sPEcRC7GgKS1xKeMxOxvsz+
         Y8kZ3oq9+8uHG2zIxWtzRUTrF8FLyHnEIqpAGfNlj9objASaFnWvETyxsFshMbI4nQAg
         iyUabYJT2pzfFQl+CMh4PoCOJXjnU5jAeeBVhVnyP80MbN90y/AtUMqB5WouiE4hpttC
         QNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347571; x=1724952371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4DO9awebiGfQkb+GVLhK+nasDGzkupYiz7rKh68ig4=;
        b=ZF2rgt45AYq/WlvB57kQhTndAoK8Z8fYCuDFnTWE12BlKg7jJJA+hUaqNfRFclX+ce
         +nwXHcNND4L2z1Mk8gy6SWgu+rOmABgo0vw/QOZGe8k8uXrakOqY2N1VuSF67gBFLbPG
         bg9wZsBCa03b6QcwzKCWUUDLKZmBaVPm0MBPOtcv3K6VdgWOiYHts9oawj2oktnwJCFj
         15/Hufeo6geSNTVHGR/xKd51tLAjLUmGhNV/jDlnnvRncD0bSjTq6OE+2uG7OXrcJSj6
         oNitwOEvVMv0WWHQPqOpUF6yUrlXd4S9XwXBGjyD0Cj7de1qQrSL8iYxTj4i3gBOhSwz
         C31A==
X-Forwarded-Encrypted: i=1; AJvYcCVniUZIqP//GYD5EMGLDRVgpRLL4czhe0Z8bFmyXNjZwVOUKjASJJBTegBVU5Qaq05y27Dhy7R4Rh9puKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIWRqdi/Q52MFfLS1NSdliYNKGfMH7KTHoLaiQ8H8J/c30KEX
	3roNFZ3S4vTC40b1gxnx7am+TWiKO87YVqhg0SAAjybrAXzPACgBsY4b/BG7Xgn/lPiGv8D8YN3
	HQi9uWN8Gir83+vacYYaBM+hNtu93N5FKUwLp
X-Google-Smtp-Source: AGHT+IERlA2H+rBepAqpYpAQ1Uha6e+U4xtYh3TpUMHIKxU6JLuOdAROJj/68rX4BvAwcW5/HgRiMK34gzHJukAoUNo=
X-Received: by 2002:adf:f509:0:b0:371:8d32:b5ed with SMTP id
 ffacd0b85a97d-37308d725b6mr1951352f8f.46.1724347570435; Thu, 22 Aug 2024
 10:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814035451.773331-1-yuzhao@google.com> <20240814035451.773331-2-yuzhao@google.com>
 <2d418463-1458-5361-86c4-a07908fc114d@huawei.com>
In-Reply-To: <2d418463-1458-5361-86c4-a07908fc114d@huawei.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 22 Aug 2024 11:25:31 -0600
Message-ID: <CAOUHufbq2biYswAfH06_1d=kNfVNvM18jpM5udx=xc4-_KNREQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
To: Yu Liao <liaoyu15@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:21=E2=80=AFAM Yu Liao <liaoyu15@huawei.com> wrote=
:
>
> On 2024/8/14 11:54, Yu Zhao wrote:
> > Support __GFP_COMP in alloc_contig_range(). When the flag is set, upon
> > success the function returns a large folio prepared by
> > prep_new_page(), rather than a range of order-0 pages prepared by
> > split_free_pages() (which is renamed from split_map_pages()).
> >
> > alloc_contig_range() can be used to allocate folios larger than
> > MAX_PAGE_ORDER, e.g., gigantic hugeTLB folios. So on the free path,
> > free_one_page() needs to handle that by split_large_buddy().
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  include/linux/gfp.h |  23 +++++++++
> >  mm/compaction.c     |  41 ++--------------
> >  mm/page_alloc.c     | 111 +++++++++++++++++++++++++++++++-------------
> >  3 files changed, 108 insertions(+), 67 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index f53f76e0b17e..59266df56aeb 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -446,4 +446,27 @@ extern struct page *alloc_contig_pages_noprof(unsi=
gned long nr_pages, gfp_t gfp_
> >  #endif
> >  void free_contig_range(unsigned long pfn, unsigned long nr_pages);
> >
> > +#ifdef CONFIG_CONTIG_ALLOC
> > +static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp=
_t gfp,
> > +                                                     int nid, nodemask=
_t *node)
> > +{
> > +     struct page *page;
> > +
> > +     if (WARN_ON(!order || !(gfp | __GFP_COMP)))
>
> It doesn't seem right, it should be !(gfp & __GFP_COMP).

Thanks. I've asked Andrew to patch this up (and another place in mm/cma.c).

