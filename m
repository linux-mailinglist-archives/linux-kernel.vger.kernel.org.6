Return-Path: <linux-kernel+bounces-292702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41D957331
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB9CB2588C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF32189531;
	Mon, 19 Aug 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhdOvzVP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC818950C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092098; cv=none; b=VFHPbZ7aSifQYPxjA3FlhdD3BHeyEEYv2D0On2ct2/6vtIfWB0bhy1AUDAyn1GucLZ6NIsr+d5DD5/vDZ30A6Jzvudq/PJmyZ6Hdjv7h/0dUecwAyHU/t5HUP5aq6LC642ww065tUClkUDBZyGvBFKFnuqebVPMH8DCwsdbYR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092098; c=relaxed/simple;
	bh=ZDQ+TDW+HPT/YJS7AVC+yHRmKHezCl4fWxH3oUtNFO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os++hWAhXlFw0dD43vMkilHm3KvpnCh7vpJO4Sp+OhWX761V1uaXXhKvAlK4ihFrkz8DUW05+Q9csXf38nBgoWXIunQ5KeZ3+89TpSEV94sbmy2YjTm2nCFIq8rrA6ETvSWfxodOAzysLt4iEUtR2fmmKsO4pQKbheWqVkRxoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhdOvzVP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724092095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzjhezZUo+KI0ryUIGmAiZd+8vS7leDdCZdWAg18fY=;
	b=AhdOvzVPfo6dzl3i4szU5Ia07Fbi4R+lA8taB2w9BRQu33RMrXcpuoBza9Iav5JoInpOlT
	T0DSU+PI9nVjj0gml7jwalJKsaWcD5powLEtD300MQZvJJfUMKXwh8xkrizGKKbj7/ti1P
	VAQqPgPzpdCm4EUg+04xUi7/AfpIOlU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-I3jhCJ5bMgWvm3MhOVz9oA-1; Mon,
 19 Aug 2024 14:28:10 -0400
X-MC-Unique: I3jhCJ5bMgWvm3MhOVz9oA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6B7B19560B1;
	Mon, 19 Aug 2024 18:28:08 +0000 (UTC)
Received: from [10.2.16.112] (unknown [10.2.16.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE8E61956053;
	Mon, 19 Aug 2024 18:28:06 +0000 (UTC)
Message-ID: <c1225ca7-5b4a-42f8-bb16-f435c6137d95@redhat.com>
Date: Mon, 19 Aug 2024 14:28:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] cgroup/cpuset: remove fetch_xcpus
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816082727.2779-1-chenridong@huawei.com>
 <20240816082727.2779-3-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240816082727.2779-3-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/16/24 04:27, Chen Ridong wrote:
> Both fetch_xcpus and user_xcpus functions are used to retrieve the value
> of exclusive_cpus. If exclusive_cpus is not set, cpus_allowed is the
> implicit value used as exclusive in a local partition. I can not imagine
> a scenario where effective_xcpus is not empty when exclusive_cpus is
> empty. Therefore, I suggest removing the fetch_xcpus function.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fdd5346616d3..8be0259065f5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -771,13 +771,6 @@ static inline bool xcpus_empty(struct cpuset *cs)
>   	       cpumask_empty(cs->exclusive_cpus);
>   }
>   
> -static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
> -{
> -	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
> -	       cpumask_empty(cs->effective_xcpus) ? cs->cpus_allowed
> -						  : cs->effective_xcpus;
> -}
> -
>   /*
>    * cpusets_are_exclusive() - check if two cpusets are exclusive
>    *
> @@ -785,8 +778,8 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
>    */
>   static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   {
> -	struct cpumask *xcpus1 = fetch_xcpus(cs1);
> -	struct cpumask *xcpus2 = fetch_xcpus(cs2);
> +	struct cpumask *xcpus1 = user_xcpus(cs1);
> +	struct cpumask *xcpus2 = user_xcpus(cs2);
>   
>   	if (cpumask_intersects(xcpus1, xcpus2))
>   		return false;
> @@ -2585,7 +2578,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		invalidate = true;
>   		rcu_read_lock();
>   		cpuset_for_each_child(cp, css, parent) {
> -			struct cpumask *xcpus = fetch_xcpus(trialcs);
> +			struct cpumask *xcpus = user_xcpus(trialcs);
>   
>   			if (is_partition_valid(cp) &&
>   			    cpumask_intersects(xcpus, cp->effective_xcpus)) {

LGTM.

Reviewed-by: Waiman Long <longman@redhat.com>


