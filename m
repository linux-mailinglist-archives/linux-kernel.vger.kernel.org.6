Return-Path: <linux-kernel+bounces-563873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F383EA64A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061FF3A9D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BFF133987;
	Mon, 17 Mar 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm1M07ud"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165E2356B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207155; cv=none; b=UcxRIviD9tLN23Z7d460wm4p9/69uK7lYg/4hSJ3sgt0BvG/kbTY7VME13cRB48TnmPDM4vdTiXOwjt7YZlfHJXhmxzwiSXFzntkTjB/7ChsM96Vuv8+V1rUvnUfAKj3EhIICpJVU3ejUPj9Y9bJvz7VXhkO4Jxz5E2mceLZynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207155; c=relaxed/simple;
	bh=TVV/g7mnMh4ma/5PIAWd23Snq3d+CIKvT6sV5VMB6BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDj2wp7ibLAIk4RjJYBHpFg0iUzmcV6Pw7u33f34tqOARB9kkXj7RLqN8JgiKTRawI0/3xcd544kw2nnxh8GTlr6D1Knh+bA3qhNoDqKY+0Atf4oUzA2CfnYpT1tixvzdevWAkHXIdnUN1ru6r96chK9tzDqHa/pQ+j62g3vYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm1M07ud; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742207151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLH7z2QoqEx9Vh2g5JBXd7g+iZGFjbWAGXHeJsAe2S4=;
	b=Bm1M07udYmR58fsX1n45g8O86MLvmf7l/pRIQ6TTTVc5gYJZ7oJpBtxLZ1wKmcWRYgl8E+
	6D0wuicfmfjiJSwV5bbmLqKnU7/bOg/vnpCYFL9w8ITLEgLl7X5iG1GR+U7Q2ZP2QhyjeJ
	C2TeHBPHuxieHTb0eUoxKYqJIT6vDyU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-NokQF4-VOqeln9JBreRQUQ-1; Mon, 17 Mar 2025 06:25:50 -0400
X-MC-Unique: NokQF4-VOqeln9JBreRQUQ-1
X-Mimecast-MFC-AGG-ID: NokQF4-VOqeln9JBreRQUQ_1742207149
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so11366855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207149; x=1742811949;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLH7z2QoqEx9Vh2g5JBXd7g+iZGFjbWAGXHeJsAe2S4=;
        b=RwEYEsWErm8tH4eS6IBot5Ri7z2URm9CJTVayGTVT+L4BZa2+nXOBcDfdA0TG8GQ19
         /fuMsSajCJHXH5wrcFexm4HCg7jknfKwwxxnSI7NmqUz2dq8luTQ7b3K2haG+NxKn5MP
         u87J/uu0ofsJmwOyaGN97LtwdVl4QuE9kRHGR1NuEgygIGD93JJBkSLJoOkCq0EPT5hX
         r2P5c3BHiew6V+edV0rktWabEtz4L+Mvh8m8a7auMN5ySNeTQGENX5gV7KGsfO8EAPCb
         IInd26eJ8SNLYO6ABBvq/ZBhEoRPoGA71cJT2Z/AiASarCjX3TQU8QtKV2jem0VPuMs7
         L4dA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4VcYRs0YUI5PR+2C1h/GoJqnhn7gVSQtfRI6Ct7wawXvaOGCZJp0jHEoKUa8f6eqw6TUgVzDYSOqMCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZkVu/RPX988ZV57hVRuuymSnEwEa2NdyLw025nhn0yr+OSKC
	laFsKnpsRPz8Kbbq9mhH5jjGvHXqjylXpFrGDg6d1ptXUC0YDZsij7R3svo1DpBEhx7YupaYCZo
	QT9V/8+GkcwoINfJejiiX0u3IgscCXIGuEn8D/EDyraqLo6dc97p5TUExY4N5Ow==
