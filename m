Return-Path: <linux-kernel+bounces-573068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E164BA6D2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639B116E19F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E42EEC5;
	Mon, 24 Mar 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/XBg6ZG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59181799F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742777557; cv=none; b=Nt6zf3sbuGGbzexebW2izAJ+SnegbcgX2wJZQYCC0xOGD2HXrHLR9drrRAP1qZgfHXpChvXObtvd2A9MdnkQw5gTJoydZLCr0sUkTN7yEXB/UOqDwi+rJmKIE/S2nakH6yzGvg4OYY1h17u0VEbZm2XpJC3BNILbxRmWdiK9oLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742777557; c=relaxed/simple;
	bh=4Nfkwq4jtQTclKMjEWQWqzsh3FD49Bu0//TRBfI1njY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drFk/pB7nZJ1SgxHYGezYIeeSzjdIuPjEucNS8PQjqglFufL3KQ9aZm26AS6Jg3w6+T5SI9x6GTk6uOVdrL0Df2r3lNiE6iyInz+/YZUilOovu4AAjdUbxcCKKBfqhRoAbTvbznI+3oOXRNAW9A23wmrQVZPbWeSNRklSSfQfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/XBg6ZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742777553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRW32NXP4xvdf4PqCm7224jsnVvYQgn/PFL+RPL5lbI=;
	b=B/XBg6ZG/tniwvk87R2hUJqQXYNBAp+3hxg9x5lsU4hiZij/fuUAxOw8IELyAMlDktIwfT
	JnlUOStDAIXFvHzjlxOfl7f2x3OSKDClGdp1ck8SPnJ3Efk86+/wc7OR4jPw4qRZqKkRzr
	aerSOO1PW6MaH6IesRPrcggttAzfeSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-pTxoLLXmPduOvObK4m1NMg-1; Sun,
 23 Mar 2025 20:52:30 -0400
X-MC-Unique: pTxoLLXmPduOvObK4m1NMg-1
X-Mimecast-MFC-AGG-ID: pTxoLLXmPduOvObK4m1NMg_1742777549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77A78180049D;
	Mon, 24 Mar 2025 00:52:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E8E4180A801;
	Mon, 24 Mar 2025 00:52:26 +0000 (UTC)
Date: Mon, 24 Mar 2025 08:52:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com,
	tim.c.chen@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] mm: swap: free each cluster individually in
 swap_entries_put_map_nr()
Message-ID: <Z+CswNiG/QVPcYB1@MiWiFi-R3L-srv>
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
 <20250320114829.25751-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320114829.25751-7-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/20/25 at 07:48pm, Kemeng Shi wrote:
> 1. Factor out general swap_entries_put_map() helper to drop entries belong
                                                                      ~~~~~
   s/belong/belonging/

> to one cluster. If entries are last map, free entries in batch, otherwise
> put entries with cluster lock acquired and released only once.
> 2. Iterate and call swap_entries_put_map() for each cluster in
> swap_entries_put_nr() to leverage batch-remove for last map belong to one
                                                              ~~~~~
    ditto

> cluster and reduce lock acquire/release in fallback case.
> 3. As swap_entries_put_nr() won't handle SWAP_HSA_CACHE drop, rename it to
> swap_entries_put_map_nr().
> 4. As we won't drop each entry invidually with swap_entry_put() now, do
> reclaim in free_swap_and_cache_nr() is because swap_entries_put_map_nr()
                                     ~~~ remove 'is' ?
