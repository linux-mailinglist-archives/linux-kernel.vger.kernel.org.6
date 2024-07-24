Return-Path: <linux-kernel+bounces-260953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457B93B0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86C8283E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D111586DB;
	Wed, 24 Jul 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fRVFkmgy"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E40155740
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823121; cv=none; b=Lf7FB2cFjY0q7KTaC9vkqAtdczpjRrJbUZEXHPz4g5TwkDd9GPIPDKQVPpqcpAE/m0lBdb7eB9hI7PHYEkp20/Jg9TyR1VWSynELni7ya8ileoY0XLJ7WHPcYHH3sAq11Xa/7ShvbyRqrlrQb31KY/pHQtK0/ObWOfueijwfMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823121; c=relaxed/simple;
	bh=oGkw0GLiv9o3avf9/YrsTflPCBl93D2KHf779SN/AM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YefN6mmhtQ/zEP7igo2mWL8fSsuMP/g07pFO+nX/a2Z9wiYFIuVIHc0pMTk5epiHJ5eHEkglqdPYN9AACLZHzRWpKF4ot1zmwxB/23/I/hZIYc9qi6y+mJYYhIuajQtCwu2OH4InBbFu134uHWjbH1PUl0nvdFEoccccczrlzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fRVFkmgy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d18112b60so632551b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721823119; x=1722427919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFy7+njE3VJU3/3ZouefuwdTQET6AYUhpuoWintiyWk=;
        b=fRVFkmgyx0OWYuX87X/X4lMipSxlrpa0PCRHYr9YHk+Yh/V2snenx8X25SUqpN2j8p
         yBSdFibHd2yGHTD8ZcJHZAOHmHX0F6uVlCBd+rEdHPH/o5qSCxYu/pEPjTvHnNodmYOS
         vkd+qnrX0Cr7CUTt0MwD0mWadU8XgKtaUAbd10/ySoO7M/zTVPR/QKrICXe1SlaBlqKE
         k5V8e5fbBT8y1m2WQI4fnR92QUa54iYVpDtyl4BPcJlrt36m6CpCZdgbocF/EP2fBF3W
         zu7LeODnuxA3ApuMI5zxeaO433PMXNfxC9SGwC4FGAbSm2oMit5TGrJbyAq8sDltu4yh
         xx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823119; x=1722427919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFy7+njE3VJU3/3ZouefuwdTQET6AYUhpuoWintiyWk=;
        b=BaCE8o5LA+7XVjpOXAZwPvEgzsjKEfMbaEEPkKMkrqZ/X2BrRP872vGkqnVkaTayrv
         TGojLNWomrevqgmB8zkWN9rJIo4SnZiicq/R7RO3i88Ajth7gyv2h6u2d43+/nsSc94R
         rCK9YSsDcK876NXPKsIvtpNgqNKWy/cWnA08ren0ypKXRsIrLQmlEZ8graQ4/J3Doepr
         uz4LxystjOm1UOwoIPNjOMXTsguYnCJ4g+/eDUsB+r/nNEd8RNrIaPAuA0roTg2yDd0n
         U9zcLWzzPpadIm+L+FvmFjSa8ebpBJUH1CxNSr+97kax2FLM7/oGjc7dzhMp2qo0/7q0
         N5XA==
X-Forwarded-Encrypted: i=1; AJvYcCXlQ7D2trVxgtI8aHBXF5HNyWqKomQSwRpkQn5Dgumd1Vb6/fz8ZxLr1C8LoyWB/zngMCIf27QgS4rmthGku1Hdqo42MMF94ZB5aOsF
X-Gm-Message-State: AOJu0YxCACY55mT/lzTvBFODAi5TKa1au1gFCMwuke/LNL8QJfBQRhko
	Eghz/BurlB7ly7HnTWLrsghaONXZzyrt5oY+MXAI1vse12jgnAT/5eiN7SHsvOSbll0LEWKq5cY
	2
X-Google-Smtp-Source: AGHT+IFI0t1oh+Q+zYfO2EfCvj5CVJm/CirsXbPQ4VIGjBy05FeIYMitLubcUYvT3km0VNBcy2yVNA==
X-Received: by 2002:a05:6a20:2443:b0:1c3:f4b6:f83c with SMTP id adf61e73a8af0-1c463782af3mr2905049637.26.1721823119250;
        Wed, 24 Jul 2024 05:11:59 -0700 (PDT)
