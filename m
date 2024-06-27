Return-Path: <linux-kernel+bounces-232317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035DF91A6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346711C21B31
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A015ECE8;
	Thu, 27 Jun 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C77bqH/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27A15ECD3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492153; cv=none; b=eAc+4rhXhEKSwM0lyAWbIym2AE2OanN0yY/aeQi+vPWKJ5hUSccYrgTtCc64kTsLq4Md7PAadNqDkO7I/3kP4vd7Rkxe+08G0Ldy/ulAJFEHLcLvJFTo0rEIUJBnzkJ2LSqGgGnkBm+2qnH0X1cjfjtz77dLoJhH6j1nS9qByw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492153; c=relaxed/simple;
	bh=F1b/lfr3BFh8K//qil04PYLCkTTM+EbSKh8SHWWOKBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rheercw1Uro6fa7S3NuKfJe7Wk5S4TEALITq23xjosB0Sz89IqlNvxuqaWrlgKJGw42E7SZFU8xEV0mnHsuVxRSbQomLKZyMXXm56FcXYWalGHuRMHwCUVrrnbz1pUS4lRfmgxRk0Hty0JXNPy8v74mPyRrEKap/Gg+BcvSUXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C77bqH/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YpYtOnZ3MZes63oloaokXEkL8DoVtv8afe3xmyYww0=;
	b=C77bqH/2lk1eYV+D/GvVsxUVT9N8hntisUo6DP0GoOVM+Trb0KuwV6B/zq5p+CSrplu29P
	O8N20ruSIPRv6GF9HWvQB4VNz3ZQXt8fsvrmYcXdTL5AxG2krP1HovYKYvl1cIcWflnVje
	QIQ95X9EHvu2hSJcnNt6KB9G92Q6ErY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-A5TBaXrkNUmbZmastdxPZA-1; Thu,
 27 Jun 2024 08:42:26 -0400
X-MC-Unique: A5TBaXrkNUmbZmastdxPZA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 648AB1944D3B;
	Thu, 27 Jun 2024 12:42:24 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BA151956054;
	Thu, 27 Jun 2024 12:42:22 +0000 (UTC)
Message-ID: <0fdc06b6-747d-4f54-8a2a-1af9912e382d@redhat.com>
Date: Thu, 27 Jun 2024 08:42:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] workqueue: Improve scalability of workqueue watchdog
 touch
To: Hillf Danton <hdanton@sina.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20240627121628.2278-1-hdanton@sina.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240627121628.2278-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 6/27/24 08:16, Hillf Danton wrote:
> On Tue, Jun 25, 2024 at 09:42:45PM +1000, Nicholas Piggin wrote:
>> On a ~2000 CPU powerpc system, hard lockups have been observed in the
>> workqueue code when stop_machine runs (in this case due to CPU hotplug).
>> This is due to lots of CPUs spinning in multi_cpu_stop, calling
>> touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
>> wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
>> and that can find itself in the same cacheline as other important
>> workqueue data, which slows down operations to the point of lockups.
>>
>> In the case of the following abridged trace, worker_pool_idr was in
>> the hot line, causing the lockups to always appear at idr_find.
>>
> Wonder if the MCS lock does not help in this case.

This patch just tries to avoid polluting the shared cacheline leading to 
excessive cacheline bouncing. No locking is involved. I am not sure what 
you are thinking about using MCS lock for.

Regards,
Longman

>>    watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
>>    Call Trace:
>>    get_work_pool
>>    __queue_work
>>    call_timer_fn
>>    run_timer_softirq
>>    __do_softirq
>>    do_softirq_own_stack
>>    irq_exit
>>    timer_interrupt
>>    decrementer_common_virt
>>    * interrupt: 900 (timer) at multi_cpu_stop
>>    multi_cpu_stop
>>    cpu_stopper_thread
>>    smpboot_thread_fn
>>    kthread
>>


