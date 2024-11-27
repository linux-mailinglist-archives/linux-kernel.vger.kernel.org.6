Return-Path: <linux-kernel+bounces-422921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD19D9FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DE8B23999
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688DC1862;
	Wed, 27 Nov 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5bi6tWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC510E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666148; cv=none; b=Rbt3/stAgHDCXwLWVM4H93R9hPD1ODySb86suB0iF+1xaiXsxmkNUf6M0PEAg2E9WKx2/QSIn9tGbJQ/r5HPX4HqHJLgNlP1f1Gno3tZMA7UR9574W82z6VPwWMYBgTLQu6OXyb/nTlN0F5o2zucl5IYkpICBGe6aVgU3Krx3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666148; c=relaxed/simple;
	bh=/CdDLGoJ1M8kEeGszX5uJUw35m3jeZUaggvfENDOBUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6farBCPFmUHe1PA1krjEcXVh4prkazlo1kyBkhZEIoH8O6ERahm4AbHJJ6w487L5fNuMVpejy/SD+oIcjw4JUa+9tlW8mJEchJNBPQ/CnWk/AEEXA5Sywt8AmsSXbIVpdbMiYHGZg9PPIzUuq8/XdCbsh33B4DVbIFFzWLGWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5bi6tWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B0C4CEDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732666148;
	bh=/CdDLGoJ1M8kEeGszX5uJUw35m3jeZUaggvfENDOBUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5bi6tWzX4ZuvkzJiRiNSlRty24faSfQ7HOtuh6syVJKVjnbOyhsHbp1bV7UMKnRs
	 a1+9vY8mzTuqchiyV/EHO/9CVZQzCgJPNztwwKH7xAYkG1h3l9GXzTDvH/ztFJjZJ8
	 ULNJP4ArfM5L6XSih2W7UQ0i9kQwysy4yLH+NmIuu13iQXmG5RrVzIzpzHIvZGByzE
	 4I0CUJZ8FXhCXz6EHSA2fWTBmlcuLaWch1hxUk/j6Zq2VC2v96Y0csNIdDAvxv/OYS
	 alOsc9BAjkFZ6EM2Ap6AbOwTqeyJR/kg/s+cW2NzS2IDw/n0NFq9qkTvNX2SxEyN9b
	 4KEFv+vVP/l3A==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eebb54fc48so55946497b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:09:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmp+iR1HPc2e9Q4T32Q/6aygPnUumHPT9LRrHjjXQf7l8WICnmLRNItqdoTuOToVZYyRai7vOKXtWuMRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMIN/vRrk9fPIt1EpDZxsxn2z1mNnKCDbe/rjy4daz8NjpVdY
	ce8QDjBE5xU8sMi3cHRntlSpEoKWrKLaGRBX2QWUW7gDgLu8nQbJPA8HHziLrMNqtq+24a2Xt5x
	QVAV3m80QFopqCXZ9ZCFht18ujtCsSO6+KVx6tA==
X-Google-Smtp-Source: AGHT+IHqcVYjU790T8D/asBW13GT8ImEB95KZ3XVSKArXMRm/5ZayDypabv/Zo+v4QJYaFWkdMfkNsrTf+s6/9a+qmA=
X-Received: by 2002:a05:690c:6e03:b0:6ee:b7cf:4a8f with SMTP id
 00721157ae682-6ef37282b3dmr14585947b3.38.1732666147348; Tue, 26 Nov 2024
 16:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com> <ZzrA5nXldoE2PWx4@casper.infradead.org>
In-Reply-To: <ZzrA5nXldoE2PWx4@casper.infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Nov 2024 16:08:56 -0800
X-Gmail-Original-Message-ID: <CACePvbWQv1KiNua4nC6L7ph-U+qXHTGPSjHMLUyPNLz-fSz7eQ@mail.gmail.com>
Message-ID: <CACePvbWQv1KiNua4nC6L7ph-U+qXHTGPSjHMLUyPNLz-fSz7eQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	chenridong@huawei.com, wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
> > On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> > > > 2. In shrink_page_list function, if folioN is THP(2M), it may be sp=
lited
> > > >    and added to swap cache folio by folio. After adding to swap cac=
he,
> > > >    it will submit io to writeback folio to swap, which is asynchron=
ous.
> > > >    When shrink_page_list is finished, the isolated folios list will=
 be
