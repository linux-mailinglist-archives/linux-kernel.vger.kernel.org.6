Return-Path: <linux-kernel+bounces-437672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA99E96A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B1283D19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693B3596D;
	Mon,  9 Dec 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIyrzCnG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfytkp81";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1v9OVHaj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OIDct9ch"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60D3596F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750713; cv=none; b=KhN3LYZAugHQKh/tDtlAZTTYNwQeS/YROoMh2fVeqAw2vHtM2IGvgGyF8oGueFZL4XuFvwxW+gBtmsiKD2FKW+N+X/px080zBe8zGd8rtDGrHquGRHOMblelSAqwIg+1FcMPJ05nnZQWjcsSi4F3huaosgSKP+XAOYkY+7WMiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750713; c=relaxed/simple;
	bh=V3cCLrlvkuiduVJumsDiu6lHykaHVqrMV6XpYJ1Tn0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DffPWbnjLrtsYqAQ800QtPn3AjQ7F6GPXWBsGCgvN7eXKFlsftuQmN7Z+PYD/kkRDyP+gy8Mk5P3pgU6wHR35g4y3DOeL2ujSxzYhZuL5wt+2AdUobiGE0hlerK7l9BVWFdoBCPEQUq+zn9pCpHyVJ5cGFurnatkmZDHjG1Yyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIyrzCnG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfytkp81; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1v9OVHaj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OIDct9ch; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 746F11F46E;
	Mon,  9 Dec 2024 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733750708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c4hdATKhAc9d7hvmD9kDp3rsVRSVDSmIfmk/WnEaIOQ=;
	b=EIyrzCnGNyTytRJprliIEiEVjOYvemhnQEogJxKanMyOeUnvfjF0Fu4fMdZhVEw0pKumfU
	QI+mG+9Qh6DTz3XgsZ8Fm1uiDPKZ7uQZPjPOjIWX/7WErbgDoaNgXT0oZrsna+AH94qlXB
	cTJUoo5K0ATYyDI52RZcqSv+ThW3+Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733750708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c4hdATKhAc9d7hvmD9kDp3rsVRSVDSmIfmk/WnEaIOQ=;
	b=kfytkp81OpOWOWCtJ/7Cp1qJYhFSgH4fzXFIk5I6zG57xzhMhCZ+rVugdXlIolvCwzSCLy
	PhHay/CYY+0YMBAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1v9OVHaj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OIDct9ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733750707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c4hdATKhAc9d7hvmD9kDp3rsVRSVDSmIfmk/WnEaIOQ=;
	b=1v9OVHajeOvcdjb1+Jk8yFSolqmgy0xQOxe1x00C74oVBzKmoPggy++rRoIk1kygDZHWhd
	+wYuYq8dEuR1dD3vzDd5BDNE4GcJY8gSEeGKXU3MYiAyvVMURBl20GuwPlbc0JUqTYHQmw
	xYQzpwzGMeVUX8202DU+KTgUwlBJA94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733750707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c4hdATKhAc9d7hvmD9kDp3rsVRSVDSmIfmk/WnEaIOQ=;
	b=OIDct9chjT4crFLxSkNuMrV2F7XzreavOqO9TytTqsSLD/FaCd7C5eoYC9jPOCBODGkrqE
	hNJgxICnvtWQU8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 566E4138A5;
	Mon,  9 Dec 2024 13:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c9PJFLPvVmegagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Dec 2024 13:25:07 +0000
Message-ID: <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
Date: Mon, 9 Dec 2024 14:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 746F11F46E
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bootlin.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/9/24 10:16, David Hildenbrand wrote:
> On 06.12.24 20:16, Lorenzo Stoakes wrote:
>> There are a number of means of interacting with VMA operations within mm,
>> and we have on occasion not been made aware of impactful changes due to
>> these sitting in different files, most recently in [0].
>> 
>> Correct this by bringing all VMA operations under the same section in
>> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
>> with VMA as there needn't be two entries as they amount to the same thing.
>> 
>> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
>> 
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
>>   MAINTAINERS | 19 +++++++------------
>>   1 file changed, 7 insertions(+), 12 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1e930c7a58b1..95db20c26f5f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>>   F:	tools/testing/selftests/mm/
>>   N:	include/linux/page[-_]*
>> 
>> -MEMORY MAPPING
>> -M:	Andrew Morton <akpm@linux-foundation.org>
>> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> -R:	Vlastimil Babka <vbabka@suse.cz>
>> -R:	Jann Horn <jannh@google.com>
>> -L:	linux-mm@kvack.org
>> -S:	Maintained
>> -W:	http://www.linux-mm.org
>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> -F:	mm/mmap.c
>> -
>>   MEMORY TECHNOLOGY DEVICES (MTD)
>>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
>>   M:	Richard Weinberger <richard@nod.at>
>> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>>   S:	Maintained
>>   W:	https://www.linux-mm.org
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> +F:	mm/madvise.c
>> +F:	mm/mlock.c
>> +F:	mm/mmap.c
>> +F:	mm/mprotect.c
>> +F:	mm/mremap.c
>> +F:	mm/mseal.c
>> +F:	mm/msync.c
> 
> Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that 
> the real "magic" they perform is in page table handling and not 
> primarily VMA handling (yes, both do VMA changes, but they are the 
> "easy" part ;) ).

I'd think that moving vma files into MEMORY MAPPING (and not the other way)
would result in a better overal name, that would be a better fit for the
newly added files too?

> They have much more in common with memory.c, which I wouldn't want to 
> see in here either. Hm.
> 


