Return-Path: <linux-kernel+bounces-355755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA1995692
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB19B21E04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C48212D14;
	Tue,  8 Oct 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrPJtbpV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106D20CCF1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412239; cv=none; b=TCnn2m8wixqrg2wUjf4hzeM5A0L+3IyX/dx9zujQcQOP1QxspKysoNfNk2JjH9pi1MIlngZQMzLzqPq8kQs5Q2XGBHdiAld6lmejF8rRLS5s8NCbz0hHaA9/omTJAffp3H8qOKWbWuywyZTO//tjJgmiiaK0X1CGQK+uMwz1hd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412239; c=relaxed/simple;
	bh=8xVOOFmtX2KBE6+tSZWykv1ITqfiNjiSwFJedUJnfE4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rXiGjmGixt50uEn9HqkWLdxlCUqAdXg/L8eLmtBl/r2zOdno3GPb76XeNOrzBcPijBHDkI/pZpCgSeHqYOdHeUWvHPrpvw2goWmIrw3Jmhm86XbKmprluVfGbD+7hU/LLOH480GbTucbLbPyDse0hQY37NxNhNE63Je9AkQHYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrPJtbpV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728412236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCRUHecqN6EI9CDv0C/hIdbNPmg6aMFGTBf8PbU5EdE=;
	b=UrPJtbpVRiwvMgGRIMiitoK2K5rHcvHp2qy5kH8LTKwkM3reLMp4ccvQz+bk/rYbpGzrKw
	okl4/B6aXganlPN3a/FWeue/KW06aKwAoar8+Pn4IxQCk50BsaSofGIKRAxuZptUas1Eq5
	7dq5RHqVBCmW6/r5srHVfEYsVG5t9wk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-TdQ0uVkNOaC4sTTrTc0oMQ-1; Tue, 08 Oct 2024 14:30:35 -0400
X-MC-Unique: TdQ0uVkNOaC4sTTrTc0oMQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so850002339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412234; x=1729017034;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCRUHecqN6EI9CDv0C/hIdbNPmg6aMFGTBf8PbU5EdE=;
        b=cAwpoztEQF81i2jDS3gFH5B7fRMyDybzfEYwJ+3gGWvxriAuM7iNSZ4dY9/F6UTs7F
         b3+dKdaMdOogpJ1b3tfDhhG0/bpHNdicRSLXjujEcee4KqfdFugupXOfJivpxPP48jhY
         jIUNOOwod5ZIl57JPltp/BB7d1X6zGCmf0ZLxi8j7S+jy1TiK1dCTp3pd+wGYN0Zc/dH
         0UAqCYG2GOmxHSbAeOFpXF4CWM/wERxLca8qgwppuRU4ajiEEdzuU3TZ/LNw2+KVDXDt
         dSwCFEM6n3Lt4Kd2C+nYhYnwuAGC/AUIe5eXUDcuhHuGMgWc980mbtegD4spr3QL7zm+
         sK5A==
X-Forwarded-Encrypted: i=1; AJvYcCV3XtcPHswhNZbfT9dLl5Z7J1ahcx4TYnQApDdZU+N2+d/iGs4BLsSLgvp0ZH3Rv2uvXAgJ0vaW/EQMTjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/EfD7/KxWpL3Hc39iAtzFUy8IyMmeFlJbnr0Fueu83Gll3Ah
	LrcGTsd2OOf39g2LGylUAMQPCbFlKGeqt7Y1yT7v4DT/WU3dL4dOysSIJs6svASOl/bdD4kyny6
	jhwIfdJoeA22KZzB8o6SHgjh96t6TRIWy+Xui9s5Iq1tsCJ3qvo8Sva8xOCUpV1q0i/jy67fI
X-Received: by 2002:a05:6602:3fd5:b0:82d:1cf:5e0c with SMTP id ca18e2360f4ac-834f7c76aa6mr1602013939f.4.1728412234617;
        Tue, 08 Oct 2024 11:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7vIzLdA5SSJ+PQ7j/AcyK8r+TeJ+6FFgGNNDO6VKrzzs+95vneGag5aA9xoBUIfmHI5Uj+A==
X-Received: by 2002:a05:6602:3fd5:b0:82d:1cf:5e0c with SMTP id ca18e2360f4ac-834f7c76aa6mr1602010939f.4.1728412234215;
        Tue, 08 Oct 2024 11:30:34 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb358b0sm1747211173.29.2024.10.08.11.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:30:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b77b8a52-7b53-46c5-bece-621345fdd4ba@redhat.com>
Date: Tue, 8 Oct 2024 14:30:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
To: Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 11:22 AM, Juri Lelli wrote:
> Hello,
>
> A report concerning latency sensitive applications using futexes on a
> PREEMPT_RT kernel brought me to (try to!) refresh my understanding of
> how futexes are implemented. The following is an attempt to make sense
> of what I am seeing from traces, validate that it indeed might make
> sense and possibly collect ideas on how to address the issue at hand.
>
> Simplifying what is actually a quite complicated setup composed of
> non-realtime (i.e., background load mostly related to a containers
> orchestrator) and realtime tasks, we can consider the following
> situation:
>
>   - Multiprocessor system running a PREEMPT_RT kernel
>   - Housekeeping CPUs (usually 2) running background tasks + “isolated”
>     CPUs running latency sensitive tasks (possibly need to run also
>     non-realtime activities at times)
>   - CPUs are isolated dynamically by using nohz_full/rcu_nocbs options
>     and affinity, no static scheduler isolation is used (i.e., no
>     isolcpus=domain)
>   - Threaded IRQs, RCU related kthreads, timers, etc. are configured with
>     the highest priorities on the system (FIFO)
>   - Latency sensitive application threads run at FIFO priority below the
>     set of tasks from the former point
>   - Latency sensitive application uses futexes, but they protect data
>     only shared among tasks running on the isolated set of CPUs
>   - Tasks running on housekeeping CPUs also use futexes
>   - Futexes belonging to the above two sets of non interacting tasks are
>     distinct
>
> Under these conditions the actual issue presents itself when:
>
>   - A background task on a housekeeping CPUs enters sys_futex syscall and
>     locks a hb->lock (PI enabled mutex on RT)
>   - That background task gets preempted by a higher priority task (e.g.
>     NIC irq thread)
>   - A low latency application task on an isolated CPU also enters
>     sys_futex, hash collision towards the background task hb, tries to
>     grab hb->lock and, even if it boosts the background task, it still
>     needs to wait for the higher priority task (NIC irq) to finish
>     executing on the housekeeping CPU and eventually misses its deadline
>
> Now, of course by making the latency sensitive application tasks use a
> higher priority than anything on housekeeping CPUs we could avoid the
> issue, but the fact that an implicit in-kernel link between otherwise
> unrelated tasks might cause priority inversion is probably not ideal?
> Thus this email.
>
> Does this report make any sense? If it does, has this issue ever been
> reported and possibly discussed? I guess it’s kind of a corner case, but
> I wonder if anybody has suggestions already on how to possibly try to
> tackle it from a kernel perspective.

Just a question. Is the low latency application using PI futex or the 
normal wait-wake futex? We could use separate set of hash buckets for 
these distinct futex types.

Cheers,
Longman


