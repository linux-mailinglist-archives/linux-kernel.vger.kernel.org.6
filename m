Return-Path: <linux-kernel+bounces-330059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6543979919
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8309F282C44
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BBA47F5F;
	Sun, 15 Sep 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrJzMwqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583517C69
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434383; cv=none; b=EAmd13ia/FQxyZnAnYBZMsf9BoLY7oPq+221uJN5d5+z/n+LjlFU8pxzhVOaGy4aY37pRScWjaSseoUHQCRbEV5/Tm/w20S40A38pal+wTiiR0QOiPbGBS5UDTTIhJd3KAb+0K8ZxjhvQ/deGZXemOfy80oBmmMV7Eo3r2qfTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434383; c=relaxed/simple;
	bh=VTeWG0/achFcJkMFubNhd3Hqr6YIm0U2U7oJtSuJteY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHxc+EvZG9RRFpe0Z9sMRZTfdYxuXnpCc+V+6dn8RpIb7tKhkVWIlRXLc9s3sXN8N5/3yAzbwOWB1WjtR3fYQ5tn3093QVwLJVymnzqKsLnnyHj2Udz5d+aKqHkD4nLORAyU10AuEtARKypbesey8UpweCovOB9SUIohleG1Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrJzMwqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726434380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjG2AT8F3XQfonol0zYOj7Kgq7T42Ks5Rvtk/ww6Tx4=;
	b=BrJzMwqTqJe/0bZfV9yUEYBVWuPu7e7Ptg0SOA6QAZCAFWi9qF2q2+Z84TNOvoUnA9OJh/
	oQQgUcJdZrnzO3Y8PXBnm4qp28XNJb5yHjGI9PER3F7gei1dAueIrih1lqyrqr65HorQo5
	HC2/bNrDYdL/M9gKjVk7a0DgiJPP2Ks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-PD-EjNkmOG6GY1g56rYKJA-1; Sun,
 15 Sep 2024 17:06:17 -0400
X-MC-Unique: PD-EjNkmOG6GY1g56rYKJA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD1B019560B4;
	Sun, 15 Sep 2024 21:06:14 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CE7C19560AA;
	Sun, 15 Sep 2024 21:06:11 +0000 (UTC)
Message-ID: <afddc02d-fa96-4793-bc60-6c81629d8d5b@redhat.com>
Date: Sun, 15 Sep 2024 17:06:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to
 numa-aware lock/unlock.
To: Uros Bizjak <ubizjak@gmail.com>, yongli-oc <yongli-oc@zhaoxin.com>,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-4-yongli-oc@zhaoxin.com>
 <fd0e5627-b89c-d25b-bbf5-edc712642f85@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <fd0e5627-b89c-d25b-bbf5-edc712642f85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9/15/24 14:44, Uros Bizjak wrote:
>
>
> On 14. 09. 24 10:53, yongli-oc wrote:
>> According to the contention level, switches from x_osq_lock to
>> numa-aware osq_lock.
>> The numa-aware lock is a two level osq_lock.
>> The Makefile for dynamic numa-aware osq lock.
>>
>> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
>> ---
>>   kernel/locking/Makefile      |   1 +
>>   kernel/locking/numa.h        |  98 ++++++++
>>   kernel/locking/numa_osq.h    |  32 +++
>>   kernel/locking/x_osq_lock.c  | 332 +++++++++++++++++++++++++++
>>   kernel/locking/zx_numa_osq.c | 433 +++++++++++++++++++++++++++++++++++
>>   5 files changed, 896 insertions(+)
>>   create mode 100644 kernel/locking/numa.h
>>   create mode 100644 kernel/locking/numa_osq.h
>>   create mode 100644 kernel/locking/x_osq_lock.c
>>   create mode 100644 kernel/locking/zx_numa_osq.c
>
> ...
>
>> +    if (lock->numa_enable == OSQLOCKSTOPPING && old == 
>> OSQ_UNLOCKED_VAL)
>> +        old = OSQ_LOCKED_VAL;
>> +
>> +    for (;;) {
>> +        if (READ_ONCE(lock->tail16) == curr &&
>> +            cmpxchg(&lock->tail16, curr, old) == curr) {
>
> I would like to ask if there is any benefit to read the location two 
> times? cmpxchg() reads the location and skips the update when curr is 
> different from the value at the location by itself. Using 
> try_cmpxchg() can produce even more optimized code, since on x86 arch 
> CMPXCHG also sets ZF flag when operand 2 is equal to the value at 
> location (and update happens), and this flag can be used in a 
> conditional jump.

The major reason is for doing a read first before cmpxchg() is to avoid 
the overhead of an atomic operation in case the current task isn't the 
tail. We usually optimize for the case with a lot of incoming lockers 
where the chance of a match isn't particularly high.

Cheers,
Longman


