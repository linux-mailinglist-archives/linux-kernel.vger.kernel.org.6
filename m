Return-Path: <linux-kernel+bounces-191297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91718D0979
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CB81C21C31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E815EFA8;
	Mon, 27 May 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JKtSKwrj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iGs8/JIe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYa+4d/N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jdFKt4D6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDD26AE7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831522; cv=none; b=M8K69JqRFAXsriIETXUm0HRsqanFL2BBR/yJZJHH2iTHdl5hpZbJrYX0VO3/VlQPH/cC5CbnJ0ipfS8TXvWokCS6jWi0+RzuYQsBFj6/3MQ8p4WASifAmCGSzXO4YY8jxwvfTfctEFmiScTNHaZCCHOSp3gQNvGj+h/57G2Ml5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831522; c=relaxed/simple;
	bh=WjogKuZyhWKP7mlud/9M5mfHu4805OM4J1Loe+DKdQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD7NMsJJBVloszIPszE0kObhmLD6ZY19RI0Zz8SwspQfLOt3RDNkKjGhqM8cOeFgZyL9fbv9A9TUc8zot2hD1EUrOOg9BiHQZcvDwzgKcVspFO+Q/JgmVpcOj9sDhm3sLtY3pFYxAg+H+CAnx+TcCI3QRnFbFVkjFntXubpoXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JKtSKwrj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iGs8/JIe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYa+4d/N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jdFKt4D6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 568611FE7D;
	Mon, 27 May 2024 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716831518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT7sqn3x8UqZ+1AY3VOfJjHycbhLSUy95jECA+AD8oM=;
	b=JKtSKwrjmHagzP6RUYMXRiXwFEIABFC7f/bWAa/BCdiK9UiD5e4uS6p9ENrP0l207QfdaK
	fSfjHrpimQW0vPZ7iC7affgwAX3UYTXuJ/Z8mvIXAya/Hjav0y5/o4JGx8+ijZS8IdXWHL
	QhnYuASSPy6/Rgcmhp2WdCJgVRSN/rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716831518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT7sqn3x8UqZ+1AY3VOfJjHycbhLSUy95jECA+AD8oM=;
	b=iGs8/JIe7rCcMdLVA7PNXtYwgdC6UB0aExVuW7ZzoRPpVqqriuspth/GNWs47jP7G+piUR
	j0mC7FPOI414uGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716831517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT7sqn3x8UqZ+1AY3VOfJjHycbhLSUy95jECA+AD8oM=;
	b=OYa+4d/Nch5DSsggH81xf/Q1oo2yugPgafbWBqHIB6IP/JwfbsDA1LQRxtnEY+KlNlgN/L
	bwCVogufWxV4EMEj6H7mgdCQAgwFx+EwabyK5eFhvAlmnq6STeZSBSgaJdbY0evecPFiKi
	v5+nrfiDiPzIXrpm8ziQY8m7kkLoWlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716831517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT7sqn3x8UqZ+1AY3VOfJjHycbhLSUy95jECA+AD8oM=;
	b=jdFKt4D6rQKp4EhxZ2EEhSFtydmFKSauIvzPcpTkovCA+dmq07/+pTm7ZjtG/zHUeGE4MZ
	zmSzqtAKjcNKABDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C4E13A6B;
	Mon, 27 May 2024 17:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pYxmLBzFVGaDewAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 17:38:36 +0000
Date: Mon, 27 May 2024 19:38:31 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v3 03/16] mm: Provide mm_struct and address to
 huge_ptep_get()
Message-ID: <ZlTFF7L3bcfUaJbg@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <fbba60d762faad40ebb959bf9517c5c22301f69e.1716714720.git.christophe.leroy@csgroup.eu>
 <ZlRsMCvVo9tSEFQV@localhost.localdomain>
 <22c4ba7c-28d2-43bd-81b6-bd63f77d1d9e@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c4ba7c-28d2-43bd-81b6-bd63f77d1d9e@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, May 27, 2024 at 03:51:41PM +0000, Christophe Leroy wrote:
> We could be is that worth the churn ?

Probably not.

> With patch 1 there was only one callsite.

Yes, you are right here.

> Here we have many callsites, and we also have huge_ptep_get_and_clear() 
> which already takes three arguments. So for me it make more sense to 
> adapt huge_ptep_get() here.
> 
> Today several of the huge-related functions already have parameters that 
> are used only by a few architectures and everytime one architecture 
> needs a new parameter it is added for all of them, and there are 
> exemples in the past of new functions added to get new parameters for 
> only a few architectures that ended up with a mess and a need to 
> re-factor at the end.
> 
> See for instance the story around arch_make_huge_pte() and pte_mkhuge(), 
> both do the same but arch_make_huge_pte() was added to take additional 
> parameters by commit d9ed9faac283 ("mm: add new arch_make_huge_pte() 
> method for tile support") then they were merged by commit 16785bd77431 
> ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")
> 
> So I'm open to any suggestion but we need to try not make it a bigger 
> mess at the end.
> 
> By the way, I think most if not all huge related helpers should all take 
> the same parameters even if not all of them are used, then it would make 
> things easier. And maybe the cleanest would be to give the page size to 
> all those functions instead of having them guess it.
> 
> So let's have your ideas here on the most straight forward way to handle 
> that.

It is probably not worth pursuing this then.
As you said, there are many callers and we would have to create some kind of hook
for only those interested places, which I guess would end up looking just too ugly
in order to save little code in arch code.

So please disregard my comment here, and stick with what we have.

> By the way, after commit 01d89b93e176 ("mm/gup: fix hugepd handling in 
> hugetlb rework") we now have the vma in gup_hugepte() so we now pass 
> vma->vm_mm

I did not notice, thanks.


-- 
Oscar Salvador
SUSE Labs

