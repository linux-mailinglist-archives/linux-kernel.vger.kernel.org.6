Return-Path: <linux-kernel+bounces-408833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C19C841C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F01CB22326
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCE1F472D;
	Thu, 14 Nov 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KvXhpM9n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8DuN7de";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KvXhpM9n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8DuN7de"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964B1F12E2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570284; cv=none; b=MiaGA2GVx9bcXC2edEicS5vEFgmdARbjbxc178FEL7ZCENZcGo+8FWS+5V4bIdyvSe1OtHsR8m4Yj0LucOgB0CAPGsCMLKQ5zkXYg7KrBTrzqqjyXnVAKHFPCl+VEJAkmXEFkMCRW7gRn9NajPRLzlIrd/ieN7IWNRCgF0OQ6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570284; c=relaxed/simple;
	bh=76+laxi71szSqZHTArZ3nlAa8xZxihpVSFg6xLyHpAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlYwbNmm9dBXLdyH+hNhGs75wtojy51ozs63EsPtMEgDtZO7VqhHweRx1O3Ja5ugABULXbva+Vd6L9Ik/REDYxixbbuX45CZ0EQuP3TpatOC7BXN3WLwPOfW4jmgRlo74Y1R/+d0A9V+OD3O8kLJPPp3v5lFyWJRQjtiLnPJ6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KvXhpM9n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8DuN7de; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KvXhpM9n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8DuN7de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD7411F833;
	Thu, 14 Nov 2024 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731570280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEq6GOjMtUumBIerpcKh1fl/SSTpDSSKy97e39FJA+Q=;
	b=KvXhpM9nCp8KXz4DOeea3AjaJnZ9YfYOkuTHv3iTr2YajRVCd+C1CHcFf6KntGTRixuwpX
	aUCtzODk276tGS99u7oOERgKromx1fmhXKA3UXX/5ewxaYlSUDl2CrPJsyGEVngqez8OUY
	8x3Ut3tLJKagd5q2PQ3XIC0br5XUYok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731570280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEq6GOjMtUumBIerpcKh1fl/SSTpDSSKy97e39FJA+Q=;
	b=O8DuN7depD4yJZCiDSxmEds+usAK/UrGVzyMeq+xYkfAE3ezWDCsdatSDmeWtsKoq9z62Q
	fox4bBT8gE1w7DBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731570280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEq6GOjMtUumBIerpcKh1fl/SSTpDSSKy97e39FJA+Q=;
	b=KvXhpM9nCp8KXz4DOeea3AjaJnZ9YfYOkuTHv3iTr2YajRVCd+C1CHcFf6KntGTRixuwpX
	aUCtzODk276tGS99u7oOERgKromx1fmhXKA3UXX/5ewxaYlSUDl2CrPJsyGEVngqez8OUY
	8x3Ut3tLJKagd5q2PQ3XIC0br5XUYok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731570280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEq6GOjMtUumBIerpcKh1fl/SSTpDSSKy97e39FJA+Q=;
	b=O8DuN7depD4yJZCiDSxmEds+usAK/UrGVzyMeq+xYkfAE3ezWDCsdatSDmeWtsKoq9z62Q
	fox4bBT8gE1w7DBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A720B13794;
	Thu, 14 Nov 2024 07:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fZk3KGiqNWeFaAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 07:44:40 +0000
Message-ID: <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
Date: Thu, 14 Nov 2024 08:44:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/compaction: remove unnecessary detection code.
To: Qiang Liu <liuq131@chinatelecom.cn>, baolin.wang@linux.alibaba.com,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241114065720.3665-1-liuq131@chinatelecom.cn>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241114065720.3665-1-liuq131@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/14/24 07:57, Qiang Liu wrote:
> It is impossible for the situation where blockpfn > end_pfn to arise,
> The if statement here is not only unnecessary, but may also lead to
> a misunderstanding that blockpfn > end_pfn could potentially happen.
> so these unnecessary checking code should be removed.
> 
> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>

I see that's since 3da0272a4c7d ("mm/compaction: correctly return failure
with bogus compound_order in strict mode")

I think that commit introduced a risk of overflow due to a bogus order
(which we read in a racy way), and once blockpfn overflows it will satisfy
<= end_pfn and might e.g. end up scanning a completely different zone?

                        if (blockpfn + (1UL << order) <= end_pfn) {

                                blockpfn += (1UL << order) - 1;
                                page += (1UL << order) - 1;
                                nr_scanned += (1UL << order) - 1;
                        }

We should better add back the MAX_ORDER sanity check?

> ---
>  mm/compaction.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a2b16b08cbbf..baeda7132252 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  	if (locked)
>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>  
> -	/*
> -	 * Be careful to not go outside of the pageblock.
> -	 */
> -	if (unlikely(blockpfn > end_pfn))
> -		blockpfn = end_pfn;
> -
>  	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>  					nr_scanned, total_isolated);
>  


