Return-Path: <linux-kernel+bounces-379458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5299ADED7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408951C20294
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1F1B21A5;
	Thu, 24 Oct 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OBubRTSL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfFMJNI/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OBubRTSL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfFMJNI/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BB1B219D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757782; cv=none; b=rsyi6sUqzW54N4DiGhVLc2kbXK09hvkv7NV2Vu23rv7CxcYu84WLJ0PQrvjgzKyBakmDptvE4pYfDIfZLOGYVSPJMdp41FaTD8aO1pQ03rbgSdMuuFV5gGp86upbQke9+s0uf/bblDPb9BzUHHqDx9TDhbEuBr82Sss2eFO5z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757782; c=relaxed/simple;
	bh=eqjuAh8tpKAwsPdkNztKv8T09eMW1BKep8ZIYGlNmFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2kf7wu/boGlpbCg6HnlC0/7xNV27UMnhrsjWD+5oHZz0JycM92rm063XsctAWapf0J06PAM+Fyo35lWPdTjIlmtAW3RdgE6Kme4gCS0Z04mjKf+VgikzeK9nzU50vPiL0OO1ANTugDAeiy6nUYtlmnw6F6HFYbi5AQq71gkjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OBubRTSL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfFMJNI/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OBubRTSL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfFMJNI/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F5F11FB7F;
	Thu, 24 Oct 2024 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729757773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUdyD45o51oSv9e/roIlQ1/uAhabhz3IoBa7KyPYKD4=;
	b=OBubRTSLGYYlVzpN7006ePYeCVtBGuGdJzoDNFmWMsojvupyN8gKAWRnz1I2b92dvQiGZx
	ISlgdLuKGl44++buPKpvfahJj88fOk7AnWr6dWWKMArLa+TMkyYIQWRTXhqYpR9bBi2IxU
	XFZoHIZ4QdwbU20wkmnUo16owNDGIfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729757773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUdyD45o51oSv9e/roIlQ1/uAhabhz3IoBa7KyPYKD4=;
	b=QfFMJNI/89VQKpVRvQudPPH7n14UWsG4ZzfLGOmqWo5Cw19EmvxdsXPkVBayLNVunYqs6F
	ix2NauhQWr6wEvAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OBubRTSL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="QfFMJNI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729757773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUdyD45o51oSv9e/roIlQ1/uAhabhz3IoBa7KyPYKD4=;
	b=OBubRTSLGYYlVzpN7006ePYeCVtBGuGdJzoDNFmWMsojvupyN8gKAWRnz1I2b92dvQiGZx
	ISlgdLuKGl44++buPKpvfahJj88fOk7AnWr6dWWKMArLa+TMkyYIQWRTXhqYpR9bBi2IxU
	XFZoHIZ4QdwbU20wkmnUo16owNDGIfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729757773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUdyD45o51oSv9e/roIlQ1/uAhabhz3IoBa7KyPYKD4=;
	b=QfFMJNI/89VQKpVRvQudPPH7n14UWsG4ZzfLGOmqWo5Cw19EmvxdsXPkVBayLNVunYqs6F
	ix2NauhQWr6wEvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28D66136F5;
	Thu, 24 Oct 2024 08:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /f2XCU0CGmfcMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Oct 2024 08:16:13 +0000
Message-ID: <b594795a-7f26-4c0d-80f4-88d242fdc0fb@suse.cz>
Date: Thu, 24 Oct 2024 10:16:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Yu Zhao <yuzhao@google.com>, Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Link Lin
 <linkl@google.com>, Matt Fleming <mfleming@cloudflare.com>
References: <20241020051315.356103-1-yuzhao@google.com>
 <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
 <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com>
 <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
 <CAOUHufb=Ze1pj2BeasCLYpAvOhBQfKXcz678Zo_==9DeMbgT9Q@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAOUHufb=Ze1pj2BeasCLYpAvOhBQfKXcz678Zo_==9DeMbgT9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F5F11FB7F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/24/24 06:35, Yu Zhao wrote:
