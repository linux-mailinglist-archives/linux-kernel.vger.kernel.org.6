Return-Path: <linux-kernel+bounces-515095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67909A35FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DBF16C421
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A718265CBD;
	Fri, 14 Feb 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPNJrGj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91D265CA9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542186; cv=none; b=fpGGIOjJwDw89Cwg7pabToeY8XdzLQpi/YM8dEaMgeA9MSVPPzWZrPETfWMr70YpYcaMlMhvJzySYoKAwmdOOGf0xQ34Q2Dos7Z7f9MQGJxFfdTWf6i05yVD4LF84pUDqo5nnmmSzmfFvpgyuTX2uJTzQnB3YSbeFk1wsx82dLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542186; c=relaxed/simple;
	bh=vdf2buP3QmO1fAInTqv30RGHRNx+/45EQKLg7iAGPwI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uhZGFzNdA/d87MQX6cW5PpvFn4+ymdFYPSmnHkEX801CFr2qAHLs7hddi8beSs6TtE8xhnbJPEGPe3HlehxFFX/vgnrpmeNW6Es9da+wzAh9wBt+tfT7VLDJsgv6JfOHlkAgO5xc1jT47JHjXbXpXUqVDyKgrp1mTXTmdgjoIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPNJrGj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739542184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvGobuu5yf2ROvpcfD7xIalvhR+r0zTyAfpxi1cLeBw=;
	b=PPNJrGj3uovtS9SaCOIlg+A3wgTiJOqDzpLvGVU3Kotapf3sqglRyGldmlL+k3lxPNC3bE
	8Q8YNobmkm1R3PhrO48imkP6a9HryRpqK/HJmt0vmh0+CyFaQabF7onQOtexQGFD59RY+q
	HlKICDkE1L7gDz43ZYsr3fyVyen04hc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-3sY5dwK6PqOiGe371p16oQ-1; Fri, 14 Feb 2025 09:09:40 -0500
X-MC-Unique: 3sY5dwK6PqOiGe371p16oQ-1
X-Mimecast-MFC-AGG-ID: 3sY5dwK6PqOiGe371p16oQ_1739542180
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e454ebef9dso43898266d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542180; x=1740146980;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvGobuu5yf2ROvpcfD7xIalvhR+r0zTyAfpxi1cLeBw=;
        b=ZWJ8H4aeHxXkVWPnJenpMX9Ma8jTWx4nT/fEU0PrZXjcVrc0AzNxfDfyPDDCmnFuHI
         msQMcmKWTs+W3eGsGNHRUoLTrQAgxAuH/478rxq/FYKcOIxhmaz9h76GAP5O/kTY0Ai1
         SCDpPhFhQen4WJ+7pPNfa4s+Tx3cIvAjBQ4iwDQ47vr3pkyUEekv1G+SZr5ilgD1iDHH
         /B4MW0cOzbyxFexZUOJUTfcqeVisvKjFx3GpH0JiDpUi4QwMnoxZOebXSnIyBpDe2BJX
         YyWRoGCSXWZ4sg1nk3QzaWqHTwCVnaNAh5q1N//zYXkaniu9DZPn2pWmoeQRWFD6oB1/
         q4RA==
X-Forwarded-Encrypted: i=1; AJvYcCUotOE5uJxWKHfUWl8NlNVBrUg8JHcDfBb1xMtJuze+WaywS93yTdKggimJ5sAjkZoZZ5lIvPlOFV51gSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlI8VXRpRr5FrMlskarZvexOym8MLVwGiEku5CcKMXKy3r2rTL
	T7KCuh3hTDk66a3opfUYS/EWJ39bhdd+ntwvWnguONuypf9vVJctNYB+WwzWqw93HyRBdfWvsdK
	ERx3lehPOUCxH7MtmBrrNtmftVfRCZmuOeFqH9pThJ/gGOd6+F+TKT3A6wWMXDw==
