Return-Path: <linux-kernel+bounces-429545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FB99E1D94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D0D285D08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B91EF09C;
	Tue,  3 Dec 2024 13:31:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE817BB16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232667; cv=none; b=gJweRhIiqAYIq+cMV1TapumyAwhOKkag6lyA//ARlaIzLVwmoEvwYxCc3cwlZo0vze3qn43tkql5OeMv0NO0z8HlCR+FXYV/CpxmwKLGkxpwftNU88Lkf/nS6Jd9F7facDXTpjAYZZYM6lX8mtHPm9RRThmJqclkXvxtwCciFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232667; c=relaxed/simple;
	bh=ceYj1RiDEHKK8dr58oE8vuCdLLJNmVRAj39pWu9/Aow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbzVOyca7P/+fB8MPwzmz1CaLzZouLydWwDlRgrg4QvIcScWLXJIh44grbr4U5c77m8Qh1PJfMg3QGpO/Y5oIX47jeFyLaPL3596I6zdhqVixd490yPeqgaqQ+4bEGqEl+JvwhB+Mi+s1lcZKd21I9U7lKRgZRQa11VOgg48Fjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93A0D1F445;
	Tue,  3 Dec 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 781F513A15;
	Tue,  3 Dec 2024 13:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGbLHBcIT2cYIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 13:31:03 +0000
Message-ID: <2e66a245-30d3-4765-95df-13d300de5d13@suse.cz>
Date: Tue, 3 Dec 2024 14:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/6] mm/page_isolation: don't pass gfp flags to
 isolate_single_pageblock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-2-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 93A0D1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On 12/3/24 10:47, David Hildenbrand wrote:
> The flags are no longer used, we can stop passing them to
> isolate_single_pageblock().
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_isolation.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 7e04047977cf..e680d40d96de 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -286,7 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * within a free or in-use page.
>   * @boundary_pfn:		pageblock-aligned pfn that a page might cross
>   * @flags:			isolation flags
> - * @gfp_flags:			GFP flags used for migrating pages
>   * @isolate_before:	isolate the pageblock before the boundary_pfn
>   * @skip_isolation:	the flag to skip the pageblock isolation in second
>   *			isolate_single_pageblock()
> @@ -306,8 +305,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * the in-use page then splitting the free page.
>   */
>  static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation,
> -			int migratetype)
> +		bool isolate_before, bool skip_isolation, int migratetype)
>  {
>  	unsigned long start_pfn;
>  	unsigned long isolate_pageblock;
> @@ -489,7 +487,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	bool skip_isolation = false;
>  
>  	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false,
> +	ret = isolate_single_pageblock(isolate_start, flags, false,
>  			skip_isolation, migratetype);
>  	if (ret)
>  		return ret;
> @@ -498,7 +496,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  		skip_isolation = true;
>  
>  	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
> +	ret = isolate_single_pageblock(isolate_end, flags, true,
>  			skip_isolation, migratetype);
>  	if (ret) {
>  		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);


