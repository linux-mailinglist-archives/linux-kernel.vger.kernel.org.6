Return-Path: <linux-kernel+bounces-360773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF6999F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6897B218F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA720B214;
	Fri, 11 Oct 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEGDobxt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tq4JHZD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEGDobxt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tq4JHZD0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAA20A5E2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636788; cv=none; b=dA0NRVEuZM0kz/2sI5RZuYCIZ+nw56//qJAeHCy5kvEGwh1R3dEVDAVh5ovBNPfoy7Hintm9VpJSKuNLJIsQoeSUs4tPEe6eaHHR8Ffn9UPsaV0JZFywdcV/iUlg9bnYAMj6OaM46973u0OLT0ICccR3ZVOq/UfGQY2Lk9SCKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636788; c=relaxed/simple;
	bh=A5wC3utkB/+KR+mTBA8M6Btsj+JVPxvV77IO/l+nJQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBqSaXzivcOH5gKQTHTbvb5P3e0DCRxZt8Py98yh8bT26N4+UjP1ni3885bPsmNaAWysUIOiwXqJSDymRVq4+dpHDq0ydLo61Q8gggNb/2rdh3YnIDvdfcnXNrZpoeZIBV7iQGXl6mL125snHSmFpdxSw3Lfua/Cqeyo06GwFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEGDobxt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tq4JHZD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEGDobxt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tq4JHZD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9013822003;
	Fri, 11 Oct 2024 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728636784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlyR+/4CFNT2GGHrEjQJ2/LjpqtZ1LuCOxv8aKDnKc=;
	b=xEGDobxtSbKX9JWVaHbvYNOwMdoiZO6vlbuPTugvadZyFxz1r0NE4l8CKsg8C8DBgYJHLJ
	mNBx7t5SS3ktUkXHMuFjCtiw6yu9BRzG12Bn9zidjMtCqD7NSevixX4Lo6GqyHBHT7yG0g
	lgJjVTKRdA1kiBjwa1mK2YPJg32YF5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728636784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlyR+/4CFNT2GGHrEjQJ2/LjpqtZ1LuCOxv8aKDnKc=;
	b=tq4JHZD0FUkrZ0oQCbIbgDQhgxdf2iltDf840Y45Qikr4L8cyH2ZsN+ijCY+MY1BVnkCQD
	37L01L2HWABaZ0AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xEGDobxt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tq4JHZD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728636784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlyR+/4CFNT2GGHrEjQJ2/LjpqtZ1LuCOxv8aKDnKc=;
	b=xEGDobxtSbKX9JWVaHbvYNOwMdoiZO6vlbuPTugvadZyFxz1r0NE4l8CKsg8C8DBgYJHLJ
	mNBx7t5SS3ktUkXHMuFjCtiw6yu9BRzG12Bn9zidjMtCqD7NSevixX4Lo6GqyHBHT7yG0g
	lgJjVTKRdA1kiBjwa1mK2YPJg32YF5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728636784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlyR+/4CFNT2GGHrEjQJ2/LjpqtZ1LuCOxv8aKDnKc=;
	b=tq4JHZD0FUkrZ0oQCbIbgDQhgxdf2iltDf840Y45Qikr4L8cyH2ZsN+ijCY+MY1BVnkCQD
	37L01L2HWABaZ0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76876136E0;
	Fri, 11 Oct 2024 08:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +YFsHHDnCGfBIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Oct 2024 08:53:04 +0000
Message-ID: <dd7e07ba-acaf-4f93-93e0-ec2d98a4da55@suse.cz>
Date: Fri, 11 Oct 2024 10:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmscan: add a vmscan event for reclaim_pages
To: jaewon31.kim@samsung.com, "sj@kernel.org" <sj@kernel.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "kaleshsingh@google.com" <kaleshsingh@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
References: <b8c56752-3451-4f15-b7f6-c18234ae4565@suse.cz>
 <20241009093124.3647359-1-jaewon31.kim@samsung.com>
 <CGME20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179@epcms1p6>
 <20241011082539epcms1p6039313672abedf63d5368a3eae87bad5@epcms1p6>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241011082539epcms1p6039313672abedf63d5368a3eae87bad5@epcms1p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9013822003
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/11/24 10:25 AM, Jaewon Kim wrote:
> Hi
> 
> Thank you for your coment. Yes if it is allowed, I can do that way. When
> I checked, the following functions should do the memset().
> 
> reclaim_clean_pages_from_list
> shrink_inactive_list
> reclaim_folio_list
> evict_folios      
> 
> Actually I was planning to move trace_mm_vmscan_reclaim_pages into
> reclaim_folio_list so that we don't have to sum up and we may be able
> to print node number, too. As we will see log for each node, if we'd
> like to know the sum, that would be the post parser's job.
> 
> Option 1. No change on memset, but print on each node.
> mm_vmscan_reclaim_pages: nid=0 nr_scanned=112 nr_reclaimed=112 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
> mm_vmscan_reclaim_pages: nid=1 ...
> mm_vmscan_reclaim_pages: nid=2 ...

