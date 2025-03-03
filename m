Return-Path: <linux-kernel+bounces-540939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D2A4B6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E96016BD9D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9951D5172;
	Mon,  3 Mar 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jbqGZAZw"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705561D2F53
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972697; cv=none; b=Cpoq+y/A++oLmCD/QybS9sgliQ6j9uddX+61QV5+A96Da58lVlU4tEXNZ76NV93fps0RMz+q/8TX4Y8CToxr7uxVKN0TfEXV+XVtx/upI+sYMm7Gl7JZRKP04aIBU15EI0+XbGOf/LV3WCFAH4s5hL0I7HXQ6E61ldYRpsZVlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972697; c=relaxed/simple;
	bh=3uhLCSmvvv7VkNMELhSDXmUJnOZ/IQEAZmCHPCOiFD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbVS9xTJZabDiIqNgmQJ2WiSUQIRCdPBYoCk4iIo7lbuav1ElNR4vnDj1F+XNGAVNszM4+HVV6Ni9zN5CaliYdT3bmdVNmPOhJhY/q7O6nS5cfyDOAgHm2o97yj7nuYjGtK/LeDMsi3EzYjUvbhpA/Bc4+HVRac0AH/MX67AwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jbqGZAZw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fea8d8c2f1so972812a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740972695; x=1741577495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBNDP/P3k6ybBa7xjmDIf+Y6ZzGtfCp6fqST1oagGvI=;
        b=jbqGZAZwrEhU/BinhHQcp1+OjTqKrVjm1sQnszkHjqTvaYuB2iCEKPbkDnXS3Cx+rr
         dHit6TNzgyJa2LkjPR2wZKvZkUb9vvUSZQCXTP/tkTIkHJP8E/XXShq1Faif2qugWmzg
         suGx4WKygeL996j3q2s5eOL/cGXBDvsHlPLD8kH5rrRoO/dWAZ6D6DFretK5b3zwUz4m
         +Tnmd0y8aElaGf0wX+YxCJo7ihAJZob+mXv2RVsJ2HtQxeJCexdDCYdTMql300kY1v2T
         2o6jXP8ts7cC2d5g5oKEfqDCaIc8GX0Y8A3IbNmo6/faDkdS8DNdUo2IwEqpJVkA5+W+
         Pbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740972695; x=1741577495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBNDP/P3k6ybBa7xjmDIf+Y6ZzGtfCp6fqST1oagGvI=;
        b=uwxkpXbIOTGPRyGEt6xx5noTBI70uq97OU0MzvwrPKdcVEjmU7EaPcuaxBWYWHHGOo
         HOrKzJE1v2J/uPbN82KOOMMqRFgLInlAsm7ykbaOVCvOMBdLdaMv/PXtvo2yGRzWyhjS
         OCehH8vQ/M4Y2kaNs3RrELeUQU8gfRDOPo+RkdxbQfPkJh4ellR7K8LaGxWw8zKF50M3
         BeCX8m0eWIwI64/N9BjSQtAc9EY8ExH5P2IX39FtFWpMR/FNN4aa6dkl9vDv5FjP1w+7
         ybY4KtH9lrirJVYFYc6JxR1H/ab4uliQrhCzCcphAK7hkembY042+s/HCxXAbHKmuR4B
         PtoQ==
X-Gm-Message-State: AOJu0Yw9HBDQ6ahagfpMGknD0mTEpwZDTdCN9FCPtqeb9hqTKxPqs2pI
	04V+/C5WMvHu9Jv/0dXSLnYCx3UWqeZrgn6BxnoZXuKM51hFYKOSnnIT/8ZQ13Q=
X-Gm-Gg: ASbGnctBbcAvjvHYuLl8q6nMVw3DJZGun7DNJJJxc81fwmVndXu4eLPWdisFvYJQxkh
	Ftfmu6fzA5HmF8uSh/ypQyDNr+rbX6h/1iyDPeHqYsFoYX5hpItn1iJr3bzmN1uaSUlrnEhASo1
	9+s5N84ANHcpqS6rVJjLnnsCwpr5K78I8qL9PdIuuxlOeX16LWdHKL46VPzkszB0CRH2PFHwRrc
	7ZZOFKCJaV0jx68o2QoPLQFCKET9me8OMt9EKbT+IQL6WYgbcYkjpFviDGUepZeM+fN3KZOhgOY
	nj7uMQOZ2/zMSApD6MEeUFOdFYixK8H5lVifRJbgj4Ys1hD7ibqCZs3k8Rlk4k0iBoRk
X-Google-Smtp-Source: AGHT+IFT7HPm+Oc+5ur6a5DTN9AUjLi4VFmqkdaUHeG+iwbpjhZS9aj+KI58zSiVa7EVPjadRMIGOQ==
X-Received: by 2002:a17:90b:1d02:b0:2fc:25b3:6a7b with SMTP id 98e67ed59e1d1-2febabf856bmr7166540a91.6.1740972694622;
        Sun, 02 Mar 2025 19:31:34 -0800 (PST)
Received: from [10.254.225.63] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fd28dsm67664885ad.94.2025.03.02.19.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 19:31:33 -0800 (PST)
Message-ID: <033b4ec3-cbbd-4aa8-b25b-3bb4bdbaced9@bytedance.com>
Date: Mon, 3 Mar 2025 11:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 0/2] Fix SCHED_IDLE behavior on wakeup preemption
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250227085815.18131-1-wuyun.abel@bytedance.com>
 <3ce5065e-8b9b-46a8-b7c1-5f9b8f118b06@amd.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <3ce5065e-8b9b-46a8-b7c1-5f9b8f118b06@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/25 4:05 PM, K Prateek Nayak wrote:
> Hello Abel,
> 
> On 2/27/2025 2:28 PM, Abel Wu wrote:
>> The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
>> defines the behavior of SCHED_IDLE as following:
>>
>>   - no SCHED_IDLE buddies
>>   - never let SCHED_IDLE preempt on wakeup
>>   - always preempt SCHED_IDLE on wakeup
>>   - limit SLEEPER fairness for SCHED_IDLE
>>
>> and the middle two of them are broken now.
> 
> Feel free to include:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks!


