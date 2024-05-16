Return-Path: <linux-kernel+bounces-181052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8628C76CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5327B1C20E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC856146005;
	Thu, 16 May 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yxtGzDPQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9IOcnl6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yxtGzDPQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9IOcnl6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DB3A1B7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863631; cv=none; b=ZjFqYRaCdCI+DiRmdv0Yota81OLFk/3Hr41dFCfEoK4/RUYbgksxYUXV207Yjteq+jClYhERoid9KqvZEcCt8AwgSIHVbE2r83fSPwy2dX+QVHWjfZ9k0ehdv5+zi4KBBdrJLjJzHeYiGMcPedWlbrlydDXX7P+7KV1sCVv3L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863631; c=relaxed/simple;
	bh=N4XtJk61jiIC6+ZqtkoIDnGLQX+KPmLZ6o29Z+dVyBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbceYNvP40ZxTAEHo/kOICKm00bVILT5LHLJUVBWW0HJiB9XCxQe+ajXimEo1mv84lpWj7n1gleTcdwgN2FPMnvImd8TjESIABRhTDOtjaEEHSVq+v/4LbiO0NA8k5eKYEu4Dh+z3Ti9O517c2eGzG4z4H+EvYR7IEl3D5TX/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yxtGzDPQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9IOcnl6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yxtGzDPQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9IOcnl6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69ACD34940;
	Thu, 16 May 2024 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715863627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uunt0wltRfjPfUxaO1z16wqwyf23EJvV6VQSXtDXjQ=;
	b=yxtGzDPQYvGfNYfJcuPm0QDabpmpGL4MyQoXPH7E3Kei/l1ld2Vs7oMAjLsnMZYefC+XyU
	Fd6SLhSFqzQY6u6AXqQVAbC5Lxw7edwEc0A2Fue0HhBgNvCPpfHpyJrcSY5LRAiaGUuRa7
	AhWO+2H0mT1IlHPyxZvS45zfcfEqgS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715863627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uunt0wltRfjPfUxaO1z16wqwyf23EJvV6VQSXtDXjQ=;
	b=D9IOcnl6NhZrbmCbZ1pgb5ON6qGsbNBaymMRAfZVtJH5icBX+7udSYYORpBIsB9Ndcpawp
	XwsCI3y4fEZaqXBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yxtGzDPQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D9IOcnl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715863627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uunt0wltRfjPfUxaO1z16wqwyf23EJvV6VQSXtDXjQ=;
	b=yxtGzDPQYvGfNYfJcuPm0QDabpmpGL4MyQoXPH7E3Kei/l1ld2Vs7oMAjLsnMZYefC+XyU
	Fd6SLhSFqzQY6u6AXqQVAbC5Lxw7edwEc0A2Fue0HhBgNvCPpfHpyJrcSY5LRAiaGUuRa7
	AhWO+2H0mT1IlHPyxZvS45zfcfEqgS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715863627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Uunt0wltRfjPfUxaO1z16wqwyf23EJvV6VQSXtDXjQ=;
	b=D9IOcnl6NhZrbmCbZ1pgb5ON6qGsbNBaymMRAfZVtJH5icBX+7udSYYORpBIsB9Ndcpawp
	XwsCI3y4fEZaqXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02033137C3;
	Thu, 16 May 2024 12:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rOU2OUoARmZhUgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 12:47:06 +0000
Date: Thu, 16 May 2024 14:47:01 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm/memory-failure: send SIGBUS in the event of
 thp split fail
Message-ID: <ZkYARVW2cOZcsFYB@localhost.localdomain>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-6-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510062602.901510-6-jane.chu@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 69ACD34940
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

On Fri, May 10, 2024 at 12:26:02AM -0600, Jane Chu wrote:
> When handle hwpoison in a RDMA longterm pinned thp page,
> try_to_split_thp_page() will fail. And at this point, there is
> little else the kernel could do except sending a SIGBUS to
> the user process, thus give it a chance to recover.

Well, it does need to be a RDMA longterm pinned, right?
Anything holding an extra refcount can already make us bite the dust, so
I would not make it that specific.


> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2fa884d8b5a3..15bb1c0c42e8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1697,7 +1697,7 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  	return page_action(ps, p, pfn);
>  }
>  
> -static int try_to_split_thp_page(struct page *page)
> +static int try_to_split_thp_page(struct page *page, bool release)
>  {
>  	int ret;
>  
> @@ -1705,7 +1705,7 @@ static int try_to_split_thp_page(struct page *page)
>  	ret = split_huge_page(page);
>  	unlock_page(page);
>  
> -	if (unlikely(ret))
> +	if (ret && release)
>  		put_page(page);

I would document whhen and when not we can release the page.
E.g: we cannot release it if there are still processes mapping the thp.


> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
> +				struct folio *folio)
> +{
> +	LIST_HEAD(tokill);
> +
> +	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> +	kill_procs(&tokill, true, pfn, flags);
> +
> +	return -EHWPOISON;

You are returning -EHWPOISON here,

> +}
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -2313,8 +2331,11 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p) < 0) {
> -			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
> +		if (try_to_split_thp_page(p, false) < 0) {
> +			pr_err("%#lx: thp split failed\n", pfn);
> +			res = kill_procs_now(p, pfn, flags, folio);
> +			put_page(p);
> +			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);

just to overwrite it here with action_result(). Which one do we need?
I think we would need -EBUSY here, right? So I would drop the retcode
from kill_procs_now.

Also, do we want the extra pr_err() here.
action_result() will already provide us the pfn and the
action_page_types which will be "unsplit thp". Is not that clear enough?

I would drop that.


-- 
Oscar Salvador
SUSE Labs

