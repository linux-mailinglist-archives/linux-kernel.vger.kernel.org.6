Return-Path: <linux-kernel+bounces-401703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D89C1E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4209D281FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D91EB9F2;
	Fri,  8 Nov 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET7oyFTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FF1E885B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073161; cv=none; b=qIiziX64J8eGCx/6JglB0Z/t40Ao2GTLPDzhQdaq8oVWHElmmIcNfLOs1PD+2SzNdW6NUJDxYYalr6GKsm2ZccRSZjjKacAndGwJYyQzacFeDCEJd2+mZXn8HxiHHnoNxtH1E9x0QVIH3Xlndib1cpjiMd5a4sc0XW3ad2P/f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073161; c=relaxed/simple;
	bh=Th+6aYVsO/JVj/6MkWgQddDZHqpcqRK+Th5MitpRU2k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pLwEo+XJQFtAOaPGcbZ8VdDZkS/VS4/CFzHocdI0JeRQLiz7XSAmm5uJMV2q8Y7GlZ85sk4wY+AeBjpJ/UJgowATAR4IBFid86i6OKgNEcB4rD4pXHLfO4X8UrUwOYldqm4nV19omvQi00UEt5HsgnIohJ4hHjEp5wU3z0gAQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET7oyFTw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731073158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7AkiWtd21jJpLfGOXDePP61e50AvdxBgODeE0rxnRo=;
	b=ET7oyFTwkDKsyS+9v3HhrQlngqByukIq3Ru5HpG+wcYLpHAyJvyul83Mfz6G7ZZT/jnWpl
	T8VtG7ctx30rJHygHR3cxf6VPNKmmIksAvyOBrmRvtueoKjgPRXbf3jO8hky8eTA4yn6Dp
	OFJBDm7M70Oe8Ba1jhyGNfVoZXqyNgw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-gf1KhLgzMlmm0sOeyUcLiQ-1; Fri, 08 Nov 2024 08:39:17 -0500
X-MC-Unique: gf1KhLgzMlmm0sOeyUcLiQ-1
X-Mimecast-MFC-AGG-ID: gf1KhLgzMlmm0sOeyUcLiQ
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6eaa08a6fdbso38391537b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073156; x=1731677956;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7AkiWtd21jJpLfGOXDePP61e50AvdxBgODeE0rxnRo=;
        b=bXeDtEstjpBtTAVoqJrrnYn4Bp++hBnhbblngFYVUU2g2PJvgjvdlM6R72e3AVIWoB
         k5xvigQy2RnVDV9UYfttELjzfErDr+S/6jtGt/9i2IEqUcVM0SJDygeami5kv7wGDUHO
         IB/RbhKSUFMPIF3/VdaVv3gF65I/4omA7nmkunwXJ7EoAt2QoYnflpMkcTBBIHiJ9Zrv
         iDmMT8mTTs2c986hISJAWOVHg79RbHYcwgVN4FyLw593hmdQnU7ChVhD1jU4A+UNnQyI
         adM8xd1/pECPWo2bKprI4N/9feP3s4X5psVnEIX3X8mOwGr3j+UT9djmLTZqdRhAUIiw
         ddXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUJSo8ljgwJW/n3dm5tcE6tnvK+oF/nPH77cZNDLTMiFaOeEs4XLIyojeCjaHWrS44yFWf1zw5vBi2RFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUjNFrzay6cIZqeGIFMJazBztgLGOLFe118CWoI/Tre3BDsnE
	wsRpOs/Ffoq7gw5yP/POetTWp0TFT0rnOLqbrTuMhBmHZ9irAzelJShtqdtrLhJT1BFjnsGous7
	Rnk06LkFmmajyCQWU5Cw3Nwma2QRQi2vIbYNEZvkXzcgJjrFak2ZF8XEArJkWMS8uA3deZw==
X-Received: by 2002:a05:690c:7485:b0:6e3:fb4:9333 with SMTP id 00721157ae682-6eaddf6f3dcmr33789097b3.28.1731073156347;
        Fri, 08 Nov 2024 05:39:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC3LnD2Ma9hnbqvMJDYhEEYZKe9ZIOFRhjPAZ94ZyiBVJhrGaZ3E2FsrLBSl4y2DVQ7uQmBg==
X-Received: by 2002:a05:690c:7485:b0:6e3:fb4:9333 with SMTP id 00721157ae682-6eaddf6f3dcmr33788757b3.28.1731073155974;
        Fri, 08 Nov 2024 05:39:15 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dc1esm160203885a.18.2024.11.08.05.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:39:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <735344cd-1c32-451f-904e-235578e1a360@redhat.com>
Date: Fri, 8 Nov 2024 08:39:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Skip overflow check if 0 capacity
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241108042924.520458-1-longman@redhat.com>
 <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/8/24 8:25 AM, Juri Lelli wrote:
> On 07/11/24 23:29, Waiman Long wrote:
>> By properly setting up a 1-cpu sched domain (partition) with no
>> task, it was found that offlining that particular CPU failed because
>> dl_bw_check_overflow() in cpuset_cpu_inactive() returned -EBUSY. This
>> is due to the fact that dl_bw_capacity() return 0 as the sched domain
>> has no active CPU causing a false positive in the overflow check.
>>
>> Fix this corner case by skipping the __dl_overflow() check in
>> dl_bw_manage() when the returned capacity is 0.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/deadline.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index be1b917dc8ce..0195f350d6d3 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -3479,7 +3479,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>>   	} else {
>>   		unsigned long cap = dl_bw_capacity(cpu);
>>   
>> -		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>> +		/*
>> +		 * In the unlikely case of 0 capacity (e.g. a sched domain
>> +		 * with no active CPUs), skip the overflow check as it will
>> +		 * always return a false positive.
>> +		 */
>> +		if (likely(cap))
>> +			overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> The remaining total_bw that make this check fail should be the one
> relative to the dl_server on the cpu that is going offline. Wonder if we
> shouldn't rather clean that up (remove dl_server contribution) before we
> get to this point during an hotplug operation. Need to think about it a
> little more.
static inline bool
__dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
{
         return dl_b->bw != -1 &&
                cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
}

With a 0 cap, cap_scale(dl_b->bw, cap) will always be 0. As long as 
total_bw isn't 0 and bw isn't -1, the condition will be true.

Cheers,
Longman


