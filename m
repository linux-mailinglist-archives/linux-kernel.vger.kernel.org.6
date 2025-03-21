Return-Path: <linux-kernel+bounces-571517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D5A6BE46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83C4189F2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A01DE4C4;
	Fri, 21 Mar 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Np7eJ2aT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gm1/g1x2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Np7eJ2aT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gm1/g1x2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7311D95A9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570358; cv=none; b=Xoss8qyNA5IZyQSfemntvt6y/t6IEhk7eQoWV3AIrkf68xJDUqrNzjMB8k/t+rPMyiQtC4CsN6yhnczOtbndwCL3NzMF5EmBhElvh/zB1r0x1eX0eve9e6KcOVDSq8w/Z1cprHYbn2ev45zr6mXOh1yd8Hz/wVXHVk99PhZ8IqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570358; c=relaxed/simple;
	bh=n2VJ9PmdBengREREYWfdPax2TQu01rEy8rzbVz/vnYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6dVOiIMQSdKazWxHdzHvRzRXBzYKU2keZ8yy/nGY0ExJFO7Yq4L4neEPVHIoKKo/ynN6813n4Pcdx+DLBS0Np9RXrLDWef9iCBNeGb/83PQ9TKgHH1XfIa1IQ4o3L+vUO2mv5SwopZiGXdvhczteMDcZH94i4C8092+BSzYBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Np7eJ2aT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gm1/g1x2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Np7eJ2aT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gm1/g1x2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87E0421C75;
	Fri, 21 Mar 2025 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742570353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8QHLGkiT1yWoOVvFUC84YvlHdbONjprG7kw5LGfqY=;
	b=Np7eJ2aTU+Opw6OCXC+3IgECpkDvvqiE1uYaYVTHQufEt9Cel2ZrhjfOszi7lxKi8jqBZW
	GQIWxV2PlIBGjpcXbW0W4H0AqYXQr0aHZRannqYbH63cmg/RV9z0YVKwF30o4JNDdwRLSi
	sKwPgCCt/yOSEI59NN0dir4SHsOx0i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742570353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8QHLGkiT1yWoOVvFUC84YvlHdbONjprG7kw5LGfqY=;
	b=gm1/g1x2gZ6KpSHZwGnR+8pkL5DS4aymaox/xd2YM0ylT/qXAztBxiDp6X8UOTYRVPl4ED
	5KEEdRZFKwwbYoDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742570353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8QHLGkiT1yWoOVvFUC84YvlHdbONjprG7kw5LGfqY=;
	b=Np7eJ2aTU+Opw6OCXC+3IgECpkDvvqiE1uYaYVTHQufEt9Cel2ZrhjfOszi7lxKi8jqBZW
	GQIWxV2PlIBGjpcXbW0W4H0AqYXQr0aHZRannqYbH63cmg/RV9z0YVKwF30o4JNDdwRLSi
	sKwPgCCt/yOSEI59NN0dir4SHsOx0i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742570353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8QHLGkiT1yWoOVvFUC84YvlHdbONjprG7kw5LGfqY=;
	b=gm1/g1x2gZ6KpSHZwGnR+8pkL5DS4aymaox/xd2YM0ylT/qXAztBxiDp6X8UOTYRVPl4ED
	5KEEdRZFKwwbYoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FEA2139AA;
	Fri, 21 Mar 2025 15:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yeT0GnGD3WfTEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Mar 2025 15:19:13 +0000
Message-ID: <809792d8-8717-41d9-8dd8-ca91a5b54a28@suse.cz>
Date: Fri, 21 Mar 2025 16:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/debug: Fix parameter passed to
 page_mapcount_is_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, david@redhat.com, linmiaohe@huawei.com,
 gehao@kylinos.cn, shan.gavin@gmail.com
References: <20250321120222.1456770-1-gshan@redhat.com>
 <20250321120222.1456770-3-gshan@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250321120222.1456770-3-gshan@redhat.com>
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
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,infradead.org,redhat.com,huawei.com,kylinos.cn,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/21/25 13:02, Gavin Shan wrote:
> As the comments of page_mapcount_is_type() indicate, the parameter
> passed to the function should be one more than page->_mapcount.
> However, page->_mapcount is passed to the function by commit 4ffca5a96678
> ("mm: support only one page_type per page") where page_type_has_type()
> is replaced by page_mapcount_is_type(), but the parameter isn't adjusted.
> 
> Fix the parameter for page_mapcount_is_type() to be (page->__mapcount
> + 1). Note that the issue doesn't cause any visible impacts due to the
> safety gap introduced by PGTY_mapcount_underflow limit.
> 
> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 8d2acf432385..b6bd9555ec7b 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -71,10 +71,10 @@ static void __dump_folio(struct folio *folio, struct page *page,
>  		unsigned long pfn, unsigned long idx)
>  {
>  	struct address_space *mapping = folio_mapping(folio);
> -	int mapcount = atomic_read(&page->_mapcount);
> +	int mapcount = atomic_read(&page->_mapcount) + 1;
>  	char *type = "";
>  
> -	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
> +	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount;

At this point it would be perhaps more obvious:

if (page_mapcount_is_type(mapcount))
	mapcount = 0;

But doesn't matter much.

>  	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
>  			folio_ref_count(folio), mapcount, mapping,
>  			folio->index + idx, pfn);


