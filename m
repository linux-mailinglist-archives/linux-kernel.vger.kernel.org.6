Return-Path: <linux-kernel+bounces-511340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650DA329A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01BF1640D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40120B801;
	Wed, 12 Feb 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QtiL1o5f"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C82116F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373306; cv=none; b=WZr5dwMsSuaEYuf8iZIJt+TQbWUFGnMSY12t05+qm/KwkjO276pAAb0jQ+JnNQx20f86j+Gff+FoqXwRRfuGOBbiGqbX7wABLZic7G7qupMH5e9wFua0KQA4+G2SJmo23S3RugBzvf6DIlc918eC4EFGg4sapwecZsUANyMcr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373306; c=relaxed/simple;
	bh=UKSI6EDytSdjdgykF5MQAulLMhQVp1al45tKOJnsdH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPIceKOYpCMAM57V4nKuIrJlubkcqavnRNOyy82CAnFCgCqJu+w0q6X+TVcZjUqEt5TfzixGCEdpHcN1J4rp5VXplJkXeYzNPAwhr/uHe5c8L+O7fP6XBJGUb+kAMRT6tS2+xGG5zuEK4zf+PJYD4b4E0MXGpWJ3LCE8aAeqlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QtiL1o5f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220cd9959f6so364985ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739373304; x=1739978104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljlNJ9UmDZpoTWF1Xq95Z534XH7s9JC+28dFI3VXtdY=;
        b=QtiL1o5fqu/nFwGQkhRUAbMFBMr2j7j+IJMele+Y/ilWf46h53pfx/2CBq/OskzUEX
         mDk6n4g+gG8XUFPYCcxRT1K2o9Tt/CYGha8v5RU6VBpL9CYt9fz4qh8ukfHgsYDvhpNs
         YS1fhaAdnxzLPmWTsBQFwg/ZSn81YY2to/J1WyWxCbGLaUH+Ahl8wMbiE0DzMrgqMeD6
         aGDWSgVhTcBppWgvKsa7a/T/vVXhVbI1OtDYMqDFXUKeMY2uSrtaNQjsucqOZgvS2l4j
         GlQapwQ58YJRg1CGPhjMszqS0876cbX9GNA2HPgyzu/Hm+6E3/kZ5DrQ8Evu1RhZ5cgt
         Ce5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373304; x=1739978104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljlNJ9UmDZpoTWF1Xq95Z534XH7s9JC+28dFI3VXtdY=;
        b=qXvtPtXZcJ+z5dXatXvpVvzjJAsd75vzYf5mi4nFY8XuERZP9Ad+R+R5qSChmFkrcp
         r8ygOPLs5rP8hmocXdLI0wXa20esq9WeNBvqCKod55/VxGDXLd178obkaJrqt5OHHCqd
         Aplm/qMgoSl2DJi6JWfxt4LReDK9QOWXkydy3ovjuREkKKhplK6PfZYcgAmJ1H8nO6tc
         ZzO/0njjRHGYGB3T2pImpyeIM4hX+asi6ZI1Z2RyZApLgPZAbUXNStGt2Q1dWJf6lkYp
         +BdwKA2kVtJdaJkF+mUmCaovNgJ6BAKH0rhVA9Za+SHfdDwq0TwdZ+E8dCATmaA2qXv+
         BvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCF7g5kKdImd1REdPvk9sX54EUMYdyucmkzBcQQRmfi3W7e/2oPlrYGFjN+PhH37E67lS2uOqmfJw5VH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08QFDZH9631HQ6vi9Ahw2KLyU0ZDGv2sKimuc26mfj5su/lzn
	zqMX5R5TigvRP03bL/aDW/q9xFQJ8cak+qvErhYjK+4horsMHNkMmKf5n715P5c=
X-Gm-Gg: ASbGncsLaoluH5rnN5q+5LBmIgGoJy+xoIFaYK+bwSu7c/8TQTOk44mATjTADD1i49s
	hSdpSbtXEFURfUcohK9ELyO5OyZap8rZy+ZB3bvWrFjswMTohvaxWsSXLoBa+PFsm8dg121WkUi
	trujZiHkiV3bNrNWsSbThNGPbsqB2SgLJHm/6X+kuLnASpAM5IBeNtCR42FYVYW6dV7g7kKD4um
	6ySNX/lN6zSNs+7JMuSN6hjxiJcxIoVWeKEGqpr7M9dGGptEWxJ3CYALaGBpGAK5pT/7kl0dcll
	sTGmWKpwHHaTHNk1W5bBaOFMapBCtY8nu9hr
X-Google-Smtp-Source: AGHT+IGMKZH7Pjm+B4qQMXXr8SYftdRnx3TSgwBf542/KSP2GU0FH9uQfkBy0KRoBLo407PBjmHRWg==
X-Received: by 2002:a05:6a21:a46:b0:1ea:e7be:ff07 with SMTP id adf61e73a8af0-1ee5cd189aamr2473323637.6.1739373304086;
        Wed, 12 Feb 2025 07:15:04 -0800 (PST)
Received: from [10.4.234.23] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad2809sm11229424b3a.58.2025.02.12.07.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:15:03 -0800 (PST)
Message-ID: <b4ae80bf-36b4-4f31-96ad-6876372c91a2@bytedance.com>
Date: Wed, 12 Feb 2025 23:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for
 cgroups
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu
 <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
 <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
 <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
 <Z6onPMIxS0ixXxj9@slm.duckdns.org>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Z6onPMIxS0ixXxj9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/25 12:20 AM, Tejun Heo Wrote:
> On Mon, Feb 10, 2025 at 04:38:56PM +0100, Michal Koutný wrote:
> ...
>> The challenge is with nr (assuming they're all runnable during Δt), that
>> would need to be sampled from /sys/kernel/debug/sched/debug. But then
>> you can get whatever load for individual cfs_rqs from there. Hm, does it
>> even make sense to add up run_delays from different CPUs?
> 
> The difficulty in aggregating across CPUs is why some and full pressures are
> defined the way they are. Ideally, we'd want full distribution of stall
> states across CPUs but both aggregation and presentation become challenging,
> so some/full provide the two extremes. Sum of all cpu_delay adds more
> incomplete signal on top. I don't know how useful it'd be. At meta, we
> depend on PSI a lot when investigating resource problems and we've never
> felt the need for the sum time, so that's one data point with the caveat
> that usually our focus is on mem and io pressures where some and full
> pressure metrics usually seem to provide sufficient information.

It's interesting, as we also find that PSI is of great useful in memory
and io and never thought of aggregating them across CPUs. With my limited
knowledge, I guess it's because they have shared global bottleneck. F.e.
a shortage of memory will put all the tasks of that memcg in same situation
no matter which cpu they are running on. And the io issues are generally
caused by legacy backends which have poor performance, that is lower speed
or less hwqueues, so still contend with each other outside the scope of
cpus. While the scheduling is different, some cpus can be much contended
than others due to affinity constrains or something else, since different
cpus have separated bandwidth.

> 
> As the picture provided by some and full metrics is incomplete, I can
> imagine adding the sum being useful. That said, it'd help if Able can
> provide more concrete examples on it being useful. Another thing to consider
> is whether we should add this across resources monitored by PSI - cpu, mem
> and io.

Please check my last reply to see our usecase, and it would be appreciated
if you can shed some light on it.

Thanks & Best Regards,
	Abel


