Return-Path: <linux-kernel+bounces-530585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E014A43555
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F8B17BE52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56922561B1;
	Tue, 25 Feb 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz7sn1VL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F498AD51
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465174; cv=none; b=lRNIn3F+TMq/yJ9mbl0/cG13Uqb5WXitdtJ6aZMdqAjNyywuNRNM6vsRDctSE9yHgVSM06LDk5jn57QBACtfu9e8zRtncVNRW9DARRDr0dOJVLhwoiTGpnqN++aIux1E/2MBurOFe2povO4eR9A00eB8bHjzKvjnxtjhfO+xdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465174; c=relaxed/simple;
	bh=ZmFkko51tUdOwMWfv5DTYwJfN7Ad/CP8h2kypZyODsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMmOgWos0QNkIIlGr7lmxVUR9qIzKKHv/ZlVCUuPuPLG4JJdaOkbGtqcIIiEUgzzS+kWcv93UxAm8ozwHkjSsaPQ4O5y8SLtCIeFRFQXSgfEvyD3fXEmLgIAKmIbi8bU6ElQu20Ytvvhb3vW+40LyUd4grlcJZBgywi++HyFuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz7sn1VL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740465171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAHGRiVe6gULuxxP81ZlSf4CThjS+6BqPeeqGS0Icyk=;
	b=gz7sn1VL01j7cQTgd9e3HniaGx7jibzwhTLIdVzt2InkEodPymHhtiDhpdkxwSIQo0qhr6
	pCCJCuWzdROj9GGg57t60PE62hwBXDc5ASDH7h+j6u0OWLpxdyrQvKeAm/42mIuQmwuruu
	AeGuEIl8+2+3oyKT5CdI4W2MVPsj4Zs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496--Ue5qIGBMlW6w7bKR0nvlA-1; Tue,
 25 Feb 2025 01:32:49 -0500
X-MC-Unique: -Ue5qIGBMlW6w7bKR0nvlA-1
X-Mimecast-MFC-AGG-ID: -Ue5qIGBMlW6w7bKR0nvlA_1740465167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D82619560B5;
	Tue, 25 Feb 2025 06:32:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61F8D1800352;
	Tue, 25 Feb 2025 06:32:43 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:32:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] mm, swap: don't update the counter up-front
Message-ID: <Z71kB6iC50io8zwS@MiWiFi-R3L-srv>
References: <20250224180212.22802-1-ryncsn@gmail.com>
 <20250224180212.22802-5-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180212.22802-5-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/25/25 at 02:02am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The counter update before allocation design was useful to avoid
> unnecessary scan when device is full, so it will abort early if the
> counter indicates the device is full. But that is an uncommon case,
> and now scanning of a full device is very fast, so the up-front update
> is not helpful any more.
> 
> Remove it and simplify the slot allocation logic.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6f2de59c6355..db836670c334 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1201,22 +1201,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  	int order = swap_entry_order(entry_order);
>  	unsigned long size = 1 << order;
>  	struct swap_info_struct *si, *next;
> -	long avail_pgs;
>  	int n_ret = 0;
>  	int node;
>  
>  	spin_lock(&swap_avail_lock);
> -
> -	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
> -	if (avail_pgs <= 0) {
> -		spin_unlock(&swap_avail_lock);
> -		goto noswap;
> -	}
> -
> -	n_goal = min3((long)n_goal, (long)SWAP_BATCH, avail_pgs);
> -
> -	atomic_long_sub(n_goal * size, &nr_swap_pages);
> -
>  start_over:
>  	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> @@ -1250,10 +1238,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  	spin_unlock(&swap_avail_lock);
>  
>  check_out:
> -	if (n_ret < n_goal)
> -		atomic_long_add((long)(n_goal - n_ret) * size,
> -				&nr_swap_pages);
> -noswap:
> +	atomic_long_sub(n_ret * size, &nr_swap_pages);
> +
>  	return n_ret;
>  }
>  
> -- 
> 2.48.1
> 