I see. Note it processes a list that might be from multiple nodes and
will group consecutive pages from the same node, but if pages come from
random nodes, the nodes will repeat and there might be many trace
events, each for few pages only.

Guess it depends on the workload if it has its pages from the same node.
Maybe you can try and see how noisy it is in practice?

> Option 2. Change on memset, but we don't care the stat from each node.
> mm_vmscan_reclaim_pages: nr_scanned=35 nr_reclaimed=35 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
> 
> Would you give me you preference between the two options?
>                                                         
> Thank you
> Jaewon Kim
>                                                                                                                                                      
>>                                                                                                                                                                                          
>> AFAICS shrink_folio_list() only cares about these fields:                                                                                                                                 
>>                                                                                                                                                                                          
>> pgactivate = stat->nr_activate[0] + stat->nr_activate[1];                                                                                                                                 
>>                                                                                                                                                                                          
>> in order to do                                                                                                                                                                            
>>                                                                                                                                                                                          
>> count_vm_events(PGACTIVATE, pgactivate);                                                                                                                                                  
>>                                                                                                                                                                                          
>> Which could be adjusted to deal with accumulating stat - i.e. take an                                                                                                                     
>> initial sum of the fields in stat and subtract from the final sum to get                                                                                                                  
>> the delta.                                                                                                                                                                                
>>                                                                                                                                                                                         
>>>  unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                                              
>>>  {                                                                                                                                                                                      
>>>  	int nid;                                                                                                                                                                              
>>> +	unsigned int nr_scanned = 0;                                                                                                                                                          
>>>  	unsigned int nr_reclaimed = 0;                                                                                                                                                        
>>>  	LIST_HEAD(node_folio_list);                                                                                                                                                           
>>>  	unsigned int noreclaim_flag;                                                                                                                                                          
>>> +	struct reclaim_stat stat_total, stat_one;                                                                                                                                             
>>>                                                                                                                                                                                         
>>>  	if (list_empty(folio_list))                                                                                                                                                           
>>>  		return nr_reclaimed;                                                                                                                                                                
>>>                                                                                                                                                                                         
>>> +	memset(&stat_total, 0, sizeof(stat_total));                                                                                                                                           
>>>  	noreclaim_flag = memalloc_noreclaim_save();                                                                                                                                           
>>>                                                                                                                                                                                         
>>>  	nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                            
>>> @@ -2168,14 +2192,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)                                                                                                       
>>>  		if (nid == folio_nid(folio)) {                                                                                                                                                      
>>>  			folio_clear_active(folio);                                                                                                                                                        
>>>  			list_move(&folio->lru, &node_folio_list);                                                                                                                                         
>>> +			nr_scanned += folio_nr_pages(folio);                                                                                                                                              
>>>  			continue;                                                                                                                                                                         
>>>  		}                                                                                                                                                                                   
>>>                                                                                                                                                                                         
>>> -		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                               
>>> +		nr_reclaimed += reclaim_folio_list(&node_folio_list,                                                                                                                                
>>> +						   NODE_DATA(nid), &stat_one);                                                                                                                                              
>>> +		reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                           
>>>  		nid = folio_nid(lru_to_folio(folio_list));                                                                                                                                          
>>>  	} while (!list_empty(folio_list));                                                                                                                                                    
>>>                                                                                                                                                                                         
>>> -	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));                                                                                                                 
>>> +	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),                                                                                                                  
>>> +					   &stat_one);                                                                                                                                                                
>>> +	reclaim_stat_add(&stat_one, &stat_total);                                                                                                                                             
>>> +	trace_mm_vmscan_reclaim_pages(nr_scanned, nr_reclaimed, &stat_total);                                                                                                                 
>>>                                                                                                                                                                                         
>>>  	memalloc_noreclaim_restore(noreclaim_flag);                                                                                                                                           
>>>                                                                                                                                                                                         

