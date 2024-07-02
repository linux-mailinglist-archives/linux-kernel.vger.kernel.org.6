Return-Path: <linux-kernel+bounces-237299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835AB91EEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66401C2123E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7007BAE5;
	Tue,  2 Jul 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iFNwNx5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52D60BBE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901596; cv=none; b=MBf80LG1O7M6pjtBuBgt4n7DSWmvp92L3/oNs8F5RoBDOCvCtnxJlHrhOtOYMR/BjjVWR8J76TaDABFm5dF8998Ap7F98yzOeMOsdInWDjPHJDHUNjJGYG0IEs9OW+D27ADjCvmv9AcMquB/al6jEgFPIjH2JIuYOgA22wp3rms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901596; c=relaxed/simple;
	bh=/NWgWzyITs0KIhEoudIf/i46NZ3AxtyQk9ZuZLbP7tM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m9aw7IdAUnnFfY5aXdkqRV25NHex3oJViq641d2n3yrz3P3cQ8NxElJEnJROl4pZN3YjZcLxav/FNf7KAHMlYZC1XCdCcPfszDxKGYdNnto5RgNPgrpnjAg/Nw1sMS2azIvONdqRc3mdWcp6dLky+xO92VnKZWcBZIMB37chO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iFNwNx5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B55C116B1;
	Tue,  2 Jul 2024 06:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719901595;
	bh=/NWgWzyITs0KIhEoudIf/i46NZ3AxtyQk9ZuZLbP7tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFNwNx5BdUiPSyNhTX2+HvsdyzHpS5vzd+UCV9fOvKf9NCRCaqhq783P+H1ee90E+
	 oR5MpznKto0jbvssxKDVTa1RrtUy2f67F4Ad8Wy0JSI20oEPP8w+Wua24yRllScKXx
	 cqla6yHYJDe79HKj/+EJoc2p9nAEv4kGl3XsRcx0=
Date: Mon, 1 Jul 2024 23:26:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jack@suse.cz, surenb@google.com, linux-kernel@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-buf: Remove unnecessary kmalloc() cast
Message-Id: <20240701232634.0bddb542ddea123b48dcabdf@linux-foundation.org>
In-Reply-To: <20240630011215.42525-1-thorsten.blum@toblux.com>
References: <20240630011215.42525-1-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 03:12:16 +0200 Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Casting the return value of kmalloc() is unnecessary and can be
> removed. Remove it and fix the following Coccinelle/coccicheck warning
> reported by alloc_cast.cocci:
> 
>   WARNING: casting value returned by memory allocation function to (struct dma_fence_chain *) is useless.
> 
> Compile-tested only.
> 
> ...
>
> --- a/include/linux/dma-fence-chain.h
> +++ b/include/linux/dma-fence-chain.h
> @@ -87,7 +87,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
>   * Returns a new struct dma_fence_chain object or NULL on failure.
>   */
>  #define dma_fence_chain_alloc()	\
> -		((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL))
> +		kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL)
>  
>  /**
>   * dma_fence_chain_free

No, I do think the cast is useful:

	struct page *page = dma_fence_chain_alloc();

will presently generate a warning.  We want this.  Your change will
remove that useful warning.


Unrelatedly: there is no earthly reason why this is implemented as a
macro.  A static inline function would be so much better.  Why do we
keep doing this.

