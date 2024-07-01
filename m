Return-Path: <linux-kernel+bounces-235860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60C91DA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA51C21994
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B114B95A;
	Mon,  1 Jul 2024 08:48:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BC14BF90
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823723; cv=none; b=acg5GS7FSVtF0q1YTq/XCW2sazljiVN3iMAqwN+osB8i9AgZdykqUYJd7w/2ouSTddYdW0jhioFKRijxyMAipGGP/tCFlLwzo3EJx9M90eyku4ASsBDm7HIhtb5VOHZnqoG5CUwlOo1h31W71mPJ308U5XMpc8851udWrF9iNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823723; c=relaxed/simple;
	bh=CdPTH1L8XM9BliRaR+K4i2VVXwKTLMr/P6n8pgwx1h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4Y5O2jh4QFkO9pF6vIq/8XPhe3My6kpJKVSTsBZinH/gLXtZBtqiWl/Q2Usdk6WbIolnhBMayrf1hCKsUyg+vvhhXntxWcUr/I5AKVkMuzqseKHUyHYhzsmOQP94O3rtOW0w/qRawPTq8ISRmfHJPfUz+r77pP9cyl7YHHSfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77313339;
	Mon,  1 Jul 2024 01:49:04 -0700 (PDT)
Received: from [10.57.72.41] (unknown [10.57.72.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A4B3F766;
	Mon,  1 Jul 2024 01:48:38 -0700 (PDT)
Message-ID: <bfdf6970-48cc-477a-b726-5e0da242da93@arm.com>
Date: Mon, 1 Jul 2024 09:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: drop checking if _deferred_list is empty
 before using TTU_SYNC
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 David Hildenbrand <david@redhat.com>
References: <20240629234155.53524-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240629234155.53524-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2024 00:41, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The optimization of list_empty(&folio->_deferred_list) aimed to prevent
> increasing the PTL duration when a large folio is partially unmapped,
> for example, from subpage 0 to subpage (nr - 2).
> 
> But Ryan's commit 5ed890ce5147 ("mm: vmscan: avoid split during
> shrink_folio_list()") actually splits this kind of large folios. This
> makes the "optimization" useless.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  -v1
>  * I remember David and Ryan once suggested that this check could be dropped
>    while the patch was being pulled into mm-unstable. However, for some reason,
>    I forgot to request squashing this change.
> 
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3d4c681c6d40..0761f91b407f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1291,7 +1291,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			 * try_to_unmap acquire PTL from the first PTE,
>  			 * eliminating the influence of temporary PTE values.
>  			 */
> -			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
> +			if (folio_test_large(folio))

As it stands, the list_empty() technically needs a data_race() annotation. I
think your original patch went into v6.10-rc1? If so, perhaps it makes sense to
try to get this into the next rc?

>  				flags |= TTU_SYNC;
>  
>  			try_to_unmap(folio, flags);


