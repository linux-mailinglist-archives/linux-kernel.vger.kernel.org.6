Return-Path: <linux-kernel+bounces-526608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9819A400F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4554265B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627AB253B5D;
	Fri, 21 Feb 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9mXuFN6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12491DC985
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169805; cv=none; b=Lyihr5gCR0VirUs/LRFygg8J2ZLDi4fT5WTFMVU6AqbCKEiCV9OVr90p+nJgGz4H52f2rHL+gatxN84JiysFoGwJk5o7KN+iRlRTLO4fh457f24nsGvf//e0YF8WG3Nmcpdo499pOOlRYax9UmIcG5PWuuE46l/ZjHGaEgn904g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169805; c=relaxed/simple;
	bh=7xXe65mMRXbX8wrPPjWeKDElAy7UsGVng4gbOLCQor4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DtzouSIgyKZz9aOw7947XzDzEvzOlIcQXMDzBR2dzR215idfus/tsxmuhLcdgMuO8KDUmmU8sopY0CYdJsIGVAQjDYpt7H6FMG2oX9VH0kSqh8O3YjqWXqfu+DKfT6T2H/BcmiIoaAs+mfp2aSyuymt1TpfhDaTeyULa13U1g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9mXuFN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740169802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXplnWMmOkla3WZLC+qs4BlkJVW64A5kf4g2SnWgzu4=;
	b=M9mXuFN6CZRMq+NxsXy57RXzkOjMCJ53L67Ppx+pCGOLhcWvYoVoqxy3dz6A7e9lc5Hlz7
	ocj4UAutAcYQZnHWYE0BzYPE6DHMsTTT/MZ1HATjAoNxyTRo56/Vi/V00d5fauBUzf4L3P
	7QdsJVJ5NN5qIiALQmfEJtyPwTG1YBI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-r6u7tqPVMQ6b6krlW1UDgQ-1; Fri, 21 Feb 2025 15:30:00 -0500
X-MC-Unique: r6u7tqPVMQ6b6krlW1UDgQ-1
X-Mimecast-MFC-AGG-ID: r6u7tqPVMQ6b6krlW1UDgQ_1740169800
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b9242877so680566885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169800; x=1740774600;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXplnWMmOkla3WZLC+qs4BlkJVW64A5kf4g2SnWgzu4=;
        b=kE92FD8oVSmc8jQCfentTjQaz9rMNjAeFxW+3RWreF5IsUaF4q/CzEKhesx7ep1nVG
         qW5TihEt3qz9zlM7I+YzGRbLQGyH1sf7p3ybdMimJUgHdLw0mDbgFiuKp8Xhccn3WJ6m
         e1VfX2ag8ToChm/sSPoG9hq4L1P/Lt5sSjZ9HwCoKWnoCMvXwInI2TciyaCZvKotYu0h
         Oeoh+fomK6sCZrK8+Gn1Zk5M2ksZT0GS7i3Rs9Tqbkv+sXCZ0882GRgmqkGEKolPrnGb
         rplN4K4bR+ACOSbER7Rj2CpTAOe9Tk9bq8cK2j7kdfWRyJMMIymzBBvslV06iFbXGiwt
         zZbg==
X-Forwarded-Encrypted: i=1; AJvYcCWj59YE+UaEFFdZBC+GPDkWoTlS5igSA0EwHXE7lkMl5GeTWUW4eQbUSVEkqQNXD1gDzzrs+saFxJiAg2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgFj2i3AyT4lYnw9tGHFyvfYaQd1igB43CVjxI1fTAzJnLmTE
	4nGXLB2PhWNUz3D29pakZaY2UhieX41VBoJ1jMfmSbq6CgBCT8umEhelDTKfgWkTXpNIJZMqJhF
	ZXyJqBYBbkF/o6SP30V2wLhgnwJoxOwoAS/zjtfVV1Vb/I0KsRxBq3TX4JezmTw==
X-Gm-Gg: ASbGncsCaCLMJgA+G9NXZl1T5J3KqdlVXT4ZWi2Xf+U/Mwl4EeA1yKShqU7Fjbt8pju
	+CTwMJimSSmCvWYv11HBRU6KwJqCB9wMxk/CXEk17PWyp+88KOomtnoFf3t/Zl+vmMzE0vBE0Qx
	nKKg++gFjcVlaZsJdtc1r7Cx8+tFPtigGZXfhBCC4/QxK2V9XOIbfyOdR5MIoeumW8GyIj0GP+n
	BFjGbxn42ZPOB6AzEnIkmI8xkO1kpf2HwUGRSZh/HRPw/KTN1s7SslgQx7JNGj7v/brpqT1YO/R
	KW9mEyB9v5I7ufnAlGlibGuwTw2vdMpUMm+FUMHZPIDCLqq9TywajlbQqC4=
X-Received: by 2002:a05:620a:1b99:b0:7c0:c822:c4e8 with SMTP id af79cd13be357-7c0cef744a2mr725061685a.57.1740169799914;
        Fri, 21 Feb 2025 12:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi0+eGMCpKSbBOBYuzkB2vcVUgKv5RVOxyd1OQ1uLdvdmQOgpHfR1XEmrY3n3XRKrVJYfM0Q==
X-Received: by 2002:a05:620a:1b99:b0:7c0:c822:c4e8 with SMTP id af79cd13be357-7c0cef744a2mr725058085a.57.1740169799527;
        Fri, 21 Feb 2025 12:29:59 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0d81b2fsm455876685a.84.2025.02.21.12.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:29:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <63fc7bff-168e-478b-a3fc-4897f2ee9d69@redhat.com>
Date: Fri, 21 Feb 2025 15:29:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: Peter Zijlstra <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
 <174014820133.967666.5855819828684207404.stgit@mhiramat.tok.corp.google.com>
 <20250221185939.GB7373@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250221185939.GB7373@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/21/25 1:59 PM, Peter Zijlstra wrote:
> On Fri, Feb 21, 2025 at 11:30:01PM +0900, Masami Hiramatsu (Google) wrote:
>> +static void debug_show_blocker(struct task_struct *task)
>> +{
>> +	struct task_struct *g, *t;
>> +	unsigned long owner;
>> +	struct mutex *lock;
>> +
>> +	lock = READ_ONCE(task->blocker_mutex);
>> +	if (!lock)
>> +		return;
>> +
>> +	owner = mutex_get_owner(lock);
>> +	if (likely(owner)) {
>> +		/* Ensure the owner information is correct. */
>> +		for_each_process_thread(g, t)
>> +			if ((unsigned long)t == owner) {
>> +				pr_err("INFO: task %s:%d is blocked on a mutex owned by task %s:%d.\n",
>> +					task->comm, task->pid, t->comm, t->pid);
>> +				sched_show_task(t);
>> +				return;
>> +			}
>   - that for_each_process_thread() scope needs { }
>
>   - that for_each_process_thread() loop needs RCU or tasklist_lock

The call chain should be

check_hung_uninterruptible_tasks()
   -> check_hung_task()
     -> debug_show_blocker()

check_hung_uninterruptible_tasks() takes rcu_read_lock() before calling 
check_hung_task(). Perhaps add a statement like

     RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");

>
>   - there is no saying that the owner you read with mutex_get_owner() is
>     still the owner by the time you do the compare, there can have been
>     owner changes.

Maybe change "owned by" to "likely owned by" :-)

Cheers,
Longman


