Return-Path: <linux-kernel+bounces-262910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A4F93CE93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD02818DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83041741C3;
	Fri, 26 Jul 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9nBAvWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268A23D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977844; cv=none; b=TE0sH53S37abQXZwOZFfnWdMp47F631cS7//Of0hsl9uwNGQAU56urII7NNHmfz4N0ClhC2gm/ZxixtJc/j4+lqrCmrxRdgaeK+QK90f18jUun5ZNk+PsY2rwH+LgRmmljxzF5H/oxIH9NvHrOGBMgUke5NJv1MluMa0YRXdCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977844; c=relaxed/simple;
	bh=ciWz2uZkoogKcZci4bmKXteSuHA0QbYSUNAknuMv7tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsIiTg+tcIu/gnM+KyNmGjB8Qed380gAtAlp7wijidhCRea/3XXDDr08vFdOUzUXIUctE04+w5kErgNJnHg+Wrwr0lyJyrue/gvHzQRm68X2bgt7uDVcLu3O1hDvpUdXDGT9vVaVIuH+OgoPGKahyB+q9GrZWPUq7U1c9EmLhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9nBAvWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1AFC4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721977843;
	bh=ciWz2uZkoogKcZci4bmKXteSuHA0QbYSUNAknuMv7tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9nBAvWKCbIXdBVaaA3UIp7yab0WwipTqZ56JG8tKdTCJSD+YZFfB6aiFkyXS0wMk
	 rXvydHdr4J1YSRGquUi1QkJjgb12bWJ72DUYALIO0ZQtQv6i37tANeLs1ngSU6EXI2
	 Q391UFbHVIe2cSVdk93ex5eL8UH6JOy85ozCmtQ7eAYy3yJQZuTiI0+liT5eEWFYVf
	 YNhteZdWlzbDttQkmzuZKJkGVlN5eaN2fbgwYi0oB+CviR3QO32YxUUIG+m1xKZRZX
	 KcEMhTRJMK5hW4hEY1ZPJPSzBtl4EOk28ECJPsLQ3X00EXE5V6agpXK8p24yg9ETVZ
	 IdnNwi/Eir7Cw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6518f8bc182so23678407b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWpzHyZaMLDxfEtOxaMivMCvB63z5WJBD8G6ZrW2jlTW2OOSyGsN+CcVKxCr5Btydg7LEEvqIQ4/l3A4mfTVETuhfDfHEiVGKLBeQh
X-Gm-Message-State: AOJu0Yx3K5g6NnYCNkD9HFzJyN6eV65ujxxOnJYymdAJY7BL1S+/arsP
	ZypbguUel8DUCGOgPbCWEhL5dSSCxxMrDyBwTwDV/rpdMfQmdf5sdKHM3syvNOM9B1JGnAXXGrK
	LoN3kfVAFPjF0RIbihkaf4tgg9hcdVWTAyGi4/A==
X-Google-Smtp-Source: AGHT+IF4vpduh+OhPn4JJeY78QAWRgRh79SI7t7KYM5Z3ITYKW7YZ6C1k3uTBAh9px2yVgxs0+J275ejoNxUTxUQyO8=
X-Received: by 2002:a05:690c:f0f:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-674dfd748ffmr50854347b3.8.1721977842919; Fri, 26 Jul 2024
 00:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org> <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
 <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
 <b4b31314-1125-40ee-b784-20abc78bd468@arm.com> <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
 <874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com> <a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
 <87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com> <43f73463-af42-4a00-8996-5f63bdf264a3@arm.com>
 <87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com> <f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com>
 <87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com> <4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
 <87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
 <87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com> <CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
 <87o76k3dkt.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o76k3dkt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jul 2024 00:10:31 -0700
X-Gmail-Original-Message-ID: <CACePvbWe9wraG2FjBcX9OmHN5ynB4et9WEHqh6NPSVK5mzJi2A@mail.gmail.com>
Message-ID: <CACePvbWe9wraG2FjBcX9OmHN5ynB4et9WEHqh6NPSVK5mzJi2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >> > If the freeing of swap entry is random distribution. You need 16
> >> > continuous swap entries free at the same time at aligned 16 base
> >> > locations. The total number of order 4 free swap space add up togeth=
er
> >> > is much lower than the order 0 allocatable swap space.
> >> > If having one entry free is 50% probability(swapfile half full), the=
n
> >> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 E=
-5.
> >> > If the swapfile is 80% full, that number drops to 6.5 E -12.
> >>
> >> This depends on workloads.  Quite some workloads will show some degree
> >> of spatial locality.  For a workload with no spatial locality at all a=
s
> >> above, mTHP may be not a good choice at the first place.
> >
> > The fragmentation comes from the order 0 entry not from the mTHP. mTHP
> > have their own valid usage case, and should be separate from how you
> > use the order 0 entry. That is why I consider this kind of strategy
> > only works on the lucky case. I would much prefer the strategy that
> > can guarantee work not depend on luck.
>
> It seems that you have some perfect solution.  Will learn it when you
> post it.

No, I don't have perfect solutions. I see puting limit on order 0 swap
usage and writing out discontinuous swap entries from a folio are more
deterministic and not depend on luck. Both have their price to pay as
well.

>
> >> >> - Order-4 pages need to be swapped out, but no enough order-4 non-f=
ull
> >> >>   clusters available.
> >> >
> >> > Exactly.
> >> >
> >> >>
> >> >> So, we need a way to migrate non-full clusters among orders to adju=
st to
> >> >> the various situations automatically.
> >> >
> >> > There is no easy way to migrate swap entries to different locations.
> >> > That is why I like to have discontiguous swap entries allocation for
> >> > mTHP.
> >>
> >> We suggest to migrate non-full swap clsuters among different lists, no=
t
> >> swap entries.
> >
> > Then you have the down side of reducing the number of total high order
> > clusters. By chance it is much easier to fragment the cluster than
> > anti-fragment a cluster.  The orders of clusters have a natural
> > tendency to move down rather than move up, given long enough time of
> > random access. It will likely run out of high order clusters in the
> > long run if we don't have any separation of orders.
>
> As my example above, you may have almost 0 high-order clusters forever.
> So, your solution only works for very specific use cases.  It's not a
> general solution.

One simple solution is having an optional limitation of 0 order swap.
I understand you don't like that option, but there is no other easy
solution to achieve the same effectiveness, so far. If there is, I
like to hear it.

>
> >> >> But yes, data is needed for any performance related change.
> >>
> >> BTW: I think non-full cluster isn't a good name.  Partial cluster is
> >> much better and follows the same convention as partial slab.
> >
> > I am not opposed to it. The only reason I hold off on the rename is
> > because there are patches from Kairui I am testing depending on it.
> > Let's finish up the V5 patch with the swap cache reclaim code path
> > then do the renaming as one batch job. We actually have more than one
> > list that has the clusters partially full. It helps reduce the repeat
> > scan of the cluster that is not full but also not able to allocate
> > swap entries for this order.  Just the name of one of them as
> > "partial" is not precise either. Because the other lists are also
> > partially full. We'd better give them precise meaning systematically.
>
> I don't think that it's hard to do a search/replace before the next
> version.

The overhead is on the other internal experimental patches. Again,
I am not opposed to renaming it. Just want to do it at one batch not
many times, including other list names.

Chris

