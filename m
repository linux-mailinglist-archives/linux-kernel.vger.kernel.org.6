Return-Path: <linux-kernel+bounces-286291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4E95192C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F632846E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37A1AE05F;
	Wed, 14 Aug 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijLl46m4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4501AE049
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632148; cv=none; b=U9osjDqt0b8C9S4rrMsvzdDIsn2D+bzqPMPXgPl3H9rXrgkellwJvM48P+j+RSMJrOzP1gF2eDXqKt9NrCS2gr3uWpWsu0OtmdqF+p6WZHI/KEdgycWI/r7Fku7hBZTlEU+nuZWcA9+sKDUF4BkIdD7f4zcdFCDznPyeWdP7I9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632148; c=relaxed/simple;
	bh=q34DH8Qrlv1hl4DSt0D47Oh9DNMXeue9FDFWUShDwWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBFaePNXVUCVaLICPoyU7sfU4MrQc9alqQy/DkHj8NJL/d64gGylDQZOqXHU7rpLTj9tTIN/NfemNQQfgs/hpgNnsyK5ajSIzGPQUYC61TqeVWr8hBhXdsOVCq3GAMY3RSz1ZdsxfsC8uien04+M8zigAr54zG4mEq5EVlcr6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijLl46m4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723632145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVVzZ/fnbsCkcspLBv4HkRJKpx2lJdkYQY9shkbiIPY=;
	b=ijLl46m4USKp+t6d7bT/irK7zPz6qVipmWczixzLTDO+64j+e9dsH0ZDMFvwtetaLKwlGv
	BsAT7vLdW+zK4lmq1oWUItWJBBIl3Nb7tADhz5ODN9H8kxusE/wmBuuDU185kwE3pIdIFj
	FvNIla8ra9/b2X1USsGYGEguzDrTndc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-4au4Hkl0N7CdsRX5Xn5tGA-1; Wed, 14 Aug 2024 06:42:24 -0400
X-MC-Unique: 4au4Hkl0N7CdsRX5Xn5tGA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-493b2b43cb7so1449520137.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723632143; x=1724236943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVVzZ/fnbsCkcspLBv4HkRJKpx2lJdkYQY9shkbiIPY=;
        b=tiWijgs5uXtuStwQbNAmxLQ6vtCFXNZAosQyEwCUBhxCimIt9mcLfwOchvfl0i4FoR
         MqgL4mSHD8mAZgHa3xpTM+QdEiSsYDA242MI08DgqmRpLz5tsFgVRr0U+oCF5L9qcqzl
         Pnzdyf79TFtFr+FFwJr3nNYJXuz1NWywP5/OFZWzN9IisqOpf/Flq6IYda20FWl4QqI8
         tBVtjteiJewYupaQkBisCDGiBczdJWq72vkS88jb+LdWTGJDSI1wliErs8CpXjaTcXZm
         No31fkn3ZmitsxMi8KyahAdtoQCwZE9gYP1NW7qY80bRgHKXhrJMGgSBt9jZtdA3/+1o
         A2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUKhQCjt1+ISRIAb7PzGX0UXod7pKn0n3HLGeqZ5TYI83L7aw+HotT8HktegMwnhbQt8Agcfk6HAdZ+LTkKZp1mYBM4KWuybyqjUY2r
X-Gm-Message-State: AOJu0YxKvyNJQWr4BtY7wEyxgX3sWJKdU2Q7IjdmxItm54q7Ok23om4u
	JpXub4sndVwpl+IBKF+R7Zoz8kOv7qq4s2sZi8XiVQU3xaC4y3d+MtewvltWEEYMw3bVkrKyEDs
	jNM4AKzvma4HvQ6op/Ml921K3b0PUzenRNezX9SjYEIAiVR0KlzpEFLz8fRXwUA==
X-Received: by 2002:a05:6102:b07:b0:492:a74d:1664 with SMTP id ada2fe7eead31-497598de9c6mr2770428137.8.1723632143561;
        Wed, 14 Aug 2024 03:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe0qdsFEoBU+bJ+49VBnw249Z4fPSpbFZdZnaHTtEYpEpqWJYXJOMSItv7ux61AV0+HDgwCA==
X-Received: by 2002:a05:6102:b07:b0:492:a74d:1664 with SMTP id ada2fe7eead31-497598de9c6mr2770409137.8.1723632143148;
        Wed, 14 Aug 2024 03:42:23 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm421228985a.84.2024.08.14.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:42:22 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:42:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	joelaf@google.com
Subject: Re: [PATCH 9/9] sched: Add pick_task(.core)
Message-ID: <ZryKCphkLfRXqGgS@jlelli-thinkpadt14gen4.remote.csb>
References: <20240813222548.049744955@infradead.org>
 <20240813224016.471745809@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813224016.471745809@infradead.org>

Hi Peter,

On 14/08/24 00:25, Peter Zijlstra wrote:
> In order to distinguish between a regular vs a core pick_task()
> invocation, add a boolean argument.
> 
> Notably SCX seems to need this, since its core pick
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

...

> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2409,7 +2409,7 @@ static struct sched_dl_entity *pick_next
>   * __pick_next_task_dl - Helper to pick the next -deadline task to run.

Super minor thing, but the above comment becomes stale after this and
previous changes.

>   * @rq: The runqueue to pick the next task from.
>   */
> -static struct task_struct *__pick_task_dl(struct rq *rq)
> +static struct task_struct *pick_task_dl(struct rq *rq, bool core)
>  {
>  	struct sched_dl_entity *dl_se;
>  	struct dl_rq *dl_rq = &rq->dl;
> @@ -2423,7 +2423,7 @@ static struct task_struct *__pick_task_d
>  	WARN_ON_ONCE(!dl_se);
>  
>  	if (dl_server(dl_se)) {
> -		p = dl_se->server_pick_task(dl_se);
> +		p = dl_se->server_pick_task(dl_se, core);
>  		if (!p) {
>  			dl_se->dl_yielded = 1;
>  			update_curr_dl_se(rq, dl_se, 0);
> @@ -2437,11 +2437,6 @@ static struct task_struct *__pick_task_d
>  	return p;
>  }
>  
> -static struct task_struct *pick_task_dl(struct rq *rq)
> -{
> -	return __pick_task_dl(rq);
> -}
> -

Best,
Juri


