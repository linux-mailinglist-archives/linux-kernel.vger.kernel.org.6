Return-Path: <linux-kernel+bounces-543524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56FAA4D6C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388FA3AACCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E61FBEA1;
	Tue,  4 Mar 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONfA4h+e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lE1n3adN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONfA4h+e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lE1n3adN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BE1FBEBE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077693; cv=none; b=TdyDf0ikxjkPZSqHhV6tE0M8BEBGBaYrRTvGU3aww99UAIZ+zhyMnIDu1XrJJo6F1tqBcBdPbZC3bhJyQp4LFelFMZUMiLmqlqXlEgiyQaOKPYDtlvOcOQ1bS5BBmNevZpDFtdH5ArK8TvRACt5QjeIPA/WhcCXFcBu3lJekNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077693; c=relaxed/simple;
	bh=q182o3gqf6yupqadBdbVD/j9y+Ok7W9ubFxiI9oEXoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fjn2PKItQ3SD7OPqwxMJNYZfNeJcuNI0B/azFva3Z90uvig+feUujWWT1IRwYvYBadC4Op2Ts2abzC0zG0HnC3QjCDNPt4Dx7MqngecL6S9H6jv1oHHXpBUj1jR84qdxdm106fpeANfy+FRpOh5JeEm6OjVI+T0SFUyp20quxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONfA4h+e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lE1n3adN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONfA4h+e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lE1n3adN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF3211F387;
	Tue,  4 Mar 2025 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741077683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eY48bp8QL7Jwi8pCQ+GUudIBOPIj3TGHcGdFTuIEtMg=;
	b=ONfA4h+ek6u7ohHhT8EyldH2ZmoekiosrYMTeOrH3yCOthpMW3e3uz95C8PmMsBScyFtrT
	nnZP4NRQdRVnxgukMUfX1/x4jB7dxfdKc1GngLxYwnzIg58VkkVbP06dLwOBV5hHDBuV/H
	tFlk6UzQf4TJS0udBS/PXDzHYMliq9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741077683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eY48bp8QL7Jwi8pCQ+GUudIBOPIj3TGHcGdFTuIEtMg=;
	b=lE1n3adN2+vtwG9Tq4EdJ4TsZgdwKH1uty9j3jEcMr8EhvEN3ljTGja6qQ3BgIUd6Yjf9J
	gvTYBLVU0ABgkPDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741077683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eY48bp8QL7Jwi8pCQ+GUudIBOPIj3TGHcGdFTuIEtMg=;
	b=ONfA4h+ek6u7ohHhT8EyldH2ZmoekiosrYMTeOrH3yCOthpMW3e3uz95C8PmMsBScyFtrT
	nnZP4NRQdRVnxgukMUfX1/x4jB7dxfdKc1GngLxYwnzIg58VkkVbP06dLwOBV5hHDBuV/H
	tFlk6UzQf4TJS0udBS/PXDzHYMliq9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741077683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eY48bp8QL7Jwi8pCQ+GUudIBOPIj3TGHcGdFTuIEtMg=;
	b=lE1n3adN2+vtwG9Tq4EdJ4TsZgdwKH1uty9j3jEcMr8EhvEN3ljTGja6qQ3BgIUd6Yjf9J
	gvTYBLVU0ABgkPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4BCF1393C;
	Tue,  4 Mar 2025 08:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yyjiJ7O8xmfKPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 08:41:23 +0000
Message-ID: <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
Date: Tue, 4 Mar 2025 09:41:23 +0100
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
To: Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, harry.yoo@oracle.com
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz> <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz> <Z8a4r2mnIzTD2cZa@Arch>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8a4r2mnIzTD2cZa@Arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,oracle.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/4/25 09:24, Lilith Gkini wrote:
> On Mon, Mar 03, 2025 at 08:06:32PM +0100, Vlastimil Babka wrote:
>> Yeah, I think bools were not used initially int the kernel, but we're fine
>> with them now and changing a function for other reasons is a good
>> opportunity to modernize. There are some guidelines in
>> Documentation/process/coding-style.rst about this (paragraphs 16 and 17).
>> int is recommended if 0 means success and -EXXX for error, bool for simple
>> true/false which is the case here.
> 
> Oh! because of the emote I thought you were being sarcastic that I didnt
> report it properly.

