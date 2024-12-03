Return-Path: <linux-kernel+bounces-429548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2244C9E1DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7249286782
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259911EE00D;
	Tue,  3 Dec 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3BI+y1Zx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mYxALwo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3BI+y1Zx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mYxALwo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95521E47C8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232791; cv=none; b=PQDuHG84a7QsFz9M6vl7jUhTx0oOJ2pesP5NDzQjdmxaLwzJdKv/39zevZHt3d3B0nGca+HsNAx/YeHCLLikRXaFFd9BY01wJEA99jVd5FkFdRnJwz68eY9bi6rq+AGA1EcXHR1DumGtqoctEcEPY5A1sJVCw4K0Drb31QThdiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232791; c=relaxed/simple;
	bh=e6lCCBl79vfOUi358l/RgZirIwYNgtnskqAtBxS/R24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KURSJpTBv60uQYV1K7U6nMJTAbwQlhRuCM2hlay7F6x36l2oTBIgtpHbvBrOYkXRuBbiqBhSnmbuNTw0to+U8er902fyyt1OUX9MYuN/aXtckkU8nsQqis+PGoRkr2/0YBRZB0zIDkxAJ9JQ3BUrxLAqE4YHfIEeAJJZ9kOK4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3BI+y1Zx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mYxALwo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3BI+y1Zx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mYxALwo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3E371F453;
	Tue,  3 Dec 2024 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733232788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdmQf9A9c3+pcii2FDFPbM18TTsEtfAMO3Iwr/KW5xk=;
	b=3BI+y1Zx5pK8pEkAYDlNNxGsUYH79LE8hNS6sv4umXISbA+A35iKYgNl+Dyt3gCIBlBGwt
	49BTNXSBUEcqH/7XNxo7D39GflzLxqqJwHSULnpJt7N81ZOwE9quzF/7sT9lI2F0mwH1c6
	iO+g9CwJpG4hY8eZbo0TYDahIiB6UgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733232788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdmQf9A9c3+pcii2FDFPbM18TTsEtfAMO3Iwr/KW5xk=;
	b=1mYxALwof+5OJlVTprquUJGOpEGw4EFe6sgO/3cVSflyf5paULj9ngRZTi+XPYMJDNthIn
	wZlkTI7GYlCwyrAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733232788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdmQf9A9c3+pcii2FDFPbM18TTsEtfAMO3Iwr/KW5xk=;
	b=3BI+y1Zx5pK8pEkAYDlNNxGsUYH79LE8hNS6sv4umXISbA+A35iKYgNl+Dyt3gCIBlBGwt
	49BTNXSBUEcqH/7XNxo7D39GflzLxqqJwHSULnpJt7N81ZOwE9quzF/7sT9lI2F0mwH1c6
	iO+g9CwJpG4hY8eZbo0TYDahIiB6UgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733232788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdmQf9A9c3+pcii2FDFPbM18TTsEtfAMO3Iwr/KW5xk=;
	b=1mYxALwof+5OJlVTprquUJGOpEGw4EFe6sgO/3cVSflyf5paULj9ngRZTi+XPYMJDNthIn
	wZlkTI7GYlCwyrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D833313A15;
	Tue,  3 Dec 2024 13:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XsJfNJMIT2e6IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 13:33:07 +0000
Message-ID: <93808ae8-4607-41b1-ba6c-20c78279d6f7@suse.cz>
Date: Tue, 3 Dec 2024 14:33:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/6] mm/page_alloc: make
 __alloc_contig_migrate_range() static
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-4-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,lists.ozlabs.org,linux-foundation.org,suse.de,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On 12/3/24 10:47, David Hildenbrand wrote:
> The single user is in page_alloc.c.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h   | 4 ----
>  mm/page_alloc.c | 5 ++---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 74713b44bedb..4bd3685c33ef 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -839,10 +839,6 @@ int
>  isolate_migratepages_range(struct compact_control *cc,
>  			   unsigned long low_pfn, unsigned long end_pfn);
>  
> -int __alloc_contig_migrate_range(struct compact_control *cc,
> -					unsigned long start, unsigned long end,
> -					int migratetype);
> -
>  /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
>  void init_cma_reserved_pageblock(struct page *page);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f371fbf2145b..ce7589a4ec01 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6284,9 +6284,8 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
>   * @migratetype: using migratetype to filter the type of migration in
>   *		trace_mm_alloc_contig_migrate_range_info.
>   */
> -int __alloc_contig_migrate_range(struct compact_control *cc,
> -					unsigned long start, unsigned long end,
> -					int migratetype)
> +static int __alloc_contig_migrate_range(struct compact_control *cc,
> +		unsigned long start, unsigned long end, int migratetype)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
>  	unsigned int nr_reclaimed;


