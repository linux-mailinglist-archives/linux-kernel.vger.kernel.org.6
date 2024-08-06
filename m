Return-Path: <linux-kernel+bounces-276799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032B94988B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F6A28305A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8287149001;
	Tue,  6 Aug 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rr8d89SU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2MoiULDl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rr8d89SU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2MoiULDl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860A18D62B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973236; cv=none; b=qkYp2MAhdULfbQAgJFjyBuxKg4RuubDvZjJZS4rquSmBYnkUH/wU6rGLys9bbeRh4UxYY3Ip0+gSlCst5qaZVo1SWK06249uYfEF0AKFbMgLKuaJ4FZMRg6OCXiQre0/smXel3jBuRPfkAxNelGZuNUUBH3LRqvhfVO57rAXevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973236; c=relaxed/simple;
	bh=0JVyVpMCxj+RL1Qz70uvQkYOkB6DrtMVNi7zh941xGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DlQY7hDZTljwUDzfVel5hRr+wL82pLSDMwrl1tvmxIJtOIYvixjNvUgwLtEvJ23MFQS62lfkN24ZtfM9+sA++K1Sp2hD5UNLpIWzj5OVvn1rQ6kiZ9+0vOVDHkKttBAkXe3sKfRuLLm/8z2TubR0pa3vOIa58mAA4EWHyd1mHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rr8d89SU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2MoiULDl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rr8d89SU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2MoiULDl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6FED1F889;
	Tue,  6 Aug 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722973230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sw7MV5JT5NMV0CSdEmUzTXNvZDyeFNWRVH2l/fPYBv0=;
	b=rr8d89SUX7yzMTex52hRFy0cH7SORSYN/X1FdqNAr2JZoRUFogTrcIyuXG0+O/tUGHEjNy
	Yu5svn2PB4FoMuSJF24sFP8VfzbXgS+TCtb6deDy2NDQ3qi3Uw53KSqbFW/l52QRiENEPa
	3zrRSZHQuhMJk+BsxJd6Ed2uShpEHGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722973230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sw7MV5JT5NMV0CSdEmUzTXNvZDyeFNWRVH2l/fPYBv0=;
	b=2MoiULDlZuGDJyDcVwr+pzHxArqtfPAxBgrKHy+8EGGLE3in9TxpzOMRVGo7lJu0btKD0y
	kTPDqeOrCZjkaMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722973230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sw7MV5JT5NMV0CSdEmUzTXNvZDyeFNWRVH2l/fPYBv0=;
	b=rr8d89SUX7yzMTex52hRFy0cH7SORSYN/X1FdqNAr2JZoRUFogTrcIyuXG0+O/tUGHEjNy
	Yu5svn2PB4FoMuSJF24sFP8VfzbXgS+TCtb6deDy2NDQ3qi3Uw53KSqbFW/l52QRiENEPa
	3zrRSZHQuhMJk+BsxJd6Ed2uShpEHGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722973230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sw7MV5JT5NMV0CSdEmUzTXNvZDyeFNWRVH2l/fPYBv0=;
	b=2MoiULDlZuGDJyDcVwr+pzHxArqtfPAxBgrKHy+8EGGLE3in9TxpzOMRVGo7lJu0btKD0y
	kTPDqeOrCZjkaMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B097813929;
	Tue,  6 Aug 2024 19:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +y7CKi58smYUMwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Aug 2024 19:40:30 +0000
Message-ID: <bd654d0a-6ded-4ebf-a2ae-d2e1e99adb93@suse.cz>
Date: Tue, 6 Aug 2024 21:40:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
 <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
 <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
 <3a706169-9fce-48a0-b808-37f347a65a25@roeck-us.net>
 <CAHk-=whoTU9F1-qGW8ad7a1ZCMm5K_QZ9pX-chCxgU8uN0+2LQ@mail.gmail.com>
 <365ae5b3-ddc0-4635-b6c5-f6bd18d2046b@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <365ae5b3-ddc0-4635-b6c5-f6bd18d2046b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Flag: NO
X-Spam-Level: 

On 8/6/24 21:21, Vlastimil Babka wrote:
> On 8/6/24 20:23, Linus Torvalds wrote:
>> On Tue, 6 Aug 2024 at 11:13, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 8/6/24 10:49, Linus Torvalds wrote:
>>> > [ Adding s390 people, this is strange ]
>>>
>>> Did I get lost somewhere ? I am seeing this with parisc (64 bit), not s390.
>> 
>> Duh. Sorry for the noise. I don't know why I thought this was s390.
>> 
>> The parisc __ffs() is also using some grotty inline asm, but I don't
>> see how the compiler could make a mess of it.
> 
> Note the alignment rules only apply to generic kmalloc-* caches, not "named"
> specific caches, such as kmem_cache and kmem_cache_node.

Also to clarify why objsize looks odd in the slabinfo for the kmalloc
caches, e.g. kmalloc-64 has 256 etc. That's also not because of wrong
alignment calculations, but because full slub_debug is enabled for
everything (CONFIG_SLUB_DEBUG_ON=y) so there's lots of metadata, redzones
etc. (it's also why these consistency checks are executed). The column says
<objsize> but it's actually reporting the full s->size, not only the actual
object...

>>                 Linus
> 