> is general routine to drop reference and the relcaim work should only be
> done in free_swap_and_cache_nr(). Remove stale comment accordingly.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/swapfile.c | 70 +++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 38 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6f11619665e8..646efccdd2ec 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1455,25 +1455,10 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static unsigned char swap_entry_put(struct swap_info_struct *si,
> -				    swp_entry_t entry)
> -{
> -	struct swap_cluster_info *ci;
> -	unsigned long offset = swp_offset(entry);
> -	unsigned char usage;
> -
> -	ci = lock_cluster(si, offset);
> -	usage = swap_entry_put_locked(si, ci, entry, 1);
> -	unlock_cluster(ci);
> -
> -	return usage;
> -}
> -
> -static bool swap_entries_put_nr(struct swap_info_struct *si,
> -				swp_entry_t entry, int nr)
> +static bool swap_entries_put_map(struct swap_info_struct *si,
> +				 swp_entry_t entry, int nr)
>  {
>  	unsigned long offset = swp_offset(entry);
> -	unsigned int type = swp_type(entry);
>  	struct swap_cluster_info *ci;
>  	bool has_cache = false;
>  	unsigned char count;
> @@ -1484,14 +1469,10 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
>  	count = swap_count(data_race(si->swap_map[offset]));
>  	if (count != 1 && count != SWAP_MAP_SHMEM)
>  		goto fallback;
> -	/* cross into another cluster */
> -	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> -		goto fallback;
>  
>  	ci = lock_cluster(si, offset);
>  	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
> -		unlock_cluster(ci);
> -		goto fallback;
> +		goto locked_fallback;
>  	}
>  	if (!has_cache)
>  		swap_entries_free(si, ci, entry, nr);
> @@ -1503,15 +1484,34 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
>  	return has_cache;
>  
>  fallback:
> -	for (i = 0; i < nr; i++) {
> -		if (data_race(si->swap_map[offset + i])) {
> -			count = swap_entry_put(si, swp_entry(type, offset + i));
> -			if (count == SWAP_HAS_CACHE)
> -				has_cache = true;
> -		} else {
> -			WARN_ON_ONCE(1);
> -		}
> +	ci = lock_cluster(si, offset);
> +locked_fallback:
> +	for (i = 0; i < nr; i++, entry.val++) {
> +		count = swap_entry_put_locked(si, ci, entry, 1);
> +		if (count == SWAP_HAS_CACHE)
> +			has_cache = true;
> +	}
> +	unlock_cluster(ci);
> +	return has_cache;
> +
> +}
> +
> +static bool swap_entries_put_map_nr(struct swap_info_struct *si,
> +				    swp_entry_t entry, int nr)
> +{
> +	int cluster_nr, cluster_rest;
> +	unsigned long offset = swp_offset(entry);
> +	bool has_cache = false;
> +
> +	cluster_rest = SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER;
> +	while (nr) {
> +		cluster_nr = min(nr, cluster_rest);
> +		has_cache |= swap_entries_put_map(si, entry, cluster_nr);
> +		cluster_rest = SWAPFILE_CLUSTER;
> +		nr -= cluster_nr;
> +		entry.val += cluster_nr;
>  	}
> +
>  	return has_cache;
>  }
>  
> @@ -1806,7 +1806,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>  	/*
>  	 * First free all entries in the range.
>  	 */
> -	any_only_cache = swap_entries_put_nr(si, entry, nr);
> +	any_only_cache = swap_entries_put_map_nr(si, entry, nr);
>  
>  	/*
>  	 * Short-circuit the below loop if none of the entries had their
> @@ -1816,13 +1816,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>  		goto out;
>  
>  	/*
> -	 * Now go back over the range trying to reclaim the swap cache. This is
> -	 * more efficient for large folios because we will only try to reclaim
> -	 * the swap once per folio in the common case. If we do
> -	 * swap_entry_put() and __try_to_reclaim_swap() in the same loop, the
> -	 * latter will get a reference and lock the folio for every individual
> -	 * page but will only succeed once the swap slot for every subpage is
> -	 * zero.
> +	 * Now go back over the range trying to reclaim the swap cache.
>  	 */
>  	for (offset = start_offset; offset < end_offset; offset += nr) {
>  		nr = 1;
> -- 
> 2.30.0
> 
> 


