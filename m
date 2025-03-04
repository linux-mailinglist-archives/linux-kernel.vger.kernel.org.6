Return-Path: <linux-kernel+bounces-544410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12361A4E0EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8771887CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805D209F4A;
	Tue,  4 Mar 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smv0gcA1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5ksXxU2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smv0gcA1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5ksXxU2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E12063E8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098331; cv=none; b=UsWc51U8ITqG33WreeHf1uWNNGA1wEIA5sg/tWtnv+Lg7bF+rX6eqh80X/ZbHIEHk+5T3malC2HhVnFHjptYsZKXqAD9gk0dqDMCYpOrPhbgO86X3os5r+rxeFo4wHzJTNaGDMCFhNgIA9sWxXwgQ8UIz8oHkKuwrQ7Lu1Ha/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098331; c=relaxed/simple;
	bh=ZUZhA0vFpgNtlTua4tc4eA3xqsNgyfMV+Sn69FlRGz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDAwslBmoka0flr9+Z0KQFrwMDBO1X4nV3ufqhiefW9xTHWwMHi4nmznmXuIvKxAFkyz5AGnjDAhsFlRoa6qq7eZU9eR2E3klFPrv7P6MtNc4yOcV5uijctLPyj/LY685vj0Cbx+pmE88WCK81SNdhpvE8OqXc5jTLVjREgLDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smv0gcA1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5ksXxU2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smv0gcA1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5ksXxU2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41D4E1F74C;
	Tue,  4 Mar 2025 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2VEfig/rslhLcE/d8ljBX2G4X2nHB+jopQ+zoj3WK/0=;
	b=smv0gcA1ngw0td62EGdtAsxvYT8hTWeQSSWPcdix3H0o9F4NgYrv9UT+Gqq7YouHj7fZIt
	M4M8Sfh+gITBKfNyiPt9AncNGt+vRz+8ZnXWqTb0yewBti5vHjJ0Nk63mj63p2Z+mxn520
	wyGSWquyB3HPqIIKsyevWcwt+df50Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2VEfig/rslhLcE/d8ljBX2G4X2nHB+jopQ+zoj3WK/0=;
	b=u5ksXxU2qpY2IDDZLWAA2YCuCChNdJEIF8JWaIpt8zbo3NQnkKwhttpinSnPXSAxG21z2A
	B5L/rrFxtUF30LBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741098327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2VEfig/rslhLcE/d8ljBX2G4X2nHB+jopQ+zoj3WK/0=;
	b=smv0gcA1ngw0td62EGdtAsxvYT8hTWeQSSWPcdix3H0o9F4NgYrv9UT+Gqq7YouHj7fZIt
	M4M8Sfh+gITBKfNyiPt9AncNGt+vRz+8ZnXWqTb0yewBti5vHjJ0Nk63mj63p2Z+mxn520
	wyGSWquyB3HPqIIKsyevWcwt+df50Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741098327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2VEfig/rslhLcE/d8ljBX2G4X2nHB+jopQ+zoj3WK/0=;
	b=u5ksXxU2qpY2IDDZLWAA2YCuCChNdJEIF8JWaIpt8zbo3NQnkKwhttpinSnPXSAxG21z2A
	B5L/rrFxtUF30LBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22F2913A53;
	Tue,  4 Mar 2025 14:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bYsjCFcNx2elMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 14:25:27 +0000
Message-ID: <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>
Date: Tue, 4 Mar 2025 15:25:26 +0100
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
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz> <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz> <Z8benEHigCNjqqQp@Arch>
 <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz> <Z8bvfiyLelfXskNw@Arch>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8bvfiyLelfXskNw@Arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,oracle.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/4/25 13:18, Lilith Gkini wrote:
> On Tue, Mar 04, 2025 at 12:20:03PM +0100, Vlastimil Babka wrote:
> Thats true. I still had the return fp == search; in my mind, but with all

Ah, right.

