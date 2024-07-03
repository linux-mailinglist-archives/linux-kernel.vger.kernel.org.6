Return-Path: <linux-kernel+bounces-239733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C739D9264A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731371F2353D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55017FAD4;
	Wed,  3 Jul 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjIsL6+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231F17DA25
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019691; cv=none; b=sXirdzHB9jERhqNEsvhMH5xJqmltqiM5uH1SytkPy9PC3wkCc1v22WPv8JDDDY3NW2Pdsvg4OyUwvovPBLozQla5pSGtDtmDLSXGqdn2L+H7ODSBXf/TDdOKdPOUD1a678Lvb5VFnxaTDy2ygoJ+VFwvor8+s+Q7kfK0Dc42d8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019691; c=relaxed/simple;
	bh=DVZoCgGNL/3QvR3GgyZlBB7wKE/Cuoc7qP2icJB8648=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otC9iYRniAvjb5fHZNGGN1dBhasJ9/NO+hTqwv5p2tJhz2BHw99yl4J8yBfyCDY4VVCDKDXb6RJvUcmMizBVC863BbSDAsI4glQhgkZ7H1tTeALIVhwo5XMq1Cp+kixkdzX0Kx6QvthfRXIcPZXp5XDad0ld9jDQYq2LT/WKXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjIsL6+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWUo3H7qkDAztkmmaCmdE2MO9pLRxkJhZ2WC3lZ6+9M=;
	b=fjIsL6+4+M5EzoZD0CnYuDac20lgl6w+iuqvg7e7W7QHL24gv3c/raL1/yJcK6MQSGeJ9h
	avk8O/d+VxhgoFzJ4WUDjpnYtfpyip7MdaHOVodmLne52F5nVR04aqLNpxlNFU+WRg6lon
	O9hrz6uKQzaP53FZruoT2Rqc35NjfiA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-OJYKiDLNPneTrgKnO966pw-1; Wed,
 03 Jul 2024 11:14:47 -0400
X-MC-Unique: OJYKiDLNPneTrgKnO966pw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B832619560A2;
	Wed,  3 Jul 2024 15:14:46 +0000 (UTC)
Received: from [10.22.33.252] (unknown [10.22.33.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8743C1955F21;
	Wed,  3 Jul 2024 15:14:45 +0000 (UTC)
Message-ID: <7b105f07-5c13-4f69-9834-05e7054ddb36@redhat.com>
Date: Wed, 3 Jul 2024 11:14:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] workqueue: Protect wq_unbound_cpumask with
 wq_pool_attach_mutex in init_rescuer()
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
 <20240703033855.3373-3-jiangshanlai@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240703033855.3373-3-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 7/2/24 23:38, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> wq_unbound_cpumask can be possibly changed without wq_pool_attach_mutex
> or wq_pool_mutex held in init_rescuer().
>
> Use wq_pool_attach_mutex to protect it.
>
> Fixes: 49584bb8ddbe("workqueue: Bind unbound workqueue rescuer to wq_unbound_cpumask")
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>   kernel/workqueue.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c738b3024cc2..cf1a129eb547 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5533,6 +5533,9 @@ static int init_rescuer(struct workqueue_struct *wq)
>   		return ret;
>   	}
>   
> +	/* lock wq_pool_attach_mutex for wq_unbound_cpumask */
> +	mutex_lock(&wq_pool_attach_mutex);
> +
>   	wq->rescuer = rescuer;
>   	if (wq->flags & WQ_UNBOUND)
>   		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
> @@ -5540,6 +5543,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>   		kthread_bind_mask(rescuer->task, cpu_possible_mask);
>   	wake_up_process(rescuer->task);
>   
> +	mutex_unlock(&wq_pool_attach_mutex);
> +
>   	return 0;
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>

Thanks!


