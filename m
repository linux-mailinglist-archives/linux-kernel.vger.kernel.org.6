Return-Path: <linux-kernel+bounces-177660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C488C42B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1026E1C20F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B615358C;
	Mon, 13 May 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBkPS3Xz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B814EC7A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608708; cv=none; b=mlDrmaGqUtHxJbnxnIPvB9OkJjkS56z4NR4hQ2bkx5y/8suH2SZP/flsQ7TOl151McPXQxLb5kkMi596Q1sb4YUX5gKDDGcGoFTNJnZmVajdZjiDMamBKAXXVly4oGCnOhVImy6jQGZkqzRvzv/7d2PslLz9bSUvr5yIF4N0OY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608708; c=relaxed/simple;
	bh=a17Hmcn6dsjVqVJ3G1GnuKDM/OvBgpuvKGrdxrbXBHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC0NST7wSHR8H+WUALObpk449lId5fs8Z7w4kAuqlRorFbxx75GwtOnxVO/Ytyz9NEtV9phioOnJKVHgjwaMmgFwjR0dfEoYHKzQsOZGSAskMlTlJRZKS1RaI2yJBG9B+kJFi2qO3ysluQXCsdy5cp3dXLJoihtzcvjRNaQ+S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBkPS3Xz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715608706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQZWlLEpCHZ3q09XMWtuYhhd2HLm0dB5aE2f3Zt+obA=;
	b=PBkPS3Xztw19NWVBIvgo6hoSV5EqwomrLde5tHdf4CEDHTqw80cJK6fPmPRzNEJDuqeSAV
	zReYEA99yIBaS7apxRUOMxhAKvLrxHyUrq4QmDsOPxDBJzHSED9qpC3FZqvhU6ACd5UatF
	whwWt1rgvNrOF6VFVegCPwYgbsWenyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-aqlTqgKuNxiE5QTM8XCj1g-1; Mon, 13 May 2024 09:58:21 -0400
X-MC-Unique: aqlTqgKuNxiE5QTM8XCj1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B4BA800CA5;
	Mon, 13 May 2024 13:58:21 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FDB11C00A97;
	Mon, 13 May 2024 13:58:15 +0000 (UTC)
Date: Mon, 13 May 2024 09:58:12 -0400
From: Phil Auld <pauld@redhat.com>
To: Paul Sherwood <paul.sherwood@codethink.co.uk>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix grammar and typos in comments
Message-ID: <20240513135812.GA9998@lorien.usersys.redhat.com>
References: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sat, May 11, 2024 at 09:26:44AM +0100 Paul Sherwood wrote:
> - conjugate verb to match subject of sentence
> - s/a entity/an entity/g
> - s/this misbehave/this misbehaviour/
> - a few typos
>
  - not starting all the lines of a commit message with "-", priceless.

Plus, you're just repeating what's in the actual patch.

Otherwise, these changes themselves look good to me.



Cheers,
Phil


> Signed-off-by: Paul Sherwood <paul.sherwood@codethink.co.uk>
> ---
>  kernel/sched/deadline.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a04a436af8cc..e9334b11edde 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -4,9 +4,9 @@
>   *
>   * Earliest Deadline First (EDF) + Constant Bandwidth Server (CBS).
>   *
> - * Tasks that periodically executes their instances for less than their
> + * Tasks that periodically execute their instances for less than their
>   * runtime won't miss any of their deadlines.
> - * Tasks that are not periodic or sporadic or that tries to execute more
> + * Tasks that are not periodic or sporadic or that try to execute more
>   * than their reserved bandwidth will be slowed down (and may potentially
>   * miss some of their deadlines), and won't affect any other task.
>   *
> @@ -816,16 +816,16 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>   * exhausting its runtime.
>   *
>   * Here we are interested in making runtime overrun possible, but we do
> - * not want a entity which is misbehaving to affect the scheduling of all
> + * not want an entity which is misbehaving to affect the scheduling of all
>   * other entities.
>   * Therefore, a budgeting strategy called Constant Bandwidth Server (CBS)
>   * is used, in order to confine each entity within its own bandwidth.
>   *
>   * This function deals exactly with that, and ensures that when the runtime
> - * of a entity is replenished, its deadline is also postponed. That ensures
> + * of an entity is replenished, its deadline is also postponed. That ensures
>   * the overrunning entity can't interfere with other entity in the system and
> - * can't make them miss their deadlines. Reasons why this kind of overruns
> - * could happen are, typically, a entity voluntarily trying to overcome its
> + * can't make them miss their deadlines. Reasons why this kind of overrun
> + * could happen are, typically, an entity voluntarily trying to overcome its
>   * runtime, or it just underestimated it during sched_setattr().
>   */
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> @@ -860,7 +860,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	 * At this point, the deadline really should be "in
>  	 * the future" with respect to rq->clock. If it's
>  	 * not, we are, for some reason, lagging too much!
> -	 * Anyway, after having warn userspace abut that,
> +	 * Anyway, after having warned userspace about that,
>  	 * we still try to keep the things running by
>  	 * resetting the deadline and the budget of the
>  	 * entity.
> @@ -896,8 +896,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>   *
>   * IOW we can't recycle current parameters.
>   *
> - * Notice that the bandwidth check is done against the deadline. For
> - * task with deadline equal to period this is the same of using
> + * Notice that the bandwidth check is done against the deadline. For a
> + * task with deadline equal to period this is the same as using
>   * dl_period instead of dl_deadline in the equation above.
>   */
>  static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
> @@ -930,8 +930,8 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
>  }
>  
>  /*
> - * Revised wakeup rule [1]: For self-suspending tasks, rather then
> - * re-initializing task's runtime and deadline, the revised wakeup
> + * Revised wakeup rule [1]: For self-suspending tasks, rather than
> + * re-initializing the task's runtime and deadline, the revised wakeup
>   * rule adjusts the task's runtime to avoid the task to overrun its
>   * density.
>   *
> @@ -941,7 +941,7 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
>   * Therefore, runtime can be adjusted to:
>   *     runtime = (dl_runtime / dl_deadline) * (deadline - t)
>   *
> - * In such way that runtime will be equal to the maximum density
> + * This way the runtime will be equal to the maximum density
>   * the task can use without breaking any rule.
>   *
>   * [1] Luca Abeni, Giuseppe Lipari, and Juri Lelli. 2015. Constant
> @@ -987,9 +987,9 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
>   * When the task is starting a new period, the Original CBS is used. In this
>   * case, the runtime is replenished and a new absolute deadline is set.
>   *
> - * When a task is queued before the begin of the next period, using the
> - * remaining runtime and deadline could make the entity to overflow, see
> - * dl_entity_overflow() to find more about runtime overflow. When such case
> + * When a task is queued before the beginning of the next period, using the
> + * remaining runtime and deadline could make the entity overflow, see
> + * dl_entity_overflow() to find more about runtime overflow. When such a case
>   * is detected, the runtime and deadline need to be updated.
>   *
>   * If the task has an implicit deadline, i.e., deadline == period, the Original
> @@ -1002,7 +1002,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
>   * runtime/deadline in a period. With deadline < period, the task would
>   * overrun the runtime/period allowed bandwidth, breaking the admission test.
>   *
> - * In order to prevent this misbehave, the Revisited CBS is used for
> + * In order to prevent this misbehaviour, the Revisited CBS is used for
>   * constrained deadline tasks when a runtime overflow is detected. In the
>   * Revisited CBS, rather than replenishing & setting a new absolute deadline,
>   * the remaining runtime of the task is reduced to avoid runtime overflow.
> -- 
> 2.33.0
> 
> 

-- 


