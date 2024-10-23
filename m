Return-Path: <linux-kernel+bounces-377551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7982C9AC067
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ABE281B65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34A154C04;
	Wed, 23 Oct 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WKXSi68d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q83Gw9h+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WKXSi68d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q83Gw9h+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A785154457
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668903; cv=none; b=UBGatEprCTAk4tSaMPXgKWu34+bXCMZB8h3G+76OARikZde0CvsmaWG4MxNgLQNumQTxKdXWC3qvdeW1p4eQX4gQQFSNgKaYBEwwo4tn4krmjS1hMnzU3VPhy7Op1dosmqV84Ymzqp9PbDgp+SA0KzeQPx9Nq+n4hUGufU/fgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668903; c=relaxed/simple;
	bh=PT1TfpWkPt+GgNr1MAYTefb5Q/XTyMxtP6L57xT22Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbdnW6GVFzSh8Zf378HGYUz59xjvc7dFzhXiz+7WcyyEGecVvoE2pjJDzQjOAt5d5vrEBYSfTa2/7fkCXfIzSgNmA0IZyNz2pAX69WZ/QFQL4FtgEXFJ23NtiXIFspwuw5feCX+MvDSrfdaUI2C6JsoJryuB9kXr0EBVgLQgsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WKXSi68d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q83Gw9h+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WKXSi68d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q83Gw9h+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92FF91F7A1;
	Wed, 23 Oct 2024 07:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729668899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZIdhv9BeZcI+mn12fiemly8KbslTq+qKAU4CBI1fRE=;
	b=WKXSi68drJAB0m+75Bmg1QuH/xhWWp8yXf5+nsxMOzrxBA4clNilfCLsIiQWi7IAvLUl0A
	qp7UC0uG0ePxwKWUWrp2p2ld8mwZJwe5RtjA3eIry91zXc4Mn+KfI3GYRerY6NYE5EXu72
	F57GGxZFtl05sl7bnn8YQlfKEfahfiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729668899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZIdhv9BeZcI+mn12fiemly8KbslTq+qKAU4CBI1fRE=;
	b=Q83Gw9h+djmUsQLuQCoauSzPlghBxzYKZvAsQRWystZgqpArVAsOSLBUc1Wmo5cfNLb/vX
	6hKB7bxWKTttfTAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WKXSi68d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q83Gw9h+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729668899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZIdhv9BeZcI+mn12fiemly8KbslTq+qKAU4CBI1fRE=;
	b=WKXSi68drJAB0m+75Bmg1QuH/xhWWp8yXf5+nsxMOzrxBA4clNilfCLsIiQWi7IAvLUl0A
	qp7UC0uG0ePxwKWUWrp2p2ld8mwZJwe5RtjA3eIry91zXc4Mn+KfI3GYRerY6NYE5EXu72
	F57GGxZFtl05sl7bnn8YQlfKEfahfiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729668899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZIdhv9BeZcI+mn12fiemly8KbslTq+qKAU4CBI1fRE=;
	b=Q83Gw9h+djmUsQLuQCoauSzPlghBxzYKZvAsQRWystZgqpArVAsOSLBUc1Wmo5cfNLb/vX
	6hKB7bxWKTttfTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E29113AD3;
	Wed, 23 Oct 2024 07:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+0eGiOnGGdCBwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Oct 2024 07:34:59 +0000
Message-ID: <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
Date: Wed, 23 Oct 2024 09:34:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Yu Zhao <yuzhao@google.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Link Lin
 <linkl@google.com>, Mel Gorman <mgorman@techsingularity.net>,
 Matt Fleming <mfleming@cloudflare.com>
References: <20241020051315.356103-1-yuzhao@google.com>
 <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
 <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92FF91F7A1
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,suse.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/23/24 08:36, Yu Zhao wrote:
> On Tue, Oct 22, 2024 at 4:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> +Cc Mel and Matt
>>
>> On 10/21/24 19:25, Michal Hocko wrote:
>> > On Mon 21-10-24 11:10:50, Yu Zhao wrote:
>> >> On Mon, Oct 21, 2024 at 2:13 AM Michal Hocko <mhocko@suse.com> wrote:
>> >> >
>> >> > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
>> >> > > OOM kills due to vastly overestimated free highatomic reserves were
>> >> > > observed:
>> >> > >
>> >> > >   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>> >> > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>> >> > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
>> >> > >
>> >> > > The second line above shows that the OOM kill was due to the following
>> >> > > condition:
>> >> > >
>> >> > >   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
>> >> > >
>> >> > > And the third line shows there were no free pages in any
>> >> > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
>> >> > > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
>> >> > > highatomic reserves. IOW, it underestimated the usable free memory by
>> >> > > over 1GB, which resulted in the unnecessary OOM kill.
>> >> >
>> >> > Why doesn't unreserve_highatomic_pageblock deal with this situation?
>> >>
>> >> The current behavior of unreserve_highatomic_pageblock() seems WAI to
>> >> me: it unreserves highatomic pageblocks that contain *free* pages so
>>
>> Hm I don't think it's completely WAI. The intention is that we should be
>> able to unreserve the highatomic pageblocks before going OOM, and there
>> seems to be an unintended corner case that if the pageblocks are fully
>> exhausted, they are not reachable for unreserving.
> 
> I still think unreserving should only apply to highatomic PBs that
> contain free pages. Otherwise, it seems to me that it'd be
> self-defecting because:
> 1. Unreserving fully used hightatomic PBs can't fulfill the alloc
> demand immediately.

