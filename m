Return-Path: <linux-kernel+bounces-302249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056395FBA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7C1C22144
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E791991CE;
	Mon, 26 Aug 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5/oq4DN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EF1993BD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707593; cv=none; b=Fxpc+ROPn/1mUDOZE6B9jolv7LAJ851IlN3UN5Tgg8Dgn28btC3P5+GhJ2UVfO1Fmy36jywQ2g7GXgSmb/gMe9DOXI/+sVNqY0n7r214X1j+y8RhQWEsc18+L2SawJsoq6xIOuxxKdCmdhmL/3PEiD371/Ln8ikck6WXSB1m96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707593; c=relaxed/simple;
	bh=nCBHHOt7A99elr0VL4vTYxnXrt16W4FKsbE09/kC2QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI/6TsthHomYOFi+w1Ga73BhnW2Za0daMxXJucWoGEcoNdXJI1aFT/nMC1kLkdV3kWoCqDUA1jwB8Z0G/iUT7XrJOrluJAipp1C6KYW6owWA6jYSwSogtp2/8TFv6GVn1dG2OJ7kl+f9TbBt9HWqACVwgGs6DrJD2KtWnsxYm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5/oq4DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EE4C4AF52
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724707591;
	bh=nCBHHOt7A99elr0VL4vTYxnXrt16W4FKsbE09/kC2QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5/oq4DNYPHF0P+ZuFVAbd88630in3yJ3glVm9FtsROBstp5T/7Om99CVaIJFA+bf
	 YgM0fjuxo6Cbu3qSb8VMxnTJo911DAkQV/rSS++oQPs/WcVRFbvQDHGBcncrtRFUSy
	 mmuCwtOFBwE0tvYNEOT1LdGCZ3/yeBLPCGSLfbaX2kLjKOdocSqB5MwdrjoKO4nMAl
	 6K2OQy7dNCJ7SzTITuvvsofYSLl8f6oIglVepfK+0JCuETO9BKdhqIs+x+UuHSSXJp
	 1gBzETjHZLFeBq5Nz1KZBO+Q5YkytDuk3NZEIZ9gNLBGQ+nSw4zea9M1iA4AMxHmJP
	 4Lte2R3JXCrLw==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6c1ed19b25fso38689387b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgZBqlFd0K0ZcV0udsGxuWYplebeO0shCsC1pFmiK2SliPEMzwnCTsny0BwEHyruK6S2A7tI11OJM6irg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAf1i+Hkpfpg4nILFpAjeErgE63E1O0JhKbIHzA0VadxNH6teU
	D8nc1TgungBZY5D9L1AyB+CjMGxK7fXMhFAarEF7gRQGmrlClWJ5tq7D9PNp/tkSgM/qFNrzCo7
	0Af2VJA2SCYX0Y+A6AG0KGFa/8UILgVDFK+eBDw==
X-Google-Smtp-Source: AGHT+IEhMJo29djjaV8v1SeXFUCZsL5ILbPkOqJd3IRx2lM5mlHdosWQRcXHz691A7WWGuQzMpKxxSv5BEWeHazBX+g=
X-Received: by 2002:a05:690c:310a:b0:664:d73b:38e9 with SMTP id
 00721157ae682-6c628b94d22mr83137657b3.30.1724707590635; Mon, 26 Aug 2024
 14:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org> <87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com> <871q2lhr4s.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q2lhr4s.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 26 Aug 2024 14:26:19 -0700
X-Gmail-Original-Message-ID: <CACePvbUp1-BsWgYX0hWDVYT+8Q2w_E-0z5up==af_B5KJ7q=VA@mail.gmail.com>
Message-ID: <CACePvbUp1-BsWgYX0hWDVYT+8Q2w_E-0z5up==af_B5KJ7q=VA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:11=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
> > BTW, what is your take on my  previous analysis of the current SSD
> > prefer write new cluster can wear out the SSD faster?
>
> No.  I don't agree with you on that.  However, my knowledge on SSD
> wearing out algorithm is quite limited.

Hi Ying,

Can you please clarify. You said you have limited knowledge on SSD
wearing internals. Does that mean you have low confidence in your
verdict?

I would like to understand your reasoning for the disagreement.
Starting from which part of my analysis you are disagreeing with.

At the same time, we can consult someone who works in the SSD space
and understand the SSD internal wearing better.

I see this is a serious issue for using SSD as swapping for data
center usage cases. In your laptop usage case, you are not using the
LLM training 24/7 right? So it still fits the usage model of the
occasional user of the swap file. It might not be as big a deal. In
the data center workload, e.g. Google's swap write 24/7. The amount of
data swapped out is much higher than typical laptop usage as well.
There the SSD wearing out issue would be much higher because the SSD
is under constant write and much bigger swap usage.

I am claiming that *some* SSD would have a higher internal write
amplification factor if doing random 4K write all over the drive, than
random 4K write to a small area of the drive.
I do believe having a different swap out policy controlling preferring
old vs new clusters is beneficial to the data center SSD swap usage
case.
It come downs to:
1) SSD are slow to erase. So most of the SSD performance erases at a
huge erase block size.
2) SSD remaps the logical block address to the internal erase block.
Most of the new data rewritten, regardless of the logical block
address of the SSD drive, grouped together and written to the erase
block.
3) When new data is overridden to the old logical data address, SSD
firmware marks those over-written data as obsolete. The discard
command has the similar effect without introducing new data.
4) When the SSD driver runs out of new erase block, it would need to
GC the old fragmented erased block and pertectial write out of old
data to make room for new erase block. Where the discard command can
be beneficial. It tells the SSD firmware which part of the old data
the GC process can just ignore and skip rewriting.

GC of the obsolete logical blocks is a general hard problem for the SSD.

I am not claiming every SSD has this kind of behavior, but it is
common enough to be worth providing an option.

> > I think it might be useful to provide users an option to choose to
> > write a non full list first. The trade off is more friendly to SSD
> > wear out than preferring to write new blocks. If you keep doing the
> > swap long enough, there will be no new free cluster anyway.
>
> It depends on workloads.  Some workloads may demonstrate better spatial
> locality.

Yes, agree that it may happen or may not happen depending on the
workload . The random distribution swap entry is a common pattern we
need to consider as well. The odds are against us. As in the quoted
email where I did the calculation, the odds of getting the whole
cluster free in the random model is very low, 4.4E10-15 even if we are
only using 1/16 swap entries in the swapfile.

Chris

>
> > The example I give in this email:
> >
> > https://lore.kernel.org/linux-mm/CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc=
5TBZP6QuHS_aQ@mail.gmail.com/
> >
> > Chris
> >>
> >> >                       /*
> >> > @@ -967,6 +995,7 @@ static void swap_free_cluster(struct swap_info_s=
truct *si, unsigned long idx)
> >> >       ci =3D lock_cluster(si, offset);
> >> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >> >       ci->count =3D 0;
> >> > +     ci->order =3D 0;
> >> >       ci->flags =3D 0;
> >> >       free_cluster(si, ci);
> >> >       unlock_cluster(ci);
> >> > @@ -2922,6 +2951,9 @@ static int setup_swap_map_and_extents(struct s=
wap_info_struct *p,
> >> >       INIT_LIST_HEAD(&p->free_clusters);
> >> >       INIT_LIST_HEAD(&p->discard_clusters);
> >> >
> >> > +     for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> >> > +             INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> >> > +
> >> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >> >               unsigned int page_nr =3D swap_header->info.badpages[i]=
;
> >> >               if (page_nr =3D=3D 0 || page_nr > swap_header->info.la=
st_page)
>
> --
> Best Regards,
> Huang, Ying

