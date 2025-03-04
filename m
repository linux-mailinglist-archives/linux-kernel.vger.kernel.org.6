Return-Path: <linux-kernel+bounces-544847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B7A4E5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A3D42317C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441628F95A;
	Tue,  4 Mar 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA6BcT/G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3028F943
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104081; cv=none; b=YipMEQQ4cc4TgV7Q7OrxRgJE5YCGAG2dPcEiIIgLBafL+nRvoPIpicPDTImPus4tK5S6Q2YBgE3ZK+G8573Pa0mzL/d7KFOAPq8KFf+xQbFlzenYw8uZUNWCLxac3p1CEakMPABxTjU6b1957MBQdY+3PgI8N8FeNpb9tLgDArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104081; c=relaxed/simple;
	bh=FYclQRW5qOKM3uda9/7c+NE0xSw7K7rC9el4vjYb+QY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=st4yrQr1LXYeu6WPJb57ztS6AekuDrwk0Pq+W+Jie7h3ltaAAMCp/2zqszSXLEy6HrrsJICSWBZ6inwXQN5JeWRWxBNNGleNpzuo6tFf49ln1wYXrMR2w6efyPwD7iS8Bg4P7I6lcOOXHpSrssf4UfaZ8VMfbD9vRyCURvAGSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA6BcT/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741104077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrjcmiuE/a0WYPzM1Vs1HXuhCSj0v+fU7DwLGVL8lzg=;
	b=KA6BcT/GgvwJu6mHASc/xlpcidVQd0boaGkbT7eRAC74VN3PxsYv1vnLt5eZc/pcsb/6bJ
	pCyMsuDLp6zAed9max2qDg8p7T2s6hWxIXUZvywhXTYPaAG9JHieujxO7AwgBccGzORNfx
	OooAD+mqPdr2MHX0LCnLp9vxzQ1vcZU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-QwiLS2sBMOmuvvq7rUt2eA-1; Tue, 04 Mar 2025 11:01:11 -0500
X-MC-Unique: QwiLS2sBMOmuvvq7rUt2eA-1
X-Mimecast-MFC-AGG-ID: QwiLS2sBMOmuvvq7rUt2eA_1741104070
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b9242877so1498495085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104070; x=1741708870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrjcmiuE/a0WYPzM1Vs1HXuhCSj0v+fU7DwLGVL8lzg=;
        b=IVDi96vI3LFUc0WmYhdJz13IdH41teCYSdomlhsdtjO2QkUHi5B6/0/Z4C7aZXoigM
         SfcogCa4EqDMMWgB5SrsGj/4TChnoUTMgnf3LWLsYpBhqhmME2T3nYgfyxwJ7M+kAkTf
         nmHiANG2dwEMySP5iExSaURLcXg6gtkcY13fmy1mI781SvuO6c0/OgGCUMTx8udzCShf
         /BCnGzpikCroHffxTTAz65z387lJF2nQnElrrNlwIWVl+eWLX3ZoilG7FbmonMyCMJ18
         UEjaNIG63MufiiTUzwfVE6ha+TGADn7omZMomtK/ijd7vkUp+NNjPxNDpJySBKAkP2t4
         0ILw==
X-Forwarded-Encrypted: i=1; AJvYcCUWKZLmNWWgZ5D4sOPO8Vtm6UNHZlph+1r6YQDdXDxgq/QQMCigJpeKA1EnF1Iqc5LRw9Rw4C92T/T2IlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxostUl4GMlLU84P3THb10lA1AtI/2QtrSb3Bq+SvcCeIut+PVV
	uSB1gvpkGMLRIAOC6E1ZBTziFzN83nAfuXsiwQVZXpP9OPEH0gcOGdw6rSL3BMdb72fK2g/xh/a
	THfpTudy3cKAJVWcFq00OaMwkU6RNBZmxsphMgQ/JpSwCdlzz97x2H8mnOSqL/g==
X-Gm-Gg: ASbGnctGu7fBYvL9TMoavbCpRX4P//eAy8f3+D1N73SuAbn61MstdN3AN9P+hHiutXF
	miLI9+CcjAS82VuPBwq/D9QizIpwW5+CKuJ5eav7iHzZW49k5nwY68IneAXaFM6aLvBu0G9ju8M
	UrWv02Zzc0IRQrzJ++/hLAac/SsnwA9YdULh7wzVqekw7SyF5YbQnLXop0kKx2wnKpfmLBlwXcs
	625mFTfoF+pYYFSxdOlERdhga1TUunIoDeKwhf/zHmcKKUmko1QuEjJQyaj+W/u7avXsQFPhD3C
	znG1o6G1DVWBM8d/rEXcO6emwaPWX96DKMZVgcjPzUG3xJxy9Hz9OViYxCU=
X-Received: by 2002:a05:620a:2621:b0:7c3:cfec:39e2 with SMTP id af79cd13be357-7c3cfec3ce9mr341170085a.52.1741104070541;
        Tue, 04 Mar 2025 08:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc4HXnFNztvW7EARLEgRj3YiE0qxm0boB8v7867SgoymPm/GNIxFOmiKNGytZyj04ASUctKQ==
X-Received: by 2002:a05:620a:2621:b0:7c3:cfec:39e2 with SMTP id af79cd13be357-7c3cfec3ce9mr341166185a.52.1741104070181;
        Tue, 04 Mar 2025 08:01:10 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9e2d5sm755254485a.68.2025.03.04.08.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:01:09 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
Date: Tue, 4 Mar 2025 11:01:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
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
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Content-Language: en-US
In-Reply-To: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 10:05 AM, Waiman Long wrote:
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -6,6 +6,19 @@
>>   #include <linux/bsearch.h>
>>     DEFINE_MUTEX(sched_domains_mutex);
>> +#ifdef CONFIG_SMP
>> +void sched_domains_mutex_lock(void)
>> +{
>> +    mutex_lock(&sched_domains_mutex);
>> +}
>> +void sched_domains_mutex_unlock(void)
>> +{
>> +    mutex_unlock(&sched_domains_mutex);
>> +}
>> +#else
>> +void sched_domains_mutex_lock(void) { }
>> +void sched_domains_mutex_unlock(void) { }
>> +#endif
>>     /* Protected by sched_domains_mutex: */
>>   static cpumask_var_t sched_domains_tmpmask;
>> @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int 
>> ndoms_new, cpumask_var_t doms_new[],
>>   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>                    struct sched_domain_attr *dattr_new)
>>   {
>> -    mutex_lock(&sched_domains_mutex);
>> +    sched_domains_mutex_lock();
>>       partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>> -    mutex_unlock(&sched_domains_mutex);
>> +    sched_domains_mutex_unlock();
>>   }
>
> There are two "lockdep_assert_held(&sched_domains_mutex);" statements 
> in topology.c file and one in cpuset.c. That can be problematic in the 
> non-SMP case. Maybe another wrapper to do the assert?

Ignore that as both topology.c and cpuset.c will only be compiled if 
CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP" 
above.

Cheers,
Longman


