Return-Path: <linux-kernel+bounces-353257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B414E992B48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CE71F22E64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5C1D2B25;
	Mon,  7 Oct 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CW8t+CFB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHgTzHXM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CW8t+CFB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHgTzHXM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35981D2B10
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303266; cv=none; b=II0QcTPGGoaGfoH7d+z+Q2l+rtEWlb3V2MhLk9NOD++utUankTWnO0TBVJHMV/NF8x4MoRQciRQOt7FNiuJhmhehSYJ0u5yvKZp6aHkDO5iRu6O10jssYfvfkO6rHV1Nf3mkcTZh0HbvLKTeuhzm81Uy7RTZ+C4y9F3I+q3gaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303266; c=relaxed/simple;
	bh=IJrNhpkaO74h6mnlcbpEr/C2a61/jpMYICVJwYA+I6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgqfMTBuRtEHLz99/vYWLSz2S4JEulP/oDrVIqGKiPPY86R6pWPbNdfvd+KZrA+elVFxqapXTXuI6xCRSYYWschPB8FcGr0H2K6zLDCZysh/uAcUUtaUDcWbPeAYkG2PxoBE+YvtcMY6xpOOTvu3qKcqJGv8jj0T96WjzxZz9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CW8t+CFB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHgTzHXM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CW8t+CFB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHgTzHXM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A80A61FD42;
	Mon,  7 Oct 2024 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728303262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai15QA7goGpy5B7QxmBsY+nTC1f7S6vHzp/ZmtDVjJY=;
	b=CW8t+CFBPV8/mnMGb5ql3/pKi6JKKjQitIu8FJvr7Ni3bWabAkV17+1QYCrjUxxTy+7aUi
	x6jls4qJm/i1LtqGjbvNG31rUeOxIWEdW7MednFkAwhMSNv5BrLBLluWEhGNolZU1uunat
	OucG5bzwSeL5PzyUwy39hGHaXZ2LiGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728303262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai15QA7goGpy5B7QxmBsY+nTC1f7S6vHzp/ZmtDVjJY=;
	b=oHgTzHXMKqYFy31gWLeWW85BOQRMbkYxnuB9O669gDvijQRZvNM4Pmkg7luK4oU/oLeQUz
	b/VaTaecHAl3AWCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728303262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai15QA7goGpy5B7QxmBsY+nTC1f7S6vHzp/ZmtDVjJY=;
	b=CW8t+CFBPV8/mnMGb5ql3/pKi6JKKjQitIu8FJvr7Ni3bWabAkV17+1QYCrjUxxTy+7aUi
	x6jls4qJm/i1LtqGjbvNG31rUeOxIWEdW7MednFkAwhMSNv5BrLBLluWEhGNolZU1uunat
	OucG5bzwSeL5PzyUwy39hGHaXZ2LiGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728303262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai15QA7goGpy5B7QxmBsY+nTC1f7S6vHzp/ZmtDVjJY=;
	b=oHgTzHXMKqYFy31gWLeWW85BOQRMbkYxnuB9O669gDvijQRZvNM4Pmkg7luK4oU/oLeQUz
	b/VaTaecHAl3AWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93ACE13786;
	Mon,  7 Oct 2024 12:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ljVnI57QA2eITAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Oct 2024 12:14:22 +0000
Message-ID: <1b93c383-3442-4202-a6c7-068e0ddafe9d@suse.cz>
Date: Mon, 7 Oct 2024 14:14:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 hotfix 6.12 1/2] maple_tree: correct tree corruption on
 spanning store
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Bert Karwatzki <spasswolf@web.de>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 maple-tree@lists.infradead.org
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
 <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,vger.kernel.org,oracle.com,web.de,gmail.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 



