Return-Path: <linux-kernel+bounces-170041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE68BD102
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DC1F22142
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECA154433;
	Mon,  6 May 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2DfIxbf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D815359F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007939; cv=none; b=ULfojMqdt6T76hsGUJt7lNQZ3lHtOsgRpXGfL9vzd7AkREAQm0inoi+3upo7hoifLxsizcf5s4i3k9S+Xfzouj0VWF90kBJwPZfUTrRMDJiGqZbjqwXr02r977W1d9nDsOBbKuu4HKmDDN3am1TIUUrLGcFS2ZGkXLbPZgtoyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007939; c=relaxed/simple;
	bh=pwUPJqSGaVxRG3VA0JRT0gFWsqDaBMCCyALOjtCGlJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikPbaGOJquAPIEqCair4O7k/R5WmFfS52M/wDexZAn5uk/2Di6+6QcjXj35oVGYeuc6akd0WlG0D3oV5+LN/i8wBiyKi8G/68T/DoTGPkDpYJhG4z+8NxpAUCIES2M/ABOWZRq5OJjmJtMCskPuJsjdtnV/6eKq1f3z02l31WPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2DfIxbf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715007936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y43xCC2ORJwXxDBQyZMiQf+AzAg+xaw7pKNsy092Gws=;
	b=U2DfIxbfmHTjKQJyevOF+4mDvBZVXQ0+AeuY+mvlcVEZLpAB8+NJ8UtjrrFQhZcSkJzXk1
	3x6YENWmm3SWVbnPxaFnspJdiszcOBJT+zmkoaYjLgClFIxNeOptc3Dcg4CozsWfw0Tp0+
	PxKs7+ELcOKPgNzZQnTuUKLasjfAajo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-EralcbDbMqOGvUgRqeAwxA-1; Mon, 06 May 2024 11:05:32 -0400
X-MC-Unique: EralcbDbMqOGvUgRqeAwxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9392388CE81;
	Mon,  6 May 2024 15:05:32 +0000 (UTC)
Received: from [10.22.17.85] (unknown [10.22.17.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4293F1C060D0;
	Mon,  6 May 2024 15:05:32 +0000 (UTC)
Message-ID: <7628453e-c418-49bb-be0a-50bc4248b7b9@redhat.com>
Date: Mon, 6 May 2024 11:05:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/qspinlock: Save previous node & owner CPU into
 mcs_spinlock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Vernon Lovejoy <vlovejoy@redhat.com>
References: <20240504024106.654319-1-longman@redhat.com>
 <20240506103637.GM40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240506103637.GM40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 5/6/24 06:36, Peter Zijlstra wrote:
> On Fri, May 03, 2024 at 10:41:06PM -0400, Waiman Long wrote:
>
> Not much of a fan of this thing, but I suppose it won't hurt too much ...
I purposely doesn't touch the fast path and add code only to slow path 
to make sure there shouldn't be any noticeable performance impact.
>> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
>> index 85251d8771d9..cbe6f07dff2e 100644
>> --- a/kernel/locking/mcs_spinlock.h
>> +++ b/kernel/locking/mcs_spinlock.h
>> @@ -13,12 +13,19 @@
>>   #ifndef __LINUX_MCS_SPINLOCK_H
>>   #define __LINUX_MCS_SPINLOCK_H
>>   
>> +/*
>> + * Save an encoded version of the current MCS lock owner CPU to the
>> + * mcs_spinlock structure of the next lock owner.
>> + */
>> +#define MCS_LOCKED	(smp_processor_id() + 1)
>> +
>>   #include <asm/mcs_spinlock.h>
>>   
>>   struct mcs_spinlock {
>>   	struct mcs_spinlock *next;
>> -	int locked; /* 1 if lock acquired */
>> -	int count;  /* nesting count, see qspinlock.c */
>> +	int locked;	 /* non-zero if lock acquired */
>> +	short count;	 /* nesting count, see qspinlock.c */
>> +	short prev_node; /* encoded previous node value */
> Strictly speaking, count shouldn't ever go much higher than 4, so I
> suppose a byte should be sufficient. That would then leave 24bit for the
> prev thing, but you'll get to use bitfields or some other horrible
> thing.
Using bit field will be more expensive. So I am deferring that until the 
time it becomes necessary.
>>   };
>>   
>>   #ifndef arch_mcs_spin_lock_contended
>> @@ -42,7 +49,7 @@ do {									\
>>    * unlocking.
>>    */
>>   #define arch_mcs_spin_unlock_contended(l)				\
>> -	smp_store_release((l), 1)
>> +	smp_store_release((l), MCS_LOCKED)
> This leaves ARM up a creek I suppose... Also, there's but a single
> MCS_LOCKED user.

I am aware that ARM has its ownarch_mcs_spin_unlock_contended() macro 
defined. That is why I define the MCS_LOCKED macro before including 
asm/mcs_spinlock.h. I am planning to send an arm patch to change 1 to 
MCS_LOCKED if this patch is merged to close the gap. None other arches 
have arch_mcs_spin_unlock_contended() macro defined.

Cheers, Longman


