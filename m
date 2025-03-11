Return-Path: <linux-kernel+bounces-556520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00410A5CB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A5917AB46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C026039E;
	Tue, 11 Mar 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EZIC0svS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A0260383
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711430; cv=none; b=hnRetsMfqUxBi07D98YDGj6HP/9NHq1AqkJx4gkNgG47yPsYCKn+J90n3CZSaOgrO6hvqZxOLBH21EMJ9ogfPqEmaZ3my7tRTMWo7WS3jRbDn33Yplev7O4uZ8kOWUBvDZh8xOAEe2cUp+U88TBcgN0LYcQh1PsbTUhXRzFoiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711430; c=relaxed/simple;
	bh=9gA/bdnk8ZzHPCFp68QBpPozxpHS5U6govbbmsu7pSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGnM43FRd2p7d9T8OqYm3pjo/3SoZqX4s0W3MaW5HsPr4SiUB/tDT8F4cvp5l1lUDYUQPQYAkn9KYP/UHR3ddsEE9b7Tn7+eVJMZX0VoTyCTyCXB2YmyLBdmDerS0igIzuYtBkFm0wqiIz/82qhaIWuTCp+IIVUpRhODb7CzBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EZIC0svS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240ff0bd6eso12065955ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741711427; x=1742316227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtDPI8Ma8CKYJvSmsJ89yrdXIJa4yOEuJo/99lfQz24=;
        b=EZIC0svSR6MWnSjckLg68b8g20goY4sbGrmI879M9KlfkGsx/jVTxOpjwehMUbCN5M
         wqZzTL4IefKG67AOmSFW1sDhaLudOqyHx/Oyv0CFP1o0VrAXIAvSBVsjz7Lc+tuObOZS
         T49savGL74khGm2lAsJW8lkPUs9tC9M6YUOQzwt0frRQ6z0UxFBzjpC5LNUwLn1BWulE
         4aT8dcZMfd8Skh6SED5mmWjGLvp2ViPHcDXMwmmkh+i0E77OgzM9+N2Qo+YYWXsYpiAc
         UdK3Ygc3hpOQGHAEFQ1Wy0BUhZThLDaBXUPv7Vqi+LrCcmF5UdieNjsFhllNvBjjThtt
         uRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711427; x=1742316227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtDPI8Ma8CKYJvSmsJ89yrdXIJa4yOEuJo/99lfQz24=;
        b=jfzWc0yAjDLooSPWZlbMKnGpDc41O0X7RfzqC2rGt+oxKPf4BXxcdKz4k+KwiCDhAc
         6bXOLfI8uDbtqY/xwo+uGD5NyVfGKJD6hjEvdlM1cDJ5eymeg826UMg9n/RpxWfu0qAl
         D6da5IEg0bIR/ChIkHy1fd0rYp4usKXLTdLG6FFDHTNhL6allAhFGwti3ctAcLDqLMB0
         QnyIhtzHoxZiGLSfppVWYkXXRpiqO8apvS3IhM35SuutDnttRybb8cmJ21BI1uxpN1Bl
         JFKPMYBFUa0ozWunx6Q63NKfkuzVkh4d5YTH9m2J6zwRqW+pgc4DNH5HTc/lE5ZYCw95
         WQfg==
X-Forwarded-Encrypted: i=1; AJvYcCVSqlf3v7MpAVrBIgtY11BbgqfteCqcP0afMo5saDub2pLrNkgOH4Eaalz2Siu6wpHzo13+VsjJWynJCyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oO8/E2UZx2MkGKyfqnsiO+3DPKYskUmKrLTPB5x9Itoa+WEC
	L/Lt3Sy/sBxMbVIv6bb3bi8qgQdkNNCEt7k3S6/wvYEii8QIniqSbrJmi++H0+w=
X-Gm-Gg: ASbGnctBgaswl9vcpj9SnAK++oY3lCAk4TpMhSm89teNBr7wGIf7iHU0eOqaZrsQ5kN
	qvyr/ty5EqikfMfB9CwvdOGhE55c7tzPbI0ob8tePMkvKBxpDsZaOEvUS8mtXnWUbGL1psEeJGa
	Ux+wNgabniUfVD+3ne15fAVByp3gJdWnyO9rGDg0QYyFajOuvRlASdO+15GNHvwc/wd26ZKfmZU
	ujT765PSujKjdNLqtjsJeRdCJo9CeHIO3m3eZpZ3yS9t+4W693T7imSAXdpuoanHbBeFySMwKO5
	2b4QHHLCVetLW/KonZfyg+NwOMqE23hE9lU2r4keBmPqCyFQkrGEvYGVEj3TcBprGm4=
X-Google-Smtp-Source: AGHT+IEN5y7M/lLL/f/eXFIg9hXlsHue3V3G+/HMpNFBFFNQHPhNFW6PBTNRv2DgtDGLsbOAdBBaGg==
X-Received: by 2002:a17:902:f610:b0:216:30f9:93c5 with SMTP id d9443c01a7336-2259326ed23mr23288955ad.6.1741711427268;
        Tue, 11 Mar 2025 09:43:47 -0700 (PDT)
