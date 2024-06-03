Return-Path: <linux-kernel+bounces-199395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48A8D86B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4181C21F36
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092D132126;
	Mon,  3 Jun 2024 15:57:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3A1E525
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430246; cv=none; b=OzSn3hJ98BbIWRcQrsqKj2rGMRGwW4NUF51wZ8XLxmFEvJqOo5/jbWqsx1AIPfl4GU04SLhWtShYgFIlFIMaJbHR5IBgrZg4kPJzMIfIWoSA38w21Q4xbGqXeKfMVIo17kz5+qB6XQkNsB7U386dKSH4QRIEatRaSA5QkX31vnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430246; c=relaxed/simple;
	bh=2bqRqWYiVIR8h9mv7pcxawhYKpjJqXxZgnm3Padn8pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIvuTn0IqMAuLXgdOEC9ewklKS4yC7nwL1DZ3hTn8eWykRfMeVZkE4w1D9yQj+awnfHPCBZ6/QoEMKpqxgfAEBNNopfYNk3R8fN7EapiYnDf3KCCdLp66XsinFrG/Ck4ECzLJ83UreObz3FOsZ2iPgW6IuT4qclvl1Q9ahzgYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D3B1042;
	Mon,  3 Jun 2024 08:57:41 -0700 (PDT)
Received: from [10.57.87.208] (unknown [10.57.87.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A28B3F64C;
	Mon,  3 Jun 2024 08:57:16 -0700 (PDT)
Message-ID: <788a0c8a-79b9-4a06-9739-8b62498bde90@arm.com>
Date: Mon, 3 Jun 2024 16:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, Luis Machado <luis.machado@arm.com>
Cc: linux-kernel@vger.kernel.org
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <20240523084548.GI40213@noisy.programming.kicks-ass.net>
 <e4b472c9-ad8b-4423-81ad-02a1ab231f95@arm.com>
 <20240523093338.GJ40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240523093338.GJ40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2024 10:33, Peter Zijlstra wrote:
> On Thu, May 23, 2024 at 10:06:04AM +0100, Luis Machado wrote:
> 
>> Booting the kernel with NO_DELAY_DEQUEUE (default to false), things work fine. Then
>> if I switch to DELAY_DEQUEUE at runtime, things start using a lot more power.
>>
>> The interesting bit is if I switch to NO_DELAY_DEQUEUE again at runtime, things don't
>> go back to normal. Rather they stay the same, using a lot more energy.
> 
> Ooh, cute.. weird. I'll try and see if we leak state somehow.

Hi. I'm working on uclamp anyway so I just gave this series (and all 
fixes mentioned in this thread) a go.

It seems after running with this series for a while, suddenly uclamp_max 
no longer works. Running a task with uclamp_max of 110 still sees an rq 
uclamp_max of 1024. Also weirdly, the PELT signal of that uclamp_max is 
completely broken. It goes up to a very high value and then suddenly 
drops to almost 0 from time to time.

I wonder if the reason Luis saw that is because he was the first one to 
run delayed dequeue with uclamp. I'm not familiar enough with the series 
to know how it could possibly affect uclamp so investigating in this 
front may be worth trying. Maybe some leaked uclamp state on the rq?

