Return-Path: <linux-kernel+bounces-285261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CE950B57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138D31F23532
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE81A2562;
	Tue, 13 Aug 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J21tYD7f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6633170A18;
	Tue, 13 Aug 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569771; cv=none; b=iw5aAVVuik3bNP3g9WKSqhEhaVFXoFUIxpQZVnk408bjxUow8SQJDdf3ACAp0SL6oP1t0H2khOily8ctSUqaTYiWMHfWUPnigw7eV4A79wz/hmQkUKzgB8cckNsIkakXEJYbc0rC1wCP5L26NfwROna+Qjmzf+XnfruW9rGWWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569771; c=relaxed/simple;
	bh=PXjGkj2+4r+pOwvax1EJsHXufhiX5E5s/WYsh43Fu9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsxQCad0ahCRYNoT2qNFZmap+5uV1bQs52Zsw0Uwei1BAHPlgNXhECyWkf20AFvlRQX+ze9z4mqcRvZUCfTVTe9TrEIMlpKQYxAY/wn97kmsX+qYZO7oiwA/6V2Yls4Eco5eHEft8PWCrZ3W6ROlJkUSd5JutVT2Z5f6NMcqWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J21tYD7f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723569770; x=1755105770;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PXjGkj2+4r+pOwvax1EJsHXufhiX5E5s/WYsh43Fu9g=;
  b=J21tYD7f3NOg7A+hHsu/lHuS5Mnv6bUKzP29N75LWZVyJJKpjNRsbdKg
   iyvj9zupgpC7h50ZWqjEs5nqRUyHpUx3o94hL3x6LdvbAxejx1Ay4jAaC
   5Vom3aYq7m5ioGkx8Ssj++u9ftHzV0fnpUt2TaZyYZctYworVfVAAJ7n0
   uxca99Gf8DUW4Jr4d16yWRhzGjOB0lC7FVwF42nolYGYG/gYZ2MkHgBpR
   LAef8wdZKuzXyLSq6plKFRZC8eO+oZtfV6IU41NHTuedIc46YqY896YU/
   9/8OX9/kRmJG4QafNF9IBCqi7qzQxPkEHwviv83/3WIif0EhQe32zy8BO
   g==;
X-CSE-ConnectionGUID: 1n54UM1rRfazmbduPD0Obg==
X-CSE-MsgGUID: STHeEZt/RaaaX7DRg7+PPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39257079"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="39257079"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:22:49 -0700
X-CSE-ConnectionGUID: 9AfD1iuWTmC/9e/5rre4IQ==
X-CSE-MsgGUID: YUgBNSyfR5CAsRM+vDHsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58430370"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2024 10:22:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 474E230125F; Tue, 13 Aug 2024 10:22:48 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,  hannes@cmpxchg.org,
  riel@surriel.com,  shakeel.butt@linux.dev,  roman.gushchin@linux.dev,
  yuzhao@google.com,  david@redhat.com,  baohua@kernel.org,
  ryan.roberts@arm.com,  rppt@kernel.org,  willy@infradead.org,
  cerasuolodomenico@gmail.com,  corbet@lwn.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] mm: split underutilized THPs
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com> (Usama Arif's
	message of "Tue, 13 Aug 2024 13:02:43 +0100")
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Date: Tue, 13 Aug 2024 10:22:48 -0700
Message-ID: <87y150mj6f.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usama Arif <usamaarif642@gmail.com> writes:
>
> This patch-series is an attempt to mitigate the issue of running out of
> memory when THP is always enabled. During runtime whenever a THP is being
> faulted in or collapsed by khugepaged, the THP is added to a list.
> Whenever memory reclaim happens, the kernel runs the deferred_split
> shrinker which goes through the list and checks if the THP was underutilized,
> i.e. how many of the base 4K pages of the entire THP were zero-filled.

Sometimes when writing a benchmark I fill things with zero explictly
to avoid faults later. For example if you want to measure memory
read bandwidth you need to fault the pages first, but that fault
pattern may well be zero.

With your patch if there is memory pressure there are two effects:

- If things are remapped to the zero page the benchmark
reading memory may give unrealistically good results because
what is thinks is a big memory area is actually only backed
by a single page.

- If I expect to write I may end up with an unexpected zeropage->real
memory fault if the pages got remapped. 

I expect such patterns can happen without benchmarking too.
I could see it being a problem for latency sensitive applications.

Now you could argue that this all should only happen under memory
pressure and when that happens things may be slow anyways and your
patch will still be an improvement.

Maybe that's true but there might be still corner cases
which are negatively impacted by this. I don't have a good solution
other than a tunable, but I expect it will cause problems for someone.

The other problem I have with your patch is that it may cause the kernel
to pollute CPU caches in the background, which again will cause noise in
the system. Instead of plain memchr_inv, you should probably use some
primitive to bypass caches or use a NTA prefetch hint at least.

-Andi

