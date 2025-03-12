Return-Path: <linux-kernel+bounces-558021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB0A5E08D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8209B19C0534
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD06256C9B;
	Wed, 12 Mar 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IqdrYTHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="00RXRHR8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F0BePVfH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2grvEfKj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9B254875
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793803; cv=none; b=Zff0GpMZkcz9Ct5rZuZ5b6IqkXK2JuxL8yOXWa997UmyFDNLo/dW4wKlsuG7dhg/ez9kH+A4R+EEnaIW5I1BVf5FzVzmRS1brrp4lY6OH4YI7kJkaS39hLq3oK1ZN85gcoK3G7VvcBbDXwquIdkykoyRFJ/ACZNCaYmsKPo1FDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793803; c=relaxed/simple;
	bh=qFY9VG5oi6Bf7Am2zf01UPtIpoT1kADJtAHZY/KSbhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVgEH4AYfWEQQlk5Xz+3f7RhQw6WjIG6Ho0y2KIISQv6nx4/kXqdwBXt6ypdT/CXNGcn1ONR3bv/y1hqtwbhzryxJEHQcZjB8bQnw24TBoCOBbrcgujmTcKEP/8vthfmYVl2RHNmH+3mndhuKzYwsv8oIV0OBeaENrk3HZ4hO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IqdrYTHh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=00RXRHR8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F0BePVfH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2grvEfKj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id E3387211CF;
	Wed, 12 Mar 2025 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741793800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8M8QqGtnL0HTCgbbxAWVuYLqQ6RLyqgkzfCrg0ngE=;
	b=IqdrYTHh2O1WJBtSCpzlk273Zt5h6e8rO0dR2KFjC2fVNtLdP/ovRaIhvL+f6i2co2o+Yd
	jmyQIkNa2eWRFwFe65cnJqSHbCwucvSaZ62hDpDrYweHkTeknMV77FZ/m92HWwZ4Pnk/cf
	dec26tzrzRkoxswRSCD78KgZaDSxpdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741793800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8M8QqGtnL0HTCgbbxAWVuYLqQ6RLyqgkzfCrg0ngE=;
	b=00RXRHR8be3lFO5p2b/GOxRHVa6IpgwxIG0VashnlL1qcVGU+oVM6ojmKFV6+IBKf1e/Gw
	p+nlVUkAghlRaoCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741793799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8M8QqGtnL0HTCgbbxAWVuYLqQ6RLyqgkzfCrg0ngE=;
	b=F0BePVfHsxyFXqqhCO7tBiewuL/s48a8aBEBqcJGc2/kJzJ0Ln4Xfqz0iV7d/NcqM8nM9g
	F8/JX19ROYWUY2u1o0aE5l6eco/eODi4J1LW1y/ZYW8rXE5XxqVm+lx2aU348uLZ1KSju0
	aSQD3heH20L76U+dzs6v8QjurfyEERw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741793799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8M8QqGtnL0HTCgbbxAWVuYLqQ6RLyqgkzfCrg0ngE=;
	b=2grvEfKjon+NHI/ZnIAQ4NdBzQOqwo02KtUjYyBv5c/Wk2EC8H2mKuNpUvA6Lnspkd79fT
	qmTtf/72BliDwvDQ==
Date: Wed, 12 Mar 2025 16:36:39 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <Z9GqB1cRSD-IQM_s@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Mar 03, 2025 at 09:25:30AM +0100, David Hildenbrand wrote:
> On 20.02.25 17:48, Jiri Bohac wrote:
> > 
> > By reserving additional crashkernel memory from CMA, the main
> > crashkernel reservation can be just large enough to fit the
> > kernel and initrd image, minimizing the memory taken away from
> > the production system. Most of the run-time memory for the crash
> > kernel will be memory previously available to userspace in the
> > production system. As this memory is no longer wasted, the
> > reservation can be done with a generous margin, making kdump more
> > reliable. Kernel memory that we need to preserve for dumping is
> > never allocated from CMA. User data is typically not dumped by
> > makedumpfile. When dumping of user data is intended this new CMA
> > reservation cannot be used.
> 
> I'll note that your comment about "user space" is currently the case, but
> will likely not hold in the long run. The assumption you are making is that
> only user-space memory will be allocated from MIGRATE_CMA, which is not
> necessarily the case. Any movable allocation will end up in there.
> 
> Besides LRU folios (user space memory and the pagecache), we already support
> migration of some kernel allocations using the non-lru migration framework.
> Such allocations (which use __GFP_MOVABLE, see __SetPageMovable()) currently
> only include
> * memory balloon: pages we never want to dump either way
> * zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
> * z3fold (->zpool): only used by zswap (-> compressed LRU pages)
> 
> Just imagine if we support migration of other kernel allocations, such as
> user page tables. The dump would be missing important information.
> 
> Once that happens, it will become a lot harder to judge whether CMA can be
> used or not. At least, the kernel could bail out/warn for these kernel
> configs.

Thanks for ponting this out. I still don't see this as a
roadblock for my primary usecase of the CMA reservation: 
get at least some (less reliable and potentially
less useful) kdump where the user is not prepared to sacrifice
the memory needed for the standard reservation and where the only
other option is no kdump at all.

Still a lot can be analyzed with a vmcore that is missing those
__GFP_MOVABLE pages. Even if/when some user page tables are
missing.

I'll send a v3 with the documenatation part updated to better
describe this.

> > The fourth patch adds a short delay before booting the kdump
> > kernel, allowing pending DMA transfers to finish.
> 
> 
> What does "short" mean? At least in theory, long-term pinning is forbidden
> for MIGRATE_CMA, so we should not have such pages mapped into an iommu where
> DMA can happily keep going on for quite a while.
 
See patch 4/5 in the series:
I propose 1 second, which is a negligible time from the kdump POV
but I assume it should be plenty enough for non-long-term pins in
MIGRATE_CMA. 

> But that assumes that our old kernel is not buggy, and doesn't end up
> mapping these pages into an IOMMU where DMA will just continue. I recall
> that DRM might currently be a problem, described here [1].
>
> If kdump starts not working as expected in case our old kernel is buggy,
> doesn't that partially destroy the purpose of kdump (-> debug bugs in the
> old kernel)?

Again, this is meant as a kind of "lightweight best effort
kdump". If there is a bug that causes the crash _and_ a bug in a
driver that hogs MIGRATE_CMA and maps it into IOMMU then this
lightweight kdump may break. Then it's time to sacrifice more
memory and use a normal crashkernel reservation.

It's not like any bug in the old kernel will break it. It's a
very specific kind of bug that can potentially break it.

I see this whole thing as particularly useful for VMs. Unlike big
physical machines, where taking away a couple hundred MBs of
memory for kdump does not really hurt, a VM can ideally be given just
enough memory for its particular task. This can often be less
than 1 GB. Proper kdump reservation needs a couple hundred MBs,
so a very large proportion of the VM memory. In case of a
virtualization host running hundreds or thousands such VMs this
means a huge waste of memory. And VMs often don't use too many
drivers for real hardware, decreasing the risk of hitting a buggy
driver like this.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


