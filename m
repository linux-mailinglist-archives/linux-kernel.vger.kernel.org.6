Return-Path: <linux-kernel+bounces-430916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B816D9E3720
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7895728AD51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8B1917D0;
	Wed,  4 Dec 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AUbPhStJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dkyMDhkV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AUbPhStJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dkyMDhkV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B0187561
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306674; cv=none; b=lrkBX64SQTq3FEDQi9FzLkS/bdyxj/VQf6m5dYTkUe5JI24G2mbGhqu/BC8fsi4YStHjOkBJNGEr8e5WzlmR2pgPXIRRsKZU4er9NPCJxnMVadhdYhJTkuJee2xsKUd6tBQPiQ96Bp1ZoTm2dMi7i9bq3j3XwQQtlUk9ABFTfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306674; c=relaxed/simple;
	bh=eK9/NUqTGJF5Z3QRPgehKRV93VI6WmVYNn30lsRPe4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMkgP7oNsUx0KaoFDsOEQHY/kdMS8riCf3JfLw1uMvlgxYtCv2iIHl/rxFfbs35UiMJrXjKieMkvGharJFOUhy9Q/1O0vIFZGfMA4UXCqu/jZYP0IjzHDZXPjO3ZXVesF2l7ScshOjT8wljYYwgzbOYfkmP5lM02lXWv/S4Um6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AUbPhStJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dkyMDhkV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AUbPhStJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dkyMDhkV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1E402115E;
	Wed,  4 Dec 2024 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733306670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy7OLEHT9rPxg4WvTixZV3fgQXGtfE/zFSKuC+qdFso=;
	b=AUbPhStJ9yLoo6V50DDcNOU42gZHOU/H3vOQfmxAS7nnzu3mUSgDU/5wbUoWW2ncTaNGpD
	BbGdUg0waSbq+6zkHZ/ATIAUXIX7VCyiLnFz1o8url87wKJoiBaXhDJ8M1XRemRPlMPCbj
	HGWj4jgvFngkJBE8qYMVi50PgwUkvFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733306670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy7OLEHT9rPxg4WvTixZV3fgQXGtfE/zFSKuC+qdFso=;
	b=dkyMDhkVk9mDPsH6MkoIidfsFFWuhjQdK3ZtCKOSv3p4X1FupD0yvwe+1mxVzqnkchxQfY
	TWUOPOj1YIi5flAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733306670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy7OLEHT9rPxg4WvTixZV3fgQXGtfE/zFSKuC+qdFso=;
	b=AUbPhStJ9yLoo6V50DDcNOU42gZHOU/H3vOQfmxAS7nnzu3mUSgDU/5wbUoWW2ncTaNGpD
	BbGdUg0waSbq+6zkHZ/ATIAUXIX7VCyiLnFz1o8url87wKJoiBaXhDJ8M1XRemRPlMPCbj
	HGWj4jgvFngkJBE8qYMVi50PgwUkvFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733306670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy7OLEHT9rPxg4WvTixZV3fgQXGtfE/zFSKuC+qdFso=;
	b=dkyMDhkVk9mDPsH6MkoIidfsFFWuhjQdK3ZtCKOSv3p4X1FupD0yvwe+1mxVzqnkchxQfY
	TWUOPOj1YIi5flAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F8C1396E;
	Wed,  4 Dec 2024 10:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id toxJBS4pUGfEdwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Dec 2024 10:04:30 +0000
Date: Wed, 4 Dec 2024 11:04:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
Message-ID: <Z1ApKEC-_OPPreun@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
 <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
 <Z1AaC5Hj2RV_5FDD@localhost.localdomain>
 <15096b27-6f27-45fc-8a8b-de781a9c42a5@suse.cz>
 <Z1AdotZfAJG-zVZX@localhost.localdomain>
 <cee06baa-8561-4be3-8f5c-ca453f58950b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee06baa-8561-4be3-8f5c-ca453f58950b@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,lists.ozlabs.org,linux-foundation.org,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, Dec 04, 2024 at 10:28:39AM +0100, David Hildenbrand wrote:
> On 04.12.24 10:15, Oscar Salvador wrote:
> > On Wed, Dec 04, 2024 at 10:03:28AM +0100, Vlastimil Babka wrote:
> > > On 12/4/24 09:59, Oscar Salvador wrote:
> > > > On Tue, Dec 03, 2024 at 08:19:02PM +0100, David Hildenbrand wrote:
> > > > > It was always set using "GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL",
> > > > > and I removed the same flag combination in #2 from memory offline code, and
> > > > > we do have the exact same thing in do_migrate_range() in
> > > > > mm/memory_hotplug.c.
> > > > > 
> > > > > We should investigate if__GFP_HARDWALL is the right thing to use here, and
> > > > > if we can get rid of that by switching to GFP_KERNEL in all these places.
> > > > 
> > > > Why would not we want __GFP_HARDWALL set?
> > > > Without it, we could potentially migrate the page to a node which is not
> > > > part of the cpuset of the task that originally allocated it, thus violating the
> > > > policy? Is not that a problem?
> > > 
> > > The task doing the alloc_contig_range() will likely not be the same task as
> > > the one that originally allocated the page, so its policy would be
> > > different, no? So even with __GFP_HARDWALL we might be already migrating
> > > outside the original tasks's constraint? Am I missing something?
> > 
> > Yes, that is right, I thought we derive the policy from the old page
> > somehow when migrating it, but reading the code does not seem to be the
> > case.
> > 
> > Looking at prepare_alloc_pages(), if !ac->nodemask, which would be the
> > case here, we would get the policy from the current task
> > (alloc_contig_range()) when cpusets are enabled.
> > 
> > So yes, I am a bit puzzled why __GFP_HARDWALL was chosen in the first
> > place.
> 
> I suspect because "GFP_USER" felt like the appropriate thing to do.

Looking back at when the whole contiguous allocator patchset was posted,
it seems that it kinda copied what memory-offline code was doing, which
was migrating pages with GFP_HIGHUSER_MOVABLE (hotremove_migrate_alloc()).

Then, the HIGHMEM modifier was dropped due to HIGHMEM restrictions on
some systems, ending up with GFP_USER.


-- 
Oscar Salvador
SUSE Labs

