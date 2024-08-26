Return-Path: <linux-kernel+bounces-302082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD395F99A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17522807DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3519923D;
	Mon, 26 Aug 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MTGTiZMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QvuIgZcJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0pD82QY1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSUANrxq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAA198845
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700196; cv=none; b=ThpTutsOeB1c3oOcxNvhu7+aJNH+M8x2FdGRdWpLHzN2SfHVjhRJZCy7KlN/76MGnpfrMsYflEowdf9sljk7XtZAKPUxWS1N1/YmhOCzfEhB6aCURas6/z+29qcVwkCX3rDybBt3ng8ISrfvF+S/0ZeydGUQby122KZfIsM7fWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700196; c=relaxed/simple;
	bh=sXe6x9QWcYBRutlGvhIe+hMW+xkv0mU6zdjyelxtd4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoObhQcsEiMOdH51DMPfVRR++byT6snKycmFve5zm8Ab+HHPjQj6reUt6ta93qB53ulUOvbXEfgIHqByNoGF+bhYLe1kr5Jj96Lrzm4f1m9WelHtXpYt0iWeVj9jZ4tEixshtpjlnlAoNt7miBExstnvAfBp1YAda019lJ++obI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MTGTiZMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QvuIgZcJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0pD82QY1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSUANrxq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53FC31F8AE;
	Mon, 26 Aug 2024 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724700192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V+ZlFdFEs5Wp7EXUYl77vMxh5e9vNYaA6k9u+nZ7HP0=;
	b=MTGTiZMTZh8gzoLMOjCr8F8xsXvRbG53nHV+YcbQHyag6fvS60BEDLNhx5sD8+VppJOZRx
	V7ZhrLkFuL+DVq4DzCiWtPTCingrsNiFI93lxY5v5R4AX20u0LBfrwBEpN/ev7pSSUqoBs
	r6dif9zhRjCt4+l+0AGU7+bBtsgw+zY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724700192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V+ZlFdFEs5Wp7EXUYl77vMxh5e9vNYaA6k9u+nZ7HP0=;
	b=QvuIgZcJaNVAbFEz0kiBygqTykjswPWCDBzdHq0G1cq/cOjilcRtpa+d1wie3c5ldZlvVl
	Nzn9SAwLWIcwhLBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724700191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V+ZlFdFEs5Wp7EXUYl77vMxh5e9vNYaA6k9u+nZ7HP0=;
	b=0pD82QY1isWmRmU3cBjsIjdcAo2eKGYExTF5EPEEq5wKVJrwb2J75XRWqe3n3uT3LG+toN
	O7CdhqWdMQEKLSv2sA91uvKL25s3HpKXjcet9yJBcAcv3PB2RHQfauF9O7gsM1uhXmNoZk
	j8itxvqhijgTicGki6x2ZsepQZ0pQCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724700191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V+ZlFdFEs5Wp7EXUYl77vMxh5e9vNYaA6k9u+nZ7HP0=;
	b=HSUANrxq/dG15/wSPKu5s3gEx/deEJ4Q8PeMerUvcm4UwMqkj1rWkKLMnolBSmp+yi3gX1
	fe2l0mVdfsBCdYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36E891398D;
	Mon, 26 Aug 2024 19:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wsi6DB/WzGawNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Aug 2024 19:23:11 +0000
Message-ID: <6e5f3c82-a18a-4c20-858f-058f44e90ced@suse.cz>
Date: Mon, 26 Aug 2024 21:23:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
Content-Language: en-US
To: Pedro Falcato <pedro.falcato@gmail.com>,
 David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240807090746.2146479-1-pedro.falcato@gmail.com>
 <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com>
 <CAKbZUD1e5nvmrQ5XZ=xV1eYbh5eeSLBQEeDT=KBx1C5T1Bjjzg@mail.gmail.com>
 <aab45188-d34c-93c6-cfab-3c0cd1326a53@google.com>
 <CAKbZUD293X0hOaqHRKpERpmsMKvvOLqRcQoKyB9mssg41Dhxtw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAKbZUD293X0hOaqHRKpERpmsMKvvOLqRcQoKyB9mssg41Dhxtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/16/24 14:17, Pedro Falcato wrote:
> On Mon, Aug 12, 2024 at 1:55 AM David Rientjes <rientjes@google.com> wrote:
>>
>> On Sun, 11 Aug 2024, Pedro Falcato wrote:
>> > > > +     if (kmem_cache_is_duplicate_name(name)) {
>> > > > +             /* Duplicate names will confuse slabtop, et al */
>> > > > +             pr_warn("%s: name %s already exists as a cache\n", __func__, name);
>> > >
>> > >
>> > > Shouldn't this be a full WARN_ON() instead of pr_warn()?  I assume we'll
>> > > be interested in who is adding the cache when the name already exists.
>> >
>> > panic_on_warn? :)
>> >
>>
>> Would get the problem fixed up pretty fast, no? :)
>>
>> > Personally I don't have anything against WARN_ON, but we've seen that
>> > panic_on_warn is a real thing on real systems, and DEBUG_VM is also
>> > set on real prod configs (like Fedora does/used to do). I've sent out
>> > one or two loose patches for problems I did find in my own testing
>> > around, but there may be many more (e.g some drivers may call
>> > kmem_cache_create repeatedly in some sort of callback, like 9pfs was
>> > doing when mounting; this is not greppable). And I'd guess grepping
>> > for cache names tends to be easy enough?
>> >
>>
>> Can we add a dump_stack() to make this way easier instead of hiding who is
>> creating the duplicate name?
> 
> 
> Bah, sorry for the delay.
> 
> I'm fully in favour of adding a dump_stack(), but it seems like hand
> coding WARN_ON a bit. Oh well.

After some pondering I've decided we should just go with WARN_ON and not do
a hand coded workaround for hypothetical people who run CONFIG_DEBUG_VM
together with panic_on_warn, so I've updated the commit in the slab tree
accordingly.

> If y'all agree, please squash this in (praying gmail doesn't mangle
> this diff, in any case it's a trivial change):
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1abe6a577d52..d183655e4b1b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -111,6 +111,7 @@ static int kmem_cache_sanity_check(const char
> *name, unsigned int size)
>        if (kmem_cache_is_duplicate_name(name)) {
>                /* Duplicate names will confuse slabtop, et al */
>                pr_warn("%s: name %s already exists as a cache\n",
> __func__, name);
> +               dump_stack_lvl(KERN_WARNING);
>        }
> 
>        WARN_ON(strchr(name, ' '));     /* It confuses parsers */


