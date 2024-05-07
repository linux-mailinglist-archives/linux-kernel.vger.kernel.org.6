Return-Path: <linux-kernel+bounces-171996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534F8BEB9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52DC285C05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D316D4FA;
	Tue,  7 May 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gS8evl/5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C4C8A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107368; cv=none; b=jLAc2OPJRDwJGx5sTo1yyJaqAvl373on/aXblIbWUwZ9rt+rimeUoTaNvKcMvJRRsJSyNuw4rd53Tt9XebZ0t3iEb4m4IYYnJKISiWs2cmiX//l4UChLFDJUB/Y/1OwPMSU1Tx0B6T1xfTc7E8VPNuVHryofOPMxMn+bEkUIVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107368; c=relaxed/simple;
	bh=qBmBP7HgNU048DFIwJJeNIqLVaKf0ezWnWkP8ycKMHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQqVLMWXsJTS+k5H/xuC7pQBdaMPSn3SGy1e+Oo7oVKqCPcQGgllQtPuxE2GoJiG+h8nYxxkkIwyGKPrOiMV71W8RTCo7zn3Dt9O2tao1esM1qzm54jViTrFfd4WcjwbhKCLl6B/7woiidhh+EfMSSWQTKTR1wfx2VUFI3t0TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gS8evl/5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso688420266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715107365; x=1715712165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBJwzDuq7a/1GG57UNlyVV56KYXXK+eUCnGXBNvuYsY=;
        b=gS8evl/5BoKaOSq9QHLhOI+/GQiACtPa4p+6sGOanTd/Fu2L8ePxt85CT6MQG9bj/L
         stKraqISzUd2vy9Kn9OGiDkohX5yT9GGI1Au0o4sQnuuT1hC1XeUK/YbrDRqI50YIhTh
         66nSV8RdTYc3b5a9h2APgvZOnFvDq4EIbvgVBf1+EomVodl5tn4TWZm7oet9y1qbDMPO
         gm0zbZN3kcjcfMd6lj3xhPhW4LbpL1zqxKRl0nwzWR+1aMxJ/PRe5T/IcBHXisE1iOA9
         XevBrq6sNjATUWf5kk05qb0Nh1JABSM57K/iEkVHRjutYVb+DVJV+phZS7DqA5F/HxWJ
         1ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715107365; x=1715712165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBJwzDuq7a/1GG57UNlyVV56KYXXK+eUCnGXBNvuYsY=;
        b=CqHmQEtjNZQkeMuimPyA032c1VnHDsudn7Ey5gmSfbaFMqtI9I/TVKwniN4ZradLd4
         PY9XFALg8jGxhAAIRpLjrpfrc7RWcLhizDYtQ/8ba0nEcbRqFVulBF0wJfZ8b3smRolY
         IWTuz5vjN/NS/VS4tgDX4VUSudwApD4wTNe8xkaiZA28fF/l1TvzH6GgqvHphkhe02sw
         xUJ6+QLTjx8DjGyTMcBFg3D5DGqrr5wB+bDxU7GgD9pEY9hktCRdeEjG3cLX56Vu8iUr
         oQ5+my4ys9Sf7fh2z+MNkjN6mHl8rRzU6QQIUX0fngOVhXiuiq33ITZS+bLJKSo2UaDU
         3XMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLj3gts+cbkS+N5pn7MTiA2Thkz0xO+Wp1PFtqQaEzi3+SqwmNcEJq7WZIWQDnkOsKvFGSBGhWcEeUgKOx7uKcPgdf7awSwkxQbJUG
X-Gm-Message-State: AOJu0YwZbyMdXyz1LZ2cyXR0EMAQGVjOFGKJM8iru0inecTA6KpJEN5+
	Q47UvIbvQMA/iRO+vIqfEWnqvACajR2P1LaNoPAQWAWY9j3iq+l6oM0oIl0KqWvJFKie3JoOKXZ
	pb6G63WAZ772PYiFB+JhD0DJLxP1AD1UXLF1x
