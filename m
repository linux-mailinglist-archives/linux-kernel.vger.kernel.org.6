Return-Path: <linux-kernel+bounces-260571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426693AB07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6452B23487
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FE14295;
	Wed, 24 Jul 2024 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxh96yz2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687517753
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787391; cv=none; b=AwrnYPYp9RkrOdn1TEe2n3H8h0+oeiql/f5Z2syCJwnqQWf4K7vEjZA91DWZW+nAqpOROQ9Uk+tL+7wGA8bc34Eljrv2ZEk2ImQe84Raou+pFq9UHzq5CtHvUSBOAVsgYLxNrhpzDnLLjrI4deUCIktp9J5eEec3U5XRHJiRF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787391; c=relaxed/simple;
	bh=2KF5CLSHMcuWmpEwXGoRe2/YBKLRgcnq1xopAFEh+zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMs7loeiRnCS4giOz+5stpczDg8xTbrVhRXcwo4lQsy35r9zrB/43alhrXyAT7cAP8XuyfIQACjSlPxBVznsrDpWlZr0fA6NMElJhoureGZLW5vZTRpyXVlEOgMcp1l3wu5sSsh1LylSczr4JkwmggqX554z8/1R7tSs5+U22tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zxh96yz2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap1Xjy1gW7dRdb1Kl5Qn6BbVa8KlAOf92YtxXu2UTdk=;
	b=Zxh96yz2C75FiW4q+FbpObgIvpkGFTDgYZiFrMtubmZAvx8XxiCmIdHkgXOGdlaB2O3Zhr
	dXCxCiGCYqARw0mXWGWqoOpz+v+4OyYp/PhHgfXF7JbyrPfZ9Jp+s7E0aeIOAiax7LHXV0
	GMz+ABnHqZ+dbZAmPx95Qdlh9CBnKEc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-zzj-w_EvONKOUdbTrYBd1w-1; Tue,
 23 Jul 2024 22:16:26 -0400
X-MC-Unique: zzj-w_EvONKOUdbTrYBd1w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F16519560B0;
	Wed, 24 Jul 2024 02:16:24 +0000 (UTC)
Received: from [10.22.33.107] (unknown [10.22.33.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E03E1955F40;
	Wed, 24 Jul 2024 02:16:21 +0000 (UTC)
Message-ID: <145e04fe-1e21-4e64-a825-807af3d4434d@redhat.com>
Date: Tue, 23 Jul 2024 22:16:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: remove child_ecpus_count
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724010803.2195033-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240724010803.2195033-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/23/24 21:08, Chen Ridong wrote:
> The child_ecpus_count variable was previously used to update
> sibling cpumask when parent's effective_cpus is updated. However, it became
> obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
> cpuset.cpus.exclusive for v2"). It should be removed.
Thanks for finding that.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 40ec4abaf440..146bf9258db2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -188,10 +188,8 @@ struct cpuset {
>   	/*
>   	 * Default hierarchy only:
>   	 * use_parent_ecpus - set if using parent's effective_cpus
> -	 * child_ecpus_count - # of children with use_parent_ecpus set
>   	 */
>   	int use_parent_ecpus;
> -	int child_ecpus_count;
>   
>   	/*
>   	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
> @@ -1512,7 +1510,6 @@ static void reset_partition_data(struct cpuset *cs)
>   	if (!cpumask_and(cs->effective_cpus,
>   			 parent->effective_cpus, cs->cpus_allowed)) {
>   		cs->use_parent_ecpus = true;
> -		parent->child_ecpus_count++;
>   		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>   	}
>   }
> @@ -1689,10 +1686,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>   	list_add(&cs->remote_sibling, &remote_children);
>   	if (cs->use_parent_ecpus) {
> -		struct cpuset *parent = parent_cs(cs);
> -
>   		cs->use_parent_ecpus = false;
> -		parent->child_ecpus_count--;
>   	}
You can also remove { } or just set use_parent_ecpus to false.
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
> @@ -2320,12 +2314,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
>   			if (!cp->use_parent_ecpus) {
>   				cp->use_parent_ecpus = true;
> -				parent->child_ecpus_count++;
>   			}
Just set it to true.
>   		} else if (cp->use_parent_ecpus) {
>   			cp->use_parent_ecpus = false;
> -			WARN_ON_ONCE(!parent->child_ecpus_count);
> -			parent->child_ecpus_count--;
>   		}
Remove {} or set it to false.
>   
>   		if (remote)
> @@ -4139,7 +4130,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>   		cs->effective_mems = parent->effective_mems;
>   		cs->use_parent_ecpus = true;
> -		parent->child_ecpus_count++;
>   	}
>   	spin_unlock_irq(&callback_lock);
>   
> @@ -4206,10 +4196,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>   		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>   
>   	if (cs->use_parent_ecpus) {
> -		struct cpuset *parent = parent_cs(cs);
> -
>   		cs->use_parent_ecpus = false;
> -		parent->child_ecpus_count--;
>   	}
>   
Just set it to false.

Cheers,
Longman


