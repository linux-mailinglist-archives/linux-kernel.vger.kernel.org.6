Return-Path: <linux-kernel+bounces-391248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBB9B8458
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C995F1F234AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506561CC153;
	Thu, 31 Oct 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBq8sjPq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AA1A2562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406498; cv=none; b=khHtXoUDGqvrDiDT750mjWGLb0m/fK67kWTpNTQlqewxUVyuPz+JfaWz42oIkJf+XgST9XrPMpjT+suAMHMfy7LbspfobwlyQ8lVKiT3R7kaTgC3RnVyxyaeZyIXmclTEocaYpSv9MGwRSHFb5cx3Xptf/9Rtt6tkwkYdzSnG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406498; c=relaxed/simple;
	bh=clDF0sjKjiDOht5bqF709QFeuHlakZRle4gxHCDbhe8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t89Iz3tZjkv2NhxsyCfgPMDByzBcxBF0em94OE7j5LRpVYHV48xY/h9flI3M1u8GA+7dfStWxqLoMDiz/txld2+AJhxkZ8FqoG6O7f6t6w5CXX90vvASvHW3xQSIwJulPWXQHanKcq87fsGoq0FHSy9CGsfYsy9f8gwRx5tYiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBq8sjPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730406495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nty5SIhJGEv2MmgXRoPlIOTMP9LLxYUWhZB396gBeg=;
	b=iBq8sjPqvsi8+Ik2YWw1jTD2WgMYHwNydI6PyLqWj7RrytfSKsLaAJ+lVmSZPJW04udyY1
	EUn2/B8yrT5lUpztGGY+lg3I8qALGWsswKckZRk1EvTKt5BR//86frCQ8UQpIEPidwT8MM
	aQrQ9uxmS3FsJ0O3TaPUT1X1Dlqasa8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-UiFC4xHgPjK9EMLZ3aAs3Q-1; Thu, 31 Oct 2024 16:28:14 -0400
X-MC-Unique: UiFC4xHgPjK9EMLZ3aAs3Q-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2885c5af51cso2266902fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406493; x=1731011293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nty5SIhJGEv2MmgXRoPlIOTMP9LLxYUWhZB396gBeg=;
        b=wARVfCM3+5GYhNYkx8GbXB2RbZwmsEU+Er9pVGDpIrf3irG/wvGZWyDIAhwXvndbZ1
         hnbtkkqkGuyGYA0YoQ8D7x7E9V+k7LUn9Rb6PuWEWaE/i1uGVrKlEPGEkGrjh+ouq02F
         hdN+wGMVh+PoMNstFZ8EALqGpFMy6wMgb0vX5+DD37iTQBH4Ts2peeKxNin1RCDCq9Hs
         4e4bIOE/Q0tDddme8U301DsmrwAZ7QLRbfrNN3cPi2NLZRuV/mMMMSl2NnoqzYSO8av4
         Nho1PP62G8GdpLAJTrsvxnVnkM/r/pAmG4DAOSzuJnGapUMUkdcC/3R2HJ846vo3upfq
         fnCA==
X-Forwarded-Encrypted: i=1; AJvYcCVryHaYE6Gz5cuNuzc5l6btYs29LysYSOiRLRcunkBy1JvbRnPe5o4nDXgbJhT1BilS9vN8pB1BWb+tU54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUq71E5dQLQx+6TRJFLXyDkKSWVu8Oo4+bu4ZGU09YOfQcHyKF
	et/hrFN3UtQH79A98JMgo5Ib8He7u9YFFR8ebnqZ3+O7qSQpLAR9AbgQMoPd2Hz5iUB5XaYmFll
	eB8oSPinKUAMvN+PqxbQVInGo7PtYCxAMoejy5SliK0MXK7JaR8QDNwWNvohrIQ==
X-Received: by 2002:a05:6870:c185:b0:25e:1382:864d with SMTP id 586e51a60fabf-2949f02016bmr1351309fac.30.1730406493255;
        Thu, 31 Oct 2024 13:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsyZhensTupItz64RbBz78gyP14sEJ46jgbD8vtyiUIwrojjT0LGWAxesESZ/bD/+5RzxULA==
X-Received: by 2002:a05:6870:c185:b0:25e:1382:864d with SMTP id 586e51a60fabf-2949f02016bmr1351291fac.30.1730406492968;
        Thu, 31 Oct 2024 13:28:12 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487778f20sm711568fac.57.2024.10.31.13.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:28:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e3cb2e03-9794-4bf9-8634-010261533146@redhat.com>
Date: Thu, 31 Oct 2024 16:28:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
 <20241031155640.Fhtm3uFD@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241031155640.Fhtm3uFD@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/24 11:56 AM, Sebastian Andrzej Siewior wrote:
> On 2024-10-28 13:13:54 [+0100], To linux-kernel@vger.kernel.org wrote:
>>                                                             Need to do
>> more testing.
> So there is "perf bench futex hash". On a 256 CPU NUMA box:
> 	perf bench futex hash -t 240 -m -s -b $hb
> and hb 2 … 131072 (moved the allocation to kvmalloc) I get the following
> (averaged over 3 three runs)
>
> buckets op/sec
>        2     9158.33
>        4    21665.66	+ ~136%
>        8    44686.66	+ ~106
>       16    84144.33	+ ~ 88
>       32   139998.33	+ ~ 66
>       64   279957.0	+ ~ 99
>      128   509533.0	+ ~100
>      256  1019846.0	+ ~100
>      512  1634940.0	+ ~ 60
>     1024  1834859.33	+ ~ 12
>           1868129.33 (global hash, 65536 hash)
>     2048  1912071.33	+ ~  4
>     4096  1918686.66	+ ~  0
>     8192  1922285.66	+ ~  0
>    16384  1923017.0	+ ~  0
>    32768  1923319.0	+ ~  0
>    65536  1932906.0	+ ~  0
>   131072  2042571.33	+ ~  5
>
> By doubling the hash size the ops/sec almost double until 256 slots.
> After 2048 slots the increase is almost noise (except for the last
> entry).

Looking at the performance data, we should probably use the global hash 
map to maximize throughput if latency isn't important.

AFAICT, the reason why patch 4 creates a local hash map when the first 
thread is created is to avoid a race of the same futex being hashed on 
both the local and the global hash maps. Correct me if my understanding 
is incorrect. So all the multithreaded processes will have to use local 
hash maps for their private futexes even if they don't care about latency.

Maybe we should limit the auto local hash map creation to only RT 
processes where latency is important. To avoid the race, we could add a 
flag to indicate if a private futex hashing operation had ever been done 
before and prevent the creation of local hash map after that.

My 2 cents.

Cheers,
Longman


