Return-Path: <linux-kernel+bounces-397917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CAC9BE259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B37287C86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630731D966A;
	Wed,  6 Nov 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y73pyFYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8lku3hhO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y73pyFYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8lku3hhO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEC1D9598
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885020; cv=none; b=dSzJHZFKP50Y0AgKPAdkOepnRXw9FX236yyS3MYPQDR70+BFLM1c13cQBV55HDBxBiqsYeiYzc4sSeSu0EXrDlI9U4UWgTOnxD3XriGW2y23BH0MNEuGQgstCl5bLCfJYz5okardpw4R7Djag9qXGbImvCMHJtpiskMccbLevEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885020; c=relaxed/simple;
	bh=cHPQZLEjtouYjHO4dCl0FTa3LDj5Nz5AQLY8nuFBRB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew40qIoe0Uz4NLxPr+XOcGFxml/fLjrdfFjiB8OCJjjE2hOT2X7pRR8Ir4F233Sw9+yp49PnSTieywDHGxbcjRlaKohube+W26dtJl3H0JtDJWu0AdmXrS6SXA9Msh5uAvDDwfEpQK7j9Ldg3Tw4NzQGOaMfhk8d50KuOWt22Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y73pyFYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8lku3hhO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y73pyFYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8lku3hhO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1A6B21C29;
	Wed,  6 Nov 2024 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730885017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1wxZBL7gdc64Tq3vyI4u8KFmJMP6vW9gBY9WDr8nPo=;
	b=y73pyFYl0zRPSMbgA90HjEOzYjrwrmTOJWb4Q8o8TtT4VQPy2oCUdTkDXEuh9qKNqSEgDb
	r6XgEXE9mzMtPyM6bpO05hU6KLTSrP0JzAxUILbfphr9SROJEwZfvf14MQvEg8SyMQFUmN
	bmF3IVaPQOyPIFgSkOuVGmw36Xpc6xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730885017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1wxZBL7gdc64Tq3vyI4u8KFmJMP6vW9gBY9WDr8nPo=;
	b=8lku3hhOHi/fLguBC2f11zMO7xeZ/gUp2v4/q+2Os3MY2wjeH76h0vBe9GI0RBBfZSKqM1
	ZW7IL3HKzCveoJAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y73pyFYl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8lku3hhO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730885017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1wxZBL7gdc64Tq3vyI4u8KFmJMP6vW9gBY9WDr8nPo=;
	b=y73pyFYl0zRPSMbgA90HjEOzYjrwrmTOJWb4Q8o8TtT4VQPy2oCUdTkDXEuh9qKNqSEgDb
	r6XgEXE9mzMtPyM6bpO05hU6KLTSrP0JzAxUILbfphr9SROJEwZfvf14MQvEg8SyMQFUmN
	bmF3IVaPQOyPIFgSkOuVGmw36Xpc6xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730885017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1wxZBL7gdc64Tq3vyI4u8KFmJMP6vW9gBY9WDr8nPo=;
	b=8lku3hhOHi/fLguBC2f11zMO7xeZ/gUp2v4/q+2Os3MY2wjeH76h0vBe9GI0RBBfZSKqM1
	ZW7IL3HKzCveoJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D4013736;
	Wed,  6 Nov 2024 09:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YwdeNJc1K2e7UQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 06 Nov 2024 09:23:35 +0000
Date: Wed, 6 Nov 2024 10:23:34 +0100
From: Oscar Salvador <osalvador@suse.de>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	linux-stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation
 call for FOLL_LONGTERM cases
Message-ID: <Zys1luxxLWwy0yXh@localhost.localdomain>
References: <20241105032944.141488-1-jhubbard@nvidia.com>
 <20241105032944.141488-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105032944.141488-2-jhubbard@nvidia.com>
X-Rspamd-Queue-Id: F1A6B21C29
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nvidia.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Nov 04, 2024 at 07:29:44PM -0800, John Hubbard wrote:
> commit 53ba78de064b ("mm/gup: introduce
> check_and_migrate_movable_folios()") created a new constraint on the
> pin_user_pages*() API family: a potentially large internal allocation
> must now occur, for FOLL_LONGTERM cases.
> 
> A user-visible consequence has now appeared: user space can no longer
> pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
> PAGE_SIZE system, when user space tries to (indirectly, via a device
> driver that calls pin_user_pages()) pin 2GB, this requires an allocation
> of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
> kmalloc().
> 
> In addition to the directly visible effect described above, there is
> also the problem of adding an unnecessary allocation. The **pages array
> argument has already been allocated, and there is no need for a
> redundant **folios array allocation in this case.
> 
> Fix this by avoiding the new allocation entirely. This is done by
> referring to either the original page[i] within **pages, or to the
> associated folio. Thanks to David Hildenbrand for suggesting this
> approach and for providing the initial implementation (which I've tested
> and adjusted slightly) as well.
> 
> Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Junxiao Chang <junxiao.chang@intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Hi John, thanks for doing this.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Nit below:

> +static int
> +migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
> +				   struct pages_or_folios *pofs)
>  {
>  	int ret;
>  	unsigned long i;
>  
> -	for (i = 0; i < nr_folios; i++) {
> -		struct folio *folio = folios[i];
> +	for (i = 0; i < pofs->nr_entries; i++) {
> +		struct folio *folio = pofs_get_folio(pofs, i);
>  
>  		if (folio_is_device_coherent(folio)) {
>  			/*
> @@ -2344,7 +2380,7 @@ static int migrate_longterm_unpinnable_folios(
>  			 * convert the pin on the source folio to a normal
>  			 * reference.
>  			 */
> -			folios[i] = NULL;
> +			pofs_clear_entry(pofs, i);
>  			folio_get(folio);
>  			gup_put_folio(folio, 1, FOLL_PIN);
>  
> @@ -2363,8 +2399,8 @@ static int migrate_longterm_unpinnable_folios(
>  		 * calling folio_isolate_lru() which takes a reference so the
>  		 * folio won't be freed if it's migrating.
>  		 */
> -		unpin_folio(folios[i]);
> -		folios[i] = NULL;
> +		unpin_folio(pofs_get_folio(pofs, i));

We already retrieved the folio before, cannot we just bypass
pofs_get_folio() here?


-- 
Oscar Salvador
SUSE Labs

