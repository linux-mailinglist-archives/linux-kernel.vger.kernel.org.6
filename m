Return-Path: <linux-kernel+bounces-291334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7B956103
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F97DB21918
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A0224FD;
	Mon, 19 Aug 2024 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYnJV+NB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1E1CF83
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033678; cv=none; b=bmjslxYLHjGxt+wMbSFcxAXL6Uft55UA66cOvgX/dCe+ab5T3sKT1eJBJhX/YGopCGohIuHO9LKtWj2T6oozZKu9AKz72uWUlLI53t+fR/ehXLD/138W3UeUJP8u6UM0SiKAiqSg1myUOaXh9rmIghJQ/arj1QyZjQZnAW47mPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033678; c=relaxed/simple;
	bh=RQqi5+5HdGXpnzT7g0L3jo7GUz+QodVWGFbrAbuGTwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPkv9Tk0gOP8mowqoXXYO/4/3kobAIRVmzTlXJir/e2jngyvAuShCplIeY4OtbbOGGP54he/UAmxoCDTlK5tBLcLkcy50vYG0pO/0kJXxS6YRuB07L3W5uqTvOYQ5IXt/dAv16ys3BlZHF4y6+gSRDHwD/DjvGjJ+GhkkpWVl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYnJV+NB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724033675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdO7TIP1EJ756Dgvzf3iDAQzqdwGqtd9g2IrKj0K2/M=;
	b=bYnJV+NBtpoMJcgo+j9iBnJpwOvl1M7lau1HyPkUm9aVAwsRBjDPXPN6nJ7LEOrv2p8dUg
	j6mSRPYgL8Jj8SNoDJfBRyAzXFntBwQegtlq13hW0gXPDXGPD8I2Ji/JTsM0rOpDKQmg5Y
	ymlkfxKn8zrTG/ZiHaAd+pbYWkpGB0E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ZlWy0JuBMJeMksbmUIQz5A-1; Sun,
 18 Aug 2024 22:14:32 -0400
X-MC-Unique: ZlWy0JuBMJeMksbmUIQz5A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 177811955D4A;
	Mon, 19 Aug 2024 02:14:30 +0000 (UTC)
Received: from [10.2.16.4] (unknown [10.2.16.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD41B19773DF;
	Mon, 19 Aug 2024 02:14:27 +0000 (UTC)
Message-ID: <dc4672a0-bff4-493f-81da-9dfdda9018f2@redhat.com>
Date: Sun, 18 Aug 2024 22:14:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cgroup/cpuset: Correct invalid remote parition
 prs
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816082727.2779-1-chenridong@huawei.com>
 <20240816082727.2779-2-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240816082727.2779-2-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 8/16/24 04:27, Chen Ridong wrote:
> When enable a remote partition, I found that:
>
> cd /sys/fs/cgroup/
> mkdir test
> mkdir test/test1
> echo +cpuset > cgroup.subtree_control
> echo +cpuset >  test/cgroup.subtree_control
> echo 3 > test/test1/cpuset.cpus
> echo root > test/test1/cpuset.cpus.partition
> cat test/test1/cpuset.cpus.partition
> root invalid (Parent is not a partition root)
>
> The parent of a remote partition could not be a root. This is due to the
> emtpy effective_xcpus. It would be better to prompt the message "invalid
> cpu list in cpuset.cpus.exclusive".
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e34fd6108b06..fdd5346616d3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -80,6 +80,7 @@ enum prs_errcode {
>   	PERR_HOTPLUG,
>   	PERR_CPUSEMPTY,
>   	PERR_HKEEPING,
> +	PERR_PMT,
>   };
>   
>   static const char * const perr_strings[] = {
> @@ -91,6 +92,7 @@ static const char * const perr_strings[] = {
>   	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
>   	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
>   	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
> +	[PERR_PMT]       = "Enable partition not permitted",
>   };
>   
>   struct cpuset {
> @@ -1669,7 +1671,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	 * The user must have sysadmin privilege.
>   	 */
>   	if (!capable(CAP_SYS_ADMIN))
> -		return 0;
> +		return PERR_PMT;
>   
>   	/*
>   	 * The requested exclusive_cpus must not be allocated to other
> @@ -1683,7 +1685,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	if (cpumask_empty(tmp->new_cpus) ||
>   	    cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
>   	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
> -		return 0;
> +		return PERR_INVCPUS;
>   
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1698,7 +1700,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	 */
>   	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>   	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
> -	return 1;
> +	return 0;
>   }

Since you are changing the meaning of the function returned value, you 
should also update the return value comment as well.

>   
>   /*
> @@ -3151,24 +3153,26 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		goto out;
>   
>   	if (!old_prs) {
> -		enum partition_cmd cmd = (new_prs == PRS_ROOT)
> -				       ? partcmd_enable : partcmd_enablei;
> -
>   		/*
> -		 * cpus_allowed and exclusive_cpus cannot be both empty.
> -		 */
> -		if (xcpus_empty(cs)) {
> -			err = PERR_CPUSEMPTY;
> -			goto out;
> -		}
> +		* If parent is valid partition, enable local partiion.
> +		* Otherwise, enable a remote partition.
> +		*/
> +		if (is_partition_valid(parent)) {
> +			enum partition_cmd cmd = (new_prs == PRS_ROOT)
> +					       ? partcmd_enable : partcmd_enablei;
>   
> -		err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
> -		/*
> -		 * If an attempt to become local partition root fails,
> -		 * try to become a remote partition root instead.
> -		 */
> -		if (err && remote_partition_enable(cs, new_prs, &tmpmask))
> -			err = 0;
> +			/*
> +			 * cpus_allowed and exclusive_cpus cannot be both empty.
> +			 */
> +			if (xcpus_empty(cs)) {
> +				err = PERR_CPUSEMPTY;
> +				goto out;
> +			}

The xcpus_empty() check should be done for both local and remote partition.

Cheers,
Longman

> +
> +			err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
> +		} else {
> +			err = remote_partition_enable(cs, new_prs, &tmpmask);
> +		}
>   	} else if (old_prs && new_prs) {
>   		/*
>   		 * A change in load balance state only, no change in cpumasks.


