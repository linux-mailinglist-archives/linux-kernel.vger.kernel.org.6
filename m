Return-Path: <linux-kernel+bounces-262938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9793CEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CE91C21774
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40E176248;
	Fri, 26 Jul 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4zMYjjY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD9175568
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979171; cv=none; b=TK1cGUtIWCLbYA3+jFZhtk8NTQD5GQPRQax9Sbk1qIJKTXAkIcww82QPZMBz978k8k6MN4uhAw6YO+VRwYrtcEuMKWluyAcQ74BTurmeAzLgnO9KCNvokQ0N7F+ov8OpChbOfxG06/M+NXaV2+bK6kfcDib6z7/BgMc5Ywk7wOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979171; c=relaxed/simple;
	bh=xRmILblJ54qqwxCEnXupQO3wlslsHCFAgUEkXfKxiEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVEypjR8B5qgypVbeWVc9MlnRGD1w+ntpHgDxMJRlTBAPMyH1enQIFmLiccN/deq6GuNHy8x4KWhcM8vhG5sLAnZ9/AVOr/uiTwSOADKQS/sZefn7jXSQ33+C1r1AZsDxC/m/F/IvQ0byp8jBMJOzJzusTGf5vWcU6irnksoWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4zMYjjY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721979169; x=1753515169;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xRmILblJ54qqwxCEnXupQO3wlslsHCFAgUEkXfKxiEw=;
  b=i4zMYjjYnox+bh/zfv1Xn8IGujkcCeHh3hiuSQv0E2Zh2B3AllPz7IX3
   VItA2771eKuIfS+UtgsbZIYcOD7rRagvyeahA4g4qeXh8NxoLrj/JM0H8
   VkhWQYf1S0JR75rECKK1T/4V35aZdjTevlDXGe19YXMERvKqZxAVo9j+t
   kU5hshYis7RZvaLfZfpKiQFjMCU4zqNLse1chtOtiMnNQtYOmg5+rdeWp
   ca04ovhfl0M7IAj7RvuRJpnnY3LSU3PMyYCEshUKd1nbUok3Ppm0H13xr
   iIxG4MaC1TxJ+Mv2JtKEBIKGhtncLN75bR3pU2i855pZG3RpaMBXZFpiz
   w==;
