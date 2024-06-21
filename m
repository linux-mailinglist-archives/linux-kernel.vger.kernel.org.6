Return-Path: <linux-kernel+bounces-224789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D149126E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2491F26FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5B9475;
	Fri, 21 Jun 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUrcKABM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921361366
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977419; cv=none; b=akl8LS7p33WgepR15A4duUrouwK9t72RAutzesf7U+CTRUVwKyJLCAQYvQk16nceCvYOR/Xiz2QyVPF2DQMXmMKaHTjpnJhSIx/VarKkODGRbV2/FTV9G3riQQvOrO5UX0L0J7DdMFcBrTpkpfIQpmlT2zLrWDq3Utyajm2Y+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977419; c=relaxed/simple;
	bh=QLNmheYAvaWvs1YBIykDFhXYvxKiXkI3zQ5sRSuGg7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnFZL2pxhsD3e03kSnzzkoNAw+T/cF1YVmtWB8jZrVK2e289CbUxKKZtLlfCufKNIOKD9Jux8ZGw1ZCxll3ZoXxUjcMPlHN+L/nD6FL1QiDaNx3wc/rckqyCYRM9h93IkvGXz+8NA+AYRiWuZmJTFFaxdLMYXzmXuJdIo+P9Me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUrcKABM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75410C2BBFC;
	Fri, 21 Jun 2024 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718977419;
	bh=QLNmheYAvaWvs1YBIykDFhXYvxKiXkI3zQ5sRSuGg7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MUrcKABMaTYh1LPZeAd0YxqmY2kjsdPh/ZkLHxs6q9wPuMrMgZgUqoZHxEbff4BjT
	 wiUoB9L5DTYq1hoCCBFc4wjeaYMrISnXKgHg3DBLnu20Um3mty4CDyoZFLYR0xmvUi
	 673WYUYzIaW7tlMirTnaJAYeBxQIF9AZTnCLoTU2dVecaGEq6ngcWR7PjCo5FX3rpR
	 HvyZTp4e6SW1xU3DWuricVZO31rkity1CTQWkPf4CTr+HqTgVvhr0eQ3sBkX5dypv7
	 rArqO7DjrPh5hlPzO+sjMMnsce8XOfB9lvho5SxvXfe8NtJdbZcP0ETVrYuf7IK8Jm
	 ZoLgmVVNQwE/w==
Message-ID: <b14879eb-cbc9-4e53-b703-ab7b451b7687@kernel.org>
Date: Fri, 21 Jun 2024 15:43:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
To: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1716811043.git.bristot@kernel.org>
 <ZnWCBF9QkQmO01nw@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <ZnWCBF9QkQmO01nw@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 15:37, Juri Lelli wrote:
> Hi Daniel,
> 
> On 27/05/24 14:06, Daniel Bristot de Oliveira wrote:
>> This is v7 of Peter's SCHED_DEADLINE server infrastructure
>> implementation [1].
> 
> I finally managed to give this a go and can report that it works great
> for what I've seen. :)
> 
> So, please consider this reply a
> 
> Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

>> SCHED_DEADLINE servers can help fixing starvation issues of low priority
>> tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
>> cycles. Today we have RT Throttling; DEADLINE servers should be able to
>> replace and improve that.
> 
> ...
> 
>> The problem with DL server only implementation is that FIFO tasks might
>> suffer preemption from NORMAL even when spare CPU cycles are available.
>> In fact, fair deadline server is enqueued right away when NORMAL tasks
>> wake up and they are first scheduled by the server, thus potentially
>> preempting a well behaving FIFO task. This is of course not ideal.
>>
>> We had discussions about it, and one of the possibilities would be
>> using a different scheduling algorithm for this. But IMHO that is
>> an overkill.
>>
>> Juri and I discussed this and though about delaying the server
>> activation for the (period - runtime), thus enabling the server
>> only if the fair scheduler is about to starve. We called it
>> the defer server.
>>
>> The defer the server start to the (absolute deadline - runtime)
>> point in time. This is achieved by starting the dl server throttled,
>> with a next replenishing time set to activate the server at
>> (absolute deadline - runtime).
>>
>> The server is enqueued with the runtime replenished. As the fair
>> scheduler runs without boost, its runtime is consumed. If the
>> fair server has its runtime before the runtime - deadline time,
>> the a new period is set, and the timer armed for the new
>> deadline.
> 
> I also wanted to pay particular attention to this part implementing the
> deferred server, but failed to find enough focus time for now. I will
> keep trying. One thing that I wondered though is if this change (and the
> move towards this replacing current RT throttling) would call for a Doc
> update. What do you think?

Yeah, am I planning a v8 for the next week. It has no code changes, just a rebase
and the addition of documentation.

I am not mentioning the RT throttling in the documentation. Instead, I am treating
this as a new feature on its own, which is inline with the comments over the code.

I will add an rv monitor to it, extending the documentation, but I will do it
on another series... once we get this done.

Thoughts?

Peter/Ingo, which branch should I rebase it?

-- Daniel

> Thanks!
> Juri
> 


