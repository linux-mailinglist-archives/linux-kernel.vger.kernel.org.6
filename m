Return-Path: <linux-kernel+bounces-444177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79029F027A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBDB162499
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536952AEE9;
	Fri, 13 Dec 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="leyo8V+a"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36388846F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734055333; cv=none; b=Q2g2fJhMXOaZHy56Rhv3xticeAVz+jfVhBaUwiiQlejKiRGiFjBd7xOPt4bXI+bUutP8zswH96OPcNLKBsPDoTE3TLkPjK9gTllyrNe5/3ZXdcztbMDCY49TI9fXx0sjZdvCeiAIkO4sgg9renKbFrH4I9tLWz9xVHao/XAUHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734055333; c=relaxed/simple;
	bh=gnbgtPzcEDsASikfB6jgokSPAazc1Vtapd0SU7k5skU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F00xG/nmpSVqMfed5i5CpNLN+0OHM+L9bZpQSVV20zGTGH76hRGMqWVbnbiKTVGXemWM4Z1j+REPyfW+xNpp+a09kKzEd0MzUYVwBFM7ykAzvWm4GGykQ7v2jg6NsXGN38Yx6EyTWMm6+6hOBxhsDFfxc7Ptl9obP1YvrshtnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=leyo8V+a; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QGdNKkiSBGBLzGEVFXwgDerw9/cLkP8NiqmikqE4lNw=; b=leyo8V+a8M02afmy+hWX7XrR4o
	08qp8R/Zd5DB+hucuhfkel5IRzuLxPw1O8FtwewVAflGKMVC3gI4RzdnYiqjlYbklDj0Bwmbw3S13
	wLGv76yvqK9kgCSne2rMo82qAF1aXLiMUFmiLgPk5roCUlJSsY92MlJtOa5ZAHBqplaP1/iGNL8C+
	qSAZsFBd/GH8DEHg7xNEsPtzaYt8S6ooYAGz9c/4kuMnwsl+2OXTrzpPNtWEQckUXg5B46Unxnlm/
	8WVPtejVeFWnBU6jM2LfcWUeekPh9Il9r6WL2y67QX8lJTPTIefByDs+gRus0lnJQOjDffiLUnwYk
	in/OuJxQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tLv0B-002ToF-GT; Fri, 13 Dec 2024 03:01:59 +0100
Message-ID: <8cb978cf-39dd-43e0-948c-1632a11b0da5@igalia.com>
Date: Fri, 13 Dec 2024 11:01:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] sched_ext: Implement scx_bpf_now_ns()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-5-changwoo@igalia.com>
 <20241211093256.GY35539@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241211093256.GY35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the review!

On 24. 12. 11. 18:32, Peter Zijlstra wrote:
> On Mon, Dec 09, 2024 at 03:15:29PM +0900, Changwoo Min wrote:
>> +	if (!(rq->scx.flags & SCX_RQ_CLK_VALID) ||
>> +	    (rq->scx.prev_clock >= clock)) {
> 
> As TJ said, it's best to consider that the clock can wrap.
I will update it as Tejun suggested.

> 
>> +		/*
>> +		 * If the rq clock is invalid or goes backward,
>> +		 * start a new rq clock period with a fresh sched_clock_cpu().
>> +		 *
>> +		 * The cached rq clock can go backward because there is a
>> +		 * race with a timer interrupt. Suppose that a timer interrupt
>> +		 * occurred while running scx_bpf_now_ns() *after* reading the
>> +		 * rq clock and *before* comparing the if condition. The timer
>> +		 * interrupt will eventually call a BPF scheduler's ops.tick(),
>> +		 * and the BPF scheduler can call scx_bpf_now_ns(). Since the
>> +		 * scheduler core updates the rq clock before calling
>> +		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
>> +		 * clock. After handling the timer interrupt, the interrupted
>> +		 * scx_bpf_now_ns() will be resumed, so the if condition will
>> +		 * be compared. In this case, the clock, which was read before
>> +		 * the timer interrupt, will be the same as rq->scx.prev_clock.
>> +		 * When such a case is detected, start a new rq clock period
>> +		 * with a fresh sched_clock_cpu().
> 
> This has a wall-of-text problem; use paragraphs?
I will improve the presentation using multiple paragraphs
and time chart.

>> +		clock = sched_clock_cpu(cpu_of(rq));
>> +		scx_rq_clock_update(rq, clock);
> Doesn't this set the VALID bit again? How is using this outside of
> RQ-lock and setting VALID a good idea?

You are right. The current implementation sets the VALID bit, so
the clock can be reused until the next update_rq_clock(). Another
approach would be not setting the VALID flag, so it gets the
fresh clock every time until next update_rq_clock(). Considering
the clock usages of the scx schedulers, both would be almost the
same in number of sched_clock_cpu() calls. But the second
approach -- not setting the VALID flag outside of rqlock -- would
be more predictable. I will double-check the difference of
sched_clock_cpu() calls, and if they are similar, I will change
it not setting the VALID flag.

Regards,
Changwoo Min

