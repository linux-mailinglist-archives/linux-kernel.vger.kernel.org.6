Return-Path: <linux-kernel+bounces-304949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B41962735
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B529A1F24B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67B178364;
	Wed, 28 Aug 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRrSGZib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821B15A86D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848553; cv=none; b=BeVPBoMS33IXr1CfCehM8XkSSyTAzcSUXadqAcesQkT5X7VtgidIwUjEpkenqThFt4jqFq2ht6aHnDCENI/MncoPgxdchdsZdH2dLXnJJeO6lmXJs3SrqrHInG9uGggwkVGYJD5MhcEpV/nDe4d+wXzoasoPeXP+WTHJMl020io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848553; c=relaxed/simple;
	bh=x9qlPosPOT0mc/BTP+9hEBMfeyvgHRt781YK8Wd4aIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1qkobt/eJTm46qFgYJ7K5j8h1ivNOZfOYb/J6ETdtkPnyP6+BliANm7GOelKx+ka3kU/7q5h3UkhcxM+m9VV2xOEulPJSFIHZa1bd1Iyk6Wvk+EoTN5hHar84J5QWnjQqZVsqiIHPdbQpQSPqvTrwydDpfrM/37knGRVN7TgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRrSGZib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724848551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4bguXdYSXvrSfLEnFQDtAqoiZ5yFy7g96RVfSc27jY=;
	b=RRrSGZibSEJp0N+/Scz1j+zp7iEIoc4h7GmOWBhLosgBVKDmn3zyykONzxpE4S8U4MPuaI
	ceIi+7N4l4VpBOZ+pgHshKa12okpFV9LB1KZYp5gYHVVFPzSztRfoRkvYPaX0X7OIyMNHl
	e5QbnhezSMBvit3bipa4oztoxRq0O7k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-xV3wLo-CN22QeofePABQbw-1; Wed, 28 Aug 2024 08:35:49 -0400
X-MC-Unique: xV3wLo-CN22QeofePABQbw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fdd97e455so93130991cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848549; x=1725453349;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4bguXdYSXvrSfLEnFQDtAqoiZ5yFy7g96RVfSc27jY=;
        b=WbUmTXeJ47LL9jTNxY0+x7Rh3rzRYoenq/vTvg/DFTx5wRRx77+C1gbzKNUwAdMnlS
         ZhH2SegUDSJf1fU2pyMMnBcwCkZxs3vwh+bVe0M5p2Tf/DaYt/1Ef39ycUMpPK0Yovlf
         NUWqad6W943yHb+Y5X5jOy8zajTAlI58EkQZ5FlRfvLNuTLyBD0auNuS7uWbUOnSnIRb
         AtgtLvcrXSLLFIP+pSSAn2QWE/i0J3y1jOu5Y9tctnKbmLcV1aezRD7REmwZqsFaXrws
         q/NhTh9BMHGSUS+Puh4DktZam0b54E4vsGdtsEbufYdVi4T4dpjnrME8/qVKfr7c7n3E
         0zvw==
X-Forwarded-Encrypted: i=1; AJvYcCXVxheIMI5LeaxL7WovLMHNjKvJGjqnnJ2CvK9wwVX094LkyZDTlX+nDMJDyTcMYwAosBKySNHKkCoxX60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+ylOL7v/cnpdNJP1T8N7FYbNOrXFcWVqW+gqIf4CbL0MEbv0
	cnoNlCp9UFkYFlpQ+K+N3nTv5nx16Bt35RGtuP/6YlqfaIldN1S19wlBrc0Az6VlnylqRTdt1sA
	FLVejE8CNlLpKGb5HxMwKhI4h9gcEuMsUupty+xzFSMZENLa8ZKAbCnfwC513KQ==
X-Received: by 2002:a05:622a:514c:b0:447:eb16:2e54 with SMTP id d75a77b69052e-45509c1be10mr250567901cf.22.1724848549184;
        Wed, 28 Aug 2024 05:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFMobLLxhfH0ePjl9UDzvnzGqdiHBlSBGLYjEpB8VeUXGrg0oM3EhtsjlS+3YQ9S8qX+m0TA==
X-Received: by 2002:a05:622a:514c:b0:447:eb16:2e54 with SMTP id d75a77b69052e-45509c1be10mr250567611cf.22.1724848548666;
        Wed, 28 Aug 2024 05:35:48 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1968a6sm61087771cf.61.2024.08.28.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 05:35:47 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel-team@meta.com,
 Chen Yu <yu.c.chen@intel.com>
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <a19308ed-7252-4119-b891-2a61791bb6e5@paulmck-laptop>
References: <c28dbc65-7499-41a5-84d0-991843153b1a@paulmck-laptop>
 <20240823074705.GB12053@noisy.programming.kicks-ass.net>
 <xhsmho75fo6e4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <b1824f4a-f5cc-4011-876f-8a73cf752067@paulmck-laptop>
 <xhsmhle0inuze.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhikvmnfb3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <c83028db-55ad-45b3-a27a-842ed665a882@paulmck-laptop>
 <103b1710-39ca-40d0-947d-fdac32d6e6a0@paulmck-laptop>
 <xhsmhcyltogin.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <a19308ed-7252-4119-b891-2a61791bb6e5@paulmck-laptop>