X-CSE-ConnectionGUID: Uh4u8JtkTSSHoKYrYGSHag==
X-CSE-MsgGUID: I8iB52gkTZqFVRwLc8BpTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19558773"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19558773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:32:49 -0700
X-CSE-ConnectionGUID: Tn/TOyOzTNqdsijLqqX4vw==
X-CSE-MsgGUID: XPWg7DiASZCecmFSS3kVqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="52882301"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:32:46 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <CACePvbWXAJTuT+tRvVZNMZA_qHZz-44iKYLn3RnSeLzv64zxZw@mail.gmail.com>
	(Chris Li's message of "Fri, 26 Jul 2024 00:22:39 -0700")
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
	<87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CANeU7Qno3o-nDjYP7Pf5ZTB9Oh_zOGU0Sv_kV+aT=Z0j_tdKjg@mail.gmail.com>
	<87bk3pzr5p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc5TBZP6QuHS_aQ@mail.gmail.com>
	<87frrw3aju.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbWXAJTuT+tRvVZNMZA_qHZz-44iKYLn3RnSeLzv64zxZw@mail.gmail.com>
Date: Fri, 26 Jul 2024 15:29:13 +0800
Message-ID: <877cd8392u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Fri, Jul 26, 2024 at 12:01=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Mon, Jun 24, 2024 at 7:36=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > On Wed, Jun 19, 2024 at 7:32=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Chris Li <chrisl@kernel.org> writes:
>> >> >>
>> >> >> > This is the short term solutiolns "swap cluster order" listed
>> >> >> > in my "Swap Abstraction" discussion slice 8 in the recent
>> >> >> > LSF/MM conference.
>> >> >> >
>> >> >> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>> >> >> > orders" is introduced, it only allocates the mTHP swap entries
>> >> >> > from new empty cluster list.  It has a fragmentation issue
>> >> >> > reported by Barry.
>> >> >> >
>> >> >> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhg=
MQdSMp+Ah+NSgNQ@mail.gmail.com/
>> >> >> >
>> >> >> > The reason is that all the empty cluster has been exhausted while
>> >> >> > there are planty of free swap entries to in the cluster that is
>> >> >> > not 100% free.
>> >> >> >
>> >> >> > Remember the swap allocation order in the cluster.
>> >> >> > Keep track of the per order non full cluster list for later allo=
cation.
>> >> >> >
>> >> >> > User impact: For users that allocate and free mix order mTHP swa=
pping,
>> >> >> > It greatly improves the success rate of the mTHP swap allocation=
 after the
>> >> >> > initial phase.
>> >> >> >
>> >> >> > Barry provides a test program to show the effect:
>> >> >> > https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@=
gmail.com/
>> >> >> >
>> >> >> > Without:
>> >> >> > $ mthp-swapout
>> >> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback=
 percentage: 51.54%
>> >> >> > Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback =
percentage: 100.00%
>> >> >> > Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback =
percentage: 100.00%
>> >> >> > Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback =
percentage: 100.00%
>> >> >> > Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback =
percentage: 100.00%
>> >> >> >
>> >> >> > $ mthp-swapout -s
>> >> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback =
percentage: 85.65%
>> >> >> > Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback p=
ercentage: 100.00%
>> >> >> > Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback p=
ercentage: 100.00%
>> >> >> >
>> >> >> > With:
>> >> >> > $ mthp-swapout
>> >> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > ...
>> >> >> > Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback=
 percentage: 0.00%
>> >> >> >
>> >> >> > $ mthp-swapout -s
>> >> >> > Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback p=
ercentage: 0.00%
>> >> >> > ...
>> >> >> > Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback =
percentage: 0.00%
>> >> >> > Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback=
 percentage: 0.00%
>> >> >>
>> >> >> Unfortunately, the data is gotten using a special designed test pr=
ogram
>> >> >> which always swap-in pages with swapped-out size.  I don't know wh=
ether
>> >> >> such workloads exist in reality.  Otherwise, you need to wait for =
mTHP
>> >> >
>> >> > The test program is designed to simulate mTHP swap behavior using
>> >> > zsmalloc and 64KB buffer.
>> >> > If we insist on only designing for existing workloads, then zsmalloc
>> >> > using 64KB buffer usage will never be able to run, exactly due the
>> >> > kernel has high failure rate allocating swap entries for 64KB. There
>> >> > is a bit of a chick and egg problem there, such a usage can not exi=
st
>> >> > because the kernel can't support it yet. Kernel can't add patches to
>> >> > support it because such simulation tests are not "real".
>> >> >
>> >> > We need to break this cycle to support something new.
>> >> >
>> >> >> swap-in to be merged firstly, and people reach consensus that we s=
hould
>> >> >> always swap-in pages with swapped-out size.
>> >> >
>> >> > We don't have to be always. We can identify the situation that makes
>> >> > sense. For the zram/zsmalloc 64K buffer usage case, swap out as the
>> >> > same swap in size makes sense.
>> >> > I think we have agreement on such zsmalloc 64K usage cases we do wa=
nt
>> >> > to support.
>> >> >
>> >> >>
>> >> >> Alternately, we can make some design adjustment to make the patchs=
et
>> >> >> work in current situation (mTHP swap-out, normal page swap-in).
>> >> >>
>> >> >> - One non-full cluster list for each order (same as current design)
>> >> >>
>> >> >> - When one swap entry is freed, check whether one "order+1" swap e=
ntry
>> >> >>   becomes free, if so, move the cluster to "order+1" non-full clus=
ter
>> >> >>   list.
>> >> >
>> >> > In the intended zsmalloc usage case, there is no order+1 swap entry
>> >> > request.
>> >>
>> >> This my main concern about this series.  Only the Android use cases a=
re
>> >> considered.  The general use cases are just ignored.  Is it hard to
>> >> consider or test a normal swap partition on your development machine?
>> >
>> > Please see the V4 cover letter. The V4 already has the SSD, zram and
>> > HDD stress testing.
>> > Of course I want to make sure the allocator works well with Barry's
>> > mthp test case as well.
>> >
>> >> > Moving the cluster to "order+1" will make less cluster available fo=
r "order".
>> >> > For that usage case it is negative gain.
>> >>
>> >> The "order+1" cluster can be used to allocate "order" cluster when
>> >> existing "order" cluster is used up.
>> >>
>> >> And in this way, we can protect clusters with more free spaces so that
>> >> they may become free.
>> >>
>> >> >> - When allocate swap entry with "order", get cluster from free, "o=
rder",
>> >> >>   "order+1", ... non-full cluster list.  If all are empty, fallbac=
k to
>> >> >
>> >> > I don't see that it is useful for the zsmalloc 64K buffer usage cas=
e.
>> >> > There will be order 0 and order 4 and nothing else.
>> >> >
>> >> > How about let's keep it simple for now. If we identify some workload
>> >> > this algorithm can help. We can do that as a follow up step.
>> >>
>> >> The simple design isn't flexible enough for your workloads too.  For
>> >> example,
>> >>
>> >> - Initially, almost only order-0 pages are swapped out, most non-full
>> >>   clusters are order-0.
>> >>
>> >> - Later, quite some order-0 swap entries are freed so that there are
>> >>   quite some order-4 swap entries available.
>> >>
>> >> - Order-4 pages need to be swapped out, but no enough order-4 non-full
>> >>   clusters available.
>> >>
>> >> So, we need a way to migrate non-full clusters among orders to adjust=
 to
>> >> the situations automatically.
>> >
>> > Depends on how lucky it is to form the order-4 cluster naturally. The
>> > odds of forming the order-4 cluster naturally in random swap
>> > allocation/ free case is very low. I have the number in my other email
>> > thread.
>> > Anyway, if we convince this payout for the complexity it introduces,
>> > we can do that as follow up steps. Try to keep things simple at first
>> > for the review benefit.
>> >
>> >>
>> >> >>   order 0.
>> >> >>
>> >> >> Do you think that this works?
>> >> >>
>> >> >> > Reported-by: Barry Song <21cnbao@gmail.com>
>> >> >> > Signed-off-by: Chris Li <chrisl@kernel.org>
>> >> >> > ---
>> >> >> > Changes in v3:
>> >> >> > - Using V1 as base.
>> >> >> > - Rename "next" to "list" for the list field, suggested by Ying.
>> >> >> > - Update comment for the locking rules for cluster fields and li=
st,
>> >> >> >   suggested by Ying.
>> >> >> > - Allocate from the nonfull list before attempting free list, su=
ggested
>> >> >> >   by Kairui.
>> >> >>
>> >> >> Haven't looked into this.  It appears that this breaks the original
>> >> >> discard behavior which helps performance of some SSD, please refer=
 to
>> >> >
>> >> > Can you clarify by "discard" you mean SSD discard command or just t=
he
>> >> > way swap allocator recycles free clusters?
>> >>
>> >> The SSD discard command, like in the following URL,
>> >>
>> >> https://en.wikipedia.org/wiki/Trim_(computing)
>> >
>> > Thanks. I know what an SSD discard command is. Want to understand why
>> > that behavior is preferred.
>> >
>> > So the reasoning to prefer a new free block rather than a recent
>> > particle free cluster is to let the previous written cluster have a
>> > higher chance to issue the discard command?
>> >
>> > This preferred new block behavior is actually not friendly to SSD from
>> > a wearing point of view.
>> > Take this example:
>> > Let say the data need to allocate and free from swap. At any given
>> > time the swap usage is 1G. The swap SSD drive is 16G.
>> > Let say the allocation and free are at random 4K page locations. There
>> > is totally 64G swap data needed to write to swap, but at any given
>> > time there is only 1G data occupite on swapfile.
>> >
>> > a) If you always prefer new free blocks. Then the swap data will
>> > eventually write at all 16G drives then random write to full 16G.
>> > Chance of forming a free cluster so a discard command can be issued is
>> > very low. (15/16)**512 =3D 4.4E-15. From SSD point of view, it does not
>> > know most of the data written to 16G drive is not used. When a page is
>> > free on a swapfile, SSD drive doesn't know about it. It sees 4K random
>> > writes to all 16G of the drive, total 64G data written.
>> >
>> > b) If you always prefer a non full cluster first over a new cluster.
>> > The 64G data will concentrate random writing to the first 1G of drive
>> > location. Total 64G data written.
>> >
>> > I consider b) are more friendly to SSD than a). Because concentrate
>> > the write into the first 1G location. The SSD can know the data
>> > overwritten in those 1G has internally obsolete, so it can internally
>> > GC the those overwritten data without a discard command. Where a)
>> > random 4K writes to the whole drive without much discard at all. Full
>> > SSD doing random writes is a bad combination from a wearing point of
>> > view.
>> >
>> > Just my 2 cents. Anyway I revert the V4 to use free cluster before
>> > nonfull cluster just to behave the same as previously.
>> >
>> >> >> commit 2a8f94493432 ("swap: change block allocation algorithm for =
SSD").
>> >> >
>> >> > I did read that change log. Help me understand in more detail which
>> >> > discard behavior you have in mind. A lot of low end micro SD cards
>> >> > have proper FTL wear leveling now, ssd even better on that.
>> >>
>> >> It's not FTL, it's discard/trim for SSD as above.
>> >
>> > Thanks for the clarification.
>> >
>> >>
>> >> >> And as pointed out by Ryan, this may reduce the opportunity of the
>> >> >> sequential block device writing during swap-out, which may hurt
>> >> >> performance of SSD too.
>> >> >
>> >> > Only at the initial phase. If the swap IO continues, after the first
>> >> > pass fills up the swap file, the write will be random on the swapfi=
le
>> >> > anyway. Because the swapfile only issues 2M discards commands when =
all
>> >> > 512 4K pages are free. The discarded area will be much smaller than
>> >> > the free area on swapfile. That combined with the random write page=
 on
>> >> > the whole swap file. It might produce a worse internal write
>> >> > amplification for SSD, compared to only writing a subset of the
>> >> > swapfile area. I would love to hear from someone who understands SSD
>> >> > internals to confirm or deny my theory.
>> >>
>> >> It depends on workloads.  Some workloads will have more severe
>> >> fragmentation than others.  For example, on quite some machines, the
>> >> swap devices will be far from being full to avoid possible OOM.
>> >
>> > I suspect most of the SSD swap on client devices nowadays are only as
>> > backup just in case it needs to be swapped.
>> > There is not much SSD swap IO during normal use. The zram and zswap
>> > are more actively used in the data center and Android phone case, from
>> > swap IO ops point of view.
>>
>> I use a Linux laptop with 16GB DRAM for work.  And I found that the swap
>> space are almost always used.
>
> Just curious how many swap OPS per second on average? I suspect it
> will be a very low number.

It depends on workloads.  I have run some LLM pruning experiment
algorithm on the machine.  The swap IOPS is high for that.

[snip]

--
Best Regards,
Huang, Ying

