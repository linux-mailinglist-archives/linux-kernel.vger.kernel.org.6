Return-Path: <linux-kernel+bounces-553720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB9A58E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD3F3AD4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BD223324;
	Mon, 10 Mar 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O2QQdpDn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0714A09E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595125; cv=none; b=P8s1/p+pNB5CWgONK45ZjERAeyHVRyCmegY9rfQLXc9ukDrO8ue5S1n0tZ+fLWvI+gMiYymfFDTOCI7vsfhD7HF3h14/ICuJuHxXMbodZcA6A40ZsecDmuXht5+dHVvhoAJvdidIiK3xsuVB5FaYPLMMgFIQ7yFeCyeW2eXYERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595125; c=relaxed/simple;
	bh=/XMuXx0eHugf0hYLANRWuLTsa6o7oUZC7L1a7+4z3zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=monzKFk+1OVu7sd+RtvMnmpCk/4X5hGp7dsuwZ4HjTdM0NLDWuN8z99e942C0FjD6Al6JTAxB2+irFT1D//b36xGPJlS0fb9rYjDrBS/UK2HV09lzi2rgrZTUj5gJlgFUBYRjzSPsNahqyU0731wJZ3CtGqQjanLGlmsqN9Q3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O2QQdpDn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22403c99457so7279385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741595123; x=1742199923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0gB0o9QOuboJgCNjHdh3ReTO3xBP1ywRnm0TOZ01nY=;
        b=O2QQdpDnmf60Z/tZn+N9XzB3ixGuzts7ZdVP6E0DpWWSKNpenwysZ9SVCTDJZi+GqG
         iDD7gfrHcdvToaz/qaGDK0LSv7uXLHAyR2H09rzqBjuCXVsRGY2JkQEqr0nBJQ4KEvHV
         vP59K+kHtRo4QaUxdF0iycdgDScDYJpdm2Z7pbzIleXPfzHkkMzNNy3Z1/q0MMlH9hzt
         oIURBRwJbxZmv2Fv+rBpqwoqc1cMZ7IE2vTIum6RAcml9Z2itwjz4UFSlzwtUvpCLlge
         GhIC5SYN7WZgDe33U7RGaY5H8AYCV86RDaDS+RowBQAznxInonj8SUKarAw4psSePI4Y
         ryIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595123; x=1742199923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0gB0o9QOuboJgCNjHdh3ReTO3xBP1ywRnm0TOZ01nY=;
        b=gpR93xOnIfgDLXE0kH+0xki5TOZSXZGkpe9CdGDTjqnn2KFCctbAlFVOLA2Ct0Pp+X
         DSFUdCd1hL6kZJtXUsHy35fN/2k7+UcMoH4Pi7jReN+NRGvk/P8venfcQebMaQoqHPjK
         DtIoxuQWgi0s4r5HtzLLTx0kwSo5mVDPwNc7wb1Hl93bQRDZ7XzlmZM+6YY2uP+o7YZl
         rDWBSORE+W+UrQ2hpqjJCSB1jjCSnhQwpWx1SpEMhjPDq9Cjpe7C5AUc8mIaKQG06KWn
         yZqJ8YEGvbHrIOgprDedz6VhLh19VfUCLLrfMjncQD+Q1SryqoHZOWlmGmO0jm6NSiJR
         fuiA==
X-Gm-Message-State: AOJu0YxpE+gXVf8NNtJbYQ9o7IohVeSoUBW37ZtRXVsHghhNeJS6VSqn
	1PqddgVO7Qd5D0qIvUTjQd5XiG0GC0XMnB+C4GXlty1PoQvGRdtezA0wGgY/qn0=
X-Gm-Gg: ASbGnct/3d9zhdWVGjjcigklqaKXVopQf2YQTLGZ4+6jJPdUSkFZJ5T5TZHJB8K1Ivf
	1HyakH0YzYpnOU3O7n4yQVnm2VWG8IqAvMaqYWGfnIMqmJ8dCTVwA3rWKLBsTMDvudZjnDKgl7B
	0elUOpc73LkKHz07UsPFeTOwfLjeQktx9+6/Kx64OyoslQsE2tui7T+L8BvzV5bPMsy+oFHRo5Z
	4Hm0fbBAE73lAqnV1eipHeFdTViTtMABqpPLZ46xe7Y4UxXwiOYF8/N3Xy2hgd9hq3juha1YlgR
	kdFqkUOtwCnz+VlABB0AP0IdRbSzRNndbi55nRnbMLjw1MPrYreFv0DwCn4JR5EYfBQ=
X-Google-Smtp-Source: AGHT+IEC0V9z3Tn11TmcTivoAoU9YgJUZuhwigVWpwZSaiuvVyVT5o29Vlwh9sb52jytzKLgjGWJpA==
X-Received: by 2002:a05:6a00:4fc7:b0:736:3222:c392 with SMTP id d2e1a72fcca58-736becb1adfmr5004146b3a.2.1741595122979;
        Mon, 10 Mar 2025 01:25:22 -0700 (PDT)
Received: from [10.254.33.33] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm4255818b3a.154.2025.03.10.01.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 01:25:22 -0700 (PDT)
Message-ID: <93f93abd-92ae-4daa-b1aa-3dd5081b4651@bytedance.com>
Date: Mon, 10 Mar 2025 16:25:15 +0800
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

loop Viresh Kumar

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


