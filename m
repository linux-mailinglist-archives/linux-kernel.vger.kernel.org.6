Return-Path: <linux-kernel+bounces-360618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BECC999D51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1721EB2247A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B451209F36;
	Fri, 11 Oct 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z36q0s2C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F36209686
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629975; cv=none; b=o/ZCwoQtodeF8eTQRcZoYiKh6CAphN7JqIo2kYhQWxeag209xfrA756yt53k4V9MSNbiIIxGi7uW3DaEJ8dud1NQqRYhaAgrZOX32426vkeRlIE7yUT/yuArwsATlWcBUS3Er4dEQT8xbcX5d9av3NKFt6LKdkU2wwoyHmtqu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629975; c=relaxed/simple;
	bh=JdHmTcFa+nm2iysBKEaftSFgG2BVS8vi3HU9lhfDQ9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qNu/0ZH0Ig9cVRH+pssHDnGsIVczKegJC0zN3NYUpsXqazWH94M6nscDR7jO+Qk9HxJ1Gfwnq+AMkzFaEq9ecg+byw6swTQugHzPuyBMpF6WS10Qn5H/ri0b7Iy5zaWoKRnahB5mgms7kgI5g6bivyqwoBPIRXJAZMRVQuGqwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z36q0s2C; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728629973; x=1760165973;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JdHmTcFa+nm2iysBKEaftSFgG2BVS8vi3HU9lhfDQ9E=;
  b=Z36q0s2C2qlJdn7QA1FGMsXUiQsTgKKDvwA/ZBgm7hYzldLrDCTBjpg8
   /lSPDduBw+fG6iX8YTnIlbJT9f0uRTEcdnL9FtLLVHTfEoegtjR8ipWvJ
   F9QKATSSWgrxAmzNOKXccsHMZXl0o6DKnG6mBuFe+G70gRiCe3ZyaoKyP
   G2S3/dbSwUGrPjYgbzg1DPnRQVCkJ9V7zU89g5bWgBAy56goBteOG2UZL
   xj3bDju5Vj3UIsSMViQGQ/rIJxtxC8q/JRRc4aHXKf9WschlJD/15qoo4
   +11Tu8iQImd+qWRUrIPTaHy7SChERMhw/Gr9vYMf340FefvyL+/4Knsto
   w==;
X-CSE-ConnectionGUID: SoSCq8siTsmXZ8x3A1P0Cg==
X-CSE-MsgGUID: +r4f6NDfRg+aMbV9d0J0aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39149351"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39149351"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:59:33 -0700
X-CSE-ConnectionGUID: 3oJ1+dsmTUuZizomQfM19g==
X-CSE-MsgGUID: q69F8MBARm+VDKnd1v1Cuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107553921"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:59:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  Vlastimil Babka <vbabka@suse.cz>,
  <linux-mm@kvack.org>,  Alexander Potapenko <glider@google.com>,  Kees
 Cook <keescook@chromium.org>,  Andrew Morton <akpm@linux-foundation.org>,
  "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Miaohe Lin
 <linmiaohe@huawei.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  John
 Hubbard <jhubbard@nvidia.com>,  <linux-kernel@vger.kernel.org>,  Ryan
 Roberts <ryan.roberts@arm.com>
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
In-Reply-To: <7C05C178-AE68-4899-BC4B-CE83C17A5BF0@nvidia.com> (Zi Yan's
	message of "Tue, 08 Oct 2024 09:46:28 -0400")
References: <20241007182315.401167-1-ziy@nvidia.com>
	<9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
	<84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
	<be1a1c1b-4630-41e2-a79a-57447851017d@suse.cz>
	<b8272cb4-aee8-45ad-8dff-353444b3fa74@redhat.com>
	<7C05C178-AE68-4899-BC4B-CE83C17A5BF0@nvidia.com>
Date: Fri, 11 Oct 2024 14:55:56 +0800
Message-ID: <878quv9lhf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zi Yan <ziy@nvidia.com> writes:

> On 8 Oct 2024, at 9:06, David Hildenbrand wrote:
>
>> On 08.10.24 14:57, Vlastimil Babka wrote:
>>> On 10/8/24 13:52, Zi Yan wrote:
>>>> On 8 Oct 2024, at 4:26, David Hildenbrand wrote:
>>>>
>>>>>
>>>>> I remember we discussed that in the past and that we do *not* want to=
 sprinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kernel.
>>>>>
>>>>> Ideally, we'd use GFP_ZERO and have the buddy just do that for us? Th=
ere is the slight chance that we zero-out when we're not going to use the a=
llocated folio, but ... that can happen either way even with the current co=
de?
>>>>
>>>> I agree that putting CONFIG_INIT_ON_ALLOC_DEFAULT_ON here is not ideal=
, but
>>>
>>> Create some nice inline wrapper for the test and it will look less ugly=
? :)
>
> something like?
>
> static inline bool alloc_zeroed()
> {
> 	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> 			&init_on_alloc);
> }
>
>
> I missed another folio_zero_user() caller in alloc_anon_folio() for mTHP.
> So both PMD THP and mTHP are zeroed twice for all arch.
>
> Adding Ryan for mTHP.
>
>>>
>>>> folio_zero_user() uses vmf->address to improve cache performance by ch=
anging
>>>> subpage clearing order. See commit c79b57e462b5 ("mm: hugetlb: clear t=
arget
>>>> sub-page last when clearing huge page=E2=80=9D). If we use GFP_ZERO, w=
e lose this
>>>> optimization. To keep it, vmf->address will need to be passed to alloc=
ation
>>>> code. Maybe that is acceptable?
>>>
>>> I'd rather not change the page allocation code for this...
>>
>> Although I'm curious if that optimization from 2017 is still valuable :)
>
> Maybe Ying can give some insight on this.

I guess the optimization still applies now.  Although the size of the
per-core(thread) last level cache increases, it's still quite common for
it to be smaller than the size of THP.  And the sizes of L1/L2 are
significantly smaller, the likelihood for the accessed cache line to be
in L1/L2/LLC increases with the optimization.

--
Best Regards,
Huang, Ying

