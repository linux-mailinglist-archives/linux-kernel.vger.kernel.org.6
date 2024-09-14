Return-Path: <linux-kernel+bounces-329537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0529792A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F3A1C21169
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CE1D130B;
	Sat, 14 Sep 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDiQxUVy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B441CFEC5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334533; cv=none; b=QcPw/FG72zO5hvWuy5hMiRWyHY722SgeISENfgXtgmhJC8PvhpQRCmtEP/mWcAuxF1mfkmRpX+4yUwDF7gaScQpGwCSZNd3JeOaz7KPvjfGvZeMiaCSi204YTC4PUKHVVBXBN07yprpFOepv63Mu/9k7lbA1baENEbvb5J3yDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334533; c=relaxed/simple;
	bh=xQFX4Q0Ux4wuliWmkNy0+0kNrGocQMF3qwDpU/ASMx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvcdLWYyXX8dFi1m1KbxYV3UAOXMusqjVkZ/x8Oo7ZO2oef/99VE2Li8SAX7PZpwls5UOVoVNW1yjiGmhAyL0F9gArEkeXf3TEW06FI9xx/Pkqbu5DpVoWv7JvFO5Ug274pv9O7zjVBbYNhxj1bgiTsd3AAev6KPoL/AJdGQaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDiQxUVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726334529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7EzSgsDr9r9jIruy2sWZCrY67MSTMTwLiKAaXeqnvA=;
	b=cDiQxUVyzCTa6kXc4uWo9vpSq52iyWDoEKKZOwmrW3/NcGu4hJYil24Wd1ujIwlaJDh9dU
	KxI5y1J+nr1QIOKnbNUdkNKY+0tzsFq5/k5aPVkmE4IvRMFg85LIG7zbKtXxGb6IqTCc6t
	xauxaSDOhBjsaY1sOJZbK14zl5TPGxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-x083uZMQOLWEIrsA5KYNaw-1; Sat,
 14 Sep 2024 13:22:04 -0400
X-MC-Unique: x083uZMQOLWEIrsA5KYNaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16C4E195608B;
	Sat, 14 Sep 2024 17:22:02 +0000 (UTC)
Received: from [10.2.16.15] (unknown [10.2.16.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 919F31955D44;
	Sat, 14 Sep 2024 17:21:59 +0000 (UTC)
Message-ID: <5045fb8b-4968-4b5a-9d9e-1def94308426@redhat.com>
Date: Sat, 14 Sep 2024 13:21:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare,
 assign and cleanup.
To: yongli-oc <yongli-oc@zhaoxin.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-5-yongli-oc@zhaoxin.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240914085327.32912-5-yongli-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 9/14/24 04:53, yongli-oc wrote:
> The numa-aware lock kernel memory cache preparation, and a
> workqueue to turn numa-aware lock back to osq lock.
> The /proc interface. Enable dynamic switch by
> echo 1 > /proc/zx_numa_lock/dynamic_enable
>
> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
> ---
>   kernel/locking/zx_numa.c | 537 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 537 insertions(+)
>   create mode 100644 kernel/locking/zx_numa.c
>
> diff --git a/kernel/locking/zx_numa.c b/kernel/locking/zx_numa.c
> new file mode 100644
> index 000000000000..89df6670a024
> --- /dev/null
> +++ b/kernel/locking/zx_numa.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Dynamic numa-aware osq lock
> + * Crossing from numa-aware lock to osq_lock
> + * Numa lock memory initialize and /proc interface
> + * Author: LiYong <yongli-oc@zhaoxin.com>
> + *
> + */
> +#include <linux/cpumask.h>
> +#include <asm/byteorder.h>
> +#include <asm/kvm_para.h>
> +#include <linux/percpu.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/osq_lock.h>
> +#include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +#include <linux/reboot.h>
> +
> +#include "numa.h"
> +#include "numa_osq.h"
> +
> +int enable_zx_numa_osq_lock;
> +struct delayed_work zx_numa_start_work;
> +struct delayed_work zx_numa_cleanup_work;
> +
> +atomic_t numa_count;
> +struct _numa_buf *zx_numa_entry;
> +int zx_numa_lock_total = 256;
> +LIST_HEAD(_zx_numa_head);
> +LIST_HEAD(_zx_numa_lock_head);
> +
> +struct kmem_cache *zx_numa_entry_cachep;
> +struct kmem_cache *zx_numa_lock_cachep;
> +int NUMASHIFT;
> +int NUMACLUSTERS;
> +static atomic_t lockindex;
> +int dynamic_enable;
> +
> +static const struct numa_cpu_info numa_cpu_list[] = {
> +	/*feature1=1, a numa node includes two clusters*/
> +	//{1, 23, X86_VENDOR_AMD, 0, 1},
> +	{0x5b, 7, X86_VENDOR_CENTAUR, 0, 1},
> +	{0x5b, 7, X86_VENDOR_ZHAOXIN, 0, 1}
> +};

Why are this zx_*() code specifically for ZhaoXin and Centaur family of 
CPUs? Are there some special hardware features that are specific to 
these CPUs?

BTW, your patch series lacks performance data to justify the addition of 
quite a lot of complexity to the core locking code. We are unlikely to 
take this without sufficient justification.

Another question that I have is that the base osq_lock() can coexist 
with your xz_osq_lock(). A cpu can dynamically switch from using 
osq_lock() to xz_osq_lock() and vice versa. What happens if some CPUs 
use osq_lock() while others use xz_osq_lock()? Will that cause a 
problem? Have you fully test this scenario to make sure that nothing 
breaks?

Cheers,
Longman


