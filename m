Return-Path: <linux-kernel+bounces-536667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F1A482C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC7D188FB35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9226AA8D;
	Thu, 27 Feb 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCue30Z3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d0ODqEk5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iY7+n9Cf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkjKLStG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475A24E00D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669524; cv=none; b=dM2GK7FIsgMx+FczV3EefXoWtfu1aUh9jYquSxKDmTyxLC3GZQBIjGPwXEHu5tKtOI1C9AfLhMVMDHWCg+qe5jH0GtsMAuzAjx7FKfsgC58YL+DLMLQTTZATKcVQiGoJaYvcP9w6IfnZALV6Byi3+1+r54zvjSxj804qTKzpgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669524; c=relaxed/simple;
	bh=nGypL1yxlv8Y+WoF8Izkff9rIKCZ3AlbD24xzmI8mDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI6vs6aFXE2B8m519SlacBBZS73PBkDOJ5CKXovAOD5aI8YkL95fYcZi4oEPvuABH2i+LGnUI60jxPCOStmuSLx7grhCVhkWZYD4BeIAdHl6B8bvVRLQQji2dJK9YsDsBNxxJph4TqB5ziUQY1fpH2RJ4KxoHEWLpKSESpBJNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCue30Z3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d0ODqEk5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iY7+n9Cf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkjKLStG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C01BF1F38F;
	Thu, 27 Feb 2025 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740669521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gELvwIuCFw+Ts+ximS2coVsiTfn+qkkHC68Xf8KkXjE=;
	b=FCue30Z3sGyYyTh7S+N3cRmT20zvlrrBDPI8qo5JKYEuONa4iDmZO9X1eHyHN71uBBEzoI
	NfDRTs5WAEU3gePX6VFAuCnM6gO+acmFxGogfS2Vfy/TGmzqeR9+1n+jnibOaKJlkdNwxk
	NriXDQS0Xn91o6ksYGjPgqDT8ONwfbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740669521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gELvwIuCFw+Ts+ximS2coVsiTfn+qkkHC68Xf8KkXjE=;
	b=d0ODqEk5Vetdr12U93Lh2XXj6RorpL/VfXWV8Ur9YkBQrbosWnonegw0jRMMpjmfwjTBwX
	C0yQjBBvHwCWZzBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iY7+n9Cf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hkjKLStG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740669520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gELvwIuCFw+Ts+ximS2coVsiTfn+qkkHC68Xf8KkXjE=;
	b=iY7+n9CfSX2Y8vYn+uov2sOYLBZC009FnRZcE4nK77yhBbvRFBo+cepA70y3hRqzYHwfEb
	kHVKGxB8mBV4dJ1BYpBFSe3fzXUsJqE1jAcfHRkjghS7M3hO2KiPqQNKER6GGAkwL3bwYe
	lUlHQDbtZgx84aJ+HhyJcZiTMV/GAos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740669520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gELvwIuCFw+Ts+ximS2coVsiTfn+qkkHC68Xf8KkXjE=;
	b=hkjKLStGzGfv6Jjq2SM+i645qgGRWsRcYQu9/QRefMuPePK4gnrJdZ12rnm4Lz9f7Dq2Fg
	EeKfLKo9zLgR+JCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8493413888;
	Thu, 27 Feb 2025 15:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mQhgH1CCwGcyCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 27 Feb 2025 15:18:40 +0000
Message-ID: <3ddcf2a2-2835-4652-8961-1dd2cac1119f@suse.cz>
Date: Thu, 27 Feb 2025 16:18:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: slub: call WARN() when the slab detect an
 error
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <CGME20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64@epcas2p2.samsung.com>
 <20250226081206.680495-3-hyesoo.yu@samsung.com> <Z8BgsapZtIC9VyRf@harry>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8BgsapZtIC9VyRf@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C01BF1F38F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[samsung.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/27/25 13:55, Harry Yoo wrote:
> On Wed, Feb 26, 2025 at 05:12:01PM +0900, Hyesoo Yu wrote:
>> If a slab object is corrupted or an error occurs in its internal
>> value, continuing after restoration may cause other side effects.
>> At this point, it is difficult to debug because the problem occurred
>> in the past. It is useful to use WARN() to catch errors at the point
>> of issue because WARN() could trigger panic for system debugging when
>> panic_on_warn is enabled. WARN() is added where to detect the error
>> on slab_err and object_err.
>> 
>> It makes sense to only do the WARN() after printing the logs. slab_err
>> is splited to __slab_err that calls the WARN() and it is called after
>> printing logs.
>> 
>> Changes in v4:
>> - Remove WARN() in kmem_cache_destroy to remove redundant warning.
>> 
>> Changes in v3:
>> - move the WARN from slab_fix to slab_err, object_err and check_obj to
>> use WARN on all error reporting paths.
>> 
>> Changes in v2:
>> - Replace direct calling with BUG_ON with the use of WARN in slab_fix.
> 
> Same here, please rephrase the changelog without "Changes in vN" in the
> changelog, and move the patch version changes below "---" line.
> 
>> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
>> ---
> 
> Otherwise this change in general looks good to me (with a suggestion below).
> Please feel free to add:
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> # Suggestion
> 
> There's a case where SLUB just calls pr_err() and dump_stack() instead of
> slab_err() or object_err() in free_consistency_checks().
> 
> I would like to add something like this:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b7660ee85db0..d5609fa63da4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1022,12 +1022,16 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> +	const char *name = "<unknown>";
> +
> +	if (s)
> +		name = s->name;
>  
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	pr_err("=============================================================================\n");
> -	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
> +	pr_err("BUG %s (%s): %pV\n", name, print_tainted(), &vaf);

				     s ? s->name : "<unknown>"

more concise

>  	pr_err("-----------------------------------------------------------------------------\n\n");
>  	va_end(args);
>  }
> @@ -1628,9 +1632,8 @@ static inline int free_consistency_checks(struct kmem_cache *s,
>  			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
>  				 object);
>  		} else if (!slab->slab_cache) {
> -			pr_err("SLUB <none>: no slab for object 0x%p.\n",
> -			       object);
> -			dump_stack();
> +			slab_err(NULL, slab, "No slab for object 0x%p",
> +				 object);

Good suggestion, added that locally. Probably not likely to trigger as a
use-after-free would mean we're rather hit !folio_test_slab() above than a
folio that has a slab flag but has a NULL pointer (or the pointer might be
garbage and not NULL). But at least the error handling will be consistent.
Changed the error message to "No slab cache" as that's more accurate.
Thanks.

>  		} else
>  			object_err(s, slab, object,
>  					"page slab pointer corrupt.");
> 


