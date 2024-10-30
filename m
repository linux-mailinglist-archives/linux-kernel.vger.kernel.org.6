Return-Path: <linux-kernel+bounces-388541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE689B6105
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502A71F20FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59B1E3DCB;
	Wed, 30 Oct 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSI3UhUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nS1NQ2LR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSI3UhUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nS1NQ2LR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470F1DDA31
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286196; cv=none; b=ZHlIzXEgmqU3ezez5cqFeFp2ajrfowSv+0pe2BUkJAQPGI1TQINVwVAIQcDa705pvJRETxcvLVAJ2V2EvZoGSiFtaPoFElLtZqXYPAnBjO8tbyMQb7wwBgOVxJGRxDZ0rCRt6LdpbZDSL6xFK1BKKj56XK2sF9EMZWCeB8OkUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286196; c=relaxed/simple;
	bh=nUcQKcRs1PtEAioTxhgNgAvqDMO+8b6HYHtP7pY1dDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/lDtVVAnHZetJJdW5HBySXv9YEHD/b8JpOzUvSVMa/OSUVEiMx72cSTAoMLEpLO1XIM51cKuwv79rtV7yjahTZ5GcFNVy5ynFGXBgjR55/a0VdszlSyi4AiAcNZEe38IcDoS/6K2C01Rdm2s1oLUr1GpZuJsEJTvN42mjlsPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DSI3UhUg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nS1NQ2LR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DSI3UhUg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nS1NQ2LR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7F01F7E7;
	Wed, 30 Oct 2024 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730286191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CwBZGB8WJMh7tsGp8Ow4+zvbdMuQU2lCueUyybaI/M=;
	b=DSI3UhUgJxLxcRDL6HNjLMZlkAB2fO6yUbM47x68aLMoSKke6fskjZSJBsRujqQEVoWhjc
	TSEPmgXijOK4rmui6Q7avx0YNYs/7j17Ua0n/04vsze6/YbcuDNJOnA7gM5AE4sfk+pg9T
	LLKad8eCR4aT+qQ1dq1CvvmevGFkiyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730286191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CwBZGB8WJMh7tsGp8Ow4+zvbdMuQU2lCueUyybaI/M=;
	b=nS1NQ2LRMyw1uw2glAhtsMWeRrifujzpY6Ck6WpY9rOuZmkbD5ENBOIdLdzqFu+07ADGtD
	U+PCXlOnW6BFjxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730286191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CwBZGB8WJMh7tsGp8Ow4+zvbdMuQU2lCueUyybaI/M=;
	b=DSI3UhUgJxLxcRDL6HNjLMZlkAB2fO6yUbM47x68aLMoSKke6fskjZSJBsRujqQEVoWhjc
	TSEPmgXijOK4rmui6Q7avx0YNYs/7j17Ua0n/04vsze6/YbcuDNJOnA7gM5AE4sfk+pg9T
	LLKad8eCR4aT+qQ1dq1CvvmevGFkiyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730286191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CwBZGB8WJMh7tsGp8Ow4+zvbdMuQU2lCueUyybaI/M=;
	b=nS1NQ2LRMyw1uw2glAhtsMWeRrifujzpY6Ck6WpY9rOuZmkbD5ENBOIdLdzqFu+07ADGtD
	U+PCXlOnW6BFjxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DC19136A5;
	Wed, 30 Oct 2024 11:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HK+lBm8SImc6QgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Oct 2024 11:03:11 +0000
Message-ID: <87124c1d-5b95-4499-aa4b-22f2ecd376bc@suse.cz>
Date: Wed, 30 Oct 2024 12:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/30/24 05:39, John Hubbard wrote:
> On 10/29/24 9:33 PM, Christoph Hellwig wrote:
>> On Tue, Oct 29, 2024 at 09:30:41PM -0700, John Hubbard wrote:
>>> I do, yes. And what happens is that when you use GPUs, drivers like
>>> to pin system memory, and then point the GPU page tables to that
>>> memory. For older GPUs that don't support replayable page faults,
>>> that's required.
>>>
>>> So this behavior has been around forever.
>>>
>>> The customer was qualifying their software and noticed that before
>>> Linux 6.10, they could allocate >2GB, and with 6.11, they could
>>> not.
>>>
>>> Whether it is "wise" for user space to allocate that much at once
>>> is a reasonable question, but at least one place is (or was!) doing
>>> it.
>> 
>> Still missing a callchain, which make me suspect that it is your weird
>> out of tree driver, in which case this simply does not matter.
>> 
> 
> I expect I could piece together something with Nouveau, given enough
> time and help from Ben Skeggs and Danillo and all...
> 
> Yes, this originated with the out of tree driver. But it never occurred
> to me that upstream be uninterested in an obvious fix to an obvious
> regression.

It might be a regression even if you don't try to pin over 2GB. high-order
(>costly order) allocations can fail and/or cause disruptive
reclaim/compaction cycles even below MAX_PAGE_ORDER and it's better to use
kvmalloc if physical contiguity is not needed, it will attempt the physical
kmalloc() allocation with __GFP_NORETRY (little disruption) and fallback to
vmalloc() quickly.

Of course if there's a way to avoid the allocation completely, even beter.

> 
> thanks,