> these changes we can just leave it as return search == NULL; as it was,
> because we are handing the edge cases.
> 
> By the time it reaches that return line it should be fine.

True.

> I was also thinking of fixing two lines to adhere to the "Breaking long
> lines and strings" (2) from the coding-style.

Hm AFAIK checkpatch was adjusted to only warn at 100 lines. While the style
document wasn't updated, we can leave such a small excess with no change.

> ---
>  mm/slub.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..e06b88137705 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1427,7 +1427,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>   * Determine if a certain object in a slab is on the freelist. Must hold the
>   * slab lock to guarantee that the chains are in a consistent state.
>   */
> -static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> +static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  {
>  	int nr = 0;
>  	void *fp;
> @@ -1437,38 +1437,48 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  	fp = slab->freelist;
>  	while (fp && nr <= slab->objects) {
>  		if (fp == search)
> -			return 1;
> +			return true;
>  		if (!check_valid_pointer(s, slab, fp)) {
>  			if (object) {
>  				object_err(s, slab, object,
>  					"Freechain corrupt");
>  				set_freepointer(s, object, NULL);
> +				break;
>  			} else {
>  				slab_err(s, slab, "Freepointer corrupt");
>  				slab->freelist = NULL;
>  				slab->inuse = slab->objects;
>  				slab_fix(s, "Freelist cleared");
> -				return 0;
> +				return false;
>  			}
> -			break;
>  		}
>  		object = fp;
>  		fp = get_freepointer(s, object);
>  		nr++;
>  	}
>  
> -	max_objects = order_objects(slab_order(slab), s->size);
> +	if (fp != NULL && nr > slab->objects) {

In case nr > slab->objects we already know fp can't be NULL, no? So we don't
have to test it?

> +		slab_err(s, slab, "Freelist cycle detected");
> +		slab->freelist = NULL;
> +		slab->inuse = slab->objects;
> +		slab_fix(s, "Freelist cleared");
> +		return false;
> +	}
> +
> +	max_objects = order_objects(slab_or0der(slab), s->size);
>  	if (max_objects > MAX_OBJS_PER_PAGE)
>  		max_objects = MAX_OBJS_PER_PAGE;
>  
>  	if (slab->objects != max_objects) {
> -		slab_err(s, slab, "Wrong number of objects. Found %d but should be %d",
> +		slab_err(s, slab,
> +			 "Wrong number of objects. Found %d but should be %d",
>  			 slab->objects, max_objects);
>  		slab->objects = max_objects;
>  		slab_fix(s, "Number of objects adjusted");
>  	}
>  	if (slab->inuse != slab->objects - nr) {
> -		slab_err(s, slab, "Wrong object count. Counter is %d but counted were %d",
> +		slab_err(s, slab,
> +			 "Wrong object count. Counter is %d but counted were %d",
>  			 slab->inuse, slab->objects - nr);
>  		slab->inuse = slab->objects - nr;
>  		slab_fix(s, "Object count adjusted");
> 
> I do have to note that the last slab_err is of length 81 with my change,
> but it looks fine. If that one extra character is unacceptable let me
> know so I can change it to something else.
> Or if you think it's completely unnecessary I could leave it as it was
> in the first place.

Yeah can leave it.

> I just thought since we are trying to modernaze I should fix the length
> as well.
> 
> Also the CHECKPATCH is complaining about the `fp != NULL` that we can
> just check fp on it's own, which is technically true, but wouldn't make
> readability worse?
> I think its better as it's in my diff cause it's more obvious, but if
> you prefer the singular fp I can change it.

I think it's not necessary to test at all but in case I'm wrong, we can do
what checkpatch suggests to be consistent with the while() condition.

> If these changes are acceptable and we don't have anything further to
> change or add I can send it as a proper commit again, But I should
> probably break it into multiple patches.

It's fine as a single patch. Thanks!

> Maybe one patch for the lines and another for the rest? Or should I
> break the bool change in it's own patch?




