Return-Path: <linux-kernel+bounces-519747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93BA3A169
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2F1742E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4326E14D;
	Tue, 18 Feb 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxcLs1I8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1A26D5DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892835; cv=none; b=bIhIRmtyabB12lnbRSVh5NzVEf2GjApAhUl9GyXGopOdfPjXYLuNC3HvA8rdy1+KB2Vy35oXnWhUxkHBjgOwECI3NZCGLaPqHGl0a0psn6D1oImica21wJXDh88PeoqWA4X26c9muBBtOIuv3X7nTV5F9VSiPV6pHC1nk+dQZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892835; c=relaxed/simple;
	bh=t8cibsn1XcXhacLGIYo20NWP5XTyEn9guHNiyAyN8iA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aCiZdynEw7cxP3tHOgq8SkBnUxmlzK8/rqu++TMAOa058YGYf/Vv8fU9SdWKgfP+9czp77NVq5PrZlsSgVbtW09iNL96syDO6A1DnZNAju/OzvUJ76mSYa2eKq1sSB3UmnJdIqUm1w3Iu+ubxjIqKHPJxP07pv0/ogtisyrTVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxcLs1I8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739892832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41Jqc/+pHSeC60EzJ+0UpeXga5Yyw7YB0ACIE3z+MU8=;
	b=XxcLs1I8BEQgO0cGPeCfcVqzqG9jlQRU50UPcR8qaN8KOBPN/9PmNO/LDgK61Oaxi/SCuh
	3dDJuTkkL9Ss3sV2kW1fNBIcFuIE/OEQyAp/zugf/1IzGZfGaTYhZUO82N8Hz1ivNT9gVA
	fYjCWglf1f9dGfafF01EjIQpejb6Y9A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-syRV2ls_Oc2tGmUzun836Q-1; Tue, 18 Feb 2025 10:33:50 -0500
X-MC-Unique: syRV2ls_Oc2tGmUzun836Q-1
X-Mimecast-MFC-AGG-ID: syRV2ls_Oc2tGmUzun836Q_1739892830
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f40efab7e9so16112b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892830; x=1740497630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41Jqc/+pHSeC60EzJ+0UpeXga5Yyw7YB0ACIE3z+MU8=;
        b=Afn8/k4VbeYV04yN8GeYSWBYhdS4op4a50+KTbRICyqFHOClA9Cj3LlHcsF7Lq3Ox5
         L6fS0indN11ZdWM+nxsM9fi4soKGbbvAEK2z51JF7+n8upsgeBg9ygt6JLpmTjhpIPSJ
         Cl3gi+DtXzCEy1NGvlL9L9yXNwJV1FOT+wOo/i4S+wKWCSg0fpHtfbDINapLzOE9lDbS
         ExHBfoVf3e5Oc1VSTtPyCJqIK2JeI5qHkQHil3DBNLQylcw6TXMJzrLxfe4WXMsvf1Y4
         7yZP6oBCI+ZZeIuciCg7kICMXVWo6td3eXy9CEaLO+MSrXuw+0qDeMn9i34xn3Fn4vJ7
         CQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM63owdb8FTR0R7l9+eFp6LBz3HaPQ2THe1wwSpAtDXAWRJjebgVDrKJ6/u18w5TqtwjsPFo+cxZDHk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKIxx8SGU/kQ5UVfTLxzX4/LNltceciV7Bz1MQmVAWkXsBJvx
	7LzZ9e/E/JB7pZBnNr2Pziy8unqDCh/PShrJw3FNkDomBGgoQUN6WDTWNdgngBhQ91ON3nrnl0K
	lcImDWijAivwt6paKBTw6HxdgBiLfVvKNKGE1bih0drQ8lzYXl2dIbLCtXOVGOQ==
X-Gm-Gg: ASbGncuMNehUThUMzzAkqCYFHZU9J8z2kWdzjZevly5T1TAFXT0bPK8sC+sMPauzoVG
	D20+McjJVT+Kq3iZF2fy1ciRaEzRj2tVkDhN4nAXLVWP9eT75fxLnmCxBsrTgBWu0SGYJ1XmBKM
	kyaM2J1+lYeo8tF8BZFyd900FbCuGoaFm45WyNOBcnRB+xU1pYD0nX05iKNSUNTQvCQ0/3QkVYA
	UdrYemZQV3s31PtEn1WfAFrBxYjulEMG98gdOYxEB6DAJ137oRQ4GHrG2n98KClFkoVmcn4ZYJg
	npLIpzxHK7+0+0JkrTfzE+7bnE2lRlXjR6scBaZqLgX6wzSi
X-Received: by 2002:a05:6808:1308:b0:3f3:d6ad:9cb4 with SMTP id 5614622812f47-3f3eb1355d5mr9739068b6e.32.1739892829811;
        Tue, 18 Feb 2025 07:33:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxgtnzZmgeZUyoEuxzRMeJlmo9l73tje3MOBo6QA5vyI7saZPim5FCZ7sQC/6ab2DhCkiVkA==