X-Gm-Gg: ASbGncv3wkBN6PFqgOR2CWkEuf83C3xs+wThAn15GC4/iZDC6YlxBntJ2lWwYSVHJZW
	Ehf/WdLdlf29P2uU4bLrQM/5qdqMn6+uDNkRRVG9xzC1DZFPQABKAyBk0f2BjISDdzgwOzjHvQs
	zew3qicXEmSQsIAOiOaXYmLcBM3SjzU0AiCXG3Bvwqtg8sKgVZWtimoQU9mvSXmb4nNb2QtuuIp
	ULgfenIUBZxLqp/SHd+YYAOB6GfrJym/md1jMvBZXwWWIaAb9mUF+jPfb69PVJLqo20Svo0LM+E
	azXSK3Ja9EpaRHh0HSAciBIP3/bm2W3hQzR3op1qIEUzMfMc
X-Received: by 2002:a05:6214:21ed:b0:6e6:69e4:650d with SMTP id 6a1803df08f44-6e669e46531mr16751766d6.20.1739542180125;
        Fri, 14 Feb 2025 06:09:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtpTTL88oyiS7uAP9sa/kZDuViaNom/84z8a4uEJn8RCEiKOdU9zcfTKs9rK04QEqOEK6aeg==
X-Received: by 2002:a05:6214:21ed:b0:6e6:69e4:650d with SMTP id 6a1803df08f44-6e669e46531mr16751416d6.20.1739542179802;
        Fri, 14 Feb 2025 06:09:39 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785bdbsm21242156d6.38.2025.02.14.06.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:09:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3d069c26-4971-415a-9751-a28d207feb43@redhat.com>
Date: Fri, 14 Feb 2025 09:09:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in
 lock_acquire()
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20250213200228.1993588-1-longman@redhat.com>
 <20250213200228.1993588-5-longman@redhat.com>
 <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNM-uN81Aje1GE9zgUW-Q=w_2gPQ28giO7N2nmbRM521kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 5:44 AM, Marco Elver wrote:
> On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>> KASAN instrumentation of lockdep has been disabled as we don't need
>> KASAN to check the validity of lockdep internal data structures and
>> incur unnecessary performance overhead. However, the lockdep_map pointer
>> passed in externally may not be valid (e.g. use-after-free) and we run
>> the risk of using garbage data resulting in false lockdep reports. Add
>> kasan_check_byte() call in lock_acquire() for non kernel core data
>> object to catch invalid lockdep_map and abort lockdep processing if
>> input data isn't valid.
>>
>> Suggested-by: Marco Elver <elver@google.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Marco Elver <elver@google.com>
>
> but double-check if the below can be simplified.
>
>> ---
>>   kernel/locking/lock_events_list.h |  1 +
>>   kernel/locking/lockdep.c          | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
>> index 9ef9850aeebe..bed59b2195c7 100644
>> --- a/kernel/locking/lock_events_list.h
>> +++ b/kernel/locking/lock_events_list.h
>> @@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)  /* # of rt_mutex_handle_deadlock()'s    */
>>   LOCK_EVENT(lockdep_acquire)
>>   LOCK_EVENT(lockdep_lock)
>>   LOCK_EVENT(lockdep_nocheck)
>> +LOCK_EVENT(lockdep_kasan_fail)
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 8436f017c74d..98dd0455d4be 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -57,6 +57,7 @@
>>   #include <linux/lockdep.h>
>>   #include <linux/context_tracking.h>
>>   #include <linux/console.h>
>> +#include <linux/kasan.h>
>>
>>   #include <asm/sections.h>
>>
>> @@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>>          if (!debug_locks)
>>                  return;
>>
>> +       /*
>> +        * As KASAN instrumentation is disabled and lock_acquire() is usually
>> +        * the first lockdep call when a task tries to acquire a lock, add
>> +        * kasan_check_byte() here to check for use-after-free of non kernel
>> +        * core lockdep_map data to avoid referencing garbage data.
>> +        */
>> +       if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
> This is not needed - kasan_check_byte() will always return true if
> KASAN is disabled or not compiled in.
I added this check because of the is_kernel_core_data() call.
>
>> +                    !is_kernel_core_data((unsigned long)lock) &&
> Why use !is_kernel_core_data()? Is it to improve performance?

Not exactly. In my testing, just using kasan_check_byte() doesn't quite 
work out. It seems to return false positive in some cases causing 
lockdep splat. I didn't look into exactly why this happens and I added 
the is_kernel_core_data() call to work around that.

Cheers,
Longman


