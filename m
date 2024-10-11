Return-Path: <linux-kernel+bounces-360760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6D999F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730B2B21914
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4444A20B1F6;
	Fri, 11 Oct 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DveQ39IC"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4F3232
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635991; cv=none; b=EwQEQEDrT8TmY9y5PJCd+BsrqKTXE2c8CKlpIhw/Yx31aGtZEXW427rk1Wah5dt7SzdhWOEZWOnCg9YBREUDWhk1xo4Hb6r+GtGnhtvWG+MGJqJ/lDquSuIMeHL5DtTquCEcqmtqeNac6wKlf/OQkLmL9Mxy5brc6dLAE0Gnkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635991; c=relaxed/simple;
	bh=iFrVmnZIJpix1eTKGuVS5pwhvqfIwPskWptKd+M4qCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWfktPOsZZxNgU3+eJt/CqwPYhAehBwPYkPx8A9RuqMXmJqnL2xvrHjXLwVi4QLWbe0r/R8Ubo3nRCUZoZl7mtPK/rKtWXah72x/MpwXrJ8GEI9YZYqt5O4+GvyGTDOM5oQBd+IHzaXKKeeAfKHRQO8s25ovTp/oJ/9PwNv1cRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DveQ39IC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so423569a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728635988; x=1729240788; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQzLRSOUJVDYXV5FlqvwVfbjfzwXvPn7jKX4d5M9SJ0=;
        b=DveQ39ICi+XqtCO28mw6KRTx9x/NwTS1Hck6UeeimhHUPdFU7IoMyRtIXiLzK/hTaE
         SgCeWDr5QQnl+Ljna8R4zhAzwMhcR4bqFYMgUpabtrenv/U/kd2E9p8Quer89XWxZgDC
         E7Bs2xhlS9typGotGMSBeHNQsjv39v/no5+genohdGqRjNln9dZVbPZm4ZbX+dBO8PhQ
         zKouuuuNUH4oA1Hao/a3ZzPgIKyRDIHg0hb1Da92Qi5UDCK9S6NDhg6zjgUFmX62rPR5
         F+yesIVVuPQJUaXr1gRyF2oZxsf/qPXrLpnd9LWS9kRutR13AjZU769gfnGMRZidMXp0
         JYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635988; x=1729240788;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQzLRSOUJVDYXV5FlqvwVfbjfzwXvPn7jKX4d5M9SJ0=;
        b=ON6helUKRagF30X/etXd4rXRCZCVt7iT/NUGu36q9pg/R8Q8amtLq3Jmal6+8PAQXO
         hkmcn/jepnBPVrv6zO7UOnBd6b26o+wS85n8gungDHl7TK7R+MPqZolX4NHn21rvYGxZ
         ezWfXPIZQ2zj8PulxwDlyeFAUi2Adt9aEt/or7TA6mTJzb+D98zQw/BIYri3bTxvULQL
         xI2W5QHdhoGvPIX5xPDoZnvkZJ20RcfpIiRtnSCNUndVITG1gPOB3Ln3ut3FCdzpyieU
         LhZLQsarz7f5kqivPHId9LB89JADXEQvswitDTPz82mLOL8fpBf58QgiDhAKmP3NaSjG
         AC3w==
X-Forwarded-Encrypted: i=1; AJvYcCXDeDxO2O60MRQSyRd030LkJyvwDZtnEBAAC5UjV1w3IIVFwf74J1zunGaPVTspheLfVYMAqIUaqifELW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/9ZJd1Ut4HW1NWiRjNDRTu3fzypFv9JgYtdFWxGVR8IpV68S
	Lv7fzeY2XEvVkLp34qQ5R4nXxbB8V876xxYv9+hIXglNB9ttbe/+niqq2hf0
X-Google-Smtp-Source: AGHT+IEIho5nttJ6WjZ7zRjMXHUbxFjeSz/Fn8mbvW+6INfFIzc+90bMeayuWcrCvN/e0t/5ZN8E6w==
X-Received: by 2002:a17:907:e208:b0:a99:8ed2:7e41 with SMTP id a640c23a62f3a-a99b943f8ecmr145623366b.11.1728635987609;
        Fri, 11 Oct 2024 01:39:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcdc3sm190750366b.172.2024.10.11.01.39.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2024 01:39:46 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:39:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 1/2] maple_tree: correct tree corruption
 on spanning store
Message-ID: <20241011083945.z6a3y22pszyq6hse@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
 <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 07, 2024 at 04:28:32PM +0100, Lorenzo Stoakes wrote:
