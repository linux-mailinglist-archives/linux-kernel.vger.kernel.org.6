Return-Path: <linux-kernel+bounces-551366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1FA56BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DBF7AB87D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34722170F;
	Fri,  7 Mar 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZjbfzL1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E621CC63
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360325; cv=none; b=WBNxvxPl6IRERN02BnO8Hi4Hl+OuMHhEYm0s6Nzj9wD+zS40iRm8hM4kHzOAeOby4STKY1LBoAL6Eh8XeTps/uYFLWzbeF9QZL8AolQyEfe4JW0DMo8xeNa4cOlrbEVrehcOX6dLOMMNgMyGc9Lrf2NoXlQ5lePsGYeCutUVS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360325; c=relaxed/simple;
	bh=C9tM5TuLfhlgQvLUFBgkKrvHur7nfMZAswXEQogvyso=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xkk/of+9WYeb34yadY50Vf4ru+T8L7wPGd61to6xoAHA4hhYNfrXb9BLlwkYF21sTGnvLJk95clToaMugbd4jnryBpv0dl1dsdxctR490EI1A2jVR/5hIZgPdScJXaRoEKSd4tqNDhRpNledH0qSi5qJuc+woXLm3TjqGUbyML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZjbfzL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3S/y/ILHmIHApB88hRzIwz+jtFgRApUnIcM4kDcX/4=;
	b=eZjbfzL1vP53CI0D5hGHZ5amGfi/+6J5Shwx0q6tLsA/gfDFEUP3Wxs96YJaQdkzt8hdlO
	VaZhiHEOJCSgPibDhr6HmtkRXJ0vrN3x25+OZQkrNLe/wHdh6HUIQ+3pZ3iU5cLmsSdu7b
	/HJGpSBbJwol+VgvcUrK2srSNskGmic=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-IKWlySv6PD6XDR5jrgbvAg-1; Fri, 07 Mar 2025 10:12:01 -0500
X-MC-Unique: IKWlySv6PD6XDR5jrgbvAg-1
X-Mimecast-MFC-AGG-ID: IKWlySv6PD6XDR5jrgbvAg_1741360321
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b53373f7so512791185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360320; x=1741965120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3S/y/ILHmIHApB88hRzIwz+jtFgRApUnIcM4kDcX/4=;
        b=rOxx24VTcVOeg1WbC0aJWRemB/bLtotAhvHMkjVLkMhEAZ7ZWzyI5Gg2lqfB/DkIBr
         0WJT8Fgda2yBzzMvZXh9r8aBQuMvGB9xv9sOKRBjhZFm4t0rMJhokdCPIwgFRJdAeCsc
         pkh7gkONP9lRn15vzTc/T9WoiJFzWNK0PyikIwb8KUEM8dGAgLELlQ0FXTyBv/KkfZx2
         Kb4S43XT87Y3NB+BT+RAA6G4I/3Lkk4nuYP3PYsLLEK90xTs4B2/D9i4b52hGfIvIl6j
         IWM4v6sy7XiWgBYRcqhFi9nxPy+CguMS+IslhT1yYd9SQLEURhwyR979EROpNLa7qGUi
         DyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWoy22Ykw4vdqXScN2zRw6rICZKqiE3Jv1CA29X8yqt1f863K+qDwhqSTLfdD/MZtyjvOMUuj5cJNwdv4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IdVaR9pkN81JSLzpYguOqhgNrIBXY92bwhfMEa6sJrHZ3pJh
	9njuMktdYXy8TUbB9twFzDGx+nj30lQKjKHS19HMlOynIsGeGFW/d+7qoeEFS2oYr+49tdpSIKH
	RIEeVy0XOZI5oQ/kioKyPHGxHRKwVgo2dAbEPL+OrqUou0HM34/Gowd63c9B6pvTxyOgNWg==
X-Gm-Gg: ASbGncu971RqLufBm0DDdcJqzSJgecoLlatmSu6YwzuWNLqdoOLif2irgc0ZfLYz2eG
	wKfofu6uPHICg15XKc4Pb7+znH8+R3hPGG9qvX5Fi18U3CQUefgAzvD3jmYQta7ym6HWMjylcf7
	cT9lWLfPfR+Ko1zda+Eu2YuYx7kC3DgcKqYcRwlJMR5lMiHuk4my9Xue9i/JasIyjVvCH9eGLf0
	eottTNTf096Nr9/8VqTC71MxpoiRdCzqKNL26d6dq2tZmscN44ypPJjCM0ZfBBstC1eXNPXE2O3
	WOn8Oim9uf56F7P710sXceeSVTujrqZ0KgF8wM1y6k70ArJPxiPjjDfe5fI=
X-Received: by 2002:a05:620a:261f:b0:7c3:e457:853c with SMTP id af79cd13be357-7c4e61ed4a1mr577216785a.50.1741360320187;
        Fri, 07 Mar 2025 07:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKuw12OwEB6WB4+HUUfMD0cI7kHe8YYf7PqXIevfwUmXERTDQ2AcnR+rdUrcLqQxyKvb/9YA==
X-Received: by 2002:a05:620a:261f:b0:7c3:e457:853c with SMTP id af79cd13be357-7c4e61ed4a1mr577213785a.50.1741360319918;
        Fri, 07 Mar 2025 07:11:59 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm254283185a.6.2025.03.07.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:11:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Date: Fri, 7 Mar 2025 10:11:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Content-Language: en-US
In-Reply-To: <20250306141016.268313-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 9:10 AM, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>            either in that case
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/cgroup/cpuset.c  |  4 ++--
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/debug.c    |  8 ++++----
>   kernel/sched/topology.c | 12 ++++++++++--
>   5 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..d5f8c161d852 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -383,6 +383,8 @@ enum uclamp_id {
>   extern struct root_domain def_root_domain;
>   extern struct mutex sched_domains_mutex;
>   #endif
> +extern void sched_domains_mutex_lock(void);
> +extern void sched_domains_mutex_unlock(void);

As discussed in the other thread, move the 
sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block 
and define the else part so that it can be used in code block that will 
also be compiled in the !CONFIG_SMP case.

Other than that, the rest looks good to me.

Cheers,
Longman


