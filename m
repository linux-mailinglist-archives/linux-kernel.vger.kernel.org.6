Return-Path: <linux-kernel+bounces-195849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7948D52C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821AB1F21D35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91855880;
	Thu, 30 May 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KG8OgMFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E108187568
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099399; cv=none; b=cr4eeMPAgb7snTJpQ/zvrr89F+fH96LLITNCMi9w6Drrm8n7Rhbel6CZTMA9X4qK1E6VexHaOUYN5PSCr/UqZOYv7AMsXozNWagCjY3CV7LI3gOcwuCb2YhI8YrOdc3CBBeN9xRoEGo+OjEStaDC+ciy+WKe88RGTFBWaZQQKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099399; c=relaxed/simple;
	bh=2Zk9G4N1QVb6dL/7eakVW9j4sKX8lEMickryI8gm060=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tZ5SR1aBxpoUloTPrzO3SwCk8En4xliQKAKa9pDqhOHncnbTx5z4Cvs9MmoPGVkF4rt8uo31AbLqIUbuGVcx9NBxe0enunKS7VJK+mQHQkmkWgF+9hp70VzsoQFz4DriUshlVodVIWpCHnG+w7hjyWTlu2AImDh8NVrI4MWu5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KG8OgMFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995FEC2BBFC;
	Thu, 30 May 2024 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717099399;
	bh=2Zk9G4N1QVb6dL/7eakVW9j4sKX8lEMickryI8gm060=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KG8OgMFc2LRGn6x9Y62ndM1Cvk9t0TmadtaEYAsyIXFPl3B7/RAlkOSxYeReyw6ro
	 viThB6cIZ9P2/i8ZGwC88TQaXdFcU4sevPvdES7ZDT4GU9pXN+/jQbtGcPDCsgbA6+
	 DQs2uCwMZujFkb3gaXK8uc/DMXlET8eXedwqkgXA=
Date: Thu, 30 May 2024 13:03:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <hailong.liu@oppo.com>
Cc: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
 <21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <xiang@kernel.org>, <guangye.yang@mediatek.com>,
 <zhaoyang.huang@unisoc.com>, "Hailong . Liu" <liuhailong@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vbq->free breakage
Message-Id: <20240530130318.2a78c0797c352a4d38cfb2c1@linux-foundation.org>
In-Reply-To: <20240530093108.4512-1-hailong.liu@oppo.com>
References: <20240530093108.4512-1-hailong.liu@oppo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 17:31:08 +0800 <hailong.liu@oppo.com> wrote:

> From: "hailong.liu" <hailong.liu@oppo.com>
> 
> The function xa_for_each() in _vm_unmap_aliases() loops through all
> vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
> vmap_blocks xarray") the vb from xarray may not be on the corresponding
> CPU vmap_block_queue. Consequently, purge_fragmented_block() might
> use the wrong vbq->lock to protect the free list, leading to vbq->free
> breakage.

What are the userspace-visible runtime effects of this change?

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..869e7788a7d5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2269,10 +2269,9 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  	for_each_possible_cpu(cpu) {
>  		struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
>  		struct vmap_block *vb;
> -		unsigned long idx;
> 
>  		rcu_read_lock();
> -		xa_for_each(&vbq->vmap_blocks, idx, vb) {
> +		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
>  			spin_lock(&vb->lock);
> 
>  			/*
> ---
> https://lore.kernel.org/all/20240530025144.1570865-1-zhaoyang.huang@unisoc.com/
> BTW, zhangyang also encounter the same issue, maybe revert commit not a
> better solution. we need a map to get vbq from vb.

That patch didn't describe the runtime effects either.

Folks, please always do this.  So that others can decide whether their
kernel needs the fix, and so that others can decide whether this fix
might address an issue which their users are reporting.

