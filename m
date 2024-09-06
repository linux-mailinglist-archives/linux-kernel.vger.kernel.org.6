Return-Path: <linux-kernel+bounces-319216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4E96F963
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CD81C22C86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A11D4615;
	Fri,  6 Sep 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCUw0ocA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546C1D1F6D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640301; cv=none; b=S0Hdf/UezV+sxt4HoHsiZXJdhFht39yGY1fnDMP8s/4oZ2rPCN2Fa6I0NP9DAs1H+5T11GqmShWUm+KBnyoeYUbz6rqWeCC9mMcgUd1Lmsyxt3kFb41FVQhBJGxjbQOPV+zGf4sDvjxGL398FsFUm9fVYNRMBP+jD0N6DqIeOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640301; c=relaxed/simple;
	bh=KZ79ji41UrPP4ECVC48yOmyNPfE5rwmoulUj0pcs0LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3klxp+rbGjlzPF55VhQqtrvacRRGPVQxULbKw1o2Xdjd7KNej7+taXtE2RHJuqZJkmF2TYA8GiuMBtad/MlTFMxUaI6WglOoRznRZlv31Z3LVU0ypYF1d+4gLDeMleWDlitpMaNNeiFl6Vsnz1L+Ww5NB02V1QJjBqwCUq5/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCUw0ocA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725640298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G522UJp7KiCHGPaSCy1MevxPOkpCIpCMoVNa9BO+Pjw=;
	b=iCUw0ocALQaPOVt7fMZr5ZaUHZwp6vo+nvtB44/OYpkyO1Yej7B2h9upEvigCaV1HL9jsE
	lNl1i0CR2LuvHDPwAwGyIkQgXQLMzPYRWw1ZadrwlBkRCjRclWjyhhGJBju4rgkbitA35e
	8dxpksu2kG7pYfNlppBCXH19DIy0b+k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-ZbzpyhzwPGGW4gInO9rZeQ-1; Fri,
 06 Sep 2024 12:31:33 -0400
X-MC-Unique: ZbzpyhzwPGGW4gInO9rZeQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 924DF193F078;
	Fri,  6 Sep 2024 16:31:31 +0000 (UTC)
Received: from [10.2.16.252] (unknown [10.2.16.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A5D53000238;
	Fri,  6 Sep 2024 16:31:28 +0000 (UTC)
Message-ID: <e02862aa-7de5-4f16-845e-5ec7f1f41245@redhat.com>
Date: Fri, 6 Sep 2024 12:31:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-3-longman@redhat.com>
 <ZtcLUcJvqSV3vXd2@localhost.localdomain>
 <d43165ae-9124-4034-b816-d09c9a48ecec@redhat.com>
 <70e5a6f3-1cff-46c9-af34-75664961eae2@redhat.com>
 <Ztr7XgZd5pUWNLnY@pavilion.home>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Ztr7XgZd5pUWNLnY@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9/6/24 08:53, Frederic Weisbecker wrote:
> Le Wed, Sep 04, 2024 at 10:54:15AM -0400, Waiman Long a écrit :
>> On 9/3/24 09:53, Waiman Long wrote:
>>> On 9/3/24 09:12, Frederic Weisbecker wrote:
>>>> Le Sun, Aug 18, 2024 at 07:45:19PM -0400, Waiman Long a écrit :
>>>>> As the previous commit has enabled the setting of HK_TYPE_SCHED
>>>>> housekeeping CPUs in nohz_full setup, we can now use the more aptly
>>>>> named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.
>>>>>
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> Can we instead merge HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER,
>>>> HK_FLAG_RCU,
>>>> HK_FLAG_MISC and HK_FLAG_KTHREAD into a single
>>>> HK_FLAG_KERNEL_NOISE / HK_TYPE_KERNEL_NOISE ?
>>> Sure. I am open to new name as I am not good on that.
>>> HK_FLAG_KERNEL_NOISE does make sense.
>> I can't merge HK_FLAG_TICK just yet as it can be independently set by using
>> isolcpus which can set just HK_TYPE_TICK, HK_TYPE_DOMAIN or
>> HK_TYPE_MANAGED_IRQ. That is the reason why they are still separate.
> Ah I think we really need to unify behaviours of isolcpus=nohz and nohz_full=
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5891e715f00d..9bc8fbf326cc 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -212,7 +212,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   	while (isalpha(*str)) {
>   		if (!strncmp(str, "nohz,", 5)) {
>   			str += 5;
> -			flags |= HK_FLAG_TICK;
> +			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> +				 HK_FLAG_MISC | HK_FLAG_KTHREAD;
>   			continue;
>   		}

I am not against it, but it is a change in userspace behavior. How about 
we introduce "isolcpus=nohz_full" option that essentially combines 
isolcpus and nohz_full in one option? That can be a separate patch.

Cheers,
Longman


