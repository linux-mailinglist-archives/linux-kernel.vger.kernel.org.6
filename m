Return-Path: <linux-kernel+bounces-262850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68493CDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EDB282DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE512156677;
	Fri, 26 Jul 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbQQdzMn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05A18641
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973340; cv=none; b=G+umL9OdPqV37e6AAhYZIT1LOfh/qUaiy4SEyJKeZXZA/8jiGaxTXd99Plg+4IwPz4RVy8pP9huA7FpDAil98gxmTq4yTU7qT9k3/6ZdFLO/zlzRnknO9EyE2iSGdhyRihegKCoB+04XwM8qMgn5+xaPDIJGuMr1G9BDjROkKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973340; c=relaxed/simple;
	bh=k0Voiw1tqOqaSA+ul5dSBP+qW+fdcsI9oLOuIpuZ7P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbZ5OM4/3O6n3XhKx/65uYhzMrY0w4Tc8CfV2HojXmBml0T7EQxYdR/zf5QKCa+YAIyxDVRuTLjQeOdwAELf3ViPpr7OYynfV7bLsTzTGXSe1vsYgHWDKUcDviAwQ5doiqCsoMxUbdy1iM1/+EALNUM1hKscZIhC2ZkQsBJy9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbQQdzMn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721973338; x=1753509338;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=k0Voiw1tqOqaSA+ul5dSBP+qW+fdcsI9oLOuIpuZ7P8=;
  b=IbQQdzMn7TB8VY5NO8/iSGnN5Lbu9jeXfwSNpaYPSuTJ5+S2gBw5yOxL
   rPd0/q7p28gLEJAk3tpCdpOnVd9/OjejFKzDNDRwkV33NeXKHzLxuA9C+
   ajnfo0HORPSWaABOQXt58WNIa/oG22/njYYxd409mzOTZ5IOhTPjMS+RK
   aKBZn2f/LVFJsNGQ5pDUaG5aYSV3FCfPG6YMOB1FZK5hfHd1OMGXNFks9
   ctPRkZXnHwDPrtUFczVeJnvIdISwlpOzeh43KVdpu/iQU9phdUIL0DJvW
   KAytG4Yb9Nn9ch3CeSkB/LhgGjDRFHq9cVo+ZwBP4gEpLzSBxfQY7QAcC
   A==;
X-CSE-ConnectionGUID: XX4W3QIVRgWTVL7pITqM5w==
X-CSE-MsgGUID: V9/PuyoIRNyoOvmiZD7Nsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19905394"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19905394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 22:55:37 -0700
X-CSE-ConnectionGUID: CYK+Ga7FRbmLZDWoDeX/Og==
X-CSE-MsgGUID: 4C7s8pMgSSyyAqOJUnUGFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="52833629"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 22:55:35 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kairui Song <kasong@tencent.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
	(Chris Li's message of "Thu, 25 Jul 2024 21:50:56 -0700")
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
	<20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
	<ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
	<CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
	<b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
	<CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
	<874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
	<87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<43f73463-af42-4a00-8996-5f63bdf264a3@arm.com>
	<87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com>
	<87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
	<87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
	<87zfq43o4n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbXZ_DqxwiNPckBPAhxqoDoMRFRzhM24_8TcHQz-LTop_w@mail.gmail.com>
Date: Fri, 26 Jul 2024 13:52:02 +0800
Message-ID: <87o76k3dkt.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jul 25, 2024 at 7:07=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>> > If the freeing of swap entry is random distribution. You need 16
>> > continuous swap entries free at the same time at aligned 16 base
>> > locations. The total number of order 4 free swap space add up together
>> > is much lower than the order 0 allocatable swap space.
>> > If having one entry free is 50% probability(swapfile half full), then
>> > having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 E-5.
>> > If the swapfile is 80% full, that number drops to 6.5 E -12.
>>
>> This depends on workloads.  Quite some workloads will show some degree
>> of spatial locality.  For a workload with no spatial locality at all as
>> above, mTHP may be not a good choice at the first place.
>
> The fragmentation comes from the order 0 entry not from the mTHP. mTHP
> have their own valid usage case, and should be separate from how you
> use the order 0 entry. That is why I consider this kind of strategy
> only works on the lucky case. I would much prefer the strategy that
> can guarantee work not depend on luck.

It seems that you have some perfect solution.  Will learn it when you
post it.

>> >> - Order-4 pages need to be swapped out, but no enough order-4 non-full
>> >>   clusters available.
>> >
>> > Exactly.
>> >
>> >>
>> >> So, we need a way to migrate non-full clusters among orders to adjust=
 to
>> >> the various situations automatically.
>> >
>> > There is no easy way to migrate swap entries to different locations.
>> > That is why I like to have discontiguous swap entries allocation for
>> > mTHP.
>>
>> We suggest to migrate non-full swap clsuters among different lists, not
>> swap entries.
>
> Then you have the down side of reducing the number of total high order
> clusters. By chance it is much easier to fragment the cluster than
> anti-fragment a cluster.  The orders of clusters have a natural
> tendency to move down rather than move up, given long enough time of
> random access. It will likely run out of high order clusters in the
> long run if we don't have any separation of orders.

As my example above, you may have almost 0 high-order clusters forever.
So, your solution only works for very specific use cases.  It's not a
general solution.

>> >> But yes, data is needed for any performance related change.
>>
>> BTW: I think non-full cluster isn't a good name.  Partial cluster is
>> much better and follows the same convention as partial slab.
>
> I am not opposed to it. The only reason I hold off on the rename is
> because there are patches from Kairui I am testing depending on it.
> Let's finish up the V5 patch with the swap cache reclaim code path
> then do the renaming as one batch job. We actually have more than one
> list that has the clusters partially full. It helps reduce the repeat
> scan of the cluster that is not full but also not able to allocate
> swap entries for this order.  Just the name of one of them as
> "partial" is not precise either. Because the other lists are also
> partially full. We'd better give them precise meaning systematically.

I don't think that it's hard to do a search/replace before the next
version.

--
Best Regards,
Huang, Ying

