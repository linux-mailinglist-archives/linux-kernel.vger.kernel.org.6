Return-Path: <linux-kernel+bounces-543633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC4A4D7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26731886E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116571F8BAA;
	Tue,  4 Mar 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G9TAC2cP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVjRosd2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G9TAC2cP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WVjRosd2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90201F8BCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079882; cv=none; b=j4uSkt+mc7+qCGz1FrlA50a2k+py44J/LcepbF9QU5Q5owVHbNByCR6fQx81iG8BJx001BObvmI8lcFig01N6ekguZGKwVCrkdbY52Lb5XQLJb7CKEUcWFgjdCSbOVX/PA8Owhni26cw1N/pWnR9ffOVhwGbco/Si1oF5rdBeY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079882; c=relaxed/simple;
	bh=YrIsco6FllE7VgEZoNWhG2k2L7easPadYklqbBhe0uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1tags+M6LfJms5AsIATVQ9ikCBpg9gWhlfxYxNi+fW+QQ6YYdEveGDw5hxI2KBkidojhiQB6Es2s1rughl93ab1R+dYC0/s+I9sQrwaEN0yEQ2KHsqieHYBCbb/5Juj1wBT4gaSNREPCw8Fj+5qIZJPCefc9SPbOzvmKmnKP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G9TAC2cP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WVjRosd2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G9TAC2cP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WVjRosd2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBA8A2118F;
	Tue,  4 Mar 2025 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741079878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ+zMoNnPWznQOdy8eGcx7wdCBztUYeaRVbXyyuev0Q=;
	b=G9TAC2cPulrjS53UqxjY7EBbS3rMubidLTmA9LMQgLr87w/M9pKMOZs6onGjcbypHwOLD6
	DNlPlDBXze1z/h4JVp/k4CXHV+j17i1uIq6+BPsSHzRXZ6pzD3lzOMXvVwMNn86UqECJGV
	SD3gy/9kC8lAoKDSJqoJT2r1oSHPbF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741079878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ+zMoNnPWznQOdy8eGcx7wdCBztUYeaRVbXyyuev0Q=;
	b=WVjRosd2bIKgA5bpXiKhWM8h3dZ4evUHX/2hXVjnHKgJ5Peh2/FQLCkSitc6TRtf9ejFIw
	C3IBV/h+cATEpqBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741079878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ+zMoNnPWznQOdy8eGcx7wdCBztUYeaRVbXyyuev0Q=;
	b=G9TAC2cPulrjS53UqxjY7EBbS3rMubidLTmA9LMQgLr87w/M9pKMOZs6onGjcbypHwOLD6
	DNlPlDBXze1z/h4JVp/k4CXHV+j17i1uIq6+BPsSHzRXZ6pzD3lzOMXvVwMNn86UqECJGV
	SD3gy/9kC8lAoKDSJqoJT2r1oSHPbF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741079878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ+zMoNnPWznQOdy8eGcx7wdCBztUYeaRVbXyyuev0Q=;
	b=WVjRosd2bIKgA5bpXiKhWM8h3dZ4evUHX/2hXVjnHKgJ5Peh2/FQLCkSitc6TRtf9ejFIw
	C3IBV/h+cATEpqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E2C13967;
	Tue,  4 Mar 2025 09:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mmiCDkbFxmfWSgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 04 Mar 2025 09:17:58 +0000
Date: Tue, 4 Mar 2025 10:17:56 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: update nr_huge_pages and
 surplus_huge_pages together
Message-ID: <Z8bFRDMf_Y4aG7uD@localhost.localdomain>
References: <20250304083841.283159-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304083841.283159-1-liushixin2@huawei.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 04, 2025 at 04:38:41PM +0800, Liu Shixin wrote:
> In alloc_surplus_hugetlb_folio(), we increase nr_huge_pages and
> surplus_huge_pages separately. In the middle window, if we set
> nr_hugepages to smaller and satisfy count < persistent_huge_pages(h),
> the surplus_huge_pages will be increased by adjust_pool_surplus().
> 
> After adding delay in the middle window, we can reproduce the problem
> easily by following step:
> 
>  1. echo 3 > /proc/sys/vm/nr_overcommit_hugepages
>  2. mmap two hugepages. When nr_huge_pages=2 and surplus_huge_pages=1,
>     goto step 3.
>  3. echo 0 > /proc/sys/vm/nr_huge_pages
> 
> Finally, nr_huge_pages is less than surplus_huge_pages.
> 
> To fix the problem, call only_alloc_fresh_hugetlb_folio() instead and
> move down __prep_account_new_huge_page() into the hugetlb_lock.
> 
> Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/hugetlb.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9faa1034704ff..0b02ea1c39e63 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2253,11 +2253,19 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  		goto out_unlock;
>  	spin_unlock_irq(&hugetlb_lock);
>  
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
> +	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
>  	if (!folio)
>  		return NULL;
>  
> +	hugetlb_vmemmap_optimize_folio(h, folio);
> +
>  	spin_lock_irq(&hugetlb_lock);
> +	/*
> +	 * Update nr_huge_pages and surplus_huge_pages together,
> +	 * otherwise it might confuse persistent_huge_pages() momentarily.
> +	 */
> +	__prep_account_new_huge_page(h, nid);

It would be great if we could pair up this one with the actual increase
of surplus pages, but then free_huge_folio() will decrease the
nr_huge_pages if the pool changed.

Also, that comment makes me think that__prep_account_new_huge_page()
will adjust both counters, so maybe just go with something like

"nr_huge_pages needs to be adjusted within the same lock cycle
as surplus_pages, otherwise..."


-- 
Oscar Salvador
SUSE Labs

