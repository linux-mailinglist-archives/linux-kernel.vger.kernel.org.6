Return-Path: <linux-kernel+bounces-271602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D737A9450A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64231B273FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57A1B9B41;
	Thu,  1 Aug 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjLWdf5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D21B3F09
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529919; cv=none; b=DBDxezeGUpIi3PXlWa+WHE+oURsfTh9iZ4bvElvb2odDKW75Ge6sPXfX6QJfH5w2UPqpq90KLwH6moJsTEMaEZ0jftoctPVbztiXoGxYVHkUGElf3gwxB7bb79ncnAYbnknoRuaW3RfzHiETagTOEzizYdTFhMpAAyNv3A/HA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529919; c=relaxed/simple;
	bh=kOqKi1gvp/YX1LyIRZvf1c8hhwmtLvO07SQgA4gCSC4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYa/BJOXak56fovClQXJBYyhlWCBUQrIDIUAH+UFi+Q6aMTTWuTZ21MNKYy8gf74o6vaAq52VatlINo74OvqTwKPJUuLjZu1YubTqglE5aD3dvrUnfSPnR6Gw0ZoOrbsEXVFo2bFLhyfkEWigaFzSRr0hros0fyDAV0QLbt1q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjLWdf5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722529915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nx2Psos8etE3ac3qTeYb/V7tISoRmYtQMJJ4hSX1mTQ=;
	b=XjLWdf5HWohDqXaZ4ud7zaU6iTwWCB/EfSeupX8C029Zx7VV4AaohMRbXJ00UupcXdq6RG
	UlwVQGufO6WvCxXy4jDqRRAZcg/ULl5gpCgEqjNGYKmMwG7UuNeQ+/RgwWORMtjNKNEaCq
	Soo0Yu4UXPq58UnXxPuDfipJ9qF5I6M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Akv2kPmIMF6IzrXTpu4RIw-1; Thu,
 01 Aug 2024 12:31:49 -0400
X-MC-Unique: Akv2kPmIMF6IzrXTpu4RIw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A22B51955D4A;
	Thu,  1 Aug 2024 16:31:47 +0000 (UTC)
Received: from [10.2.16.25] (unknown [10.2.16.25])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B545119560AA;
	Thu,  1 Aug 2024 16:31:45 +0000 (UTC)
Message-ID: <a3cee760-398f-4661-b4b5-f2fcfd5de7b7@redhat.com>
Date: Thu, 1 Aug 2024 12:31:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Do not clear xcpus when clearing
 cpus
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731092102.2369580-1-chenridong@huawei.com>
 <6a79b50a-ad74-4b1b-a98c-7da8ef341b24@redhat.com>
Content-Language: en-US
In-Reply-To: <6a79b50a-ad74-4b1b-a98c-7da8ef341b24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 7/31/24 23:22, Waiman Long wrote:
> On 7/31/24 05:21, Chen Ridong wrote:
>> After commit 737bb142a00d ("cgroup/cpuset: Make cpuset.cpus.exclusive
>> independent of cpuset.cpus"), cpuset.cpus.exclusive and cpuset.cpus
>> became independent. However we found that 
>> cpuset.cpus.exclusive.effective
>> is cleared when cpuset.cpus is clear. To fix this issue, just remove 
>> xcpus
>> clearing when cpuset.cpus is being cleared.
>>
>> It can be reproduced as below:
>> cd /sys/fs/cgroup/
>> mkdir test
>> echo +cpuset > cgroup.subtree_control
>> cd test
>> echo 3 > cpuset.cpus.exclusive
>> cat cpuset.cpus.exclusive.effective
>> 3
>> echo > cpuset.cpus
>> cat cpuset.cpus.exclusive.effective // was cleared
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index a9b6d56eeffa..248c39bebbe9 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2523,10 +2523,9 @@ static int update_cpumask(struct cpuset *cs, 
>> struct cpuset *trialcs,
>>        * that parsing.  The validate_change() call ensures that cpusets
>>        * with tasks have cpus.
>>        */
>> -    if (!*buf) {
>> +    if (!*buf)
>>           cpumask_clear(trialcs->cpus_allowed);
>> -        cpumask_clear(trialcs->effective_xcpus);
>> -    } else {
>> +    else {
>>           retval = cpulist_parse(buf, trialcs->cpus_allowed);
>>           if (retval < 0)
>>               return retval;
>
> Yes, that is a corner case bug that has not been properly handled.
>
> Reviewed-by: Waiman Long <longman@redhat.com>
>
With a second thought, I think we should keep the clearing of 
effective_xcpus if exclusive_cpus is empty. IOW

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6ba8313f1fc3..2023cd68d9bc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2516,7 +2516,8 @@ static int update_cpumask(struct cpuset *cs, 
struct cpuset *trialcs,
          */
         if (!*buf) {
                 cpumask_clear(trialcs->cpus_allowed);
-               cpumask_clear(trialcs->effective_xcpus);
+               if (cpumask_empty(trialcs->exclusive_cpus))
+ cpumask_clear(trialcs->effective_xcpus);
         } else {
                 retval = cpulist_parse(buf, trialcs->cpus_allowed);
                 if (retval < 0)

Thanks,
Longman


