Return-Path: <linux-kernel+bounces-274554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1549479F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DFBB20FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8341547F9;
	Mon,  5 Aug 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OPloIyiL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3uMzWRbs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OPloIyiL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3uMzWRbs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080813CFAD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854314; cv=none; b=CBRfElR+BdRY6AeNLcwNAfksPM29zc8iZueUcWgNKd+tcPA/HfrqT9ocjYw7iqHgd1LI0qrAyiS0q3meVk5TnbEt/mSRow5E3FMkztc7DgOgcGsXqzxXLjPSl91/Q7rXAq1Bu6obr37RQek0KPwEv9Q+3t0oYPacdAje2EdRuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854314; c=relaxed/simple;
	bh=clPpvsV2TQKaAY6ev/ha5ci48BoCSTD5NbEbHu2u2PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsE8WUUJnS8dgVoYa7ghztB3vtGA26x+X8QwhCPx0AQLYMBoLj0mkqgSyD2hjP3Kx6lUb3M0tmWE40db1aD2Q9371IlsJq4PrcZfV7rFcUQL6seVran1dxeqrmBBHMtHlFcMMW2gA7tbeSk59D2gxlzRsrcbjz1DwkSqro/jCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OPloIyiL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3uMzWRbs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OPloIyiL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3uMzWRbs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E58FF1F831;
	Mon,  5 Aug 2024 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722854309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vnBWnFwJKfaa5k4oPmmx2WyIgoL5aERcGe2MFm4Hrso=;
	b=OPloIyiLHjdXT+/nW4JauFZupCyvQxOLooXxPJPNQipoPUKx1tiN4Mh3UWYSu/Ucfs0qzJ
	qJTyto0Ns/uO0Dkg94d3BkzoqtUqddrU7E05Dqj6EzC8ehs1af25PoGws3tYWNvOb2aBJr
	R8CjoU0tvc4c2mDJvlIIqo+6ZSGUgPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722854309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vnBWnFwJKfaa5k4oPmmx2WyIgoL5aERcGe2MFm4Hrso=;
	b=3uMzWRbsxAc3OmR+J13x99HIUtCPW59IiGWCE5MtEeLrBTvOYQR9TIdXb/110FyB0deKxf
	c9KsQTqF+FAZ5fBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722854309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vnBWnFwJKfaa5k4oPmmx2WyIgoL5aERcGe2MFm4Hrso=;
	b=OPloIyiLHjdXT+/nW4JauFZupCyvQxOLooXxPJPNQipoPUKx1tiN4Mh3UWYSu/Ucfs0qzJ
	qJTyto0Ns/uO0Dkg94d3BkzoqtUqddrU7E05Dqj6EzC8ehs1af25PoGws3tYWNvOb2aBJr
	R8CjoU0tvc4c2mDJvlIIqo+6ZSGUgPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722854309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vnBWnFwJKfaa5k4oPmmx2WyIgoL5aERcGe2MFm4Hrso=;
	b=3uMzWRbsxAc3OmR+J13x99HIUtCPW59IiGWCE5MtEeLrBTvOYQR9TIdXb/110FyB0deKxf
	c9KsQTqF+FAZ5fBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA53513ACF;
	Mon,  5 Aug 2024 10:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2UOrMKWrsGafBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Aug 2024 10:38:29 +0000
Message-ID: <cdc52bd0-dac8-4f3e-bd7b-aca7513a0464@suse.cz>
Date: Mon, 5 Aug 2024 12:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Error out on duplicate cache names when DEBUG_VM=y
To: Pedro Falcato <pedro.falcato@gmail.com>, Christoph Lameter
 <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240804212839.685795-1-pedro.falcato@gmail.com>
 <CAKbZUD0hBFeMm=Rwb1LX6MYEpLK_qAnr8jfczLzY8V-DKEDn4w@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAKbZUD0hBFeMm=Rwb1LX6MYEpLK_qAnr8jfczLzY8V-DKEDn4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.79
X-Spam-Flag: NO
X-Spam-Level: 

On 8/5/24 12:24, Pedro Falcato wrote:
> On Sun, Aug 4, 2024 at 10:28 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
>>
>> Duplicate slab cache names can create havoc for userspace tooling that
>> expects slab cache names to be unique. This is a reasonable expectation.
> 
> For completeness, I just had a look at duplicate cache names around
> the kernel using
> git grep -Eoh "kmem_cache_create.*\"," | grep -Eo \".*\" | uniq -d
> (which seems to be correct)
> 
> which results in the following patch (on top of torvalds/linux.git
> master, so file_lock_cache hasn't been fixed yet)
> 
> This patch being so small is what leads me to believe that erroring
> out here is safe. Of course, no one knows what the out-of-tree modules
> do.

What about module unload/reload with a SLAB_TYPESAFE_BY_RCU cache that will
delay its freeing. Soon also if there are kfree_rcu()'s in flight. And the
zombie cache can stay also permamently around if it fails to be destroy
because some objects were not freed.

In all these cases the cache's refcount should be 0 at that point, so
minimally the check should ignore those. But I would also rather make it be
a warning anyway, at least for a few releases.

> diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
> index cc824dcfe7d..abc78320c66 100644
> --- a/drivers/scsi/snic/snic_main.c
> +++ b/drivers/scsi/snic/snic_main.c
> @@ -873,7 +873,7 @@ snic_global_data_init(void)
>        snic_glob->req_cache[SNIC_REQ_CACHE_MAX_SGL] = cachep;
> 
>        len = sizeof(struct snic_host_req);
> -       cachep = kmem_cache_create("snic_req_maxsgl", len, SNIC_SG_DESC_ALIGN,
> +       cachep = kmem_cache_create("snic_req_tm", len, SNIC_SG_DESC_ALIGN,
>                                   SLAB_HWCACHE_ALIGN, NULL);
>        if (!cachep) {
>                SNIC_ERR("Failed to create snic tm req slab\n");
> diff --git a/fs/locks.c b/fs/locks.c
> index 9afb16e0683..e45cad40f8b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2984,7 +2984,7 @@ static int __init filelock_init(void)
>        filelock_cache = kmem_cache_create("file_lock_cache",
>                        sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
> 
> -       filelease_cache = kmem_cache_create("file_lock_cache",
> +       filelease_cache = kmem_cache_create("file_lease_cache",
>                        sizeof(struct file_lease), 0, SLAB_PANIC, NULL);
> 
>        for_each_possible_cpu(i) {


