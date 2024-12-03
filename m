Return-Path: <linux-kernel+bounces-429595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C099E2466
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD57B329C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC61F1310;
	Tue,  3 Dec 2024 13:55:58 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1A1EE006
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234157; cv=none; b=uo0nb/2LW6TOFHR1lsNGCaAcbxhL2mk5lSsQBcwgi9HaU5wRIvVQLP3zK8Z/uPW6eAE9FzHX8G0mXBhjaEkxew6ijyUo7VR/w36538IvHOD8KmLpHdwF6Z/qsJWSWqIK95FjxhKuSTn6aXiZOy5KnKKmoFuhsipHpnAsDA6yMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234157; c=relaxed/simple;
	bh=DHtTMlSg3NMWpfWAJ2lfL4zSBIABUF39WU3TlKqCz/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwG2KDyHhLqCHhE3cuhsHCEbVuiEjE2EHuibyD12Ue9v4hN8oQe7ZTqS4Daz/inNwNFQuIgfvylOexE1JeoFFYLPQw31mO0UlIcLbYtW247zTSu+awe4k/09PO91bPdKMi52KUTP5c2/wxJjk/pWHWAB7JqsBGSxQZ39fzoKYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C7DE21166;
	Tue,  3 Dec 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 206F513A15;
	Tue,  3 Dec 2024 13:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +NefB+oNT2dGKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 13:55:54 +0000
Message-ID: <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
Date: Tue, 3 Dec 2024 14:55:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3C7DE21166
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On 12/3/24 10:47, David Hildenbrand wrote:
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

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> +	/*
> +	 * Flags to control page compaction/migration/reclaim, to free up our
> +	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
> +	 * for them.
> +	 *
> +	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
> +	 * keep doing that to not degrade callers.
> +	 */

Wonder if we could revisit that eventually. Why limit migration targets by
cpuset via __GFP_HARDWALL if we were not called with __GFP_HARDWALL? And why
weaken the attempts with __GFP_RETRY_MAYFAIL if we didn't specify it?

Unless I'm missing something, cc->gfp is only checked for __GFP_FS and
__GFP_NOWARN in few places, so it's mostly migration_target_control the
callers could meaningfully influence.

> +	*gfp_cc_mask = (gfp_mask & (reclaim_mask | cc_action_mask)) |
> +			__GFP_HARDWALL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> +	return 0;
> +}
> +
>  /**
>   * alloc_contig_range() -- tries to allocate given range of pages
>   * @start:	start PFN to allocate
> @@ -6398,7 +6431,9 @@ static void split_free_pages(struct list_head *list)
>   *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
>   *			in range must have the same migratetype and it must
>   *			be either of the two.
> - * @gfp_mask:	GFP mask to use during compaction
> + * @gfp_mask:	GFP mask. Node/zone/placement hints are ignored; only some
> + *		action and reclaim modifiers are supported. Reclaim modifiers
> + *		control allocation behavior during compaction/migration/reclaim.
>   *
>   * The PFN range does not have to be pageblock aligned. The PFN range must
>   * belong to a single zone.
> @@ -6424,11 +6459,14 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>  		.mode = MIGRATE_SYNC,
>  		.ignore_skip_hint = true,
>  		.no_set_skip_hint = true,
> -		.gfp_mask = current_gfp_context(gfp_mask),
>  		.alloc_contig = true,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> +	gfp_mask = current_gfp_context(gfp_mask);
> +	if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
> +		return -EINVAL;
> +
>  	/*
>  	 * What we do here is we mark all pageblocks in range as
>  	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> @@ -6571,7 +6609,9 @@ static bool zone_spans_last_pfn(const struct zone *zone,
>  /**
>   * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
>   * @nr_pages:	Number of contiguous pages to allocate
> - * @gfp_mask:	GFP mask to limit search and used during compaction
> + * @gfp_mask:	GFP mask. Node/zone/placement hints limit the search; only some
> + *		action and reclaim modifiers are supported. Reclaim modifiers
> + *		control allocation behavior during compaction/migration/reclaim.
>   * @nid:	Target node
>   * @nodemask:	Mask for other possible nodes
>   *


