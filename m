Return-Path: <linux-kernel+bounces-180814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF4C8C7379
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0881C22A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB26142E8E;
	Thu, 16 May 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gaF1jYvA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2zl8rMy+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gaF1jYvA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2zl8rMy+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A47142E96
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850439; cv=none; b=mP3WuiofL2ehULSPl1PVwBEZxsh78h7fWcSAvjXK6f3z++y9knh3ZAYNBbaWhNmZDjsqa5RfHqmeZ8+8mi0BikxK4IKJIMIZd607bjHNrw92xNvVhMzSffT751PUPpk4clPofRZEea4iwIM3+69S0HhDGY3ntu+bhnynFGsgXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850439; c=relaxed/simple;
	bh=lLXZ5P4hNA3m4VBR78XGJDYwRUuwy1e+C7SNetPp6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFODtMXcf9s1LP/SVK5jZT9uUOYNQit3oLVCtL1b6BFKSnn5IE6n1Mtf8JZOhlmLOT5oj+J2w2+J0+KozWyWXWxleakbse+LJ55NGkMa4UmzJfMZx3Q4vh/ZZg4CjJK92FvApRX9vF8+F5SEPJ04emJwG0OyPsYNQoXOJhULHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gaF1jYvA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2zl8rMy+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gaF1jYvA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2zl8rMy+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DEBC346ED;
	Thu, 16 May 2024 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715850430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLeTIM45ewjev4DQ6PoqdCo+wq0wfEIEwRwtJcI36LI=;
	b=gaF1jYvAzi0ecbsxKz4M//m5K4Zr1t/VaydIphUgvFveCyRKe9bsawBXYmn3Tpc/IlJqpy
	ZyNSz6Bplw3H3I/PFYIUvDagiQrLlWv8vp3L7TAvD2WTBtKEsjokE808qAIsoZF2MaJtDi
	Qxgw8DjU4Kkxxd+On1lCcDIdBnWykHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715850430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLeTIM45ewjev4DQ6PoqdCo+wq0wfEIEwRwtJcI36LI=;
	b=2zl8rMy+xcbx4jcJu9sQai10RG3tH8Ob/Q95lvfFo6zAZBNVv7cGMiR8hzpgl84xMG+nbf
	j+/tV4nfe0MdKeBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gaF1jYvA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2zl8rMy+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715850430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLeTIM45ewjev4DQ6PoqdCo+wq0wfEIEwRwtJcI36LI=;
	b=gaF1jYvAzi0ecbsxKz4M//m5K4Zr1t/VaydIphUgvFveCyRKe9bsawBXYmn3Tpc/IlJqpy
	ZyNSz6Bplw3H3I/PFYIUvDagiQrLlWv8vp3L7TAvD2WTBtKEsjokE808qAIsoZF2MaJtDi
	Qxgw8DjU4Kkxxd+On1lCcDIdBnWykHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715850430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLeTIM45ewjev4DQ6PoqdCo+wq0wfEIEwRwtJcI36LI=;
	b=2zl8rMy+xcbx4jcJu9sQai10RG3tH8Ob/Q95lvfFo6zAZBNVv7cGMiR8hzpgl84xMG+nbf
	j+/tV4nfe0MdKeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBA54137C3;
	Thu, 16 May 2024 09:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qYHNNr3MRWaUCwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 09:07:09 +0000
Date: Thu, 16 May 2024 11:07:04 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	shy828301@gmail.com, nao.horiguchi@gmail.com,
	xuyu@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
Message-ID: <ZkXMuHcWPBXy9sT3@localhost.localdomain>
References: <20240515023607.870022-1-linmiaohe@huawei.com>
 <e1c93779-8cde-4986-85d3-2134fb8970b3@redhat.com>
 <ZkXDS9y_cBSzBzeN@localhost.localdomain>
 <fd1b4d3f-be4c-16e2-00d9-8ea6443c68f3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1b4d3f-be4c-16e2-00d9-8ea6443c68f3@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -5.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7DEBC346ED
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux-foundation.org,gmail.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

On Thu, May 16, 2024 at 04:45:22PM +0800, Miaohe Lin wrote:
> Thanks for your comment. Do you mean something like below?
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b7..a9fe9eda593f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2546,6 +2546,13 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
>         }
> 
> +       if (is_huge_zero_folio(folio)) {
> +               unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
> +                                pfn, &unpoison_rs);
> +               ret = -EOPNOTSUPP;
> +               goto unlock_mutex;
> +       }
> +
>         if (!PageHWPoison(p)) {
>                 unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>                                  pfn, &unpoison_rs);

Yes, something like that makes much more sense to me.


Thanks

-- 
Oscar Salvador
SUSE Labs

