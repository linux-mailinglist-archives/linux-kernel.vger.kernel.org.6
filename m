Return-Path: <linux-kernel+bounces-237208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A62091ED78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2670B21C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02622301;
	Tue,  2 Jul 2024 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2L+NHq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE6374DD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891273; cv=none; b=kCCW4f0mxYFOYYwXjS3aAiakBi/8ZY1OkAK8g2djJXGtWS9W2PNJhmwF+/QUBsA970vnPYBXBHYLecUMx5QMSo3AKwVidmM4zGWl0/4ogZd59Du/WdywCwKH5uTe2vpu+9n6YoTJLM77sYAkV//SEfgB6hiJfywIg6F2Bto0b7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891273; c=relaxed/simple;
	bh=503ZizKRyOSSKuX/bUsyXVDaoDNRwwaYTCc70WniP00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCXu3VHGwzjP7slR8DkZncRmOM9h99JTos9H/AO7HAVzn8G80XtonF3vnutOTS3+olQCbrxq6wgvlqZ8Du+zmVCREFV+0cszEQ8lPEQNjp7aPFni0qzqWitGZuOdLo73lV995EQ07Do7URBFTcPfFIAhNGrYJvNfqzYqguh4ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2L+NHq/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719891270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6yOa8Xcw2ywxRoH8sabNGsvq6y6iQPejDnzWLSDKoA=;
	b=h2L+NHq/lV/XSC/sMbz9x5toCKpXRTZZKDtadsHoh1jWeM+h8OnUFPifz7zTtfC6hW7TZn
	HIqzbOpjnaoJsya8fm9+8G6HwIQgWZ9juigK0ZbEUoUcaqo7GnB9R4mt6Pcc+LD2qhXUqZ
	BnDuI8KDaGp4nvngA1WlCIWn9q3odz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-GmvpbKZnPU-YB03RO9w14w-1; Mon,
 01 Jul 2024 23:34:26 -0400
X-MC-Unique: GmvpbKZnPU-YB03RO9w14w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1624F195608C;
	Tue,  2 Jul 2024 03:34:24 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A95419560AD;
	Tue,  2 Jul 2024 03:34:17 +0000 (UTC)
Date: Tue, 2 Jul 2024 11:34:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yang Yang <yang.yang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v4] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZoN1NXSHap19qa+B@fedora>
References: <20240617024556.211451-1-yang.yang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617024556.211451-1-yang.yang@vivo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 17, 2024 at 10:45:51AM +0800, Yang Yang wrote:
> Configuration for sbq:
>   depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>   map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>   map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>   T1:                                       T2:
>   __blk_mq_get_tag                          .
>   __sbitmap_queue_get                       .
>   sbitmap_get                               .
>   sbitmap_find_bit                          .
>   sbitmap_find_bit_in_word                  .
>   __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>   sbitmap_deferred_clear                    __sbitmap_queue_get
>   /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>     if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>       return false;                         __sbitmap_get_word -> nr=-1
>     mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>     atomic_long_andnot()                    /* map->cleared=0 */
>                                               if (!(map->cleared))
>                                                 return false;
>                                      /*
>                                       * map->cleared is cleared by T1
>                                       * T2 fail to acquire the tag
>                                       */
> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
> 
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
> 
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> 
> ---
> Changes from v3:
>   - Add more arguments to sbitmap_deferred_clear(), for those who
>     don't care about the return value, just pass 0
>   - Consider the situation when using sbitmap_get_shallow()
>   - Consider the situation when ->round_robin is true
>   - Modify commit message
> Changes from v2:
>   - Modify commit message by suggestion
>   - Add extra check in sbitmap_deferred_clear() by suggestion
> Changes from v1:
>   - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
> ---
>  include/linux/sbitmap.h |  5 +++++
>  lib/sbitmap.c           | 45 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..ec0b0e73c906 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>  	 * @cleared: word holding cleared bits
>  	 */
>  	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_lock: Held while swapping word <-> cleared
> +	 */
> +	spinlock_t swap_lock;
>  } ____cacheline_aligned_in_smp;
>  
>  /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..9bd85a9b74b9 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -60,12 +60,32 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>  /*
>   * See if we have deferred clears that we can batch move
>   */
> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> -{
> -	unsigned long mask;
> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
> +		unsigned int depth, unsigned int alloc_hint, bool wrap)
> +{
> +	unsigned long mask, flags, word_mask;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&map->swap_lock, flags);
> +
> +	if (!map->cleared) {
> +		if (depth > 0) {
> +#if BITS_PER_LONG == 64
> +			word_mask = U64_MAX >> (BITS_PER_LONG - depth);
> +#else
> +			word_mask = U32_MAX >> (BITS_PER_LONG - depth);
> +#endif

Can we avoid the above conditional compiling by the following way?

	word_mask = (~0UL) >> (BITS_PER_LONG - depth);


> +			if (!wrap && alloc_hint)
> +				word_mask &= ~((1UL << alloc_hint) - 1);

The current behavior is to always retry after moving ->cleared to
word, and we change it to retry in case of any free bits. So here
is it for avoiding dead loop by taking wrap & alloc_hint into
account? If yes, this way looks fine, but I'd suggest to document
this change.


Thanks, 
Ming


