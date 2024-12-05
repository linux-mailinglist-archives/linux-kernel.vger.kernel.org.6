Return-Path: <linux-kernel+bounces-432848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C49E5101
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C90161F64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F51D0F61;
	Thu,  5 Dec 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MIT9aWdY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPf1E07q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MIT9aWdY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPf1E07q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CE17B506
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390219; cv=none; b=SGLE3WwMtzOqX1yzZdYoBKvjyMdFgZJDavpzFFQX96hhn5WjN5e4wQvA1rsaqeYqrrj3d/asYqIkCv7VvSZt6VbhKCy+l1WnI5QJFubJIy3kfzwPUDaiYithff1QuC25m4hcKqMIIM+hKjamp8vCaGH4HIsiM30FZSoKTOOzoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390219; c=relaxed/simple;
	bh=vSkIzMq+Das5sI2bQNWyBISOYHzGh4ObflhpLenZpSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIz3SqKDMGagdlhIFVQof3UAI2f1eL/yzV/zT9kIs4BNsl5vXFqE0briIAsuKFTokmJ+DsEfGtkPSIs3llGBTAFZL8zF5Qr4qD5pAQG2pZpvlBwIlxkAQkYrupjUpSz1Kh+HQYd5W5X/5WPWQbS5u+0CosGSgagWPi0KSqXskWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MIT9aWdY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPf1E07q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MIT9aWdY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPf1E07q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BD032120A;
	Thu,  5 Dec 2024 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733390210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Exos+Q3ir5xTGxhDlEiLEF409xFDOMwB2dsvHmrGW3E=;
	b=MIT9aWdYDvLSgewREbp9gRVo6oeMLRUjzAyGDtRJEJWH0nTnm04bf8qnqtrFaVt0lGo3OX
	LGd6tLLfV/BE0iLOUcyMkT8aurWBZltHFwvpWnfNhL/RSi28ZiDs3dnWMCLv1XAzEa/QO3
	ascFbNjtjisxoWOJw323IS0sRI87CtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733390210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Exos+Q3ir5xTGxhDlEiLEF409xFDOMwB2dsvHmrGW3E=;
	b=DPf1E07qO+1y3XQ4S4GsgoATOUxRYecBy2oP4skuAdX5AVB0zpDTpelniyOkYxMfBB5dcp
	fIRIjNNzqiabF4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733390210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Exos+Q3ir5xTGxhDlEiLEF409xFDOMwB2dsvHmrGW3E=;
	b=MIT9aWdYDvLSgewREbp9gRVo6oeMLRUjzAyGDtRJEJWH0nTnm04bf8qnqtrFaVt0lGo3OX
	LGd6tLLfV/BE0iLOUcyMkT8aurWBZltHFwvpWnfNhL/RSi28ZiDs3dnWMCLv1XAzEa/QO3
	ascFbNjtjisxoWOJw323IS0sRI87CtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733390210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Exos+Q3ir5xTGxhDlEiLEF409xFDOMwB2dsvHmrGW3E=;
	b=DPf1E07qO+1y3XQ4S4GsgoATOUxRYecBy2oP4skuAdX5AVB0zpDTpelniyOkYxMfBB5dcp
	fIRIjNNzqiabF4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04A75132EB;
	Thu,  5 Dec 2024 09:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OUfuOYFvUWcNfwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 05 Dec 2024 09:16:49 +0000
Date: Thu, 5 Dec 2024 10:16:44 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RESEND v1 0/2] mm: don't use __GFP_HARDWALL when
 migrating remote pages
Message-ID: <Z1FvfEwhvaZGJm7-@localhost.localdomain>
References: <20241205090508.2095225-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205090508.2095225-1-david@redhat.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Dec 05, 2024 at 10:05:06AM +0100, David Hildenbrand wrote:
> Resending via a known-working SMTP setup.
> 
> ---
> 
> __GFP_HARDWALL means that we will be respecting the cpuset of the caller
> when allocating a page. However, when we are migrating remote allocations
> (pages allocated from other context), the cpuset of the current context
> is irrelevant.
> 
> For memory offlining + alloc_contig_*(), this is rather obvious. There
> might be other such page migration users, let's start with the obvious
> ones.

After the insight we gained from yesterday's discussion, this makes a
lot of sense, and I suspect this was one of those "that code makes it
that way, let's copy it just in case".
I will go through the patches later today and give me ack.

As you mentioned, migration code could potentially derive the policy
of the old pages and try to respect that when __HARDWALL.

It might not be possible though, but I guess it is a worth a shot.
I will try to investigate and see whether that is feasible.


-- 
Oscar Salvador
SUSE Labs

