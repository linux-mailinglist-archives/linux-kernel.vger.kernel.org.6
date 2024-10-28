Return-Path: <linux-kernel+bounces-384639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73DF9B2CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153C81C21914
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449D1D1302;
	Mon, 28 Oct 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mSPpj2Bf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E3187876
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110983; cv=none; b=UW5lhPf1+ybby7lyS6eGyBn1p4KWHKFLIvQ5l1U/YOxHMmrKr7V3dvMe2Bb7dleeidHKnJL3g7VoelIzXRs+bwF4fCedWecNZh6s7cYIlALCTKYG4kNXQbduHn+q3p6beTDN335oNeX4pUtG/KIlRjXEB5w9zggBXXCBA3xEfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110983; c=relaxed/simple;
	bh=E4nXIJEzxunC4k0UUfIJa7rSAkiLTBNnOuWxU8CwlHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJN5EUZiedPClfHgIj97/V5zws0h37AFjqPtjmzBL5JB+hN5b5M8SZB3ZJWRB3qCrWvJgE7K7a9ziUd6Eg+YGn0P6pP+LjoeYj2Zz6XfZrLXb3fiULsiiRAhTiXsNbBCxqbN8ckkk6j17GAcB62nq6Nmc5i8KjPlKl8w47gsCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mSPpj2Bf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oftZlDjq+mXH+UsjsGRIt5ld8+hc52feyu3RmSLJY0c=; b=mSPpj2BfSKqud/rCMJkx+14jH2
	/b3QVnolqpk3l7p4sr/HuhoLZzRYp4y+gnHA1i5qpT7MzSldTompGnPoGW1ICaRpNdCfG1iOHSLqx
	hyYQNrSn+DtdDHtjQW9ol3WdrF1OPpNL6DxvxQj6eqHv6gpdCqDGE2vGNSm5ZancDyYfH30SRpWSY
	8NmeK+ZliW7zh43HAW0EdcTCYllCXmuCpvPcbLNzNVwywMIX7y+gFJdoO3zgtLfJPKuB/N/rtVayW
	kaTHA7aQ+qxa+mA0w13951MBtHAb3EhnAjxXQSt5/oEUoT9aT/fP81jxQ+C3yCsK3L6UXTHAgsJP0
	akxWiehQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Mti-00000009cuR-2ulm;
	Mon, 28 Oct 2024 10:22:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBE8430083E; Mon, 28 Oct 2024 11:22:53 +0100 (CET)
Date: Mon, 28 Oct 2024 11:22:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 3/3] futex: Use the task local hashmap.
Message-ID: <20241028102253.GN9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026224306.982896-4-bigeasy@linutronix.de>

On Sun, Oct 27, 2024 at 12:34:52AM +0200, Sebastian Andrzej Siewior wrote:
> Use the hashlocal hashmap if provided.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/futex/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 7c97fc96f84a3..ee5a6902154c5 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -119,13 +119,18 @@ late_initcall(fail_futex_debugfs);
>   * @key:	Pointer to the futex key for which the hash is calculated
>   *
>   * We hash on the keys returned from get_futex_key (see below) and return the
> - * corresponding hash bucket in the global hash.
> + * corresponding hash bucket in the global hash. If the FUTEX is private and
> + * a local hash table is privated then this one is used.
>   */
>  struct futex_hash_bucket *futex_hash(union futex_key *key)
>  {
> +	struct futex_hash_table *fht;
>  	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
>  			  key->both.offset);
>  
> +	fht = current->futex_hash_table;
> +	if (fht && (key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED)) == 0)
> +		return &fht->queues[hash & (fht->slots - 1)];

Perhaps add a helper like:

static inline bool futex_key_is_private(struct futex_key *key)
{
	/*
	 * Relies on get_futex_key() to set either bit for shared
	 * futexes -- see comment with union futex_key.
	 */
	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
}

