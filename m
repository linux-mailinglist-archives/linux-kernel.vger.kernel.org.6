Return-Path: <linux-kernel+bounces-255596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFE93429D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16211F22CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC21B970;
	Wed, 17 Jul 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaaVHRXh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7jZb1e/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaaVHRXh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7jZb1e/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA417545
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244962; cv=none; b=Qo+tvIN6g+sC9mBkhl5B+yTXqqHfr6jmvrFu4vRFoyPLaEHmc4Bd266a6JslL4rZcI241B8dCtFF4UT4Bat3ok5TeOu+jxCKniyfryHziTlB5TtGOvQV8/dPtdI2/oTFEc3PmqXI/vmf4jLSsn1kQV3AduNcIhyqMKupLoRNJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244962; c=relaxed/simple;
	bh=3KUryYcz0fMjh5IKSrMBbcbZtuFNnkOqQkbm90KaSjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je1GVOvqRa2v3+KclE7RqQWr0LFUws3/6Dw9wohFgPSLQJtK1tlk8rW5log0liIlpA+QTQsomplClHS3U+QY90rFnZLU0J/M7c+ZjTC0A9lq9SxYSsUBQxRRPtDkcCMLD91SrQEd9ANrNWJhPFb7OA3WtwIbbHpfgwJSs7eU9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaaVHRXh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7jZb1e/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaaVHRXh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7jZb1e/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27E571FB98;
	Wed, 17 Jul 2024 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721244957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+M+Pn7zfpnilj1S7DATFhnaQ3aerhqqQI9HJEiiY/4=;
	b=ZaaVHRXhsLIMhOIH6x8Pos36JTHpnUIkdVpUN3FH3jhen6eeqzZFr0KW72H2cdqeLCR4ec
	WKMVQCihtxFMRiFxsJtbPPogSoAEpUE/2vAYc/y6y2tvw11ZpUx86wcTpbIpIQGmfyrmFW
	AuxC8DaM18fN1evvoiavF5TRHEWanv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721244957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+M+Pn7zfpnilj1S7DATFhnaQ3aerhqqQI9HJEiiY/4=;
	b=G7jZb1e/z4SmpZub/w6ZRRyPqbkSf8dlkwiaKEITECRbRXerigPq5tgPHmq4h7QdcyS1bE
	+gWbVdlWuGj55jAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721244957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+M+Pn7zfpnilj1S7DATFhnaQ3aerhqqQI9HJEiiY/4=;
	b=ZaaVHRXhsLIMhOIH6x8Pos36JTHpnUIkdVpUN3FH3jhen6eeqzZFr0KW72H2cdqeLCR4ec
	WKMVQCihtxFMRiFxsJtbPPogSoAEpUE/2vAYc/y6y2tvw11ZpUx86wcTpbIpIQGmfyrmFW
	AuxC8DaM18fN1evvoiavF5TRHEWanv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721244957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+M+Pn7zfpnilj1S7DATFhnaQ3aerhqqQI9HJEiiY/4=;
	b=G7jZb1e/z4SmpZub/w6ZRRyPqbkSf8dlkwiaKEITECRbRXerigPq5tgPHmq4h7QdcyS1bE
	+gWbVdlWuGj55jAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11A5B136E5;
	Wed, 17 Jul 2024 19:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkb+Ax0dmGbsXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 19:35:57 +0000
Message-ID: <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz>
Date: Wed, 17 Jul 2024 21:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel test robot <lkp@intel.com>
References: <20240717181239.2510054-1-surenb@google.com>
 <20240717181239.2510054-2-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240717181239.2510054-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/17/24 8:12 PM, Suren Baghdasaryan wrote:
> Outline and export free_reserved_page() because modules use it and it
> in turn uses page_ext_{get|put} which should not be exported. The same
> result could be obtained by outlining {get|put}_page_tag_ref() but that
> would have higher performance impact as these functions are used in
> more performance critical paths.
> 
> Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Are these two patches now stable@ material as 6.10 build is broken on ppc64
with alloc taging enabled?

> ---
> Changes since v1 [1]
> - Outlined and exported free_reserved_page() in place of {get|put}_page_tag_ref,
> per Vlastimil Babka
> 
> [1] https://lore.kernel.org/all/20240717011631.2150066-2-surenb@google.com/
> 
>  include/linux/mm.h | 16 +---------------
>  mm/page_alloc.c    | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index eb7c96d24ac0..b58bad248eef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3177,21 +3177,7 @@ extern void reserve_bootmem_region(phys_addr_t start,
>  				   phys_addr_t end, int nid);
>  
>  /* Free the reserved page into the buddy system, so it gets managed. */
> -static inline void free_reserved_page(struct page *page)
> -{
> -	if (mem_alloc_profiling_enabled()) {
> -		union codetag_ref *ref = get_page_tag_ref(page);
> -
> -		if (ref) {
> -			set_codetag_empty(ref);
> -			put_page_tag_ref(ref);
> -		}
> -	}
> -	ClearPageReserved(page);
> -	init_page_count(page);
> -	__free_page(page);
> -	adjust_managed_page_count(page, 1);
> -}
> +void free_reserved_page(struct page *page);
>  #define free_highmem_page(page) free_reserved_page(page)
>  
>  static inline void mark_page_reserved(struct page *page)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9ecf99190ea2..7d2fa9f5e750 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5805,6 +5805,23 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>  	return pages;
>  }
>  
> +void free_reserved_page(struct page *page)
> +{
> +	if (mem_alloc_profiling_enabled()) {
> +		union codetag_ref *ref = get_page_tag_ref(page);
> +
> +		if (ref) {
> +			set_codetag_empty(ref);
> +			put_page_tag_ref(ref);
> +		}
> +	}
> +	ClearPageReserved(page);
> +	init_page_count(page);
> +	__free_page(page);
> +	adjust_managed_page_count(page, 1);
> +}
> +EXPORT_SYMBOL(free_reserved_page);
> +
>  static int page_alloc_cpu_dead(unsigned int cpu)
>  {
>  	struct zone *zone;