I thought the alloc demand is only blocked on the pessimistic watermark
calculation. Usable free pages exist, but the allocation is not allowed to
use them.

> 2. More importantly, it only takes one alloc failure in
> __alloc_pages_direct_reclaim() to reset nr_reserved_highatomic to 2MB,
> from as high as 1% of a zone (in this case 1GB). IOW, it makes more
> sense to me that highatomic only unreserves what it doesn't fully use
> each time unreserve_highatomic_pageblock() is called, not everything
> it got (except the last PB).

But if the highatomic pageblocks are already full, we are not really
removing any actual highatomic reserves just by changing the migratetype and
decreasing nr_reserved_highatomic? In fact that would allow the reserves
grow with some actual free pages in the future.

> Also not reachable from free_area[] isn't really a big problem. There
> are ways to solve this without scanning the PB bitmap.

Sure, if we agree it's the way to go.

>> The nr_highatomic is then
>> also fully misleading as it prevents allocations due to a limit that does
>> not reflect reality.
> 
> Right, and the comments warn about this.

Yes and explains it's to avoid the cost of searching free lists. Your fix
introduces that cost and that's not really great for a watermark check fast
path. I'd rather move the cost to highatomic unreserve which is not a fast path.

>> Your patch addresses the second issue, but there's a
>> cost to it when calculating the watermarks, and it would be better to
>> address the root issue instead.
> 
> Theoretically, yes. And I don't think it's actually measurable
> considering the paths (alloc/reclaim) we are in -- all the data
> structures this patch accesses should already have been cache-hot, due
> to unreserve_highatomic_pageblock(), etc.

__zone_watermark_unusable_free() will be executed from every allocation's
fast path, and not only after we recently did
unreserve_highatomic_pageblock(). AFAICS as soon as nr_reserved_highatomic
is over pageblock_nr_pages we'll unconditionally start counting precisely
and the design wanted to avoid this.

> Also, we have not agreed on the root cause yet.
> 
>> >> that those pages can become usable to others. There is nothing to
>> >> unreserve when they have no free pages.
>>
>> Yeah there are no actual free pages to unreserve, but unreserving would fix
>> the nr_highatomic overestimate and thus allow allocations to proceed.
> 
> Yes, but honestly, I think this is going to cause regression in
> highatomic allocs.

I think not as having more realistic counter of what's actually reserved
(and not already used up) can also allow reserving new pageblocks.

>> > I do not follow. How can you have reserved highatomic pages of that size
>> > without having page blocks with free memory. In other words is this an
>> > accounting problem or reserves problem? This is not really clear from
>> > your description.
>>
>> I think it's the problem of finding the highatomic pageblocks for
>> unreserving them once they become full. The proper fix is not exactly
>> trivial though. Either we'll have to scan for highatomic pageblocks in the
>> pageblock bitmap, or track them using an additional data structure.
> 
> Assuming we want to unreserve fully used hightatomic PBs, we wouldn't
> need to scan for them or track them. We'd only need to track the delta
> between how many we want to unreserve (full or not) and how many we
> are able to do so. The first page freed in a PB that's highatomic
> would need to try to reduce the delta by changing the MT.

Hm that assumes we're adding some checks in free fastpath, and for that to
work also that there will be a freed page in highatomic PC in near enough
future from the decision we need to unreserve something. Which is not so
much different from the current assumption we'll find such a free page
already in the free list immediately.

> To summarize, I think this is an estimation problem, which I would
> categorize as a lesser problem than accounting problems. But it sounds
> to me that you think it's a policy problem, i.e., the highatomic
> unreserving policy is wrong or not properly implemented?

Yeah I'd say not properly implemented, but that sounds like a mechanism, not
policy problem to me :)