X-Gm-Gg: ASbGnctxh8gePzUzzjdOwb4i+btKTAM1Ij6R5+//1i8m4bxvxn2EruGiqXbHOUOZ/bw
	p0IZT/CW2IZdjgE4ZtXTtnudqUUFk0++Wu1UG/9uSLBqWr53xzQ8rlaw1PsV9Sy8oJWT8drezFR
	Bp0jXJf+3Jkw+Mur8o85HXWrJdz8TMWbcdMHK5ieURYyQ1M8UMzJKUuUTH2cVwvL3Bz5d/pOaGE
	+5wVimNbl2OTwazn995cbKXUVdWiIii2uy8yudJnf286THHrZ/rqu8H5r0sM8+BUurJV1zIdQdx
	6p8pWlDIYeyw0EuNHNPKBssOAbnspzuwKr8/ka4e8QPnZMJVygTXgDnC/lZfYQrGeyU+LctSvFa
	QuqANUSK2KrF5mhiC3PP4eemaHtSA8ic3
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43d1ec765b7mr126094795e9.7.1742207149373;
        Mon, 17 Mar 2025 03:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAnSw5ZT58xJ/dgfRjmLNJ5BroXQ6ni/M8VeoavvBu5a/wEIL8St5bHo/p2XpRENGbjVMDwA==
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43d1ec765b7mr126094445e9.7.1742207148805;
        Mon, 17 Mar 2025 03:25:48 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (106.15.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.15.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm100039075e9.38.2025.03.17.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:25:48 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 srivatsa@csail.mit.edu, K Prateek Nayak <kprateek.nayak@amd.com>, Michael
 Kelley <mhklinux@outlook.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v5] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <8c2c67cc-d8a0-42cf-b9fe-c5e5c4f627c6@linux.microsoft.com>
References: <20250310052509.1416-1-namjain@linux.microsoft.com>
 <xhsmh34fjr3av.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <8c2c67cc-d8a0-42cf-b9fe-c5e5c4f627c6@linux.microsoft.com>
Date: Mon, 17 Mar 2025 11:25:47 +0100
Message-ID: <xhsmha59koswk.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 17/03/25 15:27, Naman Jain wrote:
> On 3/11/2025 9:02 PM, Valentin Schneider wrote:
>> On 10/03/25 10:55, Naman Jain wrote:
>>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>
>>> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
>>> around 8 seconds cumulatively for all the iterations. It is an expensive
>>> operation which does the sanity of non-NUMA topology masks.
>>>
>>> CPU topology is not something which changes very frequently hence make
>>> this check optional for the systems where the topology is trusted and
>>> need faster bootup.
>>>
>>> Restrict this to sched_verbose kernel cmdline option so that this penalty
>>> can be avoided for the systems who want to avoid it.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> ---
>>> Changes since v4:
>>> https://lore.kernel.org/all/20250306055354.52915-1-namjain@linux.microsoft.com/
>>>        - Rephrased print statement and moved it to sched_domain_debug.
>>>          (addressing Valentin's comments)
>>> Changes since v3:
>>> https://lore.kernel.org/all/20250203114738.3109-1-namjain@linux.microsoft.com/
>>>        - Minor typo correction in comment
>>>        - Added Tested-by tag from Prateek for x86
>>> Changes since v2:
>>> https://lore.kernel.org/all/1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com/
>>>        - Use sched_debug() instead of using sched_debug_verbose
>>>          variable directly (addressing Prateek's comment)
>>>
>>> Changes since v1:
>>> https://lore.kernel.org/all/1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com/
>>>        - Use kernel cmdline param instead of compile time flag.
>>>
>>> Adding a link to the other patch which is under review.
>>> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
>>> Above patch tries to optimize the topology sanity check, whereas this
>>> patch makes it optional. We believe both patches can coexist, as even
>>> with optimization, there will still be some performance overhead for
>>> this check.
>>>
>>> ---
>>>   kernel/sched/topology.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index c49aea8c1025..d7254c47af45 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -132,8 +132,11 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>>>   {
>>>        int level = 0;
>>>
>>> -	if (!sched_debug_verbose)
>>> +	if (!sched_debug_verbose) {
>>> +		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>>> +			     __func__);
>>>                return;
>>> +	}
>>>
>> 
>> Nit: I've been told not to break warnings over multiple lines so they can
>> be grep'ed, but given this has the "sched_domain_debug:" prefix I think we
>> could get away with the below.
>> 
>> Regardless:
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>> 
>> ---
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index d7254c47af455..b4dc7c7d2c41c 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -133,7 +133,8 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>>   	int level = 0;
>>   
>>   	if (!sched_debug_verbose) {
>> -		pr_info_once("%s: Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it\n",
>> +		pr_info_once("%s: Scheduler topology debugging disabled, "
>> +			     "add 'sched_verbose' to the cmdline to enable it\n",
>>   			     __func__);
>>   		return;
>>   	}
>
>
> Hi Valentin,
> Splitting the warning to different lines give checkpatch error with 
> --strict option. --fix option suggests we keep it like we have it 
> originally(single line). Please let me know if you feel we can change it 
> to something else or if you are fine with picking the change for next 
> iteration. Thanks again.
>

Hah, didn't know that was in checkpatch :-) As I said before that really
was more of a nitpick, consider me OK with the current patch.


