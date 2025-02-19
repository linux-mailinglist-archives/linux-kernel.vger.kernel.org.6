Return-Path: <linux-kernel+bounces-520827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8588A3AFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A44167DED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4329190072;
	Wed, 19 Feb 2025 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCot4Il8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471C176ADE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932963; cv=none; b=R6f1+OzKfN8EwV13UX6o4TMyib+Kbad3DuDDlJ6SydCta/HzG/uJkZQjbZWQknwpXJ4BdmgUZXwTwihG6DZzWvd7RAq0XXSJV3KyAu8esoYu6ccfBbkK3OH+oI4GlbZyoQcCRr6gNA1HOe9OuRXYH5FRcCiAGsnSqyl6GXjGwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932963; c=relaxed/simple;
	bh=xtegO1u8MpSEB7CYOZ4gSimg+CKF0fnM/GtVnjRCL8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmPz1EYut3dnuenBA0NbGVjCmmcxYdUPPEWwwAv0ZR5/eADUb5dOYIvCyr/2k3FVNFor1jab5gEDx9DQcSD42SMBqH9BIJqGFrqjvV6IbIbWY6J4A1aPEKPctijnVGASLOO0gXe2uEnO0ZtLB7A01AJlkj0Nx8Ki6hR82CF65WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCot4Il8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739932959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxGow9T5Rm1Zah6lyvVvsZOcPv8HupyfwhnCQmanDiw=;
	b=LCot4Il8YSnnT0vwy3TuyHh/ge+cwWwB6uwIbxLq567lITE+dD7uLr1ONs8SGy1v0dtQrM
	zJQdDvrS2ZZ4+Do5GqRM2PFrVFtpy85wH7xt8JoO4jwln59rBtByayQsHE9n6dSftjViZM
	nNe7iFf9bVOoDI5MmA2Upneu7aL+vCc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-TYU6cTYCOL6RDQidgVqd2A-1; Tue,
 18 Feb 2025 21:42:33 -0500
X-MC-Unique: TYU6cTYCOL6RDQidgVqd2A-1
X-Mimecast-MFC-AGG-ID: TYU6cTYCOL6RDQidgVqd2A_1739932951
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 486C9180098B;
	Wed, 19 Feb 2025 02:42:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847B21800940;
	Wed, 19 Feb 2025 02:42:28 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:42:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm, swap: drop the flag TTRS_DIRECT
Message-ID: <Z7VFELM19eiDUzOJ@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-3-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/15/25 at 01:57am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This flag exists temporarily to allow the allocator to bypass the slot
> cache during freeing, so reclaiming one slot will free the slot
> immediately.
> 
> But now we have already removed slot cache usage on freeing, so this
> flag has no effect now.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c77ffee4af86..449e388a6fec 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c

Reviewed-by: Baoquan He <bhe@redhaat.com>

> @@ -158,8 +158,6 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
>  #define TTRS_UNMAPPED		0x2
>  /* Reclaim the swap entry if swap is getting full */
>  #define TTRS_FULL		0x4
> -/* Reclaim directly, bypass the slot cache and don't touch device lock */
> -#define TTRS_DIRECT		0x8
>  
>  static bool swap_only_has_cache(struct swap_info_struct *si,
>  			      unsigned long offset, int nr_pages)
> @@ -257,23 +255,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	if (!need_reclaim)
>  		goto out_unlock;
>  
> -	if (!(flags & TTRS_DIRECT)) {
> -		/* Free through slot cache */
> -		delete_from_swap_cache(folio);
> -		folio_set_dirty(folio);
> -		ret = nr_pages;
> -		goto out_unlock;
> -	}
> -
> -	xa_lock_irq(&address_space->i_pages);
> -	__delete_from_swap_cache(folio, entry, NULL);
> -	xa_unlock_irq(&address_space->i_pages);
> -	folio_ref_sub(folio, nr_pages);
> +	delete_from_swap_cache(folio);
>  	folio_set_dirty(folio);
> -
> -	ci = lock_cluster(si, offset);
> -	swap_entry_range_free(si, ci, entry, nr_pages);
> -	unlock_cluster(ci);
>  	ret = nr_pages;
>  out_unlock:
>  	folio_unlock(folio);
> @@ -707,7 +690,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
>  			offset++;
>  			break;
>  		case SWAP_HAS_CACHE:
> -			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
> +			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
>  			if (nr_reclaim > 0)
>  				offset += nr_reclaim;
>  			else
> @@ -860,7 +843,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
>  			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
>  				spin_unlock(&ci->lock);
>  				nr_reclaim = __try_to_reclaim_swap(si, offset,
> -								   TTRS_ANYWAY | TTRS_DIRECT);
> +								   TTRS_ANYWAY);
>  				spin_lock(&ci->lock);
>  				if (nr_reclaim) {
>  					offset += abs(nr_reclaim);
> -- 
> 2.48.1
> 


