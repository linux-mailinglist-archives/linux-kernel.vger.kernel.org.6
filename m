Return-Path: <linux-kernel+bounces-267340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C88941078
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54577B21723
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3819DF7C;
	Tue, 30 Jul 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s8W1W/8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KL32gA4n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Zoogdzg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5xBXnKqM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F318A92F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338954; cv=none; b=YZyznTyh/6W0cG2mKEE6bul1MDgqlDBT/Urfj0aps7aCKaWA2RS9lUTqV9h/rND+KgoZuiPc7ilOTKltBv2t19n5FY7lfv1hp0xW+ams+pmiFTQ8XRoABVvgjSte9mL2d7k1+SthQAypKCKP/5KybR6/sQNlylVe/WdypHWUvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338954; c=relaxed/simple;
	bh=eLdtyNMZ8yy83hxUt4WiBpkCMbhy9MTf2l9h8AmaVhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSrZjo4UI1DMlCFA0bngq9Mv/le0XQRQmkeLThcCwiIiaPCIa9sCZKY6pOHkSwN6/Sl6FmqiK9wnZHij6f+D4Sr30iyI2q5hD/xmHzUF8PBaNVvZ6wtQ+Vc1Bjbs5z2+zVBpaD+NleSKQ0dp0CAQGwQhHIXCgiQre/2ns9mZ/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s8W1W/8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KL32gA4n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Zoogdzg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5xBXnKqM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9EFD1F7EB;
	Tue, 30 Jul 2024 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722338950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbSJA06fsKgiWYVag+Rs2XVRflnFRhGU36M+hqCROpI=;
	b=s8W1W/8Qs//cVfJIbTdjhr6qrTYp4+5v+NYZNGUsltUmVs4goGCS1p7mjDKLd/Ec7EXOct
	TiKDQw5vjUE+t9XD/9bJoRTjQd87aX0hbvPHiJjArd2RtJu+BE9ynV4zxDgwlu3QCO8aUL
	Saq7skBFpvoVSk53psaRdO4aOvEfCHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722338950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbSJA06fsKgiWYVag+Rs2XVRflnFRhGU36M+hqCROpI=;
	b=KL32gA4n/xIX5u52tLaopahwQyx+c4lQWVtoHWDA7qGavzyiJU4BOyIAcvL/0kp+n6sHje
	epabMk4M43eEoqAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Zoogdzg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5xBXnKqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722338949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbSJA06fsKgiWYVag+Rs2XVRflnFRhGU36M+hqCROpI=;
	b=0ZoogdzgMZrlRdTGBdkxrBNPTH77Rf/PJTZBgIjEkrcoTK/Tdp2UE+T7HsPkfApf3iXEa7
	/bzzvhUz/04l55+/ayT2BZ4k7WQq7GYcjrpFxwvnHOWzV3KFMyU/8FxqLggk+czKbDFPs+
	ijd/IOkHWxn2ZOwbBPKDDWxdbTWfHSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722338949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbSJA06fsKgiWYVag+Rs2XVRflnFRhGU36M+hqCROpI=;
	b=5xBXnKqMk9TfUXQDAO4n2Sb3UBHcFWORSfa7ju1WIuwyXzAvmBKkICZr6DbAew4PX7W5Zs
	wMmTq2EXXuknezBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE01813983;
	Tue, 30 Jul 2024 11:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0SsMYXOqGZ6NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 11:29:09 +0000
Message-ID: <6ae22d49-7dfd-44d4-8720-fd2903a05fee@suse.cz>
Date: Tue, 30 Jul 2024 13:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Jann Horn <jannh@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E9EFD1F7EB
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,arm.com,linux-foundation.org,linux.com,kernel.org,lge.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]

On 7/30/24 1:06 PM, Jann Horn wrote:
> Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_RCU
> slabs because use-after-free is allowed within the RCU grace period by
> design.
> 
> Add a SLUB debugging feature which RCU-delays every individual
> kmem_cache_free() before either actually freeing the object or handing it
> off to KASAN, and change KASAN to poison freed objects as normal when this
> option is enabled.
> 
> For now I've configured Kconfig.debug to default-enable this feature in the
> KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_TAGS
> mode because I'm not sure if it might have unwanted performance degradation
> effects there.
> 
> Note that this is mostly useful with KASAN in the quarantine-based GENERIC
> mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
> ->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
> those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
> (A possible future extension of this work would be to also let SLUB call
> the ->ctor() on every allocation instead of only when the slab page is
> allocated; then tag-based modes would be able to assign new tags on every
> reallocation.)
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slab


