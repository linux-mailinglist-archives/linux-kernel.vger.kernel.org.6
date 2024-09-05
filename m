Return-Path: <linux-kernel+bounces-317213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32396DB02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3361C1F26F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53319D8BC;
	Thu,  5 Sep 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0jPeGv4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA772AE96
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544856; cv=none; b=lEMr7Iljqp9tbD7CSPzW8/O3mFSwsOxjZFrgiHTaurL6rcxETED6PykZE5eLOxUx/qGUZH/tlibAGxL34GQLDZhHOGvqo69ypY9j7wuWXNuLEhR0A/o8bFxz0Z+J9rQXrTNuw+r7k8f9qxpAZyDVean/3+RAqRR/VvPVUnpPQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544856; c=relaxed/simple;
	bh=bPxNbZ7BzxE0m+ZfMhR02Ul8KM2IP4yBo/4dwS/ovqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2ZqTiZ9fmLFwvRsKQNxuqhQ32uGE5jc/jNLkG1T91/H40GblEwHOiu0rmLQTU6zbQHKrleOhj/tSQOrO8sstQpKrZPE9zMrU5d4P0E2bZSWXvFupHU5G1J7yODHP52FflQxkSIHQjOvjbTMEtipyR+khqocJMHMidOJChnbTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0jPeGv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725544853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFjzMu6h7iw3puPglph33yKYaInXmv2oCV6rB7n+Lck=;
	b=Z0jPeGv4a3PDW7ThhVkAnwswj177NXF5r4/SHYcD0UzQl6gAJ2XTEGnYRggXg5wVGDiSAB
	kO4k2EHnsWFN4nNJzho1kKiepeHlZyH8CTXcwjPzSSvTfeXJqeW4xREGOjuvnfR53Cs53a
	LG6kKKiBGTMcVNKLxzL/NTJJQn9crqI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-VCuE2WDVOa6_7gQTFlrs2g-1; Thu,
 05 Sep 2024 10:00:49 -0400
X-MC-Unique: VCuE2WDVOa6_7gQTFlrs2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E056C1955D47;
	Thu,  5 Sep 2024 14:00:40 +0000 (UTC)
Received: from [10.2.16.62] (unknown [10.2.16.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 642D030001AB;
	Thu,  5 Sep 2024 14:00:37 +0000 (UTC)
Message-ID: <66d8a8c9-f03b-49de-b67f-0623a796191e@redhat.com>
Date: Thu, 5 Sep 2024 10:00:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Do not copy user_cpus_ptr when parent is
 reset_on_fork
To: Phil Auld <pauld@redhat.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
References: <20240905090458.1173-1-xuewen.yan@unisoc.com>
 <a645086d-bffb-41b0-bd70-1ef5edb128f9@redhat.com>
 <20240905131244.GA179482@pauld.westford.csb>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240905131244.GA179482@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 9/5/24 09:12, Phil Auld wrote:
> On Thu, Sep 05, 2024 at 08:42:33AM -0400 Waiman Long wrote:
>> On 9/5/24 05:04, Xuewen Yan wrote:
>>> Now, the task's user_cpus_ptr would dup from parent's user_cpus_ptr.
>>> It is better reset the user_cpus_ptr when parent's reset_on_fork
>>> is set.
>> According to sched(7):
>>
>>         Each thread has a reset-on-fork scheduling flag.  When this flag
>>         is set, children created by fork(2) do not inherit privileged
>>         scheduling policies.
>>
>> It can be argued what are considered privileged scheduling policies. AFAICS,
>> a restricted affinity doesn't seem to be a "privileged" scheduling policy.
>> That is my own opinion strictly from the definition point of view, I will
>> let others weigh in on that and I am OK to go either way.
>>
> I think that one could argue that clearing a restricted affinity is
> increasing the privilege and not preventing inheritence of same.
> i.e. it would be the opposite of what reset-on-fork means.
>
> I'd say NAK to this one if I had that power.

Maybe I am not clear enough in my previous mail. My position is the same 
as yours. I think this patch is not necessary. More reasons should be 
provided as to why it is right to not inherited the restricted affinity 
when reset-on-fork flag is reset.

Cheers,
Longman


