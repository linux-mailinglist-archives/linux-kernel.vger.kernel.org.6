Return-Path: <linux-kernel+bounces-194899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE48D43E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EC91C2195E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A111C693;
	Thu, 30 May 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4Zw8rY1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650D8F4A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037657; cv=none; b=KSeX+A2qbrnWVZuG/aujAa//5aZbwP/vQ4Oy8J+EyIXoK3BZH5rn/pv6HHZGio69KfK4s4bzYymmd5GAscd9rPP5r6kCHRIyk9Z1minJ/yYKJeTmpEI4GP/3pWjk11s1kI+at3xClrceArc3H6Vg/sidWQtPGrYhhp9Op0P1v+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037657; c=relaxed/simple;
	bh=d8md9x7SBiL3q1zi6EOHY9MD8rjpR2Ja26NCg5WpPq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXObMppWzl3xK9UgnEe2lZ23OfzYLeC+VRRg7V3BCSJjVTV78T6yMCV8Kb7Har12oJlru2J4NF1zjocsigcWm2WGIrqOKGtvkyDT90NA3UpLCdF2TTIaumcP2oM2Y/op8VF7pXK5TiIUKGdkgu+hBRccpDjCp32B/1rcTOtLAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4Zw8rY1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717037656; x=1748573656;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=d8md9x7SBiL3q1zi6EOHY9MD8rjpR2Ja26NCg5WpPq0=;
  b=C4Zw8rY1XnyFMT8QPxz1m03kTxZLpWwEb+z9g/HxNdZOkZSitrSyk5CR
   gpbiJL7przKYZkYnRMLDoMcaxvlAyxpSZIuJTjvqaSrhtRiZPuJ3dJQYX
   NQsocr10JQY0yjqFnvzMqA13AeXq7VFdQyHf0NNwq0ER1OHjUjoEUx6/m
   KW4UdOychoJsmg5C/m1QTYuKsJ2z2rAARMBfBMeIegx2EbNCDI0VwzNZ0
   bpAjnT5pZWa8XG4TDfnmCrlw7lP1nEaZ7lAuF7QJLF1mHYLmkcXLhclBh
   FOnrD4rkY4uF5g0FJzk/ctDKC8dU0Hn4DenGUX9tZIy5RNpmFm+iitVSG
   g==;
X-CSE-ConnectionGUID: OAFFsIdxS8OoKUoedI4TCQ==
X-CSE-MsgGUID: QeKzn+ZBQm2nTnb5qbottg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13368282"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13368282"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 19:54:16 -0700
X-CSE-ConnectionGUID: 83EShAK2R5G2dyN3IJXvew==
X-CSE-MsgGUID: ANFGCL9WR1qERbEhYS7Gfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40561289"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 19:54:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
	(Chris Li's message of "Wed, 29 May 2024 18:13:33 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	<87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
Date: Thu, 30 May 2024 10:52:21 +0800
Message-ID: <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> Hi Ying,
>
> On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > I am spinning a new version for this series to address two issues
>> > found in this series:
>> >
>> > 1) Oppo discovered a bug in the following line:
>> > +               ci =3D si->cluster_info + tmp;
>> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
>> > That is a serious bug but trivial to fix.
>> >
>> > 2) order 0 allocation currently blindly scans swap_map disregarding
>> > the cluster->order.
>>
>> IIUC, now, we only scan swap_map[] only if
>> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[ord=
er]).
>> That is, if you doesn't run low swap free space, you will not do that.
>
> You can still swap space in order 0 clusters while order 4 runs out of
> free_cluster
> or nonfull_clusters[order]. For Android that is a common case.

When we fail to allocate order 4, we will fallback to order 0.  Still
don't need to scan swap_map[].  But after looking at your below reply, I
realized that the swap space is almost full at most times in your cases.
Then, it's possible that we run into scanning swap_map[].
list_empty(&si->free_clusters) &&
list_empty(&si->nonfull_clusters[order]) will become true, if we put too
many clusters in si->percpu_cluster.  So, if we want to avoid to scan
swap_map[], we can stop add clusters in si->percpu_cluster when swap
space runs low.  And maybe take clusters out of si->percpu_cluster
sometimes.

Another issue is nonfull_cluster[order1] cannot be used for
nonfull_cluster[order2].  In definition, we should not fail order 0
allocation, we need to steal nonfull_cluster[order>0] for order 0
allocation.  This can avoid to scan swap_map[] too.  This may be not
perfect, but it is the simplest first step implementation.  You can
optimize based on it further.

And, I checked your code again.  It appears that si->percpu_cluster may
be put in si->nonfull_cluster[], then be used by another CPU.  Please
check it.

--
Best Regards,
Huang, Ying

[snip]

