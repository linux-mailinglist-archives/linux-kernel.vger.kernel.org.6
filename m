Return-Path: <linux-kernel+bounces-409007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1309C864D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A01F21CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB091E9092;
	Thu, 14 Nov 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YrdubiW6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="642OnAXe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGBLBPeB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpD/7k0h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999C1F7080
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577028; cv=none; b=iMHqO51wwPqsPOYzihynTXJeIJelNbGBmnseZe52T9N9oWOCUXaoORy/wVvzmGngUnUKFjIngChNzo0/dNsRThvLtyIu1fcBlRLJ+SxMlvaJbbaSMSpA322aKlzDVPbNms5STsxWYCke4x5XfM2vss4xafXg/7a5GpaRATDtBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577028; c=relaxed/simple;
	bh=ot8JkML1Fqa96U4hnnt/WSVq5bQRymqWbaW1RAWEIHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN7oAneT1/RfXyFO/eoxv402/B2yzn9Z14bvgmZENtJqZWaAaoQzI1HI7lI1bFBx7vZTm77qhIFe+JwmY5j1twx8+FFR7rqxN1nFMWWthaSM3zGS1/MSa3KnNrytNBTqlgt8h8LtlO7qXoVLmPk58qrzaSO0WD/HrN0yNmuc5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YrdubiW6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=642OnAXe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGBLBPeB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpD/7k0h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23B54211A7;
	Thu, 14 Nov 2024 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731577024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/bOqQRVse3V0lUYD/zC6I5Ky+/oax4QI/e1pHiBRlA=;
	b=YrdubiW6pnUwpwf8dIP8SCkhgwZftQCv9Dq5HOxGN+9NPyCcm8UX2cQIoQ+nVd9KInM/vk
	89D1XChwrqVVfqJFbD5ZmeKzP8riD1zDlDAtZWCNUQHTJfyRKPLmcInQjDytaQOE6IQ/T0
	gn/a65+VOL/TS8H5v/z1H9Yut/CAzV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731577024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/bOqQRVse3V0lUYD/zC6I5Ky+/oax4QI/e1pHiBRlA=;
	b=642OnAXen5oB52fu4j7vyKxD4k3x7GE0gevo+W2sv8F7ckMyH42eZ12h45R1o2sdwaNhyM
	1Se7gxrMH7lnCtBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QGBLBPeB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dpD/7k0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731577022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/bOqQRVse3V0lUYD/zC6I5Ky+/oax4QI/e1pHiBRlA=;
	b=QGBLBPeBcMpqtCiQXWy5TxEe9w0xsQ8gKvHgghEBfnEL9Io+z4ovk+ghx2B2pG+Mu1o0sJ
	0q67Vi7BprdelLOp+0PJPQ42H++tm1xKeOUHp14HxQQLZgbkWYVbv4TCiQyjf1VepNy9A7
	8Yt3K85GUWVPNMT4SyNfEMM1kTgakQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731577022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/bOqQRVse3V0lUYD/zC6I5Ky+/oax4QI/e1pHiBRlA=;
	b=dpD/7k0hqEbDgtFSBY5WJ1O4WfK4rUmCFlEtrW1rtSFbvZ2/wF9oykOQk4zHfq6J9HGUyU
	dPFNGrcE6zpw+8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 125F313794;
	Thu, 14 Nov 2024 09:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +wT5A77ENWf1DwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 09:37:02 +0000
Message-ID: <6b055821-ce14-4a6d-959c-25ade4a9bfd7@suse.cz>
Date: Thu, 14 Nov 2024 10:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/compaction: remove unnecessary detection code.
Content-Language: en-US
To: Kemeng Shi <shikemeng@huaweicloud.com>,
 Qiang Liu <liuq131@chinatelecom.cn>, baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241114065720.3665-1-liuq131@chinatelecom.cn>
 <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
 <56ee8988-fd25-76bf-08a8-b84732fd2170@huaweicloud.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <56ee8988-fd25-76bf-08a8-b84732fd2170@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 23B54211A7
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/14/24 10:21, Kemeng Shi wrote:
> 
> Hello
> on 11/14/2024 3:44 PM, Vlastimil Babka wrote:
>> On 11/14/24 07:57, Qiang Liu wrote:
>>> It is impossible for the situation where blockpfn > end_pfn to arise,
>>> The if statement here is not only unnecessary, but may also lead to
>>> a misunderstanding that blockpfn > end_pfn could potentially happen.
>>> so these unnecessary checking code should be removed.
>>>
>>> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
>> 
> As stride could 32, if isolate_freepages_range() is called with start_pfn not
> aligned with 32, we could bail out look with blockpfn > end_pfn in
> isolate_freepages_block(). Please correct if I miss something.
>> I see that's since 3da0272a4c7d ("mm/compaction: correctly return failure
>> with bogus compound_order in strict mode")
>> 
>> I think that commit introduced a risk of overflow due to a bogus order
>> (which we read in a racy way), and once blockpfn overflows it will satisfy
>> <= end_pfn and might e.g. end up scanning a completely different zone?
>> 
>>                         if (blockpfn + (1UL << order) <= end_pfn) {
>> 
>>                                 blockpfn += (1UL << order) - 1;
>>                                 page += (1UL << order) - 1;
>>                                 nr_scanned += (1UL << order) - 1;
>>                         }
>> 
>> We should better add back the MAX_ORDER sanity check?
> As order of pageblock is <= MAX_ORDER, if bogus order is > MAX_ORDER, then
> blockpfn + (1UL << order) must be > end_pfn, I think the sanity check is
> not needed.
Hm I guess we could only overflow with blockpfn being initially >= 1UL << 63
and reading a bogus order of 63.
So it can't realistically happen.

> Thanks.
> Kemeng
>> 
>>> ---
>>>  mm/compaction.c | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index a2b16b08cbbf..baeda7132252 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>>  	if (locked)
>>>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>>>  
>>> -	/*
>>> -	 * Be careful to not go outside of the pageblock.
>>> -	 */
>>> -	if (unlikely(blockpfn > end_pfn))
>>> -		blockpfn = end_pfn;
>>> -
>>>  	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>>>  					nr_scanned, total_isolated);
>>>  
>> 
> 


