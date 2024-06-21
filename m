Return-Path: <linux-kernel+bounces-224224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4BC911F17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BEC1F25DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E716DED6;
	Fri, 21 Jun 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psdp6Wn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAD16D9C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959443; cv=none; b=Lb93yr2PQElb8RsQcNLc7+rxx9mcVERpNSkwhrk4zO3Y/BJK1pE39E/A6PFsGZrvTiMPiSoagRpzMhKLewAVXyQdlEoPpBoXpGzeIo05QpAsHOWKcALDwaVgT95Oy9XF/nNEeXhW3mlgMGh6OEtcdSp/VS3YauFIsyXZLoTaMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959443; c=relaxed/simple;
	bh=o0Av5eK5HMA8bUT1/2JpuZm4T45XRAPVuU2vzw/2gok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTQQtDq7hKOLfzCVHroq1aArHfobSwbgYWf9OV7NfmTQzoECCt+jkJO0TeP1XXE5zaim5ybWLO7ASAnWIFvSdzGUK4nfzcnY529QswV5d9Ta8rb1QYV52h5dkQ/XUHRM4cSj9k7Bf1Lg+Nf9jJgB0IpLe8kYV+UUflU/FwkUIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psdp6Wn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AEDC4AF0F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959442;
	bh=o0Av5eK5HMA8bUT1/2JpuZm4T45XRAPVuU2vzw/2gok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=psdp6Wn+IOWU+uWrZqm5/Kjyxzv/9hOkNDmhuB6Ymp2iDa/1DmsVbZq9rmldjlDsZ
	 IXuB+Kre/7lnXakmpcZzsjoHIcYSPoO8ne6js9whK1vRaH/I7mqpNOu7xKGDBMKBwe
	 3PlFASmX1vPqWk6b49XL/xkDWlvnj4W4PSSiEg6u9vsM9kuW20ELuSK9m0h1tqUrTN
	 H/pyS90b1ncyCImAoNrJkhV0Mnew4EXr3cbsMzAARh4t85O7wfgNXrLMVHCcoa1cSC
	 SRTqhD7/E0IDXNxnpuvRhdTjg18ZpvoMFaC8GF5efoC8uWHBE7XOGUjfCSDoILVB1a
	 P1nGAPc2PIVSg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec10324791so19195981fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:44:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlA9EXlFQYBTGOXHZOb1noIU2rQTKobX6IQwXi6jskZh/v+XtozkqsH4uAae4uDFcuzZ9su3CfOnmFYSSlZctvK1+KKoSlJcD6t7nD
X-Gm-Message-State: AOJu0YwA0K3E8D6Gn4qSGCQYBwzjqFnm1VD6fwdTcubf0zZfcLkJ5z2k
	S8nit7pjRuZ5e/s70WuoUipl5DfPt9ZHOEXZW7gw0gALmzB4drzYkZNpcvzZ2zB5T27e6k7hxDB
	z21m8gi6Uv8HLs70svyQVoH2j1Q==
X-Google-Smtp-Source: AGHT+IG+eAqntFEIwdnZSD69ZmTYMe1Yr1liB/5jhvYvIBL53EFxw3XhnO0rgnmc1RzNtqcZaeuxbQgHpGTWuQtEB1Q=
X-Received: by 2002:a2e:9e03:0:b0:2ec:40cf:fa9 with SMTP id
 38308e7fff4ca-2ec40cf117amr44259111fa.29.1718959441416; Fri, 21 Jun 2024
 01:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org> <87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 21 Jun 2024 01:43:49 -0700
