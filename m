Return-Path: <linux-kernel+bounces-274059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99E9472F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1288B20B51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E413C80C;
	Mon,  5 Aug 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPO60WLP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7017C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821008; cv=none; b=ltZ/+ZPoKJRTlbgYJf+nafA/Ozs3KXNoyzTc3Bq12sPgNPuMJnRhXF0JLb5MQNtuAN4fmp/479Z3PlZOp6UpIWzwQCPFiTaK/nNyiQMCCVbrBQIDHzewhQr9Dkelg6/vNQb1VsSA2oicUWrjY37gZydLuEQGYRGW7MSEXBvhttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821008; c=relaxed/simple;
	bh=TWAZCKc/8sdi9bViyLItAX5wY99RNU5L4u+VGSfnumE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqy61O572QKIYOUu2U5QqwoyMe8lLjbq8H7YW1w1LHsK58hA5bOwVNUrnTiPu98WsI+lDWkePVl3tF9oq9gmNYhDfEYMTNcUvioVfTsbVohb8AExBcsyCEZz5yiU5JKBi0SCz0VK+1mYaeWA+32L7hzJtVZyGn4AjQAsQ4ef8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPO60WLP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVIi7B3AYBw3NNFHNxFdJ1PfaBxB+CqFqO3o2h/IpZ4=;
	b=RPO60WLPui2+g0CLRewq1bgjl8cOmtq0lEYEvZ5SYcWqFJ9zcLfsKnf6Yi4vdq6tHtO9Iw
	5U6lNRNl55HdbIaVB3YL9dbj3NqjFzThtiSGeqU7XOr/64bUa12lMrZDQLeXa9TWEt9Jtc
	44Dk20Sww1xw51kDeyqNQJwCAQd6Tl0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-ePaFIir1PZ6xL-wVrX2Gpg-1; Sun,
 04 Aug 2024 21:23:21 -0400
X-MC-Unique: ePaFIir1PZ6xL-wVrX2Gpg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79C8B1955F56;
	Mon,  5 Aug 2024 01:23:19 +0000 (UTC)
Received: from [10.2.16.2] (unknown [10.2.16.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33D9C19560AE;
	Mon,  5 Aug 2024 01:23:16 +0000 (UTC)
Message-ID: <e8186bf5-51ed-453f-8ba2-350735a2b058@redhat.com>
Date: Sun, 4 Aug 2024 21:23:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/pids: Remove unreachable paths of
 pids_{can,cancel}_fork
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiujianfeng@huawei.com
References: <20240805004304.57314-1-xiujianfeng@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240805004304.57314-1-xiujianfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 8/4/24 20:43, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> According to the implementation of cgroup_css_set_fork(), it will fail
> if cset cannot be found and the can_fork/cancel_fork methods will not
> be called in this case, which means that the argument 'cset' for these
> methods must not be NULL, so remove the unrechable paths in them.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
> v2: reword the commit message
> ---
>   kernel/cgroup/pids.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
> index 34aa63d7c9c6..8f61114c36dd 100644
> --- a/kernel/cgroup/pids.c
> +++ b/kernel/cgroup/pids.c
> @@ -272,15 +272,10 @@ static void pids_event(struct pids_cgroup *pids_forking,
>    */
>   static int pids_can_fork(struct task_struct *task, struct css_set *cset)
>   {
> -	struct cgroup_subsys_state *css;
>   	struct pids_cgroup *pids, *pids_over_limit;
>   	int err;
>   
> -	if (cset)
> -		css = cset->subsys[pids_cgrp_id];
> -	else
> -		css = task_css_check(current, pids_cgrp_id, true);
> -	pids = css_pids(css);
> +	pids = css_pids(cset->subsys[pids_cgrp_id]);
>   	err = pids_try_charge(pids, 1, &pids_over_limit);
>   	if (err)
>   		pids_event(pids, pids_over_limit);
> @@ -290,14 +285,9 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
>   
>   static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
>   {
> -	struct cgroup_subsys_state *css;
>   	struct pids_cgroup *pids;
>   
> -	if (cset)
> -		css = cset->subsys[pids_cgrp_id];
> -	else
> -		css = task_css_check(current, pids_cgrp_id, true);
> -	pids = css_pids(css);
> +	pids = css_pids(cset->subsys[pids_cgrp_id]);
>   	pids_uncharge(pids, 1);
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>


