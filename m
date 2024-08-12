Return-Path: <linux-kernel+bounces-282767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2894E85C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C747C1F21FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0109166F02;
	Mon, 12 Aug 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3Z3kN4N"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF71876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450731; cv=none; b=IimsCffN9VCqTVZ2AXbC/jXKgzWSrmOB9c6UbmROxba7XqUmBT9MVAUmSwpcgI4Nteam/VWR8VA/kToBNwi/h0EhNV6ow/bWKGBpY559PlC2NgL4jWaLrwgyod9YHdcuNZQA9/Uev05dvEokcnjgNjUcpAChFkgroiKvOifKoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450731; c=relaxed/simple;
	bh=cgR/NMQRYOgSzF3Qy2yoC4x+t/mql++VHase+Lz5Mpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0fyRxHsblWrapAZV6nKkfQZi7/KpY8TBvUdJnRonIucBU065Y4qZrxSZc3hs70cmX5EzV4a7/wBg34aysXWbt8o5nzkCxS1NmTLiAc0x6ynTPthupEZTWZiC6QEJ/m8X+zK+9ug4Vkt1frv7xCbyNSCa/e3Jt6PcpznytpJqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3Z3kN4N; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso4608468a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723450728; x=1724055528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT64ovfrCU9Zee9Y2QVyAPt/J2QcowfwSWdbeJCRYUs=;
        b=B3Z3kN4NqbWlh1PLq0QhyquHbOCVY9+/9nKJSYWnUVb9oNeslmBzokrZdhZ0+Cp2KL
         LabwldN5/SpWpFlVZnY5pDjn1V1dMYTLU7mNYLuep9ULgwC4/T6kILH4yeYf+Ua2+PRJ
         L+7Fumu3YRRGoee4NtKJ8F9iEU0U3n+unY3L6vu8iCKQzzOxexCM68VlxkbhNIzuCLge
         q7xlwBOepbM+bAxQknbuR+2ZaubRJfE1+Xo4rGQm9VNEk2+n7ivl6du3WhdRI0LO/em2
         yaKAc4uWPO47E053vRjWLTeOAJmVSOUhc0z+JSYkKFbY+QY80gK11s0FkzsdswDWgWzu
         DWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450728; x=1724055528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT64ovfrCU9Zee9Y2QVyAPt/J2QcowfwSWdbeJCRYUs=;
        b=XA6ySO4vpaxKs4nTt8W56cAm/Td6KxeksM2qnExsU2SCw/pS1RW3DnaH8gz+KeN0G8
         rn2v1cfWTI+3AeWElUUAtdueSLWC/qPrlo5YRyHr3TfymmuF8XXGNy5qlddL8rWUeETQ
         P0OiW/+LUM8a6DSOIkjf/YoqX7Gs0m9WIe0PRlAsISi+koonz2Yi6WDVfO0Z4HwelpJf
         ioXo0YmLdiozkpztt8qE/Tlm4FurVd+5fLEsw3L0V+nKPKJ3ATnYW3de5igyUOd2w9dM
         DhgUN09wJFFyWwueXSlAVdrxuILvQ8bXwB9EPSKL0iy36gsvfDKmF25uwBCfzMPjOTRl
         88Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUYuLZI5Sm3NgNkgqIYdtaqGj3eyIPwlyVmGHwBEJitxUJcqr7nBG5D0d/e7izrYHE0fAg0j603HrLz8cJR9JjkGMhYbUSh8Edmud+B
X-Gm-Message-State: AOJu0Yznnbucx7BWpX2WP2biumbjFcal12xWyS20eN06hXb3Fm20cY9f
	8gibdRK49b5Cyqxbs0keZlMi7ZHbVoLtR6v/7Ktk2f5L0p0UnnRBclVxUQxBu59OcapwHK/ZoF8
	XClxjcAPiApCLycvCww4L1RaxCUw=
X-Google-Smtp-Source: AGHT+IE8dvVEEZMCdEXUQaeQ55ANsM3WcSwuZwJERb8mL0HdgQ+W3IPYqLGwGaFdlIv2R8tMEBJcxVOXFQKK5nETx5U=
X-Received: by 2002:a17:907:f1e9:b0:a7a:8d73:c2c6 with SMTP id
 a640c23a62f3a-a80aa595ca3mr592758066b.18.1723450727316; Mon, 12 Aug 2024
 01:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407301049.5051dc19-oliver.sang@intel.com> <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com> <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com> <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com> <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2> <66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com>
