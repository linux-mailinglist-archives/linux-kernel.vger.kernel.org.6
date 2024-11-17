Return-Path: <linux-kernel+bounces-412250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3985B9D0605
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ED7282124
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90121DB956;
	Sun, 17 Nov 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcHSRb11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+4DEh/HW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcHSRb11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+4DEh/HW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9BA937
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877321; cv=none; b=m3pwIZmCYVdqSYxdfDUaAZwSFzuIgWQuDYZPRf55rFyFicit5zo8XhiuBFdscSHICF2KJEfmElyztZOQyHmtA0K27KJcc09v9PhVWwCjuB6dzNUa2lEsxcufrKcVaxds0qvx8urQnw3LJbr7hVROYP4l7ORACnFVIg0lMeH1u/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877321; c=relaxed/simple;
	bh=vsjGvNL9B+WWR8kgTCUwnbPGRjC9oUX99z3N/YF/Ek0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeD74chOT1wX7VEP6eGUGyIsS6wWgcQh6VHx7sRz/sVk++w3pBEYIEIxopMwi+Q5C0nKypUtsBH3pChbMGfGxW9UqbneUtV+qRguSb3YOlVZUQEXXjsLrZAkxvd02WgGunDLJgUU5xFn3bsLdJAyYa7oWcSNVixOf3Vm1qJ42BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcHSRb11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+4DEh/HW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcHSRb11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+4DEh/HW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C60AC21288;
	Sun, 17 Nov 2024 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731877317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLTr/NahoUUzWTaTSWHEo2tnJpwITYiCHiCG5lE+2BQ=;
	b=KcHSRb11TedM4R6iEOebivmcfzIM7q1A66Fn+0sC8VB3A4O4v1U9WdQkG0/BsA72tlIs7O
	8zIioVYhYOHWkervA4eB+htlSJKqyNA2rGez8vq3+CtQjMApLLCyUVsgDvN7C0W3qVVmJc
	3cGCeDm1AC7SxEQ2nFLUetTbLHLuw2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731877317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLTr/NahoUUzWTaTSWHEo2tnJpwITYiCHiCG5lE+2BQ=;
	b=+4DEh/HWB42jr7OAB7JWLlJXNh3NdmkCORClvYpvySMmG0F7yu68vRa0QpS8h1PzGImyZ6
	g39leJIfEM0MupDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KcHSRb11;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+4DEh/HW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731877317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLTr/NahoUUzWTaTSWHEo2tnJpwITYiCHiCG5lE+2BQ=;
	b=KcHSRb11TedM4R6iEOebivmcfzIM7q1A66Fn+0sC8VB3A4O4v1U9WdQkG0/BsA72tlIs7O
	8zIioVYhYOHWkervA4eB+htlSJKqyNA2rGez8vq3+CtQjMApLLCyUVsgDvN7C0W3qVVmJc
	3cGCeDm1AC7SxEQ2nFLUetTbLHLuw2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731877317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLTr/NahoUUzWTaTSWHEo2tnJpwITYiCHiCG5lE+2BQ=;
	b=+4DEh/HWB42jr7OAB7JWLlJXNh3NdmkCORClvYpvySMmG0F7yu68vRa0QpS8h1PzGImyZ6
	g39leJIfEM0MupDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A778713297;
	Sun, 17 Nov 2024 21:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y84mKMVZOmcaXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 17 Nov 2024 21:01:57 +0000
Message-ID: <d7d5fa1f-f696-44f7-8384-6ba982bff8ec@suse.cz>
Date: Sun, 17 Nov 2024 22:01:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] slab updates for 6.13
Content-Language: en-US
To: Xiongwei Song <sxwbruce@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>
 <Zzi7BxJASrR_wbAQ@sashalap> <Zzi7zR0maqdCC3ME@sashalap>
 <52be272d-009b-477b-9929-564f75208168@suse.cz> <Zzll9v3dR8UxwvQ8@sashalap>
 <CALy5rjW-rOAUDuFVVL67yRXhyVUjWa_9saE2HBTGbyAfUV53kA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CALy5rjW-rOAUDuFVVL67yRXhyVUjWa_9saE2HBTGbyAfUV53kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C60AC21288
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,linux-foundation.org,google.com,linux.com,kvack.org,vger.kernel.org,linux.dev,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/17/24 13:56, Xiongwei Song wrote:
> It seems there is a conflict between fc0eac57d08c ("slab: pull kmem_cache_open()
> into do_kmem_cache_create()") and 543c5bde72e9 ("mm/slab: Allow cache creation
> to proceed even if sysfs registration fails"). The err is initialized

No conflict, commit fc0eac57d08c is from 6.12-rc1, there's no merge here.
I've introduced the bug by trying to improve Hyeonggon's patch and he
quickly corrected me [1] so the buggy version never even made it to -next.
But here I managed to resurrect it before the git pull.

[1] https://lore.kernel.org/all/195242b4-5471-419a-a350-08fd246973f0@suse.cz/

> to -EINVAL in
> the entry of do_kmem_cache_create(), sysfs_slab_add() call can assign
> a value to
> err normally,  but the assignment to err variable has been removed in
> Hyeonggon's
> patch, so do_kmem_cache_create() returns -EINVAL normally. We probably can do
> the following fix:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 73eea67a306b..19630a2da8e1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6199,9 +6199,11 @@ int do_kmem_cache_create(struct kmem_cache *s,
> const char *name,
>         if (!alloc_kmem_cache_cpus(s))
>                 goto out;
> 
> +       /* The error code is not needed any more. */
> +       err = 0;
> +
>         /* Mutex is not taken during early boot */
>         if (slab_state <= UP) {
> -               err = 0;

That was indeed the fix.

>                 goto out;
>         }
> 
> Regards,
> Xiongwei
> 
> On Sun, Nov 17, 2024 at 11:42 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Sat, Nov 16, 2024 at 09:43:07PM +0100, Vlastimil Babka wrote:
>> >On 11/16/24 16:35, Sasha Levin wrote:
>> >> [ Obviously I fat-fingered it and didn't add Christian or Al ]
>> >
>> >I have found the problem and looks like I managed to force push an older
>> >broken version of a branch, possibly due to switching between two computers.
>> >Serves me well for amending in some last minute R-b tags. Doing git diff
>> >@{u} to check for unexpected suprirses before pushing the result didn't help
>> >this time, either I forgot or was blind.
>> >
>> >I have deleted the slab-for-6.13 signed tag and pushed the fixed branch only
>> >to -next. Thanks a lot Sasha for catching this early and please drop the
>> >merge from the for-linus tree.
>>
>> I've dropped the merge and tests are passing now, thanks!
>>
>> --
>> Thanks,
>> Sasha
>>