> On Wed, Oct 23, 2024 at 1:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/23/24 08:36, Yu Zhao wrote:
>> > On Tue, Oct 22, 2024 at 4:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >>
>> >> +Cc Mel and Matt
>> >>
>> >> On 10/21/24 19:25, Michal Hocko wrote:
>> >>
>> >> Hm I don't think it's completely WAI. The intention is that we should be
>> >> able to unreserve the highatomic pageblocks before going OOM, and there
>> >> seems to be an unintended corner case that if the pageblocks are fully
>> >> exhausted, they are not reachable for unreserving.
>> >
>> > I still think unreserving should only apply to highatomic PBs that
>> > contain free pages. Otherwise, it seems to me that it'd be
>> > self-defecting because:
>> > 1. Unreserving fully used hightatomic PBs can't fulfill the alloc
>> > demand immediately.
>>
>> I thought the alloc demand is only blocked on the pessimistic watermark
>> calculation. Usable free pages exist, but the allocation is not allowed to
>> use them.
> 
> I think we are talking about two different problems here:
> 1. The estimation problem.
> 2. The unreserving policy problem.
> 
> What you said here is correct w.r.t. the first problem, and I was
> talking about the second problem.

OK but the problem with unreserving currently makes the problem of
estimation worse and unfixable.

>> > 2. More importantly, it only takes one alloc failure in
>> > __alloc_pages_direct_reclaim() to reset nr_reserved_highatomic to 2MB,
>> > from as high as 1% of a zone (in this case 1GB). IOW, it makes more
>> > sense to me that highatomic only unreserves what it doesn't fully use
>> > each time unreserve_highatomic_pageblock() is called, not everything
>> > it got (except the last PB).
>>
>> But if the highatomic pageblocks are already full, we are not really
>> removing any actual highatomic reserves just by changing the migratetype and
>> decreasing nr_reserved_highatomic?
> 
> If we change the MT, they can be fragmented a lot faster, i.e., from
> the next near OOM condition to upon becoming free. Trying to persist
> over time is what actually makes those PBs more fragmentation
> resistant.

If we assume the allocations there have similar sizes and lifetimes, then I
guess yeah.

>> In fact that would allow the reserves
>> grow with some actual free pages in the future.
> 
> Good point. I think I can explain it better along this line.
> 
> If highatomic is under the limit, both your proposal and the current
> implementation would try to grow, making not much difference. However,
> the current implementation can also reuse previously full PBs when
> they become available. So there is a clear winner here: the current
> implementation.

I'd say it depends on the user of the highatomic blocks (the workload),
which way ends up better.

> If highatomic has reached the limit, with your proposal, the growth
> can only happen after unreserve, and unreserve only happens under
> memory pressure. This means it's likely that it tries to grow under
> memory pressure, which is more difficult than the condition where
> there is plenty of memory. For the current implementation, it doesn't
> try to grow, rather, it keeps what it already has, betting those full
> PBs becoming available for reuse. So I don't see a clear winner
> between trying to grow under memory pressure and betting on becoming
> available for reuse.

Understood. But also note there are many conditions where the current
implementation and my proposal behave the same. If highatomic pageblocks
become full and then only one or few pages from each is freed, it suddenly
becomes possible to unreserve them due to memory pressure, and there is no
reuse for those highatomic allocations anymore. This very different outcome
only depends on whether a single page is free for the unreserve to work, but
from the efficiency of pageblock reusal you describe above a single page is
only a minor difference. My proposal would at least remove the sudden change
of behavior when going from a single free page to no free page.

>> Hm that assumes we're adding some checks in free fastpath, and for that to
>> work also that there will be a freed page in highatomic PC in near enough
>> future from the decision we need to unreserve something. Which is not so
>> much different from the current assumption we'll find such a free page
>> already in the free list immediately.
>>
>> > To summarize, I think this is an estimation problem, which I would
>> > categorize as a lesser problem than accounting problems. But it sounds
>> > to me that you think it's a policy problem, i.e., the highatomic
>> > unreserving policy is wrong or not properly implemented?
>>
>> Yeah I'd say not properly implemented, but that sounds like a mechanism, not
>> policy problem to me :)
> 
> What about adding a new counter to keep track of the size of free
> pages reserved for highatomic?

That's doable but not so trivial and means starting to handle the highatomic
pageblocks much more carefully, like we do with CMA pageblocks and
NR_FREE_CMA_PAGES counter, otherwise we risk drifting the counter unrecoverably.

> Mel?