In-Reply-To: <66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 12 Aug 2024 10:18:35 +0200
Message-ID: <CAGudoHGVc+=w5b8wKc=tt4FTOP3wN-3Ts9DCwRg_caZ8dfUNDg@mail.gmail.com>
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9% regression
To: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, kernel test robot <oliver.sang@intel.com>, 
	Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, 
	ying.huang@intel.com, feng.tang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:12=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.08.24 06:49, Mateusz Guzik wrote:
> > On Mon, Aug 12, 2024 at 12:43:08PM +0800, Yin Fengwei wrote:
> >> Hi David,
> >>
> >> On 8/1/24 09:44, David Hildenbrand wrote:
> >>> On 01.08.24 15:37, Mateusz Guzik wrote:
> >>>> On Thu, Aug 1, 2024 at 3:34=E2=80=AFPM David Hildenbrand <david@redh=
at.com>
> >>>> wrote:
> >>>>>
> >>>>> On 01.08.24 15:30, Mateusz Guzik wrote:
> >>>>>> On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
> >>>>>>> Yes indeed. fork() can be extremely sensitive to each
> >>>>>>> added instruction.
> >>>>>>>
> >>>>>>> I even pointed out to Peter why I didn't add the
> >>>>>>> PageHuge check in there
> >>>>>>> originally [1].
> >>>>>>>
> >>>>>>> "Well, and I didn't want to have runtime-hugetlb checks in
> >>>>>>> PageAnonExclusive code called on certainly-not-hugetlb code paths=
."
> >>>>>>>
> >>>>>>>
> >>>>>>> We now have to do a page_folio(page) and then test for hugetlb.
> >>>>>>>
> >>>>>>>        return folio_test_hugetlb(page_folio(page));
> >>>>>>>
> >>>>>>> Nowadays, folio_test_hugetlb() will be faster than at
> >>>>>>> c0bff412e6 times, so
> >>>>>>> maybe at least part of the overhead is gone.
> >>>>>>>
> >>>>>>
> >>>>>> I'll note page_folio expands to a call to _compound_head.
> >>>>>>
> >>>>>> While _compound_head is declared as an inline, it ends up being bi=
g
> >>>>>> enough that the compiler decides to emit a real function instead a=
nd
> >>>>>> real func calls are not particularly cheap.
> >>>>>>
> >>>>>> I had a brief look with a profiler myself and for single-threaded =
usage
> >>>>>> the func is quite high up there, while it manages to get out with =
the
> >>>>>> first branch -- that is to say there is definitely performance los=
t for
> >>>>>> having a func call instead of an inlined branch.
> >>>>>>
> >>>>>> The routine is deinlined because of a call to page_fixed_fake_head=
,
> >>>>>> which itself is annotated with always_inline.
> >>>>>>
> >>>>>> This is of course patchable with minor shoveling.
> >>>>>>
> >>>>>> I did not go for it because stress-ng results were too unstable fo=
r me
> >>>>>> to confidently state win/loss.
> >>>>>>
> >>>>>> But should you want to whack the regression, this is what I would =
look
> >>>>>> into.
> >>>>>>
> >>>>>
> >>>>> This might improve it, at least for small folios I guess:
> >> Do you want us to test this change? Or you have further optimization
> >> ongoing? Thanks.
> >
> > I verified the thing below boots, I have no idea about performance. If
> > it helps it can be massaged later from style perspective.
>
> As quite a lot of setups already run with the vmemmap optimization enable=
d, I
> wonder how effective this would be (might need more fine tuning, did not =
look
> at the generated code):
>
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 085dd8dcbea2..7ddcdbd712ec 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -233,7 +233,7 @@ static __always_inline int page_is_fake_head(const st=
ruct page *page)
>          return page_fixed_fake_head(page) !=3D page;
>   }
>
> -static inline unsigned long _compound_head(const struct page *page)
> +static __always_inline unsigned long _compound_head(const struct page *p=
age)
>   {
>          unsigned long head =3D READ_ONCE(page->compound_head);
>
>

Well one may need to justify it with bloat-o-meter which is why I did
not just straight up inline the entire thing.

But if you are down to fight opposition of the sort I agree this is
the patch to benchmark. :)
--=20
Mateusz Guzik <mjguzik gmail.com>

