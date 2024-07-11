Return-Path: <linux-kernel+bounces-248723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB1B92E11B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B11F211CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF714B955;
	Thu, 11 Jul 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WX2C5B3P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+J9WDxWg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X4uKc8K8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g1XqSaYg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5D14B08C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683823; cv=none; b=czsx/Ej8f2TCWXrxG/zA6Ta+ZvlhjAXEfGalTTG+KyQ/QNapsR3BuE/PyD5q45O6002gMxb0mG34pgBopgCtylxD4mW2fKYntoLa9SI2HKwwY5PhxeJ+DL4e3Jo9x4Rqo1bU2jXiEo1zbmaJW/RUNYbFx7OP4tkVNLVIwB9JBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683823; c=relaxed/simple;
	bh=UfRSeFIcSvkUBr5Zi4f51R6wU0KwP1MShergxOiZ1nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iw9mRy+GYug0lZnM1P/VU5khgpXfKWDa16xrlm00MTh09Zj0WQgIzzg9mmC5+zOxZY+tBjY3R0NbMlqFz9f6k5GwgSLihVPNn7QDjVGr3OOzPrlB8Fg4ePsoUuA/8Wl1dgyOaLfGSXIJMQiGSO5nSQ9Glf6tVpH48DineXnHCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WX2C5B3P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+J9WDxWg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X4uKc8K8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g1XqSaYg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D39DF2121E;
	Thu, 11 Jul 2024 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720683819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GE/EgkSTHCy0F2vseSTXJXTTRUr4we0SLGgb0fQq4g=;
	b=WX2C5B3PdT1qji2DGGpB93SpzoWyqfZ0BSKS0AEB5JiHHrjXGaCPsIFs2NE7prOcEOzEKC
	H5aIFG90WvkMQiAw2I2Id+IkP2ke1UUaUBhh+zuXNrlje6R58QUq2CT2zDFFNfd/Xlb6p9
	jhben9ftCH5QQ/6DkPG9p/TAAja4bgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720683819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GE/EgkSTHCy0F2vseSTXJXTTRUr4we0SLGgb0fQq4g=;
	b=+J9WDxWgFbAOdO/59OZqGt4/aGoRo5T9j4e6A1NVicmAULnmwHA4UaUkcpSU++zO/ADWj9
	+gJtjIgZLhpTSwAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720683817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GE/EgkSTHCy0F2vseSTXJXTTRUr4we0SLGgb0fQq4g=;
	b=X4uKc8K8avESgHu5UEldTkILXKcJ4mwuOOKoWkcjYUDLDOOfKusci08okzI2eNK8nzxe/r
	Lw2IPOuubperxYORcQ7n3IZGzbjJS440pDDV/D2brFs00qOvSWe/non35MWYHkWT4uDGdn
	kPv1e7fbXMFlWI5/PFwznLj9eL1Ub/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720683817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GE/EgkSTHCy0F2vseSTXJXTTRUr4we0SLGgb0fQq4g=;
	b=g1XqSaYgj4BfIiI5qnUIZPRUIEFpPn5HZplpJBv+/rumpWrRU1cP7E026k6R6UtRBavOly
	9Iuio/UYsV7n4sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE54E139E0;
	Thu, 11 Jul 2024 07:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PWwtKimNj2aXFQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 07:43:37 +0000
Message-ID: <4b533d6c-b2f3-49eb-a7fb-807af482def8@suse.cz>
Date: Thu, 11 Jul 2024 09:43:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function
 enabled
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, sxwjean@me.com, cl@linux.co,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 xiongwei.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>
References: <20240710025418.394321-1-sxwjean@me.com>
 <Zo36BTqhzGkukyT_@casper.infradead.org>
 <20240710150154.GA1684801@thelio-3990X>
 <CAJuCfpFUawbMXf34YpUv_hrEvwOFX=CvPmyTS3CBOSZtC=c6Tg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpFUawbMXf34YpUv_hrEvwOFX=CvPmyTS3CBOSZtC=c6Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
	FREEMAIL_CC(0.00)[infradead.org,me.com,linux.co,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,intel.com,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,me.com:email,intel.com:email,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 7/10/24 11:40 PM, Suren Baghdasaryan wrote:
> On Wed, Jul 10, 2024 at 8:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Wed, Jul 10, 2024 at 04:03:33AM +0100, Matthew Wilcox wrote:
>> > On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
>> > > From: Xiongwei Song <xiongwei.song@linux.dev>
>> > >
>> > > The only user of prepare_slab_obj_exts_hook() is
>> > > alloc_tagging_slab_alloc_hook(), which can build with
>> > > CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
>> > > when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unused"
>> > > for prepare_slab_obj_exts_hook().
>> >
>> > Perhaps instead clang can be fixed to match gcc's behaviour?
>>
>> Clang only differs from GCC on warning for unused static inline functions in .c
>> files, not .h files. The kernel already handles this in
>> include/linux/compiler_types.h but it disables this workaround for W=1 to catch
>> unused functions like this as a result of commit 6863f5643dd7 ("kbuild: allow
>> Clang to find unused static inline functions for W=1 build"):
>>
>> /*
>>  * GCC does not warn about unused static inline functions for -Wunused-function.
>>  * Suppress the warning in clang as well by using __maybe_unused, but enable it
>>  * for W=1 build. This will allow clang to find unused functions. Remove the
>>  * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.
>>  */
>> #ifdef KBUILD_EXTRA_WARN1
>> #define __inline_maybe_unused
>> #else
>> #define __inline_maybe_unused __maybe_unused
>> #endif
>>
>> So I don't really think there is much for clang to do here and I think having
>> the ability to find unused static inline functions in .c files is useful (you
>> might disagree, perhaps a revert could still be discussed). I guess
>> IS_ENABLED() can't be used there, so it seems like either taking this patch,
>> ignoring the warning, or refactoring the code in some other way are the only
>> options I see.
> 
> I think this is the consequence of the recent refactoring I've done in
> https://lore.kernel.org/all/20240704135941.1145038-1-surenb@google.com/.
> There should be a cleaner way to fix this. I'll post it later today or
> tomorrow morning.

Yeah looks like the non-empty prepare_slab_obj_exts_hook() could move to the
#ifdef CONFIG_MEM_ALLOC_PROFILING section above
alloc_tagging_slab_alloc_hook() and the empty one just removed.

> Thanks,
> Suren.
> 
>>
>> > > Reported-by: kernel test robot <lkp@intel.com>
>> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/
>> > > Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
>> > > ---
>> > >  mm/slub.c | 4 ++--
>> > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/mm/slub.c b/mm/slub.c
>> > > index ce39544acf7c..2e26f20759c0 100644
>> > > --- a/mm/slub.c
>> > > +++ b/mm/slub.c
>> > > @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
>> > >     return false;
>> > >  }
>> > >
>> > > -static inline struct slabobj_ext *
>> > > +static inline struct slabobj_ext * __maybe_unused
>> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>> > >  {
>> > >     struct slab *slab;
>> > > @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
>> > >     return false;
>> > >  }
>> > >
>> > > -static inline struct slabobj_ext *
>> > > +static inline struct slabobj_ext * __maybe_unused
>> > >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>> > >  {
>> > >     return NULL;
>> > > --
>> > > 2.34.1
>> > >
>> > >


