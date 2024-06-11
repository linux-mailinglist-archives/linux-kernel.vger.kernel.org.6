Return-Path: <linux-kernel+bounces-210384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CD904309
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5551F21B30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7759162;
	Tue, 11 Jun 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1XfzG8e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0260482D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128922; cv=none; b=RTw0mCIoX61RGTIBC1jEGPCbXsAP1OVQ1T/QHVAqza6rFGtd5rDHYsOHdpdXtP0mmOWhRJjbn4saVQhhm5HOR3g99GvSKe9MiGE9VSCj2sgEsAitplZaYBub5jo6Qh1obMQBmcf2VWU4vk7MM5DbCG/MWfECHQpiw7MRrwDCzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128922; c=relaxed/simple;
	bh=OWF7nEj5DBu3q8/A/HxsLgxKjxJne8cXVcKM/+gUA6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qsa3KaL2/ua2MNBj4MpKLN9O+D7YBDiG09gT0+/T+D9dw99N9o/mxwztd/YgcnBacYH4bw/NDabvKx9ycIk6XfyhcM3xGB9b3mGquseJKxE5Sx718pbJwMB5+FhE5DzOppy6PObZ2frzJHxQITrCGcbin5NHxteU2Gj4ewFId7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1XfzG8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718128919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boT4WhMfNiG1uf94oCjXPXPBcHUmJoyRMB9nHGWn29M=;
	b=L1XfzG8eQpfFkUpwZCzZRuMYNqmjjixC4YAxk7dI2AgsACyHZ2R3acP2R5gtHox75pqcOB
	9tyoZENpVOEi6fsupIZuy6dcOL1gmEhsFL+/4qJZyyszZn7TJM/VWKDJOtkcjJLQj7QX/Y
	d7MEREn27mkLxh3L/+Z9hsQwojBljhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-1QbIF7p3MVCq-fXVdzBBpA-1; Tue,
 11 Jun 2024 14:01:56 -0400
X-MC-Unique: 1QbIF7p3MVCq-fXVdzBBpA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C450195606E;
	Tue, 11 Jun 2024 18:01:53 +0000 (UTC)
Received: from [10.22.33.230] (unknown [10.22.33.230])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6089C1956087;
	Tue, 11 Jun 2024 18:01:51 +0000 (UTC)
Message-ID: <360b7a0c-6f70-42eb-b41d-b0d1325b0586@redhat.com>
Date: Tue, 11 Jun 2024 14:01:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 1/2] cgroup/cpuset: Fix remote root partition
 creation problem
To: ghostxavier@sina.com
Cc: cgroups <cgroups@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, tj <tj@kernel.org>,
 "lizefan.x" <lizefan.x@bytedance.com>, hannes <hannes@cmpxchg.org>
References: <6661b33c7f1670.55086514.d793e57a@m1.mail.sina.com.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <6661b33c7f1670.55086514.d793e57a@m1.mail.sina.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6/6/24 09:01, Xavier wrote:
> Hi Longman,
>
> I have a small question about your new patch.
> I wonder that in cgroup v2,  will there be any overlap between valid partition roots and top_cpuset? If it is not, the section starting with 'restart:' that searches for overlapping cpusets can be skipped for cgroup v2. Otherwise, if there are any overlap, then the assignment to 'dom' may need perform an cpumask_or operation?

In cgroup v2, the top_cpuset is a non-isolating partition root by itself 
and its partition root state cannot be changed.

The reason for the introduction of the partition feature in cgroup v2 
was to support the creation of a separate sched domain. cgroup v1 
supports that indirectly via clever use of the cpuset.sched_load_balance 
flag. So by definition, the presence of a non-isolating partition root 
defines a new sched domain.

Cheers,
Longman

