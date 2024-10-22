Return-Path: <linux-kernel+bounces-376124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C69AA064
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D6283829
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA6199EB7;
	Tue, 22 Oct 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebQhSo8r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMEJyFwb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebQhSo8r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMEJyFwb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0133198838
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594400; cv=none; b=Uni6Kfgv9IO3HMwg4eQYDAAxn88EoERUzSk3MR4ENx++VgoJ7J0TYJU6Y59D+yv331YZyEO/7rnohO/3bxXWFKPybHjkAWNHjN2k8TZ6tukrZ+FCBZNT9fnlmtKNl4DuFvErkevD4WA1d/Ik2omoVYJiCt27rggjYYwBOKbp/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594400; c=relaxed/simple;
	bh=J97Xn19QEdCI3ZnpgOOQkD6GN71Ke/zsW7Db16rtF6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNWDEgg+M5oLr661FK99WtP6KNL2C52a2HOicDFQ0xUjzv2KLGY7dE+kjJht+mUTajEYodLiimIuyCgOUsYRDkaNLnwJ+Ecm3K31g104iTW4OAfGIk7xbzM7/0/Q23oaxqLyy5irrcK+hdDpRETv6K3bLCQRQ6FGLn1qpHy5H/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebQhSo8r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMEJyFwb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebQhSo8r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMEJyFwb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C98581FBBC;
	Tue, 22 Oct 2024 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729594395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMW+K6rUQg/2azU5UZpb7HQSGIwUBL2V/U6CHfSO/2E=;
	b=ebQhSo8rNsPES7IQTs+ZrGw33maldAHJvOZnIBrvVXRBsSvj9u9EEXRYtQixS7cYsKqfj9
	qjZpSiLDaeCppWZHTUaTiev0MfhNXpqn7A9yBKDnh6A0OlzmYw0e0qbVFsQhOdVPugVm8I
	tRHIkd4McvM4LfFEzVR4fCzUzdP0Do0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729594395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMW+K6rUQg/2azU5UZpb7HQSGIwUBL2V/U6CHfSO/2E=;
	b=YMEJyFwbds9mO3ZyDM+2bgfLUU0iIpNqbsjYAgqyHSB+o0Oql6tJSa0Qw7Cr0RiBEuH0U8
	b8jP1etz1Rvkk9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729594395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMW+K6rUQg/2azU5UZpb7HQSGIwUBL2V/U6CHfSO/2E=;
	b=ebQhSo8rNsPES7IQTs+ZrGw33maldAHJvOZnIBrvVXRBsSvj9u9EEXRYtQixS7cYsKqfj9
	qjZpSiLDaeCppWZHTUaTiev0MfhNXpqn7A9yBKDnh6A0OlzmYw0e0qbVFsQhOdVPugVm8I
	tRHIkd4McvM4LfFEzVR4fCzUzdP0Do0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729594395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMW+K6rUQg/2azU5UZpb7HQSGIwUBL2V/U6CHfSO/2E=;
	b=YMEJyFwbds9mO3ZyDM+2bgfLUU0iIpNqbsjYAgqyHSB+o0Oql6tJSa0Qw7Cr0RiBEuH0U8
	b8jP1etz1Rvkk9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B34CC13894;
	Tue, 22 Oct 2024 10:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f5J1KxuEF2eKKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Oct 2024 10:53:15 +0000
Message-ID: <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
Date: Tue, 22 Oct 2024 12:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Matt Fleming <mfleming@cloudflare.com>
References: <20241020051315.356103-1-yuzhao@google.com>
 <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZxaOo59ZwXoCduhG@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

+Cc Mel and Matt

On 10/21/24 19:25, Michal Hocko wrote:
> On Mon 21-10-24 11:10:50, Yu Zhao wrote:
>> On Mon, Oct 21, 2024 at 2:13 AM Michal Hocko <mhocko@suse.com> wrote:
>> >
>> > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
>> > > OOM kills due to vastly overestimated free highatomic reserves were
>> > > observed:
>> > >
>> > >   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>> > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>> > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
>> > >
>> > > The second line above shows that the OOM kill was due to the following
>> > > condition:
>> > >
>> > >   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
>> > >
>> > > And the third line shows there were no free pages in any
>> > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
>> > > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
>> > > highatomic reserves. IOW, it underestimated the usable free memory by
>> > > over 1GB, which resulted in the unnecessary OOM kill.
>> >
>> > Why doesn't unreserve_highatomic_pageblock deal with this situation?
>> 
>> The current behavior of unreserve_highatomic_pageblock() seems WAI to
>> me: it unreserves highatomic pageblocks that contain *free* pages so

Hm I don't think it's completely WAI. The intention is that we should be
able to unreserve the highatomic pageblocks before going OOM, and there
seems to be an unintended corner case that if the pageblocks are fully
exhausted, they are not reachable for unreserving. The nr_highatomic is then
also fully misleading as it prevents allocations due to a limit that does
not reflect reality. Your patch addresses the second issue, but there's a
cost to it when calculating the watermarks, and it would be better to
address the root issue instead.

>> that those pages can become usable to others. There is nothing to
>> unreserve when they have no free pages.

Yeah there are no actual free pages to unreserve, but unreserving would fix
the nr_highatomic overestimate and thus allow allocations to proceed.

> I do not follow. How can you have reserved highatomic pages of that size
> without having page blocks with free memory. In other words is this an
> accounting problem or reserves problem? This is not really clear from
> your description.

I think it's the problem of finding the highatomic pageblocks for
unreserving them once they become full. The proper fix is not exactly
trivial though. Either we'll have to scan for highatomic pageblocks in the
pageblock bitmap, or track them using an additional data structure.