X-Gmail-Original-Message-ID: <CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
Message-ID: <CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:32=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
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
> > The reason is that all the empty cluster has been exhausted while
> > there are planty of free swap entries to in the cluster that is
> > not 100% free.
> >
> > Remember the swap allocation order in the cluster.
> > Keep track of the per order non full cluster list for later allocation.
> >
> > User impact: For users that allocate and free mix order mTHP swapping,
> > It greatly improves the success rate of the mTHP swap allocation after =
the
> > initial phase.
> >
> > Barry provides a test program to show the effect:
> > https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.c=
om/
> >
> > Without:
> > $ mthp-swapout
> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback percen=
tage: 51.54%
> > Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback percenta=
ge: 100.00%
> > Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback percenta=
ge: 100.00%
> > Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback percenta=
ge: 100.00%
> > Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback percenta=
ge: 100.00%
> > Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback percent=
age: 100.00%
> > Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback percent=
age: 100.00%
> > Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback percent=
age: 100.00%
> > Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback percent=
age: 100.00%
> >
> > $ mthp-swapout -s
> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback percent=
age: 85.65%
> > Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback percenta=
ge: 100.00%
> > Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback percenta=
ge: 100.00%
> > Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback percenta=
ge: 100.00%
> > Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback percenta=
ge: 100.00%
> >
> > With:
> > $ mthp-swapout
> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > ...
> > Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >
> > $ mthp-swapout -s
> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > ...
> > Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percent=
age: 0.00%
> > Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>
> Unfortunately, the data is gotten using a special designed test program
> which always swap-in pages with swapped-out size.  I don't know whether
> such workloads exist in reality.  Otherwise, you need to wait for mTHP

The test program is designed to simulate mTHP swap behavior using
zsmalloc and 64KB buffer.
If we insist on only designing for existing workloads, then zsmalloc
using 64KB buffer usage will never be able to run, exactly due the
kernel has high failure rate allocating swap entries for 64KB. There
is a bit of a chick and egg problem there, such a usage can not exist
because the kernel can't support it yet. Kernel can't add patches to
support it because such simulation tests are not "real".

We need to break this cycle to support something new.

> swap-in to be merged firstly, and people reach consensus that we should
> always swap-in pages with swapped-out size.

We don't have to be always. We can identify the situation that makes
sense. For the zram/zsmalloc 64K buffer usage case, swap out as the
same swap in size makes sense.
I think we have agreement on such zsmalloc 64K usage cases we do want
to support.

>
> Alternately, we can make some design adjustment to make the patchset
> work in current situation (mTHP swap-out, normal page swap-in).
>
> - One non-full cluster list for each order (same as current design)
>
> - When one swap entry is freed, check whether one "order+1" swap entry
>   becomes free, if so, move the cluster to "order+1" non-full cluster
>   list.

In the intended zsmalloc usage case, there is no order+1 swap entry request=
.
Moving the cluster to "order+1" will make less cluster available for "order=
".
For that usage case it is negative gain.

> - When allocate swap entry with "order", get cluster from free, "order",
>   "order+1", ... non-full cluster list.  If all are empty, fallback to

I don't see that it is useful for the zsmalloc 64K buffer usage case.
There will be order 0 and order 4 and nothing else.

How about let's keep it simple for now. If we identify some workload
this algorithm can help. We can do that as a follow up step.

>   order 0.
>
> Do you think that this works?
>
> > Reported-by: Barry Song <21cnbao@gmail.com>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Changes in v3:
> > - Using V1 as base.
> > - Rename "next" to "list" for the list field, suggested by Ying.
> > - Update comment for the locking rules for cluster fields and list,
> >   suggested by Ying.
> > - Allocate from the nonfull list before attempting free list, suggested
> >   by Kairui.
>
> Haven't looked into this.  It appears that this breaks the original
> discard behavior which helps performance of some SSD, please refer to

Can you clarify by "discard" you mean SSD discard command or just the
way swap allocator recycles free clusters?

> commit 2a8f94493432 ("swap: change block allocation algorithm for SSD").

I did read that change log. Help me understand in more detail which
discard behavior you have in mind. A lot of low end micro SD cards
have proper FTL wear leveling now, ssd even better on that.

> And as pointed out by Ryan, this may reduce the opportunity of the
> sequential block device writing during swap-out, which may hurt
> performance of SSD too.

Only at the initial phase. If the swap IO continues, after the first
pass fills up the swap file, the write will be random on the swapfile
anyway. Because the swapfile only issues 2M discards commands when all
512 4K pages are free. The discarded area will be much smaller than
the free area on swapfile. That combined with the random write page on
the whole swap file. It might produce a worse internal write
amplification for SSD, compared to only writing a subset of the
swapfile area. I would love to hear from someone who understands SSD
internals to confirm or deny my theory.

Even let's assume the SSD wants a free block over a nonfull cluster
first. Zswap and zram swap are not subject to SSD property. We might
want to have a kernel option to select using  nonfree clusters over
the free one for zram and zswap (ghost swapfile). That will help
contain the fragmented swap area.

Chris

