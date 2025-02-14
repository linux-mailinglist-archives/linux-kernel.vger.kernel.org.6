Return-Path: <linux-kernel+bounces-515536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A9A365F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904847A3DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333371A76BC;
	Fri, 14 Feb 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1c+xDEV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110519007F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559502; cv=none; b=DhH4XdfJOolh+vR1gUz/AGLwA6Hi+JDVvXMUVXJWIUHM7K0hyWMVB0dc5250Su9NfAHwFB2xVAJ8wJQb9ks1vkM7A+xTXv4wYckyiZXU9e18dDwwi7mPbT5Iax+dsslZrZgBN/eWkgHGXyZJkF37S12xz0m5DPCDKH0+iD6aFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559502; c=relaxed/simple;
	bh=tY/QrJ6TLiR5uq+GUfd8p52iDVYm9mPY2MfO5yiCsM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heDWNaUOoltB+1yZmN69g5Iqhe9+TJrZaB6q2j5Q0vP4jBHHgB7hxKvqg4pvD24noq1DN94Jc0BKXl6FLLpFUDNzlWuljtAfI7g2cKI5enASXF1s7YsLD2b4cer5SxNve2elMj4JWBbjjDmXNk/uyYhpw91PweEUeL7G4+5qbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H1c+xDEV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJY+Un96mohCR/jRGL+IsydTgTLFWtyd08Up8an2AZU=; b=H1c+xDEV7uRNaVKM/qoOL7PHyN
	Trz5VfFABe7al5zgDRdNNYNFA9HP/7bkm9S3bc7EzQO1N7PPgEK5EzLIp/IlPDDZ8Hf05ugth2kNe
	WbXSOxJ5kQq/J/e3hUu55UF6Wdu/75jUaTDfs/YEbDyTOJq+mnl2EfcyaPUgBQYF2Yamnr72VCur6
	U81v4qn/aFXggJwYhxT3TfBq2UUUGJJSe1BTr+QqbmlbAPPV/DpGTWab/lIgpa4NZKTrDzwnttjwK
	6SsGnKZshTNT5gK+GxuVgXpgt7PjgYEzfjZmu0ph5NhtVo+3bJAg6BY4UONrsGi3b0ONKCb2+EJJ5
	+JvniXBg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tj0t8-0000000Bum4-3VQR;
	Fri, 14 Feb 2025 18:58:10 +0000
Date: Fri, 14 Feb 2025 18:58:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, brauner@kernel.org,
	lorenzo.stoakes@oracle.com, davidlohr.bueso@hp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of
 semaphore
Message-ID: <Z6-SQtS-SuxiBzoK@casper.infradead.org>
References: <20250214180157.10288-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214180157.10288-1-aha310510@gmail.com>

On Sat, Feb 15, 2025 at 03:01:57AM +0900, Jeongjun Park wrote:
> In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> only calling idr_for_each(), which can be protected by the RCU read-critical
> section.
> 
> And if idr_for_each() is not protected by the RCU read-critical section,
> then when radix_tree_node_free() is called to free the struct radix_tree_node
> through call_rcu(), the node will be freed immediately, and when reading the
> next node in radix_tree_for_each_slot(), the memory that has already been
> freed may be read. 
> 
> Therefore, I think it is appropriate to use RCU instead of semaphore to
> protect it.
> 
> Fixes: d9a605e40b13 ("ipc: rename ids->rw_mutex")

This does not fix that commit.  That's just the last commit that touches
this line.  Indeed, it doesn't fix anything.

You need to justify why making this change is desirable.  Does it speed
anything up?

> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  ipc/shm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 99564c870084..8fd87c4e5dc8 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -430,10 +430,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
>  
>  void shm_destroy_orphaned(struct ipc_namespace *ns)
>  {
> -	down_write(&shm_ids(ns).rwsem);
> +	rcu_read_lock();
>  	if (shm_ids(ns).in_use)
>  		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
> -	up_write(&shm_ids(ns).rwsem);
> +	rcu_read_unlock();
>  }
>  
>  /* Locking assumes this will only be called with task == current */
> --

