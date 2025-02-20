Return-Path: <linux-kernel+bounces-524067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283AA3DED0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70C67AC871
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077EF1FDA94;
	Thu, 20 Feb 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aV5RvMYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721701D5CDE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065431; cv=none; b=G+7PpYyou0vF65ijztKBjV0w8AvtuA1GTEYN1w45c0SEq+XlTvAD3ziSiEIj+++obHTrmR0wsv8Zv5gF8hLtjkK3cfuu60QHGIfuly0y4SSXfgovvxAYXG49dNcASEQld9qRZe2bH6f0sabRSOgmP/sbeLvV6sB3tyoUfNAIz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065431; c=relaxed/simple;
	bh=/aCOLlQa56ogQjSEhr6EEGpJHe2bTEFvNX+Zf99/rvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmCBUXsosM6Y0jw5q7fcfEypLuytRW9z6J56G9jlmoj0O+65LFfUxD78+cTZudCJwXP0X3Wbm3LraESMi5C2bku03yLhhyLTXzyOawinoJL/Zurj0H0D6I1arliS44NB8AFA50KeD2eGUaRUt3WQfeV4Y9ebtMNOrNjWb/BuoW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV5RvMYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740065428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eKTaHaEvddQzU5722WOjI+3oiQgOlFUwv2UlcnuFPYs=;
	b=aV5RvMYAjcUxNoqFCKgz2ihOaLRGCGnq7oJC2nSpzl9QPT7VkAsYIFW7ihKV0cI3pAvxd6
	i3WhxT8c6iA0YF25/moe83kAiAPMvYqZu//ZAOQHh0MC7F7tzK8TkPekC3cN8Td0VHGyYn
	MsDcpRkG7cgtBCpIU0oRn5l8zdWUjlc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-jpIZdr9kN4SGGPZKwPk0Lw-1; Thu, 20 Feb 2025 10:30:27 -0500
X-MC-Unique: jpIZdr9kN4SGGPZKwPk0Lw-1
X-Mimecast-MFC-AGG-ID: jpIZdr9kN4SGGPZKwPk0Lw_1740065426
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso1118309f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065426; x=1740670226;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKTaHaEvddQzU5722WOjI+3oiQgOlFUwv2UlcnuFPYs=;
        b=U004nemrmQmJVJNXCr5kl8ArNj6q0yc4nE+i/fmq8Q2c+QZEycT9ixernzNsGwe/C8
         1XQvZprfAPdWuaC6gnxVZhEDwvpj6xhvWd76YUBwcseM/Puc49zdBC8DtjKOByOGxRId
         ZJwAYXbxEIjOM4b6X+QkTz3GuqXlQhFC3ulj/7EcbfePoCDG3t5O/xG3hQ+mKrjl/W3x
         u2xcQ7eNNffQfwMc7sT7LBnGKESUNFxkvWKzndNCcGX4DBSRfV9BV9GB7Iq0xqKr0kU4
         8F4vDmK29JrcDjKTLoNsASvTS/InPkGfTuXi+CNoKH46RJ5g01DWRaj/M9JBBs8Mppyu
         1tOA==
X-Forwarded-Encrypted: i=1; AJvYcCUsFynDiTP8RXh8PLA82OAs/QDrYWlD009YXtV6WnSjB8DxfktrGVMKwGH7iSPFqfeZKwFHDkporIHLiVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBp1t8wIDWUJqRve6f8oyy1W/R5OqOqzvCOn6NhYVUnqoJUEf
	RCugGYR5izHpc8Zv6t4Psze8Am3sxmmQd3k1CCSHPlgnynrYLTwL5F1ni2FAnt4TAZ8uzoDIf8s
	bRCdhtYFdbTvNLy2lHM6fUVxCIjtr8yp7iqyZ7FDbu/0lpcbUhZILMMZ6nNBTf2hzRsNpqkLp
X-Gm-Gg: ASbGncsDBvp6PXLqUighebGKtmEgRqjmGMvCbLNIuYwTHLgI9tM/CBvB5Pr0gaURDrO
	keGeeyWdpoy6Xd0+wdv2Z4XDMf49+RLL6l5sUBdrGuNY4UQaGo/un+NY0Y+WdW1CX5UFKnV5lkX
	aS9LemtbyFpVQl6MYTxymmlgCtXBdXNt+uWPJFPSU6WbusNbzuPHvpEMy2gnDCgVFfBlUuesUxc
	kAvf9OFwNoTiA6MBdvwFNEFlyWCa5DKkOgtChSGB+yuFgca64pE/Z26ILnLUqHRrbqySdBEK+Cm
	+Je68fP/1F4z6uHj5cqHf8I43j1Tpis=
X-Received: by 2002:a05:6000:4712:b0:38f:32d5:3a92 with SMTP id ffacd0b85a97d-38f614b827bmr3184414f8f.12.1740065425435;
        Thu, 20 Feb 2025 07:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMOK8qLm4hhqAb33GHsQI0q1jZIRok0DsJ4GBWPKskL8lGrJaQSLX5IEEJZeKsfMRaXgbN3Q==
X-Received: by 2002:a05:6000:4712:b0:38f:32d5:3a92 with SMTP id ffacd0b85a97d-38f614b827bmr3184376f8f.12.1740065424988;
        Thu, 20 Feb 2025 07:30:24 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm6316858f8f.21.2025.02.20.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:30:24 -0800 (PST)
