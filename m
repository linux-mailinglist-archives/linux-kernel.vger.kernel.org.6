Return-Path: <linux-kernel+bounces-571016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38708A6B7EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE03B27A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7951F1505;
	Fri, 21 Mar 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bHejE7qR"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C6182B4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550163; cv=none; b=aUSzhR/zxS0NtSmrWUpQrKl/9jjoKfGNsir8qb9RtXaOaDArhzIv8NoTYPgkCTwN+EnyfstivGqTmiu8DvZiWKQQOD/8zQ1Af87SquCxCp5XX93m/5imjbnGXFvJMjqzElnlOWvF7pzIPAN+QFIhgD8126gctss44u6WmGrqDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550163; c=relaxed/simple;
	bh=kGo5R2yat6qKX+HPnO6n5yYkLjkrjwM2VmvLVD1C3BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCYVsPGjGlieICitCjrQfJviFxGqn4LjhdgoYY8HOlmaqa/Fx+pX9BhRPdAso3RG9CH10VqrOUBUYDFGZ4g60yQStXvETafhQ1pgkF1uT1gPKJmBHz5KHGuIhxd6uFJrjYCsN1bAjcI2waNfyPcJvPO1hh9EP+qaNH/GMMpi7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bHejE7qR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22403c99457so4008965ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742550160; x=1743154960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfZ/QIymP5lHEql9eshbTLfaGA1JisjXHXnYIcXCxs0=;
        b=bHejE7qRqd/6+znN0YTCwfqyzGNgglo9cuyEmsSVXGCHIhMqJqAJZNWVQXMP5jcPAN
         sxXkv1oicDkKULYf57rVTX2Gpad0InD9jFnS1tFUu7umhKuK2tlhAyAL3r51qsjlegI8
         gkVW9RzKwrCaD+yyFRYZ830jVWf6ATEIf9eZ6S5pAdw4k20xpfLtqf3+m2n8ProTK9lF
         uqM4F++ff4YarfM/ZperPz+EBClVwyGuX+WhfM7NTyT92iie6KVMHz2qq0Ij+6w5dVJ2
         DkFZCWz302fDQE2a4PBUvxwOLCg017CinuREYzq5wY3Ii0C+Cr0W0LV74+NpyFvGcniD
         dJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550160; x=1743154960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfZ/QIymP5lHEql9eshbTLfaGA1JisjXHXnYIcXCxs0=;
        b=lSzYB7aov56Redab70h+NMyIblGqPLJSJf+WT1lF76pcKr47gYdTrmS9G0OdoV6KRY
         QY7kvFgiWkuvM9Zaa1Qf7zpMuSvcx3oe07/aFjXGxSnQGrpAanazxGPr94oOePh4Btyv
         4ZJB6aR6Gbt/sGXBcosC472dtwRhBk3PTFLfnNCOiJ4qq+m/7DcYjMDjZ5pMKssfJyhr
         Im8WunPwJzEohHlTWGs3yCeRisr4EvWC9AOPGMXmm8GiM9yQtr4GkXXTm/M51fSJLZRS
         QRoyoGMg687X0Jncj0R9bzetGnOPgHKn0WW22u8P91DhcQN37MZH1Mkc/qMyUcuJqyyJ
         YMnA==
X-Gm-Message-State: AOJu0YymBddmfXgL3nWJ5qQofcUsCGna74rQ4t7UR0RE4aN3gpMpXvPU
	qKEz1dnb1DD557n1U7Ularm0CBJoulWebOh9Gp8PHuJAc0PQwrVW74Mpc5lFRmc=
X-Gm-Gg: ASbGncvfCgThyGraa4IS1IYhRNcLbZ2lFb3Xb2QupKUKoco0xuRIc2eMjvHAJWcxvs4
	fipJKdRb34YYSqsDID+Xt3BEs9lTdFFrsUHtzrI9EgGnJHaTfZ+cCWjqQVY9lzX5cxtyBcttqTf
	S0lDd0BhXD3Hs+fTZTcf08a/uQ1IQx3x/vdArXIjbXfVKKuedGx4AedLBD7BzKmd9IFBCJbD1mp
	0+2pg89Etguu7zoIQSN/WY7aDQqbL+pIhKdhMo4Uvkv8hP2nBprsiCyiOLSDxyZPAWCmvO1FaTk
	oud/HqXFIkZTrF/UYrlgE2VmIdpmbSf54hmQVbi4Ei/7l7G7a2SRT+RdDbSniJHngA==
X-Google-Smtp-Source: AGHT+IFGvzZSbWfHQKdbEzGHNnB/3CEj8Jf+cYn1eofR+dI45jhkPhrUl0jylsMSI9HCGreph2txxQ==
X-Received: by 2002:a17:902:fc48:b0:21f:1365:8bcf with SMTP id d9443c01a7336-22780de63a0mr19670575ad.10.1742550160206;
        Fri, 21 Mar 2025 02:42:40 -0700 (PDT)
Received: from [10.68.122.94] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bd195sm12130875ad.132.2025.03.21.02.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 02:42:39 -0700 (PDT)
Message-ID: <5bad2c2d-8e5d-492b-be24-c61c43499f64@bytedance.com>
Date: Fri, 21 Mar 2025 17:42:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix SCHED_IDLE behavior on wakeup preemption
Content-Language: en-US
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
References: <20250307032118.30364-1-wuyun.abel@bytedance.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20250307032118.30364-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping.. Can this series be merged, pls?

On 3/7/25 11:21 AM, Abel Wu wrote:
> The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> defines the behavior of SCHED_IDLE as following:
> 
>   - no SCHED_IDLE buddies
>   - never let SCHED_IDLE preempt on wakeup
>   - always preempt SCHED_IDLE on wakeup
>   - limit SLEEPER fairness for SCHED_IDLE
> 
> and the middle two of them are broken now.
> 
> v3:
>   - Collect Tested-by and Acked-by from K Nayak and Vincent, thanks!
> 
> v2:
>   - Collect Reviewed-by tags from Vincent, Josh and Madadi, thanks!
>   - Rebased to up-to-date tip. (Madadi)
>   - Folded some discussion with Vincent into commit log.
> 
> Abel Wu (2):
>    sched/fair: Do not let idle entities preempt others
>    sched/fair: Fix premature check of WAKEUP_PREEMPTION
> 
>   kernel/sched/fair.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 


