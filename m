Return-Path: <linux-kernel+bounces-561125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2FA60DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BD117AC60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A41F4265;
	Fri, 14 Mar 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="POwhI5re"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259731F1537
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945778; cv=none; b=VIygGMkejzD8UD6wVnBCca35GAzmy/9zsNuFNynCgFlFAaAHMQDiHfXwWhMn4KhYwN+7vEKfZHtRFeiEUzfd2fPzMd4EYjQn4lvPDanxHabFNlTncdsId5XBYtlBT8d8AQVPi0oQmb90BryFAOW5MmhKS+GKXXG4NQGvUnHI6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945778; c=relaxed/simple;
	bh=T47qoCHSNB9fC7nBLhSYaTfUYyKyRXfMFXXb6z8nqyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orYZtOV1AYjSON6mvDxaCyWN4qclNs9EIK9H4s6E3IXT+7EKvpg7vo1dKsWlLSZ/gRtbCZO6mEfAtRnReDVYkSGQ+wO8kSk+z05c204fxnzYURzXi8RugFfNn6IgbHFrhsU6mGtZaBrOBs6xF0WtdvRuleOauLzPFib0iAogkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=POwhI5re; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so33940475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741945773; x=1742550573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/kbh4NaUZavoTXiLgXQym0SQ459DGnz3jYAyrYCq3A=;
        b=POwhI5rev5QEEnpDhLjNNZZEcm/zMtWHMxk8emVy2jCyY6biqj+GGFZMguuv3T9mZl
         4tj4SGrrmO1rN25f5R/ELilnJVBtNIosZmKLJiIRjpr8mJcrs7jNfP0F/rKbeOjJkI9X
         OmccGwZJli3FceKTmdVa7ArqcWxN31IcS9Dqvz2QRhaWJOSv0cwAPy7bC4yC9hASpqNo
         FpkuC6q0/Wev5jM5jKBijmryt1fq1AEtudncEwK/9bwSxXsbqh96UMJ317Uad9Glswqp
         h+C0uxpLI1psqw5pIYE1gpmv1PKYutfTkJyftpc1iRScyZ7dxyLFXmNq8wFzjRxA54JB
         WWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945773; x=1742550573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/kbh4NaUZavoTXiLgXQym0SQ459DGnz3jYAyrYCq3A=;
        b=ELMFEr0LdVl+wxDTOf+gPMyDm5M1Jdv/g7SYpwFWyv1rc++YsBmQq3OAuIQ8buIGUZ
         +YMoS0mvAmMsXGybbPktmIm1EUy0UagZRpwMMuWFctLduoJrpncFJhFUj8Zv/XRLP+6s
         rx4K+rDEw5kgB3Lul87+LAg+4fDJFuF8ma2HaloMjZquSlra1p3OMAhHLNfoHiuNCGu2
         DY54o31n/twwsZ+nplY03Qm4WOHIeQ1ZscUNw1grFh+GwfiomKnPRJKMw8Zt8HJwrhK/
         7v32Q25vE48CDvux6uubV/7QbUKjzNWeFr5A+vTpv5pHMaFx8ECikDjBgaP1sql07N3f
         NOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeM0MOca7WXFADcWD4VRubGw5VR/OvBm8Ca+Q4DEuQxtchyYCfpylIbOSMo0A9MLpLELjul5Q+YxHRC7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4CRx6SnoHUxOcrT2/4XMuiDaUZFisD3armhCtSuVHl16MQA6
	se92b8lswu2mMOKa6uNObjDSGVm0HcdPE5dBGmCasiqo8wfoZR10EZp5C50org==
X-Gm-Gg: ASbGncuVC0LveZgTCDOxdTurWQn1rGtvbSbSyJ1Mt/B34O6n/mH1L/iqo5S7gfN+HcE
	pV/igBFJWfom4zZNYxmuMbx+zPdcP0BZ/DKzMO5ejHUjEydjNlwRKowvgziPsLb/l3gMw0JFTWq
	fUv0XEXJiRpUjnTYv4ZQSJDfqNwUTgf+rNmVf+p6LfIDvFP41Bsoeqeh0XKiXH+hvWE1UYzKYHB
	J/IVC55vYCc68/MarLmz0ezYDrqssN/MQr9H1LOCM0WeENhxG6zgO0L1PpfTrHjXctMUjOGxkpm
	fjrgb4sSfKucxBPrhhsihTZIdj33w3dBKTkJu721Fxz4
X-Google-Smtp-Source: AGHT+IG9IYTvh3eEHhgVjVHeV2klPY2cfKHC7Kpl6XjMjfqGQAdr+ePpDoDdDYYkfV4B6TJHCpFHfg==
X-Received: by 2002:a17:903:2f06:b0:224:1c1:4aba with SMTP id d9443c01a7336-225e0b274e8mr23014875ad.50.1741945773349;
        Fri, 14 Mar 2025 02:49:33 -0700 (PDT)
Received: from bytedance ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883e6sm25805755ad.8.2025.03.14.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:49:33 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:49:25 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH 4/7] sched/fair: Take care of migrated
 task for task based throttle
Message-ID: <20250314094925.GD1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gc2vAMO_5x8wYhA-=34n0vChrSdUvnd+Cf56MXfq2YFfQ@mail.gmail.com>
 <f091f0e8-ead5-4fed-afbf-45be29db8e2e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f091f0e8-ead5-4fed-afbf-45be29db8e2e@amd.com>

On Fri, Mar 14, 2025 at 09:33:10AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:51 PM, Aaron Lu wrote:
> > If a task is migrated to a new cpu, it is possible this task is not
> > throttled but the new cfs_rq is throttled or vice vesa. Take care of
> > these situations in enqueue path.
> > 
> > Note that we can't handle this in migrate_task_rq_fair() because there,
> > the dst cpu's rq lock is not held and things like checking if the new
> > cfs_rq needs throttle can be racy.
> > 
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> >   kernel/sched/fair.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4a95fe3785e43..9e036f18d73e6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7051,6 +7051,23 @@ enqueue_task_fair(struct rq *rq, struct
> > task_struct *p, int flags)
> >   	assert_list_leaf_cfs_rq(rq);
> > 
> >   	hrtick_update(rq);
> > +
> > +	if (!cfs_bandwidth_used())
> > +		return;
> > +
> > +	/*
> > +	 * This is for migrate_task_rq_fair(): the new_cpu's rq lock is not held
> > +	 * in migrate_task_rq_fair() so we have to do these things in enqueue
> > +	 * time when the dst cpu's rq lock is held. Doing this check in enqueue
> > +	 * time also takes care of newly woken up tasks, e.g. a task wakes up
> > +	 * into a throttled cfs_rq.
> > +	 *
> > +	 * It's possible the task has a throttle work added but this new cfs_rq
> > +	 * is not in throttled hierarchy but that's OK, throttle_cfs_rq_work()
> > +	 * will take care of it.
> > +	 */
> > +	if (throttled_hierarchy(cfs_rq_of(&p->se)))
> > +		task_throttle_setup_work(p);
> 
> Any reason we can't move this to somewhere towards the top?
> throttled_hierarchy() check should be cheap enough and we probably don't
> need the cfs_bandwidth_used() guarding check unless there are other
> concerns that I may have missed.

I didn't realize the delayed dequeue case so I placed this at bottom,
but as you have mentioned, for delayed dequeue tasks that gets
re-queued, this has to be on top.

Will change it to top in next version.
Thanks!