> > > >    moved back to the head of inactive lru. The inactive lru may jus=
t look
> > > >    like this, with 512 filioes have been move to the head of inacti=
ve lru.
> > >
> > > I was hoping that we'd be able to stop splitting the folio when addin=
g
> > > to the swap cache.  Ideally. we'd add the whole 2MB and write it back
> > > as a single unit.
> >
> > This is already the case: adding to the swapcache doesn=E2=80=99t requi=
re splitting
> > THPs, but failing to allocate 2MB of contiguous swap slots will.
>
> Agreed we need to understand why this is happening.  As I've said a few
> times now, we need to stop requiring contiguity.  Real filesystems don't
> need the contiguity (they become less efficient, but they can scatter a
> single 2MB folio to multiple places).
>
> Maybe Chris has a solution to this in the works?

Hi Matthew  and Chenridong,

Sorry for the late reply.

I don't have a working solution yet. I just have some ideas.

One of the big challenges is what to do with swap cache. Currently
when a folio was added to the swap cache, it assumed continued swap
entry. There will be a lot of complexity to break that assumption. To
make things worse, the discontiguous swap entry might belong to a
different xarray due to the 64M swap address sharding.

One idea is that we can have a special kind of swap device to do swap
entry redirecting.

For the swap out path,

Let's say the real swapfile A is almost full. We want to allocate an
order of 4 swap entries to folio F.

If there are contiguous swap entries in A, the swap allocator just
returns entry [A9 ..A12], with A9 as the head swap entry. That is the
same as the normal path we have now.

On the other hand, if there is no contiguous swap entry in A. Only
non-contiguous swap entry A1, A3, A5, A7.

Instead, we allocate from a special redirecting swap device R as R1,
R2, R3, R4 with an IO redirecting array as [R1, A1, A3, A5, A7]. Swap
device R is virtual, there is no real file backing on it, so the swap
file size on R can grow or shrink as needed.

In add_to_swap_cache(), we set folio F->swap =3D R1. Add F into swap
cache S with entry [R1..R4] pointing to folio F. In other words,
S[R1..R4] =3D F.  Add additional lookup xarray L[R1..R4] =3D [R1, A1, A3,
A5, A7]. For the rest of the code, we pass the R1 as the continuous
swap entry to folio F.

The swap_writepage_bdev_async() will recognize R as a special device.
It will do the lookup xarray L[R1] to get the [R1, A1, A3, A5, A7],
use that entry list to build the bio with 4 iovec instead of 1. Fill
up the [A1,A3,A5,A7] into the bio vec. That is the swap write path.

For the swap in, the page fault handler gets a fault at address X and
looks up the pte containing swap entry R3.  Look up the swap cache of
S[R3] and get nothing, folio F is not in the swap cache.
Recognize the R is a remapping device. The swap core will lookup L[R3]
=3D [R1, A1,A3,A5,A7]. If we want to swap in order 2 folio. Then
construct swap_read_folio_bdev_async() with iovec [A1, A3, A5, A7].
If we just want to swap in a 4k page. We can construct iovec as [A3]
alone, given the swap entry starts from R1.

That is the read path.

For the simplicity, there is a lot of detail omitted in the
description. Also on the implementation side, a lot of optimizations
we might be able to do, e.g. using pointer lookup of R1 instead of
xarray, we can use struct to hold R1 and [A1, A3, A5, A7] etc.

This approach avoids a lot of complexity in breaking the continuity
assumption of swap cache entries, at the cost of additional swap cache
address space R. The lookup mapping L[R1..R4] =3D [R1, A1, A3, A5, A7]
are minimally necessary data structures to track the IO remapping. I
think that is unavoidable.

Please let me know if you see any problem with the above approach. As
always, feedback is welcome as well.

Thanks

Chris

