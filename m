Return-Path: <linux-kernel+bounces-214950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683BF908CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29B2886C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4162107;
	Fri, 14 Jun 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJOro4ox"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FE63B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372557; cv=none; b=BHt6IdbJzUeWswZa4PVAbkahq40BiSlGkrOEmmnFwetjzBKEiVZNC9zOX9IH8hc0X48b9yL2eJJCvtbuW4EbdMZBWGw63Htkp7bn0Ssefuw0eEFeeCH3VU2o+4SZ/KYyy97xaM9YPReptQpgJksB6x1uqLsKgAooXJJrIjAIZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372557; c=relaxed/simple;
	bh=esMGgyY1W25P7oUFv/eBPQQ0NO1tlRMBciGtesHw7yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6vyuaqRQ7w7qYS1pADxA+B1ycDxvp+RaRu13HZLAKQ7d1pB96vUk4mY23uAPAv/46cwVTO4H0JoI6s8pF6ZvkMNmHgx4qGz9qWuvOaZsE2smk2DZABPSLHbmj8nSf/mzjJICcKO+mxpQK3Nbl+eaDLe/aRDdjtRinOBpf+m6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJOro4ox; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FOEDNVsvnyrjERCR6kvUw9fLHGQTorC8TxMyHmBMNMk=; b=aJOro4oxeGoIKSfgHm+gSn3UCP
	20XioKN1lO12GHRSUaf8O4SgNjuxK8vKU3J7edTOFIOAGiiqeynHV7nR6/to4xfky6NkWvyg3Iib6
	UI3+s/eBycdgp4QWJ+/bTOs7VMRTZCkMlNjGpZa8tATcw+XNUG4Cgv6mMyCMTMuHB3i3cOFTVTHQ1
	NXAcyLZocOMZTZK2/oSZyf7QIG00hJGdKdcFN8xAj2ALBLjP2HI//I+GnXWdkIETlcj4m9l+q5TIs
	4wmuazHJ10FMgDRIhx+5qQobgMpw5Zrqn4GLuJaiZJdLsLErDOJRBA97tb60yoodwetWPCwTmOBC8
	grvqdFBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI7C9-0000000H0o7-0Gwf;
	Fri, 14 Jun 2024 13:42:21 +0000
Date: Fri, 14 Jun 2024 14:42:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Message-ID: <ZmxIvIJ3YSZDwbPW@casper.infradead.org>
References: <20240614131856.754-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614131856.754-1-hdanton@sina.com>

On Fri, Jun 14, 2024 at 09:18:56PM +0800, Hillf Danton wrote:
> Flush lru cache to avoid folio->mapping uaf in case of inode teardown.

What?  inodes are supposed to have all their folios removed before
being freed.  Part of removing a folio sets the folio->mapping to NULL.
Where is the report?

> Reported-and-tested-by: syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> Post for comments because lru_add_drain_all() is too haevy a hammer.
> 
> --- x/mm/truncate.c
> +++ y/mm/truncate.c
> @@ -419,6 +419,9 @@ void truncate_inode_pages_range(struct a
>  		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
>  		folio_batch_release(&fbatch);
>  	}
> +
> +	if (mapping_exiting(mapping))
> +		lru_add_drain_all();
>  }
>  EXPORT_SYMBOL(truncate_inode_pages_range);
>  
> --

