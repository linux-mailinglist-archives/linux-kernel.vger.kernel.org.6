Return-Path: <linux-kernel+bounces-180863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E648C7410
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081D9B21E25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93B14386B;
	Thu, 16 May 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TO5NBGA4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LdlkeoH9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TO5NBGA4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LdlkeoH9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F5143860
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852773; cv=none; b=iyqi58BZ9qbu2DBFGPZjPzt8C4b8kcnOwbjUYGg3UaLiv8x7UpnjX6f14hIN6lz5cgi+vXieHHY5YixNKp8WbBuaL14OeEsZ1bUMCFVfKA45RlJeka9Kdc1wtxol1Vdtv6kjeWPFK4VomgUhQjahWcwN3pvb07KexPDmFLJ0LGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852773; c=relaxed/simple;
	bh=6Osh+B7xuSDku/k3KR/bEdbX9RqNlnJlOWg/UYmHoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQjGjpgoPWLTDR3HumBqHwWbBEYGraNOB41PMLQCndT2ipK9U5y7R5A4NH7FX2LSOjTPsuLUN3AOaXXMBT2bG/wqq11lOJQKsUAtpm1O3XiyzlRwhdtBYOOYdZ0dFBH8dYz8SGuYgWNhITCYH2pOQ17kwMXLWt+EHArGz0s0JZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TO5NBGA4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LdlkeoH9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TO5NBGA4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LdlkeoH9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41C9F34741;
	Thu, 16 May 2024 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715852769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5a6IJhenQzXpAbOqnOLMPNsXtvNu5dVA873wpwAdiZs=;
	b=TO5NBGA4lW9jHLbhhAoS12g3bSv1mVBehSmgtJ+xVAu8m9OuOVJb2FdJl5u62XhaCI2iI3
	Fv0lWkkNStAFWD1/DnXJBDcoUmDKuSA621t1lwjUw1dZHdLqE3zP9yVK1qFZbDJs2i8sDh
	u6U/yGBjzXqRRCfyGrn5NVD3LasCkAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715852769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5a6IJhenQzXpAbOqnOLMPNsXtvNu5dVA873wpwAdiZs=;
	b=LdlkeoH9RK93OBFYiHWvmYaIjyZ0VWwlSv4VxCFICLNajWWIc6pZ6Wox4rJ0lBrqadO+IY
	TbQfc6OtwK51SSBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TO5NBGA4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LdlkeoH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715852769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5a6IJhenQzXpAbOqnOLMPNsXtvNu5dVA873wpwAdiZs=;
	b=TO5NBGA4lW9jHLbhhAoS12g3bSv1mVBehSmgtJ+xVAu8m9OuOVJb2FdJl5u62XhaCI2iI3
	Fv0lWkkNStAFWD1/DnXJBDcoUmDKuSA621t1lwjUw1dZHdLqE3zP9yVK1qFZbDJs2i8sDh
	u6U/yGBjzXqRRCfyGrn5NVD3LasCkAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715852769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5a6IJhenQzXpAbOqnOLMPNsXtvNu5dVA873wpwAdiZs=;
	b=LdlkeoH9RK93OBFYiHWvmYaIjyZ0VWwlSv4VxCFICLNajWWIc6pZ6Wox4rJ0lBrqadO+IY
	TbQfc6OtwK51SSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C751513991;
	Thu, 16 May 2024 09:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLXWLeDVRWZLbgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 09:46:08 +0000
Date: Thu, 16 May 2024 11:46:07 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm/memory-failure: improve memory failure
 action_result messages
Message-ID: <ZkXV3wDlfo3rzN1X@localhost.localdomain>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-4-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510062602.901510-4-jane.chu@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 41C9F34741
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Fri, May 10, 2024 at 12:26:00AM -0600, Jane Chu wrote:
> Added two explicit MF_MSG messages describing failure in get_hwpoison_page.
> Attemped to document the definition of various action names, and made a few
> adjustment to the action_result() calls.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
..  
> +/*
> + * MF_IGNORED - Either the m-f() handler did nothing to recover, or it did
"or if it "
> + *   something, then caught in a race condition which renders the effort sort
"it was caught"

I would also add to MF_IGNORED that we mark the page hwpoisoned anyway.
  
> @@ -1018,7 +1034,7 @@ static int me_unknown(struct page_state *ps, struct page *p)
>  {
>  	pr_err("%#lx: Unknown page state\n", page_to_pfn(p));
>  	unlock_page(p);
> -	return MF_FAILED;
> +	return MF_IGNORED;
>  }

I was confused because I saw you replaced all MF_MSG_UNKNOWN, so I
wondered how we can end up here until I saw this is a catch-all in case
we fail to make sense of the page->flags.
While you are improving this, I would suggest to add a little comment
above the function explaining how we can reach it.

>  /*
> @@ -2055,6 +2071,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		if (flags & MF_ACTION_REQUIRED) {
>  			folio = page_folio(p);
>  			res = kill_accessing_process(current, folio_pfn(folio), flags);
> +			return action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);

I do not understand why are you doing this.

First of all, why is this considered a failure? We did not fail this
time, did we? We went right ahead and kill the process which was
re-accessing the hwpoisoned page. Is that considered a failure?

Second, you are know supressing -EHWPOISON with whatever action_result()
will gives us, which judging from the actual code would be -EBUSY?
I do not think that that is right, and we should be returning
-EHWPOISON. Or whatever error code kill_accessing_process() gives us.


> @@ -2231,6 +2248,7 @@ int memory_failure(unsigned long pfn, int flags)
>  			res = kill_accessing_process(current, pfn, flags);
>  		if (flags & MF_COUNT_INCREASED)
>  			put_page(p);
> +		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);

This is not coherent with what you did in try_memory_failure_hugetlb
for MF_MSG_ALREADY_POISONED, I __think__ that in there we should be
doing the same as we do here.

 

-- 
Oscar Salvador
SUSE Labs

