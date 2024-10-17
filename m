Return-Path: <linux-kernel+bounces-369506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CB9A1E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A483228507E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1561DB52D;
	Thu, 17 Oct 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M02S6C3i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AavFWX7w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M02S6C3i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AavFWX7w"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145321DACA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156861; cv=none; b=ZJ6jGIB4TBWTznh9zBqDiGh54QG4T9pREAsp/CPhFPLGsXw+FwU0kR3Mk5emj3u7jwLgOHa7XHKzXY6PMDoppmtBuyfR54U4WPnmIH5kJRsvL+L6s7jVwUlGnjMdQz2DnvoMJ9TGHGoHW++ZV9airfNGkfeIX5guYQ0SAp6z+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156861; c=relaxed/simple;
	bh=WG6zPnBcVYlDc5OmUtYVEvBzUoTJ9eJ6EOJNG/5IeSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgZ8z4Y+lNK9PgKA9V97FJcdmvpnZ4eBwFPsbzo3ZnXSEkPSkCy5+KWqEjx5JgHRhdIiRe0kmpXe7AtzsmjlsBWdIKFA7U3PA32A0H5G9NxDtp4Xs8O0emrePLpkisnl2v+EI8c/zrg5HZXWAt97ynnQ66OCniM3WCB9Zqi2TSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M02S6C3i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AavFWX7w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M02S6C3i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AavFWX7w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1801E1FEF3;
	Thu, 17 Oct 2024 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729156856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rlGcWKytSPzUfNRR42UnWi/FqU3SMgFJqScHSHZrPlk=;
	b=M02S6C3i9kxAE6zX0RojBDyoIRGv8kMmr1/KvVw0ShflgeHFaGgwdzjgnaAgk7Bk+td5eY
	Hzf/xOyJH6kGYvSyIoL1oGnazsvaWDibn51p671OXTsiSi/MpkgfwwhiHDS9P8PAAlYHo4
	l+9vLrSH/5bplNbsryIB1fiNJtT75IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729156856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rlGcWKytSPzUfNRR42UnWi/FqU3SMgFJqScHSHZrPlk=;
	b=AavFWX7wk53sH4R3rxVkt79ywXYVx9+2XEyAgImNJ1Awvj/3fJAudzCEd2zZwvv0xxGhUB
	KjP0EMzsLwXMkUCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729156856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rlGcWKytSPzUfNRR42UnWi/FqU3SMgFJqScHSHZrPlk=;
	b=M02S6C3i9kxAE6zX0RojBDyoIRGv8kMmr1/KvVw0ShflgeHFaGgwdzjgnaAgk7Bk+td5eY
	Hzf/xOyJH6kGYvSyIoL1oGnazsvaWDibn51p671OXTsiSi/MpkgfwwhiHDS9P8PAAlYHo4
	l+9vLrSH/5bplNbsryIB1fiNJtT75IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729156856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rlGcWKytSPzUfNRR42UnWi/FqU3SMgFJqScHSHZrPlk=;
	b=AavFWX7wk53sH4R3rxVkt79ywXYVx9+2XEyAgImNJ1Awvj/3fJAudzCEd2zZwvv0xxGhUB
	KjP0EMzsLwXMkUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02F6313A53;
	Thu, 17 Oct 2024 09:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UCccAPjWEGeZRwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 17 Oct 2024 09:20:56 +0000
Message-ID: <3fba1c4f-5c22-496b-a5cb-ffa74be9fe6c@suse.cz>
Date: Thu, 17 Oct 2024 11:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vmscan: add a vmscan event for reclaim_pages
Content-Language: en-US
To: jaewon31.kim@samsung.com, "sj@kernel.org" <sj@kernel.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "kaleshsingh@google.com" <kaleshsingh@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
References: <CGME20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11@epcms1p6>
 <20241016132452epcms1p6884ae0197aa83731baa193fb5714b0d2@epcms1p6>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241016132452epcms1p6884ae0197aa83731baa193fb5714b0d2@epcms1p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/16/24 15:24, 김재원 wrote:
