Return-Path: <linux-kernel+bounces-523789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BDA3DB47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9343B52B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668731F8BA4;
	Thu, 20 Feb 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX99E1yU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6E433BE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058117; cv=none; b=N+jmP/7Q0oy8i4Kp3nVHBlAoVABLCalKd5zPmeGzQOQn1Li626rKE4+AoCA8j9Sr1qp52JeNH7kSm8r4/kcwjkmaydnGeoTupHCzz8OqqT7uc+oP/Kc/7GH1j5d7o9eeLiudc66s+mTP/4dxfIeVjEWRBtPZaNZ1KqcSoaoZANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058117; c=relaxed/simple;
	bh=6v7PJVxBLl1BToOa9hbm/qb/5k7mTQ1bH6QP2xbWj3o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V31aKwHz/h636xavmZAfH9ieCfWIDOPZq+9pXF5nCHFlK3rwRYldo+YlegZTwWrxz4I6tihTOG2azKKBaZtmN8Yluod84cQO66zdIr0Vk2bGBLNM11X67VSyVE3ug77bByXD5PhCUVDoBihTimCnPP661m1TvCH8nnHSuZUBlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AX99E1yU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEfE+oQZ6m0RLdfUPRWERlu8bLJ41aEcuNufBb3jHao=;
	b=AX99E1yU+1/dZPbjmy+z4V7yKazk8GNPvVaou2KMJTYRt5WNjZ+Pb48AV5cZ7+Mv+PemDj
	ZqL2e5HM8+c7mzB5y1rp27T6gGX6afOcEjaCA+2NaYc6ho1xtAEzmOWr/D5tAvaZPbIxsu
	RALCWkwcFoOWC1rlnaAXB+mS8IOvbl8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-XLUhUUm1PJKgZbShAq9Zng-1; Thu, 20 Feb 2025 08:28:33 -0500
X-MC-Unique: XLUhUUm1PJKgZbShAq9Zng-1
X-Mimecast-MFC-AGG-ID: XLUhUUm1PJKgZbShAq9Zng_1740058113
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e65a5ee5f0so36259326d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058113; x=1740662913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEfE+oQZ6m0RLdfUPRWERlu8bLJ41aEcuNufBb3jHao=;
        b=thigMgy1n7EOrDFRLOlfK9FF5Xl9PXnR9VoEZEFYoi9xBi7ld/ip6k7F0vNlUlHHSY
         jjUcueF5v8qu4KXvpLihDdnj+rku75wWa5Zy3CbsA209F452JwSaxIuTD41AMfNODi5+
         PASrQ+NIpnukKKf6gg82vbL2gPX9ihE080nngdlol+DeJnqvn4aB43rjaEaQ9PluLioN
         FNKvCruuybT9pm3ccLM/wACQ3Y3SwmET+5yrQrxoXJHfdHlnsAOgaOVDTn90y6E46dKt
         irv10Q7xy18ZR4trhq2RflNjv+Fmo5DGbH2sMpZsxKI3B6T2sY0M/FFnHlI+8X2XAAxi
         qs2g==
X-Forwarded-Encrypted: i=1; AJvYcCV8x76FB3l44Zq3Vu7CyDWhuoTflRj92tBOllFVovwFnqtljE3IWN7YRtoyTSnEW3HYNnweRTJRtnd+36w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyem6gKBRAzXcthXdMmwL3YtQXCiVsl9tEuYPb729PqqFQOEXL
	+1ajWQUfsnPYpB2+ZGvmsbKIMuAe9MDiGSKmAt49BPGCCEHnMaRQX/armi2Gi2FNCjH1LTV/IXB
	meNyiaeFZkgcqxI5CE0BD4JvcZjykVy0ZuFRKwlVx/VW0D0AJ8PwzSM/BNnP9ew==
X-Gm-Gg: ASbGnct4tynlq4lhiD6yogyQBvHVxsgmEvO8Jk7Leikjir6wJwI5H5jt9RS3KuvUHC4
	e6KlD0KBAhsbFHj3VZLdYiFxLwowCs5bTCAs0/eDJuQP/IazWLbdc6oo8+UYy6FmE65gse/+Q+9
	YQ+e7QlHNVY0q3iJMvAb6aXv1ILC+92GIvs/XTdhYhNq/MxODmwHy6M2X/IJVV5cQ0kWZAQC6JO
	BR9fFL/gicr6HhGQSlgnrrhz3ND2rjWUZDz4PXGLf4D7Z5JI+1N7N2BJ/Yzu0MSY5VwU6kvqvDh
	iadmyq//7arxvvYfSQsrBV4YnLLTaMholp+WgMQsp1FWMmcd
X-Received: by 2002:ad4:5949:0:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6e6a257b2edmr51384786d6.4.1740058112723;
        Thu, 20 Feb 2025 05:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6L/J150VyhZE8qpddA7Ggp+4U/MflpgbPfOEplCKpjVPjN9XqDo0bGw1rmUPzHRESSRb5Dg==
