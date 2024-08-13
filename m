Return-Path: <linux-kernel+bounces-284927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBAE9506FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D2B22D35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D019D068;
	Tue, 13 Aug 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKjNp6Rl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9553187341
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557435; cv=none; b=Cz977RTbS53ENlHO5NuUlKL5cBwjP0eMXxLWuutO4JkF2hHnp8l2l8nbNtc+0N4TAQCtAO8zvzw5GLNdTzCOc56FnjqgU+NM2/SI/08k8xwmUKFti/nqzOQDuO0oxibIxExSBwYZd2ORVUjwpaqKasdSX9U9JrkEt5klgxm0Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557435; c=relaxed/simple;
	bh=RcMqqTEfTSLr+++tDYyI0Q1bjZz9OT1eaU6LMXSMTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKefKzfGgbbdBkF+2qf0sHQ9CwflhFsAKdb9g4metaXFZkP+29/KNGhcOE81YHoO/+cVGYgvuUSGFMf/GtpXQCQJ1+Ya2GISO2+WNB/F7blSz0hCA9HIoGzV3ws1iGvdeSU5CxbUNJFQ7cj1iTna8mQ/MnzvfGDd7kusj4kim8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKjNp6Rl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723557432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vabtoVHWKvV/1SG/be91JzWWAjd+sf4Dx+EYtZWiLoc=;
	b=GKjNp6RlpTgC/qEXXz41qLgvvA6voEFeJ4D73P8EMPWsoDPL9hG8Nj23MhxbpIb5VWqs2F
	EBnEZ8Os25eCKTcvtbqbGZgjCF07TWqegzW4TZCb3IiZZWLT0udaQckEg71RDtrGLZihG7
	UsvuNkNDoWWsT1TzcOGF+746pCDHKrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-NAdPScy-P_OMh5LrX2mOfA-1; Tue, 13 Aug 2024 09:57:09 -0400
X-MC-Unique: NAdPScy-P_OMh5LrX2mOfA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso42697825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557428; x=1724162228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vabtoVHWKvV/1SG/be91JzWWAjd+sf4Dx+EYtZWiLoc=;
        b=Oh7DSSg8M5ajBjmYhI+isUDWAyjKH1P+BWBBxGtVy3kZi1sHlrURfnbH2InYMSYFVv
         OEOmnBEkC5c8qgaVRgYfqQPuxGKnLKUew8HeQAlObTyNAUjx1ILWCjXBQB679CBTwdjM
         WwX57JqCLC7thx+SMNIVqd6LJGlh7MRSgAnL2i/jkKFNnWXC30Tji7ixm92dM/t/mlHf
         RL+TCeqK9ORWoD1iwsATnQ4uMGCsPVGOKZLPWX5m+ypJGj6UXDV5FHyLQD4yu0XMgTll
         pnnLwNWGaNBjzzlAp+uwxJPlPaNaW7XowAvRsvuD7yMynow5ExgewLuYFwkWV4KT1+ZS
         RRtg==
X-Forwarded-Encrypted: i=1; AJvYcCXnKSFrJkngp91F/XmAI3E9vUEkcxN1s4Q9bWNzg8Y82DivmpOyW5XEUb64K8DUALuuAt4lLKF1oLZvBPRE/pAb/wFuZZfDrRo5hEGK
X-Gm-Message-State: AOJu0Yz9ZimG63AcPuUXDt1QlGxKO5wT+uH34jMyaKz1Gr0SI657Wq2D
	UwVOKPa3jZt6X+XkJlDVnHK2tjC+anAuhGrdqRaBVhOcqYRSvqqtitCnChGXY6uJ5xWCor6mR/1
	zpzg+915GcfcbS/SqEAvF43gT+APK1VGgOokSzdnwGCAcSJMcnrUTnVmWhPKwNQ==
X-Received: by 2002:a05:600c:4ed2:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-429d481e867mr26475065e9.21.1723557428438;
        Tue, 13 Aug 2024 06:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGE61Ix61B1P0ouSqVuqS620H57DJ6X6CEjFHpczsLuKHS/td3xxFMWW04FQ2c39NHm585rw==
X-Received: by 2002:a05:600c:4ed2:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-429d481e867mr26474815e9.21.1723557427872;
        Tue, 13 Aug 2024 06:57:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a38a6sm228324985e9.42.2024.08.13.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:57:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:57:05 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