>There has been a subtle bug present in the maple tree implementation from
>its inception.
>
>This arises from how stores are performed - when a store occurs, it will
>overwrite overlapping ranges and adjust the tree as necessary to
>accommodate this.
>
>A range may always ultimately span two leaf nodes. In this instance we walk
>the two leaf nodes, determine which elements are not overwritten to the
>left and to the right of the start and end of the ranges respectively and
>then rebalance the tree to contain these entries and the newly inserted
>one.
>
>This kind of store is dubbed a 'spanning store' and is implemented by
>mas_wr_spanning_store().
>
>In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
>mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
>the object (mas) to traverse to the location where the write should be
>performed, determining its store type.
>
>When a spanning store is required, this function returns false stopping at
>the parent node which contains the target range, and mas_wr_store_type()
>marks the mas->store_type as wr_spanning_store to denote this fact.
>
>When we go to perform the store in mas_wr_spanning_store(), we first
>determine the elements AFTER the END of the range we wish to store (that
>is, to the right of the entry to be inserted) - we do this by walking to
>the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
>have just determined contains the range over which we intend to write.
>
>We then turn our attention to the entries to the left of the entry we are
>inserting, whose state is represented by l_mas, and copy these into a 'big
>node', which is a special node which contains enough slots to contain two
>leaf node's worth of data.
>
>We then copy the entry we wish to store immediately after this - the copy
>and the insertion of the new entry is performed by mas_store_b_node().
>
>After this we copy the elements to the right of the end of the range which
>we are inserting, if we have not exceeded the length of the node
>(i.e. r_mas.offset <= r_mas.end).
>
>Herein lies the bug - under very specific circumstances, this logic can
>break and corrupt the maple tree.
>
>Consider the following tree:
>
>Height
>  0                             Root Node
>                                 /      \
>                 pivot = 0xffff /        \ pivot = ULONG_MAX
>                               /          \
>  1                       A [-----]       ...
>                             /   \
>             pivot = 0x4fff /     \ pivot = 0xffff
>                           /       \
>  2 (LEAVES)          B [-----]  [-----] C
>                                      ^--- Last pivot 0xffff.
>
>Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
>that all ranges expressed in maple tree code are inclusive):
>
>1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
>   determines that this is a spanning store across nodes B and C. The mas
>   state is set such that the current node from which we traverse further
>   is node A.
>
>2. In mas_wr_spanning_store() we try to find elements to the right of pivot
>   0xffff by searching for an index of 0x10000:
>
>    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
>      mas_wr_node_walk() in turn.
>
>        - mas_wr_node_walk() loops over entries in node A until EITHER it
>          finds an entry whose pivot equals or exceeds 0x10000 OR it
>          reaches the final entry.
>
>        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
>          0xffff is selected, leading to node C.
>
>    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
>      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
>      in turn once again.
>
>         - Again, we reach the last entry in node C, which has a pivot of
>           0xffff.
>
>3. We then copy the elements to the left of 0x4000 in node B to the big
>   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
>   too.
>
>4. We determine whether we have any entries to copy from the right of the
>   end of the range via - and with r_mas set up at the entry at pivot
>   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
>   pivot 0xffff.
>
>5. BUG! The maple tree is corrupted with a duplicate entry.
>
>This requires a very specific set of circumstances - we must be spanning
>the last element in a leaf node, which is the last element in the parent
>node.
>
>spanning store across two leaf nodes with a range that ends at that shared
>pivot.
>
>A potential solution to this problem would simply be to reset the walk each
>time we traverse r_mas, however given the rarity of this situation it seems
>that would be rather inefficient.
>
>Instead, this patch detects if the right hand node is populated, i.e. has
>anything we need to copy.
>
>We do so by only copying elements from the right of the entry being inserted
>when the maximum value present exceeds the last, rather than basing this on
>offset position.
>
>The patch also updates some comments and eliminates the unused bool return
>value in mas_wr_walk_index().
>
>The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
>in mmap_region()") seems to have made the probability of this event much
>more likely, which is the point at which reports started to be submitted
>concerning this bug.
>
>The motivation for this change arose from Bert Karwatzki's report of
>encountering mm instability after the release of kernel v6.12-rc1 which,
>after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
>options, was identified as maple tree corruption.
>
>After Bert very generously provided his time and ability to reproduce this
>event consistently, I was able to finally identify that the issue discussed
>in this commit message was occurring for him.
>
>Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
>Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
>Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
>Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

