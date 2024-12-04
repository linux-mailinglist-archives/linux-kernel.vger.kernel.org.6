Return-Path: <linux-kernel+bounces-430829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB49E3622
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD3C280EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E101A08CB;
	Wed,  4 Dec 2024 09:03:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41D1917C7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303011; cv=none; b=RavbmTgvTIlga3AdG0hNb6OvlckR3oP++KVsHo73dfr3C4KEQ4hoOoLJB6ckravSE2QjbNuEiMVYhr92+IArKrJ3CV/t0X+7hcz4HVt3EEDhVUW7KKA11m/eclBo3poyp8YTYnG/E5Bh9DVqCN8gHcUoWWOxbB2szS4TiUstNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303011; c=relaxed/simple;
	bh=2Fwb9FRusdCQDX3x+tCsy/e/ftT++2gkMtJd4sEr6z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWoEzuIxiBIHOGRGZBwejVdRqh/sGfQSjxyaHaXttYHs3s9+KwoJG39IeUcki/oGcSjquIN5zIxD2g5YmIj9bad/GmHSiUD/wXUVV5BiVWUboT71YlE99sGrh4izOwnBXMlX0xJh8Ni0hiCLM5jlJbsOpH5kk25t1jM4HcQ5Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5F91F45F;
	Wed,  4 Dec 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AC88139C2;
	Wed,  4 Dec 2024 09:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DfrUFt8aUGfgZAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Dec 2024 09:03:27 +0000
Date: Wed, 4 Dec 2024 10:03:25 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 5/6] mm/page_alloc: forward the gfp flags from
 alloc_contig_range() to post_alloc_hook()
Message-ID: <Z1Aa3SjgMCS59agm@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-6-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-6-david@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0E5F91F45F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, Dec 03, 2024 at 10:47:31AM +0100, David Hildenbrand wrote:
> In the __GFP_COMP case, we already pass the gfp_flags to
> prep_new_page()->post_alloc_hook(). However, in the !__GFP_COMP case, we
> essentially pass only hardcoded __GFP_MOVABLE to post_alloc_hook(),
> preventing some action modifiers from being effective..
> 
> Let's pass our now properly adjusted gfp flags there as well.
> 
> This way, we can now support __GFP_ZERO for alloc_contig_*().
> 
> As a side effect, we now also support __GFP_SKIP_ZERO and__GFP_ZEROTAGS;
> but we'll keep the more special stuff (KASAN, NOLOCKDEP) disabled for
> now.
> 
> It's worth noting that with __GFP_ZERO, we might unnecessarily zero pages
> when we have to release part of our range using free_contig_range() again.
> This can be optimized in the future, if ever required; the caller we'll
> be converting (powernv/memtrace) next won't trigger this.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

