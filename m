Return-Path: <linux-kernel+bounces-192201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC88D19E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C236B236CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035616C847;
	Tue, 28 May 2024 11:42:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91D16ABEA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896576; cv=none; b=UNWp7DXK3kqKyb/l24WH4Y+JDy4LOgqUTnCLnnsxXVtO2JHHOkYGc8duoh7FYrwTNHDY8bnRUS6oKcv1P0GNqc1Li44dkMCEjBp/ibzyKH0TxkUFe/0ZQFtH7GMccLIR3D/vaVsW6MyWZoUBwBEI3HD/suz4Q0/zf0jJeT+Mk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896576; c=relaxed/simple;
	bh=S0VJJBbE5kOXZ/KL0cz9wUfOzpd6ZFwGTVuAidGHwU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1RGXAnTc+UzcZMQdmxvYhW7+1MFAf/9RxWlZn3GGISHjjVT3V6kjJEVehDvjpllJ+qov/xj0CJZ/+Z+SaY9N+nWiU7xngtDjhGiG+jx4Rk4PfXBh+nwEYeTiu60TGU5f8lMQ0+lKepAI2neGlUqWUL4Yzjk/10usOQ8QUaJ8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0518D339;
	Tue, 28 May 2024 04:43:18 -0700 (PDT)
Received: from [10.1.36.57] (e133649.arm.com [10.1.36.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5593F762;
	Tue, 28 May 2024 04:42:50 -0700 (PDT)
Message-ID: <0387ac04-2dbe-4a73-975a-078a18554654@arm.com>
Date: Tue, 28 May 2024 12:42:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/6] sched/uclamp: Simplify uclamp_eff_value()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <6209eda0b134ad7a0be8855ffdd7b4c747fb8048.1715082714.git.hongyan.xia2@arm.com>
 <1f8c50f2-6530-49bd-9b41-744437078100@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <1f8c50f2-6530-49bd-9b41-744437078100@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2024 23:52, Dietmar Eggemann wrote:
> On 07/05/2024 14:50, Hongyan Xia wrote:
> 
> [...]
> 
>> +static inline unsigned long uclamp_eff_value(struct task_struct *p,
>> +					     enum uclamp_id clamp_id)
>> +{
>> +	if (uclamp_is_used() && p->uclamp[clamp_id].active)
>> +		return p->uclamp[clamp_id].value;
>> +
>> +	if (clamp_id == UCLAMP_MIN)
>> +		return 0;
>> +
>> +	return SCHED_CAPACITY_SCALE;
> 
> Why not keep using 'return uclamp_none(clamp_id)'  here?

Reason is that uclamp_none() is in core.c.

I could move uclamp_none() into sched.h if needed.

