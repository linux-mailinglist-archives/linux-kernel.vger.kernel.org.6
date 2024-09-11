Return-Path: <linux-kernel+bounces-324076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1F9747AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EF21C25A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0E1CF92;
	Wed, 11 Sep 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPBlga5U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BB18C3E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017295; cv=none; b=NfYGEg6nf/CRZa14F72r/y13EQANE9MAuNgDkyABzOeCqDuqA81JNEEkfMTtSMqkx2syTrf5PUzynte2A98ZKiHIsZaRSvzQtY8mmDQsXHsKuzV15bkr0kwGQo2WzSO/U9YSXftPR2wW5W2DIQJ/Le4W3nIxgoUFNzENAkR3+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017295; c=relaxed/simple;
	bh=JkxPpkKyaZKOXFrI24q959UCrQqUzmaM/yQpsNcLszg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSeUhg0WTi3w/YfqLT2my2ZxLh6mNjg8/pXDoi5ij7axEv9YOa6rWlBsM4awGuM6zxD8QRefXhXmu6FAx9YHx+fslaI0NW6JD/01rwp/JFAQXxx/QlXj/BcEMV9OZW+RTPC2Z3sc8FUd3sUO1hOYAWfzLdFeWAClAM8WGFV2GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPBlga5U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726017294; x=1757553294;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JkxPpkKyaZKOXFrI24q959UCrQqUzmaM/yQpsNcLszg=;
  b=YPBlga5U8QIH7gO/y9gx/26029aE0hWjaImOAi9hDdZXDn2giBisgxue
   Bep+uOntJLAiMiFFar3rfGxCxTDt4LVuKshJlvN27qykG6s6uHXn2etxz
   GUXaEU35p7bsWbpJKwNb00LVilbdfFobnQx4TOMdTEPE+xKtU38r8QhA6
   VzFpyYC8ORrGypqYNPsLetxy7n1FAmLdng2PdRvSCzM6wcPQRJS0RrUVv
   a60H8fBmY7RwCr4F0c0zajm6RDX0aahMy8LuJ38jykjNXLP/5Hx4/FqBX
   mJp21ifUpGfULWAOpvz5Fu9LgQ3qiUkYG14GkLBrvZsmsBBTvPaFV12K5
   g==;
X-CSE-ConnectionGUID: tMtW34F4TVWuGFp9Xn8o0g==
X-CSE-MsgGUID: xQ0M/MqERe+CYMGDDEw3oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24734651"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24734651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:14:54 -0700
X-CSE-ConnectionGUID: mv52wyQ6Q1CkL26nnumGDw==
X-CSE-MsgGUID: Zq5A12oTRx+hGKeSn+Izlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71353115"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:14:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
  kunit-dev@googlegroups.com,  "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>,  "open list"
 <linux-kernel@vger.kernel.org>,  "Anders Roxell"
 <anders.roxell@linaro.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "David Gow" <davidgow@google.com>
Subject: Re: Kunit: kernel/resource.c: In function 'gfr_start':
 include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first use
 in this function)
In-Reply-To: <aaee4ddb-68a8-42ae-bb68-11ef991ada1c@app.fastmail.com> (Arnd
	Bergmann's message of "Mon, 09 Sep 2024 20:20:23 +0000")
References: <CA+G9fYtNY+S0Ls2f3atJS_Y9Nh3V01EKO5jbPtVYbgch0TYsFA@mail.gmail.com>
	<aaee4ddb-68a8-42ae-bb68-11ef991ada1c@app.fastmail.com>
Date: Wed, 11 Sep 2024 09:11:18 +0800
Message-ID: <87plpbvvt5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Arnd,

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Mon, Sep 9, 2024, at 20:00, Naresh Kamboju wrote:
>> The arm kunit builds failed on the Linux next-20240909 due to following
>> build warnings / errors with gcc-13 and clang-19 with extra Kconfigs
>>
>>   CONFIG_OF_KUNIT_TEST=y
>>   CONFIG_KASAN=y
>>   CONFIG_KUNIT=y
>>   CONFIG_KUNIT_ALL_TESTS=y
>>
>> First seen on next-20240909
>>   Good: next-20240906
>>   BAD:  next-20240909
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>
> This patch below addresses the build regression, not sure if that
> is what we want.
>
>         Arnd
>
>>From 39601b1274354c710368f5cf40fe9e32540f7591 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 9 Sep 2024 13:10:21 +0000
> Subject: [PATCH] resource, kunit: add sparsemem dependency
>
> The testcase now selects CONFIG_GET_FREE_REGION, but that
> is only available for sparsemem configurations:
>
> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>   Depends on [n]: SPARSEMEM [=n]
>   Selected by [m]:
>   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
> In file included from include/linux/ioport.h:15,
>                  from kernel/resource.c:15:
> kernel/resource.c: In function 'gfr_start':
> include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first use in this function)
>   101 | # define PHYSMEM_END    ((1ULL << MAX_PHYSMEM_BITS) - 1)
> kernel/resource.c:1874:57: note: in expansion of macro 'PHYSMEM_END'
>  1874 |                 end = min_t(resource_size_t, base->end, PHYSMEM_END);
>       |                                                         ^~~~~~~~~~~
>
> It may be better to extend this to non-sparsemem, but a Kconfig
> dependency is the easiest way to address the build failure at the
> moment.
>
> Fixes: e2941fe697c8 ("resource, kunit: add test case for region_intersects()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index b986050fc7e0..4c081a28fe96 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2632,6 +2632,7 @@ config HASH_KUNIT_TEST
>  config RESOURCE_KUNIT_TEST
>  	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> +	depends on SPARSEMEM
>  	default KUNIT_ALL_TESTS
>  	select GET_FREE_REGION
>  	help

Thanks for the fixing patch.  I think that this is caused by merge
conflict.

For the fix, IMHO, resource kunit test may be used on architectures with
SPARSEMEM=n.  I have a fix patch in,

https://lore.kernel.org/linux-mm/87wmjkyshl.fsf@yhuang6-desk2.ccr.corp.intel.com/

--
Best Regards,
Huang, Ying