Received: from [10.254.218.171] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70e9cf572e7sm1186944b3a.29.2024.07.24.05.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 05:11:58 -0700 (PDT)
Message-ID: <790f44b4-2cad-469f-adcb-aa1cb31ff802@bytedance.com>
Date: Wed, 24 Jul 2024 20:11:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/numa_balancing: Fix the memory thrashing problem in
 the single-threaded process
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: peterz@infradead.org, mgorman@suse.de, ying.huang@intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
 <e3a75483-d3f7-4963-9332-4893d22463ad@bytedance.com>
 <CACSyD1M_nqrOZh3CDqydaasX3_9JdsqDFQTqOZ+q-xkvNMY1Kg@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CACSyD1M_nqrOZh3CDqydaasX3_9JdsqDFQTqOZ+q-xkvNMY1Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/24 11:55 AM, Zhongkun He Wrote:
> On Tue, Jul 23, 2024 at 9:39 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Hi Zhongkun,
>>
>> On 7/23/24 1:32 PM, Zhongkun He Wrote:
>>> I found a problem in my test machine that the memory of a process is
>>> repeatedly migrated between two nodes and does not stop.
>>>
>>> 1.Test step and the machines.
>>> ------------
>>> VM machine: 4 numa nodes and 10GB per node.
>>>
>>> stress --vm 1 --vm-bytes 12g --vm-keep
>>>
>>> The info of numa stat:
>>> while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
>>> anon N0=98304 N1=0 N2=10250747904 N3=2634334208
>>
>> I am curious what was the exact reason made the worker migrated
>> to N3? And later...
> 
> The maximum capacity of each node is 10 GB， but it requires 12GB,
> so there's always 2G on other nodes. With the patch below we only
> have page_faults in other nodes, not local. so we will migrate pages
> to other nodes because p->numa_preferred_nid is always the other node.

Ahh sorry, I didn't notice the size of the node...

> 
>>
>>> anon N0=98304 N1=0 N2=10250747904 N3=2634334208
>>> anon N0=98304 N1=0 N2=9937256448 N3=2947825664
>>> anon N0=98304 N1=0 N2=8863514624 N3=4021567488
>>> anon N0=98304 N1=0 N2=7789772800 N3=5095309312
>>> anon N0=98304 N1=0 N2=6716030976 N3=6169051136
>>> anon N0=98304 N1=0 N2=5642289152 N3=7242792960
>>> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
>>> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
>>> anon N0=98304 N1=0 N2=4837007360 N3=8048074752
>>> anon N0=98304 N1=0 N2=3763265536 N3=9121816576
>>> anon N0=98304 N1=0 N2=2689523712 N3=10195558400
>>> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
>>> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
>>> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
>>
>> .. why it was moved back to N2?
> 
> The private page_faults on N2 are larger than that on N3.
> 
>>
>>> anon N0=98304 N1=0 N2=3320455168 N3=9564626944
>>> anon N0=98304 N1=0 N2=4394196992 N3=8490885120
>>> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
>>> anon N0=98304 N1=0 N2=6174195712 N3=6710886400
>>> anon N0=98304 N1=0 N2=7247937536 N3=5637144576
>>> anon N0=98304 N1=0 N2=8321679360 N3=4563402752
>>> anon N0=98304 N1=0 N2=9395421184 N3=3489660928
>>> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
>>> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
>>>
>>> 2. Root cause:
>>> Since commit 3e32158767b0 ("mm/mprotect.c: don't touch single threaded
>>> PTEs which are on the right node")the PTE of local pages will not be
>>> changed in change_pte_range() for single-threaded process, so no
>>> page_faults information will be generated in do_numa_page(). If a
>>> single-threaded process has memory on another node, it will
>>> unconditionally migrate all of it's local memory to that node,
>>> even if the remote node has only one page.
>>
>> IIUC the remote pages will be moved to the node where the worker
>> is running since local (private) PTEs are not set to protnone and
>> won't be faulted on.
>>
> 
> Yes.
> 
>>>
>>> So, let's fix it. The memory of single-threaded process should follow
>>> the cpu, not the numa faults info in order to avoid memory thrashing.
>>
>> Don't forget the 'Fixes' tag for bugfix patches :)
> 
> OK, thanks.
> 
>>
>>>
>>> ...>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 24dda708b699..d7cbbda568fb 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -2898,6 +2898,12 @@ static void task_numa_placement(struct task_struct *p)
>>>                numa_group_count_active_nodes(ng);
>>>                spin_unlock_irq(group_lock);
>>>                max_nid = preferred_group_nid(p, max_nid);
>>> +     } else if (atomic_read(&p->mm->mm_users) == 1) {
>>> +             /*
>>> +              * The memory of a single-threaded process should
>>> +              * follow the CPU in order to avoid memory thrashing.
>>> +              */
>>> +             max_nid = numa_node_id();
>>>        }
>>>
>>>        if (max_faults) {
>>
>> Since you don't want to respect the faults info, can we simply
>> skip task placement?
> 
> This is a good suggestion. It would be even better if there were some
> feedback from others.

Although it is still a pity that, if remote node holds more hot pages
than p->numa_preferred_nid, we have to migrate them to local rather
than simply migrate the task to the hot node.

