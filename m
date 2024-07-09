Return-Path: <linux-kernel+bounces-246235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B961592BF72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62681C23617
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96619DF71;
	Tue,  9 Jul 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ldo0q05F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CE19DF6C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541356; cv=none; b=Q1pKsNWh2lUp1ISLYzR7HUWxKHkez+LM29sEPDpaxQjR8yGrT1R5746MMNYmqg4gn+dzKEhpvSQLy4qr6dPdTkB9SY6qWTJ0ZMCYj5AcHQQDZ00fokuiQH6tDTOwmcv6cz/DEbpMycYGLK6o4LiJyw4tL+UWpE1sR39idO9kQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541356; c=relaxed/simple;
	bh=FGRnS6HrOy8B60pAUYJYvZ43kcQMTlUlioArToOkYZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LroJSrmNGbhTjF3WJL7ICQsmFzB1h2zpznXUKjzCgYaDgSZr0mfcdlYTr2WVbddntVt8oavs1r8RnDgKIfXa3fHYx8wZiwcr/srO9kQBLMkZLFhlpdySuZAncE24YfpNNmgMnUcTNZ3E4pxlRedOLxeWmoxu/zjtuD3zm+5kGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ldo0q05F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720541353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsIWbJCIxtXdUtyfcJ/HuCRS5/rhV3Z8dkkrqoWXNu8=;
	b=Ldo0q05F8PW/QjPLAM848yySfL5SECgOAgll6rkSWdLe5Th42kLMCpPTX9NiA5mJZ55uQl
	OpZj76kGs81kbGnMQ8u+VabQ+sDWrM/h6kGODZrqLmSVHQwK2EscH5cR79h9VcJjYUAt/M
	C9w79xgB3TXnx57f5RS3X3EjY8XYvtk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-PxWcNCzsPEK7IR4Uy1xlTg-1; Tue,
 09 Jul 2024 12:09:10 -0400
X-MC-Unique: PxWcNCzsPEK7IR4Uy1xlTg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40AFE1955F67;
	Tue,  9 Jul 2024 16:09:08 +0000 (UTC)
Received: from [10.22.34.7] (unknown [10.22.34.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29E8C3000181;
	Tue,  9 Jul 2024 16:09:05 +0000 (UTC)
Message-ID: <4291c0ed-bc37-46de-b081-271e8b299b1d@redhat.com>
Date: Tue, 9 Jul 2024 12:09:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo
 <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709132814.2198740-1-longman@redhat.com>
 <1c0d9ee1-e80a-46da-a48d-2ab23dd04673@oracle.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1c0d9ee1-e80a-46da-a48d-2ab23dd04673@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/9/24 11:58, Kamalesh Babulal wrote:
>
> On 7/9/24 6:58 PM, Waiman Long wrote:
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups. That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
>> responsible.  This patch adds CSS counts in the cgroup_subsys structure
>> to keep track of the number of CSSes for each of the cgroup subsystems.
>>
>> As cgroup v2 had deprecated the use of /proc/cgroups, the root
>> cgroup.stat file is extended to show the number of outstanding CSSes
>> associated with all the non-inhibited cgroup subsystems that have been
>> bound to cgroup v2.  This will help us pinpoint which subsystems may be
>> responsible for the increasing number of dying (nr_dying_descendants)
>> cgroups.
>>
>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 53
>> 	nr_dying_descendants 34
>> 	nr_cpuset 1
>> 	nr_cpu 40
>> 	nr_io 40
>> 	nr_memory 87
>> 	nr_perf_event 54
>> 	nr_hugetlb 1
>> 	nr_pids 53
>> 	nr_rdma 1
>> 	nr_misc 1
>>
>> In this particular case, it can be seen that memory cgroup is the most
>> likely culprit for causing the 34 dying cgroups.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
>>   include/linux/cgroup-defs.h             |  3 +++
>>   kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 52763d6b2919..65af2f30196f 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
>>   		A dying cgroup can consume system resources not exceeding
>>   		limits, which were active at the moment of cgroup deletion.
>>   
>> +	  nr_<cgroup_subsys>
>> +		Total number of cgroups associated with that cgroup
>> +		subsystem, e.g. cpuset or memory.  These cgroup counts
>> +		will only be shown in the root cgroup and for subsystems
>> +		bound to cgroup v2.
>> +
>>     cgroup.freeze
>>   	A read-write single value file which exists on non-root cgroups.
>>   	Allowed values are "0" and "1". The default is "0".
>> @@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
>>   
>>   - "cgroup.clone_children" is removed.
>>   
>> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
>> -  at the root instead.
>> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
>> +  "cgroup.stat" files at the root instead.
>>   
>>   
>>   Issues with v1 and Rationales for v2
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index b36690ca0d3f..522ab77f0406 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -776,6 +776,9 @@ struct cgroup_subsys {
>>   	 * specifies the mask of subsystems that this one depends on.
>>   	 */
>>   	unsigned int depends_on;
>> +
>> +	/* Number of CSSes, used only for /proc/cgroups */
>> +	atomic_t nr_csses;
>>   };
>>   
>>   extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index c8e4b62b436a..48eba2737b1a 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3669,12 +3669,27 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>   static int cgroup_stat_show(struct seq_file *seq, void *v)
>>   {
>>   	struct cgroup *cgroup = seq_css(seq)->cgroup;
>> +	struct cgroup_subsys *ss;
>> +	int i;
>>   
>>   	seq_printf(seq, "nr_descendants %d\n",
>>   		   cgroup->nr_descendants);
>>   	seq_printf(seq, "nr_dying_descendants %d\n",
>>   		   cgroup->nr_dying_descendants);
>>   
>> +	if (cgroup_parent(cgroup))
>> +		return 0;
>> +
>> +	/*
>> +	 * For the root cgroup, shows the number of csses associated
>> +	 * with each of non-inhibited cgroup subsystems bound to it.
>> +	 */
>> +	do_each_subsys_mask(ss, i, ~cgrp_dfl_inhibit_ss_mask) {
>> +		if (ss->root != &cgrp_dfl_root)
>> +			continue;
>> +		seq_printf(seq, "nr_%s %d\n", ss->name,
>> +			   atomic_read(&ss->nr_csses));
>> +	} while_each_subsys_mask();
>>   	return 0;
>>   }
>>   
> Thanks for adding nr_csses, the patch looks good to me. A preference comment,
> nr_<subsys>_css format, makes it easier to interpret the count.
>
> With or without the changes to the cgroup subsys format:
>
> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Thanks for the review.

CSS is a kernel internal name for cgroup subsystem state. Non kernel 
developers or users may not know what CSS is and cgroup-v2.rst doesn't 
mention CSS at all. So I don't think it is a good idea to add the "_css" 
suffix. From the user point of view, the proper term to use here is the 
number of cgroups, just like what "nr_descendants" and 
"nr_dying_descendants" are referring to before this patch. The only 
issue that I didn't address is the use of the proper plural form which 
is hard for cgroup subsystem names that we have.

Cheers,
Longman