Message-ID: <ebc70e9e9ad4a7055286d0db93085536ed070a6f.camel@redhat.com>
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney"	 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Date: Thu, 20 Feb 2025 16:30:22 +0100
In-Reply-To: <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
References: <20250220102639.141314-1-gmonaco@redhat.com>
	 <20250220102639.141314-2-gmonaco@redhat.com>
	 <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Thu, 2025-02-20 at 09:42 -0500, Mathieu Desnoyers wrote:
> On 2025-02-20 05:26, Gabriele Monaco wrote:
> > Currently, the task_mm_cid_work function is called in a task work
> > triggered by a scheduler tick to frequently compact the mm_cids of
> > each
> > process. This can delay the execution of the corresponding thread
> > for
> > the entire duration of the function, negatively affecting the
> > response
> > in case of real time tasks. In practice, we observe
> > task_mm_cid_work
> > increasing the latency of 30-35us on a 128 cores system, this order
> > of
> > magnitude is meaningful under PREEMPT_RT.
> >=20
> > Run the task_mm_cid_work in a new work_struct connected to the
> > mm_struct rather than in the task context before returning to
> > userspace.
> >=20
> > This work_struct is initialised with the mm and disabled before
> > freeing
> > it. The queuing of the work happens while returning to userspace in
> > __rseq_handle_notify_resume, maintaining the checks to avoid
> > running
> > more frequently than MM_CID_SCAN_DELAY.
> > To make sure this happens predictably also on long running tasks,
> > we
> > trigger a call to __rseq_handle_notify_resume also from the
> > scheduler
> > tick (which in turn will also schedule the work item).
> >=20
> > The main advantage of this change is that the function can be
> > offloaded
> > to a different CPU and even preempted by RT tasks.
> >=20
> > Moreover, this new behaviour is more predictable with periodic
> > tasks
> > with short runtime, which may rarely run during a scheduler tick.
> > Now, the work is always scheduled when the task returns to
> > userspace.
> >=20
> > The work is disabled during mmdrop, since the function cannot sleep
> > in
> > all kernel configurations, we cannot wait for possibly running work
> > items to terminate. We make sure the mm is valid in case the task
> > is
> > terminating by reserving it with mmgrab/mmdrop, returning
> > prematurely if
> > we are really the last user while the work gets to run.
> > This situation is unlikely since we don't schedule the work for
> > exiting
> > tasks, but we cannot rule it out.
> >=20
> > Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
> > by mm_cid")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> [...]
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9aecd914ac691..363e51dd25175 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5663,7 +5663,7 @@ void sched_tick(void)
> > =C2=A0=C2=A0		resched_latency =3D cpu_resched_latency(rq);
> > =C2=A0=C2=A0	calc_global_load_tick(rq);
> > =C2=A0=C2=A0	sched_core_tick(rq);
> > -	task_tick_mm_cid(rq, donor);
> > +	rseq_preempt(donor);
> > =C2=A0=C2=A0	scx_tick(rq);
> > =C2=A0=20
> > =C2=A0=C2=A0	rq_unlock(rq, &rf);
>=20
> There is one tiny important detail worth discussing here: I wonder if
> executing a __rseq_handle_notify_resume() on return to userspace on
> every scheduler tick will cause noticeable performance degradation ?
>=20
> I think we can mitigate the impact if we can quickly compute the
> amount
> of contiguous unpreempted runtime since last preemption, then we
> could
> use this as a way to only issue rseq_preempt() when there has been a
> minimum amount of contiguous unpreempted execution. Otherwise the
> rseq_preempt() already issued by preemption is enough.
>=20
> I'm not entirely sure how to compute this "unpreempted contiguous
> runtime" value within sched_tick() though, any ideas ?

I was a bit concerned but, at least from the latency perspective, I
didn't see any noticeable difference. This may also depend on the
system under test, though.

We may not need to do that, what we are doing here is improperly
calling rseq_preempt. What if we call an rseq_tick which sets a
different bit in rseq_event_mask and take that into consideration while
running __rseq_handle_notify_resume?

We could follow the periodicity of the mm_cid compaction and, if the
rseq event is a tick, only continue if it is time to compact (and we
can return this value from task_queue_mm_cid to avoid checking twice).
We would be off by one period (commit the rseq happens before we
schedule the next compaction), but it should be acceptable:

    __rseq_handle_notify_resume()
    {
        should_queue =3D task_queue_mm_cid();
        if (!should_queue && test_bit(RSEQ_EVENT_TICK, &t-
>rseq_event_mask))
            return;
        /* go on with __rseq_handle_notify_resume */
    }

Does it sound like an acceptable solution?

Another doubt about this case, here we are worrying about this
hypothetical long-running task, I'm assuming this can happen only for:
1. isolated cpus with nohz_full and 1 task (the approach wouldn't work)
  or
2. tasks with RT priority mostly starving the cpu

In 1. I'm not sure the user would really need rseq in the first place,
in 2., assuming nothing like stalld/sched rt throttling is in place, we
will probably also never run the kworker doing mm_cid compaction (I'm
using the system_wq), for this reason it's probably wiser to use the
system_unbound_wq, which as far as I could understand is the only one
that would allow the work to run on any other CPU.

I might be missing something trivial here, what do you think though?

Thanks,
Gabriele


