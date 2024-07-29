Return-Path: <linux-kernel+bounces-265791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D893F5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA08B226C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF49C1494AC;
	Mon, 29 Jul 2024 12:58:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB28148826
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257915; cv=none; b=AitdcW3scz1Q25OSc/2z2zbxkE42P5mI0wIyNLJI5BX600UWvpmQu1b6qc2CneMDXray5vYrd7PcANGpiLt5v5r4sWWET3H6oc9io2aWoCeaog5jDtOY0Op6jWOIAw9CW5NtUuCE0ZwDcqp1cM52zvQk1U4xxhH6EtiPIhK5oSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257915; c=relaxed/simple;
	bh=aaIeuc+dtQ03nN6NOvfTSDegfJz4w8kApyIznXrcVkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsiSUChyF+yfUQ5uFFEDYO595Z+kW6C4sTneiStVEc0hj6MpuOOxeOvHlX/sr2pmDbNEaRDpdtEK203YkEyDxfHLKfIFfKjqljEwnl5InPWb4B0AEgMB0qiIqWNlkxXC8W1jp0YXLhPNGHhjA/ooe/huphYpVvRGkeEqNXYDfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46TCwToP039528;
	Mon, 29 Jul 2024 21:58:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 29 Jul 2024 21:58:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46TCwTD2039524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Jul 2024 21:58:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <90a8e819-988a-4f16-831c-71a0f4631e96@I-love.SAKURA.ne.jp>
Date: Mon, 29 Jul 2024 21:58:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/28 1:54, Linus Torvalds wrote:
> On Sat, 27 Jul 2024 at 04:00, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> We could replace alloc_cpumask_var() with zalloc_cpumask_var() and
>> call cpumask_copy() from create_proc_profile() on only UP kernels, for
>> profile_online_cpu() calls cpumask_set_cpu() as needed via
>> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN) on SMP kernels. But this patch
>> removes prof_cpu_mask because it seems unnecessary.
> 
> So I like this one a lot more, but it actually makes me wonder: could
> we just remove the horrid per-cpu profile flip buffers entirely?

I dropped "profiling: initialize prof_cpu_mask from profile_online_cpu()" from
my tree so that someone can take this patch. Andrew, can you take this patch?
Whether somebody notices performance/accuracy problem by removing the horrid
per-cpu profile flip buffers will be attempted by a separate patch.

> 
> This code predates the whole "we have _real_ profiling", and dates
> back to literally two decades ago.
> 
> It's there due to ancient NUMA concerns on old SGI Altix hardware in 2004:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=ad02973d42f6b538c7ed76c7c0a5ae8560f65913
> 
> and I think it's past time to just take all this code out of its misery.
> 
> Nobody sane should use the old profile code for any real work any
> more. I'd be more than happy to just remove all the magic code and see
> if anybody even notices..
> 
>                   Linus