Date: Wed, 28 Aug 2024 14:35:45 +0200
Message-ID: <xhsmha5gwome6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/08/24 13:36, Paul E. McKenney wrote:
> On Tue, Aug 27, 2024 at 10:30:24PM +0200, Valentin Schneider wrote:
>> On 27/08/24 11:35, Paul E. McKenney wrote:
>> > On Tue, Aug 27, 2024 at 10:33:13AM -0700, Paul E. McKenney wrote:
>> >> On Tue, Aug 27, 2024 at 05:41:52PM +0200, Valentin Schneider wrote:
>> >> > I've taken tip/sched/core and shuffled hunks around; I didn't re-or=
der any
>> >> > commit. I've also taken out the dequeue from switched_from_fair() a=
nd put
>> >> > it at the very top of the branch which should hopefully help bisect=
ion.
>> >> >
>> >> > The final delta between that branch and tip/sched/core is empty, so=
 it
>> >> > really is just shuffling inbetween commits.
>> >> >
>> >> > Please find the branch at:
>> >> >
>> >> > https://gitlab.com/vschneid/linux.git -b mainline/sched/eevdf-compl=
ete-builderr
>> >> >
>> >> > I'll go stare at the BUG itself now.
>> >>
>> >> Thank you!
>> >>
>> >> I have fired up tests on the "BROKEN?" commit.  If that fails, I will
>> >> try its predecessor, and if that fails, I wlll bisect from e28b5f8bda=
01
>> >> ("sched/fair: Assert {set_next,put_prev}_entity() are properly balanc=
ed"),
>> >> which has stood up to heavy hammering in earlier testing.
>> >
>> > And of 50 runs of TREE03 on the "BROKEN?" commit resulted in 32 failur=
es.
>> > Of these, 29 were the dequeue_rt_stack() failure.  Two more were RCU
>> > CPU stall warnings, and the last one was an oddball "kernel BUG at
>> > kernel/sched/rt.c:1714"=C2=A0followed by an equally oddball "Oops: inv=
alid
>> > opcode: 0000 [#1] PREEMPT SMP PTI".
>> >
>> > Just to be specific, this is commit:
>> >
>> > df8fe34bfa36 ("BROKEN? sched/fair: Dequeue sched_delayed tasks when sw=
itching from fair")
>> >
>> > This commit's predecessor is this commit:
>> >
>> > 2f888533d073 ("sched/eevdf: Propagate min_slice up the cgroup hierarch=
y")
>> >
>> > This predecessor commit passes 50 runs of TREE03 with no failures.
>> >
>> > So that addition of that dequeue_task() call to the switched_from_fair=
()
>> > function is looking quite suspicious to me.  ;-)
>> >
>> >                                                       Thanx, Paul
>>
>> Thanks for the testing!
>>
>> The WARN_ON_ONCE(!rt_se->on_list); hit in __dequeue_rt_entity() feels li=
ke
>> a put_prev/set_next kind of issue...
>>
>> So far I'd assumed a ->sched_delayed task can't be current during
>> switched_from_fair(), I got confused because it's Mond^CCC Tuesday, but I
>> think that still holds: we can't get a balance_dl() or balance_rt() to d=
rop
>> the RQ lock because prev would be fair, and we can't get a
>> newidle_balance() with a ->sched_delayed task because we'd have
>> sched_fair_runnable() :=3D true.
>>
>> I'll pick this back up tomorrow, this is a task that requires either
>> caffeine or booze and it's too late for either.
>
> Thank you for chasing this, and get some sleep!  This one is of course
> annoying, but it is not (yet) an emergency.  I look forward to seeing
> what you come up with.
>
> Also, I would of course be happy to apply debug patches.
>
>                                                       Thanx, Paul

Chen Yu made me realize [1] that dequeue_task() really isn't enough; the
dequeue_task() in e.g. __sched_setscheduler() won't have DEQUEUE_DELAYED,
so stuff will just be left on the CFS tree.

Worse, what we need here is the __block_task() like we have at the end of
dequeue_entities(), otherwise p stays ->on_rq and that's borked - AFAICT
that explains the splat you're getting, because affine_move_task() ends up
doing a move_queued_task() for what really is a dequeued task.

I unfortunately couldn't reproduce the issue locally using your TREE03
invocation. I've pushed a new patch on top of my branch, would you mind
giving it a spin? It's a bit sketchy but should at least be going in the
right direction...

[1]: http://lore.kernel.org/r/Zs2d2aaC/zSyR94v@chenyu5-mobl2


