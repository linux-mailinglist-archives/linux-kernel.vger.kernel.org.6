Return-Path: <linux-kernel+bounces-328621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF80978683
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C2C28728E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A3839E4;
	Fri, 13 Sep 2024 17:13:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679C82D66
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247619; cv=none; b=NULm4C9RU1OOZmvs8lUpe5i56X8tsDCpSSU03VNoIdcXILkyoUn40mCikjIx8IGEqIHC3zRAAHqsg8BiAruHoWTMk5dOcugufIpXj/RmTPFXi6Fj9lHzZLAys4agIxuZ3QbNtcGdu3JQgG04NU5870Dp+V8hJZh7/QNkY5EojlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247619; c=relaxed/simple;
	bh=bdhM4R5fE2+VdHpuqyjiN5QKqRZXydJ9f7R1QLxMP/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJo6aX3vX4x67vpMqkc0ohUsuq+fsBsHKldduZgnfN7L9NdykoJNBJ9BJxaCLUT3sXw4mijc/Vp4iOu/1TFnfRe0XYR5NLnJGoD8KBqNx4DAUYgR0n/jSBCdsLH8MM1rczUQfulQzawxhlHhs3c5WD02ADYj7MXibvRppPSNtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA9C4CEC0;
	Fri, 13 Sep 2024 17:13:37 +0000 (UTC)
Date: Fri, 13 Sep 2024 18:13:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, muchun.song@linux.dev, david@redhat.com,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] hugetlb: arm64: add mte support
Message-ID: <ZuRyv8Q4iRDabq1-@arm.com>
References: <20240912204129.1432995-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912204129.1432995-1-yang@os.amperecomputing.com>

On Thu, Sep 12, 2024 at 01:41:28PM -0700, Yang Shi wrote:
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index a7bb20055ce0..c8687ccc2633 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -18,17 +18,41 @@ void copy_highpage(struct page *to, struct page *from)
>  {
>  	void *kto = page_address(to);
>  	void *kfrom = page_address(from);
> +	struct folio *src = page_folio(from);
> +	struct folio *dst = page_folio(to);
> +	unsigned int i, nr_pages;
>  
>  	copy_page(kto, kfrom);
>  
>  	if (kasan_hw_tags_enabled())
>  		page_kasan_tag_reset(to);
>  
> -	if (system_supports_mte() && page_mte_tagged(from)) {
> -		/* It's a new page, shouldn't have been tagged yet */
> -		WARN_ON_ONCE(!try_page_mte_tagging(to));
> -		mte_copy_page_tags(kto, kfrom);
> -		set_page_mte_tagged(to);
> +	if (system_supports_mte()) {
> +		if (folio_test_hugetlb(src) &&
> +		    folio_test_hugetlb_mte_tagged(src)) {
> +			if (!try_folio_hugetlb_mte_tagging(dst))
> +				return;
> +
> +			/*
> +			 * Populate tags for all subpages.
> +			 *
> +			 * Don't assume the first page is head page since
> +			 * huge page copy may start from any subpage.
> +			 */
> +			nr_pages = folio_nr_pages(src);
> +			for (i = 0; i < nr_pages; i++) {
> +				kfrom = page_address(folio_page(src, i));
> +				kto = page_address(folio_page(dst, i));
> +				mte_copy_page_tags(kto, kfrom);
> +			}
> +			folio_set_hugetlb_mte_tagged(dst);
> +		} else if (page_mte_tagged(from)) {
> +			/* It's a new page, shouldn't have been tagged yet */
> +			WARN_ON_ONCE(!try_page_mte_tagging(to));
> +
> +			mte_copy_page_tags(kto, kfrom);
> +			set_page_mte_tagged(to);
> +		}
>  	}
>  }

A nitpick here: I don't like that much indentation, so just do an early
return if !system_supports_mte() in this function.

Otherwise the patch looks fine to me. I agree with David's point on an
earlier version of this patch, the naming of these functions isn't
great. So, as per David's suggestion (at least for the first two):

folio_test_hugetlb_mte_tagged()
folio_set_hugetlb_mte_tagged()
folio_try_hugetlb_mte_tagging()

As for "try" vs "test_and_set_.*_lock", the original name was picked to
mimic spin_trylock() since this function is waiting/spinning. It's not
great but the alternative naming is closer to test_and_set_bit_lock().
This has different behaviour, it only sets a bit with acquire semantics,
no waiting/spinning.

-- 
Catalin

