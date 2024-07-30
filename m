Return-Path: <linux-kernel+bounces-267217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2E940E83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00551F242E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435618A92A;
	Tue, 30 Jul 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRjJlkb9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g+q+sVoT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoVEuTLv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QSmvn+mu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDE1953BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333610; cv=none; b=XKOUop4OBxNWsTpKU1YDh1CxVD4KzMnyTw2/rbpS5C/FXMnl75PKYt+ht8wZWSf3GaRxoVBcxjw54ACUyzwdasm2QqHLXhxixAnlWbvkX/uxbhfq6ZzncfGrUy+L0JK+Ld5Zikqfu0bv7hfiC09i1dcF3s7oxZDuBBzN7wPHstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333610; c=relaxed/simple;
	bh=JuRbMwNChgrNnn5IynJ4ckaiQMQ48qBbBc90smjVjPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9IRHan6pD9zJUPJUgjebny5Mwyr0OY9qabcu3Mt7tj1Yi5hHO8dykdK3cg6uW2fMV714ymEVSB6EllMTBmX4f+kPsoAJCiQuZxErCmEzirPZiq3LN63paZtIUjBezPIDXeFIE8HilOhFaKVvU2XHWYDMQjlaT0zya8Q6/iiKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRjJlkb9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g+q+sVoT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoVEuTLv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QSmvn+mu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56DB321B13;
	Tue, 30 Jul 2024 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722333603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYE/yrKasWTDsioKmGzRTK+De0ZmQxvlTJ0eyUHh8tU=;
	b=MRjJlkb9xtzUvPOFNvTcO4UYN1V6YYyqDd3rxxzMSWn3BWleyHKoms4zxmQg9G4OLL1H8I
	9BUr8jo9nXnKoNqNAkYWn72EjNyphQ9GliPpB8d2OCeBlmO5fkWYUZpCjbgKvc1NIVd6fw
	elFXDg1n3hXjbDjrJmW0zXnO3+rYbzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722333603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYE/yrKasWTDsioKmGzRTK+De0ZmQxvlTJ0eyUHh8tU=;
	b=g+q+sVoTi0MrzPDDBfpInmQ4kNp/fprTuPoYE2g82viqGrFgPUq4dS9oCUBfPC+v1YZEcN
	+uwHL5Km64/kifBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DoVEuTLv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QSmvn+mu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722333602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYE/yrKasWTDsioKmGzRTK+De0ZmQxvlTJ0eyUHh8tU=;
	b=DoVEuTLvrDNi2aY8xgA+wCa6vOWNXmOvX+YH/pNxn38gwEcSHUfTWhoPV6O29v4Cy7BwSq
	haZwv8G/+QH6PZy+jUpy2pMgNTdqApcewm6q2+eyLmTgbk81+Y4Ssx5Xy32Z2S77UC/PgF
	W0SituL5x2CKJyq5CIPTNbnhJgVw5nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722333602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYE/yrKasWTDsioKmGzRTK+De0ZmQxvlTJ0eyUHh8tU=;
	b=QSmvn+muN0skCQGgMhB9DLzL1NCVmbd7aTB8VvaDTUYjGaYhn3Wy560vTzoq8yW/mhlvO5
	51wXOeI1xJVsxFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B8213297;
	Tue, 30 Jul 2024 10:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xHmFEKK5qGYCHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 10:00:02 +0000
Message-ID: <0d6e8252-de39-4414-b4e7-b6c22a427b0d@suse.cz>
Date: Tue, 30 Jul 2024 12:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,slub: do not call do_slab_free for kfence object
To: Chris Mason <clm@meta.com>, Rik van Riel <riel@surriel.com>
Cc: Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Rientjes <rientjes@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, Jann Horn <jannh@google.com>
References: <20240729141928.4545a093@imladris.surriel.com>
 <044edc48-f597-46dd-8dc8-524697e50848@meta.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <044edc48-f597-46dd-8dc8-524697e50848@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 56DB321B13
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On 7/29/24 8:46 PM, Chris Mason wrote:
> 
> 
> On 7/29/24 2:19 PM, Rik van Riel wrote:
>> In 782f8906f805 the freeing of kfence objects was moved from deep
>> inside do_free_slab to the wrapper functions outside. This is a nice
>> change, but unfortunately it missed one spot in __kmem_cache_free_bulk.
>>
>> This results in a crash like this:
>>
>> BUG skbuff_head_cache (Tainted: G S  B       E     ): Padding overwritten. 0xffff88907fea0f00-0xffff88907fea0fff @offset=3840
>>
>> slab_err (mm/slub.c:1129)
>> free_to_partial_list (mm/slub.c:? mm/slub.c:4036)
>> slab_pad_check (mm/slub.c:864 mm/slub.c:1290)
>> check_slab (mm/slub.c:?)
>> free_to_partial_list (mm/slub.c:3171 mm/slub.c:4036)
>> kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4495 mm/slub.c:4586 mm/slub.c:4635)
>> napi_build_skb (net/core/skbuff.c:348 net/core/skbuff.c:527 net/core/skbuff.c:549)
>>
>> All the other callers to do_free_slab appear to be ok.

changed do_free_slab to do_slab_free in two places.

>>
>> Add a kfence_free check in __kmem_cache_free_bulk to avoid the crash.
>>
>> Reported-by: Chris Mason <clm@meta.com>
>> Fixes: 782f8906f805 ("mm/slub: free KFENCE objects in slab_free_hook()")
>> Cc: stable@kernel.org
>> Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> We found this after bisecting a slab corruption down to the kfence
> patch, and with this patch applied we're no longer falling over.  So
> thanks Rik!

Indeed thanks and sorry for the trouble! Given that
__kmem_cache_free_bulk is currently only used to unwind a
kmem_cache_bulk_alloc() that runs out of memory in the middle of the
operation, I'm surprised you saw this happen reliably enough to bisect it.

Added to slab/for-6.11-rc1/fixes


> -chris

