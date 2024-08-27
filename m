Return-Path: <linux-kernel+bounces-303010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB1960618
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B128478A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973919D880;
	Tue, 27 Aug 2024 09:44:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B26719CD0F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751841; cv=none; b=gFM83J9PyS8TWZhVumUSPxA4FNSoJImtKgpTyTmpJyPjJgDiwOGJgBfjTSy6+mYK1qqdbh/H/AMFla/9bHHXRN/riTyuMvI/D5L9zPvIoxTCRQeJ/++xZFMzQwcK3GkH4YpwfDHRsfGFe/K4h0iWUth5Es33Hd513XDoTvMue+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751841; c=relaxed/simple;
	bh=XWoEWPbC+uq4zMzhqbvJWEvDQnMd2PKrum0BcLRlbYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQPhKGbMDDUoyVUyfvmM8dJBEB4nqNu8918bqaCkfKX/CaexqlTL0JJbrt5P6fWnwG5d5uSnKOkbQo7JEtARIU6f9ebeRptyJYkrLf+OpYSrBkVnyEh4cfb/Np+Pg4lDJ6G6lb0io0sE7d07fBmGnPLrkcPZPdF0VKh64H3L7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986B6DA7;
	Tue, 27 Aug 2024 02:44:18 -0700 (PDT)
Received: from [10.1.31.53] (e133649.arm.com [10.1.31.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AC53F66E;
	Tue, 27 Aug 2024 02:43:49 -0700 (PDT)
Message-ID: <fcc48e7c-cb26-4f20-8875-19e30362c3b5@arm.com>
Date: Tue, 27 Aug 2024 10:43:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <c6a673d4-ee16-4458-bf68-8f75d5062984@arm.com>
 <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>
 <20240822155503.GC17097@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240822155503.GC17097@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2024 16:55, Peter Zijlstra wrote:
> On Wed, Aug 21, 2024 at 10:46:07AM +0100, Hongyan Xia wrote:
>> Okay, in case the trace I provided isn't clear enough, I traced the crash to
>> a call chain like this:
>>
>> dl_server_start()
>> 	enqueue_dl_entity()
>> 		update_stats_enqueue_dl()
>> 			update_stats_enqueue_sleeper_dl()
>> 				__schedstats_from_dl_se()
>> 					dl_task_of() <---------- crash
>>
>> If I undefine CONFIG_SCHEDSTATS, then it boots fine, and I wonder if this is
>> the reason why other people are not seeing this. This is probably not EEVDF
>> but DL refactoring related.
> 
> Thanks for the report -- I'll see if I can spot something. Since you
> initially fingered these eevdf patches, could you confirm or deny that
> changing:
> 
>    kernel/sched/features.h:SCHED_FEAT(DELAY_DEQUEUE, true)
> 
> to false, makes any difference in the previously failing case?

Sadly the issue persists. I'm seeing exactly the same backtrace on my 
Juno board.

