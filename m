Return-Path: <linux-kernel+bounces-308955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F333996643F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B97EB22A28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319D1B2514;
	Fri, 30 Aug 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggI5pjSv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811A1B2EE3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028410; cv=none; b=P4B13FlKJ94dTdIiRgJdbk2chVzctz/v5FD3MFFKI8FFLm9NKStXOgX5Uu7U0fwPPvw/Cf5H+Gb/1sKAv3skhHwhTTHWpMJcfV6kLOPPVd9AWXLGtOP/rtJNNhn5xmmdWGK/vZDs/3CD7WPVyFQiI7aSiLbuS/4X7sl5Eft2xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028410; c=relaxed/simple;
	bh=Z9TvoLYNagTODd4i2+BAcS6gF/9LpxgSMPXmSsaH77I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLdxMnqOMWbzoN2VKPQBI5ENLtzNuqTbdhhxh1NZ+IsCjvMbw6g+lKux9gD94BbwQXZ/WtVOR+sEQqcT7cy3v/zCWa3XNvnRK4u+D/qgPLkzrf1cRRGkrEMMTvXOYghM3ae0mwQEJEESojHPaW0TLw7AnrD3mHsMuaV074BO9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggI5pjSv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725028407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbKYhWJQmd4aTvmQBdXsKTdxEaSRx7bVj4GRaT9+/4A=;
	b=ggI5pjSvkDs4CiI+tE1ZNq+Z0xdNCUXJpqeDqWfHA/rFJjGVNJaxO+uk/xtkriYf1ECz+D
	dOcDhemi/kNPQrUxfVjupG4+4dy4U+Z4FhVIm093VDch3Eexl3ynarCjcBLgB97+h7wQx4
	gMIvI+icF3gFzVlJxJR+eR6NHNOAvzI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-pk9AKLqGMMadO2TdSjOeiA-1; Fri,
 30 Aug 2024 10:33:21 -0400
X-MC-Unique: pk9AKLqGMMadO2TdSjOeiA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72046197767C;
	Fri, 30 Aug 2024 14:33:16 +0000 (UTC)
Received: from [10.2.16.212] (unknown [10.2.16.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAFAC1955F6B;
	Fri, 30 Aug 2024 14:33:13 +0000 (UTC)
Message-ID: <65c89464-88bf-418e-bfe1-2d3c0822dbd5@redhat.com>
Date: Fri, 30 Aug 2024 10:33:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 -next 00/12] cgroup:cpuset:separate legacy cgroup v1
 code and put under config option
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenridong@huaweicloud.com
References: <20240830100229.953012-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/30/24 06:02, Chen Ridong wrote:
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
> ---
> V4:
> - Rename legacy_files to cpuset1_files.
> - Revert rebuild_sched_domain and fmeter_init rename.
>
> V3:
> - Delete blank line at the end of file.
> - Rename some generic functions name with cpuset_/cpuset1_ prefix.
>
> V2:
> - Update to base on the latest cgroup/for-6.12.
> - Add CONFIG_CPUSETS_V1 for cpuset_memory_pressure_bump.
>
> Chen Ridong (12):
>    cgroup/cpuset: introduce cpuset-v1.c
>    cgroup/cpuset: move common code to cpuset-internal.h
>    cgroup/cpuset: move memory_pressure to cpuset-v1.c
>    cgroup/cpuset: move relax_domain_level to cpuset-v1.c
>    cgroup/cpuset: move memory_spread to cpuset-v1.c
>    cgroup/cpuset: add callback_lock helper
>    cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
>    cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
>    cgroup/cpuset: move v1 interfaces to cpuset-v1.c
>    cgroup/cpuset: rename functions shared between v1 and v2
>    cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
>    cgroup/cpuset: add sefltest for cpuset v1
>
>   MAINTAINERS                                   |   3 +
>   include/linux/cpuset.h                        |   4 +
>   init/Kconfig                                  |  13 +
>   kernel/cgroup/Makefile                        |   1 +
>   kernel/cgroup/cpuset-internal.h               | 304 ++++++
>   kernel/cgroup/cpuset-v1.c                     | 562 +++++++++++
>   kernel/cgroup/cpuset.c                        | 892 +-----------------
>   .../selftests/cgroup/test_cpuset_v1_base.sh   |  77 ++
>   8 files changed, 1005 insertions(+), 851 deletions(-)
>   create mode 100644 kernel/cgroup/cpuset-internal.h
>   create mode 100644 kernel/cgroup/cpuset-v1.c
>   create mode 100755 tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
>
For the series,

Acked-by: Waiman Long <longman@redhat.com>


