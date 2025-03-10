Return-Path: <linux-kernel+bounces-554946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E4A5A3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37D3AC1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813C235364;
	Mon, 10 Mar 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhWfwzBW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE021422E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634342; cv=none; b=GMoGdJe+My/MOxPQ3UhjZre2E67hh7LRFiwAE3G5RLrm57MnRA8OdaQHcOQ7yW6RRvElCnAsIghac9GE0AOa3ZBP53DxjTfOtalntkus9t2492HcCtWLdzxfvsYasiVNjU5ZynAI7ty64UtmW6M6XmBE8WlbOnOyYIx1JIZp100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634342; c=relaxed/simple;
	bh=N3f+MEWxB77zkydBCDkoQHG5PkErqEqsIhPm+kg/w9s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JV/3aU/svee6StYPmgBvc461TZklv1+ywGYgXxWDerRcBSvpN4q3Cb0WIs7Lj1ZX+PFoboXKP3f5sbWffjWgtXZxnGK+XEEzgyfWlJWEmrvlJSQhiOcdUs92vHhFbAPQwZykAenbsPbnLxGjPOttSYJixF2Q6SX5akLncp2rigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhWfwzBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741634339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FW26yOeGd8FsUgqCXYMLoexwnJ+HSuO06Px25PwBcpk=;
	b=EhWfwzBWZ0QAmiI4zpAtam7zHhxwoQ1V3eXoNtMq5uFQSam5Lh3cgXsdEhVmcI7G+OlPcR
	c68TWkXkRXO0rmXoVXT7t1xXh3ulgjjkOYmCs7Okc0bvgmIdxxhQAddyi2YQMQAgSPNpOg
	ZkmfuQTyMhwoN71M3cTR5AdRVXLX2mI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-yupr7pkvPL2zuGn7l8XIDw-1; Mon, 10 Mar 2025 15:18:58 -0400
X-MC-Unique: yupr7pkvPL2zuGn7l8XIDw-1
X-Mimecast-MFC-AGG-ID: yupr7pkvPL2zuGn7l8XIDw_1741634337
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91d8a7183so25388176d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634337; x=1742239137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW26yOeGd8FsUgqCXYMLoexwnJ+HSuO06Px25PwBcpk=;
        b=fm7zfFgZ1NKzBMeOVCO+8Cg4kCKNTwmw61ZUkmJHY42TkjAFV2iKHrmGNF/vLJq2Bw
         Hdpukw960jfPHcN7MTjHV8lPrxH8nRvIE4aHRklKNbaSP79W9wgi92z2Q4+kD+ulWXoA
         bRFKfg8sDDh/nLz+fA2yK2laKe6sPtaGYjyQdVUGzRDHHsgmynJjJ9okmR/shHLIk0cb
         h+KK3V5iGlufz4KHnPBe/oU3e/z1AvvP+uBm11BdBJiX/rRqmUdEjlr4h/rhVeDZALPO
         qwWDh3bV4vi2VEJ4NkNlSy9DzA7GQJFFXWQEOJJl24j2tuLPEe5lyjyFjKcI/irYH/MT
         iFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqZLeIgJgX236Y93x7O4ULhWMiJFxmAirLk7joUeIrtY/Uf0nkwC6hPbP5kX2fDhPFmTNPX5pmGa3CYfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMLP4K9U8WK9S9vvar5O+iqXvbTTj/dPxj9ZoBEUBBr9XYPWn
	S9tMGZ+ZaTAC3DddbBwmlf1N0f+4nRNyeOoLyE+tS/r+WBkK/bzN+1YfRQ/npx381Vt7ee/0EWh
	bFp2KLjv4V5mQJtffz/71VGAUG5FZuIKeWbz8iu8oB6z8Ih4hfhwfgsHzTrcZzQ==
X-Gm-Gg: ASbGncvXxl1fINmf+g5qf80ohwJ3Y/4uD2carlOvU6C1ULOUfBQObZAx/d3EjMcxaCF
	b9hvCo73dS8XYlXVHcVeW3aGGg4O0lxuwLbWgjOqMMfWozsktKCPkDF4XYE34ADlQBHBgLC/ZCK
	m8ttccv9LxODqJhF0mcDqgGszfDhrfvew98zDzBZkAuKwZOPWnAccl/PcOu9PslDDPW27keK3eN
	jhQRf//XTLnFYhXiAG3jNYewg5m2idryHxNkvmTxM4Cri7Q1i9zjZmZkUoAdoRgJ2nKFjkEARgM
	VaLLKZ29gHWWzIsT0PFEPsF+3wmi4MXW/H+0NG5Jqg/ysuUyPgFm1iAFNHXK3w==
X-Received: by 2002:a05:6214:410f:b0:6e6:6b5b:e559 with SMTP id 6a1803df08f44-6ea3a698657mr14049726d6.34.1741634337552;
        Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5wDu/JAC3Co4zaR/Est4jAkafKsO8b40TLou1V9tXx1j18RmCBuNgwe9rhBlqLNlpqgqHGw==
X-Received: by 2002:a05:6214:410f:b0:6e6:6b5b:e559 with SMTP id 6a1803df08f44-6ea3a698657mr14049106d6.34.1741634337167;
        Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090904sm61851766d6.28.2025.03.10.12.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 12:18:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Date: Mon, 10 Mar 2025 15:18:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
Content-Language: en-US
In-Reply-To: <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
> On 10/03/2025 10:37, Juri Lelli wrote:
>> Rebuilding of root domains accounting information (total_bw) is
>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> Nit: Couldn't spot any arch dependency here. I guess it was just tested
> on Arm64 platforms so far.
>
> [...]
>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 44093339761c..363ad268a25b 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>>   	ndoms_cur = ndoms_new;
>>   
>>   	update_sched_domain_debugfs();
>> +	dl_rebuild_rd_accounting();
> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
> barf when called via cpuhp's:
>
> sched_cpu_deactivate()
>
>    cpuset_cpu_inactive()
>
>      partition_sched_domains()
>
>        partition_sched_domains_locked()
>
>          dl_rebuild_rd_accounting()
>
> ?
>
> [...]

Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be 
called without holding cpuset mutex.

Well, I think we will need an additional wrapper in cpuset.c that 
acquires the cpuset_mutex first before calling partition_sched_domains() 
and use the new wrapper in these cases.

Cheers,
Longman


