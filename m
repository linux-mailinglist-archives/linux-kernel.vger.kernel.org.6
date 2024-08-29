Return-Path: <linux-kernel+bounces-307832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33932965388
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEFF1C22938
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEE18EFD4;
	Thu, 29 Aug 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXrtE5sl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF6187843
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974752; cv=none; b=icgDweiLiKMX1KBX5qVJHaRcakSOApRw08bW9HHKlK+JZpXAZiYBQzI/n+4Q6wlWjjqEbVVfQeEwJGCHuavQeCtENcfGcErR6zx/XtRk1BSfyUHXzpFF0seMU9mpgnVGLhMBOvKH87e531WNhcpu0kQMpe8sKL0eQRXK7owKw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974752; c=relaxed/simple;
	bh=qIGudN197udaEzSbHat6mP5MvNd2krek/aPMD3IFuqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsQ1q+xdAaHPVxu38EN7xMVJOYUeNkuVIYvUvdTRupEmkfPXmC4HRPBvfs4tKLmypJxX5ZZKIWrVczAIR9YnakYd3UdPshg87Qfjd9FNuwr2E16VaJC2SGsZUL8g7kPemi9IWpszJ5xZ3dJmOM9mgNuBlAO0VyWp0L0l06ptCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXrtE5sl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724974749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUhLKrM3AgJQLzPb7rc4PbVNqaVvI00+ASUmxqGhgYY=;
	b=AXrtE5slPF/sXR2FIRW4FiSHzA3hbWNOoyjdFzUo90fhL3Sxhgp8T2/btKuMJHte8NLybc
	9Rh4R6v5jHZfwCJlVX2Za7eOeCH3Z1s+9TIePfNPBEffOdRvXpaUbArfOcp91rZ6lEmTuG
	wUBvAjRLYZcMwo0euqK91s+SP3fT8O4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-cgrT47EbOtuIbCb5Eotv5w-1; Thu,
 29 Aug 2024 19:39:06 -0400
X-MC-Unique: cgrT47EbOtuIbCb5Eotv5w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16B561955D5A;
	Thu, 29 Aug 2024 23:39:04 +0000 (UTC)
Received: from [10.2.16.9] (unknown [10.2.16.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6CC219560A3;
	Thu, 29 Aug 2024 23:39:00 +0000 (UTC)
Message-ID: <ac341b58-9447-4759-a231-0d23efe7af72@redhat.com>
Date: Thu, 29 Aug 2024 19:39:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240829220427.2764399-1-joshdon@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240829220427.2764399-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/29/24 18:04, Josh Don wrote:
> Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
> a WARN when a per-task affinity assignment races with a cpuset update.
>
> Specifically, we can have a race where a cpuset update results in the
> task affinity no longer being a subset of the cpuset. That's fine; we
> have a fallback to instead use the cpuset mask. However, we have a WARN
> set up that will trigger if the cpuset mask has no overlap at all with
> the requested task affinity. This shouldn't be a warning condition; its
> trivial to create this condition.
>
> Reproduced the warning by the following setup:
>
> - $PID inside a cpuset cgroup
> - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
> - another thread repeatedly setting the $PID affinity (via taskset) to 2
>
> Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>   kernel/sched/syscalls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4fae3cf25a3a..3a88f7c0cb69 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1321,7 +1321,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
>   			bool empty = !cpumask_and(new_mask, new_mask,
>   						  ctx->user_mask);
>   
> -			if (WARN_ON_ONCE(empty))
> +			if (empty)
>   				cpumask_copy(new_mask, cpus_allowed);
>   		}
>   		__set_cpus_allowed_ptr(p, ctx);

Taking out the WARN_ON_ONCE() should be fine.

Acked-by: Waiman Long <longman@redhat.com>



