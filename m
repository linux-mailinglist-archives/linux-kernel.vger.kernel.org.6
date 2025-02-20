Return-Path: <linux-kernel+bounces-522919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB4A3D01B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509D9177E27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F11CDA0B;
	Thu, 20 Feb 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN4xHLvK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF04C6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022632; cv=none; b=aicL+zdn/EhpeHxyhn7oysQBzSowhZc+vtmXBjwGLO3T6KkgR6czcskmhHQehczOU1etS2tqvMBYAL0TxlJlkJemAw71zOla+1fRbJNVYkiNSBWX/4FLhpKyQ983hqGrc9Do+LUgpppxzhbkGOtEDg724Iym/zd3m1YZ6mdY9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022632; c=relaxed/simple;
	bh=hjRpAsgp90Evyaus4Ci9Ilku5xvI5AxJXA77lXsijFU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IiUxX4NHljc+QmtYrJw0bX5eZpwBwtxDW3gXuhqMkZ5r6tWFstvH87B22ZRY0Z59PJR2NW1PO57yu5+T5Hpael0hT1Z6dSjgNr+Ko5ERh0YVpfxf4PbvKleF+wFlCj03RttKO8nTqdWI1DEVQyiYrj/JOMbkbUtytRa5gL2pSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MN4xHLvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740022629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ow4Bas2JrZurs245FgxS4YuHQc9ZSsOuYeCiBScV/U=;
	b=MN4xHLvKMakPgeF+MGB1Qon+5LnhTwnbahUorOdWuRGMk3gTp4naoV1Lo+2h1UWrbu8PO6
	nTiZKRSyaXUDLvoQEpHnFuYNAAb0FNUBwt305B6gByfj9cFZ6taGf47tyUKf8qzFL3Rw/V
	2koueqVt4lTwXJ9GvsgeMAdwn9R97Vs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-xY8xrQWFOWOR6YnO42fd_g-1; Wed, 19 Feb 2025 22:37:07 -0500
X-MC-Unique: xY8xrQWFOWOR6YnO42fd_g-1
X-Mimecast-MFC-AGG-ID: xY8xrQWFOWOR6YnO42fd_g_1740022627
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3f40e8dabdbso148389b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740022627; x=1740627427;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ow4Bas2JrZurs245FgxS4YuHQc9ZSsOuYeCiBScV/U=;
        b=oCoKIhACE5udvE01X4xeKHjA5SsDZxy26DWkjT5eCWnvsk5O3DqjCBObc5GzHjOU1X
         FnhU0mfhUV48ydZHNFD7MCS4Tvsrwe5CUUVRJuB3tIv3Ta2UCdcUuDoz5VhHvLFsl0N+
         ZGbm5NQczJ4lanhPuPy76k4M5N0lO0eUqQ96zJ4cNdWEDleNtZ3hmRYq/FuB79y7Z54n
         FAigq14FQzFl4t+QHz2Rc12xOpC8YaqqGi0O2Vdh3wD8YwWCXl+YjjY+EaY4eICEGkx9
         RPYiZBknq7ssHLbtv+EJjPVkSnwCAMEp49ND1luSE1C4W8mx1fdnEHfw8rJh7Wi6VxSv
         kHKg==
X-Forwarded-Encrypted: i=1; AJvYcCXDh0gZTFmNLddYys1PibXiSQ7VC61mtG3CBoqHu9IRkOSdJHlCGyEAol2NlZbmB3G16/syJCFAjdyFwxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuePUUb0ar2Jwzdi9c3Ik0td9HKJep1m3+9qH/sd9P3LveYjp
	EQNRBk436jJ8JRFgCOrKO6dlgob5TwH04OEDD48ywVy5awCZNMiZ9FFvLFXMRPiB2n5A4nHjjCa
	9Re+H1gOM22xiCrfbZpizdE8VlVgHn+/49eQGvifJAHDGeLnYdfnGrV+OVJiMDA==
X-Gm-Gg: ASbGnctPUHX5KMCS3gxfliN7fXBtXgvI9X6IcLgpm2aIyXwqM0zD3WuTqViSinE/AFB
	xN+11OZGoMHgnR2QcXkoJy69TmrdiDQQgF6WquS8ci4OTzLZYrFjxidFUgKxQ5BV6QcE+X+TBjX
	dNxRrdKS+oor5ecySbhDZDGxqXcB1Glgf+KfjkwaKumINm0T6cgLjhcMmuYJoBEritpg4Og8C2S
	mBdbhCWsIJFDsLn4wJHr2IApGeYiTcMOb6O0lGL8EiF6Jt7qjRvvj6qzUPHkqAMTLfRAZqmY//w
	Tl1ZZfch9pouBMgjyrVUi4xxPkjwUa8HLkGRF4IHWbG2quRD
