Return-Path: <linux-kernel+bounces-540941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A5A4B6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA11890E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8381D95B4;
	Mon,  3 Mar 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G33aCWbA"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AE4A05
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972753; cv=none; b=T1/Qi5V6ZdnDuwRx+x24+EBu0ZEe6dV3SDMh0Ty15WkX/tBW4AdLyy5ynJWyXhAN3gF6VLbdHQWSqpQuXOYChoerqVtp/GrmAQwMKT8yiGsfZgRfjhn5d4SkcSIw/MryyRY1HesWxGnQR9Ip4D18dDt3nQ+I5KBt/3YqxVjVg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972753; c=relaxed/simple;
	bh=9HpN8YNbM1g+5HMgusPSZ6T6i/R2IPLHgnjcpfni1kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2y8UhW7OKU9NiVAyUkPf7oLzDpvRPvQWd5TJzD18tJYEqmayrLZroXK9hmSmP2sEMEAK9/HD/f6ECg4nyqXrKGFAY263mEdHmSf4VjFf78et2md1A25gNt0kB0KilPe7595b6put6gIbdqH3+vDwX/Sc+Ic3b7pplkFnxvksM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G33aCWbA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fee688b474so203360a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740972751; x=1741577551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKGzbVXfgyG8sHy3CMwzPi1s2SgLFm/W4scE3baWvx4=;
        b=G33aCWbASN6gexBfPNxv9/xJXx/oR+iI9I4cVJVuRaamiLh9FPh939JZk259AGlkaA
         qEF4t+7/HVPWTYVRbgZKN0Y7EPjpThUtwTgKHqPVcouHJ54GSCcSR22ml9Ir5/OHALXw
         CxTV4Mb9a7zdhfPJzsWAnco5s0v1G6YyjKI6zhE6bonpkg41CHV5ZhpsulvOcq5QLgCu
         oOS1fTrJPiDAq/UDbBrwExeqQgmGGiRL+yAc/QB2WCl2D5jIuyFBHnFKLNTtR14adzn/
         A9gKnQFeYfS2o4XGH97Fu6W06VCuQavq61Ji02mf2CEIsQn8/4R229W8CY4yYaHOwl18
         M2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740972751; x=1741577551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKGzbVXfgyG8sHy3CMwzPi1s2SgLFm/W4scE3baWvx4=;
        b=b/gels/aaJcHiC/pdBqpXsMzPuU9Q4zFRQUit1dREEjeQF1GIcvqQMfKrtFc5dRuq1
         S1unjiuQN+f3SkbS7Brcw08lHU54cIkIJ/v8LXUMXuJO3sHK4/UdNG0/wnvs72kvOA3B
         Mpehp4Xi+hO8hHtUagmDt7s9C15aTET4J/QkykqeuaUN9SFPlkjbdUzQW8SHIiKOv+gE
         lqedZciENEI7TGraxF/VCftjWKWGxDL7Ip3ibsQ6SkymQDBdjx6zllmhjNZF6ZfvnAOQ
         Ac6LwumS3sDBUASlHdqWn251AOcLqvBxkZlpTRSOH8WJpVXG2DDnj+vinsKTtf/9nb2h
         IDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGUKlYZF9Jtv3XI4hqedeOYGdabrzosbZFG0ATVyKUlHwWmyV0U18i/NjY27Pmaaib5YECACZreCuRxP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYWlm6lbvir1rm+MNN+jmS3Cr5qsXQKIvy59IYC7f2oXAvt99
	GLbYzh01mjojlqaVzN8nycMLrj5ohDBYxIXb8U1xgsmzJex/Qvv+r9gb0q2Fv98=
X-Gm-Gg: ASbGnctmExQhibAZdqk8HTW59o/UkNdeZFYin8qUo/2GgGCS87o1k74eNv8nkyA1HvW
	HxS8b7IgUPxEyQM0trXSnR+ON0gPeqGhcmyliZmvsBzvzZT5MKJ7zU3+4NLJ8Z+JcXpB55qt3SO
	U/9SEWtdJJUqIS4a5cZ3825Ob1u5PGxUSo76B/599QqiKstC2wufC3n/SQ/t6Dk54Nk4v6NkV3C
	Dpi7yH2vkr9ei7O7xYw6BgcqRijKS3ZWRK0h+E+PG1cPhW9o4FpdjxxT7LCtneNn1C23kjveuEd
	ax0VzWVcfTN0x+ZvbcE2Gv12fToG0esTBgHyxDoT9s1PzWsRKafTPQXZCkgp1whIHQWH
X-Google-Smtp-Source: AGHT+IFhoizGvM4lmwrFXDN5Y7DrMhPmLwqsNJT83KNbuYz0kwllV3EY1WYYzS71FHhg28mFSmBh9g==
X-Received: by 2002:a05:6a00:429b:b0:736:442d:6310 with SMTP id d2e1a72fcca58-736442d6578mr2294328b3a.6.1740972751390;
        Sun, 02 Mar 2025 19:32:31 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73634ed9d05sm3713682b3a.178.2025.03.02.19.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 19:32:30 -0800 (PST)
Message-ID: <3cc57824-4a99-4bdc-9283-ca73bdc2fa50@bytedance.com>
Date: Mon, 3 Mar 2025 11:32:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250227085815.18131-1-wuyun.abel@bytedance.com>
 <20250227085815.18131-3-wuyun.abel@bytedance.com>
 <CAKfTPtBj2xhVg1BA5q6cC57TFGVBtgz6bbKrWGkjStSUKdxpgg@mail.gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtBj2xhVg1BA5q6cC57TFGVBtgz6bbKrWGkjStSUKdxpgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 10:26 PM, Vincent Guittot wrote:
> On Thu, 27 Feb 2025 at 09:58, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
>> defines the behavior of SCHED_IDLE as following:
>>
>>   - no SCHED_IDLE buddies
>>   - never let SCHED_IDLE preempt on wakeup
>>   - always preempt SCHED_IDLE on wakeup
>>   - limit SLEEPER fairness for SCHED_IDLE
>>
>> and the 3rd rule is broken if !WAKEUP_PREEMPTION due to recently merged
>> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
>>
>> Although WAKEUP_PREEMPTION is mainly there for debug purpose to provide
>> a way to check whether a performance degrade of certain workload is due
>> to overscheduling or not, it is still kind of weird that we treat sched-
>> idle cpus as idle but don't let the non-idle tasks preempt the sched-idle
>> cpus in debug mode (!WAKEUP_PREEMPTION).
>>
>> Fix it by strictly following the aforementioned rules.
>>
>> Fixes: faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> WAKEUP_PREEMPTION seems to be still used so
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!