X-Received: by 2002:ad4:5949:0:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6e6a257b2edmr51384266d6.4.1740058112355;
        Thu, 20 Feb 2025 05:28:32 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6acb6d6b4sm637146d6.121.2025.02.20.05.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:28:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b91faa4-f346-4a61-a3a6-e47648af0fb5@redhat.com>
Date: Thu, 20 Feb 2025 08:28:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Waiman Long <llong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
 <20250220075639.298616eb494248d390417977@kernel.org>
 <d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
 <20250219204153.65ed1f5e@gandalf.local.home>
 <9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
 <20250220115904.051e0cc55a9cb88302582ef4@kernel.org>
 <bb5886cc-a512-4a59-98c7-f21128ab6194@redhat.com>
 <20250220182927.258e394c6ba5d76d4c57324b@kernel.org>
Content-Language: en-US
In-Reply-To: <20250220182927.258e394c6ba5d76d4c57324b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/25 4:29 AM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 22:37:04 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> On 2/19/25 9:59 PM, Masami Hiramatsu (Google) wrote:
>>> On Wed, 19 Feb 2025 21:15:08 -0500
>>> Waiman Long <llong@redhat.com> wrote:
>>>
>>>> On 2/19/25 8:41 PM, Steven Rostedt wrote:
>>>>> On Wed, 19 Feb 2025 20:36:13 -0500
>>>>> Waiman Long <llong@redhat.com> wrote:
>>>>>
>>>>>     
>>>>>>>>>> this field, we don't need to take lock, though taking the wait_lock may
>>>>>>>>>> still be needed to examine other information inside the mutex.
>>>>>>> Do we need to take it just for accessing owner, which is in an atomic?
>>>>>> Right. I forgot it is an atomic_long_t. In that case, no lock should be
>>>>>> needed.
>>>>> Now if we have a two fields to read:
>>>>>
>>>>> 	block_flags (for the type of lock) and blocked_on (for the lock)
>>>>>
>>>>> We need a way to synchronize the two. What happens if we read the type, and
>>>>> the task wakes up and and then blocks on a different type of lock?
>>>>>
>>>>> Then the lock read from blocked_on could be a different type of lock than
>>>>> what is expected.
>>>> That is different from reading the owner. In this case, we need to use
>>>> smp_rmb()/wmb() to sequence the read and write operations unless it is
>>>> guaranteed that they are in the same cacheline. One possible way is as
>>>> follows:
>>>>
>>>> Writer - setting them:
>>>>
>>>>        WRITE_ONCE(lock)
>>>>        smp_wmb()
>>>>        WRITE_ONCE(type)
>>>>
>>>> Clearing them:
>>>>
>>>>        WRITE_ONCE(type, 0)
>>>>        smp_wmb()
>>>>        WRITE_ONCE(lock, NULL)
>>>>
>>>> Reader:
>>>>
>>>>        READ_ONCE(type)
>>>> again:
>>>>        smp_rmb()
>>>>        READ_ONCE(lock)
>>>>        smp_rmb()
>>>>        if (READ_ONCE(type) != type)
>>>>            goto again
>>> What about mutex-rwsem-mutex case?
>>>
>>> mutex_lock(&lock1);
>>> down_read(&lock2);
>>> mutex_lock(&lock3);
>>>
>>> The worst scenario is;
>>>
>>> WRITE_ONCE(lock, &lock1)
>>> smp_wmb()
>>> WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX
>>> WRITE_ONCE(type, 0)
>>> smp_wmb()
>>> WRITE_ONCE(lock, NULL)
>>> WRITE_ONCE(lock, &lock2)    READ_ONCE(lock) -> &lock2
>>> smp_wmb()
>>> WRITE_ONCE(type, RWSEM)
>>> WRITE_ONCE(type, 0)
>>> smp_wmb()
>>> WRITE_ONCE(lock, NULL)
>>> WRITE_ONCE(lock, &lock3)
>>> smp_wmb()
>>> WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX == MUTEX
>>> WRITE_ONCE(type, 0)
>>> smp_wmb()
>>> WRITE_ONCE(lock, NULL)
>>>
>>>                               "OK, lock2 is a MUTEX!"
>>>
>>> So unless stopping the blocker task, we can not ensure this works.
>>> But unless decode the lock, we don't know the blocker task.
>> That could only happen if the reader can get interrupted/preempted for a
>> long time. In that case, we may need to reread the lock again to be sure
>> that they are stable.
> Hm, actually read side should run under rcu read locked, so only interrupt
> matters. So I think this rarely happens.
>
> BTW, we don't need the lock address itself, but we need to know who is the
> owner. Maybe we can point the address of atomic_long_t?
>
> struct task_struct {
> 	atomic_long_t *blocked_on_owner;
> };
Yes, we can use a pointer to the owner field. However, the way that 
owner field is encoded varies depends on the lock type. So we still need 
to know what lock it is. As mentioned in the other thread, we can encode 
the lock type into the lowest 2 bits of the pointer.
>
> The problem is that mutex and rwsem are OK, but rt_mutex uses task_struct *.
> Maybe we can use atomic_long_t in rt_mutex too if the new Kconfig is enabled.

It shouldn't be a problem to use atomic_long_t for the owner.

Cheers,
Longman