>>On 10/11/24 14:49, Jaewon Kim wrote:
>>> The reclaim_folio_list uses a dummy reclaim_stat and is not being
>>> used. To know the memory stat, add a new trace event. This is useful how
>>> how many pages are not reclaimed or why.
>>> 
>>> This is an example.
>>> mm_vmscan_reclaim_pages: nid=0 nr_scanned=112 nr_reclaimed=112 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
>>> 
>>> Currenlty reclaim_folio_list is only called by reclaim_pages, and
>>> reclaim_pages is used by damon and madvise. In the latest Android,
>>> reclaim_pages is also used by shmem to reclaim all pages in a
>>> address_space.
>>> 
>>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>>> ---
>>> v2: remove reclaim_stat_add function and call the trace on each node
>>> v1: introduce a new trace event
>>> ---
>>>  include/trace/events/vmscan.h | 45 +++++++++++++++++++++++++++++++++++
>>>  mm/vmscan.c                   | 16 +++++++++----
>>>  2 files changed, 56 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
>>> index 1a488c30afa5..490958fa10de 100644
>>> --- a/include/trace/events/vmscan.h
>>> +++ b/include/trace/events/vmscan.h
>>> @@ -346,6 +346,51 @@ TRACE_EVENT(mm_vmscan_write_folio,
>>>                  show_reclaim_flags(__entry->reclaim_flags))
>>>  );
>>>  
>>> +TRACE_EVENT(mm_vmscan_reclaim_pages,
>>> +
>>> +        TP_PROTO(int nid,
>>> +                unsigned long nr_scanned, unsigned long nr_reclaimed,
>>> +                struct reclaim_stat *stat),
>>> +
>>> +        TP_ARGS(nid, nr_scanned, nr_reclaimed, stat),
>>> +
>>> +        TP_STRUCT__entry(
>>> +                __field(int, nid)
>>> +                __field(unsigned long, nr_scanned)
>>> +                __field(unsigned long, nr_reclaimed)
>>> +                __field(unsigned long, nr_dirty)
>>> +                __field(unsigned long, nr_writeback)
>>> +                __field(unsigned long, nr_congested)
>>> +                __field(unsigned long, nr_immediate)
>>> +                __field(unsigned int, nr_activate0)
>>> +                __field(unsigned int, nr_activate1)
>>> +                __field(unsigned long, nr_ref_keep)
>>> +                __field(unsigned long, nr_unmap_fail)
>>> +        ),
>>> +
>>> +        TP_fast_assign(
>>> +                __entry->nid = nid;
>>> +                __entry->nr_scanned = nr_scanned;
>>> +                __entry->nr_reclaimed = nr_reclaimed;
>>> +                __entry->nr_dirty = stat->nr_dirty;
>>> +                __entry->nr_writeback = stat->nr_writeback;
>>> +                __entry->nr_congested = stat->nr_congested;
>>> +                __entry->nr_immediate = stat->nr_immediate;
>>> +                __entry->nr_activate0 = stat->nr_activate[0];
>>> +                __entry->nr_activate1 = stat->nr_activate[1];
>>> +                __entry->nr_ref_keep = stat->nr_ref_keep;
>>> +                __entry->nr_unmap_fail = stat->nr_unmap_fail;
>>> +        ),
>>> +
>>> +        TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld",
>>> +                __entry->nid,
>>> +                __entry->nr_scanned, __entry->nr_reclaimed,
>>> +                __entry->nr_dirty, __entry->nr_writeback,
>>> +                __entry->nr_congested, __entry->nr_immediate,
>>> +                __entry->nr_activate0, __entry->nr_activate1,
>>> +                __entry->nr_ref_keep, __entry->nr_unmap_fail)
>>> +);
>>> +
>>>  TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>>>  
>>>          TP_PROTO(int nid,
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 749cdc110c74..0c2c36bf4c5a 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -2126,9 +2126,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
>>>  }
>>>  
>>>  static unsigned int reclaim_folio_list(struct list_head *folio_list,
>>> +                                      unsigned int nr_scanned,
>>>                                        struct pglist_data *pgdat)
>>>  {
>>> -        struct reclaim_stat dummy_stat;
>>> +        struct reclaim_stat stat;
>>>          unsigned int nr_reclaimed;
>>>          struct folio *folio;
>>>          struct scan_control sc = {
>>> @@ -2139,12 +2140,13 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>>>                  .no_demotion = 1,
>>>          };
>>>  
>>> -        nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);
>>> +        nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true);
>>>          while (!list_empty(folio_list)) {
>>>                  folio = lru_to_folio(folio_list);
>>>                  list_del(&folio->lru);
>>>                  folio_putback_lru(folio);
>>>          }
>>> +        trace_mm_vmscan_reclaim_pages(pgdat->node_id, nr_scanned, nr_reclaimed, &stat);
>>
>>Why is the new calculation of nr_scanned needed? Could you just take a delta
>>of sc->nr_scanned, i.e. after - before calling shrink_folio_list() ?
> 
> Oh correct. 
> 
> Except the case of (!folio_trylock(folio)), shrink_folio_list would count on sc->nr_scanned.
> I don't understand why we do not count this lock case though.

Guess it means we couldn't really scan it. Should be probably rare anyway.


