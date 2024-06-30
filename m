Return-Path: <linux-kernel+bounces-235345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35391D457
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C5D1C20954
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D3537E7;
	Sun, 30 Jun 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY93WzQA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595983C6AC
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785311; cv=none; b=CLLFQkZ0Ym0SigeikBZ5uUTRPSaHSqTTjPed9wLSMjJbiCg05b0zfo+J71tFeV+0nXpAdzFqxCl2N+yN26YNoI5r6NlCP5c4F3LASfHVn9Cd3CJRRFoXJ12nT7ESlsMQb2Z0/kElE9QcUGZIPy8FMssHIy3xPLnWVj4TDAaAtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785311; c=relaxed/simple;
	bh=wzy0H/OEHzQcefX+8E+hxXW+qicgdlllGmxWxA5hr0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAlW094l9ENAJJS16fayQtoYLWEHTIRc3LR6lvbk4el2s4bwkbsy9SG5llPJ8PInCiEsJlLRAwGxBdUEIKrEH4u4SeCCWrkwhD3Ew0rmyHfXiPLCJf6P2de2tZOMzOxuyH2E6ovJmwNYTm92mzsUKugMe8TPOvb3b1j5qFLiMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bY93WzQA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719785308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DhhMCywiSojDFBn3CQTLU2DYvorE4y6qoBLkewleiI=;
	b=bY93WzQAgPnJ6sJMjRqhFhHaBNN4mTh2L7kmJHrJH8KRPwlcIskITUcc2ei6L0YZBQL2hE
	8QLF9yFHNZivrBFnlpTjxcaXHeyZE7N43EXwCvSadJ5jcBKleQIC1zPB8xCD2Xwe67jNVs
	TiA83FBYK8q492McFSkWwcCyJNPVp0U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-3bGb1qh8PyuZGN3ih-0jWQ-1; Sun,
 30 Jun 2024 18:08:26 -0400
X-MC-Unique: 3bGb1qh8PyuZGN3ih-0jWQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2331956089;
	Sun, 30 Jun 2024 22:08:24 +0000 (UTC)
Received: from [10.22.8.67] (unknown [10.22.8.67])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C7E81956089;
	Sun, 30 Jun 2024 22:08:21 +0000 (UTC)
Message-ID: <016f2bd0-a192-4ec5-9c4b-d48e8e001cd6@redhat.com>
Date: Sun, 30 Jun 2024 18:08:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: lockdep_set_notrack_class()
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240630051037.2785156-1-kent.overstreet@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240630051037.2785156-1-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6/30/24 01:10, Kent Overstreet wrote:
> Add a new helper to disable lockdep tracking entirely for a given class.
>
> This is needed for bcachefs, which takes too many btree node locks for
> lockdep to track. Instead, we have a single lockdep_map for "btree_trans
> has any btree nodes locked", which makes more since given that we have
> centralized lock management and a cycle detector.

Could you explain a bit more what the current novalidate_class is 
lacking WRT to the bcachefs lock? Is it excessive performance overhead 
or some bogus lockdep warning?

Cheers,
Longman

>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   fs/bcachefs/btree_locking.c   | 2 +-
>   include/linux/lockdep.h       | 4 ++++
>   include/linux/lockdep_types.h | 1 +
>   kernel/locking/lockdep.c      | 9 ++++++++-
>   4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/fs/bcachefs/btree_locking.c b/fs/bcachefs/btree_locking.c
> index 79057cde4c41..16834a6b4c3d 100644
> --- a/fs/bcachefs/btree_locking.c
> +++ b/fs/bcachefs/btree_locking.c
> @@ -10,7 +10,7 @@ void bch2_btree_lock_init(struct btree_bkey_cached_common *b,
>   			  enum six_lock_init_flags flags)
>   {
>   	__six_lock_init(&b->lock, "b->c.lock", &bch2_btree_node_lock_key, flags);
> -	lockdep_set_novalidate_class(&b->lock);
> +	lockdep_set_notrack_class(&b->lock);
>   }
>   
>   #ifdef CONFIG_LOCKDEP
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 08b0d1d9d78b..b76f1bcd2f7f 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -181,6 +181,9 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>   #define lockdep_set_novalidate_class(lock) \
>   	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)
>   
> +#define lockdep_set_notrack_class(lock) \
> +	lockdep_set_class_and_name(lock, &__lockdep_no_track__, #lock)
> +
>   /*
>    * Compare locking classes
>    */
> @@ -338,6 +341,7 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
>   #define lockdep_set_subclass(lock, sub)		do { } while (0)
>   
>   #define lockdep_set_novalidate_class(lock) do { } while (0)
> +#define lockdep_set_notrack_class(lock) do { } while (0)
>   
>   /*
>    * We don't define lockdep_match_class() and lockdep_match_key() for !LOCKDEP
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 70d30d40ea4a..9f361d3ab9d9 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -80,6 +80,7 @@ struct lock_class_key {
>   };
>   
>   extern struct lock_class_key __lockdep_no_validate__;
> +extern struct lock_class_key __lockdep_no_track__;
>   
>   struct lock_trace;
>   
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..b6bb9fcd992a 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4918,6 +4918,9 @@ EXPORT_SYMBOL_GPL(lockdep_init_map_type);
>   struct lock_class_key __lockdep_no_validate__;
>   EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
>   
> +struct lock_class_key __lockdep_no_track__;
> +EXPORT_SYMBOL_GPL(__lockdep_no_track__);
> +
>   #ifdef CONFIG_PROVE_LOCKING
>   void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
>   			     lock_print_fn print_fn)
> @@ -5002,6 +5005,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>   	if (unlikely(!debug_locks))
>   		return 0;
>   
> +	if (unlikely(lock->key == &__lockdep_no_track__))
> +		return 0;
> +
>   	if (!prove_locking || lock->key == &__lockdep_no_validate__)
>   		check = 0;
>   
> @@ -5764,7 +5770,8 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
>   
>   	trace_lock_release(lock, ip);
>   
> -	if (unlikely(!lockdep_enabled()))
> +	if (unlikely(!lockdep_enabled() ||
> +		     lock->key == &__lockdep_no_track__))
>   		return;
>   
>   	raw_local_irq_save(flags);


