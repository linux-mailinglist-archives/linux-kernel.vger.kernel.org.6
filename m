Return-Path: <linux-kernel+bounces-259799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF924939D59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE4283349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C014C582;
	Tue, 23 Jul 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTYs/csg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB9208B6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726148; cv=none; b=WMx1tPwR5TqK4ruX9OsQNRsIIZVcHNvn7qJM9QZDo7q21NFpYESNWw7Ze6i5Y1gHFRoXQswemIN1qdB2u7K0NUMwanh1YlbaE8wt/dOawn6v3P/6WSAoBAlqO1daS8X7cQllVYIg2QP5somsG6vpe3Tz7f/UB3pCvrzBCe/IbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726148; c=relaxed/simple;
	bh=JKRazvoFIf/4bQMW4OxTf84GHZy/Gi963R+CIj248Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzxLlQCSWgyjafmVLhBugyzTy92s4lMiktmoAX0x2BIt9cz79ZSeSrJgI2VekZF363IKqMczg2iOomtwxhKJoLnjhtQcoq4OxElYYCm8pLLRUyoBxnmlGftPeHinDuraM7alPoogmvVUCWzm4Bf0v/QIfKCU9CDaShX7d7HLOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTYs/csg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721726145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dn0oMV7bhyORjlIV9NNrpUbkRujXMXyPxUT7qs9yU/E=;
	b=bTYs/csgSI1wjB8mqzdTEPfWSbxmENZGPpAR8rp6V5eWEi7+GFITy94YcXTvFen+5wuKjX
	islImNAqezgI1k2S1G0zruLi/E/oa1aCxaCH7IeHylo29g/R817DNRpciGFkvn205b+33+
	LxAkOSscROhbQy+4wnggO/X56fZ+lps=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-rvU2neXnPoq9Z4Pr2GNLRA-1; Tue, 23 Jul 2024 05:15:42 -0400
X-MC-Unique: rvU2neXnPoq9Z4Pr2GNLRA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-66b3b4415c7so83831897b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726142; x=1722330942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn0oMV7bhyORjlIV9NNrpUbkRujXMXyPxUT7qs9yU/E=;
        b=HVZBSsWNASHWMTua5vjdCAjjCI5+E6mu41QCdZy+6aS8JRSXwhNhAV1AnqXSvsoX26
         zF0nC8xJNEgMKUuMsy4EXhTx6nhoXqA7p/INuXBNkjFjP0ah/WonZXrwQBhWZp1KP/AJ
         2f6my8hHV7oWsxlKe49UMzFeaKobHJUHsm9gxw5bAkAs7vQRSHdq5cejBzU8hTgwWS8n
         HjAEJPATg7t57KOlnOWrfnTpIPs8RFpRIrSNpG2uWyoB3xIlgnulP0fhADLAooKvsQvw
         wnnXPO93wZ9EnLYjnen2oGAJJcX8XCGzTjp28SvR0/lX64xejz0AicHAZuEf22qr0B2v
         F7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWgKYs/KwzvlZODhyuGnpamMgQeOx5rHyk/ix5P894jMMwuirLGVtgjJRoVUDPCzM6HFr3QK1gvSh+NuirEVk/G2OrtQvuZvF+HlTjp
X-Gm-Message-State: AOJu0YyybBFXWZD4BrmTVT+tXb/FIJMmO9VrWQJC/Ab6jkrlaPCYQkhE
	+7IUr7vLw27f0BW5sXXtMyXxgHC33Mn6qkLt0f29ZRcwYp0auRqnUt2XNXorjHIhRx7oPqiBadU
	Qwyoq2vO/F9WzzD3vmsWvHN5S3X8+3ijKX399QOerGPursyTucsx7hUeMJhkqAQ==
X-Received: by 2002:a81:eb01:0:b0:665:7184:fcd0 with SMTP id 00721157ae682-66e4c57cc07mr25524977b3.23.1721726142420;
        Tue, 23 Jul 2024 02:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4IiXmj2FuxzskFkC0utHW7AkKAtNEST/fURo/dZSMHzQSDCbMp7OLSFmaIo2lbAehtKKQ1w==
X-Received: by 2002:a81:eb01:0:b0:665:7184:fcd0 with SMTP id 00721157ae682-66e4c57cc07mr25524867b3.23.1721726142107;
        Tue, 23 Jul 2024 02:15:42 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.147.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9c35cdsm45486866d6.98.2024.07.23.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:15:41 -0700 (PDT)
Date: Tue, 23 Jul 2024 11:15:37 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] sched/deadline: Consolidate Timer Cancellation
Message-ID: <Zp90uZSUPkLmluEo@jlelli-thinkpadt14gen4.remote.csb>
References: <20240722132935.14426-1-wander@redhat.com>
 <20240722132935.14426-4-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722132935.14426-4-wander@redhat.com>

Hi Wander,

Guess this might help yes, only a minor naming suggestion below.

On 22/07/24 10:29, Wander Lairson Costa wrote:
> After commit b58652db66c9 ("sched/deadline: Fix task_struct reference
> leak"), I identified additional calls to hrtimer_try_to_cancel that
> might also require a dl_server check. It remains unclear whether this
> omission was intentional or accidental in those contexts.
> 
> This patch consolidates the timer cancellation logic into dedicated
> functions, ensuring consistent behavior across all calls.
> Additionally, it reduces code duplication and improves overall code
> cleanliness.
> 
> Note the use of the __always_inline keyword. In some instances, we
> have a task_struct pointer, dereference the dl member, and then use
> the container_of macro to retrieve the task_struct pointer again. By
> inlining the code, the compiler can potentially optimize out this
> redundant round trip.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  kernel/sched/deadline.c | 44 ++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 908d5ce79425..8b0bbade2dcb 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -320,6 +320,29 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  		__sub_running_bw(dl_se->dl_bw, dl_rq);
>  }
>  
> +static __always_inline
> +void cancel_timer(struct sched_dl_entity *dl_se, struct hrtimer *timer)
> +{
> +	/*
> +	 * If the timer callback was running (hrtimer_try_to_cancel == -1),
> +	 * it will eventually call put_task_struct().
> +	 */
> +	if (hrtimer_try_to_cancel(timer) == 1 && !dl_server(dl_se))
> +		put_task_struct(dl_task_of(dl_se));
> +}
> +
> +static __always_inline
> +void cancel_dl_timer(struct sched_dl_entity *dl_se)

Maybe we could call the above cancel_replenish_timer

> +{
> +	cancel_timer(dl_se, &dl_se->dl_timer);

and this one cancel_dl_timer?

Best,
Juri