X-Received: by 2002:a05:6808:152b:b0:3f4:11b3:fe10 with SMTP id 5614622812f47-3f411b400c4mr4020783b6e.23.1740022626872;
        Wed, 19 Feb 2025 19:37:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtkqiQcRzaHD+Wga6oKqyRvebB42mVXu8FpnN1eMTxKeDPKC2F/l/pMGLPnwDIv/XvwUbczQ==
X-Received: by 2002:a05:6808:152b:b0:3f4:11b3:fe10 with SMTP id 5614622812f47-3f411b400c4mr4020762b6e.23.1740022626471;
        Wed, 19 Feb 2025 19:37:06 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fceba25fe7sm1657333eaf.37.2025.02.19.19.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 19:37:05 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bb5886cc-a512-4a59-98c7-f21128ab6194@redhat.com>
Date: Wed, 19 Feb 2025 22:37:04 -0500
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
Content-Language: en-US
In-Reply-To: <20250220115904.051e0cc55a9cb88302582ef4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/25 9:59 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 21:15:08 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> On 2/19/25 8:41 PM, Steven Rostedt wrote:
>>> On Wed, 19 Feb 2025 20:36:13 -0500
>>> Waiman Long <llong@redhat.com> wrote:
>>>
>>>    
>>>>>>>> this field, we don't need to take lock, though taking the wait_lock may
>>>>>>>> still be needed to examine other information inside the mutex.
>>>>> Do we need to take it just for accessing owner, which is in an atomic?
>>>> Right. I forgot it is an atomic_long_t. In that case, no lock should be
>>>> needed.
>>> Now if we have a two fields to read:
>>>
>>> 	block_flags (for the type of lock) and blocked_on (for the lock)
>>>
>>> We need a way to synchronize the two. What happens if we read the type, and
>>> the task wakes up and and then blocks on a different type of lock?
>>>
>>> Then the lock read from blocked_on could be a different type of lock than
>>> what is expected.
>> That is different from reading the owner. In this case, we need to use
>> smp_rmb()/wmb() to sequence the read and write operations unless it is
>> guaranteed that they are in the same cacheline. One possible way is as
>> follows:
>>
>> Writer - setting them:
>>
>>       WRITE_ONCE(lock)
>>       smp_wmb()
>>       WRITE_ONCE(type)
>>
>> Clearing them:
>>
>>       WRITE_ONCE(type, 0)
>>       smp_wmb()
>>       WRITE_ONCE(lock, NULL)
>>
>> Reader:
>>
>>       READ_ONCE(type)
>> again:
>>       smp_rmb()
>>       READ_ONCE(lock)
>>       smp_rmb()
>>       if (READ_ONCE(type) != type)
>>           goto again
> What about mutex-rwsem-mutex case?
>
> mutex_lock(&lock1);
> down_read(&lock2);
> mutex_lock(&lock3);
>
> The worst scenario is;
>
> WRITE_ONCE(lock, &lock1)
> smp_wmb()
> WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX
> WRITE_ONCE(type, 0)
> smp_wmb()
> WRITE_ONCE(lock, NULL)
> WRITE_ONCE(lock, &lock2)    READ_ONCE(lock) -> &lock2
> smp_wmb()
> WRITE_ONCE(type, RWSEM)
> WRITE_ONCE(type, 0)
> smp_wmb()
> WRITE_ONCE(lock, NULL)
> WRITE_ONCE(lock, &lock3)
> smp_wmb()
> WRITE_ONCE(type, MUTEX)     READ_ONCE(type) -> MUTEX == MUTEX
> WRITE_ONCE(type, 0)
> smp_wmb()
> WRITE_ONCE(lock, NULL)
>
>                              "OK, lock2 is a MUTEX!"
>
> So unless stopping the blocker task, we can not ensure this works.
> But unless decode the lock, we don't know the blocker task.

That could only happen if the reader can get interrupted/preempted for a 
long time. In that case, we may need to reread the lock again to be sure 
that they are stable.

Cheers,
Longman

>
> Maybe we can run the hung_task in stop_machine()?
> (or introduce common_lock)
>
> Thank you,
>