On 10/6/24 4:31 PM, Lorenzo Stoakes wrote:
> There has been a subtle bug present in the maple tree implementation from
> its inception.
> 
> This arises from how stores are performed - when a store occurs, it will
> overwrite overlapping ranges and adjust the tree as necessary to
> accommodate this.
> 
> A range may always ultimately span two leaf nodes. In this instance we walk
> the two leaf nodes, determine which elements are not overwritten to the
> left and to the right of the start and end of the ranges respectively and
> then rebalance the tree to contain these entries and the newly inserted
> one.
> 
> This kind of store is dubbed a 'spanning store' and is implemented by
> mas_wr_spanning_store().
> 
> In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
> mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
> the object (mas) to traverse to the location where the write should be
> performed, determining its store type.
> 
> When a spanning store is required, this function returns false stopping at
> the parent node which contains the target range, and mas_wr_store_type()
> marks the mas->store_type as wr_spanning_store to denote this fact.
> 
> When we go to perform the store in mas_wr_spanning_store(), we first
> determine the elements AFTER the END of the range we wish to store (that
> is, to the right of the entry to be inserted) - we do this by walking to
> the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
> have just determined contains the range over which we intend to write.
> 
> We then turn our attention to the entries to the left of the entry we are
> inserting, whose state is represented by l_mas, and copy these into a 'big
> node', which is a special node which contains enough slots to contain two
> leaf node's worth of data.
> 
> We then copy the entry we wish to store immediately after this - the copy
> and the insertion of the new entry is performed by mas_store_b_node().
> 
> After this we copy the elements to the right of the end of the range which
> we are inserting, if we have not exceeded the length of the node
> (i.e. r_mas.offset <= r_mas.end).
> 
> Herein lies the bug - under very specific circumstances, this logic can
> break and corrupt the maple tree.
> 
> Consider the following tree:
> 
> Height
>   0                             Root Node
>                                  /      \
>                  pivot = 0xffff /        \ pivot = ULONG_MAX
>                                /          \
>   1                       A [-----]       ...
>                              /   \
>              pivot = 0x4fff /     \ pivot = 0xffff
>                            /       \
>   2 (LEAVES)          B [-----]  [-----] C
>                                       ^--- Last pivot 0xffff.
> 
> Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
> that all ranges expressed in maple tree code are inclusive):
> 
> 1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
>    determines that this is a spanning store across nodes B and C. The mas
>    state is set such that the current node from which we traverse further
>    is node A.
> 
> 2. In mas_wr_spanning_store() we try to find elements to the right of pivot
>    0xffff by searching for an index of 0x10000:
> 
>     - mas_wr_walk_index() invokes mas_wr_walk_descend() and
>       mas_wr_node_walk() in turn.
> 
>         - mas_wr_node_walk() loops over entries in node A until EITHER it
>           finds an entry whose pivot equals or exceeds 0x10000 OR it
>           reaches the final entry.
> 
>         - Since no entry has a pivot equal to or exceeding 0x10000, pivot
>           0xffff is selected, leading to node C.
> 
>     - mas_wr_walk_traverse() resets the mas state to traverse node C. We
>       loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
>       in turn once again.
> 
>          - Again, we reach the last entry in node C, which has a pivot of
>            0xffff.
> 
> 3. We then copy the elements to the left of 0x4000 in node B to the big
>    node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
>    too.
> 
> 4. We determine whether we have any entries to copy from the right of the
>    end of the range via - and with r_mas set up at the entry at pivot
>    0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
>    pivot 0xffff.
> 
> 5. BUG! The maple tree is corrupted with a duplicate entry.
> 
> This requires a very specific set of circumstances - we must be spanning
> the last element in a leaf node, which is the last element in the parent
> node.
> 
> spanning store across two leaf nodes with a range that ends at that shared
> pivot.

This looks like missing something to form a complete sentence?

> A potential solution to this problem would simply be to reset the walk each
> time we traverse r_mas, however given the rarity of this situation it seems
> that would be rather inefficient.
> 
> Instead, this patch detects if the right hand node is populated, i.e. has
> anything we need to copy. We can do this easily in mas_wr_walk_index() by
> detecting if the pivot is either 0 (shorthand for the end of the range) or
> the required index is less than or equal to the last encountered pivot.
> 
> This change is made in mas_wr_walk_index() which is only used by the
> spanning store so it has minimal impact.
> 
> The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> in mmap_region()") seems to have made the probability of this event much
> more likely, which is the point at which reports started to be submitted
> concerning this bug.
> 
> The motivation for this change arose from Bert Karwatzki's report of
> encountering mm instability after the release of kernel v6.12-rc1 which,
> after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> options, was identified as maple tree corruption.
> 
> After Bert very generously provided his time and ability to reproduce this
> event consistently, I was able to finally identify that the issue discussed
> in this commit message was occurring for him.
> 
> Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  lib/maple_tree.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20990ecba2dd..f72e1a5a4dfa 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
> 
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
> + *                      If @mas->index cannot be found within the containing
> + *                      node, we traverse to the last entry in the node.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3532,6 +3534,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  	return true;
>  }
> 
> +/*
> + * Traverse the maple tree until the offset of mas->index is reached.
> + *
> + * Return: Is this node actually populated with entries possessing pivots equal
> + *         to or greater than mas->index?
> + */
>  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> @@ -3540,8 +3548,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  		mas_wr_walk_descend(wr_mas);
>  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
>  						  mas->offset);
> -		if (ma_is_leaf(wr_mas->type))
> -			return true;
> +		if (ma_is_leaf(wr_mas->type)) {
> +			unsigned long pivot = wr_mas->pivots[mas->offset];
> +
> +			return pivot == 0 || mas->index <= pivot;
> +		}
>  		mas_wr_walk_traverse(wr_mas);
> 
>  	}
> @@ -3701,6 +3712,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	struct maple_big_node b_node;
>  	struct ma_state *mas;
>  	unsigned char height;
> +	bool r_populated;
> 
>  	/* Left and Right side of spanning store */
>  	MA_STATE(l_mas, NULL, 0, 0);
> @@ -3742,7 +3754,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  		r_mas.last++;
> 
>  	r_mas.index = r_mas.last;
> -	mas_wr_walk_index(&r_wr_mas);
> +	r_populated = mas_wr_walk_index(&r_wr_mas);
>  	r_mas.last = r_mas.index = mas->last;
> 
>  	/* Set up left side. */
> @@ -3766,7 +3778,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	/* Copy l_mas and store the value in b_node. */
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
>  	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <= r_mas.end)
> +	if (r_populated && r_mas.offset <= r_mas.end)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);
>  	else
> --
> 2.46.2

