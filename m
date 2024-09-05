Return-Path: <linux-kernel+bounces-317095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D696D923
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07CC1F2BA02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05319D084;
	Thu,  5 Sep 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMn9uM0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2519D07F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540166; cv=none; b=n+Tuy8rsPqHdPyuEuHynDW7T61cJpJnSE9MZ0DqiUhdI0XPuVIrxPS+4gUZc0G32galOju/0vGLQbG/LLJYUtteL9p2jttddWHW4MvN5Xi4c8jHvmVpiaYPrmZW/izXCaJjINAlLyNTdxHh0B7Vqv/qPLc+fO97E31OFNCe3qeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540166; c=relaxed/simple;
	bh=2eVd9ovXzBAuAw2MuqoGdP8bS4RExH8qUH3TW2uw5Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAFR9qBx0scCrrT8hvYzsbn7ALO3TehUFz0jJmoYXCvs/MpCJ4DI+dm6cUoweg+zbzrhc5hb2hMdgrV5cTh2Z3JTrtI+ka2mFLFOivymGrtjv1J5TiYJ0yKufAsc3XDBw3rbtNqNSToJbVRAtKvhbrWajyMMHdtPOxG4qZLty+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMn9uM0j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725540163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tECcz7e0PZh0vVfImS/s6U6CWZOaYBfSv1YMpOXyntg=;
	b=EMn9uM0j2eVtuHaEF/rnDQChtZJoP1tWzzcvWijf4hIY2PAHMjOc0A1FoqQJPHgysgQECV
	zY3IKpAKU/ybEiV8Dl/METinhC9l+mw9atdkXC3wfzztLJVDGwA9XsPNEPmxtHG3Sbgjwl
	Aox3TB6s26xv2DrAx2cvpPJdJsY1kVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-gGyrXoxAPASE6ukqBPXE4g-1; Thu,
 05 Sep 2024 08:42:40 -0400
X-MC-Unique: gGyrXoxAPASE6ukqBPXE4g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E61C71955F0D;
	Thu,  5 Sep 2024 12:42:37 +0000 (UTC)
Received: from [10.2.16.62] (unknown [10.2.16.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CF5F1955D45;
	Thu,  5 Sep 2024 12:42:34 +0000 (UTC)
Message-ID: <a645086d-bffb-41b0-bd70-1ef5edb128f9@redhat.com>
Date: Thu, 5 Sep 2024 08:42:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: Do not copy user_cpus_ptr when parent is
 reset_on_fork
To: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
References: <20240905090458.1173-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240905090458.1173-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/5/24 05:04, Xuewen Yan wrote:
> Now, the task's user_cpus_ptr would dup from parent's user_cpus_ptr.
> It is better reset the user_cpus_ptr when parent's reset_on_fork
> is set.

According to sched(7):

        Each thread has a reset-on-fork scheduling flag.  When this flag
        is set, children created by fork(2) do not inherit privileged
        scheduling policies.

It can be argued what are considered privileged scheduling policies. 
AFAICS, a restricted affinity doesn't seem to be a "privileged" 
scheduling policy. That is my own opinion strictly from the definition 
point of view, I will let others weigh in on that and I am OK to go 
either way.

Cheers,
Longman

>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f3951e4a55e5..2fbae00cd1dc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2666,7 +2666,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>   	 * do_set_cpus_allowed().
>   	 */
>   	raw_spin_lock_irqsave(&src->pi_lock, flags);
> -	if (src->user_cpus_ptr) {
> +	if (src->user_cpus_ptr && !src->sched_reset_on_fork) {
>   		swap(dst->user_cpus_ptr, user_mask);
>   		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
>   	}


