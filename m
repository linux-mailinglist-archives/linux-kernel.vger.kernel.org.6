Return-Path: <linux-kernel+bounces-573071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D93A6D2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101A11894686
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EE171C9;
	Mon, 24 Mar 2025 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqS9zwmF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2E2E3381
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742778498; cv=none; b=C+laB4lc0BoCcMzlnLVjErHMwTV6BwI7y7x5pu6joEMZtd6/xKITVkP5wb7URV5Kgxi+kJ/K5RuqXlig5jnyCEOyYDdPZBDwnkUbzU3qIwbyVY/4B0q8q7ehKJ4/Fv8ye4NrLq9wcLQFe9MXFweJ9kK2Iqpi49fRCVBFGV28fpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742778498; c=relaxed/simple;
	bh=f/R/yUiTOBUoCj9WY7YVryxcoDDHuwcFhanvZzyi6G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDCeNTxi6hAqtLfmWdW9WpWqVmf5QuNeXU73ppygiCC4ywmjb1ybbMYS32kcmntbnorELjkF335lyHpGDV9NZEHGB+6J9LxTE5FBZJzuRF+GEJM9UVIVSf1MtM33MSGtiwsKNJyI5vM6jivJ6xOYRhPqvV4GCqq0xkFjCDcy3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqS9zwmF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742778495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0ry4lY4x2+hqK6ZCLNUPERIg6iDxjpwe3Lrc8jTe4U=;
	b=fqS9zwmFgInniI1W4zmQ1v5JzMBsQme2Q9P9/m+S5FF+yKdPDUJuSrQvgqWDM7sOG+WNzq
	xKiqMnv5mMMgOLRJZkouSdKa+93B+Mr5mdwm5UXR70+jRmN1EWcJ9aqCsUfbV5NSDT6Jkk
	/KA4Nb2ANIX5mJvKXrhAI2QI3DN4EQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-UvbDM-vLPTSlfUuZVyFCjA-1; Sun,
 23 Mar 2025 21:08:12 -0400
X-MC-Unique: UvbDM-vLPTSlfUuZVyFCjA-1
X-Mimecast-MFC-AGG-ID: UvbDM-vLPTSlfUuZVyFCjA_1742778490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 595A61800257;
	Mon, 24 Mar 2025 01:08:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 539FF180A801;
	Mon, 24 Mar 2025 01:07:56 +0000 (UTC)
Date: Mon, 24 Mar 2025 09:07:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com,
	tim.c.chen@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] mm: swap: factor out helper to drop cache of
 entries within a single cluster
Message-ID: <Z+CwPsZyVqYH1Ijb@MiWiFi-R3L-srv>
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
 <20250320114829.25751-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320114829.25751-8-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/20/25 at 07:48pm, Kemeng Shi wrote:
> Factor out helper swap_entries_put_cache() from put_swap_folio() to server
                                                                      ~~~~~
                                                              s/server/serve/?
> as a general-purpose routine for dropping cache flag of entries within a
> single cluster.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/swapfile.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 646efccdd2ec..40a7d75c01e8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1455,6 +1455,22 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	return NULL;
>  }
>  
> +static void swap_entries_put_cache(struct swap_info_struct *si,
> +				   swp_entry_t entry, int nr)
> +{
> +	unsigned long offset = swp_offset(entry);
> +	struct swap_cluster_info *ci;
> +
> +	ci = lock_cluster(si, offset);
> +	if (swap_only_has_cache(si, offset, nr))
> +		swap_entries_free(si, ci, entry, nr);
> +	else {
> +		for (int i = 0; i < nr; i++, entry.val++)
> +			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
> +	}
> +	unlock_cluster(ci);
> +}
> +
>  static bool swap_entries_put_map(struct swap_info_struct *si,
>  				 swp_entry_t entry, int nr)
>  {
> @@ -1595,8 +1611,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
>   */
>  void put_swap_folio(struct folio *folio, swp_entry_t entry)
>  {
> -	unsigned long offset = swp_offset(entry);
> -	struct swap_cluster_info *ci;
>  	struct swap_info_struct *si;
>  	int size = 1 << swap_entry_order(folio_order(folio));
>  
> @@ -1604,14 +1618,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>  	if (!si)
>  		return;
>  
> -	ci = lock_cluster(si, offset);
> -	if (swap_only_has_cache(si, offset, size))
> -		swap_entries_free(si, ci, entry, size);
> -	else {
> -		for (int i = 0; i < size; i++, entry.val++)
> -			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
> -	}
> -	unlock_cluster(ci);
> +	swap_entries_put_cache(si, entry, size);
>  }
>  
>  int __swap_count(swp_entry_t entry)
> -- 
> 2.30.0
> 
> 


