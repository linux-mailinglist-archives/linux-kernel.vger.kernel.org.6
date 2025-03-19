Return-Path: <linux-kernel+bounces-567381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA19A6854A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFEA3A593E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCD212D8A;
	Wed, 19 Mar 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ARSwhbAw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6AE552
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367165; cv=none; b=Kr4gLqG9BkNyQ3hz6WZb2w7uubTY1VADJ3B0bBV0hd5U4H8SNzNqMuRp9Xt/BwjQ9J40Q6UJXWJ0WkozKAAZmpRe22L7OA1p0FibN4xQwYD/1uGz7eZhJAMHSrlZCZFe+pUjYVDhApCwqTdsdsJ8maH1h7AXSee4rU6IFfwItRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367165; c=relaxed/simple;
	bh=sYDIOGlrdK3h2JvEezS+j42TYfmnBRNO5nikVowEROM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2+HFoPY/8H0MO3LAH9iYfS7rkJDvRZC4oJbfvC/xfzh5viNXxz+ZSzmPqJ7IOUNeMWKqXdH8LTKDkDRb27u7MPdiiPaWwPTNck70rRHrMmJxfTyVTO8D7W9d0UeSLf8Y5JVALQK/OUmkXFS5ooYiq05FKOOQk9ponNG73oPd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ARSwhbAw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22400301e40so16787205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742367161; x=1742971961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4APPNUu4N0j5NTvHk2iL+eedm0KhNNDCeenHwPWNnC0=;
        b=ARSwhbAwHGBy2J1FCT05ge8kgp7cUHWwmhQew4wDoSa0RC1f9f2Uxgg8c3X0/b2I+3
         QKKL8nwhJ3ziOiUucmduJMQLhnKn4NCMjH2QDJMNCPMt4XrzThbLKrUkMX0MPQXl5ZGZ
         f8B/eVfkDf2wWbcfTfqL9j/P+oalzBJwzSWdm+58oaKEFvZZNl7azyb8dyjnaOuIoxgW
         bCBsIfH2ZLRNTlqEFJwt+/IAODNVuoj8T3i3kp65ViSOiaf9VHHYNGNEvAB0QkjLfSCA
         RGM5z5KRcizdfTK7/NNE+gGpJcN1PpIq8NZPuHqgHnlrhVIMScQw5UqbmOyqpDOH9R/G
         OMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742367161; x=1742971961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4APPNUu4N0j5NTvHk2iL+eedm0KhNNDCeenHwPWNnC0=;
        b=Oy/3cPGuJbL5yxRV5DzgNedVKAmFI3hiyAk9AkyXMYxzCWzySzC56oTVhTLrR1scH0
         Jx9nI+0JmaIuFactg4IOwZsldlnB8fK0+y50nt8ecbeM/tK25Y+nbbiLahOV0lm26Rt5
         ycrbvzlvbYlm+2NFceOiudAZpyvr0Ed/KYQ3JHej9GtPh4CreL7Huwme8zWmXPmiFcza
         Jf3q22xzGF5r//V6Q0IENS/zWi6my8ruk769mzPONpwbw04IYlrSP6ec7TSx8k/80ojJ
         ldK7MkQcrTMNcWXQr1w1MRIybmHsqJDBsFAF2U/JVXpG4NjC5CkZWMkfaIuf4Z/+GKBd
         dviQ==
X-Gm-Message-State: AOJu0YwpifyWq5SrPLVwq+yd72mq0qon1t2TzDgoA5+7JgLCgK0H7apW
	OFS4fMmXyk9PQGFH1wOXx3diDpV6Ehb3vSB53dubtQkwokmiYhCu7wD3OxkzcQM=
X-Gm-Gg: ASbGnctoUML7Qr6Vc0DWvWWTOCR8m+NMjxbt+592PM6q/TVPwZGo/bwDYQK7BnLd9j3
	8AXG9y11UiMOTNLOlf5tubphjzogiuq3MxmzdOVnzxG1qfly7/+116D0GxDjP/bMIEhubWhNoXV
	iIO4WBmtBBFPqLNEBeW5C59fNZ3nJx9kOt3Z7kMbJltTtV//qUgM4n769tYlAu7pZLyGiPS9/59
	JHMQGCU6kg7xwEtZgGPz5avsm8Y9pb9kb/r/J3+uQetdQkNdVr9NW3D1ZoPWX87t6HC4Wi2Acxl
	xIx63DvFAYt9bySljnS6KTJ5FIrCfi5LIif51Bk1jk3alukfirQrHsF6Eg7T0Zeg5p4=
