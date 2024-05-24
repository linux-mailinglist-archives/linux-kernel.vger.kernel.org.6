Return-Path: <linux-kernel+bounces-188498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CDC8CE2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8686D1C211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05F127E3C;
	Fri, 24 May 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCWHgvdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD611D54D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541232; cv=none; b=OtumWDVKT9nbne5icr9k6yxPLNyFqSCsnCusDdPO5dbP10ibYfHVAoOVk2F6UHiPwFjiBjbCrtza29a6LUjFTiGpgiNcP0QdKpzzJVjSpotr2zfaWW7Y68QVm7Ml99E4s5NoupSUbQHycihJeaNmToCHs1LW8iVS57ZgMHsQIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541232; c=relaxed/simple;
	bh=8Q+zLE+3ZGqzpxPIL0MDPn9+ya9ASYFZxQPUwCQYsuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9r1FbnFrd9n7XasUiONZVxVAJbwhRkUKAkpSnZ1kB+/pRlCszKPDDmYueKyHFTirPAW8TBFLYy7wvInYCy12GJsOmgzlMv4DEgo40Qttaup199t+eevkTMXsjilWv5mv38yEEUujza2801/N9LcaUUx/mar9QlCd19IEJEnqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCWHgvdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D1C32786;
	Fri, 24 May 2024 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716541230;
	bh=8Q+zLE+3ZGqzpxPIL0MDPn9+ya9ASYFZxQPUwCQYsuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCWHgvdc6YG5HjI3oW+GtrM7KsHZ1JZSco7P5xT0291wv934HLrNOnuOU10OjkhUh
	 cetPaPo4DRZCMdIU4ZvXa1zqAqs2Gck87Ve6KU1FASOib1KQwdYIPonle3pqIeh9FF
	 raLyF2gTVHGw9N2tBKsxgq5d+EZsOcl2MVuMvj90hOrgzd9lmzReEMFSJqVedQlhC1
	 T0kF5gY0aOWs+e2tZ35e2ptQZtVIHOVxOEH1hOQA5lc703e1L+NYd+I3Awe7gtAC/F
	 Uh+0CgouUViYhGuxIIAi9YgkFGMyeeBE8jrp4Xm1behpZsS3uXDpMr7OD34lzcLb8r
	 k37hJgolXUiWA==
Date: Fri, 24 May 2024 11:58:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH RFC 1/6] mm: update _mapcount and page_type documentation
Message-ID: <ZlBWv3nrN_U_5QJQ@kernel.org>
References: <20240522210341.1030552-1-david@redhat.com>
 <20240522210341.1030552-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522210341.1030552-2-david@redhat.com>

On Wed, May 22, 2024 at 11:03:36PM +0200, David Hildenbrand wrote:
> Let's make it clearer that _mapcount must no longer be used for own
> purposes, and how _mapcount and page_type behaves nowadays (also in the
> context of hugetlb folios, which are typed folios that will be mapped
> to user space).
> 
> Move the documentation regarding "-1" over from page_mapcount_reset(),
> which we will remove next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h       |  5 -----
>  include/linux/mm_types.h | 24 +++++++++++++++---------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..018e7c0265ca 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1206,11 +1206,6 @@ static inline int folio_entire_mapcount(const struct folio *folio)
>  	return atomic_read(&folio->_entire_mapcount) + 1;
>  }
>  
> -/*
> - * The atomic page->_mapcount, starts from -1: so that transitions
> - * both from it and to it can be tracked, using atomic_inc_and_test
> - * and atomic_add_negative(-1).
> - */
>  static inline void page_mapcount_reset(struct page *page)
>  {
>  	atomic_set(&(page)->_mapcount, -1);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 24323c7d0bd4..532a3030405d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -46,9 +46,7 @@ struct mem_cgroup;
>   * which is guaranteed to be aligned.  If you use the same storage as
>   * page->mapping, you must restore it to NULL before freeing the page.
>   *
> - * If your page will not be mapped to userspace, you can also use the four
> - * bytes in the mapcount union, but you must call page_mapcount_reset()
> - * before freeing it.
> + * The mapcount field must not be used for own purposes.
>   *
>   * If you want to use the refcount field, it must be used in such a way
>   * that other CPUs temporarily incrementing and then decrementing the
> @@ -152,16 +150,24 @@ struct page {
>  
>  	union {		/* This union is 4 bytes in size. */
>  		/*
> -		 * If the page can be mapped to userspace, encodes the number
> -		 * of times this page is referenced by a page table.
> +		 * For pages part of non-typed folios for which mappings are

Maybe

For pages that are part ...

> +		 * tracked via the RMAP, encodes the number of times this page
> +		 * is directly referenced by a page table.
> +		 *
> +		 * Note that the mapcount is always initialized to -1, so that
> +		 * transitions both from it and to it can be tracked, using
> +		 * atomic_inc_and_test() and atomic_add_negative(-1).
>  		 */
>  		atomic_t _mapcount;
>  
>  		/*
> -		 * If the page is neither PageSlab nor mappable to userspace,
> -		 * the value stored here may help determine what this page
> -		 * is used for.  See page-flags.h for a list of page types
> -		 * which are currently stored here.
> +		 * For head pages of typed folios, the value stored here
> +		 * allows for determining what this page is used for. The
> +		 * tail pages of typed folios will not store a type
> +		 * (mapcount == -1).
> +		 *
> +		 * See page-flags.h for a list of page types which are currently
> +		 * stored here.
>  		 */
>  		unsigned int page_type;

and maybe move page_type before _mapcount, so that it will be a bit clearer
what are "typed" pages and folios are.

>  	};
> -- 
> 2.45.0
> 

-- 
Sincerely yours,
Mike.

