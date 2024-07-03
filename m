Return-Path: <linux-kernel+bounces-239998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7519267BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC12881E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361F18629B;
	Wed,  3 Jul 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuTIkZCK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAD567D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029981; cv=none; b=oW80fCeeWpwCTBlkigUEFgVLG2O9JkPzJo0PtEuZzoIIaUDoWOqxs5eEZQZm5HCBqQ1xhWPoSaXVRlDNJ6tYaqY5X96tgcMrIdzGmkvvlySDCplRFpdKBGIWm3Wkc8kSR/U1xX1c0Qjs4ZTy9P+m6Lv4qZwr8L3Lu9Rqqsg25iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029981; c=relaxed/simple;
	bh=+MbLfYtEWFSDBMzZZxNrmUZXhuZHRSrqO8dsReyBC5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdX4tpKGv3UlfRmfPyCS+GZE52QF7wBkY7dpkbQ4uJX3P/jEeZE5u7Jmtw+Ki2YWjjiNz9KsM74ACZbzflYdI5WtVYBfc+8s+G8tsIOO+etU+6xj58FI5IHh1+SOfrLQ9saegRQfBLPiQH9hQSgeIMXaMH/unQE3w759uQN/0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuTIkZCK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720029978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIEH1DQ5UkzdCEa2J+MChYeDbaqJXOVbALXQjkzbCEE=;
	b=HuTIkZCKyNtO73Q76ZKe+V6uzaQUUGu7+5Y/clG4YaVNCqHZ7Wl8znJ6mmaselw6ytmyJB
	sxhxFhIscWwXBFwm5dCDX68Ewsce4cYJhGlnPOx00VmXRLTcrRSn6AQxBtKlyL0zttS9z+
	FBwRpRzbC3cXtiRXCzYtlpST2r68aJ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-N_3O_f3IMGSL5DOyKqH24A-1; Wed,
 03 Jul 2024 14:06:15 -0400
X-MC-Unique: N_3O_f3IMGSL5DOyKqH24A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BD781954B0B;
	Wed,  3 Jul 2024 18:06:14 +0000 (UTC)
Received: from [10.22.33.252] (unknown [10.22.33.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43A8C30000DD;
	Wed,  3 Jul 2024 18:06:13 +0000 (UTC)
Message-ID: <c9c9ed1c-116d-4deb-b54e-6e464c342f23@redhat.com>
Date: Wed, 3 Jul 2024 14:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Always queue work items to the newest PWQ for
 order workqueues
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>
References: <20240703092741.22997-1-jiangshanlai@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240703092741.22997-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/3/24 05:27, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> To ensure non-reentrancy, __queue_work() attempts to enqueue a work
> item to the pool of the currently executing worker. This is not only
> unnecessary for an ordered workqueue, where order inherently suggests
> non-reentrancy, but it could also disrupt the sequence if the item is
> not enqueued on the newest PWQ.
>
> Just queue it to the newest PWQ and let order management guarantees
> non-reentrancy.
>
> Fixes: 4c065dbce1e8("workqueue: Enable unbound cpumask update on ordered workqueues")
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>   kernel/workqueue.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c910f3c28664..d4fecd23ea44 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2271,9 +2271,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>   	 * If @work was previously on a different pool, it might still be
>   	 * running there, in which case the work needs to be queued on that
>   	 * pool to guarantee non-reentrancy.
> +	 *
> +	 * For ordered workqueue, work items must be queued on the newest pwq
> +	 * for accurate order management.  Guaranteed order also guarantees
> +	 * non-reentrancy.  See the comments above unplug_oldest_pwq().
>   	 */
>   	last_pool = get_work_pool(work);
> -	if (last_pool && last_pool != pool) {
> +	if (last_pool && last_pool != pool && !(wq->flags & __WQ_ORDERED)) {
>   		struct worker *worker;
>   
>   		raw_spin_lock(&last_pool->lock);

Thanks for the fix again.

Acked-by: Waiman Long <longman@redhat.com>


