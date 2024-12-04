Return-Path: <linux-kernel+bounces-430825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAE9E3617
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2169616603C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A4619068E;
	Wed,  4 Dec 2024 09:00:44 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DF189F57
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302844; cv=none; b=fbrfkVGsifbEMXnbjLS64RVG5Pgrom1U+pyFgrdy7NpWz+Go822R0ITjnSoJXEPVy93PXhHBMNVALeodVA2MAXnzh5TtKdwaKHcD3eCLOalTcLlpEZ47K75TH8rwYF68Xt++24nK1ZdICsSVo1e8QyH9O3xP6M6CuKvA8f/K3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302844; c=relaxed/simple;
	bh=VFGn/i2mswdUo9vJGn70rNcLBz73roL+GQEm5meiYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh4AlxgOsoKLE0wUfHdx/6c7pnwdvCuwfhjXq47MPVVt5itfcue0q9mIcDJIf+OdG6qny7W2WALoMiE1jdxwNpOlNfRuOPYyto6JCXaVLT18HcKBveOy2Ey8C5hqa1ZpnMlynjUhTCwjnBT+Qwi8NRiszKJcLs1MxvksTjCMSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F095A21167;
	Wed,  4 Dec 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51CEC139C2;
	Wed,  4 Dec 2024 09:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kxxfETgaUGcyZAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 04 Dec 2024 09:00:40 +0000
Date: Wed, 4 Dec 2024 10:00:34 +0100
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
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
Message-ID: <Z1AaMikjy9BUNe7v@localhost.localdomain>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-5-david@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F095A21167
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, Dec 03, 2024 at 10:47:30AM +0100, David Hildenbrand wrote:
> It's all a bit complicated for alloc_contig_range(). For example, we don't
> support many flags, so let's start bailing out on unsupported
> ones -- ignoring the placement hints, as we are already given the range
> to allocate.
> 
> While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
> simply create yet another GFP mask whereby we ignore the reclaim flags
> specify by the caller. That looks very inconsistent.
> 
> Let's clean it up, constructing the gfp flags used for
> compaction/migration exactly once. Update the documentation of the
> gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

