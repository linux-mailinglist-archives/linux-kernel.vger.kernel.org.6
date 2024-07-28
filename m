Return-Path: <linux-kernel+bounces-264891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703E93E9C2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A422818CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA085768FC;
	Sun, 28 Jul 2024 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jq4D1qR/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B6179A3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722203196; cv=none; b=T4mq12ZxuV2HHevNoJZFrnZ7E4+11GJYGdYqeYP4VfI78a6dRXOFRDAViHYH6mrVzwLKXdbBZRJ6dlzx+gNOWCMRKRW2JGmm3oUf9Lg+3NJlxbDhfkBfHHlhkF7QjJNoWrehOKTyJn8bNsYFrUYdaDXvfvpB+/FX5Cj/VtanLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722203196; c=relaxed/simple;
	bh=aoR+sdktVtJtfJWSffIjMVjPig6lcsRQZux7heNkfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaVc8p9NYERB1GhqEHyQEtZXTQFNHuzgmq+IP19M24/SACFdf5wVXrg7tqBQRJEZuEtTP8RpUezD9i1BGWsyGOsb8h14fVBq1/M5Qp7kvHznizaKyqt+51n43djws4j+6ZYQ13cT2+pbH3/HjVSbcuGSg6FfVnlZ6D667KN6nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jq4D1qR/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ee35UQdGzo/TjoqV+FGBExRMBQy4PRf/ou1hv4n6+Zo=; b=Jq4D1qR/ke08I1MT3ewwS/H+eC
	TaPqwwCWfzTkJYmfMnK5G8wY1mRY+RK8jEuUEcCEK40Fl4fht/d6C9QZoENWOswFIv0KOGb1vX3mn
	gJTFMXHxBDW0gA2EHMPtnNgqejsyerbe03OVAiCN953gNvL434BssfVDd4Zki+Nbu7fvjPp2dim5K
	jqXuZes4HAi0Y2F2enRs3F/Ce+kWjPiPeYDGAgH3WWOf/coJQtV9NKuXFnaGwQhu89YcUlR/mFu2v
	esP2tynMspdtn7syuVsw3Sq5ng7h+vEMgcjZ/rYgXZNn1lw4tpycDyQdkWIh48hqkMXbnGIDZYil5
	ELeu1t4A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYBio-0000000CqUE-0RtE;
	Sun, 28 Jul 2024 21:46:30 +0000
Date: Sun, 28 Jul 2024 22:46:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
Message-ID: <Zqa8NTqKuXkTxzBw@casper.infradead.org>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>

On Sun, Jul 28, 2024 at 11:49:13PM +0800, Gao Xiang wrote:
> It was found by compaction stress test when I explicitly enable EROFS
> compressed files to use large folios, which case I cannot reproduce with
> the same workload if large folio support is off (current mainline).
> Typically, filesystem reads (with locked file-backed folios) could use
> another bdev/meta inode to load some other I/Os (e.g. inode extent
> metadata or caching compressed data), so the locking order will be:

Umm.  That is a new constraint to me.  We have two other places which
take the folio lock in a particular order.  Writeback takes locks on
folios belonging to the same inode in ascending ->index order.  It
submits all the folios for write before moving on to lock other inodes,
so it does not conflict with this new constraint you're proposing.

The other place is remap_file_range().  Both inodes in that case must be
regular files,
        if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
                return -EINVAL;
so this new rule is fine.

Does anybody know of any _other_ ordering constraints on folio locks?  I'm
willing to write them down ...

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20cb9f5f7446..a912e4b83228 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1483,7 +1483,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>  {
>  	int rc;
>  
> -	folio_lock(folio);
> +	if (!folio_trylock(folio))
> +		return -EAGAIN;
>  	rc = split_folio_to_list(folio, split_folios);
>  	folio_unlock(folio);
>  	if (!rc)

This feels like the best quick fix to me since migration is going to
walk the folios in a different order from writeback.  I'm surprised
this hasn't already bitten us, to be honest.

(ie I don't think this is even necessarily connected to the new
ordering constraint; I think migration and writeback can already
deadlock)

