Return-Path: <linux-kernel+bounces-547718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4BA50C95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5880188388A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E92045A8;
	Wed,  5 Mar 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SyboO6iu"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736917B50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206789; cv=none; b=I/7LDER/zDvBCSQ+PaKEHW52BvKj3J/Vpcw2z5Nu/EvmAh6JaP3EWFtFOLuDpyaRNEo39eiXYwF/VQZ+EL8/3bTf+/8n6VMgS9hMGoocQl2L4g4ENx+W1XFmDTiW8Hrn4lngFcf7zOfps3O5oKfJ6YcOr/fiDMnrw46z4K5hb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206789; c=relaxed/simple;
	bh=8rSiXhWy6zq6zyHtUk/mVzvcEvHUJdwLGZ3WCE2SW/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTjSrel6/1VNWYaHFAlh+dj24iwgm5K75CI/B3png/6lsjEGsA1Vn81n468S26tHbxKBmgR2vIi2bN9PEPEeSk4bYAoB7nNVdBrtBSdva6nG8TcjIhV5n/+zrRSYVoXZIdDwiQwAUBpHvMfzbixQVKZltYG9YG2OljuZH/wdSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SyboO6iu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 12:32:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2TU4SraGYQgOb4W04xqs17RGU2mlizF+kj6Iy1M9wM=;
	b=SyboO6iudiY0EqVHWiluZ74ViPJLPszqqPnxYZ7GLgmsCAVR7jymRQdsCDozstNxY+Cgzq
	AQJaIf5ND3aQh1zZVRwaHq0q6ta+oUM9iXUBpoTq+uhPmiSja9UZ9Nz2wvC9mD25CPwuX9
	QugJLrlwTJvlz44pZduZNttsfo1uDXM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/16] mm/madvise: split out populate behavior check
 logic
Message-ID: <kic3iznofvqvkljvelk6c7l2jigdwtlrrlhebkrh4tnundfp6h@upfyjh5hr6k5>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-3-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:15:57AM -0800, SeongJae Park wrote:
> madvise_do_behavior() has a long open-coded 'behavior' check for
> MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
> code arguably take longer time to read.  Like is_memory_failure(), split
> out the check to a separate function.  This is not technically removing
> the additional layer but discourage further extending the switch-case.
> Also it makes madvise_do_behavior() code shorter and therefore easier to
> read.
> 
> [1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/madvise.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dbc8fec05cc6..4a91590656dc 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1633,6 +1633,17 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
>  	return true;
>  }
>  
> +static bool is_memory_populate(int behavior)

No strong opinion on this patch but if you want to keep it, the above
name feels weird. How about either is_madvise_populate() or
is_populate_memory()?

> +{
> +	switch (behavior) {
> +	case MADV_POPULATE_READ:
> +	case MADV_POPULATE_WRITE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int madvise_do_behavior(struct mm_struct *mm,
>  		unsigned long start, size_t len_in, size_t len, int behavior)
>  {
> @@ -1646,16 +1657,11 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	end = start + len;
>  
>  	blk_start_plug(&plug);
> -	switch (behavior) {
> -	case MADV_POPULATE_READ:
> -	case MADV_POPULATE_WRITE:
> +	if (is_memory_populate(behavior))
>  		error = madvise_populate(mm, start, end, behavior);
> -		break;
> -	default:
> +	else
>  		error = madvise_walk_vmas(mm, start, end, behavior,
>  					  madvise_vma_behavior);
> -		break;
> -	}
>  	blk_finish_plug(&plug);
>  	return error;
>  }
> -- 
> 2.39.5

