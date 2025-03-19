Return-Path: <linux-kernel+bounces-568299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A1A69373
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69874880444
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9641C82F4;
	Wed, 19 Mar 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFfhgsGt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE71C1F02
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398028; cv=none; b=krt6IcgAJ4vrBrz9RD1JTCwTka0yE2AqaOtL1KT31d1eshuu0WoDEaOoyDNcnNC7k/fyYYhHCAzc7xNNaDaJjbdtckh7qXBYxiyQhXVDiMTER3BB3cn0/mJavTpn9U3LgyHb7jJMMFSpzfzBrsBEYtYZQFj7qVjDGsMTXyshmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398028; c=relaxed/simple;
	bh=ct7aopUzsN3QxU9w0Lbs5JG/nSf5raBmrCZ7HXdeMFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sFOyVqPQ5xWkg/qCa7t5lQ/3BTI03AbjgtjSBypwjyTl16S0s0A6TnwCGP6roL40VSURW+pF3zDVwHtVna6c8sWbJN+lbTnh37Ci9rbPRWqbsaQ/6tIw3jtV0rcoT1virDNDKrfK2e5omS2fOWz7XBvsHabM2/ndh/Bt4XBiUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFfhgsGt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742398024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFmtReSkCsUxD4daXrXxVeAmSy8TwLmqMGMSutGOM1k=;
	b=JFfhgsGt4CuJeHNEyxNnQsULW2V581WG/RRXQT4zm3kVs4ZUCu5XcHA5c6A+/+V7/eUVid
	bWgFusQddXcgl20Yrv+mmsaaKIi1NJm0M1Ew8Pas7CqnofAG6fQ+KFhRZ3Ju2NkgdA3td2
	WzbsjDyt7M5/lhqIGNwGkp4SxGENSME=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-l7nd0tJJMzibjvPFcqEz6g-1; Wed, 19 Mar 2025 11:27:02 -0400
X-MC-Unique: l7nd0tJJMzibjvPFcqEz6g-1
X-Mimecast-MFC-AGG-ID: l7nd0tJJMzibjvPFcqEz6g_1742398021
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2815aba51so530054566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398021; x=1743002821;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFmtReSkCsUxD4daXrXxVeAmSy8TwLmqMGMSutGOM1k=;
        b=vlDtED30+tf49U0Jz6d9blMrFOFYslCqPcYvlwLKj8nBvLKcyAVqNRIGmweIUZJYs8
         Sm0kpOzPkr9uyBIPmoHyiM9O3Vd+0im83Q4G8S1a9eABCrYG5yFehcmwRp2KUUvjNK++
         NNgKliIv5soJZYajo/0INgJeN6qwN/L8Roe8MaGG3SJmfEmBk4jUxXWfNtfD4QguI1go
         cWCGs6exXdCNc2aOtl2sJdKZN5XpeGo6JZXh+a12P8i6JpsHNIcpxllDjUZN1dBpCXrY
         1p+i+P1BxM3QNEd9tGVkPuTa9YZkcH1GS+/vWhjIt6Eq+HjKuZ2MiHfcQx6RFCoFRaT9
         Lh1A==
X-Forwarded-Encrypted: i=1; AJvYcCXrG7nFeYIQPda3m2Fw0WVDJFuf+RXN/GUu28owr+aLeUxIBI00+lNoivUJT7LDA1+RJJx9ObAWnnCSIJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywLAOsCVT2HcJ51FDKDMXFqnTFKKrl5HsQ19uHSXdIOcDGX/0
	2GD6Mbfx5NjKu1hsoIl/VB/KHu/n9keOEaZdoW+hZoFYhOiJ/2SkZmYgmuvqhFlzBLLEXXbVYNQ
	RklaXHyvOO25SPsSMct53n+jhjb8jb4tMcxtrpDQSKQYPUn5azLXUJwfzK06e5w==
X-Gm-Gg: ASbGnctGc5cWQfe3IFTUwkolac6iNKZ2FywQQeoe4v3GpXb8gzFVkPWLHDKrRTeVatk
	gwaZAj2DoEKOjsMMBdvcVmBjUpLznFWDXGG78ekya1piB2sk9kVVbBX7QOwLQZT26SqOtiMFa1T
	ePBAZ+caJQXTF4TcgaCQ/q5YlTnsejFinmPJ0kezpNQGOLRwa6JJugJMxbYEJB0et3J5J05j0bS
	9gERDKNI86jkRrW8U4te+ROiaFXsXhzdTf24WTB0/n+qFQEqn6EWwAvj/F8pGv1H0J5WmIRLoev
	DORrWv9V7ebynPg05oSJcU4tUbpTrjRA4Z2WoVpBgk9/mGc=
X-Received: by 2002:a17:907:7212:b0:ac2:d600:7b96 with SMTP id a640c23a62f3a-ac3b7f1cc48mr291868266b.44.1742398021053;
        Wed, 19 Mar 2025 08:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW6J4H9UNcHH0IRlkhfYPf/SDnP+brXtiSAcE/OywQrTcxY5xJV/JidYpPyfVl2U5iLXtqvw==
X-Received: by 2002:a17:907:7212:b0:ac2:d600:7b96 with SMTP id a640c23a62f3a-ac3b7f1cc48mr291860866b.44.1742398020561;
        Wed, 19 Mar 2025 08:27:00 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([81.27.113.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0df9sm1044248566b.99.2025.03.19.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:26:59 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 lukasz.luba@arm.com, rafael.j.wysocki@intel.com, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
 luis.machado@arm.com, qperret@google.com, Vincent Guittot
 <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
In-Reply-To: <20250302210539.1563190-6-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-6-vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 16:26:56 +0100
Message-ID: <xhsmh1putoxbz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/03/25 22:05, Vincent Guittot wrote:
> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->cfs.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +
> +	/*
> +	 * Remove task from the pushable list as we try only once after that
> +	 * the task has been put back in enqueued list.
> +	 */
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +
> +	return p;

I've only had a look at this patch per the OSPM newidle balance discussion;
coupled with something like RT/DL's overload cpumask, this could be a
viable newidle_balance() replacement.

Unfortunately this means we now have a third copy of the push mechanism
along with RT and DL, so a third place to manually patch whenever a bug is
fixed in one of them [1].

We could perhaps have a skeleton of the pushable list handling in
{enqueue,dequeue)_task() and put_prev_task(), with class-specific conditions and
backing storage, (plist vs rbtree) handled via class callbacks.

Or even make the whole pushable enqueue/dequeue its own class callback,
which would simplify [2].

[1]: http://lore.kernel.org/r/20250304103001.0f89e953@gandalf.local.home
[2]: https://lore.kernel.org/lkml/20250312221147.1865364-7-jstultz@google.com/


