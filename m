Return-Path: <linux-kernel+bounces-284875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F063995064C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219771C21FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9EB19B59F;
	Tue, 13 Aug 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnPPpfP9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144B19B3C4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555178; cv=none; b=kPiI4xfVpMvf5sdgH4mpt2QakAgEym0tsALT9xNQMvwVYfzJsVVg+UHY6+v2OCf0HVTdf0h5SGspDVvXUb7K0lfTnM2U5AX4EFRaoiHoXIZF5DUq9OOVoOUWPQ/tXLmSghb6/SgCCpeS/v0wiy1JxSS+3Zmgej1DUdsPgTycu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555178; c=relaxed/simple;
	bh=UqxTkUGvtwG+g+4y+gpOh7+zfsZW7IT7gQu8DIUoAp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0k1rf5HokvcmIiW8hAf3G+0eIybMusSU0LN2VROoqXyXol/iBMBij9oJiRN/CIWdgwMMENWvVlVImDAW4bEgCCqPAoY3eWiv7c/RsMUxTJiUlewi328DKgqK136CXaThpmEcjmBT9/bvP+5BGxA0uvi25ruufL3iFW0kkUegag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnPPpfP9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723555175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg7+Ggc3snS1DhVjmDqwGKcDB4EJn3V1wuE3H5dT92A=;
	b=UnPPpfP9A2FUPa4RxwkDvVRjbzkokDyBqfue50t3YbaL8iRryvbvMEdUa0S24r2LloMEwv
	MaGo3Px7+zrkYo1xdbsJBCSFw51HdACNUVld0KixkDai/RnOoXf81ZLkX2+qxewFkEtUYR
	gildcWPPEox5kyjslzKIzujx9ZQAPQQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-K6PyBOgRN6CcaS1QVWvvZw-1; Tue, 13 Aug 2024 09:19:33 -0400
X-MC-Unique: K6PyBOgRN6CcaS1QVWvvZw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3687a1a6846so3098076f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555172; x=1724159972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg7+Ggc3snS1DhVjmDqwGKcDB4EJn3V1wuE3H5dT92A=;
        b=j4lhNyYpqlTv5cTumvBucef62Iw0/9VG9Qrii6znKWPI1lLAxSdSx7Xjtvl/4sJhMH
         2LjQAt5ep1/6htcugppBgfeCX/j2F6esN+GvY/pONwzwRTSieFNsZlkEIzuQI720dpGZ
         +ad038+I+IWK3ogce7Gf5uRxU4Sd8kNZH73gzMyKK5K+BJQKVDVmOOzihin9FzlIB+QX
         f8u7NJY7pARih+xcs9ACbvG8as6t4c2dqTzKBQsDEGCkUXW/oZaftm5w4vIpkW+RWVWA
         5R1wmovwv4qzURrM3wub8EZqXkRDYQpyyU6Mi0C3uKQG/SSTGCxe7IDzCUAn4vQz3r3E
         UlMA==
X-Forwarded-Encrypted: i=1; AJvYcCUDyjIq14Fa51TeNHYAN45s+bLsXoEG0VtZQD+EQSRXkZijq9QVgzHlDEDJ8SrQi5LQvtcBpWbxHecB6iPJEMQtUkI3Jiy4jtJ+LFiX
X-Gm-Message-State: AOJu0YzvHWR08B1bXAyOs5TdJbGR695nygRg7cSzTsEFemtsnPOwjVpJ
	xSSnmd9dG559hzVFYd9x9ecDLclBbDJPMyvzlBQDJC0+u2W54EG0mc6wpYEq12iiNOHtG0cXXa2
	buZzINShlYO9IXgjdNHtGM4j+2+BypqSQj7nPJGdIpjqqkCYNzRyHxCxKt0flEw==
X-Received: by 2002:a5d:6202:0:b0:36b:33ec:ac40 with SMTP id ffacd0b85a97d-3716ccf4511mr2234676f8f.16.1723555172471;
        Tue, 13 Aug 2024 06:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbvjrw6+c7B5jqqiO5v/YBG2lt/jSLU5V6GqBRYBZPORVTMNlwkmbnwha4bsrKICbkvO5wkg==
X-Received: by 2002:a5d:6202:0:b0:36b:33ec:ac40 with SMTP id ffacd0b85a97d-3716ccf4511mr2234651f8f.16.1723555171933;
        Tue, 13 Aug 2024 06:19:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ef58sm139499255e9.16.2024.08.13.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:19:31 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:19:29 +0100
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
Message-ID: <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
 <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25da50cb-776f-42db-9821-e86a441259c0@arm.com>

On 13/08/24 11:17, Christian Loehle wrote:
> On 8/13/24 08:54, Vincent Guittot wrote:
> > On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
> >>
> >> On 09/08/24 02:24, Qais Yousef wrote:
> >>> Adding more sched folks to CC
> >>>
> >>> On 08/06/24 14:41, Christian Loehle wrote:
> >>>> Convert the sugov deadline task attributes to use the available
> >>>> definitions to make them more readable.
> >>>> No functional change.
> >>>>
> >>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>> ---
> >>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>> index eece6244f9d2..012b38a04894 100644
> >>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >>>>              * Fake (unused) bandwidth; workaround to "fix"
> >>>>              * priority inheritance.
> >>>>              */
> >>>> -           .sched_runtime  =  1000000,
> >>>> -           .sched_deadline = 10000000,
> >>>> -           .sched_period   = 10000000,
> >>>> +           .sched_runtime  = USEC_PER_SEC,
> >>>> +           .sched_deadline = 10 * USEC_PER_SEC,
> >>>> +           .sched_period   = 10 * USEC_PER_SEC,
> >>>
> >>> I think NSEC_PER_MSEC is the correct one. The units in
> >>> include/uapi/linux/sched/types.h is not specified. Had to look at
> >>> sched-deadline.rst to figure it out.
> 
> Huh, that's what I used, see below.
> 
> >>
> >> In practice it's the same number :). But, you are correct, we want
> >> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
> > 
> > Yes NSEC_PER_MSEC is the correct unit
> 
> Thank you Qais, Juri and Vincent, but if I'm not missing something we
> have a contradiction.
> This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
> - Documentation/scheduler/sched-deadline.rst talks about microseconds:
> SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
>  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
>  "runtime" microseconds of execution time every "period" microseconds, and
>  these "runtime" microseconds are available within "deadline" microseconds
>  from the beginning of the period.
> 
> - sched_setattr / sched_getattr manpages talks about nanoseconds:
>        sched_deadline
>               This field specifies the "Deadline" parameter for deadline
>               scheduling.  The value is expressed in nanoseconds.
> 
> - include/uapi/linux/sched/types.h doesn't mention any unit.
> I will add that to the v2 series.
> 
> - kernel/sched/deadline.c works with nanoseconds internally (although
> with the precision limitation in microseconds).
> 
> No conversion so
> attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
> So Documentation/scheduler/sched-deadline.rst is false or what is it that
> I'm missing?
> 

As you say above, internal resolution is essentially down to 1us
(microsecond) and we also check that parameters are at least 1us or
bigger [1].

syscalls and internal mechanics work with nanoseconds, but I don't think
this is a contradiction.

1 - https://elixir.bootlin.com/linux/v6.10.4/source/kernel/sched/deadline.c#L3065


