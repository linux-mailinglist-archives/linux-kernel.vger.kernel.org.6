Return-Path: <linux-kernel+bounces-402962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A631E9C2F05
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D2428241C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102CF19DF99;
	Sat,  9 Nov 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5Uz1WiF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1B29CF4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176305; cv=none; b=mCIgJXvoZj9TyMio6DgRgEacaH1QLyAyylQN0hIZIy74nBMjYHZQG2CX8so/T6HMS3GeEID+DQEVG/j5koa6pBF7iZmzUd+wKNGydHif3NGZtkMblB+PuBBQ57X2rODCj6F/vQshLB1EsRgoE4RJvnUI8hE72+lRz063+QY37mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176305; c=relaxed/simple;
	bh=AdBVtku9OHGYHPMRtzIcKYmQn1RHh/7QKvXpJqM6jY4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LdEBYXD14cmD+WqIRjRyPPxXkhmwsWJBYKRwH01bKyq5oIjrGJHB51ZsKYoWt3rszx4tF9To4o0xuI2+VqlmiRgyaYXKPA1wMkhXDsTP8DfjAD4K2rtmpaEhS0EHacP5aE94MEXlNcemhoPe5fepSDlzYQRxizCWtdy/ty+08XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5Uz1WiF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731176302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZceLSWwaG3m1lst/hPVRtV9JqwN+LCux/GOk3HRfSqM=;
	b=T5Uz1WiFyB4NzyEyT60M8cP07nuUYAcGIoRlqHwuUAPUUXxjZakKFiYdpPS7pZCoF6dfEu
	mUyPpx4xG/o8v9xs9HYsTjo17oy0EtttDs7+7UDkXpVX7LvUuj+XmMC+9rEZFVVBEiw5IJ
	t+IsLGawJ0zQHElVroRvvLa+Le94xTE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-h_jku7pSPHy1Mm22upj86A-1; Sat, 09 Nov 2024 13:18:20 -0500
X-MC-Unique: h_jku7pSPHy1Mm22upj86A-1
X-Mimecast-MFC-AGG-ID: h_jku7pSPHy1Mm22upj86A
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b14f4f66a4so726653285a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 10:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731176299; x=1731781099;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZceLSWwaG3m1lst/hPVRtV9JqwN+LCux/GOk3HRfSqM=;
        b=bLJESRfOGxVMvv3vRJ7EOifu3Kla+VG+YhnFV94ymupFFiZiwPkS0Pzqq0eFfcVkrJ
         hiYTPj4Rt6rINXRSJyEvz+pV2BAa3lk0yPYXMdq0XsUO4An6qoz9yJjw9rEFXjbFwEMf
         Hhr/ZhBWQhALIqzOzaazb0FWhqYFXwqQqBwnPSkClGbcarXLj/rEshYTa248SfnvyfAg
         I8R3toe6sIuDItJxtbQIx6PfK2bad5UWxdZoNdaiGay/Pmq2QFRuhCSvi8vX6gaHWrl6
         4Mi9JVSnNHB4T81/SoC2EiVwA6nFXVUM7wR4yWCd4/Oov5sk+YxksK0sRKb4yqg0erM+
         s2tA==
X-Gm-Message-State: AOJu0YyAgJxaWoIp3MMFMO1mfeXHuwjnXXQAyKgx1+OJAeInrFPygSA4
	uL8Tx9iZefpxpkqDOvtLkZDCjxkhfBjxn7YaBD4LZuUWESnuIs7eTm7OSurZoEVLHBhtRVY6CtD
	++N7RZoh5/3xa+aHCcF0T/nePNUcBGcEJPL0JrJLDzbEdlX2gdLecS91pmjONZg==
X-Received: by 2002:a05:620a:4513:b0:7b1:8cfa:91fa with SMTP id af79cd13be357-7b331867b43mr1205035785a.0.1731176299489;
        Sat, 09 Nov 2024 10:18:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH38aWAjeQ/3efX0ujSqkdonYUqTNRWekycFxm1ukWXe1kggHxsS0tqHJelXIMdupg0qFeXQA==
X-Received: by 2002:a05:620a:4513:b0:7b1:8cfa:91fa with SMTP id af79cd13be357-7b331867b43mr1205032985a.0.1731176299132;
        Sat, 09 Nov 2024 10:18:19 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2d2sm33953266d6.25.2024.11.09.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:18:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a8e3dfbd-0efa-4b4e-bc18-d00abaa79f14@redhat.com>
Date: Sat, 9 Nov 2024 13:18:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
To: Juri Lelli <juri.lelli@redhat.com>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
 <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
 <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
 <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
 <5259772c-527b-4ab2-9606-2d1f0d93862a@redhat.com>
Content-Language: en-US
In-Reply-To: <5259772c-527b-4ab2-9606-2d1f0d93862a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 10:30 PM, Waiman Long wrote:
> I have the patchset to enforce that rebuild_sched_domains_locked() 
> will only be called at most once per cpuset operation.
>
> By adding some debug code to further study the null total_bw issue 
> when cpuset.cpus.partition is being changed, I found that eliminating 
> the redundant rebuild_sched_domains_locked() reduced the chance of 
> hitting null total_bw, it did not eliminate it. By running my cpuset 
> test script, I hit 250 cases of null total_bw with the v6.12-rc6 
> kernel. With my new cpuset patch applied, it reduces it to 120 cases 
> of null total_bw.
>
> I will try to look further for the exact condition that triggers null 
> total_bw generation.

After further testing, the 120 cases of null total_bw can be classified 
into the following 3 categories.

1) 51 cases when an isolated partition with isolated CPUs is created. 
Isolated CPU is not subjected to scheduling and so a total_bw of 0 is 
fine and not really a problem.

2) 67 cases when a nested partitions are being removed (A1 - A2). There 
is probably caused by some kind of race condtion. If I insert an 
artifical delay between the removal of A2 and A1, total_bw is fine. If 
there is no delay, I can see a null total_bw. That shouldn't really a 
problem in practice, though we may still need to figure out why.

2) Two cases where null total_bw is seen when a new partition is created 
by moving all the CPUs in the parent cgroup into its partition and the 
parent becomes a null partition with no CPU. The following example 
illustrates the steps.

#!/bin/bash
CGRP=/sys/fs/cgroup
cd $CGRP
echo +cpuset > cgroup.subtree_control
mkdir A1
cd A1
echo 0-1 > cpuset.cpus
echo root > cpuset.cpus.partition
echo "A1 partition"
echo +cpuset > cgroup.subtree_control
mkdir A2
cd A2
echo 0-1 > cpuset.cpus
echo root > cpuset.cpus.partition
echo "A2 partition"
cd ..
echo "Remove A2"
rmdir A2
cd ..
echo "Remove A1"
rmdir A1

In this corner case, there is actually no change in the set of sched 
domains. In this case, the sched domain set of CPUs 0-1 is being moved 
from partition A1 to A2 and vice versa in the removal of A2. This is 
similar to calling rebuild_sched_domains_locked() twice with the same 
input. I believe that is the condition that causes null total_bw.

Now the question is why the deadline code behaves this way. It is 
probably a bug that needs to be addressed.

Cheers,
Longman


