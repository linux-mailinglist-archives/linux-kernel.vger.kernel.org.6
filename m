Return-Path: <linux-kernel+bounces-408821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 980719C83EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9182819BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327B1EC00B;
	Thu, 14 Nov 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OmhenwFx"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69831EBA17
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569081; cv=none; b=Tvlg06Bt1/34yoB2a38RosstbVJumOlKTfZrrWQScABThSZl4qnsDsmuSm3fZ1DzpI51HmVN8/e+zCnMXi4S3xzeneggifSR2QQliGN5MC3UMQ4cLWpJSXTQlDFkSYSWRNxbeBZbHY00FcwdT+IJ7gMPSMoReDhED5v+E16skIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569081; c=relaxed/simple;
	bh=pxBF18LLrtzw0rOlim/7KrTwEZd/62KHOfarfNNr/4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4Q/CVT4PrE9fmxfxllgDvVJbXomBpj2WRIsBVfZ7bZp1W0bVdQbttyevUQq2YooVCdppP9s3en5cX/k4u802JnzLY/5aHfjY1+QtrMK6chguAwgFV+4cGxe5pO1jYpce+EiyOmmtx8T4rZ+Z+Cr1yvNjwU8o9O8Yike8+zE/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OmhenwFx; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731569074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JpPiLXj9tOb+MaLA4ZmbYFoZeOfrmnX3jkfIXiyJdA=;
	b=OmhenwFx3IE/B8liNUfMehNSM08DpoAYCy1ypNJ9YnfwfgtgKKApC8fsPw8QdUBhjbFIVx
	x+TdTtkvRYyaRyxwNHTmcP5L16BA07b5RvOhcChqWB9DkNLx8dRKQ8gKL6ScJkRRf25t6C
	ql32e4Wn4IZllpCG1Aav5rASztsuRyY=
Date: Thu, 14 Nov 2024 15:24:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
 <21cnbao@gmail.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
 "Gopal, Vinodh" <vinodh.gopal@intel.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello,

On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
> 
>> -----Original Message-----
>> From: Johannes Weiner <hannes@cmpxchg.org>
>> Sent: Wednesday, November 13, 2024 9:12 PM
>> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
>> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
>> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
>> mm@kvack.org; chengming.zhou@linux.dev; usamaarif642@gmail.com;
>> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
>> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
>> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
>> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
>> zswap_decompress().
>>
>> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana P wrote:
>>> So my question was, can we prevent the migration to a different cpu
>>> by relinquishing the mutex lock after this conditional
>>
>> Holding the mutex doesn't prevent preemption/migration.
> 
> Sure, however, is this also applicable to holding the mutex of a per-cpu
> structure obtained via raw_cpu_ptr()?

Yes, unless you use migration_disable() or cpus_read_lock() to protect
this section.

> 
> Would holding the mutex prevent the acomp_ctx of the cpu prior to
> the migration (in the UAF scenario you described) from being deleted?

No, cpu offline can kick in anytime to free the acomp_ctx->buffer.

> 
> If holding the per-cpu acomp_ctx's mutex isn't sufficient to prevent the
> UAF, I agree, we might need a way to prevent the acomp_ctx from being
> deleted, e.g. with refcounts as you've suggested, or to not use the

Right, refcount solution from Johannes is very good IMHO.

> acomp_ctx at all for the check, instead use a boolean.

But this is not enough to just avoid using acomp_ctx for the check,
the usage of acomp_ctx inside the mutex is also UAF, since cpu offline
can kick in anytime to free the acomp_ctx->buffer.

Thanks.