Received: from [10.254.33.33] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91be9sm100010845ad.179.2025.03.11.09.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:43:46 -0700 (PDT)
Message-ID: <2c8c4cdb-e9b7-40f3-aa83-d82676641162@bytedance.com>
Date: Wed, 12 Mar 2025 00:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC PATCH 2/2] sched/fair: Do not specialcase SCHED_IDLE
 cpus in select slowpath
To: Josh Don <joshdon@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-3-wuyun.abel@bytedance.com>
 <CABk29Ns9wq+mB5mAfu72gi3RZkNdwzXmkZSq3FQpKkTEH23dgw@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Ns9wq+mB5mAfu72gi3RZkNdwzXmkZSq3FQpKkTEH23dgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh,

On 3/11/25 6:38 AM, Josh Don wrote:
> Thanks Abel,
> 
>> @@ -7481,12 +7481,13 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>>                                  latest_idle_timestamp = rq->idle_stamp;
>>                                  shallowest_idle_cpu = i;
>>                          }
>> -               } else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
>> -                       if (sched_idle_cpu(i)) {
>> -                               si_cpu = i;
>> -                               continue;
>> -                       }
>> -
>> +               } else if (shallowest_idle_cpu == -1) {
>> +                       /*
>> +                        * The SCHED_IDLE cpus do not necessarily means anything
>> +                        * to @p due to the cgroup hierarchical behavior. But it
>> +                        * is almost certain that the wakee will get better served
>> +                        * if the cpu is less loaded.
>> +                        */
>>                          load = cpu_load(cpu_rq(i));
>>                          if (load < min_load) {
>>                                  min_load = load;
> 
> This seems reasonable due to the case you describe. However, I'm
> wondering if you considered any heuristics here to help identify when
> a target cpu should really be considered sched_idle from the
> perspective of the incoming task. For example, in your cgroup
> hierarchy, if you have a cpu currently only running tasks in your
> besteffort container (and all cpus in the system are busy running
> something), then that cpu should be considered as a good target for a
> waking task in the "guaranteed" container, and not a good target for a
> waking task in the "containerd" container.  A simple way to do this

Yes, it actually did cost me several days trying hard to figure out
whether there is a proper way to achieve what you're suggesting.


Solution A
----------

Mark all the hierarchically idle task_groups by assigning a unique
prime, and define a tree walk starts from @n to root that contains
all the preemptable nodes.

	struct task_group {
		/*
		 * Set to a unique prime if at least 1 ancestor is idle,
		 * otherwise set to 1.
		 */
		u64	prime;
		u64	mul;
	};

	/* Called by sched_group_set_idle() */
	static void calculate_mul(struct task_group *tg)
	{
		struct task_group *curr, *iter;

		lockdep_assert_held(&shares_mutex);
		for (curr = tg; curr->parent; curr = curr->parent) {
			list_for_each_entry(iter, &curr->parent->children, siblings) {
				/* Can't preempt non-idle siblings */
				if (!iter->idle)
					continue;
				/*
				 * For each node in the subtree rooted at @iter do:
				 *	tg->mul *= node->prime;
				 */
				traverse_subtree(tg, iter);
			}
		}
	}

	int sched_idle_cpu(int cpu, struct task_struct *p)
	{
		/* rq::cached_mul caches rq->donor's tg::mul */
		return p->sched_task_group.mul % cpu_rq(cpu)->cached_mul == 0;
	}

With this we even can drop find_matching_se(), since it's quite easy
to know whether or not a sched_entity can preempt another. But sadly
task_group::mul will quickly get overflowed.


Solution B
----------

Since we do not require 100% accurate, solution A can be shifted to
using bloom filters.

	struct task_group {
		u64	key; /* A random number used for hashing */
		u64	filter;
	};

	/* Called by sched_group_set_idle() */
	static void calculate_filter(struct task_group *tg)
	{
		struct task_group *curr, *iter;

		lockdep_assert_held(&shares_mutex);
		for (curr = tg; curr->parent; curr = curr->parent) {
			list_for_each_entry(iter, &curr->parent->children, siblings) {
				/* Can't preempt non-idle siblings */
				if (!iter->idle)
					continue;
				/*
				 * For each node in the subtree rooted at @iter do:
				 * 	set_bit(bloom_hash(node->key), &tg->filter);
				 */
				traverse_subtree(tg, iter);
			}
		}
	}

	int sched_idle_cpu(int cpu, struct task_struct *p)
	{
		u64 filter = p->sched_task_group.filter;
		u64 cached = cpu_rq(cpu)->cached_filter;

		return filter & cached == cached;
	}

False positives are possible, but the possibility can be reduced by
optimizing blooming setup.

I chose the simplest way for now to workaround the issue we encountered,
while I am still trying to do something to get rid of sched_idle_cpu().
Thoughts?

> would be to do a find_matching_se on the incoming task and the current
> on_cpu task. That does have a drawback of cgroup pointer chasing in a
> hot wakeup path, so I don't love it.

Neither do I. But if we go through find_matching_se(), I think we need
this rq locked.

> 
> In any case, I'm fine with the change as-is, mostly curious if you
> gave any additional thought to the case mentioned above.

Thanks!
	Abel


