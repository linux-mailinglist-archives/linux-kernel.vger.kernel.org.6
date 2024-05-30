Return-Path: <linux-kernel+bounces-195852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40088D52D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54118B23855
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D55588B;
	Thu, 30 May 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ButqOVXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6418641
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099543; cv=none; b=A8lf9/PqZ8gFylb8UPC0I9JKlcK4K7WeT6fE6PotxZzCmSVizpvrNOhmhr0YXETwBsFeULdAwi4NjCXhlWi3+qAgm8wkTfOeUap/45BDUpItLUMCDoOGjU3565bluc+4vCpU3fRbUlAKsfiMW5mBrjbgCJZXFPCF+90xK3unMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099543; c=relaxed/simple;
	bh=kRBwLlYCuKNk3Fl0J0lD/a6vXcmLqtYeu1cqzVACock=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KmS/SSwJJjxU9C2jejiQfc9AM53Cry7i7mj0Uc3VHnWEvrQ9oiK08iIKmWy7m/qbES8satk7R1zj8t4G/M4Pf45pg41T8+Tdnd2kBC3TcqMSNLs3qXMGxEK2bu+egD4MDzdNmamN9kZyjkACtQMFlM4tWOAR9dsW6/a4YsKtdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ButqOVXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CCAC2BBFC;
	Thu, 30 May 2024 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717099542;
	bh=kRBwLlYCuKNk3Fl0J0lD/a6vXcmLqtYeu1cqzVACock=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ButqOVXNDS+TCCelEMmoNeITCkjmvKoaPnVCR1oqMNKRNyy/ojaP70KejUyYhVR5L
	 oKgk0iKAshkcBnZeSMx2bLClJgskdhV22Jluwx6Z/GD9ykQferXI6Gr5borcBHpUK5
	 XWh5m37/X/nJIDKsQ9uu1OVUbgvb5O0MSlex87LA=
Date: Thu, 30 May 2024 13:05:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <hailong.liu@oppo.com>
Cc: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
 <21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <xiang@kernel.org>, <guangye.yang@mediatek.com>,
 <zhaoyang.huang@unisoc.com>, "Hailong . Liu" <liuhailong@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vbq->free breakage
Message-Id: <20240530130541.c615fcfc1e6f211199315e13@linux-foundation.org>
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
> 
> ...
>
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

I borrowed the Fixes: from that patch and added cc:stable, pending
confirmation that the runtime effects are significant.


