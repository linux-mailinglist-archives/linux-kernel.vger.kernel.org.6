Return-Path: <linux-kernel+bounces-542609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA8A4CB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4E3AC384
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4422CBFA;
	Mon,  3 Mar 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdMvKlxD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/+WFGPOd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q2vMxDYr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bdSC6hSV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4ED1DE2BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028798; cv=none; b=W3qBHuaNIJJRYe91i7tX9f0f7TIokgKPNV+VQUEudB0D5oQeCTNC6ATrGx1SKo+XxL6BrccwXifDY/zWiuyC8NCfjSbSkagsaF+0CUOJq0mKeASe2iROlP3PfRZww3ZuYSJ2tATpYfEo/LYnO/y7OnFUIstYBoKtW2CpHW3xlyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028798; c=relaxed/simple;
	bh=hWGeFawQi49vIEDUNe9Uk5wvnJoxN6Q+h7IyPhJMlZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnlbTOyUuR8icHVCKiNRrXtq+/TfhP4D7PWAFGqgS1K4/CWMh73dT1rOlvoMzEW6MbnoYK/z7HVi4MX/WHl6boCndm2vvIN6yvtF7qhFz3/9I2B+jcAdXmBtknY0O1ioN2/rLYcYM88WgMmVdGmXLfJPVMSnLhFJHUxEbSvetZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdMvKlxD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/+WFGPOd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q2vMxDYr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bdSC6hSV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC00C211DF;
	Mon,  3 Mar 2025 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741028794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5jpDrSfaukdGwh0R60esxhP42gvTWxjgUuAaBB97vnA=;
	b=mdMvKlxD5OVYUhSnBLhgkGlmdM3vRFEBWLj61oR8UY6LeWXvYwHW3yfuoyFGRg/cZ37Pp/
	AHaBVs8IdPdLU/clDf4Y65kJwK9PS6j6WwifCZ1d55npMckI+Yh7C9oAJDHrTbzk+1zvNw
	qQ+/8RBSWJdyLXbitwRKYRrBNbwkuq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741028794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5jpDrSfaukdGwh0R60esxhP42gvTWxjgUuAaBB97vnA=;
	b=/+WFGPOd1utzl7swYDvq+7UEBirNREIuPJxVj5WTL1xbi3fS1cOJU55x7X/gu+YtcPTvho
	EnV1LnO5MgIr+fAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q2vMxDYr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bdSC6hSV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741028792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5jpDrSfaukdGwh0R60esxhP42gvTWxjgUuAaBB97vnA=;
	b=q2vMxDYrzgM7kxoat9Gu9JPn/g5ox64WlkkuxOcRYwboaMJsNWrivP7Jl/fAvrkLlz/dvS
	tSARzL3BD2y+4xAOEhqKiVD/kw2eGx+8B3QuFps4OGuTgLp1QeRA/LnE5uu4XK/VxLGgRT
	0nBKQSK4jDYOcVaIjWALtsW7jCMroc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741028792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5jpDrSfaukdGwh0R60esxhP42gvTWxjgUuAaBB97vnA=;
	b=bdSC6hSVGXMR4iypjgxuNumqPxRKgv11epYIzt2TRYdQ/j7QUQ9CUsdsc/S5LlteKYdtq/
	ivsv5m8p5y/pmODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9F613939;
	Mon,  3 Mar 2025 19:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YWpDMbj9xWdAVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Mar 2025 19:06:32 +0000
Message-ID: <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
Date: Mon, 3 Mar 2025 20:06:32 +0100
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8XbomV9WCabATIM@Arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC00C211DF
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/3/25 17:41, Lilith Gkini wrote:
> On Mon, Mar 03, 2025 at 12:06:58PM +0100, Vlastimil Babka wrote:
>> On 3/2/25 19:01, Lilith Persefoni Gkini wrote:
>> > If the `search` pattern is not found in the freelist then the function
>> > should return `fp == search` where fp is the last freepointer from the
>> > while loop.
>> > 
>> > If the caller of the function was searching for NULL and the freelist is
>> > valid it should return True (1), otherwise False (0).
>> 
>> This suggests we should change the function return value to bool :)
>> 
> 
> Alright, If you want to be more technical it's
> `1 (true), otherwise 0 (false).`
> Its just easier to communicate with the true or false concepts, but in C
> we usually don't use bools cause its just 1s or 0s.

Yeah, I think bools were not used initially int the kernel, but we're fine
with them now and changing a function for other reasons is a good
opportunity to modernize. There are some guidelines in
Documentation/process/coding-style.rst about this (paragraphs 16 and 17).
int is recommended if 0 means success and -EXXX for error, bool for simple
true/false which is the case here.

>> I think there's a problem that none of this will fix or even report the
>> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
>> all objects are free. This goes contrary to the other places that respond to
>> slab corruption by setting all objects to used and trying not to touch the
>> slab again at all.
>> 
>> So I think after the while loop we could determine there was a cycle if (nr
>> == slab->objects && fp != NULL), right? In that case we could perform the
>> same report and fix as in the "Freepointer corrupt" case?
> 
> True! We could either add an if check after the while as you said to
> replicate the "Freepointer corrupt" behavior...
> Or...
> 
> I hate to say it, or we could leave the while condition with the equal
> sign intact, as it was, and change that `if` check from
> `if (!check_valid_pointer(s, slab, fp)) {`
> to
> `if (!check_valid_pointer(s, slab, fp) || nr == slab->objects) {`

You're right!

> When it reaches nr == slab->objects and we are still in the while loop
> it means that fp != NULL and therefore the freelist is corrupted (note
> that nr starts from 0).
> 
> This would add fewer lines of code and there won't be any repeating
> code.
> It will enter in the "Freechain corrupt" branch and set the tail of 
> the freelist to NULL, inform us of the error and it won't get a chance
> to do the nr++ part, leaving nr == slab->objects in that particular 
> case, because it breaks of the loop afterwards.
> 
> But it will not Null-out the freelist and set inuse to objects like you
> suggested. If that is the desired behavior instead then we could do
> something like you suggested.

We could change if (object) to if (object && nr != slab->objects) to force
it into the "Freepointer corrupt" variant which is better. But then the
message should be also adjusted depending on nr... it should really report
"Freelist cycle detected", but that's adding too many conditions just to
reuse the cleanup code so maybe it's more readable to check that outside of
the while loop after all.

