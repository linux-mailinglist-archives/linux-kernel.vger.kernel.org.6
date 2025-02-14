Return-Path: <linux-kernel+bounces-515107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE5A36039
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3622316F800
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A72661AA;
	Fri, 14 Feb 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEkqKaM0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BC264A82
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542859; cv=none; b=B7qBtze6ohrdhM+BdhmpyDpJbjG09Kd545VVR2G62uZ+Rr9m8yIyyH/htWx/ZpgkwiMHiW2zlCNStm6eW00cFn6yCqah+NoTJzza7N/I1ofeevf/tQ9csfuK78OezijiZuXK8XBRYk3mSpOKY25f4vNXVMr45oJOKqRawPcAlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542859; c=relaxed/simple;
	bh=pf1W6MoE15Qo7lkjknPJ6Zy9FUnC9L9Q1WzI1QuBI2M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FY7L83KjzD/P1QZb5eJmde/mKCglh0T9rpZXDhZ4mGsvWO5Ljpgd//lke1tQw6RlGdHqVHmEDhdxqrgetwrQOTjAvKPQcFuWGkyWWtrlAbTGt6hoc7SRM+7g8uzN4nF9ffzXwmdeoUlt399rWESg1cEfOWadpI6iLvwyfUs9f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEkqKaM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739542855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV/L1fOmL0HeZv0K9l5Ab/QjAd6iaWJdT6HUX+u0MV4=;
	b=ZEkqKaM0pvW1Gqc9WJU51Z0szQ2evDSNopZun/CccvhdtLD0r+ujP4pAASWPdbjku2arVa
	eDN4XTROFHdp6joE11VqrvWApGbNV7QL9QmwhuYL6qFe0rxQ8QETWfM9Pbb0KhiVzphvN8
	OrUMe8n1LnTmreKRwo/Gf5KYKg6fBrg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-N3HjtqM1MginqKmE6L1PrA-1; Fri, 14 Feb 2025 09:20:54 -0500
X-MC-Unique: N3HjtqM1MginqKmE6L1PrA-1
X-Mimecast-MFC-AGG-ID: N3HjtqM1MginqKmE6L1PrA_1739542854
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-471c05a5a9fso38133931cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542854; x=1740147654;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV/L1fOmL0HeZv0K9l5Ab/QjAd6iaWJdT6HUX+u0MV4=;
        b=fHTrBBBfU+cFG7D8BAxbxGLHbUw809oHvT5vtZiWtg//JKPFV3SCdGSzY/kA7r5aAe
         J0EhrQugPjCBM/rd0ikfbC6Q3XJP1ovMXXQ+eFzLBngDP5uZ/jprA3CrRPerJXDa8IUg
         mc/u8rVXMyf5Rn8FWG0WGp7iJA54t0r+WzwdcK4M4Pwn8UbBYk30bHv9kojzgUsXKLPY
         zmI2Dfqe7FOJ6/5C2KZt6NaL1UzQqVs+Kh7641F5NFYSual2dk2Sbe1fJvMHgt2FAYF3
         IcVzd3WvGP1cYnppzGq/WQWaLVaSD//Nknqmx8HkibteNvQQ6W993VgeJEM+OF2QgiTD
         I/QA==
X-Forwarded-Encrypted: i=1; AJvYcCV4JBygMF7NMjHq4hMOelTU7r7Q0ltosN+gCTXqdLxUskQVYZVXQpLJLuI8MTZbkqwuX/6P2ulGJYauHrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFpFlHC92Pg/fDXpWPgi3eor0cclbSF/OAhuA4CCkGTakJVe4
	JhzzqRcTCAkNFkiNEEa+BSAFdZIkj9k+PnGjpMGB7vVOlIIDP1XoyqDRMoriPgLZs3QVA4pKsL5
	AMEKK00d2CUpYm8ABUijGklT84cap+cZc5oiFc6prsZlg6XTnAvi7HFe59+/4nQ==
X-Gm-Gg: ASbGncupFefZfDTDHIHaNI3dhdkQqMr11u1MXPsRvtjPH5QqDlhmTuyDbMOgAEuVTG/
	/0TkhTKUickvfDBCXuCYfeb5oxHo3Jc3O5yN/hAin3zYUHSAtAfexG2eEoearTjFYeOL1P9GQeY
	lwPJ+pAyFi8+WBfoee/SRfAeUXLqx6pROB/ez/2VBNz5HBA+05pZautH2/jd5YXbupmkdy8yeHf
	Hw17XbqSZv4K5tLR+xAYQCwsthYiu7l3Qy3jOsmbg/6+6JnZhUadwebAaXqJIxBtxt3T14QuCib
	qnuGPWEbMvNsmIDtiUZggVLQCXvfLghkqVV3D3btRnBJ0iEI
X-Received: by 2002:ac8:5846:0:b0:471:d843:bfbc with SMTP id d75a77b69052e-471d843e5ecmr9607481cf.37.1739542854058;
        Fri, 14 Feb 2025 06:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkUl5pLsLYnHm6R6S4fN/Xb2hjARlX76BlooqiWlvMLvPMfCnXmKthY/XONqAsQ6WfuschHg==
X-Received: by 2002:ac8:5846:0:b0:471:d843:bfbc with SMTP id d75a77b69052e-471d843e5ecmr9607131cf.37.1739542853586;
        Fri, 14 Feb 2025 06:20:53 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b14c22sm18342591cf.81.2025.02.14.06.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:20:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <96398f56-79a2-47b0-8d0f-41efaa9dc775@redhat.com>
