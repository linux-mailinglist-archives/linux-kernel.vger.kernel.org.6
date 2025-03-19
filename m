Return-Path: <linux-kernel+bounces-567866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C1A68B79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC296884690
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575C25522D;
	Wed, 19 Mar 2025 11:19:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67726482F2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383142; cv=none; b=tGZ9aD1djmaPM+/0KNFe6xsuKP6eafDI7ATi8ha9H3wcAoZgnPialVzQHWJPcwaMLvtJch1TgmTAkplPs7gI/SIlwuPSDcJtVsT/NULIGAX9WqKkGG5OfIdfqqAb5ye7CXtF8haJfusy731oIfWhWeqcUeHPzT21wNxaSA2LVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383142; c=relaxed/simple;
	bh=IXeQyYXcup9Cp8G9gPgPi3i1EnfTtTWZ/QE2GjXdGR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY5lxv7ujNug1sifrSiv0Ln4yfV9zYhAxDJJek7Izjs7NvPvTVcPkFumNAQqgSgacZAVD3jQb2C9ThMcFH9UiFjZCuwX8uozHXfZVC8QnHPY4RMN8D3OQTjEQx/DES0i82GcQBCr+n5tEUvZLd6BqRGdCVrH7BWmtPdic3QRovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20A0113E;
	Wed, 19 Mar 2025 04:19:07 -0700 (PDT)
Received: from [192.168.3.228] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9943F673;
	Wed, 19 Mar 2025 04:18:58 -0700 (PDT)
Message-ID: <30adb3ee-60d2-499f-94d5-0880e83c4403@arm.com>
Date: Wed, 19 Mar 2025 11:18:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/topology: Fix sched_is_eas_possible() prints
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ba823a10-3199-4702-8821-03dd88d45212@arm.com>
 <CAKfTPtCEEqjOw+5k9d9a-5P_iu5doNT65EiMmhdhXytDnXdmMw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtCEEqjOw+5k9d9a-5P_iu5doNT65EiMmhdhXytDnXdmMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:07, Vincent Guittot wrote:
> On Wed, 19 Mar 2025 at 11:59, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> Add the missing newline on two failure prints to ensure EAS abort
>> reasons don't go missing.
> 
> Would be good to have a Fixes tag
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

You're right, thanks.
It's
fa50e2b452c6 ("sched/topology: Condition EAS enablement on FIE support")
8f833c82cdab ("sched/topology: Change behaviour of the 'sched_energy_aware' sysctl, based on the platform")
respectively, so I'll split this to make backporting easier and carry
your R-b in both if you don't mind.



