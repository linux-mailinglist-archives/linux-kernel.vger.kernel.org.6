Return-Path: <linux-kernel+bounces-315177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA396BEDD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB1828877B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECB1DA31E;
	Wed,  4 Sep 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxg+LQO3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2561D0167
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457321; cv=none; b=fNlYSJlEHGhscES6tAg8OOiyuhWVLseNgZmtFbyqnRchzXi8HVN0EPM5C1/PK6zRTc4GYs5FN3enn9ovK05PjJA26aOZZ/vY+wk25dsCbc4Mgknix22ScaEPOQdyVOP9oZLL6yP7h6e1z4hiefQWyNJ0FAD8XwZuNuS9HnHh+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457321; c=relaxed/simple;
	bh=JbWayupVn/JJ7GNhAx0PUBZWkZNObgTS/i31L2CJTQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xzzr+UGWu+2US6kaR2vvtjZ2TM6jrGztJWmvEn/hNydr4zHCmALBWTwZlsz/6oDtBcmRJmN92OH3HOZcnZX2LVi4SU9qg0nPS5ZZ15Tw+rNfUz2wKuyxMj4u+OMvOybCTVnzaGHHUvrgUw5lskya4bw/p8PsbD9UTmqEU1MXRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uxg+LQO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MQR4Ycby6XUOwft8GVXSA68r8M0SwRZCOvfGY+GmZU=;
	b=Uxg+LQO3612JDf7p94Cm708lxxJ5VFk4hifLCA23OVbuslHzt67B+WtjacfL01BRqQqL+5
	VobSvOPJt2ZhNrumw2VGGdPsLfRSOw9nsuWgk0X57B3AXEaJBp51p6SCHeNeeCzQOE7c0T
	FVWhR8wrCjy6wK5JPkloiXtGhOQkk+Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-mr4fRSDbOuCOEQiSnaZwcQ-1; Wed,
 04 Sep 2024 09:41:53 -0400
X-MC-Unique: mr4fRSDbOuCOEQiSnaZwcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86F72193E8F9;
	Wed,  4 Sep 2024 13:41:51 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B10941955D4F;
	Wed,  4 Sep 2024 13:41:36 +0000 (UTC)
Message-ID: <00df81bb-8790-44c1-8f22-f24b73fb734f@redhat.com>
Date: Wed, 4 Sep 2024 09:41:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
To: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
 <ZthWKgK9B_AUqSs1@localhost.localdomain>
 <20240904130445.GI4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240904130445.GI4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 9/4/24 09:04, Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 02:44:26PM +0200, Frederic Weisbecker wrote:
>>>> I'm a bit scared about rule 1) because I know there are existing users of
>>>> nohz_full on multi-CPU domains... So I feel a bit trapped.
>>> As stated before, this is not a common use case.
>> Not sure and anyway it's not a forbidden usecase. But this is anyway outside
>> the scope of this patchset.
> Most crucially, it is a completely broken setup. It doesn't actually
> work well.
>
> Taking it away will force people to fix their broken. That's a good
> thing, no?
It will be hard to take it away without a good substitute. This is 
exactly what I am trying to accomplish with the dynamic CPU isolation work.

>
>>> The isolcpus boot option is deprecated, as stated in kernel-parameters.txt.
>> We should undeprecate it, apparently it's still widely used. Perhaps by people
>> who can't afford to use cpusets/cgroups.
> What is the actual problem with using cpusets? At the very least the
> whole nohz_full thing needs to be moved into cpusets so it isn't a fixed
> boot time thing anymore.
Right.
>>> My plan is to deprecate nohz_full as well once we are able to make dynamic
>>> CPU isolation via cpuset works almost as good as isolcpus + nohz_full.
>> You can't really deprecate such a kernel boot option unfortunately. Believe me
>> I wish we could.
> Why not? As I said, the only thing that's kept it around, and worse,
> made it more popular again, is this nohz_full nonsense. That never
> should've used isolcpus, but that's not something we can do anything
> about now.
>
> Rigid, boot time only things are teh suck.

Declaring a feature as being deprecated is the first step in the process 
of removing it. Users can still use a deprecated feature as the code is 
still there. The actual removal will be at least several releases later 
if not more.

Cheers,
Longman


