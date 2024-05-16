Return-Path: <linux-kernel+bounces-180889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5C8C746A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520751F23C40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8025143890;
	Thu, 16 May 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zABhOF3G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="grh52sRt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zABhOF3G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="grh52sRt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A7143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854278; cv=none; b=X1FtPpQGvsc7f0zhpKzuecToE17iRlshHg+zdVz9NAwSSLhJp/2VmTLb6ZoUUiwM7HAqE+eTjUUm/XIIEVHmLWlsZCH/xtbB5WaVzfVvjsbbK0uk4WQzMx/rNu8WTzhhMFGQWx2lkou93OfN425VuMTaUHV92KJuUAap+NzJlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854278; c=relaxed/simple;
	bh=wrjWg5VNLq3/Z7bb5HcOdywt5W6rn/Ry5+A8Q5qacOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7atOr/+D4fBQauBSwdL5hcNB8/87ydz97EEV9wwVxFCggDwC+nRZmHPNk6qy49yxEeXEbP0HT7+Nr9SqXYgEljWAiyvplfOSRKxVgfbRlbDamCfEeIc1ofaa/DwQ7TxP7vhTb6MVMr5SpzQzAcd5IwhaVujtMKu7UwJQrzD3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zABhOF3G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=grh52sRt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zABhOF3G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=grh52sRt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1950134790;
	Thu, 16 May 2024 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715854272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4NkbSv/WPWfVquDX8K+L4Ufl8jYQbOt3YU2BEJVMIc=;
	b=zABhOF3GpZaSm6yvSDAIM6fEip/RWQj89LDo6L4h4e+QzZ32SICr6hahL4vnyEr8qHBbvO
	iGCZ2nbEMs72XXsCCqunJuW1N8u0WK5qqKn6wocTQl2hYqQtUKoffFbATddslYAqE5lhLT
	PPi01jrfcUmZgI6L6a4M1gRsDeoaNCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715854272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4NkbSv/WPWfVquDX8K+L4Ufl8jYQbOt3YU2BEJVMIc=;
	b=grh52sRt4oi3gZ70C9CYIIOIMq6uwX+EMCg1yZb12xdqfWIrmdSddiVUDvQ9ZNoo/+sFoI
	SRCuJ9H3XRyuZECQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zABhOF3G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=grh52sRt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715854272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4NkbSv/WPWfVquDX8K+L4Ufl8jYQbOt3YU2BEJVMIc=;
	b=zABhOF3GpZaSm6yvSDAIM6fEip/RWQj89LDo6L4h4e+QzZ32SICr6hahL4vnyEr8qHBbvO
	iGCZ2nbEMs72XXsCCqunJuW1N8u0WK5qqKn6wocTQl2hYqQtUKoffFbATddslYAqE5lhLT
	PPi01jrfcUmZgI6L6a4M1gRsDeoaNCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715854272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4NkbSv/WPWfVquDX8K+L4Ufl8jYQbOt3YU2BEJVMIc=;
	b=grh52sRt4oi3gZ70C9CYIIOIMq6uwX+EMCg1yZb12xdqfWIrmdSddiVUDvQ9ZNoo/+sFoI
	SRCuJ9H3XRyuZECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF08F13991;
	Thu, 16 May 2024 10:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDQ6KL/bRWYuSAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 10:11:11 +0000
Date: Thu, 16 May 2024 12:11:06 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm/memory-failure: move hwpoison_filter() higher
 up
Message-ID: <ZkXbugsIzSWkBk6w@localhost.localdomain>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-5-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510062602.901510-5-jane.chu@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1950134790
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.00

On Fri, May 10, 2024 at 12:26:01AM -0600, Jane Chu wrote:
> Move hwpoison_filter() higher up as there is no need to spend a lot
> cycles only to find out later that the page is supposed to be skipped
> for hwpoison handling.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 62133c10fb51..2fa884d8b5a3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2236,6 +2236,13 @@ int memory_failure(unsigned long pfn, int flags)
>  		goto unlock_mutex;
>  	}
>  
> +	if (hwpoison_filter(p)) {
> +		if (flags & MF_COUNT_INCREASED)
> +			put_page(p);
> +		res = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}

Now, it is true that doing this might not be optimal for the reasons
explained by Miaohe, but the whole hwpoison_filter() thing is only used
by the hwpoison-inject code AFAICS, which is just for testing purposes,
so I do not think there is any harm in lifting the check.

But no real strong opinion here.


-- 
Oscar Salvador
SUSE Labs

