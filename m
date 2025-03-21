Return-Path: <linux-kernel+bounces-571167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4AA6B9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C387B189276F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551322371F;
	Fri, 21 Mar 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VrAS6S8q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HWPeSFxj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VrAS6S8q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HWPeSFxj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE6155753
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556835; cv=none; b=AwSZiduFoKlfWeZx7cumhGZoCdGtWUVmfJf0SOWM/jGpdFZrzPaTWb6X7BAH4tXhTiwFQya96N8nWKGG+/Tef4dB/TeB3TeSJPkEyScfpCnLUHGZ9W7b11qjrZed5x1h0oQnkisFqvoZHSzUAzkq8ORNggPGxhSklZ2gNyIXtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556835; c=relaxed/simple;
	bh=/5JT4fXpKckH/pBQFYcPbK4Z7goTzOa8x57wJkWapmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn19k3dI1WWEew86nVPSuaaGC31mDlWyRy26TRQ6jY4ilK/8WAJy1Ue+aPBaEwobDYCuMe1CU1Il5BZk/APfXCUQzmb8eNiBEVS/HaTyX+DZpcN6jPASKAp+bwvC+fOyKYuvk6EFyLiISpltr0KkmhEUNha0F9OOgCrKZYLqQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VrAS6S8q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HWPeSFxj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VrAS6S8q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HWPeSFxj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0681F78F;
	Fri, 21 Mar 2025 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742556832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1zj69AyHS8QvZf6eMqCoAwxWFzA9rEhGNVFV6bgfA=;
	b=VrAS6S8qNve/p7u33K19g4zLOe28lWvZyxPP0I22SbANR91cCQD8I6oPTBFVuzL8Oq7pcP
	YFUerpNphh7Hi59AeJvsA2wCS9j6teNDs9yoLiwUxSpe1fAFFcOlBL/is5vpGQihSGiAsO
	6BUjGxsQw3J2Z6wL87zGMK8NoZqnfSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742556832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1zj69AyHS8QvZf6eMqCoAwxWFzA9rEhGNVFV6bgfA=;
	b=HWPeSFxjRCuICyqT4ksF2wHEURrbbAVQ5gnRwudHVxgWLlA6gAJwvVH5KqChRRNmwoDwlc
	yVf6AvBd5B1feVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742556832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1zj69AyHS8QvZf6eMqCoAwxWFzA9rEhGNVFV6bgfA=;
	b=VrAS6S8qNve/p7u33K19g4zLOe28lWvZyxPP0I22SbANR91cCQD8I6oPTBFVuzL8Oq7pcP
	YFUerpNphh7Hi59AeJvsA2wCS9j6teNDs9yoLiwUxSpe1fAFFcOlBL/is5vpGQihSGiAsO
	6BUjGxsQw3J2Z6wL87zGMK8NoZqnfSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742556832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW1zj69AyHS8QvZf6eMqCoAwxWFzA9rEhGNVFV6bgfA=;
	b=HWPeSFxjRCuICyqT4ksF2wHEURrbbAVQ5gnRwudHVxgWLlA6gAJwvVH5KqChRRNmwoDwlc
	yVf6AvBd5B1feVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45F02139AA;
	Fri, 21 Mar 2025 11:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7jAEKBO3Wf3QwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Mar 2025 11:33:52 +0000
Message-ID: <fb1f1b70-6c6e-4b68-b3bb-fef45b8e8581@suse.cz>
Date: Fri, 21 Mar 2025 12:33:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
 <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
 <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,infradead.org,suse.de,kylinos.cn,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/21/25 12:25, Gavin Shan wrote:
> On 3/21/25 8:11 PM, David Hildenbrand wrote:
>> On 21.03.25 10:23, Vlastimil Babka wrote:
>>> On 3/21/25 06:31, Gavin Shan wrote:
>>>> Found by code inspection. There are two places where the parameter
>>>> passed to page_mapcount_is_type() is (page->__mapcount), which is
>>>> correct since it should be one more than the value, as explained in
>>>> the comments to page_mapcount_is_type(): (a) page_has_type() in
>>>> page-flags.h (b) __dump_folio() in mm/debug.c
>>>
>>> IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
>>> this off-by-one error doesn't currently cause visible issues i.e.
>>> misclassifications legitimate mapcount as page type and vice versa, right?
>>> We'd have to have a mapcount underflown severely right to the limit to make
>>> that off-by-one error cross it?
>> 
>> Agreed. Likely not stable material because it isn't actually fixing anything (because of the safety gaps).
>> 
> 
> Yes, it shouldn't cause any visible impacts so far due to the gap.

Thanks for confirming, please state that in the commit log/cover letter too.

> I just found the issue by code inspection. Lets drop the fix tags
> in v2.

Fixes: tag is fine and correct, just Cc: stable is unnecessary.
Thanks.

>>>
>>> I wonder if a more future-proof solution would be to redefine
>>> page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.
>> 
>> With upcoming changes around that, likely best to leave that alone. I expect page_mapcount_is_type() to completely vanish.
>> 
> 
> +1 to remove page_mapcount_is_type(). After Willy confirms, I can post
> an extra series to do it if needed.
> 
> Thanks,
> Gavin
> 


