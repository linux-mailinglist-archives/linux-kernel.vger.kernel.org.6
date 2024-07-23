Return-Path: <linux-kernel+bounces-259777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0C939D02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D80282910
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5E14C58C;
	Tue, 23 Jul 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0GTZPNN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945414B94E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724924; cv=none; b=Y++QGTqk4xWMv10hw4X7CuACvMtAAGL2hAcnaKoC84UIdzpr10VrOVF6FGTGXUx+nmJPVjQ/Mg51yGpANQxjJOq52cK8EglZoNJY7Xh6RHXHlCrOR32OXlln07VmPF56enmInDbLNy9Nkt0A/Q7SPYHTX0oHItqbSJ2jruH53sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724924; c=relaxed/simple;
	bh=cYuef4yedOHxKwwOpPoC7sGuOoTyfhl4KaigcKcVzHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX2E6ABA/NZrq/trFYZHFq0fIwvkX9zMU5476WNwItUaJZds7S3buRPvrA+DEaGj9oww5GuMFK/NpyoZH9VRmJRVM0Xn9aoP2MEGDZN3wkmSWwJjbTwv/UrJfkD4oe8L+WHe3hY8vKpQth84VBZvD0O+LBD3YO21GwCJyLr9EyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0GTZPNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721724921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bBvB8yIoYpWYbFnCfiKQzWXZmKSEZ0SNbHfuAG2QuY=;
	b=H0GTZPNNuNsgZ+B6O+uFs2bTvr2ehlS/C4e6p3/ykt2IarH7ThZ/mPzGmuerevu9wtsuoi
	7m4lgLAOqBeOIiRzwyeO+KPc1/akbnTuhbecWBckGGRVqz2+wqkNEqH+YgYwXVmLXsQADD
	bo7z9iMzV3p1ekszBJ3LoUgk3mrC5dM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-ed0iX491N0ONWGRyfTUjZw-1; Tue, 23 Jul 2024 04:55:19 -0400
X-MC-Unique: ed0iX491N0ONWGRyfTUjZw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8234478650aso1053228241.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721724919; x=1722329719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bBvB8yIoYpWYbFnCfiKQzWXZmKSEZ0SNbHfuAG2QuY=;
        b=FbJY6JvEO3ssjlXGC07WSD+dHuqhuRm62wQE2JipKWKsqRashbGiMMy9rayg9lcopf
         LTLDvnwHU6AHZQ2t2Kx8NCsKo3Yp1fqz6qapya5cFjLNqMgWA6RGZ9zbi0CKjVCCK7Cg
         HA3Wh1us4ZLLkpw7SjzzeIf92gayO9Zt0epIDXGobeUUKuMDw/f5u+X8i9xD6xhLwRd5
         DIuClfKnOTC2eNejBXZfiaaFq4lXXFexUKBvQ1dQRFLVEkY/tLRl5MQpwvZswoPbvR4k
         1NcG7DMpGRmDrf45JK6efdyyRX6amVUujese4rbksgkeLzkIVcoIale3fOtuudtZV/sp
         RyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXdVPxHXsz9/ZFMLkTQlyJd3AE/bTm0EcN2LZSPWF+ywJ+PjHjbQklTt19EHUZw0Mz5uY0nYVpB7edWOogib9g3e/BnCbz3lJqUWOc
X-Gm-Message-State: AOJu0Yykgqa18vceQz4rZViQTCdyHB7rMwUsudQEjiZ+5HMyh+vkERY6
	dna9+hA9Ll6d23EmtBYwNkBR5wJyogWwGCBZxKmD+IZJ73V+lzbmoJEfD9AJx0P+5v9TUD4QBYS
	l2WqAX/JUsYO+IhVatHmqTLfVyVZolbN3bb3nOkBOAwNkNzGCV5tbY241/mOovA==
X-Received: by 2002:a05:6102:1484:b0:493:afc8:17e2 with SMTP id ada2fe7eead31-493afc81e62mr3715566137.17.1721724919010;
        Tue, 23 Jul 2024 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGkRX5Nur1dqD6ILqmc92zwaB2fiyr8yON9W7m571tWg23qdt44sfCx9R1L0MvOGhv0bx67g==
X-Received: by 2002:a05:6102:1484:b0:493:afc8:17e2 with SMTP id ada2fe7eead31-493afc81e62mr3715556137.17.1721724918664;
        Tue, 23 Jul 2024 01:55:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.147.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fab28fsm459264485a.3.2024.07.23.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:55:18 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:55:14 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] sched/deadline: avoid redundant check for boosted
 task
Message-ID: <Zp9v8gJ8nqyLkL1m@jlelli-thinkpadt14gen4.remote.csb>
References: <20240722132935.14426-1-wander@redhat.com>
 <20240722132935.14426-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722132935.14426-3-wander@redhat.com>

Hi Wander,

On 22/07/24 10:29, Wander Lairson Costa wrote:
> enqueue_dl_entity only calls setup_new_dl_entity if the task is not
> boosted, so the WARN_ON check is unnecessary.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  kernel/sched/deadline.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 312e8fa7ce94..908d5ce79425 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -785,12 +785,11 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
>   * one, and to (try to!) reconcile itself with its own scheduling
>   * parameters.
>   */
> -static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> +static inline void __setup_new_dl_entity(struct sched_dl_entity *dl_se)
>  {
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>  	struct rq *rq = rq_of_dl_rq(dl_rq);
>  
> -	WARN_ON(is_dl_boosted(dl_se));
>  	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
>  
>  	/*
> @@ -809,6 +808,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>  	replenish_dl_new_period(dl_se, rq);
>  }
>  
> +static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> +{
> +	WARN_ON(is_dl_boosted(dl_se));
> +	__setup_new_dl_entity(dl_se);
> +}
> +

So, the other call path is from dl_server_start() and for this we know
the entity is not boosted either. We could probably just remove the
WARN_ON w/o the additional wrapper function. That said, considering it's
not fast path, I wonder if we actually want to leave the WARN_ON where
it is, so that we can catch potential future erroneous usages?

Thanks,
Juri


