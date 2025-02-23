Return-Path: <linux-kernel+bounces-527936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB45A4115E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9C164295
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD9194A44;
	Sun, 23 Feb 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8k7uX+s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6118E362
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340416; cv=none; b=YsDwkPcX5jqC3h77NOCIqA9t/Z3N5li2tvFo+kJBJxqDT6Ma7CZOysDFH6H0LzDeogaTQCOTMr+A2LUvkmQF3a9oiuvT/wGPNJQftyxjdxyLoU6tqH2LA8tBb2y74lDOzfJzAYRsYzWpaKnW2Geks1cFvWXIv95SEoWN1Y4ymVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340416; c=relaxed/simple;
	bh=isLyKUNkK5J1WRc9im9Q8yc/skWe36M8jvv8rD78rmo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sE/Vx/GagBOAh6RFTf7rv7kxHkE5+P65epnfIRVjYzVSYUZ36nTd6zIH6BMzSh/Hxf8l/N13ZFkYSB6a4/g57jmVH6tIOEIwl9HHzUd/b3qIf3FndcdWgWv4dvTDD2Fbd4+1k3xvYHvAxMC2Cw3pcXU+mnwx7GynP1gpEvBJqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8k7uX+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740340413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vyz0MOCJ575vJASPS5AZPFNJ2IiJmZqtA5WU0OXgy3Q=;
	b=Y8k7uX+sxyfHvvjsm5Zyz8rKmX5ltqKb9MjgBjsti8ZhUgBK+p4i6GrxZmwrXYNMNixmxl
	rrqmAq79xDeAjMpqNlOApwqACmN77oNPkjyqpdVrGEEOowWl9Q9/8Vsv5pKroAeDebCUOX
	32TG7Puq4lIP88+++oerTGB4lKKNZvw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-kszhwi5BORmiUC9c0bqpGw-1; Sun, 23 Feb 2025 14:53:31 -0500
X-MC-Unique: kszhwi5BORmiUC9c0bqpGw-1
X-Mimecast-MFC-AGG-ID: kszhwi5BORmiUC9c0bqpGw_1740340411
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0ae84aaceso659015185a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740340411; x=1740945211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vyz0MOCJ575vJASPS5AZPFNJ2IiJmZqtA5WU0OXgy3Q=;
        b=wfdL4eoyavpq9X0F9THV1wPZiGItuXQtkOdOOY5sc8iFlNqhx+VbMzZN0NEycbR6nq
         1woRr06ai+cbmI3eXO1vafCeN9icb6Z/HreK621V5/HLt+vSsZKkgDWknAFf9zPcp+nH
         P8f4GnQ0yYEdMAyJU1VgKACfeQmmPTODgVqcjW96B59piaCESpei5XTPT8+mMqFGFVL7
         UHe/LmaYbAyI/664ACGFDDO6pXwSYFeaRhqwu4CPkJL+1vbIVTGpENG4AzA1RX41hBVf
         mq5i/q2Rh/e4fIV8yqui5B6iPdBo8q1GYcpI072lZDP5+mWkzJb+lSS3eB8xJZINWWQV
         qJEg==
X-Forwarded-Encrypted: i=1; AJvYcCUlAKGCrpKUoD2sXzGz0hp2foaOe5U7TdBkWGRsRKtsStqszVdB87GxEvZTXK37zcTcsmoLwEmkyJKsT54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtONgLFIZliYCgiqBxN3CObOyF+Wp8VCT6zMzxxx/rKSuSgZG
	lNI5G4rudIsdaIvggIA+/DM//MEsItfIOxijZ98tZL/38gjnUAhJPLXBOT8iipViy0QrHFg7U4n
	MwGfcTVpRxvSTN7nuYkak/w2x3HAvniB9SuAtovcEPSuXCa8XuLchSXcn6w6mYw==
X-Gm-Gg: ASbGncvW8ZpqYn8vbqI1XyxY/qcpJM+72n975onvWX5sW5L4XYUx0z1FqGCbH2/v8V4
	mhXlDTdTeAkCDjRdLzSliTQIElb6GJBRKhBV1rQ5ZYPF0VLdE8lDY0bFGyRoCBdsIExLJgljK8u
	OtX6ZUvhDUVoegfRBnmCFaxA9TRmeyn3e0E8tUmDz0gLRVLjOb193yYcK4U9LPQt3PqNe6ltMFi
	Uxtp4IpWsZ1HjPjZv+UhJKjSDe0F31fLLREqG4CQ0KOU4eYvfNzxNH85OWlq6JBVQr7a7aUfnmp
	IjUQkHo6PnxfGMKObW3FvmqKgVzICqx/Nmq0LZjAol4O0zCql6DeTrHNx+4=
