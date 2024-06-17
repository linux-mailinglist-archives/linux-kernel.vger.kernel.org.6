Return-Path: <linux-kernel+bounces-217185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DE90AC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13521F23F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29791946BF;
	Mon, 17 Jun 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aA4iOcc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xZBSPMl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SFC5ENC/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6bt9vuVY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23058381A1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622536; cv=none; b=e6dJvzAuHi6mawmIwUr9b4C7VOdIP/rr3P7l9dixswILh0SkilGMaRxjAx12TRkRqjLwTsF15NB3SOnUHC4qORDG29g5eCaYnE2fOQScHfcs3ETSRMp6yKshhzEvXfZbOOxFgELpp9S76JfaZn6mADJ3tCZzd2V2Kxolp+VSHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622536; c=relaxed/simple;
	bh=bWDw1jNcssBziZS8uwBBaO5U8fFcIM4LL6Kk2uRrvaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrnkUDlc1I2zo/SkT/7wJpbeKQP9xGdR7RlTHqM709C0rum7ocWr+GaqYo0Bu23il9xnJ84Ixy68/HswgBRNOQHxLsTbRIvZLTO3bWJBPp8NjFDKvbwwShc8ExrU55VRTNMws2mpFjolakl3yiD452iBWexXCt5RE0UAYBhRXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aA4iOcc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xZBSPMl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SFC5ENC/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6bt9vuVY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2D815C040;
	Mon, 17 Jun 2024 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718622533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcE9SscqAw6k1EomARF9XYm+AyRMpBjy+86cPLXX7zU=;
	b=aA4iOcc4DZ60C+JIahr9WARY4NTRn8ky3WQbJDk8vgNfKPB3qe7jpbuhCDUrFO+YRePOhe
	HEzoZfgx6UidBF/c5LKLkwBt9KLQXYd0xNO8qNnXYPBc3zZeFZByy7Y3aagok/UVfjYmkl
	95wAyY4v9RkkILEXOP+Y4cuzknPD4LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718622533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcE9SscqAw6k1EomARF9XYm+AyRMpBjy+86cPLXX7zU=;
	b=3xZBSPMlm4WiqwRcya3SEP7qIPCtoANCB4wH1Zp0CJZO5w3Mn/U0xCTEQ141TZbf0+pSRj
	I8kwqwzlsTC//iDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="SFC5ENC/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6bt9vuVY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718622532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcE9SscqAw6k1EomARF9XYm+AyRMpBjy+86cPLXX7zU=;
	b=SFC5ENC/+Fr1rjX+emwTho81VpVQVjv3cwHnVN1FAYWLsqY+SSOakrx57Okh7vhrnpLfs6
	W5pxA8VNgZ/6VznLkUSwYRF5JtX+ZPUCGRfYO1DGVOiWnK0SxwtV2Rbo3OFB3AY4jKajCh
	hWWwJiqGHZI+0zOVoFDYbpfuaK2Wi1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718622532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcE9SscqAw6k1EomARF9XYm+AyRMpBjy+86cPLXX7zU=;
	b=6bt9vuVYI/k7+lPh0mb0xs5R15FUHUM4t559kq7n6sArUQhTMLik2EB7yEzwJOg4JMqHSZ
	bgsMxwwXcS+pDcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E5813AAA;
	Mon, 17 Jun 2024 11:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rhoBLEQZcGZfFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Jun 2024 11:08:52 +0000
Message-ID: <5251cbf9-be70-4a83-97e6-8662427aae68@suse.cz>
Date: Mon, 17 Jun 2024 13:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Kees Cook <keescook@chromium.org>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
 <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
 <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
 <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
 <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
 <e655405f-92b2-46e4-830e-013586bd0022@linux.dev>
 <7eaee8ce-ad5b-41ea-9eb5-83195f83fd24@suse.cz>
 <0c0e0892-8410-4a7a-9f12-23b9cc2ef544@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <0c0e0892-8410-4a7a-9f12-23b9cc2ef544@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D2D815C040
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,intel.com,kvack.org,vger.kernel.org,bytedance.com,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/17/24 12:29 PM, Chengming Zhou wrote:
> On 2024/6/17 17:51, Vlastimil Babka wrote:
>> On 6/14/24 4:40 AM, Chengming Zhou wrote:
>>> On 2024/6/12 06:52, Christoph Lameter (Ampere) wrote:
>>>
>>> This reminds me that we can't toggle slub_debug options for kmem_cache in runtime,
>>> I'm wondering is it useful to be able to enable/disable debug options in runtime?
>>> We can implement this feature by using per-slab debug options, so per-slab has
>>> independent execution path, in which some slabs with debug options enabled go
>>> the slow path, while others can still go fast path.
>> 
>> Many of the debug options change the layout of objects in slabs (i.e. affect
>> calculate_sizes()) so it would be very complicated to change things in
> Yeah, so each slab in the same kmem_cache can have different layout (caused by
> different debug_options enabled), we use these different information to decide
> which path each slab should go.
> 
> Then the problem is saving these different layout information for each slab,
> which has an unused _mapcount to reuse, can be used as index to find its layout
> information in the kmem_cache.
> 
> I haven't thought too much about this, so must be missing something.

Yeah it seems very complex with dubious benefits. Possibly would affect fast
paths too as we might disable debugging but still have some slabs around
that were created with debugging enabled so we'll need to keep doing the
checks for them... We'd basically have to keep the "percpu slabs and their
fastpaths can't be used" mode for given cache even after the debugging is
disabled, and that would already defeat most of the performance benefit.

> Thanks.
> 
>> runtime. Also the cache might be merged with other ones if it boots without
>> debug... I don't think it would be feasible at all.
>> 
>>> No sure if it's useful in some cases? Maybe KFENCE is enough? Just my random thoughts.
>>>
>>> Thanks.
>> 


