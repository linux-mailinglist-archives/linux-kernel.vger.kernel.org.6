Return-Path: <linux-kernel+bounces-529847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1DA42BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F094A1885AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8C266188;
	Mon, 24 Feb 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfQxnxG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AB2641E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422423; cv=none; b=Cky9MA/Yk2SQQB/BHkIFn0/lr31xL/s8dTfeJHlphqaAyseld2MbKH7iOsXhxpevMssj4QA2pfFPEI+Hi+QDSDsSaVOxzOxcW3RAH7tjHcXXnmnm3S5r4o39idvRd20a9gA2/wUsQTBJTbK8r6s5VbVjyGuAewCbVPEIVRTXxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422423; c=relaxed/simple;
	bh=W/4TB0pejHdesPEYcGw7u9G1KUlaFKUiog0H0ebCgZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7YqcZWBDsAFq84J8HdzsfYCuKT1l28aGDzE6HBSn/FSSooSUUF4PAQaEWmupMvJlqMj4QwBnmOaT/AoNMy9xToJkRisMQWJqEf5b2j45XtvKmJiRZ8lPNnCoaadatRo3zJPnO3yRRvT1EZQ9n1DQ3ES+Zg28NCD/gamMlev18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfQxnxG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966EC4CED6;
	Mon, 24 Feb 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740422423;
	bh=W/4TB0pejHdesPEYcGw7u9G1KUlaFKUiog0H0ebCgZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfQxnxG24sBcRNpkmE9jJOV0VHHLnAJuqY1IqaHBobd2C89p4o7xcDVJR2vzU7sPz
	 gO7KSCyBga9aWmwMTwDz1jpLA5ktMAjhWvYsMvQHMAxREiXCp1/q7Y3mVNvT135xu6
	 P3NhsooPfOd2tyx1Cml545qQoxRP7s3VWaGMIot8P9FLoVQgIKadBHD2BCskVwGLYX
	 WZyioBs5RC8lZ6R4j4ZmGDhGV7vpEHkXeDBObtGltAvPinAn9Y5stzuTffG2BsS9zj
	 HTbCm9z1TEeSh+z9A/0L0ktC1FLFbaTRa1/G1jsI6eQcp7Y9nXYWZnJkI5/OM1M3pV
	 VVLYZ4TYLAVvA==
Date: Mon, 24 Feb 2025 10:40:19 -0800
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brian Mak <makb@juniper.net>,
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: unhide get_dump_page() function
Message-ID: <202502241038.A4A1ED25A1@keescook>
References: <20250224151225.3637934-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224151225.3637934-1-arnd@kernel.org>

On Mon, Feb 24, 2025 at 04:12:21PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The definition of get_dump_page() is guarded by CONFIG_ELF_CORE, but
> the caller has now moved into a function that is built based on
> CONFIG_COREDUMP, which leads to a possible link failure:
> 
> ld.lld-21: error: undefined symbol: get_dump_page
> >>> referenced by coredump.c
> >>>               fs/coredump.o:(dump_vma_snapshot) in archive vmlinux.a
> 
> Change the #ifdef block around the definition to match the caller.
> In practice there is very little difference, as setting COREDUMP
> but not ELF_CORE is not useful.
> 
> Fixes: ff41385709f0 ("coredump: Only sort VMAs when truncating or core_sort_vma sysctl is set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this! I think I'm going to split up ff41385709f0 -- between
this #ifdef and the recent prototype changes, it's going to be not a
great backport, so I'll pick this up too. I expect I'll have a simple
sysctl fix for -rc5 and then the rest in -next.

-Kees

> ---
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d846c0ce41d6..15d6d7b5df1d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2266,7 +2266,7 @@ EXPORT_SYMBOL(fault_in_readable);
>   *
>   * Called without mmap_lock (takes and releases the mmap_lock by itself).
>   */
> -#ifdef CONFIG_ELF_CORE
> +#ifdef CONFIG_COREDUMP
>  struct page *get_dump_page(unsigned long addr, int *locked)
>  {
>  	struct page *page;
> @@ -2276,7 +2276,7 @@ struct page *get_dump_page(unsigned long addr, int *locked)
>  				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>  	return (ret == 1) ? page : NULL;
>  }
> -#endif /* CONFIG_ELF_CORE */
> +#endif /* CONFIG_COREDUMP */
>  
>  #ifdef CONFIG_MIGRATION
>  
> -- 
> 2.39.5
> 

-- 
Kees Cook

