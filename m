Return-Path: <linux-kernel+bounces-384782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B968A9B2E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6D0B23577
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462C1D95AA;
	Mon, 28 Oct 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdQsWPUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tw695dtk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdQsWPUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tw695dtk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14D1D5178
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113278; cv=none; b=Mv62Q8lMaAg/HNNe8CeGxRE1WTvnVRUGGAXTYV+uL3gmxpLf+CV7JKCM/HFJS+yMWukoZSC6Je3/ita5aOKCV8du8v27S/OqiPZJ19VMFxMVWKvdznr4InhKMNgTHmWcef1SXUj0unn1D7m0RRBYOoISXEP1pKC+mDrqqyas6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113278; c=relaxed/simple;
	bh=4AvCjYyEYWBCxN6UTZy/b2uJDHjMdjZ3KenXLcf+q4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CukSNGYOkdELhpLj/LB5Zo6bYzYmeaBDlu6hMQE671RQ6R4yqxTKa7LNf62e4AgyOz7PpJX1+k0Wql53OkfvrSkPYTt+uBRMYug5FbudBq23avFFmpjZApNt3QqI1MGM3NG3QpWxxkzYPFCx45/FWDuwM4Aaf1xZeJdJmIkYcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdQsWPUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tw695dtk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdQsWPUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tw695dtk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05637219FB;
	Mon, 28 Oct 2024 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730113274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPErEHvWrwDTtY0/hCiF+bKl1VxPwxAdWFCd/773/fs=;
	b=GdQsWPUhXwTNbduKQKsBCapXTFfekkye0woEwDyJJ6mudy7c/ujKVYPeaXrqHe9/Epz4ha
	IvfJDOfdIkctlZaiZ69C+1w5YBJ3qCVKsbo5IWBB7kfK8TwEmRHihW6exqLM6TJT5PLlGJ
	cJH3JrEoJCJdyTZWMCV/L6lj69kyEPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730113274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPErEHvWrwDTtY0/hCiF+bKl1VxPwxAdWFCd/773/fs=;
	b=Tw695dtkgNrxC3d+ujvpGV+T6UkZS4gXHMSZZ1bnwvyboFJOC9tK08HP4f51Q3iYmGhZnr
	2IwcwIZYE1h99oDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GdQsWPUh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Tw695dtk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730113274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPErEHvWrwDTtY0/hCiF+bKl1VxPwxAdWFCd/773/fs=;
	b=GdQsWPUhXwTNbduKQKsBCapXTFfekkye0woEwDyJJ6mudy7c/ujKVYPeaXrqHe9/Epz4ha
	IvfJDOfdIkctlZaiZ69C+1w5YBJ3qCVKsbo5IWBB7kfK8TwEmRHihW6exqLM6TJT5PLlGJ
	cJH3JrEoJCJdyTZWMCV/L6lj69kyEPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730113274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPErEHvWrwDTtY0/hCiF+bKl1VxPwxAdWFCd/773/fs=;
	b=Tw695dtkgNrxC3d+ujvpGV+T6UkZS4gXHMSZZ1bnwvyboFJOC9tK08HP4f51Q3iYmGhZnr
	2IwcwIZYE1h99oDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B0D136DC;
	Mon, 28 Oct 2024 11:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BkIMLPluH2eqQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 28 Oct 2024 11:01:13 +0000
Message-ID: <fb1db044-e5da-4a77-b0ba-9a059a5f5ad9@suse.cz>
Date: Mon, 28 Oct 2024 12:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free
 highatomic
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Matt Fleming <mfleming@cloudflare.com>, David Rientjes
 <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Link Lin <linkl@google.com>
References: <20241026033625.2237102-1-yuzhao@google.com>
 <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
 <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com>
 <8459b884-5877-41bd-a882-546e046b9dad@suse.cz>
 <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
 <6ac7a38f-30df-4403-8723-a43829bcdba5@suse.cz>
 <CAOUHufYyEjDG1+MEqRhuWPL037aSqrDhi_FT5gfyktbpQBmDVA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <CAOUHufYyEjDG1+MEqRhuWPL037aSqrDhi_FT5gfyktbpQBmDVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05637219FB
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/28/24 1:24 AM, Yu Zhao wrote:
> On Sun, Oct 27, 2024 at 3:05 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/27/24 21:51, Yu Zhao wrote:
>>> On Sun, Oct 27, 2024 at 2:36 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> On 10/27/24 21:17, Yu Zhao wrote:
>>>>> On Sun, Oct 27, 2024 at 1:53 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>
>>>>
>>>> For example:
>>>>
>>>> - a page is on pcplist in MIGRATE_MOVABLE list
>>>> - we reserve its pageblock as highatomic, which does nothing to the page on
>>>> the pcplist
>>>> - page above is flushed from pcplist to zone freelist, but it remembers it
>>>> was MIGRATE_MOVABLE, merges with another buddy/buddies from the
>>>> now-highatomic list, the resulting order-X page ends up on the movable
>>>> freelist despite being in highatomic pageblock. The counter of free
>>>> highatomic is now wrong wrt the freelist reality
>>>
>>> This is the part I don't follow: how is it wrong w.r.t. the freelist
>>> reality? The new nr_free_highatomic should reflect how many pages are
>>> exactly on free_list[MIGRATE_HIGHATOMIC], because it's updated
>>> accordingly.
>>
>> You'd have to try implementing your change in the kernel without that
>> migratetype hygiene series, and see how it would either not work, or you'd
>> end up implementing the series as part of that.
> 
> A proper backport would need to track the MT of the free_list a page
> is deleted from, and I see no reason why in such a proper backport
> "the counter could drift easily" or "the counter of free highatomic is
> now wrong wrt the freelist reality". So I assume you actually mean
> this patch can't be backported cleanly? (Which I do agree.)

Yes you're right. But since we don't plan to backport it beyond 6.12,
sorry for sidetracking the discussion unnecessarily. More importantly,
is it possible to change the implementation as I suggested? [1] Hooking
to __del_page_from_free_list() and __add_to_free_list() means extra work
in every loop iteration in expand() and __free_one_page(). The
migratetype hygiene should ensure it's not necessary to intercept every
freelist add/move and hooking to account_freepages() should be
sufficient and in line with the intended design.

Thanks,
Vlastimil

[1]
https://lore.kernel.org/all/37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz/

