Return-Path: <linux-kernel+bounces-353751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53614993217
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3452815A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DE1DA0E3;
	Mon,  7 Oct 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQSJ5KRP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873481D434E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316500; cv=none; b=iHmTJatdrFFMhojg1GFmtz6O2I0ko2cX8g6sa3rrxxX+gYmkEAtmhuVDfc44lZ//yDsZt+LD4BgmWh1k8RmhQ73V8d8Nyna+luuX69HAyaqdUVD1+FI+OAbeSI7HsFVqzPPzvdz2KWeg3LrFdgqxFx5J7wBhNpX61/kfnVfD3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316500; c=relaxed/simple;
	bh=0JGhNjI9OqMPJQ3ZGZRQDKLlCHXNrwXmeMrliEcJ7kg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n+PI8bLJC8R1rftEdknP7gxHdhdFDLUuNKmkcOv8NbfNUew2mL4fX26FcvVJNxIuTytkuXddIKvF2Xr371H1AMhQPeAu3VVCo9BUhXX1IDUcuAD363GBEVAiQE0Fg+XAt9iUqGWB3fBVQOFqR2ne2Be45MsBlpfeP2znboOAqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQSJ5KRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728316498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZywjjCV3vpsaGGSAq9qpARUrwV4upoWhBWZs6kVxC8=;
	b=iQSJ5KRPIIM7ydp+I9D7q9x9nmFbXHyy5uD9x22pP0m2/PP+MDZwO3TbffOhIKPuDdvi06
	aWPrzb6UsQsNbCXX8T8zBE7ri3EB8uuqKH6Bl1Hfi7RcU1rb+1/a0EaFj+xz754ZVWitww
	fWq3yJkNlWOMu3pU4NH11Tkr2vzfY18=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-xN3-gQeoPES1_WKnAl-JDA-1; Mon, 07 Oct 2024 11:54:57 -0400
X-MC-Unique: xN3-gQeoPES1_WKnAl-JDA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4582182b6afso101091201cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316496; x=1728921296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZywjjCV3vpsaGGSAq9qpARUrwV4upoWhBWZs6kVxC8=;
        b=exHva3xTdAePPCZ/P5xryHGejGLsb31wGdJMK22SZP5i59FSWF0SrzgZMIMtyERxkK
         VjaLuHPqpXoRPYibCgdRFDkgNWHGVmu/EaXYutWe5mDKMFa2mz5g5zmHfYLNuBFB9GCR
         Ka7LC26Xi0OW1EPMhhS4K5fcs2dc21/Jwrz7LegWs11zAwlU46d47FmGH3hPhdVER/tp
         27pjVioXGYdmoPWVpbIVSd8fJuaDz67tRNvK1feu9/qKKoVw05sdfmwUdtOF7KR1fDy4
         WOJw20y7yNNA8P0nvGLXmGZ/J6d05faeuw7DMF+KlN+kh7rJvlK3Np3w4lUS4w4PrsDo
         FDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHI4v13FSIK4kPPnC95IZAEIHfp30QNG1pu4a5WGMxJojDByCswPYDQNTe9h2MnthJXpRyaqblbZ4brjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwYG+6nLgU90ptN95H4QZJx5LZ89rYrO0/T3oJ1/MOhLxilg0
	/JQLMCgwtmpg/ekVOIccxJ0GiZDGVz6tj49i9o9kan1QTRVgzyPLvWu4XIR4qzWIvoIGoIIVru2
	pH/JsD8gn6NN+iW+VHGva77SaVuX8ZTRDPNojgzaYLmHZHOIdGydjEq2RIU3jrw==
X-Received: by 2002:ac8:57c9:0:b0:458:1f34:55cb with SMTP id d75a77b69052e-45d9ba59c32mr207714971cf.23.1728316496641;
        Mon, 07 Oct 2024 08:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6K4EleieQHgjI66hd44o18y3hyV+4FXW1ImxX/hjMEyIh7ZAhU5FLeI6hYOtojHKZ0mE7QQ==
X-Received: by 2002:ac8:57c9:0:b0:458:1f34:55cb with SMTP id d75a77b69052e-45d9ba59c32mr207714631cf.23.1728316496253;
        Mon, 07 Oct 2024 08:54:56 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b458bsm27432141cf.2.2024.10.07.08.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:54:55 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <13f78472-2fa8-4af9-9d5f-a93cb16cc7ca@redhat.com>
Date: Mon, 7 Oct 2024 11:54:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Luis Goncalves <lgoncalv@redhat.com>,
 Chunyu Hu <chuhu@redhat.com>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
 <20241007145037.GE4879@noisy.programming.kicks-ass.net>
 <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>
 <20241007153341.GA14587@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241007153341.GA14587@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/24 11:33 AM, Peter Zijlstra wrote:
> On Mon, Oct 07, 2024 at 11:23:32AM -0400, Waiman Long wrote:
>
>>> Is the problem that:
>>>
>>> 	sched_tick()
>            raw_spin_lock(&rq->__lock);
>>> 	  task_tick_mm_cid()
>>> 	    task_work_add()
>>> 	      kasan_save_stack()
>>> 	        idiotic crap while holding rq->__lock ?
>>>
>>> Because afaict that is completely insane. And has nothing to do with
>>> rtmutex.
>>>
>>> We are not going to change rtmutex because instrumentation shit is shit.
>> Yes, it is because of KASAN that causes page allocation while holding the
>> rq->__lock. Maybe we can blame KASAN for this. It is actually not a problem
>> for non-PREEMPT_RT kernel because only trylock is being used. However, we
>> don't use trylock all the way when rt_spin_trylock() is being used with
>> PREEMPT_RT Kernel.
> It has nothing to do with trylock, an everything to do with scheduler
> locks being special.
>
> But even so, trying to squirrel a spinlock inside a raw_spinlock is
> dodgy at the best of times, yes it mostly works, but should be avoided
> whenever possible.
>
> And instrumentation just doesn't count.
>
>> This is certainly a problem that we need to fix as there
>> may be other similar case not involving rq->__lock lurking somewhere.
> There cannot be, lock order is:
>
>    rtmutex->wait_lock
>      task->pi_lock
>        rq->__lock
>
> Trying to subvert that order gets you a splat, any other:
>
>    raw_spin_lock(&foo);
>    spin_trylock(&bar);
>
> will 'work', despite probably not being a very good idea.
>
> Any case involving the scheduler locks needs to be eradicated, not
> worked around.

OK, I will see what I can do to work around this issue.

Cheers,
Longman


