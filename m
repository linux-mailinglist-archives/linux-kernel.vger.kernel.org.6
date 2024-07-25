Return-Path: <linux-kernel+bounces-262546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDA93C877
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C1D1F21C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74647A5C;
	Thu, 25 Jul 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AufllaqH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59B6FB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932976; cv=none; b=R05xxzbbsKu94Li+K0ASfF9fiL33qN/Kl3XVxCysrl9pLsZqvjtJ/muxKw7E2WrJ/qCOrDOxNDdzdtY/5s5mQRLU/01cBheiTs6WFZYHKhGMFEPloz5dxgfNDi1pNv8ey2P+3w6hQVffZCAH7bzrcYMF8InDLVV+d5E+KrzEH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932976; c=relaxed/simple;
	bh=htlozbdfP31fkGRXT+SJO0bb4rIwPmpYVc0TmXQEGkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixSevBrPu710+7uGCFzHEjggd2FxKy4fh7zrrwhdHog8qLLuKSJv1Mk1OOCcPfmYg+kSIIaiU5dR+0fuXLshiIWtVj6HA/W+JhyafBbWkiwKZcUN6lIzj+JRjGyXPK81N2/Mh8Gb4mikj0CO85Fi27w60NzKJHy4ZxBdQ4yvC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AufllaqH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721932973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhh3ef+SZX3Di+Ilex19CKfZBnmCa7mbwhplV/o/WOM=;
	b=AufllaqHP6yi1OpwXi1JKpVN0SNr8ECp5HYNUIJUPWVZtHpV5WikG/UE+/rxL7KgbDlyu1
	syIdlVX3P2s67IWurSXrS+go5Lt7VqxZO6NaG0cpNBrMw/lI0KXXMxuAVYKarPG5GOmHnr
	szFuExpiiKtuYB6MRmZesQ0vJCN3LV0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-5NAhdYa3PmyFGwwLDGPonA-1; Thu,
 25 Jul 2024 14:42:50 -0400
X-MC-Unique: 5NAhdYa3PmyFGwwLDGPonA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19E811955D42;
	Thu, 25 Jul 2024 18:42:48 +0000 (UTC)
Received: from [10.2.16.78] (unknown [10.2.16.78])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03C523000197;
	Thu, 25 Jul 2024 18:42:44 +0000 (UTC)
Message-ID: <c218d869-c429-4289-a7a6-4c4ba2e13c3b@redhat.com>
Date: Thu, 25 Jul 2024 14:42:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/cpuset: remove child_ecpus_count
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724102418.2213801-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240724102418.2213801-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/24/24 06:24, Chen Ridong wrote:
> The child_ecpus_count variable was previously used to update
> sibling cpumask when parent's effective_cpus is updated. However, it became
> obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
> cpuset.cpus.exclusive for v2"). It should be removed.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 40ec4abaf440..d4322619e59a 100644
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
> @@ -1688,12 +1685,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   	spin_lock_irq(&callback_lock);
>   	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>   	list_add(&cs->remote_sibling, &remote_children);
> -	if (cs->use_parent_ecpus) {
> -		struct cpuset *parent = parent_cs(cs);
> -
> +	if (cs->use_parent_ecpus)
>   		cs->use_parent_ecpus = false;
> -		parent->child_ecpus_count--;
> -	}
>   	spin_unlock_irq(&callback_lock);
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   
> @@ -2318,15 +2311,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		 */
>   		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
>   			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
> -			if (!cp->use_parent_ecpus) {
> +			if (!cp->use_parent_ecpus)
>   				cp->use_parent_ecpus = true;
> -				parent->child_ecpus_count++;
> -			}
> -		} else if (cp->use_parent_ecpus) {
> +		} else if (cp->use_parent_ecpus)
>   			cp->use_parent_ecpus = false;
> -			WARN_ON_ONCE(!parent->child_ecpus_count);
> -			parent->child_ecpus_count--;
> -		}
>   

The usual practice is to keep the {} in the else part even if it is a 
single statement when the if-part requires {}. Anyway, it is a minor issue.

Acked-by: Waiman Long <longman@redhat.com>


