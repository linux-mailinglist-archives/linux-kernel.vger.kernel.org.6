Return-Path: <linux-kernel+bounces-260390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F893A844
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A961F233F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4B142905;
	Tue, 23 Jul 2024 20:47:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6A2E634
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767649; cv=none; b=cv5P7LdXTOP9fdAFLMaisA43tmwE1LB+SapDwzu8ZmQ0Dq8GYwQvjSZlYcVI9XDub5rQnXSH4iYqnSBmNcEuasx+W2V8Nars03zOwz0WYa1jCQIHymDkXLytEfFLr4H1Y2xEw1RmWgkfifDyKk+BE5NAbTIUkJChNilglaqN2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767649; c=relaxed/simple;
	bh=es8Nr9/DwaxSsBnWKsrVSBsl1/go9e5pcTtl0tFjmtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLkg6tGkCsprs3C7RONr6cPNZW85F75XMLnEuyVol4sRNd2bvwlGvfd8+z0apuKGTZ5MSv4qYgW0z2AHnU2hyxwf6x3VY1CuqlkE+370CKhqwfAXDmmS1taRGwVkpwE434BxefoDEZF9HO3u4/RRKJ2xCoKsMxcU0lkXhksE6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FCEE139F;
	Tue, 23 Jul 2024 13:47:51 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CE9E3F73F;
	Tue, 23 Jul 2024 13:47:24 -0700 (PDT)
Message-ID: <d4ac0022-5ba4-44b9-ac09-4530a18b0974@arm.com>
Date: Tue, 23 Jul 2024 22:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240720031928.406540-1-zhouchuyi@bytedance.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240720031928.406540-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2024 05:19, Chuyi Zhou wrote:
> nr_spread_over tracks the number of instances where the difference
> between a scheduling entity's virtual runtime and the minimum virtual
> runtime in the runqueue exceeds three times the scheduler latency,
> indicating significant disparity in task scheduling.
> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed its usage.
> 
> cfs_rq->exec_clock was used to account for time spent executing tasks.
> Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
> removed its usage.

I was under the impression this commit removed
'schedstat_add(cfs_rq->exec_clock, delta_exec)' from update_curr() by
mistake?

That's why I sent out this patch back in May:

https://lkml.kernel.org/r/20240503104605.1871571-1-dietmar.eggemann@arm.com

to add it back.