X-Google-Smtp-Source: AGHT+IG6wlSQFDt9sIQE06SyCOhxxFtSp/BP/IoalOE17F6C1A4LlXMSucfvAL6rrinGb9DCGlBqkg==
X-Received: by 2002:a17:903:440c:b0:224:8bf:6d83 with SMTP id d9443c01a7336-2264c601f53mr6927365ad.8.1742367161265;
        Tue, 18 Mar 2025 23:52:41 -0700 (PDT)
Received: from [10.68.122.94] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5bf8sm105823945ad.253.2025.03.18.23.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 23:52:40 -0700 (PDT)
Message-ID: <243bc12f-2a0b-485b-87fe-43fc66d92c84@bytedance.com>
Date: Wed, 19 Mar 2025 14:52:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Prioritize idle cpus over SCHED_IDLE ones
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250310074044.3656-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping :)

On 3/10/25 3:40 PM, Abel Wu wrote:
> Since commit
> 
>    17346452b25b ("sched/fair: Make sched-idle CPU selection consistent")
> 
> the SCHED_IDLE cpus are given equal or more preference over idle ones in
> fast- and slow-path of select_task_rq_fair(). This works well in flattened
> cgroup hierarchy, e.g. all tasks running inside root cgroup, but may not
> ideal in a deeper hierarchy where SCHED_IDLE doesn't mean anything between
> entities whose parents are different. Hence a SCHED_IDLE cpu does NOT
> necessarily implies any of the following:
> 
>   - It is a less loaded cpu (since the parent of its topmost idle
>     ancestor could be a 'giant' entity with large cpu.weight).
> 
>   - It can be expected to be preempted by a newly woken task soon
>     enough (which actually depends on their ancestors who have
>     common parent).
> 
> As a less loaded cpu probably has better ability to serve the newly
> woken task, which also applies to the SCHED_IDLE cpus that less loaded
> SCHED_IDLE cpu might be easier and faster preempted, let's not special
> case SCHED_IDLE cpus at least in slowpath when selecting.
> 
>    [ Plan to try the same in SIS, that is selecting a less loaded cpu
>      and get rid of ambiguous sched_idle_cpu(). Comments and suggests
>      are really appreciated. ]
> 
> Some benchmarks are tested in a Intel(R) Xeon(R) CPU E5-2650 v4 machine
> based on tip/master ec3106906cbf, and are tested in following two setup:
> 
> 		(t1)			(t2)
> 		root			root
> 		/  \\			/  \
> 	benchmark   noise	benchmark   X
> 					     \\
> 					     noise
> 
> where noise comes from a SCHED_IDLE cgroup. I didn't see an obvious diff
> in hackbench or tbench, but not schbench.
> 
> 				vanilla-t1	       patched-t1
> Lat 50.0th-qrtle-1         8.00 (   0.00%)        8.00 (   0.00%)
> Lat 90.0th-qrtle-1        13.00 (   0.00%)       13.00 (   0.00%)
> Lat 99.0th-qrtle-1        19.00 (   0.00%)       18.00 (   5.26%)
> Lat 99.9th-qrtle-1        22.00 (   0.00%)       22.00 (   0.00%)
> Lat 20.0th-qrtle-1       257.00 (   0.00%)      259.00 (  -0.78%)
> Lat 50.0th-qrtle-2         8.00 (   0.00%)        9.00 ( -12.50%)
> Lat 90.0th-qrtle-2        13.00 (   0.00%)       13.00 (   0.00%)
> Lat 99.0th-qrtle-2        19.00 (   0.00%)       19.00 (   0.00%)
> Lat 99.9th-qrtle-2        23.00 (   0.00%)       24.00 (  -4.35%)
> Lat 20.0th-qrtle-2       484.00 (   0.00%)      434.00 (  10.33%)
> Lat 50.0th-qrtle-4         9.00 (   0.00%)        9.00 (   0.00%)
> Lat 90.0th-qrtle-4        14.00 (   0.00%)       14.00 (   0.00%)
> Lat 99.0th-qrtle-4        19.00 (   0.00%)       19.00 (   0.00%)
> Lat 99.9th-qrtle-4        25.00 (   0.00%)       24.00 (   4.00%)
> Lat 20.0th-qrtle-4       877.00 (   0.00%)      857.00 (   2.28%)
> Lat 50.0th-qrtle-8         9.00 (   0.00%)        9.00 (   0.00%)
> Lat 90.0th-qrtle-8        14.00 (   0.00%)       15.00 (  -7.14%)
> Lat 99.0th-qrtle-8        20.00 (   0.00%)       21.00 (  -5.00%)
> Lat 99.9th-qrtle-8        26.00 (   0.00%)       26.00 (   0.00%)
> Lat 20.0th-qrtle-8      1698.00 (   0.00%)     1598.00 (   5.89%)
> Lat 50.0th-qrtle-16       10.00 (   0.00%)       10.00 (   0.00%)
> Lat 90.0th-qrtle-16       15.00 (   0.00%)       15.00 (   0.00%)
> Lat 99.0th-qrtle-16       20.00 (   0.00%)       20.00 (   0.00%)
> Lat 99.9th-qrtle-16       28.00 (   0.00%)       27.00 (   3.57%)
> Lat 20.0th-qrtle-16     2900.00 (   0.00%)     2860.00 (   1.38%)
> Lat 50.0th-qrtle-23        9.00 (   0.00%)        9.00 (   0.00%)
> Lat 90.0th-qrtle-23       15.00 (   0.00%)       15.00 (   0.00%)
> Lat 99.0th-qrtle-23       49.00 (   0.00%)       28.00 (  42.86%)
> Lat 99.9th-qrtle-23     1602.00 (   0.00%)     1458.00 (   8.99%)
> Lat 20.0th-qrtle-23     3796.00 (   0.00%)     3804.00 (  -0.21%)
> 
> 				vanilla-t2	       patched-t2
> Lat 50.0th-qrtle-1        10.00 (   0.00%)        9.00 (  10.00%)
> Lat 90.0th-qrtle-1       271.00 (   0.00%)      272.00 (  -0.37%)
> Lat 99.0th-qrtle-1      1013.00 (   0.00%)      793.00 (  21.72%)
> Lat 99.9th-qrtle-1      1998.00 (   0.00%)     1642.00 (  17.82%)
> Lat 20.0th-qrtle-1       262.00 (   0.00%)      262.00 (   0.00%)
> Lat 50.0th-qrtle-2        10.00 (   0.00%)        9.00 (  10.00%)
> Lat 90.0th-qrtle-2       531.00 (   0.00%)      510.00 (   3.95%)
> Lat 99.0th-qrtle-2      1034.00 (   0.00%)      933.00 (   9.77%)
> Lat 99.9th-qrtle-2      1846.00 (   0.00%)     1614.00 (  12.57%)
> Lat 20.0th-qrtle-2       517.00 (   0.00%)      517.00 (   0.00%)
> Lat 50.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
> Lat 90.0th-qrtle-4       523.00 (   0.00%)      494.00 (   5.54%)
> Lat 99.0th-qrtle-4       973.00 (   0.00%)      901.00 (   7.40%)
> Lat 99.9th-qrtle-4      1618.00 (   0.00%)     1606.00 (   0.74%)
> Lat 20.0th-qrtle-4      1015.00 (   0.00%)     1001.00 (   1.38%)
> Lat 50.0th-qrtle-8        11.00 (   0.00%)       10.00 (   9.09%)
> Lat 90.0th-qrtle-8       527.00 (   0.00%)      454.00 (  13.85%)
> Lat 99.0th-qrtle-8       931.00 (   0.00%)      901.00 (   3.22%)
> Lat 99.9th-qrtle-8      1598.00 (   0.00%)     1582.00 (   1.00%)
> Lat 20.0th-qrtle-8      1738.00 (   0.00%)     1666.00 (   4.14%)
> Lat 50.0th-qrtle-16        9.00 (   0.00%)        9.00 (   0.00%)
> Lat 90.0th-qrtle-16      410.00 (   0.00%)      243.00 (  40.73%)
> Lat 99.0th-qrtle-16      979.00 (   0.00%)      891.00 (   8.99%)
> Lat 99.9th-qrtle-16     1486.00 (   0.00%)     1470.00 (   1.08%)
> Lat 20.0th-qrtle-16     2708.00 (   0.00%)     2708.00 (   0.00%)
> Lat 50.0th-qrtle-23        8.00 (   0.00%)        9.00 ( -12.50%)
> Lat 90.0th-qrtle-23      454.00 (   0.00%)      303.00 (  33.26%)
> Lat 99.0th-qrtle-23     3228.00 (   0.00%)     2564.00 (  20.57%)
> Lat 99.9th-qrtle-23     5496.00 (   0.00%)     5304.00 (   3.49%)
> Lat 20.0th-qrtle-23     3132.00 (   0.00%)     3156.00 (  -0.77%)
> 
> Abel Wu (2):
>    Revert "sched/fair: Make sched-idle CPU selection consistent throughout"
>    sched/fair: Do not specialcase SCHED_IDLE cpus in select slowpath
> 
>   kernel/sched/fair.c | 40 ++++++++++++++++++++++++----------------
>   1 file changed, 24 insertions(+), 16 deletions(-)
> 