X-Google-Smtp-Source: AGHT+IE0eddGWRUD/u6sVgPGqrSIh1excx/dLF1miP1H89kcgRzA7f5C9SOOgwaanvTdkG1D2pEBaaReidGYG63gAIQ=
X-Received: by 2002:a17:906:64c:b0:a59:c090:7781 with SMTP id
 a640c23a62f3a-a59fb94a633mr17613866b.3.1715107365190; Tue, 07 May 2024
 11:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506211333.346605-1-yosryahmed@google.com>
 <1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com> <CAJD7tkam8BvLvOrw_FfgZ8XOsfdu-Hv2oCv_s+LAMcGvd44hTA@mail.gmail.com>
 <42a18f08-99a5-4bb0-8a1d-771549cac046@redhat.com>
In-Reply-To: <42a18f08-99a5-4bb0-8a1d-771549cac046@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 May 2024 11:42:07 -0700
Message-ID: <CAJD7tkYkhw1p-8qtJt7ux5qq7T-NA4NsUJBaQPZqX-01OP31mg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm: rmap: abstract updating per-node and
 per-memcg stats
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:38=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.05.24 17:54, Yosry Ahmed wrote:
> > On Tue, May 7, 2024 at 1:52=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 06.05.24 23:13, Yosry Ahmed wrote:
> >>> A lot of intricacies go into updating the stats when adding or removi=
ng
> >>> mappings: which stat index to use and which function. Abstract this a=
way
> >>> into a new static helper in rmap.c, __folio_mod_stat().
> >>>
> >>> This adds an unnecessary call to folio_test_anon() in
> >>> __folio_add_anon_rmap() and __folio_add_file_rmap(). However, the fol=
io
> >>> struct should already be in the cache at this point, so it shouldn't
> >>> cause any noticeable overhead.
> >>
> >> Depending on the inlining, we might have more branches that could be a=
voided
> >> (especially in folio_add_new_anon_rmap()).
> >>
> >> [the rmap code is more performance-sensitive and relevant than you mig=
ht think]
> >
> > I thought about making the helper __always_inline. Would that be better=
?
>
> Let's leave it like that. I might do some actual measurements to see if
> it makes a difference at all.

That would be interesting to find out for sure.

[..]
> >>>
> >>> -     if (nr_pmdmapped) {
> >>> -             /* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-mem=
cg */
> >>> -             if (folio_test_anon(folio))
> >>> -                     __lruvec_stat_mod_folio(folio, NR_ANON_THPS, -n=
r_pmdmapped);
> >>> -             else
> >>> -                     __mod_node_page_state(pgdat,
> >>> -                                     folio_test_swapbacked(folio) ?
> >>> -                                     NR_SHMEM_PMDMAPPED : NR_FILE_PM=
DMAPPED,
> >>> -                                     -nr_pmdmapped);
> >>> -     }
> >>>        if (nr) {
> >>> -             idx =3D folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FI=
LE_MAPPED;
> >>> -             __lruvec_stat_mod_folio(folio, idx, -nr);
> >>> -
> >>
> >>
> >> We can now even do:
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 9ed995da4709..7a147195e512 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1555,18 +1555,17 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>                   break;
> >>           }
> >>
> >> -       if (nr) {
> >> -               /*
> >> -                * Queue anon large folio for deferred split if at lea=
st one
> >> -                * page of the folio is unmapped and at least one page
> >> -                * is still mapped.
> >> -                *
> >> -                * Check partially_mapped first to ensure it is a larg=
e folio.
> >> -                */
> >> -               if (folio_test_anon(folio) && partially_mapped &&
> >> -                   list_empty(&folio->_deferred_list))
> >> -                       deferred_split_folio(folio);
> >> -       }
> >> +       /*
> >> +        * Queue anon large folio for deferred split if at least one
> >> +        * page of the folio is unmapped and at least one page
> >> +        * is still mapped.
> >> +        *
> >> +        * Check partially_mapped first to ensure it is a large folio.
> >> +        */
> >> +       if (folio_test_anon(folio) && partially_mapped &&
> >> +           list_empty(&folio->_deferred_list))
> >> +               deferred_split_folio(folio);
> >> +
> >
> > Dumb question: why is it okay to remove the 'if (nr)' condition here?
> > It seems to me by looking at the code in case RMAP_LEVEL_PMD that it
> > is possible for partially_mapped to be true while nr =3D=3D 0.
>
> Not a dumb question at all, and I cannot immediately tell if we might
> have to move the "nr" check to the RMAP_LEVEL_PMD case (I feel like
> we're good, but will have to double check). So let's keep it as is for
> now and I'll perform that change separately.

SGTM, thanks for checking and for the review.

It appears to me that no changes are required here then :)

