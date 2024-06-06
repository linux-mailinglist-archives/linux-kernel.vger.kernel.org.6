Return-Path: <linux-kernel+bounces-203513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811058FDC5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DBE1C22CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3A14AB8;
	Thu,  6 Jun 2024 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTFD9ilR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19567CA6B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639040; cv=none; b=BHwXHMEzt3dUdgMRgtOpkFyvwssXgXotm5JxPBTSKN8E0tge2AmXyc+1mNtTZaLzA4Zmtvrxt7ko8zk6LxfMryosjxxIS6B9X2OOTuC+MKX0+04ydrJclevlX3B6ArykaH6fQVd6c7lyZ4MkFuqveE4b8v9AGlGSCwKYLow/kDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639040; c=relaxed/simple;
	bh=1+jnYSMue3rbA1K7GRIby88dm6CNWh/oOxG1dvm29rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kL4iAxz0CK/R5olXPBlPGCZleEHZmNojNYVlLDYrq1qoLN/tsWBQyRf4UI9jLtoRvY/J/zxc1Mek4gcVXCY04JwzEh2NskcovFLW3q7UE3CKQDLzoQNV2WmqQizzA3V0MfW1kdXYPLNv+PDuoOZXgBJbyrdjS3mPf3VPHk+YuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTFD9ilR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717639039; x=1749175039;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=1+jnYSMue3rbA1K7GRIby88dm6CNWh/oOxG1dvm29rk=;
  b=gTFD9ilROcQ+rt6LMYsL3Aey7kJ/umP/0+yD0YxQriurzRqIES+Sx2OC
   Hw3SIZy3Wexcpg36BoN+uSASY6hCPXduQi+gsIv4MqGNFfKpylx7eoRUC
   ssaPCXPiSyTUZDXcjtqHgi28YoodWvHJXtRBkQP2XHGkQ0bkDOPohpUsc
   zztxuQSUsSC32e/jmSnnmebBpqqSc6eTcAdp8YrAYz1/hgzYT7cf/VcZv
   RB65J9DvVuBH9SKdkgdqWDLVuiPM+3ww7/FipuYh7MSZJTwJl3s87hkWh
   3HT3iAj2C9Mg0rN1suH1VIlenPsk1oSFQCormrb6AZPhgck7Rqg46KaT3
   w==;
X-CSE-ConnectionGUID: QkjoFmwERxmq24bgAWgg9A==
X-CSE-MsgGUID: IlLUe6x9RHaQhLYcj+q2RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25393560"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25393560"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:57:18 -0700
X-CSE-ConnectionGUID: 7XySAZOaRGqZvpdpxSGUDw==
X-CSE-MsgGUID: UbC28saqSDaLJkLI4E2GTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42725519"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:57:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
	(Chris Li's message of "Wed, 5 Jun 2024 00:08:12 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	<87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
	<875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
	<87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuPLhmJqMi-unDOm820c8_kRnQVA_dnSfgRzMXaHKnDHAQ@mail.gmail.com>
Date: Thu, 06 Jun 2024 09:55:24 +0800
Message-ID: <875xum96nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, May 30, 2024 at 7:37=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> > because android does not have too many cpu. We are talking about a
>> > handful of clusters, which might not justify the code complexity. It
>> > does not change the behavior that order 0 can pollut higher order.
>>
>> I have a feeling that you don't really know why swap_map[] is scanned.
>> I suggest you to do more test and tracing to find out the reason.  I
>> suspect that there are some non-full cluster collection issues.
>
> Swap_map[] is scanned because of running out of non full clusters.
> This can happen because Android tries to make full use of the swapfile.
> However, once the swap_map[] scan happens, the non full cluster is pollut=
ed.
>
> I currently don't have a local reproduction of the issue Barry reported.
> However here is some data point:
> Two swap files, one for high order allocation only with this patch. No
> fall back.
> If there is a non-full cluster collection issue, we should see the
> fall back in this case as well.
>
> BTW, same setup without this patch series it will fall back on the
> high order allocation as well.
>
>>
>> >> Another issue is nonfull_cluster[order1] cannot be used for
>> >> nonfull_cluster[order2].  In definition, we should not fail order 0
>> >> allocation, we need to steal nonfull_cluster[order>0] for order 0
>> >> allocation.  This can avoid to scan swap_map[] too.  This may be not
>> >> perfect, but it is the simplest first step implementation.  You can
>> >> optimize based on it further.
>> >
>> > Yes, that is listed as the limitation of this cluster order approach.
>> > Initially we need to support one order well first. We might choose
>> > what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
>> > are too big. The sweet spot might be some there in between.  If we can
>> > support one order well, we can demonstrate the value of the mTHP. We
>> > can worry about other mix orders later.
>> >
>> > Do you have any suggestions for how to prevent the order 0 polluting
>> > the higher order cluster? If we allow that to happen, then it defeats
>> > the goal of being able to allocate higher order swap entries. The
>> > tricky question is we don't know how much swap space we should reserve
>> > for each order. We can always break higher order clusters to lower
>> > order, but can't do the reserves. The current patch series lets the
>> > actual usage determine the percentage of the cluster for each order.
>> > However that seems not enough for the test case Barry has. When the
>> > app gets OOM kill that is where a large swing of order 0 swap will
>> > show up and not enough higher order usage for the brief moment. The
>> > order 0 swap entry will pollute the high order cluster. We are
>> > currently debating a "knob" to be able to reserve a certain % of swap
>> > space for a certain order. Those reservations will be guaranteed and
>> > order 0 swap entry can't pollute them even when it runs out of swap
>> > space. That can make the mTHP at least usable for the Android case.
>>
>> IMO, the bottom line is that order-0 allocation is the first class
>> citizen, we must keep it optimized.  And, OOM with free swap space isn't
>> acceptable.  Please consider the policy we used for page allocation.
>
> We need to make order-0 and high order allocation both can work after
> the initial pass of allocating from empty clusters.
> Only order-0 allocation work is not good enough.
>
> In the page allocation side, we have the hugetlbfs which reserve some
> memory for high order pages.
> We should have similar things to allow reserve some high order swap
> entries without getting polluted by low order one.

TBH, I don't like the idea of high order swap entries reservation.  If
that's really important for you, I think that it's better to design
something like hugetlbfs vs core mm, that is, be separated from the
normal swap subsystem as much as possible.

>>
>> > Do you see another way to protect the high order cluster polluted by
>> > lower order one?
>>
>> If we use high-order page allocation as reference, we need something
>> like compaction to guarantee high-order allocation finally.  But we are
>> too far from that.
>
> We should consider reservation for high-order swap entry allocation
> similar to hugetlbfs for memory.
> Swap compaction will be very complicated because it needs to scan the
> PTE to migrate the swap entry. It might be easier to support folio
> write out compound discontiguous swap entries. That is another way to
> address the fragmentation issue. We are also too far from that as
> right now.

That's not easy to write out compound discontiguous swap entries too.
For example, how to put folios in swap cache?

>>
>> For specific configuration, I believe that we can get reasonable
>> high-order swap entry allocation success rate for specific use cases.
>> For example, if we only do limited maximum number order-0 swap entries
>> allocation, can we keep high-order clusters?
>
> Yes we can. Having a knob to reserve some high order swap space.
> Limiting order 0 is the same as having some high order swap entries
> reserved.
>
> That is a short term solution.

--
Best Regards,
Huang, Ying

