Return-Path: <linux-kernel+bounces-536601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B12A48203
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE67A19C3092
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB9235BF8;
	Thu, 27 Feb 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u523WwmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjOhYbh9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u523WwmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjOhYbh9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD883231C87
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667132; cv=none; b=MWFpvxNGkWsAdJZZfXOCeEviohbcpaIJa2eOETt6V112rKLiRttPceYyUbZR4QKJopzAwkqKGRb/znmDQ1oyNQY73dqQz7rmBztELZsmHRoNXRfQkuHjfkcw+EyROYcqqRBthWTyw1nZgpGAewMaCXLCmKZWjnCTP8lG1qd+ReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667132; c=relaxed/simple;
	bh=ugGlZWJEMUS3tEPTcLeHFPxbYGU002BhkX+XwcJCDmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBsH0TEp1Wyo+dI90oUwhQxtXt4MCaE1/wuBox8l0NSqaWTPaoBFzkJ7RSYg+tOk6r43qLJ1MgqNgeEXY3GpBKtZutIR25dowKEXBGULgmH5fUCcQ93kD5j3xQMtYhjZYGHSQNEKLgYDc1nsbDaMa6OdyFDvlomHxmIUn/6Ibi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u523WwmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjOhYbh9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u523WwmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjOhYbh9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 681022118B;
	Thu, 27 Feb 2025 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740667128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5x4jy6t17hcLvzjI8SgZJDgjCK5nQB09GOUL3aUeAjI=;
	b=u523WwmHMZ6kKdnsm1VUSMMNF8qmHp9oQH+/uDjRpSPqvL36Q0NZxfwQTfGyTXI6Ey4qMW
	RGux5NivHT3wq0Rr5kLJRpCRn6ayW6Jbb22sJauKK72iuZl5lD7lqUj7oIXnD+3SpwEUTi
	8TaUKR24w0Ji59Ven+4OjK2UKANX3uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740667128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5x4jy6t17hcLvzjI8SgZJDgjCK5nQB09GOUL3aUeAjI=;
	b=bjOhYbh92IKRXZ4V38mC90ymS7JIdiu8CkZut6SOtxLWksL3G4SC7VE7cDaQrVDykgZMlN
	jfezwuEj+YtQZOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u523WwmH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bjOhYbh9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740667128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5x4jy6t17hcLvzjI8SgZJDgjCK5nQB09GOUL3aUeAjI=;
	b=u523WwmHMZ6kKdnsm1VUSMMNF8qmHp9oQH+/uDjRpSPqvL36Q0NZxfwQTfGyTXI6Ey4qMW
	RGux5NivHT3wq0Rr5kLJRpCRn6ayW6Jbb22sJauKK72iuZl5lD7lqUj7oIXnD+3SpwEUTi
	8TaUKR24w0Ji59Ven+4OjK2UKANX3uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740667128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5x4jy6t17hcLvzjI8SgZJDgjCK5nQB09GOUL3aUeAjI=;
	b=bjOhYbh92IKRXZ4V38mC90ymS7JIdiu8CkZut6SOtxLWksL3G4SC7VE7cDaQrVDykgZMlN
	jfezwuEj+YtQZOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C15A13888;
	Thu, 27 Feb 2025 14:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UMeQEfh4wGcleQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 27 Feb 2025 14:38:48 +0000
Message-ID: <50cb2f6c-f1cd-4aac-9336-e2c88f6314bf@suse.cz>
Date: Thu, 27 Feb 2025 15:38:48 +0100
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
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, harry.yoo@oracle.com,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <CGME20250226081359epcas2p2a6a1f3f92540660129164734fa6eaa64@epcas2p2.samsung.com>
 <20250226081206.680495-3-hyesoo.yu@samsung.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250226081206.680495-3-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 681022118B
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[samsung.com,oracle.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/26/25 09:12, Hyesoo Yu wrote:
> If a slab object is corrupted or an error occurs in its internal
> value, continuing after restoration may cause other side effects.
> At this point, it is difficult to debug because the problem occurred
> in the past. It is useful to use WARN() to catch errors at the point
> of issue because WARN() could trigger panic for system debugging when
> panic_on_warn is enabled. WARN() is added where to detect the error
> on slab_err and object_err.
> 
> It makes sense to only do the WARN() after printing the logs. slab_err
> is splited to __slab_err that calls the WARN() and it is called after
> printing logs.
> 
> Changes in v4:
> - Remove WARN() in kmem_cache_destroy to remove redundant warning.
> 
> Changes in v3:
> - move the WARN from slab_fix to slab_err, object_err and check_obj to
> use WARN on all error reporting paths.
> 
> Changes in v2:
> - Replace direct calling with BUG_ON with the use of WARN in slab_fix.
> 
> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>

As Harry said. I'll remove that locally.

> ---
>  mm/slab_common.c |  3 ---
>  mm/slub.c        | 31 +++++++++++++++++++------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 477fa471da18..d13f4ffe252b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -517,9 +517,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	kasan_cache_shutdown(s);
>  
>  	err = __kmem_cache_shutdown(s);
> -	if (!slab_in_kunit_test())
> -		WARN(err, "%s %s: Slab cache still has objects when called from %pS",
> -		     __func__, s->name, (void *)_RET_IP_);

I think I'll keep this one, because the more detailed warning via
list_slab_objects() is only enabled with CONFIG_SLUB_DEBUG.
If it's not enabled, the kmem_cache_destroy() failure rather should not be
silent.
So slab_in_kunit_test() would also stay.

>  		} else {
> -			list_slab_objects(s, slab,
> -			  "Objects remaining in %s on __kmem_cache_shutdown()");
> +			list_slab_objects(s, slab);

I tried to extract slab_bug() and __slab_err() from list_slab_objects() but
they were also only available with CONFIG_SLUB_DEBUG.

Perhaps we can improve that, but as a follow-up cleanup so we don't hold
this up further.

>  		}
>  	}
>  	spin_unlock_irq(&n->list_lock);