Date: Fri, 14 Feb 2025 09:20:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, Waiman Long <llong@redhat.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
 <006c1475-b45f-4339-ab53-0e7be51514af@redhat.com>
 <CA+B+MYQPQ_oD+Kmss1DeBdQ3Qpd4B=wFF1ngEz-aas46oWK4sg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+B+MYQPQ_oD+Kmss1DeBdQ3Qpd4B=wFF1ngEz-aas46oWK4sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/25 5:34 AM, Jin Guojie wrote:
> On Wed, Jan 15, 2025 at 11:38 PM Waiman Long <llong@redhat.com> wrote:
>> On 1/15/25 12:05 AM, Jin Guojie wrote:
>>> When running LTP's cpuset_memory_pressure program, the following error occurs:
>>>
>>> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
>>> then set cpuset_memory_pressure to 1
>>> (2) In this cgroup, create a process to allocate a large amount of
>>> memory and generate pressure counts
>>> (3) Set cpuset_memory_pressure to 0
>>> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
>>> current kernel returns a value of 1, so LTP determines it as FAIL
>>>
>>> V2:
>>> * call fmeter_init() when writing 0 to the memory_pressure_enabled
>>>
>>> Compared with patch v1 [1], this version implements clearer logic.
>>>
>>> [1] https://lore.kernel.org/cgroups/CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep36ZHe6HMQ@mail.gmail.com/T/#u
>>>
>>> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
>>> Suggested-by: Michal Koutný <mkoutny@suse.com>
>>> Suggested-by: Waiman Long <longman@redhat.com>
>>> ---
>>>    kernel/cgroup/cpuset-v1.c | 4 +++-
>>>    kernel/cgroup/cpuset.c    | 2 ++
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>> index 25c1d7b77e2f..7520eb31598a 100644
>>> --- a/kernel/cgroup/cpuset-v1.c
>>> +++ b/kernel/cgroup/cpuset-v1.c
>>> @@ -66,7 +66,6 @@ void fmeter_init(struct fmeter *fmp)
>>>           fmp->cnt = 0;
>>>           fmp->val = 0;
>>>           fmp->time = 0;
>>> -       spin_lock_init(&fmp->lock);
>>>    }
>>>
>>>    /* Internal meter update - process cnt events and update value */
>>> @@ -437,6 +436,9 @@ static int cpuset_write_u64(struct
>>> cgroup_subsys_state *css, struct cftype *cft,
>>>                   break;
>>>           case FILE_MEMORY_PRESSURE_ENABLED:
>>>                   cpuset_memory_pressure_enabled = !!val;
>>> +               if (cpuset_memory_pressure_enabled == 0) {
>>> +                       fmeter_init(&cs->fmeter);
>>> +               }
>> Nit: you don't need parentheses when there is only one statement
>> underneath "if".
>>>                   break;
>>>           case FILE_SPREAD_PAGE:
>>>                   retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 0f910c828973..3583c898ff77 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -3378,6 +3378,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>>>
>>>           __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>>>           fmeter_init(&cs->fmeter);
>>> +       spin_lock_init(&cs->fmeter.lock);
>>>           cs->relax_domain_level = -1;
>>>           INIT_LIST_HEAD(&cs->remote_sibling);
>>>
>>> @@ -3650,6 +3651,7 @@ int __init cpuset_init(void)
>>>           nodes_setall(top_cpuset.effective_mems);
>>>
>>>           fmeter_init(&top_cpuset.fmeter);
>>> +       spin_lock_init(&top_cpuset.fmeter.lock);
>>>           INIT_LIST_HEAD(&remote_children);
>>>
>>>           BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>>> --
>>> 2.34.1
>>>
>> I just realize that cpuset.memory_pressure_enabled is on root cgroup
>> only and affect a global flag that impact the behavior of all the
>> existing cpusets. Your current patch will clear the memory pressure data
>> in the root cgroup only. The other child cpusets will not be affected
>> and will still show existing data. This inconsistency isn't good.
>>
>> OTOH, I also don't think iterating the whole cpuset hierarchy and
>> clearing all the fmeter data is worth the effort given that cgroup v1 is
>> in maintenance mode. Perhaps just a simple check to return 0 if
>> cpuset.memory_pressure_enabled isn't set like in the v1 patch. I also
>> don't think we need to clear the fmeter data in that case as it will
>> lead to data clearing only on cpusets where cpuset.memory_pressure is
>> read while cpuset.memory_pressure_enabled has been cleared.
>>
>> Cheers,
>> Longman
> Hi Waiman,
>
> I understand that your meaning is to avoid clearing the fmeter data.
> Based on this idea, I made some modifications based on patch v1.
>
> Instead of writing 0 to the member variables of fmeter, we only need
> to return 0 in fmeter_getrate(). The update logic for fmeter data is kept
> unchanged, which minimizes the impact on the kernel's current behavior.
>
> The whole patch is greatly simplified as follows.
> Please see if this idea is correct, thanks!
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..14564e91e2b3 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>          fmeter_update(fmp);
>          val = fmp->val;
>          spin_unlock(&fmp->lock);
> -       return val;
> +       return cpuset_memory_pressure_enabled ? val : 0;
> }

That looks good to me. You can send out a v3 with this simpler change.

Cheers,
Longman


