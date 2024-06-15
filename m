Return-Path: <linux-kernel+bounces-215673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A39095BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF021F221CD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500ACCA6B;
	Sat, 15 Jun 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRnHVi6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9A2907
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419884; cv=none; b=avUEodOSJ6osyyIqEoNSmthAlkS/hWddJnabokEIPF7+zRBNd/2yj6YS/aOKma4X5Re/BLWFEBJ53hYJ6KxGRpJtOpAWNwUNNX4OXj5CIXP2xlNkV7e+Fcu6DVhTKYsKUrrsLhucnGHCL3Kjy45zRZ9NgxSoMGE8E7aVN+/WacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419884; c=relaxed/simple;
	bh=hzi5z305rKc8dBhBbV12L+aW0t0uf3vTIaGYA2JEyow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4J9WvVdeNA2ofeklGnWQJmcQBzaThjQmm2zeUdiZ1nG6WJD0XATKD9C1oyNit5nZtWP6+HOlrTh3eQ3vkv6JsqFTemeYyk5RAOdKCGpeEjBYEGvk6Vt/oYoEGKhUjWE7OHnhTm6aaCLCLLRgrRfmpvlOnpjlcRtkrU2O3bs05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRnHVi6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D837C32786
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718419884;
	bh=hzi5z305rKc8dBhBbV12L+aW0t0uf3vTIaGYA2JEyow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRnHVi6RJfhc2x1SI9E4uMlPJkB+SthoGu/EV0JstH1PivYbYn8W/dVMBqAmzkMjm
	 h2D8GbDpaXcK0q8B5fx7IVXI0ohO9L9Vu3mhMHuzSRbYF0lmgzULecVE0IjpHOoNVh
	 mIZOadwtUoniRtAxCGa5GNyZCa4eAop448B/fgwCzoq1BRx9SzGA0m9x9PPWubS2/F
	 vQFKaiHpNpiASTCWddXnINLuxrj1nsEqPloBOARPSErkVInvxJI9yLph/Oa5iRNFK+
	 9HjnlAB4rzFte3vFBKMg93lkVIXGoYgAJeGyopVZKcVGmh87Yrj7xmkWQzmpzfv8jV
	 SXTdfFv8nFiCw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c32d934c2so3036916e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVclL7WSUGq+emkLRQXQo4zEMyErHhn8oJRt4tDz00MmNECFjHhK+1OG1zmzTq1JnlIvjzPzamsZa+NEXNTgXTu2RL5o++CLrZvw3PR
X-Gm-Message-State: AOJu0YzGtO21lZARpB/ytZIVAlIfsqNCv9tBexfiDfYjEdKmcypc51PS
	yYjOMgulFAWsvdNP/ODg9dcZfqMni93CCV3g0gtWl9vGUOfrGr9v63jzsvUQ/aExce0iTXV5QIg
	hw+zCwQ2oKaXzUZzzyrgs8N6tBA==
X-Google-Smtp-Source: AGHT+IE8dUPtHypxvylrw+AB71eNYrAw2oIJ2PJBuO3mGPTftvYSz51CQy8hmvtoE7AzYEJOfKcySsZNAwSaGEkpyfA=
X-Received: by 2002:a05:6512:20cb:b0:52b:bd97:ffde with SMTP id
 2adb3069b0e04-52ca6e55d56mr2574730e87.7.1718419882804; Fri, 14 Jun 2024
 19:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org> <20240614180606.5f3b6f4a6cd515df30b7a0e4@linux-foundation.org>
In-Reply-To: <20240614180606.5f3b6f4a6cd515df30b7a0e4@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 14 Jun 2024 19:51:11 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=Nd3Os7cm-Lu4h5fvkMdoHeYbtjkUja+sAMcJ2moMKrQ@mail.gmail.com>
Message-ID: <CANeU7Q=Nd3Os7cm-Lu4h5fvkMdoHeYbtjkUja+sAMcJ2moMKrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 6:06=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 14 Jun 2024 16:48:06 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > This is the short term solutiolns "swap cluster order" listed
> > in my "Swap Abstraction" discussion slice 8 in the recent
> > LSF/MM conference.
> >
> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> > orders" is introduced, it only allocates the mTHP swap entries
> > from new empty cluster list.  It has a fragmentation issue
> > reported by Barry.
> >
> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+=
Ah+NSgNQ@mail.gmail.com/
> >
> > The mTHP allocation failure rate raises to almost 100% after a few
> > hours in Barry's test run.
> >
> > The reason is that all the empty cluster has been exhausted while
> > there are planty of free swap entries to in the cluster that is
> > not 100% free.
> >
> > Remember the swap allocation order in the cluster.
> > Keep track of the per order non full cluster list for later allocation.
> >
> > This greatly improve the sucess rate of the mTHP swap allocation.
> >
>
> I'm having trouble understanding the overall impact of this on users.
> We fail the mTHP swap allocation and fall back, but things continue to
> operate OK?

Continue to operate OK in the sense that the mTHP will have to split
into 4K pages before the swap out, aka the fall back. The swap out and
swap in can continue to work as 4K pages, not as the mTHP. Due to the
fallback, the mTHP based zsmalloc compression with 64K buffer will not
happen. That is the effect of the fallback. But mTHP swap out and swap
in is relatively new, it is not really a regression.

>
> > There is some test number in the V1 thread of this series:
> > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@ker=
nel.org
>
> Well, please let's get the latest numbers into the latest patchset.
> Along with a higher-level (and quantitative) description of the user impa=
ct.

I will need Barray's help to collect the number. I don't have the
setup to reproduce his test result.
Maybe a follow up commit message amendment for the test number when I get i=
t?

>
> I'll add this into mm-unstable now for some exposure, but at this point
> I'm not able to determine whether it should go in as a hotfix for
> 6.10-rcX.

Maybe not need to be a hotfix. Not all Barry's mTHP swap out and swap
in patch got merged yet.

Chris

