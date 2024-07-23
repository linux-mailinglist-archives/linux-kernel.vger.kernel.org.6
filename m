Return-Path: <linux-kernel+bounces-259674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E77939B46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E241C2194C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5E13D248;
	Tue, 23 Jul 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsVKWqXR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTWkUb0u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsVKWqXR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTWkUb0u"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92238130AC8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718134; cv=none; b=ERzJhGUU1J6dWtuau6cuSVWeF/a8qr+I4n1NB5mtmei8ROkTec/qIgLGAwhIUVdjPspdqQ5HNgQ4+eIt22DFveqeitPK5s71iFby6oNrsA8kTOKJfaz+3k2ivTOCZzf8GTP0XY/npFK3qbWD+tiNVKRbSZsEuhAs8BH0dKItPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718134; c=relaxed/simple;
	bh=WlRZwKDKcA1kmOREZOfWzbRccX+E5enM/6D1oxmQFPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyogpyPUUeA6apjY7cY8shk6vHGG5SjyJLt3XCLYqxIBFT1em+mCRR/DKFyUjTP438qy4L6bYUwD+1jaAEIbr7XumGnxga7w4oyTOZBfrNM8Nuu0NbAnWj1Fthghn3NHuM05kWfCcYSCM089HWWIZRdKANrKF+b69MhE9sdNvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsVKWqXR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTWkUb0u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsVKWqXR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTWkUb0u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2B4D2174A;
	Tue, 23 Jul 2024 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721718130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ah17SItxJ57HnquFDgj7w7ZLVAS8JHQip51CdTKeOak=;
	b=NsVKWqXRoVR9tG/juxXoxo/sqNBI2/BsioRgLck3mamDhVAdaw6LG4o2cQLEMS11pzTUmJ
	ixKwNLN2+NKjt31umPb1o+VvgQXfuqoptahg4MsJ3qiq5+6fFrF3oF4n0v3uvmal6I3yO3
	XmvrbLH+x2+eSmFN/Itg+9ySvPu4UpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721718130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ah17SItxJ57HnquFDgj7w7ZLVAS8JHQip51CdTKeOak=;
	b=GTWkUb0uMnqcs33QMu9/yXt5nv0QY/1TafxmshsWXb6Ev06jUnCUDghqa5MKvCyUspGI18
	jxvaAYroUg9dvfAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NsVKWqXR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GTWkUb0u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721718130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ah17SItxJ57HnquFDgj7w7ZLVAS8JHQip51CdTKeOak=;
	b=NsVKWqXRoVR9tG/juxXoxo/sqNBI2/BsioRgLck3mamDhVAdaw6LG4o2cQLEMS11pzTUmJ
	ixKwNLN2+NKjt31umPb1o+VvgQXfuqoptahg4MsJ3qiq5+6fFrF3oF4n0v3uvmal6I3yO3
	XmvrbLH+x2+eSmFN/Itg+9ySvPu4UpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721718130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ah17SItxJ57HnquFDgj7w7ZLVAS8JHQip51CdTKeOak=;
	b=GTWkUb0uMnqcs33QMu9/yXt5nv0QY/1TafxmshsWXb6Ev06jUnCUDghqa5MKvCyUspGI18
	jxvaAYroUg9dvfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA1413874;
	Tue, 23 Jul 2024 07:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2zlnJnJVn2b4TQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jul 2024 07:02:10 +0000
Message-ID: <2c81bdc0-8ff3-467d-9ff8-2e7b95bff2af@suse.cz>
Date: Tue, 23 Jul 2024 09:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
To: Li Zhijian <lizhijian@fujitsu.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Yasunori Gotou <y-goto@fujitsu.com>, David Hildenbrand <david@redhat.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
References: <20240723064428.1179519-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240723064428.1179519-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B2B4D2174A

On 7/23/24 8:44 AM, Li Zhijian wrote:
> It's expected that no page should be left in pcp_list after calling
> zone_pcp_disable() in offline_pages(). Previously, it's observed that
> offline_pages() gets stuck [1] due to some pages remaining in pcp_list.
> 
> Cause:
> There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
> involving the pcp->count variable. See below scenario:
> 
>          CPU0                              CPU1
>     ----------------                    ---------------
>                                       spin_lock(&pcp->lock);
>                                       __rmqueue_pcplist() {
> zone_pcp_disable() {
>                                         /* list is empty */
>                                         if (list_empty(list)) {
>                                           /* add pages to pcp_list */
>                                           alloced = rmqueue_bulk()
>   mutex_lock(&pcp_batch_high_lock)
>   ...
>   __drain_all_pages() {
>     drain_pages_zone() {
>       /* read pcp->count, it's 0 here */
>       count = READ_ONCE(pcp->count)
>       /* 0 means nothing to drain */
>                                           /* update pcp->count */
>                                           pcp->count += alloced << order;
>       ...
>                                       ...
>                                       spin_unlock(&pcp->lock);
> 
> In this case, after calling zone_pcp_disable() though, there are still some
> pages in pcp_list. And these pages in pcp_list are neither movable nor
> isolated, offline_pages() gets stuck as a result.
> 
> Solution:
> Expand the scope of the pcp->lock to also protect pcp->count in
> drain_pages_zone(), to ensure no pages are left in the pcp list after
> zone_pcp_disable()
> 
> [1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
I'd also add a Cc: stable in this case

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
> V3:
>     Read pcp->count in the loop with lock held to prevent unnecessary spin_lock() wasteful
> V2:
>     - Narrow down the scope of the spin_lock() to limit the draining latency. # Vlastimil and David
>     - In above scenario, it's sufficient to read pcp->count once with lock held, and it fully fixed
>       my issue[1] in thounds runs(It happened in more than 5% before).
> RFC:
>     https://lore.kernel.org/linux-mm/20240716073929.843277-1-lizhijian@fujitsu.com/
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  mm/page_alloc.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9ecf99190ea2..a32289ec4768 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2323,16 +2323,20 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  {
>  	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> -	int count = READ_ONCE(pcp->count);
> -
> -	while (count) {
> -		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
> -		count -= to_drain;
> +	int count;
>  
> +	do {
>  		spin_lock(&pcp->lock);
> -		free_pcppages_bulk(zone, to_drain, pcp, 0);
> +		count = pcp->count;
> +		if (count) {
> +			int to_drain = min(count,
> +				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
> +
> +			free_pcppages_bulk(zone, to_drain, pcp, 0);
> +			count -= to_drain;
> +		}
>  		spin_unlock(&pcp->lock);
> -	}
> +	} while (count);
>  }
>  
>  /*


