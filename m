Return-Path: <linux-kernel+bounces-430843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541F9E3655
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD772823E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28A19DF66;
	Wed,  4 Dec 2024 09:15:28 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861017B50E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303728; cv=none; b=sIeRMwvha2XJY1fCy8J4pz/0wVjMeV3NQsMWBIxqp1+135oIsx+vlq1anSHVvOnM8UQf8QdTYgr+GAnILPH2B+M5OWyBqpFeEFbLuKC18I/AFgN9UVhptQ18T0eWkDwWLvLqoaX/zVxvb4sSgPpIsLAKG+IfP1IRKgeOZ6EmqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303728; c=relaxed/simple;
	bh=OSIQVeqA7BjoP8zOcS1ipuCVyk4y5qwnWOvjFzpXt3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4XVhprDQo4I/FrRi4jI7rbnMORu45EY+lTIFGKe4Ra3+2IizvlHDClaWUxGRsUOU68WFXb/Qglv/laBU3dkdIKcKsjj22iYVRtR5wY7MdVxgDlNhzmWAH1u94ijXIclH5r+sLbtVxr1gbYjIsQAeXX2gTLbAr8G9PGMAz1dfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F26A72115C;
	Wed,  4 Dec 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51565139C2;
	Wed,  4 Dec 2024 09:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wN0nEawdUGfYaAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Dec 2024 09:15:24 +0000
Date: Wed, 4 Dec 2024 10:15:14 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
Message-ID: <Z1AdotZfAJG-zVZX@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
 <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
 <Z1AaC5Hj2RV_5FDD@localhost.localdomain>
 <15096b27-6f27-45fc-8a8b-de781a9c42a5@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15096b27-6f27-45fc-8a8b-de781a9c42a5@suse.cz>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: F26A72115C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Wed, Dec 04, 2024 at 10:03:28AM +0100, Vlastimil Babka wrote:
> On 12/4/24 09:59, Oscar Salvador wrote:
> > On Tue, Dec 03, 2024 at 08:19:02PM +0100, David Hildenbrand wrote:
> >> It was always set using "GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL",
> >> and I removed the same flag combination in #2 from memory offline code, and
> >> we do have the exact same thing in do_migrate_range() in
> >> mm/memory_hotplug.c.
> >> 
> >> We should investigate if__GFP_HARDWALL is the right thing to use here, and
> >> if we can get rid of that by switching to GFP_KERNEL in all these places.
> > 
> > Why would not we want __GFP_HARDWALL set?
> > Without it, we could potentially migrate the page to a node which is not
> > part of the cpuset of the task that originally allocated it, thus violating the
> > policy? Is not that a problem?
> 
> The task doing the alloc_contig_range() will likely not be the same task as
> the one that originally allocated the page, so its policy would be
> different, no? So even with __GFP_HARDWALL we might be already migrating
> outside the original tasks's constraint? Am I missing something?

Yes, that is right, I thought we derive the policy from the old page
somehow when migrating it, but reading the code does not seem to be the
case.

Looking at prepare_alloc_pages(), if !ac->nodemask, which would be the
case here, we would get the policy from the current task
(alloc_contig_range()) when cpusets are enabled.

So yes, I am a bit puzzled why __GFP_HARDWALL was chosen in the first
place.


-- 
Oscar Salvador
SUSE Labs

