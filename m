Return-Path: <linux-kernel+bounces-368340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329149A0E96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8466DB22E31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC420F5D8;
	Wed, 16 Oct 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKQgcL0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E20F5CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093116; cv=none; b=TMLIN9j9IrnW8FWhbTXBDf3EmAqJS8n0OXMTtekMdWh6E23oU7D6r4hj2F7IvW7PDyL91xnsKpkykqMigcuMJ36rBu/J9i/HSnuIQYX6ulbR4XYxDZ4tWMPtyxAk/IMMxYKp3ZwWJdmcV38DxZaTG2yhv1hal+SwsbMw0VuLvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093116; c=relaxed/simple;
	bh=29ow3Nc5Mi5UPGBCiX3p6gcTOJuG3+bSE570gzg2QgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqqE8xi8tXQZIFQBhMRTOyEqT4QmUC5sB9dkr1+m08+G+xSDDyKM6rw642WAZhqeHTmKJIzYp4FEkgKLsvTrRp0bF9rXqVsQr1VUXpBHuH6AbUZbmR1sSRXDZqlEVBLYqAi72UzYr3/TmK7iwHtL+C1eEWaLKsq+Dj7P1H/9tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKQgcL0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A7C4CECF;
	Wed, 16 Oct 2024 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729093116;
	bh=29ow3Nc5Mi5UPGBCiX3p6gcTOJuG3+bSE570gzg2QgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKQgcL0b1wNTfytC/wVDlDeCvENl0LBhevXSYBUE6VlyPM3bJDSngob4BdYyiv0gu
	 liwk3uiMiDGYjffxQ88BtNfRTwJa0Fq9saX+1ckbVQ/Nl8BqRflJkkPissKd0Y9ALT
	 V3p/0nYyXNdc0sUEe8LO8G+MYGYALfpZjfvvfMzws63VP30VSLsUwpgKiwrmakoczQ
	 /R7cIW5+Ozv+JNkHJvg/OGx8ILu7V9uX8G2bg6vip2RzJrN/5/anTjhiozWeP5DYi9
	 7uIFbk1u4w2UeZQfqQ0v2ku2HREFlTTHcBgmirERU+muTV4V1HgoV0YW8L/b9TT79y
	 lVcUqkDFJOAVw==
Date: Wed, 16 Oct 2024 08:38:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH -v2] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
Message-ID: <20241016153833.GA385255@thelio-3990X>
References: <20241016014730.339369-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016014730.339369-1-ying.huang@intel.com>

On Wed, Oct 16, 2024 at 09:47:30AM +0800, Huang Ying wrote:
> We want to use the functions (get_free_mem_region()) configured via
> GET_FREE_REGION in resource kunit tests.  However, GET_FREE_REGION
> depends on SPARSEMEM now.  This makes resource kunit tests cannot be
> built on some architectures lacking SPARSEMEM, or causes config
> warning as follows,
> 
>   WARNING: unmet direct dependencies detected for GET_FREE_REGION
>   Depends on [n]: SPARSEMEM [=n]
>   Selected by [y]:
>   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
> 
> When get_free_mem_region() was introduced the only consumers were
> those looking to pass the address range to memremap_pages(). That
> address range needed to be mindful of the maximum addressable platform
> physical address which at the time only SPARSMEM defined via
> MAX_PHYSMEM_BITS.
> 
> Given that memremap_pages() also depended on SPARSEMEM via
> ZONE_DEVICE, it was easier to just depend on that definition than
> invent a general MAX_PHYSMEM_BITS concept outside of SPARSEMEM.
> 
> Turns out that decision was buggy and did not account for KASAN
> consumption of physical address space. That problem was resolved
> recently with commit ea72ce5da228 ("x86/kaslr: Expose and use the end
> of the physical memory address space"), and GET_FREE_REGION dropped
> its MAX_PHYSMEM_BITS dependency.
> 
> Then commit 99185c10d5d9 ("resource, kunit: add test case for
> region_intersects()"), went ahead and fixed up the only remaining
> dependency on SPARSEMEM which was usage of the PA_SECTION_SHIFT macro
> for setting the default alignment. A PAGE_SIZE fallback is fine in the
> SPARSEMEM=n case.
> 
> With those build dependencies gone GET_FREE_REGION no longer depends
> on SPARSEMEM.  So, the patch removes dependency on SPARSEMEM from
> GET_FREE_REGION to fix the build issues.
> 
> Link: https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
> Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

Thanks for adding the Fixes tag, as this should go via -hotfixes.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  mm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4c9f5ea13271..33fa51d608dc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>  	depends on MMU
>  
>  config GET_FREE_REGION
> -	depends on SPARSEMEM
>  	bool
>  
>  config DEVICE_PRIVATE
> -- 
> 2.39.2
> 

