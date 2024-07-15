Return-Path: <linux-kernel+bounces-251979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75224930C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7BA281311
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28555258;
	Mon, 15 Jul 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxcPmR6Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372754C79
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009351; cv=none; b=H4ODg1ECtJoSslzNWDfXAZ4mad+Hhd5bHdA+CTf+eBMibmFLoQKlhoIB5HE3Tjill50mIA0nijdkieCG72Xb7SK1EWxv9pnPioL02BlhFapADd27hTyjhs8hwA7W1nqYqDUBFw242O9SbRyiKF05HCGxLIBPJpB4SEMdngp7WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009351; c=relaxed/simple;
	bh=PSGB1XjsYSc8NTuRyyMVhTEZaT4OidUH2jBry1Hnohg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWHhLKf6vFmuR41IQ9/zTyVs2793WntykNPTr8rino/8/reD5CsGNX5J6YoGqO8q68tKGO+z9qWMLfc2O7q89qDoDosMOKUk8WQfnG4jyoJzw1UhZZ6PJspmIYmDKTqxiWAkuzF2XMSrIoNtHDkKYtHtOZssrCxKnDDI2lmtADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxcPmR6Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721009348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48LHOzY52BEKUvW29PKFsf6owCO62EQFfzDoBcBwjZg=;
	b=IxcPmR6ZyuZF/yphl3ZIDo0+BkoEMuh5CVOqD4O9gwmPSLZSMtsZ4dhlKDswnAXjeWH5Zw
	FW6pkXoclKXj/UQr3FV3jw0I8AS0GNyrYEK+q/HIjjW1Ou4XDHfiJFr8Q/OVUb5jBwyELQ
	WPtLXoPzgMCZOmaZJ9lv8hVFYYztEDg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-1zoR6OZ2PE6r3Tywc5mXag-1; Sun,
 14 Jul 2024 22:09:02 -0400
X-MC-Unique: 1zoR6OZ2PE6r3Tywc5mXag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E3ED19560AA;
	Mon, 15 Jul 2024 02:08:59 +0000 (UTC)
Received: from [10.22.64.27] (unknown [10.22.64.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41E8C1956066;
	Mon, 15 Jul 2024 02:08:55 +0000 (UTC)
Message-ID: <061e0f4f-2dc0-45c9-b407-020120047d24@redhat.com>
Date: Sun, 14 Jul 2024 22:08:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A new spinlock for multicore (>16) platform
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 =?UTF-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpRjDDKGq1F4cSBr@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 7/14/24 19:45, Bagas Sanjaya wrote:
> On Mon, Jul 15, 2024 at 01:07:40AM +0800, Shi-Wu, Lo（Gmail） wrote:
>> Dear Linux Contributors,
>> I am a Linux enthusiast from Taiwan, and I hope to contribute to the
>> Linux kernel. We have developed a new spinlock method that has been
>> validated on AMD 64-core and AMD 32-core processors. Compared to
>> previous methods, this new method is optimized in the following areas:
>>
>> Motivation and Approaches:
>> 1. As the number of cores increases, there is a need for more refined
>> optimization of the data transmission paths between cores.
>> 2. Data transmission usually involves lock-unlock wrapping.
>> 3. Performance improvement can be achieved using a shortest path
>> approximation algorithm.
>>     A detailed introduction to this method can be found in the following paper:
>> https://www.usenix.org/conference/osdi23/presentation/lo
>>
>> Our laboratory is currently developing a system that can apply the
>> same optimization strategy to all multi-core processors. Below is our
>> plan.
>>
>> The New Method and Its Compatibility with qspinlock:
>> 1. The default algorithm in the Linux kernel remains qspinlock.
>> 2. A new file is created in /proc/routing_path, where a shortest path
>> can be input, for example:
>> sudo echo 1,2,3,4,16,17,18,19,5,6,7,8,11,12,13,14 > /proc/routing_path
>> 3. After inputting the shortest path, the kernel switches to using the
>> RON algorithm.
>>
>> Expected Outcomes:
>> According to our measurements on AMD 32-core and AMD 64-core
>> processors, Google LevelDB can achieve a 3-4% speed improvement.
>>
>> Comparison with Previous NUMA-aware algorithms:
>> Compared to NUMA-aware results, since such systems may contain more
>> than two processors, the communication cost between processors is much
>> higher than the communication cost between cores (within the same
>> processor). Our method focuses on multiple cores within a single
>> processor, making it multicore-aware. If a NUMA-aware algorithm is
>> used in a multicore environment, it is not as effective as a
>> multicore-aware algorithm. (Please refer to the paper,
>> https://www.usenix.org/conference/osdi23/presentation/lo)
>>
>> Assistance Needed:
>> I would like to understand if the Linux kernel community is interested
>> in this new spinlock method. As a teacher, I cannot complete all the
>> work by myself. Is anyone willing to collaborate with me on this
>> project?
>>
>> Sorry to bother you:
>> I apologize for taking up so much of your time with this letter.
>> Although I am quite old, this is the first time I feel that my
>> research results are good enough to contribute to the Linux community.
>> I have read the relevant documentation, and it made me realize that my
>> time and abilities are insufficient to write the high-quality code
>> required by the Linux community. Therefore, I ask for your guidance.
> I can't really say about this topic (as I'm not subject-matter expert here),
> so Cc: relevant maintainers.

After a quick look at the algorithm of the paper, I believe there are 2 
major issues with this algorithm.

1) Each lock requires a routing table of size num_possible_cpus() for 
the routing table. There can be thousands of spinlocks in the kernel and 
it may be problematic to manage this extra memory.

2) Beside lock contention performance, the Linux kernel also has to 
provide good uncontended spinlock performance. The unlock code currently 
scan the routing table to find the next one to allocate the lock to 
which may slow down the uncontended spinlock performance.

I believe this new lock can certain improve performance in a highly 
contended case, but I am not sure if it is a gain or loss in the 
uncontended or some less contended cases. Anyway, the 3-4% performance 
improvement in a contended lock may not be good enough for the 
performance loss in an uncontended lock.

There were attempts to introduce numa-awareness to qspinlock in the past.

https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/

It was not accepted at the time because the of the increase in code 
complexity and the unfairness aspect of the implementation.

Thanks,
Longman


