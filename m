Return-Path: <linux-kernel+bounces-397999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E79BE3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0895328900D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013771DDC34;
	Wed,  6 Nov 2024 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQso9PjM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bouy2adX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQso9PjM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bouy2adX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD491DE3B6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887996; cv=none; b=Mng36uM4/XYdVWAIuNrZgx3tqW/1GX0dwt8ql806EH6pJTkRi0Z4q/Sb6T5iKLqRuy+xuofaTFtPt5RcKNOJiLDX9Y2Z61mAlLZZVAKGhARlrwRc4nILTxJNzCxHu8mWRfg2O/a28NWGoPypXPNCCSB9Ew2h77/owsHqCmA+OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887996; c=relaxed/simple;
	bh=eUhWf+/0RuYiseNmBrEFp9ONV6mjmeUfT3c0FrVnbRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H62aq43awqgDWBV+nRhw0oEqG41OJODjF1bUaGcp/dEZkQrFUCf3uIYwIpl3iIMi5dOECeiRzQ8XS/+m/4FgnLjT1zzVlHY5FYIoiQkFu9QnBPWCXYcHqevUjkS4uz0AzBNLUT7+l6huwHKBzTHjuiaSSpJGY/cjozE7ZILCZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQso9PjM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bouy2adX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQso9PjM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bouy2adX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8017E1FB41;
	Wed,  6 Nov 2024 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730887992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LME6K5OzSMusf8J6UQPQJ71HsTjrNQCgsWOEhpq3SVI=;
	b=FQso9PjM67FszQ9RYH4N0oMQfXUcOVaNYOrN5iKwn2AZSeA4ZWJMwI9AvbSXb93Yel056V
	LfZR9vw8IwjIvnTUtmYIIhw56snLyZYp1ULE075KnGAveYk59e2hFyLbhqOBbHbGIzBNH2
	EzsgY7xBWiJMP276p1/cXhzZlczgMlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730887992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LME6K5OzSMusf8J6UQPQJ71HsTjrNQCgsWOEhpq3SVI=;
	b=bouy2adXyRQf2lJ9CE1yEk5maImFkQaN5mSWI8Pph4w51pvFwWLXvIZIlsuKk6Ik2aVfKr
	TpYL2/FgeupoczAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FQso9PjM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bouy2adX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730887992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LME6K5OzSMusf8J6UQPQJ71HsTjrNQCgsWOEhpq3SVI=;
	b=FQso9PjM67FszQ9RYH4N0oMQfXUcOVaNYOrN5iKwn2AZSeA4ZWJMwI9AvbSXb93Yel056V
	LfZR9vw8IwjIvnTUtmYIIhw56snLyZYp1ULE075KnGAveYk59e2hFyLbhqOBbHbGIzBNH2
	EzsgY7xBWiJMP276p1/cXhzZlczgMlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730887992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LME6K5OzSMusf8J6UQPQJ71HsTjrNQCgsWOEhpq3SVI=;
	b=bouy2adXyRQf2lJ9CE1yEk5maImFkQaN5mSWI8Pph4w51pvFwWLXvIZIlsuKk6Ik2aVfKr
	TpYL2/FgeupoczAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F9A0137C4;
	Wed,  6 Nov 2024 10:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lXnAzdBK2ftYQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 06 Nov 2024 10:13:11 +0000
Date: Wed, 6 Nov 2024 11:13:09 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Ackerley Tng <ackerleytng@google.com>
Cc: muchun.song@linux.dev, peterx@redhat.com, akpm@linux-foundation.org,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	david@redhat.com, isaku.yamahata@intel.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com,
	jhubbard@nvidia.com, seanjc@google.com, pbonzini@redhat.com,
	erdemaktas@google.com, vannapurve@google.com, pgonda@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] mm: hugetlb: Simplify logic in
 dequeue_hugetlb_folio_vma()
Message-ID: <ZytBNcUUpDBL3Sm4@localhost.localdomain>
References: <cover.1728684491.git.ackerleytng@google.com>
 <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
X-Rspamd-Queue-Id: 8017E1FB41
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, Oct 11, 2024 at 11:22:36PM +0000, Ackerley Tng wrote:
> Replace arguments avoid_reserve and chg in dequeue_hugetlb_folio_vma()
> so dequeue_hugetlb_folio_vma() is more understandable.
> 
> The new argument, use_hstate_resv, indicates whether the folio to be
> dequeued should be taken from reservations in hstate.
> 
> If use_hstate_resv is true, the folio to be dequeued should be taken
> from reservations in hstate and hence h->resv_huge_pages is
> decremented, and the folio is marked so that the reservation is
> restored.
> 
> If use_hstate_resv is false, then a folio needs to be taken from the
> pool and hence there must exist available_huge_pages(h), failing
> which, goto err.
> 
> The bool use_hstate_resv can be reused within
> dequeue_hugetlb_folio_vma()'s caller, alloc_hugetlb_folio().
> 
> No functional changes are intended.
> 
> As proof, the original two if conditions
> 
> !vma_has_reserves(vma, chg) && !available_huge_pages(h)
> 
> and
> 
> avoid_reserve && !available_huge_pages(h)
> 
> can be combined into
> 
> (avoid_reserve || !vma_has_reserves(vma, chg))
> && !available_huge_pages(h).
> 
> Applying de Morgan's theorem on
> 
> avoid_reserve || !vma_has_reserves(vma, chg)
> 
> yields
> 
> !avoid_reserve && vma_has_reserves(vma, chg),
> 
> hence the simplification is correct.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

I like this, it is a nice simplification and hugetlb revervation
mechanism is already hard enough to follow.

As already mentioned, Sean's changes look easier to follow.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

On a side note, we might want to convert the 'avoid_reserve' param from
alloc_hugetlb_folio into a bool, as we are using it exactly like that,
so it would seem more natutal.

> ---
>  mm/hugetlb.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..73165c670739 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1281,8 +1281,9 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  	}
> 
>  	/*
> -	 * Only the process that called mmap() has reserves for
> -	 * private mappings.
> +	 * Only the process that called mmap() has reserves for private
> +	 * mappings. A child process with MAP_PRIVATE mappings created by their
> +	 * parent have no page reserves.

'page reserves' looks odd. I would say 'reservations'.


-- 
Oscar Salvador
SUSE Labs

