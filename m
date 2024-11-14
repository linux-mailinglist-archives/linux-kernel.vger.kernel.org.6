Return-Path: <linux-kernel+bounces-408852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF219C8452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C771F23955
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255B1EF09F;
	Thu, 14 Nov 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9gHOWmE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZgF7dN7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9gHOWmE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZgF7dN7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95211EABAB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570745; cv=none; b=IiRe8NFUYULzOUXV1bdbn1eEPrxbL2QaQqMsaJ4GLBFJ36WzNcoJOcbab7UtnGASxpCVVcoKQSSPWCLiIp8m5H7/k977GI0Fsd6GbK5iDR8nYBmt5xEVGKNXSqKsVkMCMaQM1SmfiYHfXnkXsIeqqmWT46lHKpXWYS029w0zkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570745; c=relaxed/simple;
	bh=YvIPzQ4ESV2et8xD4F+yHEJAVV77Z3dmui/A1sUlMok=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f9kB7CfWqu9DTT/BrP9QIl2RflXwLLyWXK2MsISC3Yk4XSpvVLrd3M+fqDAzwlj4ucMSimgNWNARg+Ok1OpH2JsiLGVfBfqi4mxPideshiC0qwejYXb49khHfq1Z5OCjTR7RV+gOitspmg//wzzg4RG1t9/TyehBBXKTEKd2Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9gHOWmE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZgF7dN7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9gHOWmE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZgF7dN7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0364121979;
	Thu, 14 Nov 2024 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731570741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQ4uIaR8EC9zCCXZjp5UewO6FD29d7j31WBEEqB9OUE=;
	b=V9gHOWmEwuYU+gnLWkvmJaIW/JmbOZwdhPDN5DBf46No1EWIL2/j6h41yunv+VN6dohw1M
	nBLPI631VJwHupvkdkOpS+9P/CJIk/QmPRDUP4zFOg993eqlq/lv3D90WpFiqE70Gi7IfH
	SZ2dWu69Nh8A+2WGs8Zt5JDqtHbe0ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731570741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQ4uIaR8EC9zCCXZjp5UewO6FD29d7j31WBEEqB9OUE=;
	b=qZgF7dN7+fjEBlLo4+PFJSqGil1iQivj/EqGBNB3qpQW6g+Pg88wHOKO2/Pjq/gjEk4sE4
	JYjb5AD8Y/FJEDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731570741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQ4uIaR8EC9zCCXZjp5UewO6FD29d7j31WBEEqB9OUE=;
	b=V9gHOWmEwuYU+gnLWkvmJaIW/JmbOZwdhPDN5DBf46No1EWIL2/j6h41yunv+VN6dohw1M
	nBLPI631VJwHupvkdkOpS+9P/CJIk/QmPRDUP4zFOg993eqlq/lv3D90WpFiqE70Gi7IfH
	SZ2dWu69Nh8A+2WGs8Zt5JDqtHbe0ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731570741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQ4uIaR8EC9zCCXZjp5UewO6FD29d7j31WBEEqB9OUE=;
	b=qZgF7dN7+fjEBlLo4+PFJSqGil1iQivj/EqGBNB3qpQW6g+Pg88wHOKO2/Pjq/gjEk4sE4
	JYjb5AD8Y/FJEDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E336F13794;
	Thu, 14 Nov 2024 07:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g3nYNjSsNWf+agAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 07:52:20 +0000
Message-ID: <f1cdc0e0-6704-4dc4-a3cf-158fc867db56@suse.cz>
Date: Thu, 14 Nov 2024 08:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/compaction: remove unnecessary detection code.
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Qiang Liu <liuq131@chinatelecom.cn>, baolin.wang@linux.alibaba.com,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241114065720.3665-1-liuq131@chinatelecom.cn>
 <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/14/24 08:44, Vlastimil Babka wrote:
> On 11/14/24 07:57, Qiang Liu wrote:
>> It is impossible for the situation where blockpfn > end_pfn to arise,
>> The if statement here is not only unnecessary, but may also lead to
>> a misunderstanding that blockpfn > end_pfn could potentially happen.
>> so these unnecessary checking code should be removed.
>> 
>> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
> 
> I see that's since 3da0272a4c7d ("mm/compaction: correctly return failure
> with bogus compound_order in strict mode")

Hm but we still have:

for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {

and this advance by stride can mix up with advance by isolated, initial pfn
might not be aligned... I don't see any guarantee that the for loop will
exit with exactly blockpfn == end_pfn, it may easily advance beyond end_pfn
so we shouldn't remove the check?

> I think that commit introduced a risk of overflow due to a bogus order
> (which we read in a racy way), and once blockpfn overflows it will satisfy
> <= end_pfn and might e.g. end up scanning a completely different zone?
> 
>                         if (blockpfn + (1UL << order) <= end_pfn) {
> 
>                                 blockpfn += (1UL << order) - 1;
>                                 page += (1UL << order) - 1;
>                                 nr_scanned += (1UL << order) - 1;
>                         }
> 
> We should better add back the MAX_ORDER sanity check?
> 
>> ---
>>  mm/compaction.c | 6 ------
>>  1 file changed, 6 deletions(-)
>> 
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index a2b16b08cbbf..baeda7132252 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>  	if (locked)
>>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>>  
>> -	/*
>> -	 * Be careful to not go outside of the pageblock.
>> -	 */
>> -	if (unlikely(blockpfn > end_pfn))
>> -		blockpfn = end_pfn;
>> -
>>  	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>>  					nr_scanned, total_isolated);
>>  
> 
> 


