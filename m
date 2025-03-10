Return-Path: <linux-kernel+bounces-554091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C3A592D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDB0188DEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA7221702;
	Mon, 10 Mar 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xcNZI6Pk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4MRRiFZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xcNZI6Pk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4MRRiFZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233AD21E092
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606651; cv=none; b=GZzoRfB63y2IL0N+n7JrNrgHLrraHGPgL28Bu0s7wGRfou0a+h6Za1uhqc9xYyF+sKr5mY9OAt3kcbWRMtkr6ZQ/5f3OhehzsSDMGQtMRLdV+ALoxhtxGVSEPWbU2E765+bOJgXNQJ7ux1ZcD6BUee2cqaRiwdmjgOd6vw4kCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606651; c=relaxed/simple;
	bh=DMs/TAlP3Os2nxZau3ARmh/n4V/08GFKW/xi2WtQBSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4carXBFIYHDbxe2YTNbLdwLoIo1NVCcLe7uq/8UkVG9PCCc9fn2S8ur/Q7gFjUzx6ZKgI5MN/6px29kR+7hdAXzaIkOF33nv/kFL0OyjRjPbahKx5F+w/Vn3PN+hXFqnh3808dmv/IULJnx5NhAhcimypcYMyGb/PyrXtDZ2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xcNZI6Pk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4MRRiFZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xcNZI6Pk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4MRRiFZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CF721F38C;
	Mon, 10 Mar 2025 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741606646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfW0icj+R9uq3V3PyovxRXcxaOTH8rdLWSIUiTmY8c0=;
	b=xcNZI6Pk6vvaINpdGf5jo7J4jmr2mj+lwY9UyB/3nEOjoMU+AhkU35JnFa0BPVsFfLPcWS
	+sn0XLx4Z2aqnwEHjvHKx+1NnS9J/qyASd0SjBVh0p6QKZti64sA8uoU6tWP7CtJ9EEMeE
	J/drOe0g4JU4nLpHWAkaKrIF/HSFrSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741606646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfW0icj+R9uq3V3PyovxRXcxaOTH8rdLWSIUiTmY8c0=;
	b=k4MRRiFZkZwWAGpJwFbr/uxf8Virpg/n2xQLkPc81RUTZEs9PUGXN0SkqSYDbP2Ci3w0eT
	0nQvFQZut0mW7HCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xcNZI6Pk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k4MRRiFZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741606646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfW0icj+R9uq3V3PyovxRXcxaOTH8rdLWSIUiTmY8c0=;
	b=xcNZI6Pk6vvaINpdGf5jo7J4jmr2mj+lwY9UyB/3nEOjoMU+AhkU35JnFa0BPVsFfLPcWS
	+sn0XLx4Z2aqnwEHjvHKx+1NnS9J/qyASd0SjBVh0p6QKZti64sA8uoU6tWP7CtJ9EEMeE
	J/drOe0g4JU4nLpHWAkaKrIF/HSFrSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741606646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfW0icj+R9uq3V3PyovxRXcxaOTH8rdLWSIUiTmY8c0=;
	b=k4MRRiFZkZwWAGpJwFbr/uxf8Virpg/n2xQLkPc81RUTZEs9PUGXN0SkqSYDbP2Ci3w0eT
	0nQvFQZut0mW7HCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFE211399F;
	Mon, 10 Mar 2025 11:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G3j/NfXOzmdLfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 11:37:25 +0000
Message-ID: <03b53f18-8c16-4716-8ed4-1902d7247354@suse.cz>
Date: Mon, 10 Mar 2025 12:37:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Fix memory accept before watermarks gets
 initialized
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>
References: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CF721F38C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/10/25 09:28, Kirill A. Shutemov wrote:
> Watermarks are initialized during the postcore initcall. Until then, all
> watermarks are set to zero. This causes cond_accept_memory() to
> incorrectly skip memory acceptance because a watermark of 0 is always
> met.

What are the user-visible consequences of that?

> To ensure progress, accept one MAX_ORDER page if the watermark is zero.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-and-tested-by: Farrah Chen <farrah.chen@intel.com>

Fixes:, Cc: stable etc?

> ---
>  mm/page_alloc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..4fe93029bcb6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7004,7 +7004,7 @@ static inline bool has_unaccepted_memory(void)
>  
>  static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  {
> -	long to_accept;
> +	long to_accept, wmark;
>  	bool ret = false;
>  
>  	if (!has_unaccepted_memory())
> @@ -7013,8 +7013,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
>  	if (list_empty(&zone->unaccepted_pages))
>  		return false;
>  
> +	wmark = promo_wmark_pages(zone);
> +
> +	/*
> +	 * Watermarks have not been initialized yet.
> +	 *
> +	 * Accepting one MAX_ORDER page to ensure progress.
> +	 */
> +	if (!wmark)
> +		return try_to_accept_memory_one(zone);
> +
>  	/* How much to accept to get to promo watermark? */
> -	to_accept = promo_wmark_pages(zone) -
> +	to_accept = wmark -
>  		    (zone_page_state(zone, NR_FREE_PAGES) -
>  		    __zone_watermark_unusable_free(zone, order, 0) -
>  		    zone_page_state(zone, NR_UNACCEPTED));


