Return-Path: <linux-kernel+bounces-280040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7079794C4F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E441F23E57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FE147C86;
	Thu,  8 Aug 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lzBJnmo5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1749132121
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143316; cv=none; b=DDb+CFTOLr5B62/zWX34tNxP7aty+PfT31ps5FP9ahFK4CMB4c9OXmJTZBLz1gCV1a1wdcmK4nkWpBPF5fAPA+laOAEjIJJiM/QaClX0xfCoYE9tOd13CeCkivyBf0xpYWmnUiwRhhTL+gSjTn7xkA4dTedoYdB1+5UD82BW2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143316; c=relaxed/simple;
	bh=lfFCBH9xl2pbQz5/RgTr95SckKR16ouqjSGMkA/j2uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPoMeSd/sgg2ZNuv3V0NiKDo6MjtEUzGHAzrx7Nr8aWVMzzIVPF9KJI+Ba8x0/hURLJlO5isE2HLngeeQ52VVfNF6OTjFiF0D1SH08u0lg/OECpiMa+sow4VyfO7fn2gJt7JAN6cXi1aIeDZqRuZizU9UN338gnbVh22kFRVPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lzBJnmo5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe58fcf2bso7947161cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143314; x=1723748114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO/Z3SbablodSUL+R3JeSvJ8+7bDWABWfQskJp837f0=;
        b=lzBJnmo58WX+zWJhg0ZW48pMzEE1o2F5s36NqfXgMtyCvtriXcDcnw13xw0/QDnP0M
         thehAZnwpnkiMCjUr3sDXOTi9jrELI5l8xuEGfZoJYn/i3rsUe87GpT1gYanruKtToKb
         /r/kF1LG9ull8LuJhTsT3Mii0QswVdQH6l7jy0m7wuQw51vUuo4j4NiZdg+BHO7pqGK4
         7jlSsy/tdPWPnPec7KJuHQFD/Ph6hHL8ZeRsO+MDHEP/oM8I5k1vZEboXF6U+BeY0UYi
         AQByG+YdAqLfjrc18v1GHR6jWSEF673zMfJCSUk3Sk6k8CLKgojPKghUVFnxn0HinK54
         FvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143314; x=1723748114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO/Z3SbablodSUL+R3JeSvJ8+7bDWABWfQskJp837f0=;
        b=IMB4bH+5lce9xk/ouahVtbOounKFNwk1KpNAO70wAN/j+kEhHlAKmEOe9zPCice4+g
         QIZ4w119GyU2Qn7aZgIJL+6c0PFKi6C5SZ0coAlWlATW5e/08JqS1WHqplbzn6GvSVwA
         9V5iOo2xOLDIryEofUmbKE65bLJxNB+26BSXkQ62EyAdPA3xnRWKv0p/vTkHA2Y8LX/V
         xS5H9I0GvBGYd3BlGf7y/EkwK3MAGq9jLLycCtrP8QzERqMzacNXFfAoFYF6SvfquZ2B
         eCOqQV2EPmhuduCVOp6yfk9ZwZparPGlOiXaHDJAWq2Flb5y4i2wgh2i7AhpH8Yxvjx6
         b1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpauAKYeCTnRMPIYgY+RwTvpAqidbjVY3d9SXocM7/qhfUk7b+6xeW/Yt1jp9JnJNB6dt4LYHap58O23buNZauJmDlOXc/VCw1Pzx9
X-Gm-Message-State: AOJu0YyCvTiL8S+gu+0JNDEPV/cXZ6JOmA2C2tL2hc+K4Lf4SIWMfsK7
	zshG0POdis2azFoq8eoYKSWpJlu6m9kk1cf6JPwdNnbXCqeWtVK23MTns98zR51MbUrsHK/D9EA
	vvfLtn8Pmjv8Gv+JLH/63nLv+Mwa2P25vudqw/Q==
X-Google-Smtp-Source: AGHT+IGCSGjuz41NNdGhYP00jq6qPDxX9zDID06r1oWKzkL+fM3fiKkjBrJ2CXqN+zVBtulvpbY7hra6xTPzoF1wD6c=
X-Received: by 2002:a05:622a:4ac9:b0:44f:dd52:8aee with SMTP id
 d75a77b69052e-451d430ab3fmr39557171cf.46.1723143313673; Thu, 08 Aug 2024
 11:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-3-pasha.tatashin@soleen.com> <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
In-Reply-To: <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 14:54:35 -0400
Message-ID: <CA+CK2bDvmSq1Wg92TVi6A5jVwxn5Xeo5aTf3sfUafCkiWPPZUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:12=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 17:42, Pasha Tatashin wrote:
> > When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> > not account, the memory is going to be release at the function exit.
>
> I would write it as
>
> "When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
> not account any already-allocated pages: we're going to free all them
> before we return from the function."
>

Will change.

> Acked-by: David Hildenbrand <david@redhat.com>

Thank you,
Pasha

>
> >
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index fa83a7b38199..70027869d844 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long =
start, unsigned long end,
> >
> >       for (i =3D 0; i < nr_pages; i++) {
> >               page =3D alloc_pages_node(nid, gfp_mask, 0);
> > -             if (!page) {
> > -                     mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i)=
;
> > +             if (!page)
> >                       goto out;
> > -             }
> >               list_add(&page->lru, list);
> >       }
> > -
> >       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
> >
> >       return 0;
>
> --
> Cheers,
>
> David / dhildenb
>

