Return-Path: <linux-kernel+bounces-265847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACA93F6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6400C1C2161D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496E1487CC;
	Mon, 29 Jul 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRdk4mvF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705B8C06
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259956; cv=none; b=cMOOBqEpm0xY7UKCZAf4YzozgCgkEbSb/0saIQSQTziBdOnTBjOVc+3zQdsqC8tN+sLDPJixwXsmyIUpwVb5q8axx+6iPugkQiLzUQ+kk7Ff2ZUHRzYdF0wL52zDDvPgRg9xdpLk8RDE2qtZh5HQGyb1gr6/G6Y4cAGmW2Obbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259956; c=relaxed/simple;
	bh=FORGH31FVY36dwbf1bsEa9eg79lwKPk1j59XV5rC67A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gf+6f6ZsKTqH1LiECcJCv/0eOulyyuk+tuznbNyAWROgGlygpf60QT7LVPpbGZvLSyrw6QCfP4A+vs7tFUlpHshmVQHqCal/7gnbmwisLrkdXZdzevZOuvxPawsVLPqhKooVy3Jr8LVHeGfuxlGLTQSWmNUlUIpihqZ4YYfXZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRdk4mvF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efdf02d13so5369341e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259953; x=1722864753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbRjAHQtUB3Dfr8gxrGGpoQyBA89PQB8SKva9HnXgRk=;
        b=MRdk4mvF5d3UaIeKXnzkZTMlol3JKuOlEk5TaAWga9MqpX44IQx4cZN4NLcj+HzbD6
         Uj/FQ9RxPScW/Q5npUJJdpqEI4x6nSsLIyL7JSgSBFr6d9z86ZGd7Vpg246VmtEUT1Z+
         B85TUCLxg2JRTqt/UqLJPGwqLIQQG/kv3HqV3whIsQEJsOPLRTbGLst5DHocfjOzxU20
         zI+PHIDSNzgVe80aL6k7QS15N7NtCUUozFrhAwn1yPMjis41x5mRojfuEZK4RB7/8MIb
         Rlkfu5HCdmF65itqIFn2/NWDETwPCCIDG1TXJnsjv+UgKvmMXKLjSPROnxx/Utu+X1/U
         g93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259953; x=1722864753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbRjAHQtUB3Dfr8gxrGGpoQyBA89PQB8SKva9HnXgRk=;
        b=nBmnNKb5trz37AXwmrGg8oNk2o9cmarwbTQNFxTR1UzplzXf/CcKhhU3tH0HZ1c3qY
         mH4uJvKqLlPgR/UH91QqndY+7BDWZ4mYJ4N2+GKzXiQLdIxTedOSyn1nJSqLAG+cX8uZ
         5n7vsiLai/ETcm1vd6KlKaSURAt9s35fGS4IfokKgf7QDffgfYjONId8vZp0VrscVDjE
         a7gbj1fIJInYZnCxdNDc4Ofz4A84VjTyk/+EX9+oNNysBKnM4Bs2LeLA+xs9jyzWBiLG
         2EluZpg2GpmtwdJdye7AA5yHFfGIpJzmOBewqgtED/tyDB98m76Op6EYv6WbSsFCeI9K
         9tEg==
X-Forwarded-Encrypted: i=1; AJvYcCVffjhFH0FCkjzVqLbA4BssqO/EJGR9lfhhoeej0BDCwCegRifxuBxvGnXE/UAYECn/ccvdqtQdHFIo9UnLVxQeSBexoJm3n54YSoFp
X-Gm-Message-State: AOJu0YxgeGEiYIUg7y9bdpSXx0EiKNtm4jSJqFW4sjLpPS1ot4RoU2l/
	RQVCprioy6gh/5GhTeIuKQD02Xm08itzZOfFFJ2t7coOWuT5cvLHAH/D3AUmQEWt/WO43ZSnlgr
	HaXeZV2vWqCuikWd0ubmz6OYeY/A=
X-Google-Smtp-Source: AGHT+IE71KUp2UUw2nzU+qFo3xxkx15j6FcheRdalU9a6Wo0DAliW7C/B2RxOZOo+MHMdZNXOuTl+qDdqcspqNW0Q7Q=
X-Received: by 2002:ac2:4bc7:0:b0:52c:84ac:8fa2 with SMTP id
 2adb3069b0e04-5309b269275mr7252892e87.7.1722259952209; Mon, 29 Jul 2024
 06:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CANzGp4J3et+yo8v8iDngvAb3nrn-gSDh0_j0=65OEiw9jKJbPQ@mail.gmail.com>
 <ZqeRO9gedIPcbm3E@casper.infradead.org>
In-Reply-To: <ZqeRO9gedIPcbm3E@casper.infradead.org>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Mon, 29 Jul 2024 21:32:20 +0800
Message-ID: <CANzGp4JobgUNCUXrv-kXw_NFBCNp7pO9bGwUBJxMDjca8P7G-w@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ying.huang@intel.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 20:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 29, 2024 at 02:36:38PM +0800, Chuanhua Han wrote:
> > Matthew Wilcox <willy@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=80 11:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABL=
E, 0,
> > > > -                                             vma, vmf->address, fa=
lse);
> > > > +                     folio =3D alloc_swap_folio(vmf);
> > > >                       page =3D &folio->page;
> > >
> > > This is no longer correct.  You need to set 'page' to the precise pag=
e
> > > that is being faulted rather than the first page of the folio.  It wa=
s
> > > fine before because it always allocated a single-page folio, but now =
it
> > > must use folio_page() or folio_file_page() (whichever has the correct
> > > semantics for you).
> > >
> > > Also you need to fix your test suite to notice this bug.  I suggest
> > > doing that first so that you know whether you've got the calculation
> > > correct.
> >
> > >
> > >
> > This is no problem now, we support large folios swapin as a whole, so
> > the head page is used here instead of the page that is being faulted.
> > You can also refer to the current code context, now support large
> > folios swapin as a whole, and previously only support small page
> > swapin is not the same.
>
> You have completely failed to understand the problem.  Let's try it this
> way:
>
> We take a page fault at address 0x123456789000.
> If part of a 16KiB folio, that's page 1 of the folio at 0x123456788000.
> If you now map page 0 of the folio at 0x123456789000, you've
> given the user the wrong page!  That looks like data corruption.
The user does not get the wrong data because we are mapping the whole,
and for 16KiB folio, we map 16KiB through the page table.
>
> The code in
>         if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> as Barry pointed out will save you -- but what if those conditions fail?
> What if the mmap has been mremap()ed and the folio now crosses a PMD
> boundary?  mk_pte() will now be called on the wrong page.
These special cases have been dealt with in our patch. For mthp's
large folio, mk_pte uses head page to construct pte.


--=20
Thanks,
Chuanhua

