Return-Path: <linux-kernel+bounces-282910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D294EA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8691F228C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3916E883;
	Mon, 12 Aug 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsZIclMu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DC16E88B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456967; cv=none; b=pqik9C7HfGvPAgkbhu3ISnEs1aV+LDLc0w+zWN/qtB4MP8ND5ncX4ZCXm+xCsqzgp7fxpvEeGpAYbshTmkvHq+fYl0X1PsgFMZ6g+GJXWb25NfzWrhMjZWOYGOc5BdOal+/fwem5YWWrebdtPGP33SD7DDJAMm8k6hJulWMn2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456967; c=relaxed/simple;
	bh=VLPReqJgbkUSfci2aNPirl+NRfOjGhbDcgQ5lsX3Ll4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YioygwCgh4Wgoi3suXS20KbARWGbIZQL+erGP/2MZGqGdngjnLCGCuChO74mAQjWxs1AW3LDHYDmPZUATlZT0ROJwNI5Kxk8A7XzWMYghgb1UNsI4yENPzzr1YJEDYctZcLTxJX7TuFjgXh1p+BkTB70PhSJBBRbO27wrd1QJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsZIclMu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723456965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QGPf24CgLB+VFvLEqjtRAK7BayDhIyPh3chqbIt/Rk=;
	b=SsZIclMuqHkluULDf3ei3yFdVG2hwWIxdRkyLYBT/omI8YZkqAHloYsYjxIKwqB4IhPTs8
	ojfH1/fFp9xb5cZeZaW91/mJngmnu2cv5hliBU4U4o0Ks6ibVY7q8sTI/ivEQgc6f6IacQ
	FQvz/I2WH65PMHqgLbqVu/2l4pWVGkA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-aGKl0yk8MI-zlpb4kkdRRA-1; Mon, 12 Aug 2024 06:02:44 -0400
X-MC-Unique: aGKl0yk8MI-zlpb4kkdRRA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d737f940so923233585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723456963; x=1724061763;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QGPf24CgLB+VFvLEqjtRAK7BayDhIyPh3chqbIt/Rk=;
        b=vYxt3Asg8RKdFaNzRtKNMvB2hTPO56ujckqvV3FIcGj3JbUgmCIQa+1PQYsH8DlxY+
         WIcwXZ8XEH0QGXrQcCWhQAASacv6H+bgnYJiuervLya/GwU/tWlT4i5ckU8X7qIRL445
         R56Yf+Wc/Xy2G+VwTLoqPQangsN3RoICSgzYLI9/YHxBe/NriVSvYAJjdn49KwF1XBrh
         b02f45dJQ8hZkx34iLEfFb/nOXWzKz3+hV9eggjCrSOgxCEiEO7LSs1W937eoxXAAXbx
         UPMUxk0nzJTXTZ4NHrJp0n5IrZiUQ/bx3SDJuZ2BXCNJTUFxxMQIrZn2VZhlxJbTa7WV
         /9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXuRjB0CkOVYYUHbQtUMjCgvQfJmM+cwAWxdJ+Ta0JmAk/BJJn0P3v0iyyEA8PxfjqK0CXkDYq2SFe7rDKFC511Y9jrqkZiT2hw7gut
X-Gm-Message-State: AOJu0YwQa99C5OLokXTto6ECrFN1iVoQcU6cBAzUoDz3AxrrRZFeESIq
	f1CwqR29G5vrb/o+xEFQi/hcf63Q1hYSM6MxB40fbg52tqlAY7P7yStYpyYnncJhmnthczrbnkx
	JTs07q583dTREMorucddLWoJ90rHAH9l+JcNM/G3BbXZVZMV+LRf3k1Rk6YM41A==
X-Received: by 2002:a05:620a:400b:b0:7a1:da64:5683 with SMTP id af79cd13be357-7a38249900amr2214462385a.20.1723456963558;
        Mon, 12 Aug 2024 03:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHki7rrsE28cq2OWs4AReAQ1k6/3eDhPSXnvorYSede6fW2CoEb2+sG+95xdjUrCsNgtbmXZw==
X-Received: by 2002:a05:620a:400b:b0:7a1:da64:5683 with SMTP id af79cd13be357-7a38249900amr2214458985a.20.1723456963195;
        Mon, 12 Aug 2024 03:02:43 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d62678sm225467585a.5.2024.08.12.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:02:42 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
Subject: Re: [PATCH 07/24] sched/fair: Re-organize dequeue_task_fair()
In-Reply-To: <20240810221723.GJ11646@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105028.977256873@infradead.org>
 <xhsmhh6bty6wl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240810221723.GJ11646@noisy.programming.kicks-ass.net>
Date: Mon, 12 Aug 2024 12:02:39 +0200
Message-ID: <xhsmhed6uxdmo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/08/24 00:17, Peter Zijlstra wrote:
> On Fri, Aug 09, 2024 at 06:53:30PM +0200, Valentin Schneider wrote:
>> On 27/07/24 12:27, Peter Zijlstra wrote:
>> > -static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>> > +static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>> >  {
>> > -	struct cfs_rq *cfs_rq;
>> > -	struct sched_entity *se = &p->se;
>> > -	int task_sleep = flags & DEQUEUE_SLEEP;
>> > -	int idle_h_nr_running = task_has_idle_policy(p);
>> >       bool was_sched_idle = sched_idle_rq(rq);
>> >       int rq_h_nr_running = rq->cfs.h_nr_running;
>> > +	bool task_sleep = flags & DEQUEUE_SLEEP;
>> > +	struct task_struct *p = NULL;
>> > +	int idle_h_nr_running = 0;
>> > +	int h_nr_running = 0;
>> > +	struct cfs_rq *cfs_rq;
>> >
>> > -	util_est_dequeue(&rq->cfs, p);
>> > +	if (entity_is_task(se)) {
>> > +		p = task_of(se);
>> > +		h_nr_running = 1;
>> > +		idle_h_nr_running = task_has_idle_policy(p);
>> > +	}
>> >
>>
>> This leaves the *h_nr_running to 0 for non-task entities. IIUC this makes
>> sense for ->sched_delayed entities (they should be empty of tasks), not so
>> sure for the other case. However, this only ends up being used for non-task
>> entities in:
>> - pick_next_entity(), if se->sched_delayed
>> - unregister_fair_sched_group()
>>
>> IIRC unregister_fair_sched_group() can only happen after the group has been
>> drained, so it would then indeed be empty of tasks, but I reckon this could
>> do with a comment/assert in dequeue_entities(), no? Or did I get too
>> confused by cgroups again?
>>
>
> Yeah, so I did have me a patch that made all this work for cfs bandwidth
> control as well. And then we need all this for throttled cgroup entries
> as well.
>
> Anyway... I had the patch, it worked, but then I remembered you were
> going to rewrite all that anyway and I was making a terrible mess of
> things, so I made it go away again.

Heh, sounds like someone needs to get back to it then :-)