X-Received: by 2002:a05:6808:1308:b0:3f3:d6ad:9cb4 with SMTP id 5614622812f47-3f3eb1355d5mr9739048b6e.32.1739892829474;
        Tue, 18 Feb 2025 07:33:49 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40773d709sm613143b6e.6.2025.02.18.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:33:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9380df9c-a358-4466-91f4-b5b2c0cfcbbb@redhat.com>
Date: Tue, 18 Feb 2025 10:33:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
To: Phil Auld <pauld@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb> <Z67Wy9Jjn0BZa01A@linux.ibm.com>
 <20250218150059.GC547103@pauld.westford.csb>
 <12775fc3-1575-4bdd-8d1e-056915d95e3d@redhat.com>
 <20250218153039.GD547103@pauld.westford.csb>
Content-Language: en-US
In-Reply-To: <20250218153039.GD547103@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/25 10:30 AM, Phil Auld wrote:
> On Tue, Feb 18, 2025 at 10:23:50AM -0500 Waiman Long wrote:
>> On 2/18/25 10:00 AM, Phil Auld wrote:
>>> Hi Vishal.
>>>
>>> On Fri, Feb 14, 2025 at 11:08:19AM +0530 Vishal Chourasia wrote:
>>>> Hi Phil, Vineeth
>>>>
>>>> On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
>>>>> On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
>>>>>> Hi Phil Auld,
>>>>>>
>>>>>> On 11/02/25 19:31, Phil Auld wrote:
>>>>>>> The exising code uses housekeeping_any_cpu() to select a cpu for
>>>>>>> a given housekeeping task. However, this often ends up calling
>>>>>>> cpumask_any_and() which is defined as cpumask_first_and() which has
>>>>>>> the effect of alyways using the first cpu among those available.
>>>>>>>
>>>>>>> The same applies when multiple NUMA nodes are involved. In that
>>>>>>> case the first cpu in the local node is chosen which does provide
>>>>>>> a bit of spreading but with multiple HK cpus per node the same
>>>>>>> issues arise.
>>>>>>>
>>>>>>> Spread the HK work out by having housekeeping_any_cpu() and
>>>>>>> sched_numa_find_closest() use cpumask_any_and_distribute()
>>>>>>> instead of cpumask_any_and().
>>>>>>>
>>>>>> Got the overall intent of the patch for better load distribution on
>>>>>> housekeeping tasks. However, one potential drawback could be that by
>>>>>> spreading HK work across multiple CPUs might reduce the time that
>>>>>> some cores can spend in deeper idle states which can be beneficial for
>>>>>> power-sensitive systems.
>>>>>>
>>>>>> Thoughts?
>>>>> NOHZ_full setups are not generally used in power sensitive systems I think.
>>>>> They aren't in our use cases at least.
>>>>>
>>>>> In cases with many cpus a single housekeeping cpu can not keep up. Having
>>>>> other HK cpus in deep idle states while the one in use is overloaded is
>>>>> not a win.
>>>> To me, an overloaded CPU sounds like where more than one tasks are ready
>>>> to run, and a HK CPU is one receiving periodic scheduling clock
>>>> ticks, so HP CPU is bound to comes out of any power-saving state it is in.
>>> If the overload is caused by HK and interrupts there is nothing in the
>>> system to help. Tasks, sure, can get load balanced.
>>>
>>> And as you say, the HK cpus will have generally ticks happening anyway.
>>>
>>>>> If your single HK cpu can keep up then only configure that one HK cpu.
>>>>> The others will go idle and stay there.  And since they are nohz_full
>>>>> might get to stay idle even longer.
>>>> While it is good to distribute the load across each HK CPU in the HK
>>>> cpumask (queuing jobs on different CPUs each time), this can cause
>>>> jitter in virtualized environments. Unnecessaryily evicting other
>>>> tenants, when it's better to overload a VP than to wake up other VPs of a
>>>> tenant.
>>>>
>>> Sorry I'm not sure I understand your setup. Are your running virtual
>>> tenants on the HK cpus?  nohz_full in the guests? Maybe you only need
>>> on HK then it won't matter.
>>>
>>> My concern is that currently there is no point in having more than
>>> one HK cpu (per node in a NUMA case). The code as currently implemented
>>> is just not doing what it needs to.
>>>
>>> We have numerous cases where a single HK cpu just cannot keep up and
>>> the remote_tick warning fires. It also can lead to the other things
>>> (orchastration sw, HA keepalives etc) on the HK cpus getting starved
>>> which leads to other issues.  In these cases we recommend increasing
>>> the number of HK cpus.  But... that only helps the userspace tasks
>>> somewhat. It does not help the actual housekeeping part.
>> That is the part that should go into the commit log as well as it is the
>> rationale behind your patch.
>>
> Sure, I can add that piece and resend.

While at it, you can also add some text to address the other concerns 
that reviewers have so far.

Cheers,
Longman

>
>
> Cheers,
> Phil
>
>
>> Cheers,
>> Longman
>>


