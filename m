Return-Path: <linux-kernel+bounces-551547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B5A56DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59837A7E44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED7242904;
	Fri,  7 Mar 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKHier80"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A7241687
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365257; cv=none; b=hTr44h2DocQPeS+0w3CaTf9mkXzQdyXRePxKJKjhQyxZsSrcx90TPlF+IN3kNMi9/DXu9tXh1AdeaNVhzcjCmRdcbUO5CN4x9vMqkaqAwDvdtS5lSN5+T+bMAeCSY11ziPoqH4LDvCOXt19xZDydU8YjmD/NlprtyHmtj1z57V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365257; c=relaxed/simple;
	bh=H8uzd5peODCzukZg6jl5fU/M2HJxgbzQtlgwHrd4fKA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sKxIk0y8nyH1BkD2D/EhES+oUBoyLrb06jpE6C0Vq10ouBUbysBeNF4OULDlV68AFJCxWuOcCLhFDBSy2MBX411UsuTnFeufHLhUciENTvWpxHKJ8pY84K2kVRMKIXDqkMSafgTecmkROdAvKKsfO1r6CwCMn7fXPSRLySTEpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKHier80; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741365254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I29SMSMVFttr10Ul27KnYZOPsk3TfrDUd1/Dj5UPrMM=;
	b=UKHier80MdKMVCtsuXSSnTHaUKhuJ87vn5tVCMcBp9Yj0Y8idJlwn6SD8iMfjz5o0vKz+8
	oqGnjr3LsroQ4WPSe6vEN5x549j9IQoHgrc0+yIYKdZRu87e4vTUebU6KLmlBr1n9v35CD
	r3ZO1Kl6lRSXj2TBz/LjLhV6Gp1wvH8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-KGK7HEo3P2CzFH-0qPMYrQ-1; Fri, 07 Mar 2025 11:34:12 -0500
X-MC-Unique: KGK7HEo3P2CzFH-0qPMYrQ-1
X-Mimecast-MFC-AGG-ID: KGK7HEo3P2CzFH-0qPMYrQ_1741365252
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8ba7d884bso40557126d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365252; x=1741970052;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I29SMSMVFttr10Ul27KnYZOPsk3TfrDUd1/Dj5UPrMM=;
        b=eiacVt+95gELOhp8RJwvsmpPkYpOrNC9Hc0cCsPMJKemHIDhnFUZu8tGPWSOWMCZvi
         lpRNeNE2/sH9uIQsz7vPfprhB4zVnZffXsZzSQikQf8AfvKo7iL098JyGociOmFD+Iuz
         tU3NI322NsLpgWFUr5hU2ozASbyRoCX1ek5Z6semRI8U5FFcv9Pv358tRd2q1KLCqS6+
         ot8UYaWScMUqllqs3nBC7hD8uzdEPtYbk27FXXX9SdEEQkH63wDzHfpHXVcNCbQd2mL1
         u///RGdFMaDnAGXunMZ54D8yoGDK/cKgeECC5MAohLFX/RX5/P/eyzNEaLGSEmTVms7y
         Hvzg==
X-Gm-Message-State: AOJu0Ywe9MZJNoQ+Hv9MJ+aiUUBwWQBsWnIRPfohllA+BdYx+HT6rjlv
	1dsTHGcvev4tNEpURwwHcUYUkIn/6QATi6+MjDRv+jYEJtwS4exOwSsOiJl5RV5mr6ulueMF8nN
	KFJ8xDF0oWU/EFzKBz/fVk5OxsJrbmW/ZqiMmS4PNHyAfd3TsENmAXkFsy7sT2CaoOOd8fg==
X-Gm-Gg: ASbGncuufKRC21Q6j9OS/FhsIJlzYBdWyhOhgukbtMnSkVrxAVlyejig68QJpXDzqf1
	Ynxr3GiXBYi3b2NWJ9G1e9fPRlQUN4M8ZvVnhSThtabs4mFR9asAnXxHX6mUSLU3AqXADmJDTfm
	V1jnn4SVv5nIfaCdNEW55wduUYVENIseRE9bIMdUO9C7yefVnOkcUEzjjko4gllOhvLtBVFedRN
	dEj4mSHizemncXNi63a0hztO0XWv3N3poWK+e/QYqPXLACs6g7PyqufbsIU2i5erZhtBjRYZJiv
	5RKVkD1w4QHfwLjyH3I+tGMjkXQVAkClRYt2BSAfEqfZZ4kqMWWHA4pyZS8=
X-Received: by 2002:ac8:5708:0:b0:472:1814:3fc1 with SMTP id d75a77b69052e-476109b1b81mr46175881cf.31.1741365251784;
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyiT6kSkHsRD2rq0rc8kZ0edEmUm64eP/RfjPLUfuJmGieySNXWs5OYJHIRlasV7cNaGtGrA==
X-Received: by 2002:ac8:5708:0:b0:472:1814:3fc1 with SMTP id d75a77b69052e-476109b1b81mr46175551cf.31.1741365251451;
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9a89acsm22570861cf.44.2025.03.07.08.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:34:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67a401e5-6cef-4f4c-a31b-7c2793666e40@redhat.com>
Date: Fri, 7 Mar 2025 11:34:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
 <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
 <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/25 10:59 AM, Juri Lelli wrote:
> On 07/03/25 10:19, Waiman Long wrote:
>> On 3/7/25 10:11 AM, Waiman Long wrote:
>>> On 3/6/25 9:10 AM, Juri Lelli wrote:
>>>> Create wrappers for sched_domains_mutex so that it can transparently be
>>>> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
>>>> do.
>>>>
>>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
>>>> earlier for hotplug")
>>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>>>> ---
>>>> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>>>>             either in that case
>>>> ---
>>>>    include/linux/sched.h   |  2 ++
>>>>    kernel/cgroup/cpuset.c  |  4 ++--
>>>>    kernel/sched/core.c     |  4 ++--
>>>>    kernel/sched/debug.c    |  8 ++++----
>>>>    kernel/sched/topology.c | 12 ++++++++++--
>>>>    5 files changed, 20 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index 9632e3318e0d..d5f8c161d852 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -383,6 +383,8 @@ enum uclamp_id {
>>>>    extern struct root_domain def_root_domain;
>>>>    extern struct mutex sched_domains_mutex;
>>>>    #endif
>>>> +extern void sched_domains_mutex_lock(void);
>>>> +extern void sched_domains_mutex_unlock(void);
>>> As discussed in the other thread, move the
>>> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block
>>> and define the else part so that it can be used in code block that will
>>> also be compiled in the !CONFIG_SMP case.
>>>
>>> Other than that, the rest looks good to me.
>> Actually, you can also remove sched_domains_mutex from the header and make
>> it static as it is no longer directly accessed.
> Apart from a lockdep_assert_held() in cpuset.c, no? Guess I can create a
> wrapper for that, but is it really better?

I forgot about that. Please ignore this comment.

Thanks,
Longman


