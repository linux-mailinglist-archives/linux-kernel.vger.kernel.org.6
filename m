Return-Path: <linux-kernel+bounces-244937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4492ABEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B651C220B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24914F9F4;
	Mon,  8 Jul 2024 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EWJTtxyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FF14F12C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476980; cv=none; b=aIDZGbnAMsIbLFJCzKdFtRJpylIPjZD/3G7GNy/kLzRCEtGCiq5g7HUXeJPoqHV5cpbNUYYDxrXJpG3+UyrcWVMVn8xUN9HCsOQAXqMIcNHUaGQxe5KT1dmpDJLY46RZZ8tMC8hTa68iP15rkkVvVbzxCiWLfxLlpq39O4plmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476980; c=relaxed/simple;
	bh=3L1LL5eQl6io+xeK0GdjxwAay/oDjN3TVaty+F1eKUU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ufN80PCCKqiq7O5EDUeLc9Gf2qR5JbydNeXdVWlK6ttwNy6PUriubgFe/NrC/OhNsBgA7SO45rWt1IYyw6jiLxIfUsRdSwzDHtsnEcDjomeToycmAPEERejs2EvpSPmzjMZwztJutopsLbW9lqirrTPtFf1m0b6gh+vobw8cuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EWJTtxyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC00EC3277B;
	Mon,  8 Jul 2024 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720476980;
	bh=3L1LL5eQl6io+xeK0GdjxwAay/oDjN3TVaty+F1eKUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWJTtxytujM8XiQY/uBZg3PX0H07/smcJ/DzloEwktMR/kvYpRnN7+SOboNqCjqqh
	 wYfDZDFGPbKXQPCcTlbj/fX6q5RFvSKVV3fE11c8HbcdyF4DKfcF6yX/m0KM7KXX1G
	 ijrzbFrwwwKDwAuk9vMAj44ktqJxvVUmoyTIhzfY=
Date: Mon, 8 Jul 2024 15:16:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Bharata B Rao <bharata@amd.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Mel Gorman <mgorman@techsingularity.net>, Johannes Weiner
 <hannes@cmpxchg.org>
Subject: Re: [PATCH mm-unstable v1] mm/truncate: batch-clear shadow entries
Message-Id: <20240708151619.dc738d16d3b2d56d6c4fe285@linux-foundation.org>
In-Reply-To: <20240708212753.3120511-1-yuzhao@google.com>
References: <20240708212753.3120511-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jul 2024 15:27:53 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Make clear_shadow_entry() clear shadow entries in `struct folio_batch`
> so that it can reduce contention on i_lock and i_pages locks, e.g.,
> 
>   watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
>     clear_shadow_entry+0x3d/0x100
>     mapping_try_invalidate+0x117/0x1d0
>     invalidate_mapping_pages+0x10/0x20
>     invalidate_bdev+0x3c/0x50
>     blkdev_common_ioctl+0x5f7/0xa90
>     blkdev_ioctl+0x109/0x270

This will clearly reduce lock traffic a lot, but does it truly fix the
issue?  Is it the case that sufficiently extreme loads will still run
into problems?

> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -39,12 +39,24 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
>  	xas_store(&xas, NULL);
>  }
>  
> -static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
> -			       void *entry)
> +static void clear_shadow_entry(struct address_space *mapping,
> +			       struct folio_batch *fbatch, pgoff_t *indices)
>  {
> +	int i;
> +
> +	if (shmem_mapping(mapping) || dax_mapping(mapping))
> +		return;

We lost the comment which was in invalidate_exceptional_entry() and
elsewhere.  It wasn't a terribly good one but I do think a few words
which explain why we're testing for these things would be helpful.

I expect we should backport this.  But identifying a Fixes: target
looks to be challenging.

