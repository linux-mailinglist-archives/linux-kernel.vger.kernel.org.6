Return-Path: <linux-kernel+bounces-521866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337AA3C34D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBC57A586F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4197198E8C;
	Wed, 19 Feb 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJ8qWtGj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1815CD52
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978129; cv=none; b=svEngsFwUUAGgDs8Y/5xkAGRvYYCWA89e0xuWeudU0SFK9Qvc61v9cKTekV4wyO1I+OgWjfIpA9DYrGLOjY758LqL3KMlWsWR/xuXayzQi7gi3RyDhBOBZaUcFdQrgzZfPl9l4nPpbnN43mzNetdqh6VKOIb15dyuX7bBOXhN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978129; c=relaxed/simple;
	bh=lmp+K833cpavV06YZOLU0YZf3FFGqq9FdQl2u7K8H64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+YzZja/tOY2Y+b66nELVgAxyV0BvcuGkvuRtGjx46XOtWrXAWbTZryk36yuRIcZ24DolCDHclKGUJGa3yplwOoaGTdyDymvofjXmphg7KaiSgXH4Aqwe8Rs6proaMdVgP4blDeyl51dYH27OFCNVJhSI1pKcLHDpc1JQ+zh4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pJ8qWtGj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=175cKEWRmZAKRUF4IVht6MRwBpaF+VjbFIkwKtXrOb0=; b=pJ8qWtGjs36Asigj/eIF2fjmtL
	Z6l3Lf5VzhHydPYTDx/1zuid39HUcGewgWCpg580nLX1vBtiTi3HXFQwL5O2ypisxHoyg5tzZWJBI
	9kEsQN/LTiR20mhHz9Gs8rbRCMmFKl47y9sjdYbSQGKGa9lFr0LfQ49zB4AwP1ssLrqg9MM6geQB3
	fT+shlpgru8N2F8+VhvLJ0TEG6O857I62vrQua6pizq0hqHVc5g7YJxHPuNRE5P7aHsQW/w1Q6lSn
	ius3VHQP341mFQiUa7Ai7X50KCG5xSRE6hsm+UKjU9BOw7dV4C39oJ1Cq9+FWNMyvjRBnsveufnL1
	hSSaOb+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tklnE-00000006K7E-43yU;
	Wed, 19 Feb 2025 15:15:20 +0000
Date: Wed, 19 Feb 2025 15:15:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	segoon@openwall.com, linux-kernel@vger.kernel.org,
	syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU
Message-ID: <Z7X1iLYDHWFuvqAK@casper.infradead.org>
References: <20250219132905.8214-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219132905.8214-1-aha310510@gmail.com>

On Wed, Feb 19, 2025 at 10:29:05PM +0900, Jeongjun Park wrote:
> In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> only calling idr_for_each(), which can be protected by the RCU read-critical
> section.

Well, no, that's not true.  The IPCS is updated by the callback passed
to idr_for_each().

> And if idr_for_each() is not protected by the RCU read-critical section,
> then when radix_tree_node_free() is called to free the struct radix_tree_node
> through call_rcu(), the node will be freed immediately, and when reading the
> next node in radix_tree_for_each_slot(), the memory that has already been
> freed may be read.
> 
> Therefore, when calling idr_for_each() in shm_destroy_orphaned(), it should
> be modify to protect it within the RCU read critical section.

This is a very complicated way of not describing what the problem is.
How about:

Holding the rwsem is insufficient to protect the IDR from concurrent
modification.  That allows radix tree nodes to be freed while we are
iterating the IDR.  We can prevent this by holding the RCU read lock
in addition to the rwsem.

(a really good commit message would explain why holding the rwsem is
insufficient, but the way ipc uses the IDR and RCU is very complicated,
and I don't remember)

> Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
> Fixes: b34a6b1da371 ("ipc: introduce shm_rmid_forced sysctl")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  ipc/shm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 99564c870084..baef5afadfb9 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -431,8 +431,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
>  void shm_destroy_orphaned(struct ipc_namespace *ns)
>  {
>  	down_write(&shm_ids(ns).rwsem);
> +	rcu_read_lock();
>  	if (shm_ids(ns).in_use)
>  		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
> +	rcu_read_unlock();
>  	up_write(&shm_ids(ns).rwsem);
>  }
>  
> --

