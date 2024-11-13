Return-Path: <linux-kernel+bounces-408225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCF9C7C44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089101F22E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BA205ABD;
	Wed, 13 Nov 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EWTysWmX"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009E201276
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526713; cv=none; b=HHzH1EGsaVrPx+5PSi36ffC7drpq0v6SM+bxhcZvo+cePCi52KWb3rJ7+fo6AZbaoywuJ3HsuI9Gbg+uaK5G8NDx/S5WmBvIWWCh1CumBghBspgtHDPivxTk2UTrXof2NM/tQD4KuiBVJo34DcOJCdtyfZtoBVeUrG3hU4uaFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526713; c=relaxed/simple;
	bh=dCGHBWLYkwmc7GofaaaTQdWOeTsx+ojqJ2GaAnQmIRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0hKaDE2be5d90pAPDTuF1/LjyOwZmpVYeLrFoHfbMJ6ko1kyCZx+RKat11BT9cuLURwcy+BWxy39uFM7CqT/9LAAnXK7kiv/in7VhmDJJurLZ/JWqJ17rMGqP7qoyRo34MsE2CPRtIexzeFHshYwR4V3oUWHrrx+GEqxsj0QaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EWTysWmX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731526703;
	bh=dCGHBWLYkwmc7GofaaaTQdWOeTsx+ojqJ2GaAnQmIRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EWTysWmXGNtu4AsXyP0EvsNt/y3B26qe7l72sEB9f1aWTF+w5datuvrzrOmKxP+oa
	 OpdMQSWizGuDEUoYKgxea2+l2XbQAF0Y1OkbWFbECe0QguzMXWnc26pP3uwEeSONXo
	 xlzPYeVUveuuu7hKLadmxV4FrNIQ3gvQCuHdeVnhhw3OhfiI1L/ve8Ojl0+Rf5jkJ5
	 pMZxnLu8zxKB3lVvYlUHa1BG8RcGrfytr0vnRRRc67PDpZYVL78wwGtBw7ygdLdP2a
	 va0Z4MJKOPNWeOp2xb8zMQEle6dojTDsafZri6OUfWCNaEXke6Eoc3tSeLKFN1li34
	 Zw+Yo8dZHvU/A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XpYVR1nbkzRgW;
	Wed, 13 Nov 2024 14:38:23 -0500 (EST)
Message-ID: <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
Date: Wed, 13 Nov 2024 14:36:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
To: Peter Zijlstra <peterz@infradead.org>,
 Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
 daniel.m.jordan@oracle.com
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241113185013.GA22571@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-13 13:50, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
> 
>> This patch set implements the above mentioned 50us extension time as posted
>> by Peter. But instead of using restartable sequences as API to set the flag
>> to request the extension, this patch proposes a new API with use of a per
>> thread shared structure implementation described below. This shared structure
>> is accessible in both users pace and kernel. The user thread will set the
>> flag in this shared structure to request execution time extension.
> 
> But why -- we already have rseq, glibc uses it by default. Why add yet
> another thing?

Indeed, what I'm not seeing in this RFC patch series cover letter is an
explanation that justifies adding yet another per-thread memory area
shared between kernel and userspace when we have extensible rseq
already.

Peter, was there anything fundamentally wrong with your approach based
on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net

The main thing I wonder is whether loading the rseq delay resched flag
on return to userspace is too late in your patch. Also, I'm not sure it is
realistic to require that no system calls should be done within time extension
slice. If we have this scenario:

A) userspace grabs lock
    - set rseq delay resched flag
B) syscall
    - reschedule
     [...]
    - return to userspace, load rseq delay-resched flag from userspace (too late)

I would have thought loading the delay resched flag should be attempted much
earlier in the scheduler code. Perhaps we could do this from a page fault
disable critical section, and accept that this hint may be a no-op if the
rseq page happens to be swapped out (which is really unlikely). This is
similar to the "on_cpu" sched state rseq extension RFC I posted a while back,
which needed to be accessed from the scheduler:

   https://lore.kernel.org/lkml/20230517152654.7193-1-mathieu.desnoyers@efficios.com/
   https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/

And we'd leave the delay-resched load in place on return to userspace, so
in the unlikely scenario where it is swapped out, at least it gets paged
back at that point.

Feel free to let me know if I'm missing an important point and/or saying
nonsense here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


