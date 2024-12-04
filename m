Return-Path: <linux-kernel+bounces-430573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94589E3308
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CE5284E27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628E170A23;
	Wed,  4 Dec 2024 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="olSbeEOR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC58145B2C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733289467; cv=none; b=bo5dGBr5HUmOPK6I4e6kJT9E4BB5O/RGZO2qHQh/lWdn7haO6Zg47xlq72yaCyJDdqFXPXqQSauVJyIXjFVjoEoZGEO+JiznsyhBmjZQvjk8YF18B+h1nDGvIgoLFG3sdhucoo4GG36WGuhhCg/l6qSmVb/tWR7HybaPOc4qZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733289467; c=relaxed/simple;
	bh=/j9L3IKU5s1T51c3E45wLDr83YA9hNQrWlUrtTtaFKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/Up4v4t+XS1G3h0yiJyjcJlGuE08rnVwY7FgZq7MHpLogiBsl3FLSW4ncJXwVAqetLbIAaB77PraKtMJJo7Q68MQSQvAIw3Uj9ekE0zxWwHf+f1kdY7zdBrkl5NWYbVJZcWWSsZPMIK5vg2T1LuY4p6R6t0UJtArWqrKSEI2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=olSbeEOR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/LWkJquf9jbtcNFnRwA6eEi+fdQ9o45ZwDSGvSg6WZY=; b=olSbeEORGvz3Tq/yHZol+J0dSD
	BjhvdCpt+OObzHgkYEPQK5sMN4hYRmUkCxsGoMP/lSNNqI2N7t5XdugFNEXuuf7Ks9zrnNk4Bl/WX
	F0st2XY6nHnKKHwL9WRUdlsyZtyX/2kjnUqV3YXBtWTxtudu8H/LAtXmxucYo6qUstZS8jRP2pnfU
	3o5DEsacHZi2ZDDxhn/QTGhRVMr8kBOoGrKj1ML5yB6XGH8bCpUAQ082YwKm3+Y44DJST4I69odPL
	3AHFrMWAb2+U04JaJNRWDoJKsvEbV8x3aSEjQ8tjtD6kckJ5H40I6mFFu0tN/15i5oGcN76++jw/M
	MO0w1E4A==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tIhlP-00GMg3-8M; Wed, 04 Dec 2024 06:17:27 +0100
Message-ID: <51eb6162-ebbf-4fbd-8422-f21ebf9726f7@igalia.com>
Date: Wed, 4 Dec 2024 14:17:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-4-changwoo@igalia.com>
 <Z0-WIkfltRm9b3ZN@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z0-WIkfltRm9b3ZN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


On 24. 12. 4. 08:37, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 11:28:00PM +0900, Changwoo Min wrote:
>> +__bpf_kfunc u64 scx_bpf_clock_get_ns(void)
>> +{
>> +	static DEFINE_PER_CPU(u64, prev_clk);
>> +	struct rq *rq = this_rq();
> 
> this_rq() is this_cpu_ptr(). Shouldn't this be below preempt_disable() if
> this function is allowed to be called from sleepable ops?

Thanks for pointing that out. You are right. I will change it in
the next version.

> 
>> +	u64 pr_clk, cr_clk;
>> +
>> +	preempt_disable();
>> +	pr_clk = __this_cpu_read(prev_clk);
> 
> Would it make sense to make the above rq->scx.prev_clk?

That will also work. I will change it as suggested in the next
version.

> 
>> +	/*
>> +	 * If the rq clock is invalid, start a new rq clock period
>> +	 * with a fresh sched_clock().
>> +	 */
>> +	if (!(rq->scx.flags & SCX_RQ_CLK_VALID)) {
>> +		cr_clk = sched_clock();
>> +		scx_rq_clock_update(rq, cr_clk);
>> +	}
>> +	/*
>> +	 * If the rq clock is valid, use the cached rq clock
>> +	 * whenever the clock does not go backward.
>> +	 */
> 
> Can you move the comments inside the if/else bodies so that "} else {" can
> stay on the same line?

Sure.

> 
>> +	else {
>> +		cr_clk = rq->scx.clock;
>> +		/*
>> +		 * If the clock goes backward, start a new rq clock period
>> +		 * with a fresh sched_clock().
>> +		 */
> 
> Can you please add comment explaining how this can happen?

Sure, I will add the explanation in the next version.


Thanks!
Changwoo Min

