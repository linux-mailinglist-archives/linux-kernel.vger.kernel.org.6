Return-Path: <linux-kernel+bounces-388139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689029B5B34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C7EB21D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1A1993B1;
	Wed, 30 Oct 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmdYXm/m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FE33E7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266178; cv=none; b=eUWguyvhWfCP5UpApYEkREmmzGe9e+xHke9IKWB4I+ardI8SeN5stoQe/S1z79d5BzSnSmAvTvffU8fR5Gczdt4GPNMrC6n6t62YPmJEI6u/Pm5FbMfVhZO0ZfGR/jC82sV1VXPyoNxKCQ+ZXjvTYkBJVz4U8QDD89RlWZ5uBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266178; c=relaxed/simple;
	bh=BzMhPOvr65ahHVJ3qMxFG8vjBGKRF8xyTjN5oC/B3FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q85CxDf7bF5Y/wNMkcd+aXR6H9YMXY5ZP7zf7SR4eb+D/xxLJvdtai9ck3K+3QogNiVLn8z4FUJzXXxmWZOu6Hkq35Dk8qSeDBM1PymaNhRu6v2iSlqlN3HDBMMqcFqzf8Fo0QYsQyFSppfXOnSSoZEV5aZ6uHn2blL9VhOuZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmdYXm/m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730266176; x=1761802176;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=BzMhPOvr65ahHVJ3qMxFG8vjBGKRF8xyTjN5oC/B3FA=;
  b=dmdYXm/mpGGICIxYCKMTzygaPLlL4cvEyxtb8kcuBMKwGcseuMkMDiks
   jheiDFr7bbrvyjYvof6kh/x9IgUYNHEGgqRlxko34l8nPEPLe/rQrZhBQ
   U2FUZI0FXHvtA48dFy0yUBKRrpZYeqERZMzAIXEfH9q0ySnnDu15tY3Wu
   FL2r1eE1HHrRRde10BA6zEOy44tiJBeold+xk07/cQHUBGAX+m+3qpds5
   6o8kV3Ly8cCCtbDKmE6w/XYQEZhZubgIetkQz1gMqsxY6pstjyLUFaRq2
   ltu4CdDet4cUkmiqoBwKUingqZmO/Bsp549sgKkr/ItQ28R141TSSbh14
   w==;
X-CSE-ConnectionGUID: VMujDF+tRBi4pzWRcu1igQ==
X-CSE-MsgGUID: LTnkcyE9QD6exhpKarHk8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40481698"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40481698"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:29:35 -0700
X-CSE-ConnectionGUID: An9WfAeWQHK8FnV5xvcS1g==
X-CSE-MsgGUID: 2/sgSOihSJqQLGt1uHRO+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82364993"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:29:32 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,  David
 Hildenbrand <david@redhat.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Chris Li <chrisl@kernel.org>,  Yosry
 Ahmed <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH] mm: add per-order mTHP swpin counters
In-Reply-To: <CAGsJ_4yv0CqAyiA1WaPdNm8HSUL5pda9frgT_1H31+FZt1fGjg@mail.gmail.com>
	(Barry Song's message of "Wed, 30 Oct 2024 17:33:46 +1300")
References: <20241026082423.26298-1-21cnbao@gmail.com>
	<87o7329s0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yv0CqAyiA1WaPdNm8HSUL5pda9frgT_1H31+FZt1fGjg@mail.gmail.com>
Date: Wed, 30 Oct 2024 13:25:58 +0800
Message-ID: <87jzdq9n6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Wed, Oct 30, 2024 at 4:45=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > This helps profile the sizes of folios being swapped in. Currently,
>> > only mTHP swap-out is being counted.
>>
>> Better to describe the user space interface in patch description?
>>
>
> Do you mean something as below?
>
> The new interface can be found at:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>          swapin

Yes.  Some example output may be even better.

--
Best Regards,
Huang, Ying

