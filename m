Return-Path: <linux-kernel+bounces-229939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88091764A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EC91F22DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B538DE8;
	Wed, 26 Jun 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S9VgrL9m"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128412BD18
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369833; cv=none; b=ZvSrI5+dMXk1azKjZy2PFaMlt6nsPLwlXNOoWfnkQU9dpYbC5We1x5VFl23cBITaZZuJxTPy2jVkC3HGv6yGFrq22rWKCaxK/tQNcxArrRG9UXLjw96SJhX5FBFXFkVYUKopdN9eySPpqNU5CjXnv0uwlxx85mw3ytW9gSe6XN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369833; c=relaxed/simple;
	bh=79ZyvXGq2QmC/+nujJTWSpy/2aFxCYRraNbkq0IYdQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgs90OnoLOEjWHf6ca/P3Rp21+puE90KUeljugBKcLbOX9UDtF/VthsSvFsKtkkguMfo1lSAU6Zy+zXTLOunhndOfJjOofCXkArEa/jnNVU2ysnkehsW/SBmxuW2QqD+JmDKqTIkXe0krM1uhbh+oF61fq9LvN/aC8qCtPHUmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S9VgrL9m; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719369823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gilfLfI8DleZahX8loDIEcplFpqkD9gVPjXwXFjAvqM=;
	b=S9VgrL9mNSV4u2WH2DcgX5XQYreHXEc8e5HYQmm1ZJIqmSwY/oEyTjyFqAXZqpZJyOUQEzPgdTwxzypm0G0Tjj/R3pOCH4lG2OMBGVQWYhszGh8La2u4orbhq1uQs/1EtaDQ8iSjJcv++Onfjbmdmy8kRCgMVIz92jrtMw496b4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W9Hbm46_1719369820;
Received: from 30.97.48.207(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W9Hbm46_1719369820)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 10:43:42 +0800
Message-ID: <76c12fee-6cd7-4932-9cd9-fb450e485eb2@linux.alibaba.com>
Date: Wed, 26 Jun 2024 10:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/35] sched: handle preempt=voluntary under
 PREEMPT_AUTO
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
 juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
 sshegde@linux.ibm.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-30-ankur.a.arora@oracle.com>
 <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
 <87h6dmazs5.fsf@oracle.com>
 <dd6c29cf-3ca0-4aa3-8cfe-e85a35e300e4@linux.alibaba.com>
 <87ikxxakq5.fsf@oracle.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <87ikxxakq5.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/25 09:12, Ankur Arora wrote:
> 
> Side question: are there any benchmarks that would exercise various types
> of sched policy, idle and otherwise?
> 

AFAIK, no.
May need to combine workloads with different sched policies set by manual...
Or let's see if anyone else can offer suggestions.

Thanks.

