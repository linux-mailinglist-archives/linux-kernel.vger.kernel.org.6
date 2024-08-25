Return-Path: <linux-kernel+bounces-300502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624BA95E48B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2245281D13
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DC156F45;
	Sun, 25 Aug 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmC8ymrm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665DBE6F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724606415; cv=none; b=S79meDLk3mvU4dFwMerD18fK00jPC6LfYiEudc042tN+QQ3haKWvnDCHl7Ny0HZZAikqSOU46krBBvMCr18xMLvm4dUztjHWu34Q4sFIz6ba5d3N8wL8QGt1EN5xhH5eV3lqsJwAmgvQXEK2pfctOM02fv8wPA6+5dzG0f8nGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724606415; c=relaxed/simple;
	bh=wuvssAx6MDLd3teV3hPwZ7uDUyx5SPWcERWULd7S4hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au0qJM82e7R5OXwOo/zbjbuCRgwFiGs9R5jdQGJTbrGhAATwnzUKSEvxQZBsH/Y5QM05nRz6+qE0pbPzcany99QXmO5mJeYvIbghCXwR1AZJ6l22okQ6QA4htJdvO7yt8t+wR2A6JNn6+rDqpbHAwPJbNq3YD5/Sh7TqI0Cd3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmC8ymrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724606412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/vx9NN4+/0ZRrbAHyYZB8VafOyiYAISAr34QxOsgT0=;
	b=CmC8ymrm3TUjqr+SBBnYpvCvpK8lDkkncTjbn18BN3NG+LFnmpFPcJaX063v4DEIH+iEaN
	/4I2FULISUj0bxhfauLsT0zZ0zZGvz2F3wljHKL48p79IvJuLOsTIB0Us5fJLFjqErT7Zs
	exiL+4t6Rdnpb/z0r/1Dia+p67qE7FI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-2RfeNPtUMZ2hLVH8d1bpcw-1; Sun,
 25 Aug 2024 13:20:11 -0400
X-MC-Unique: 2RfeNPtUMZ2hLVH8d1bpcw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A33C19560B4;
	Sun, 25 Aug 2024 17:20:09 +0000 (UTC)
Received: from [10.2.16.7] (unknown [10.2.16.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EEE8300019C;
	Sun, 25 Aug 2024 17:20:07 +0000 (UTC)
Message-ID: <6dde95a0-2cad-4ca8-9ea3-2b4c6e70db93@redhat.com>
Date: Sun, 25 Aug 2024 13:20:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 00/11] cgroup:cpuset:separate legacy cgroup v1
 code and put under config option
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823100110.472120-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240823100110.472120-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/23/24 06:00, Chen Ridong wrote:
> Cgroups v2 have been around for a while and many users have fully adopted
> them, so they never use cgroups v1 features and functionality. Yet they
> have to "pay" for the cgroup v1 support anyway:
> 1) the kernel binary contains an unused cgroup v1 code,
> 2) some code paths have additional checks which are not needed,
> 3) some common structures like task_struct and mem_cgroup contain unused
>     cgroup v1-specific members.
>
> Cgroup memory controller has already separated legacy code to
> memory-v1.c. So it is time to do the same thing for cpuset controller.
>
> This patchset aims to do:
> 1) moving cgroup v1-specific cpuset code to the new cpuset-v1.c file,
> 2) putting definitions shared by cpuset.c and cpuset-v1.c into the
>     cpuset-internal.h header,
> 3) introducing the CONFIG_CPUSETS_V1 config option, turned off by default,
> 4) making cpuset-v1.c to compile only if CONFIG_CPUSETS_V1 is set.
>
> This patchset is based on -next commit c79c85875f1a ("Add linux-next
> specific files for 20240823") and assumes that "Some optimizations about
> cpuset" series are merged, which are applied to cgroup/for-6.12.
>
>
> Chen Ridong (11):
>    cgroup/cpuset: introduce cpuset-v1.c
>    cgroup/cpuset: move common code to cpuset-internal.h
>    cgroup/cpuset: move memory_pressure to cpuset-v1.c
>    cgroup/cpuset: move relax_domain_level to cpuset-v1.c
>    cgroup/cpuset: move memory_spread to cpuset-v1.c
>    cgroup/cpuset: add callback_lock helper
>    cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
>    cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
>    cgroup/cpuset: move v1 interfaces to cpuset-v1.c
>    cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
>    cgroup/cpuset: add sefltest for cpuset v1
>
>   MAINTAINERS                                   |   3 +
>   include/linux/cpuset.h                        |   8 +-
>   init/Kconfig                                  |  13 +
>   kernel/cgroup/Makefile                        |   1 +
>   kernel/cgroup/cpuset-internal.h               | 307 +++++++
>   kernel/cgroup/cpuset-v1.c                     | 565 ++++++++++++
>   kernel/cgroup/cpuset.c                        | 850 +-----------------
>   .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
>   8 files changed, 987 insertions(+), 837 deletions(-)
>   create mode 100644 kernel/cgroup/cpuset-internal.h
>   create mode 100644 kernel/cgroup/cpuset-v1.c
>   create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
>
Patch 2 doesn't apply to the latest cgroup/for-6.12 branch of the cgroup 
tree. You will have to update the patch series.

Cheers,
Longman