> Best regards,
> Xavier
>
>> ----- Original Message -----
>> From: Waiman Long <longman@redhat.com>
>> To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
>> Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Xavier <ghostxavier@sina.com>, Waiman Long <longman@redhat.com>
>> Subject: [PATCH-cgroup 1/2] cgroup/cpuset: Fix remote root partition creation problem
>> Date: 2024-06-06 01:19
>>
>> Since commit 181c8e091aae ("cgroup/cpuset: Introduce remote partition"),
>> a remote partition can be created underneath a non-partition root cpuset
>> as long as its exclusive_cpus are set to distribute exclusive CPUs down
>> to its children. The generate_sched_domains() function, however, doesn't
>> take into account this new behavior and hence will fail to create the
>> sched domain needed for a remote root (non-isolated) partition.
>> There are two issues related to remote partition support. First of
>> all, generate_sched_domains() has a fast path that is activated if
>> root_load_balance is true and top_cpuset.nr_subparts is non-zero. The
>> later condition isn't quite correct for remote partitions as nr_subparts
>> just shows the number of local child partitions underneath it. There
>> can be no local child partition under top_cpuset even if there are
>> remote partitions further down the hierarchy. Fix that by checking
>> for subpartitions_cpus which contains exclusive CPUs allocated to both
>> local and remote partitions.
>> Secondly, the valid partition check for subtree skipping in the csa[]
>> generation loop isn't enough as remote partition does not need to
>> have a partition root parent. Fix this problem by breaking csa[] array
>> generation loop of generate_sched_domains() into v1 and v2 specific parts
>> and checking a cpuset's exclusive_cpus before skipping its subtree in
>> the v2 case.
>> Also simplify generate_sched_domains() for cgroup v2 as only
>> non-isolating partition roots should be included in building the cpuset
>> array and none of the v1 scheduling attributes other than a different
>> way to create an isolated partition are supported.
>> Fixes: 181c8e091aae ("cgroup/cpuset: Introduce remote partition")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>> kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++++----------
>> 1 file changed, 42 insertions(+), 13 deletions(-)
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index f9b97f65e204..fb71d710a603 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -169,7 +169,7 @@ struct cpuset {
>> 	/* for custom sched domain */
>> 	int relax_domain_level;
>>
>> -	/* number of valid sub-partitions */
>> +	/* number of valid local child partitions */
>> 	int nr_subparts;
>>
>> 	/* partition root state */
>> @@ -957,13 +957,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>> 	int nslot;		/* next empty doms[] struct cpumask slot */
>> 	struct cgroup_subsys_state *pos_css;
>> 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
>> +	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
>>
>> 	doms = NULL;
>> 	dattr = NULL;
>> 	csa = NULL;
>>
>> 	/* Special case for the 99% of systems with one, full, sched domain */
>> -	if (root_load_balance && !top_cpuset.nr_subparts) {
>> +	if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
>> single_root_domain:
>> 		ndoms = 1;
>> 		doms = alloc_sched_domains(ndoms);
>> @@ -992,16 +993,18 @@ static int generate_sched_domains(cpumask_var_t **domains,
>> 	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>> 		if (cp == &top_cpuset)
>> 			continue;
>> +
>> +		if (cgrpv2)
>> +			goto v2;
>> +
>> 		/*
>> +		 * v1:
>> 		 * Continue traversing beyond @cp iff @cp has some CPUs and
>> 		 * isn't load balancing.  The former is obvious.  The
>> 		 * latter: All child cpusets contain a subset of the
>> 		 * parent's cpus, so just skip them, and then we call
>> 		 * update_domain_attr_tree() to calc relax_domain_level of
>> 		 * the corresponding sched domain.
>> -		 *
>> -		 * If root is load-balancing, we can skip @cp if it
>> -		 * is a subset of the root's effective_cpus.
>> 		 */
>> 		if (!cpumask_empty(cp->cpus_allowed) &&
>> 		    !(is_sched_load_balance(cp) &&
>> @@ -1009,16 +1012,28 @@ static int generate_sched_domains(cpumask_var_t **domains,
>> 					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
>> 			continue;
>>
>> -		if (root_load_balance &&
>> -		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
>> -			continue;
>> -
>> 		if (is_sched_load_balance(cp) &&
>> 		    !cpumask_empty(cp->effective_cpus))
>> 			csa[csn++] = cp;
>>
>> -		/* skip @cp's subtree if not a partition root */
>> -		if (!is_partition_valid(cp))
>> +		/* skip @cp's subtree */
>> +		pos_css = css_rightmost_descendant(pos_css);
>> +		continue;
>> +
>> +v2:
>> +		/*
>> +		 * Only valid partition roots that are not isolated and with
>> +		 * non-empty effective_cpus will be saved into csn[].
>> +		 */
>> +		if ((cp->partition_root_state == PRS_ROOT) &&
>> +		    !cpumask_empty(cp->effective_cpus))
>> +			csa[csn++] = cp;
>> +
>> +		/*
>> +		 * Skip @cp's subtree if not a partition root and has no
>> +		 * exclusive CPUs to be granted to child cpusets.
>> +		 */
>> +		if (!is_partition_valid(cp) && cpumask_empty(cp->exclusive_cpus))
>> 			pos_css = css_rightmost_descendant(pos_css);
>> 	}
>> 	rcu_read_unlock();
>> @@ -1072,6 +1087,20 @@ static int generate_sched_domains(cpumask_var_t **domains,
>> 	dattr = kmalloc_array(ndoms, sizeof(struct sched_domain_attr),
>> 			      GFP_KERNEL);
>>
>> +	/*
>> +	 * Cgroup v2 doesn't support domain attributes, just set all of them
>> +	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
>> +	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
>> +	 */
>> +	if (cgrpv2) {
>> +		for (i = 0; i < ndoms; i++) {
>> +			cpumask_copy(doms[i], csa[i]->effective_cpus);         /*****************************************/
>> +			if (dattr)
>> +				dattr[i] = SD_ATTR_INIT;
>> +		}
>> +		goto done;
>> +	}
>> +
>> 	for (nslot = 0, i = 0; i < csn; i++) {
>> 		struct cpuset *a = csa[i];
>> 		struct cpumask *dp;
>> @@ -1231,7 +1260,7 @@ static void rebuild_sched_domains_locked(void)
>> 	 * root should be only a subset of the active CPUs.  Since a CPU in any
>> 	 * partition root could be offlined, all must be checked.
>> 	 */
>> -	if (top_cpuset.nr_subparts) {
>> +	if (!cpumask_empty(subpartitions_cpus)) {
>> 		rcu_read_lock();
>> 		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>> 			if (!is_partition_valid(cs)) {
>> @@ -4575,7 +4604,7 @@ static void cpuset_handle_hotplug(void)
>> 	 * In the rare case that hotplug removes all the cpus in
>> 	 * subpartitions_cpus, we assumed that cpus are updated.
>> 	 */
>> -	if (!cpus_updated && top_cpuset.nr_subparts)
>> +	if (!cpus_updated && !cpumask_empty(subpartitions_cpus))
>> 		cpus_updated = true;
>>
>> 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
>> -- 
>> 2.39.3


