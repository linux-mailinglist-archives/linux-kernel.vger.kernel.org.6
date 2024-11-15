Return-Path: <linux-kernel+bounces-411249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0FB9CF531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A5B301EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348551E7C2A;
	Fri, 15 Nov 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzlIYWNT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA621E6DDD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699573; cv=none; b=rcN6nYno+aJ8ZdOBv3GNBIXjSvbbnBtfG0xrn5KHyvqCW91Qpf4lViIl/QyJnLGhEoja2aJYLHHxbsMr7B7L/KAiNBdnrR/66Y8Rj9xgSeFXJ2hmPo1Kq3AIG+JI8nV+d3LN4bdgMBu6c3FZqMuURvzbWOgil9XH2EITvKFm2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699573; c=relaxed/simple;
	bh=WO3LYlC8FSr1xkO83XWtsQbujZXokPiHKRNla+Yaq+w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S/rUFAhOc8z1T5kjYzDdzMbGgB4noEBQT6FaB6Rc7kfpi0SevTj6rNlXYL4UxULjifCZ9lYMqzDtrPbiJOkpsVdzW7bDQIolamcQXJjYGQMW4S7jWJX4cVezchrFVTR4WafBlDeXy6W15BlmLRfHnGmb39BHNOn2tZqqDOzvBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzlIYWNT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731699570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UClBQ2KNdutipp4WysPso+EwlbZECuwoqD14/Ir3Hzk=;
	b=YzlIYWNTiE1TiqT37VDMOeu9tvOLhhQMLE1Sg/7jnqmLfKBfnqWAidg3i73rUKFVwRyW9I
	coGyhTVaN4iuyGjL0dFCd4UnsfT1vbXGTKL32zROx8xAEs3gq8qislUwkXFfjN95Yfo2OJ
	AnYrjcwxMPTE66N7AOINvkqhj8xPDio=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-NJ2DuhlkNNqyvI8-Paiuig-1; Fri, 15 Nov 2024 14:39:29 -0500
X-MC-Unique: NJ2DuhlkNNqyvI8-Paiuig-1
X-Mimecast-MFC-AGG-ID: NJ2DuhlkNNqyvI8-Paiuig
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d3729a555dso13718256d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699568; x=1732304368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UClBQ2KNdutipp4WysPso+EwlbZECuwoqD14/Ir3Hzk=;
        b=ay9r/Yc4+i/5YA6f+RBzEqUio//lUPLELO2YaARrlB59Tc+NH11BAtkADC416S2cUF
         k7BBxGQx8Zy40j3M5reUwRhcwQDJLfgNrJWfaOtXMphbjT+JN7oo1wXB91FQhwtF7exF
         CWw9YzbiNb9TSHvIPBQH6zZCGp0/geifkZirxxQn78A8N8Cg5npsjqFE2r9nSlJCiQB7
         gUro22ZOoMAsYgmAA26YJot2l3fq/MXztE0lCn804RUQZkujqEK34teIpc2vVeaDT3fl
         oN8e22cB2QNCo26t+jg7HVMOOu6nl/QvxI7rb3zpiO8OzdooPAed7oyL7fbGDfwFX2Ot
         rY4A==
X-Forwarded-Encrypted: i=1; AJvYcCUwYrRRFdSfCl5sip+3lTW+xLP2nyHxD9auE+b7hdRe1OV0A3Tiu9tL9J7mQJJDLqAOA4G6P1qjt5uP9dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpnXYGLd+6mfOt9qMfY8PTvriAJwNjTTlBpO4LbuOnZnOSjzk
	MipHK81ZlHNPV9diBrFSVb0MHWvt+FAEsTJszQbudode9A8eG6ulFdOqDq1yezPjmv2WMIWu9TM
	n8Ayf6HaZukYHWFsXq7nhe9c/1EGs+KUArO3JTEOZn73dF2CHuPDScvCAn5f4cO2b2qzTmA==
X-Received: by 2002:a05:6214:2f88:b0:6cb:e648:863e with SMTP id 6a1803df08f44-6d3fb8ba0f9mr46216276d6.43.1731699568640;
        Fri, 15 Nov 2024 11:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGrxzNmraREqVUm7K5CU2tJS7fblvy+gMXPvXZnyUMgQphs5y6h+rRaDxtiXgBL0PePCmXyQ==
X-Received: by 2002:a05:6214:2f88:b0:6cb:e648:863e with SMTP id 6a1803df08f44-6d3fb8ba0f9mr46215966d6.43.1731699568234;
        Fri, 15 Nov 2024 11:39:28 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dbe1491sm224006d6.2.2024.11.15.11.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:39:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <896fe0bd-41a1-4613-a3f7-f3ccf80d880c@redhat.com>
Date: Fri, 15 Nov 2024 14:39:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Daniel Wagner <dwagner@suse.de>
References: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
 <f5241a1d-9753-4c95-b633-067ecda50c10@redhat.com>
Content-Language: en-US
In-Reply-To: <f5241a1d-9753-4c95-b633-067ecda50c10@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/24 2:32 PM, Waiman Long wrote:
> On 11/15/24 10:45 AM, Michal Koutný wrote:
>> Hello.
>>
>> I recently liked the idea of considering isolated CPUs a static (boot
>> time) resource and only use cpusets to place (or remove) sensitive
>> workload from those selected CPUs depending on current needs. (Yes, this
>> may not efficiently utilize the isolated CPUs when reserve them based on
>> maximum needs of a node.)
>
> Thanks for taking a look at this.
>
> Yes, I am moving in this direction too. Boot time statically isolated 
> CPUs have better isolation than is currently possible if we do it 
> dynamically at run time, though we are trying to close the gap.
>
>>
>>
>> On Wed, Aug 21, 2024 at 10:23:11AM GMT, Waiman Long 
>> <longman@redhat.com> wrote:
>>> This patch is a step in that direction by making the housekeeping CPU
>>> mask APIs exclude the dynamically isolated CPUs when they are called
>>> at run time. The housekeeping CPU masks will fall back to the bootup
>>> default when all the dynamically isolated CPUs are released.
>> But when I look at it with the dynamism in mind, I would expect that
>> some API like housekeeping_setup_type(), i.e. modify the set of isolated
>> CPUs are requested and leave it up to the isolation implementation to
>> propagate any changes to respective subsystems. And return an error of
>> type contains a flag for which dynamism isn't implemented yet or not
>> possible.
>
> There are currently 9 different hk_type's defined in 
> include/linux/sched/isolation.h. We are now trying to reduce their 
> number as some of them cannot be set independently. See [1]. I am 
> thinking about doing dynamism in the best effort basis. Of course, we 
> could expose some information about what aspect of dynamic isolation 
> can be enabled at the moment, if necessary.

Forgot to put the link.

[1] https://lore.kernel.org/lkml/20240921190720.106195-1-longman@redhat.com/

>
> Cheers,
> Longman
>