Message-ID: <ZrtmMcU1405Niiks@jlelli-thinkpadt14gen4.remote.csb>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
 <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
 <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
 <459ae1ee-d114-4fdc-b728-33bde5d08e24@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459ae1ee-d114-4fdc-b728-33bde5d08e24@arm.com>

On 13/08/24 14:34, Christian Loehle wrote:
> On 8/13/24 14:19, Juri Lelli wrote:
> > On 13/08/24 11:17, Christian Loehle wrote:
> >> On 8/13/24 08:54, Vincent Guittot wrote:
> >>> On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
> >>>>
> >>>> On 09/08/24 02:24, Qais Yousef wrote:
> >>>>> Adding more sched folks to CC
> >>>>>
> >>>>> On 08/06/24 14:41, Christian Loehle wrote:
> >>>>>> Convert the sugov deadline task attributes to use the available
> >>>>>> definitions to make them more readable.
> >>>>>> No functional change.
> >>>>>>
> >>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>>>> ---
> >>>>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
> >>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>>>> index eece6244f9d2..012b38a04894 100644
> >>>>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >>>>>>              * Fake (unused) bandwidth; workaround to "fix"
> >>>>>>              * priority inheritance.
> >>>>>>              */
> >>>>>> -           .sched_runtime  =  1000000,
> >>>>>> -           .sched_deadline = 10000000,
> >>>>>> -           .sched_period   = 10000000,
> >>>>>> +           .sched_runtime  = USEC_PER_SEC,
> >>>>>> +           .sched_deadline = 10 * USEC_PER_SEC,
> >>>>>> +           .sched_period   = 10 * USEC_PER_SEC,
> >>>>>
> >>>>> I think NSEC_PER_MSEC is the correct one. The units in
> >>>>> include/uapi/linux/sched/types.h is not specified. Had to look at
> >>>>> sched-deadline.rst to figure it out.
> >>
> >> Huh, that's what I used, see below.
> >>
> >>>>
> >>>> In practice it's the same number :). But, you are correct, we want
> >>>> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
> >>>
> >>> Yes NSEC_PER_MSEC is the correct unit
> >>
> >> Thank you Qais, Juri and Vincent, but if I'm not missing something we
> >> have a contradiction.
> >> This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
> >> - Documentation/scheduler/sched-deadline.rst talks about microseconds:
> >> SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
> >>  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
> >>  "runtime" microseconds of execution time every "period" microseconds, and
> >>  these "runtime" microseconds are available within "deadline" microseconds
> >>  from the beginning of the period.
> >>
> >> - sched_setattr / sched_getattr manpages talks about nanoseconds:
> >>        sched_deadline
> >>               This field specifies the "Deadline" parameter for deadline
> >>               scheduling.  The value is expressed in nanoseconds.
> >>
> >> - include/uapi/linux/sched/types.h doesn't mention any unit.
> >> I will add that to the v2 series.
> >>
> >> - kernel/sched/deadline.c works with nanoseconds internally (although
> >> with the precision limitation in microseconds).
> >>
> >> No conversion so
> >> attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
> >> So Documentation/scheduler/sched-deadline.rst is false or what is it that
> >> I'm missing?
> >>
> > 
> > As you say above, internal resolution is essentially down to 1us
> > (microsecond) and we also check that parameters are at least 1us or
> > bigger [1].
> > 
> > syscalls and internal mechanics work with nanoseconds, but I don't think
> > this is a contradiction.
> > 
> > 1 - https://elixir.bootlin.com/linux/v6.10.4/source/kernel/sched/deadline.c#L3065
> > 
> 
> All good then you reckon?
> Still the part about schedtool is wrong:
> 
> -->8--
> 
> diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
> index 9fe4846079bb..f7475d101e7a 100644
> --- a/Documentation/scheduler/sched-deadline.rst
> +++ b/Documentation/scheduler/sched-deadline.rst
> @@ -759,7 +759,7 @@ Appendix A. Test suite
>    # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
>  
>   With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
> - of 10ms every 100ms (note that parameters are expressed in microseconds).
> + of 10ms every 100ms (note that parameters are expressed in nanoseconds).
>   You can also use schedtool to create a reservation for an already running
>   application, given that you know its pid::

Right. Well, while we are at it, I actually wonder if we want to just rewrite
the example using chrt (which now supports DEADLINE). :)


