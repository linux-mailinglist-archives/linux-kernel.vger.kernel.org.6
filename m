Return-Path: <linux-kernel+bounces-292397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9D956EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4331A1F21EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCA12E1D9;
	Mon, 19 Aug 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D0ZGlPSA"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A8130A47
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081880; cv=none; b=d99LmRtlqYzHjOvMWCoqipo3yHh/WY1hjwonInmBRm6mBblkftY+CTsi/cvrZwE/gFb5RF4MvY3JZhgAeI2qIgtF5kHX6hz3yZqz+ljHF8vqn5brffwPnzOn6KM7RG+goYD8aRg7GT1CRsrBCyZNGACt+G4Cj9v4wWYbC3/WIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081880; c=relaxed/simple;
	bh=tVO8/URvVCyOC2foSa+OgB1GmIHP1QQVAEGcQ68DUMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on008lR89TXpVftqqNTtxjDJF8Zo32JPQnXGvk0ZXJiJx5tmTBhKMJ579ZzT4LgS0PRBTGwl9j2oHfoawoPTFi2nnDxKZSsxXUHh75wa24KzREc/fEZ+KA0eJVxb9X2g0NXNfS5N2aRmCkqU3zwcU8+PdTF8WhCeMjNpbGlaGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D0ZGlPSA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Aug 2024 08:37:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724081875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDoNKpYc2BhDlpHR6whjlONzdtHocWfp4rWQ/S2NQEg=;
	b=D0ZGlPSAieuHmaPEQGxbUufJC7QiTcywkSCjBQsQKkRshZh9x6q2butEwK+2sfXv6SECzU
	mW+catBrEdfUm78Ts/dRH390SkdZEXvxSSZTFSKg03obfxXizFXFF8KOSlv4Hm2BU+wM89
	t+GbBR48gNA9XtDI8lDEOvhd1IYAd6k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: muchun.song@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: kmem: fix split_page_memcg()
Message-ID: <wvsagtywkr5rjn3y6fjz4wewmsyymxulim4zabunonmtxe4q4c@i7fd6bnwrbwp>
References: <20240819080415.44964-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819080415.44964-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 04:04:15PM GMT, Muchun Song wrote:
> split_page_memcg() does not care about the returned memcg for kmem
> pages, so folio_memcg_charged() should be used, otherwise obj_cgroup_memcg
> will complain about this.

Basically avoid calling folio_memcg() for folio_memcg_kmem(folio),
correct?

> 
> Reported-by: syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


