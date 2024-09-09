Return-Path: <linux-kernel+bounces-320924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE4297121D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6BA1C21D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15BA1B5EDC;
	Mon,  9 Sep 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPgQkTXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D671B5ED9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870503; cv=none; b=YUtaBZyNr0RolL6ukxzrSw1BDZHbaQ7Y2yBi8uSaw0fEx4INsW3VEMnLw0jqhK1uLx4gaUgmuxEWbO8NU/bzd4K9xIHL/ABc3gz722Q0Yrqodut8qhWNcBvj5BoJNmi0mb7/ndwGzDA6EFABRFg+ssk9fznzT0oHlg2yMgTNniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870503; c=relaxed/simple;
	bh=khXHjXx8hRmTU/IZvQEdj6n2m1e+nZBZNshqBcuC64M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYQ2aDTbOYj4I9j3779aMmFr3489DmuuU/SSliKIUrY44lRdO9zUZpVQBm4OTw3DUBahsCbVdKkcy2KlQkQZpLndUiM3lppNl2pzaHPGtITL48RMJ3vfoaNokl0o91OLCuxjvJbr7/etG3/5V8UkOCQFeF9cNLZPtid04LVKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPgQkTXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA3CC4CEC8;
	Mon,  9 Sep 2024 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725870502;
	bh=khXHjXx8hRmTU/IZvQEdj6n2m1e+nZBZNshqBcuC64M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPgQkTXwfphMGS+/ZFhlh4yIOdnDC2/lvd22xOGZvcWRQxKOovtkHeEsXmgUG9Oxu
	 AU6NL+VAawKzRdIKy/FRbjN6v1EPfdKtyhunnwXmu2iK53p9An4fFhL42Tpc8Z5PFC
	 0G0SUiNQogt87AvHengOpQsaRXBXK4q0v0fYLH/0tCj3xADNNPMZ2zX0YaTZF2HRoa
	 6sawlMOWW4CIiPVrdpyfejUUjdOuAni3tWb3/khACbyQrfM4IgintD/K5F+7CgmoBc
	 Eyw81FcmGTiGsb8H5BGRCi46Lpe557JzTIdVQy3pd0vWy40Fm0Du22pkUZrEs3/cu4
	 X4Nu2Z4Tcb2ZQ==
Date: Mon, 9 Sep 2024 11:25:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/page: Drop has_unaccepted_memory() helper
Message-ID: <Zt6w-QADv8kta8UE@kernel.org>
References: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>

On Mon, Sep 09, 2024 at 11:19:30AM +0300, Kirill A. Shutemov wrote:
> has_unaccepted_memory() has the only caller -- cond_accept_memory().
> 
> Remove the helper and check zones_with_unaccepted_pages directly in
> cond_accept_memory().
> 
> It also fixes warning with clang 18 when kernel is compiled without
> unaccepted memory support:
> 
>  mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409061101.Jlx5z2fI-lkp@intel.com/

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/page_alloc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91ace8ca97e2..7fc5af7cb387 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -288,7 +288,6 @@ EXPORT_SYMBOL(nr_online_nodes);
>  static bool page_contains_unaccepted(struct page *page, unsigned int order);
>  static void accept_page(struct page *page, unsigned int order);
>  static bool cond_accept_memory(struct zone *zone, unsigned int order);
> -static inline bool has_unaccepted_memory(void);
>  static bool __free_unaccepted(struct page *page);
>  
>  int page_group_by_mobility_disabled __read_mostly;
> @@ -6975,7 +6974,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  	long to_accept;
>  	bool ret = false;
>  
> -	if (!has_unaccepted_memory())
> +	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
>  		return false;
>  
>  	if (list_empty(&zone->unaccepted_pages))
> @@ -6997,11 +6996,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  	return ret;
>  }
>  
> -static inline bool has_unaccepted_memory(void)
> -{
> -	return static_branch_unlikely(&zones_with_unaccepted_pages);
> -}
> -
>  static bool __free_unaccepted(struct page *page)
>  {
>  	struct zone *zone = page_zone(page);
> @@ -7040,11 +7034,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  	return false;
>  }
>  
> -static inline bool has_unaccepted_memory(void)
> -{
> -	return false;
> -}
> -
>  static bool __free_unaccepted(struct page *page)
>  {
>  	BUILD_BUG();
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