X-Received: by 2002:a05:620a:1790:b0:7c0:abe0:ce4b with SMTP id af79cd13be357-7c0ceeec71emr1251445885a.12.1740340410851;
        Sun, 23 Feb 2025 11:53:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6X6CUfypiI9MVQtUWwMPokADnScBAbOZ6Cs6b0AzcJ3CTyRiGtyUgEyBZI4wgbNtBeIhTCQ==
X-Received: by 2002:a05:620a:1790:b0:7c0:abe0:ce4b with SMTP id af79cd13be357-7c0ceeec71emr1251444485a.12.1740340410501;
        Sun, 23 Feb 2025 11:53:30 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a04d1aeesm872134585a.40.2025.02.23.11.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 11:53:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <30f8fa10-4527-4e03-91c6-638834412466@redhat.com>
Date: Sun, 23 Feb 2025 14:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
 <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
 <fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
Content-Language: en-US
In-Reply-To: <fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/25 2:34 PM, Waiman Long wrote:
> On 2/21/25 9:03 PM, Masami Hiramatsu (Google) wrote:
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> The "hung_task" shows a long-time uninterruptible slept task, but most
>> often, it's blocked on a mutex acquired by another task. Without
>> dumping such a task, investigating the root cause of the hung task
>> problem is very difficult.
>>
>> This introduce task_struct::blocker_mutex to point the mutex lock
>> which this task is waiting for. Since the mutex has "owner"
>> information, we can find the owner task and dump it with hung tasks.
>>
>> Note: the owner can be changed while dumping the owner task, so
>> this is "likely" the owner of the mutex.
>>
>> With this change, the hung task shows blocker task's info like below;
>>
>>   INFO: task cat:115 blocked for more than 122 seconds.
>>         Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
>> message.
>>   task:cat             state:D stack:13432 pid:115   tgid:115 
>> ppid:106    task_flags:0x400100 flags:0x00000002
>>   Call Trace:
>>    <TASK>
>>    __schedule+0x731/0x960
>>    ? schedule_preempt_disabled+0x54/0xa0
>>    schedule+0xb7/0x140
>>    ? __mutex_lock+0x51b/0xa60
>>    ? __mutex_lock+0x51b/0xa60
>>    schedule_preempt_disabled+0x54/0xa0
>>    __mutex_lock+0x51b/0xa60
>>    read_dummy+0x23/0x70
>>    full_proxy_read+0x6a/0xc0
>>    vfs_read+0xc2/0x340
>>    ? __pfx_direct_file_splice_eof+0x10/0x10
>>    ? do_sendfile+0x1bd/0x2e0
>>    ksys_read+0x76/0xe0
>>    do_syscall_64+0xe3/0x1c0
>>    ? exc_page_fault+0xa9/0x1d0
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   RIP: 0033:0x4840cd
>>   RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>>   RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
>>   RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
>>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>>   R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
>>    </TASK>
>>   INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
>>   task:cat             state:S stack:13432 pid:114   tgid:114 
>> ppid:106    task_flags:0x400100 flags:0x00000002
>>   Call Trace:
>>    <TASK>
>>    __schedule+0x731/0x960
>>    ? schedule_timeout+0xa8/0x120
>>    schedule+0xb7/0x140
>>    schedule_timeout+0xa8/0x120
>>    ? __pfx_process_timeout+0x10/0x10
>>    msleep_interruptible+0x3e/0x60
>>    read_dummy+0x2d/0x70
>>    full_proxy_read+0x6a/0xc0
>>    vfs_read+0xc2/0x340
>>    ? __pfx_direct_file_splice_eof+0x10/0x10
>>    ? do_sendfile+0x1bd/0x2e0
>>    ksys_read+0x76/0xe0
>>    do_syscall_64+0xe3/0x1c0
>>    ? exc_page_fault+0xa9/0x1d0
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   RIP: 0033:0x4840cd
>>   RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>>   RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
>>   RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
>>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>>   R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
>>    </TASK>
>>
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> ---
>>   Changes in v3:
>>    - Add RCU_LOCKDEP_WARN() to ensure rcu_read_lock() is held.
>>    - Cleanup code to make it fail-fast and add brace to
>>      for_each_process_thread().
>>    - Change the message to "likely owned" instead of "owned".
>>   Changes in v2:
>>    - Introduce CONFIG_DETECT_HUNG_TASK_BLOCKER for this feature.
>>    - Introduce task_struct::blocker_mutex to point the mutex.
>>    - Rename debug_mutex_get_owner() to mutex_get_owner().
>>    - Remove unneeded mutex_waiter::mutex.
>> ---
>>   include/linux/mutex.h  |    2 ++
>>   include/linux/sched.h  |    4 ++++
>>   kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
>>   kernel/locking/mutex.c |   14 ++++++++++++++
>>   lib/Kconfig.debug      |   10 ++++++++++
>>   5 files changed, 66 insertions(+)
>>
>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>> index 2bf91b57591b..2143d05116be 100644
>> --- a/include/linux/mutex.h
>> +++ b/include/linux/mutex.h
>> @@ -202,4 +202,6 @@ DEFINE_GUARD(mutex, struct mutex *, 
>> mutex_lock(_T), mutex_unlock(_T))
>>   DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>>   DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
>>   +extern unsigned long mutex_get_owner(struct mutex *lock);
>> +
>>   #endif /* __LINUX_MUTEX_H */
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 9632e3318e0d..0cebdd736d44 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1217,6 +1217,10 @@ struct task_struct {
>>       struct mutex_waiter        *blocked_on;
>>   #endif
>>   +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>> +    struct mutex            *blocker_mutex;
>> +#endif
>> +
>>   #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>>       int                non_block_count;
>>   #endif
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 04efa7a6e69b..ccd7217fcec1 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -93,6 +93,41 @@ static struct notifier_block panic_block = {
>>       .notifier_call = hung_task_panic,
>>   };
>>   +
>> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>> +static void debug_show_blocker(struct task_struct *task)

I think the easiest way forward is to change it to "#if 
defined(CONFIG_DETECT_HUNG_TASK_BLOCKER) && !defined(CONFIG_PREEMPT_RT)" 
to skip this feature for PREEMPT_RT right now . Otherwise, you will have 
to deal with the rtmutex code.

Cheers,
Longman

>> +{
>> +    struct task_struct *g, *t;
>> +    unsigned long owner;
>> +    struct mutex *lock;
>> +
>> +    RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
>> +
>> +    lock = READ_ONCE(task->blocker_mutex);
>> +    if (!lock)
>> +        return;
>> +
>> +    owner = mutex_get_owner(lock);
>> +    if (unlikely(!owner)) {
>> +        pr_err("INFO: task %s:%d is blocked on a mutex, but the 
>> owner is not found.\n",
>> +            task->comm, task->pid);
>> +        return;
>> +    }
>> +
>> +    /* Ensure the owner information is correct. */
>> +    for_each_process_thread(g, t) {
>> +        if ((unsigned long)t == owner) {
>> +            pr_err("INFO: task %s:%d is blocked on a mutex likely 
>> owned by task %s:%d.\n",
>> +                task->comm, task->pid, t->comm, t->pid);
>> +            sched_show_task(t);
>> +            return;
>> +        }
>> +    }
>> +}
>> +#else
>> +#define debug_show_blocker(t)    do {} while (0)
>> +#endif
>> +
>>   static void check_hung_task(struct task_struct *t, unsigned long 
>> timeout)
>>   {
>>       unsigned long switch_count = t->nvcsw + t->nivcsw;
>> @@ -152,6 +187,7 @@ static void check_hung_task(struct task_struct 
>> *t, unsigned long timeout)
>>           pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>>               " disables this message.\n");
>>           sched_show_task(t);
>> +        debug_show_blocker(t);
>>           hung_task_show_lock = true;
>>             if (sysctl_hung_task_all_cpu_backtrace)
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index b36f23de48f1..6a543c204a14 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -72,6 +72,14 @@ static inline unsigned long __owner_flags(unsigned 
>> long owner)
>>       return owner & MUTEX_FLAGS;
>>   }
>>   +/* Do not use the return value as a pointer directly. */
>> +unsigned long mutex_get_owner(struct mutex *lock)
>> +{
>> +    unsigned long owner = atomic_long_read(&lock->owner);
>> +
>> +    return (unsigned long)__owner_task(owner);
>> +}
>> +
>>   /*
>>    * Returns: __mutex_owner(lock) on failure or NULL on success.
>>    */
>> @@ -180,6 +188,9 @@ static void
>>   __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>>              struct list_head *list)
>>   {
>> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>> +    WRITE_ONCE(current->blocker_mutex, lock);
>> +#endif
>>       debug_mutex_add_waiter(lock, waiter, current);
>>         list_add_tail(&waiter->list, list);
>> @@ -195,6 +206,9 @@ __mutex_remove_waiter(struct mutex *lock, struct 
>> mutex_waiter *waiter)
>>           __mutex_clear_flag(lock, MUTEX_FLAGS);
>>         debug_mutex_remove_waiter(lock, waiter, current);
>> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>> +    WRITE_ONCE(current->blocker_mutex, NULL);
>> +#endif
>>   }
>
> This patch looks good, but there is a PREEMPT_RT complication that you 
> need to handle as well. Most of the mutex.c is compiled out if 
> CONFIG_PREEMPT_RT is defined.
>
> You can either add the CONFIG_PREEMPT_RT check in your 
> debug_show_blocker() function or in the mutex_get_owner() declaration 
> in mutex.h.
>
> You should enable CONFIG_PREEMPT_RT in a test build to make sure that 
> nothing break.
>
> Cheers,
> Longman
>


