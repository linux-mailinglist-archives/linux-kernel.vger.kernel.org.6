Return-Path: <linux-kernel+bounces-231244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD203918813
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875CE2823B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E318F2F5;
	Wed, 26 Jun 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E36+TvcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5713B5BB;
	Wed, 26 Jun 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421226; cv=none; b=g7lDFHwOopmpk0acFgeyVfct0VOMBxFvR/JMlRs4J7mG8nAwwYPKjRQqZ6TDd1Me/TzLSH68IpTvhawx6YqzvAL4Xbp66AdoiSvHckQUSvn5mMh8+nAnPILx9UjE1tFt8b5MHgUur30g46FNc1xlNH5cC/gNSrYmTVsncfVs+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421226; c=relaxed/simple;
	bh=ck9BJVN94A8X/goWOfcFcUMXyljByonN8PhcWCiNwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgM/8qfvXFTPlNDzY6/OBFKINemueb5siFDu+wnVpslLFwudIpq5lXUGsyA6LPw91nQ8rq2dxVRpyC/lo9SYdxHKCt/QsS+KMEdscHrCIDhy8SEaKBmNDgIb4rEg6T0RKus9Tn/W+hyz37vCTNmHKtYh3BqDw8Pzbc9tlOn4U6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E36+TvcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D09C116B1;
	Wed, 26 Jun 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421226;
	bh=ck9BJVN94A8X/goWOfcFcUMXyljByonN8PhcWCiNwW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E36+TvcNN3NIJeM5crOgJkH0f6cMwNGvgheTm9IsQYiTTspJzzo9y4W7/iRLX2gkJ
	 LeDP+u3Fger1rdyxgA+iPB15PHH4jI211/GKltEBqDVD84XHc1pb0gViBxAnDpgwd1
	 iNiigvFZi5Uuw/6wX7dzpY6E8almLmxQFiyoZjJ4WB9FgrO9BgvAYBBHd0qAcasDP8
	 +s9R0uK7MD+YmvSj5TWO6Jwx+zP6Gso03BB/gVLi7aceTIGZzKSqkIZrEFOtdfznra
	 AycdZtptf5sDCQs/V9EjHq9B5aZkETF0rnHlwAQJ+w/blJJ8OR7yiFfzHO2t4IUyxH
	 73ZaPNzvCdqag==
Date: Wed, 26 Jun 2024 10:00:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	lkft-triage@lists.linaro.org,
	clang-built-linux <llvm@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Lance Yang <ioworker0@gmail.com>
Subject: Re: mm: huge_memory.c:2736:31: error: variable 'page' is
 uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <20240626170023.GA65296@fedora-macbook-air-m2>
References: <CA+G9fYv-rWNXZ9JxA19qSP0r+jhPDaMJejKbckN72kT1UpQ3QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv-rWNXZ9JxA19qSP0r+jhPDaMJejKbckN72kT1UpQ3QA@mail.gmail.com>

Hi Naresh,

On Wed, Jun 26, 2024 at 10:14:56PM +0530, Naresh Kamboju wrote:
> The x86_64 clang builds failed on Linux next due to these warnings / errors.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ------
> mm/huge_memory.c:2736:31: error: variable 'page' is uninitialized when
> used here [-Werror,-Wuninitialized]
>  2736 |         folio_remove_rmap_pmd(folio, page, vma);
>       |                                      ^~~~
> /builds/linux/mm/huge_memory.c:2700:19: note: initialize the variable
> 'page' to silence this warning
>  2700 |         struct page *page;
>       |                          ^
>       |                           = NULL
> 1 error generated.
> 
> patch that is causing this build failures,
>   mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

Thanks for the report. It looks like Andrew addressed this in
mm-unstable based on an earlier report (although that change might need
some more polish ;)

https://lore.kernel.org/202406260514.SLhNM9kQ-lkp@intel.com/

https://git.kernel.org/akpm/mm/c/199e6c3bd568657e85ead22d6f41c46e74ad9a75

Cheers,
Nathan

