Return-Path: <linux-kernel+bounces-541496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D82A4BD7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C8518953FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BD1F4281;
	Mon,  3 Mar 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgumgaSq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y++An/tC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgumgaSq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y++An/tC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAC1F3FC3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000022; cv=none; b=k9dALwcXfdUyWAvc5TqAPADGy3gYUFIri23JfZolWJcQF2Jmb8E8GNFEW7P84KzMIrIU4DU1BYaocW3u8IGebih5T9/XfVyzx9B3Et1BCgkXqgNpD6DLGpHD2wtjTflEqQdBqLo4oNDbXeFwnQPCSIrudlp4adpm8CQWH2Ftx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000022; c=relaxed/simple;
	bh=Z6v09OA0MxQDcioS2IJriPXLoRhLT0ABh2XjyLHknl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nj3JCAsj3L/62rG0qmJRQ7UMACaNDUchaL8owUBiWFdBFai9CujLBOXfArLPuyWymmuDVeLcUW4e0FAleL+mJBo8A+8zX8JqCHrBWmNVRCTrzZdPCAKbgI0VDWQ/q2J6vY3SUehq3g401VVhsOnAWqdKMJTjLHiNoLTB2IFjAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgumgaSq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y++An/tC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgumgaSq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y++An/tC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AE132117A;
	Mon,  3 Mar 2025 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741000019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4wm6X0cQdr1ptSNl5ceQEwqlufdO05imJpQYPKalfs=;
	b=zgumgaSqIZA82EoC+tXkSm05kbW3rF1iMFbcygmixoBJCk6FOB8lEi5wA4aO1ufneoQxKG
	RUDr4Bywq9YOyhWRGge+QdK4vndsCgzCvbHpYJ9xdt8cx8bNV+WQtEa4ceFnFS1ywN8JR5
	/zB9RQAaie6KkfrQaCksJORZsaUC3WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741000019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4wm6X0cQdr1ptSNl5ceQEwqlufdO05imJpQYPKalfs=;
	b=Y++An/tCPXxj2Bf3NP+OVuwQtMtjXmH/LcAmLOXDYtG6qWNl6C5IotYYoMAKK9inCK5ma/
	38glTCjNeSdyUbBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zgumgaSq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Y++An/tC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741000019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4wm6X0cQdr1ptSNl5ceQEwqlufdO05imJpQYPKalfs=;
	b=zgumgaSqIZA82EoC+tXkSm05kbW3rF1iMFbcygmixoBJCk6FOB8lEi5wA4aO1ufneoQxKG
	RUDr4Bywq9YOyhWRGge+QdK4vndsCgzCvbHpYJ9xdt8cx8bNV+WQtEa4ceFnFS1ywN8JR5
	/zB9RQAaie6KkfrQaCksJORZsaUC3WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741000019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4wm6X0cQdr1ptSNl5ceQEwqlufdO05imJpQYPKalfs=;
	b=Y++An/tCPXxj2Bf3NP+OVuwQtMtjXmH/LcAmLOXDYtG6qWNl6C5IotYYoMAKK9inCK5ma/
	38glTCjNeSdyUbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4FA813A23;
	Mon,  3 Mar 2025 11:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ftVbN1KNxWetKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Mar 2025 11:06:58 +0000
Message-ID: <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
Date: Mon, 3 Mar 2025 12:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Content-Language: en-US
To: Lilith Persefoni Gkini <lilithpgkini@gmail.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, harry.yoo@oracle.com
References: <Z8Sc4DEIVs-lDV1J@Arch>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8Sc4DEIVs-lDV1J@Arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0AE132117A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,oracle.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/2/25 19:01, Lilith Persefoni Gkini wrote:
> The on_freelist() uses a while loop to walk through the linked list
> freelist of a particular slab until it finds the `search` pattern and
> breaks if there is a freepointer in the list that is NULL, or invalid
> (fails the check_valid_pointer() check), or the number of objects (nr)
> in the freelist is more than `slab->objects + 1`
> 
> No valid freelist should have more than slab->objects non NULL pointers,
> therefore the while conditional should check until slab->objects amount
> of times, not more.

In v1 discussion you explained how this can later lead to setting
slab->inuse to -1. I think it's useful to say it here in the changelog
because it's fixing a more serious problem than just doing an unnecessary
loop iteration.

> If the `search` pattern is not found in the freelist then the function
> should return `fp == search` where fp is the last freepointer from the
> while loop.
> 
> If the caller of the function was searching for NULL and the freelist is
> valid it should return True (1), otherwise False (0).

This suggests we should change the function return value to bool :)

> Signed-off-by: Lilith Persefoni Gkini <lilithgkini@proton.me>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..0d3dd429b095 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  	int max_objects;
>  
>  	fp = slab->freelist;
> -	while (fp && nr <= slab->objects) {
> +	while (fp && nr < slab->objects) {
>  		if (fp == search)
>  			return 1;
>  		if (!check_valid_pointer(s, slab, fp)) {
> @@ -1473,7 +1473,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  		slab->inuse = slab->objects - nr;
>  		slab_fix(s, "Object count adjusted");
>  	}
> -	return search == NULL;
> +	return fp == search;
>  }

This seems ok and fixes the issue with setting inuse to -1, while
on_freelist(..., NULL) keeps working, AFAICS.

But I'm wondering if we still have some gap in case there's a cycle in the
freelist as such that we finish the loop with nr == slab->objects and fp is
not NULL. check_valid_pointer() will not catch it as every pointer seems
valid on its own.

This will happen either
- from free_consistency_checks() when searching for an object that's not on
the freelist. Notet his check should avoid the freelist cycle happening in
the first place, by preventing a double free. But it could also happen due
to some other (deliberate?) corruption.
- the call validate_slab() searching for NULL will be returning false

I think there's a problem that none of this will fix or even report the
situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
all objects are free. This goes contrary to the other places that respond to
slab corruption by setting all objects to used and trying not to touch the
slab again at all.

So I think after the while loop we could determine there was a cycle if (nr
== slab->objects && fp != NULL), right? In that case we could perform the
same report and fix as in the "Freepointer corrupt" case?

