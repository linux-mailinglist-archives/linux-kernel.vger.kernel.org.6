Return-Path: <linux-kernel+bounces-302066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008095F96A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ED51C220C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14D1991AE;
	Mon, 26 Aug 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7ByxdB7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC241991B8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699248; cv=none; b=myIV4o3NgmmEG/PlWJ001UZA0KXdbgbhcnISu7Y9rDY3y85jv2LGvZ/k3JiYalVczK1LiQIJosQgWMS7NkswUe9kq17OlZJ7RYIAq8OcqfuRNn+owxBGMmfkSS0LdMujlx64WqrPKIDu0qdB4FTnq4a2FMIqV6DcF/+W61RCv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699248; c=relaxed/simple;
	bh=YC8ERyq9Y/ai9/rTul4XSlGavYtAoT1W+MUA0PzPEeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSdM9QVaO6Kpn46V/pb8rGXQtEzuY4DVvU8r6fPkJYLTmwx7QYwJL9/ygq/axugV+3qLcdH6yuzOWf2ynR9WlBlhKClGB37KI5KMFOYNJBbm3B85bKI6M8+eFk97af167Zl8xwgkPvF+RiXdnn0azpRkFm4LgTJcIresLuJ88s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7ByxdB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724699244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WZgpdIiQKl/zQSuIkU/SYa9/FTQk49azxNSwK0okPA=;
	b=O7ByxdB7gV/gHfvokSMgr/DGPLcZcm0FHqmpKXo6RhrjloX6j3sA/1FyqRwZeFuNFsLEZY
	202y07JZYmauZ1OqYUxVhdFbaA7oOSOenYe8F6rb8oyteJcbhMUxCM9lg9CdWOQBR3hw7J
	IGI7WPNiwIP+/eGLWMXbnad59LPch6Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-ekZUPRfnPBCT3Miy1GTRaw-1; Mon,
 26 Aug 2024 15:07:20 -0400
X-MC-Unique: ekZUPRfnPBCT3Miy1GTRaw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEE8B1954B08;
	Mon, 26 Aug 2024 19:07:18 +0000 (UTC)
Received: from [10.2.16.157] (unknown [10.2.16.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 900DD300019C;
	Mon, 26 Aug 2024 19:07:16 +0000 (UTC)
Message-ID: <53f17d71-c710-4720-ada7-8b81afc0c5e1@redhat.com>
Date: Mon, 26 Aug 2024 15:07:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 01/11] cgroup/cpuset: introduce cpuset-v1.c
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenridong@huaweicloud.com
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-2-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240826132703.558956-2-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/26/24 09:26, Chen Ridong wrote:
> This patch introduces the cgroup/cpuset-v1.c source file which will be
> used for all legacy (cgroup v1) cpuset cgroup code. It also introduces
> cgroup/cpuset-internal.h to keep declarations shared between
> cgroup/cpuset.c and cpuset/cpuset-v1.c.
>
> As of now, let's compile it if CONFIG_CPUSET is set. Later on it can be
> switched to use a separate config option, so that the legacy code won't be
> compiled if not required.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   MAINTAINERS                     | 2 ++
>   kernel/cgroup/Makefile          | 2 +-
>   kernel/cgroup/cpuset-internal.h | 7 +++++++
>   kernel/cgroup/cpuset-v1.c       | 4 ++++
>   4 files changed, 14 insertions(+), 1 deletion(-)
>   create mode 100644 kernel/cgroup/cpuset-internal.h
>   create mode 100644 kernel/cgroup/cpuset-v1.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82e3924816d2..3b5ec1cafd95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5698,6 +5698,8 @@ S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
>   F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
>   F:	include/linux/cpuset.h
> +F:	kernel/cgroup/cpuset-internal.h
> +F:	kernel/cgroup/cpuset-v1.c
>   F:	kernel/cgroup/cpuset.c
>   F:	tools/testing/selftests/cgroup/test_cpuset.c
>   F:	tools/testing/selftests/cgroup/test_cpuset_prs.sh
> diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
> index 12f8457ad1f9..005ac4c675cb 100644
> --- a/kernel/cgroup/Makefile
> +++ b/kernel/cgroup/Makefile
> @@ -4,6 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
>   obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
>   obj-$(CONFIG_CGROUP_PIDS) += pids.o
>   obj-$(CONFIG_CGROUP_RDMA) += rdma.o
> -obj-$(CONFIG_CPUSETS) += cpuset.o
> +obj-$(CONFIG_CPUSETS) += cpuset.o cpuset-v1.o
>   obj-$(CONFIG_CGROUP_MISC) += misc.o
>   obj-$(CONFIG_CGROUP_DEBUG) += debug.o
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> new file mode 100644
> index 000000000000..6605be417e32
> --- /dev/null
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __CPUSET_INTERNAL_H
> +#define __CPUSET_INTERNAL_H
> +
> +#endif /* __CPUSET_INTERNAL_H */
> +
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> new file mode 100644
> index 000000000000..ae166eb4f75d
> --- /dev/null
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "cpuset-internal.h"
> +

Don't leave a blank line at the end of a file. You will get the 
following error when applying the patch.

0001-cgroup_cpuset-introduce-cpuset-v1.c.patch:70: new blank line at EOF.

All your patches except the last one have this problem.

Cheers,
Longman