Ah, sorry about that misunderstanding.

> Thank you for clarifying! That should be an easy fix!

Great!

>> > When it reaches nr == slab->objects and we are still in the while loop
>> > it means that fp != NULL and therefore the freelist is corrupted (note
>> > that nr starts from 0).
>> > 
>> > This would add fewer lines of code and there won't be any repeating
>> > code.
>> > It will enter in the "Freechain corrupt" branch and set the tail of 
>> > the freelist to NULL, inform us of the error and it won't get a chance
>> > to do the nr++ part, leaving nr == slab->objects in that particular 
>> > case, because it breaks of the loop afterwards.
>> > 
>> > But it will not Null-out the freelist and set inuse to objects like you
>> > suggested. If that is the desired behavior instead then we could do
>> > something like you suggested.
>> 
>> We could change if (object) to if (object && nr != slab->objects) to force
>> it into the "Freepointer corrupt" variant which is better. But then the
> 
> We could add a ternary operator in addition to you suggestion.
> Changing this:
> `slab_err(s, slab, "Freepointer corrupt");`
> 
> to this (needs adjusting for the proper formating ofc...):
> `slab_err(s, slab, (nr == slab->objects) ? "Freelist cycle detected" : "Freepointer corrupt");`
> 
> But this might be too much voodoo...

Yeah it means 3 places where we check (nr == slab->objects) so it's not very
readable.

>> message should be also adjusted depending on nr... it should really report
> 
> I m not sure what you have in mind about the adjusting the message on
> nr. Do we really need to report the nr in the error? Do we need to
> mention anything besides "Freelist cycle detected" like you mentioned?

I meant just the Freelist cycle detected" message. As "nr" equals
slab->objects it's not so interesting.

>> "Freelist cycle detected", but that's adding too many conditions just to
>> reuse the cleanup code so maybe it's more readable to check that outside of
>> the while loop after all.
> 
> If the ternary operator is too unreadable we could do something like you
> suggested
> 
> ```
> if (fp != NULL && nr == slab->objects) {
> 	slab_err(s, slab, "Freelist cycle detected");
> 	slab->freelist = NULL;
> 	slab->inuse = slab->objects;
> 	slab_fix(s, "Freelist cleared");
> 	return false;
> }
> ```

Yeah looks good.
> 
> What more would you like to add in the error message?
> 
> In a previous email you mentioned this
> 
>> >> I think there's a problem that none of this will fix or even report the
>> >> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
>> >> all objects are free. This goes contrary to the other places that respond to
>> >> slab corruption by setting all objects to used and trying not to touch the
>> >> slab again at all.
> 
> If nuking it is how we should hangle corrupted freelists shouldn't we
> also do the same in the "Freechain corrupt" branch? Otherwise it
> wouldn't be consistent. Instead the code now just sets the tail to NULL.

It sets the tail to NULL but then also breaks out of the loop (btw that
break; could be moved to the if (object) branch to make it more obvious) to
the code below, which should also set slab->inuse properly. So the result
should be consistent? In that case we're able to salvage at least the
uncorrupted part of the freelist. It's likely corrupted by a use-after-free
of a single object overwriting the freepointer.

In case of the cycle we could also in theory replace the freepointer causing
the cycle to NULL. But we'd have to spend more effort to determine which it
was. Cycle is also probably due to a more serious issue than single object
overwrite - it's unlikely a random overwrite would corrupt a freepointer in
a way that it's valid but causing a cycle. So throwing out everything seems
the easiest.

> In that case we'll need to do a lot more rewriting, but it might help
> out with avoiding the reuse of cleanup code.


