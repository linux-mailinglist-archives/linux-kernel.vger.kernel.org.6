Return-Path: <linux-kernel+bounces-319581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3F96FED5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650A5285582
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0845258;
	Sat,  7 Sep 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwnfDtKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDA79F3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671215; cv=none; b=XDnV1Q5VdHj0TqvnFxlWNZMOfBjzbjmPZIQ42+9dv7Rvu+Oysl2F+L7dIxl45ajQiq1IUJHXDB0aAv0FSxXhmCOt+DG8j4dOg0z8tRqrq/LmX0OT6/QwMU4qmHorLvdLA7qz6d3InjAxydFY8Zjrgic+XN0DgQFFLS/beYEzJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671215; c=relaxed/simple;
	bh=OoWvYPBu/dJK5tEBxzqeuQx4dFSf3hWwlC9XnEMn6qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elVdsObQtxrC3XrV5EOpt2/dPIFi4HmUU8CkLe+p8+Vp3fiY2MyV3pFEXfbTYSEpvvvXbTp3TlQ6x7rrVvVInhu7gWDLM2R4sRdmWcPOs/uegaMYofWHm8+VD31d72nierkVOnZ0Vr/Pd8ijAix/pX/5dSvbAQALJ/6c7AWQJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwnfDtKP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725671212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9YTogihn/7xFD1XwEJj/5iJ0b1DrhhToPtEuhPRdog=;
	b=BwnfDtKPyqToKISBfl6BZB0+LkBGAH5rSU0cPny56jUCuMlV3telFNho5yxF4NY6Id1T0h
	HUTo27GFuKX99GyB7ooynpS/mAxkSiATpzu2p5LNiOqpFcueX/Ak9kxEAlx2X6f2dbom3m
	9JWab/WI5Fq/1iyD2TsD0m0MPfhRQiI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-s1cxY30PMoWaT0ehUeviWA-1; Fri,
 06 Sep 2024 21:06:50 -0400
X-MC-Unique: s1cxY30PMoWaT0ehUeviWA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B4DC195608C;
	Sat,  7 Sep 2024 01:06:48 +0000 (UTC)
Received: from [10.2.17.16] (unknown [10.2.17.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21AEC1956048;
	Sat,  7 Sep 2024 01:06:44 +0000 (UTC)
Message-ID: <4fdb8c1f-fe0d-4fb1-81fb-1372fc18f85e@redhat.com>
Date: Fri, 6 Sep 2024 21:06:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched/isolation: Consolidate housekeeping cpumasks
 that are always identical
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20240904183650.1053708-1-longman@redhat.com>
 <20240904183650.1053708-3-longman@redhat.com>
 <ZtjOmPV0V7jbYqfO@pavilion.home>
 <4b976f7c-b105-4093-8838-eae26fc7de85@redhat.com>
 <Ztr_SIwkOK1MXTIW@pavilion.home>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Ztr_SIwkOK1MXTIW@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 9/6/24 09:10, Frederic Weisbecker wrote:
> Le Wed, Sep 04, 2024 at 07:57:13PM -0400, Waiman Long a écrit :
>>>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>>>> index 499d5e480882..e2c42172de82 100644
>>>> --- a/include/linux/sched/isolation.h
>>>> +++ b/include/linux/sched/isolation.h
>>>> @@ -7,15 +7,21 @@
>>>>    #include <linux/tick.h>
>>>>    enum hk_type {
>>>> -	HK_TYPE_TIMER,
>>>> -	HK_TYPE_RCU,
>>>> -	HK_TYPE_MISC,
>>>>    	HK_TYPE_TICK,
>>>>    	HK_TYPE_DOMAIN,
>>>> -	HK_TYPE_WQ,
>>>>    	HK_TYPE_MANAGED_IRQ,
>>>> -	HK_TYPE_KTHREAD,
>>>> -	HK_TYPE_MAX
>>>> +	HK_TYPE_KERNEL_NOISE,
>>>> +	HK_TYPE_MAX,
>>>> +
>>>> +	/*
>>>> +	 * The following housekeeping types are only set by the nohz_full
>>>> +	 * boot commandline option. So they can share the same value.
>>>> +	 */
>>>> +	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
>>>> +	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
>>>> +	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
>>>> +	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
>>>> +	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
>>> Why not removing them entirely and only keep HK_TYPE_KERNEL_NOISE ?
>> All these HK_TYPE_* types are still used in other parts of kernel. We need
>> to clean them all up before we can remove them, but that is outside the
>> scope of this series.
> If that can help, I posted this a while ago:
>
> https://lore.kernel.org/lkml/20230203232409.163847-2-frederic@kernel.org/
>
> I think it is very much needed. People keep getting confused about these individual
> bits.

This patch does merge all the nohz_full bits (except HK_TYPE_TICK) into 
a single bit. I see that you tried to do that last year. This patch is 
less aggressive as it only touches the scheduling code. Once we agree 
that this is the direction to go and is merged, we can proceed to update 
the other kernel subsystems.

Cheers,
Longman


