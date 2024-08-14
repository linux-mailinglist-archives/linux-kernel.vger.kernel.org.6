Return-Path: <linux-kernel+bounces-286055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF49515E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C3282D23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F713C918;
	Wed, 14 Aug 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gbJQ+onP"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54C1311AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622021; cv=none; b=sl5HXvqpuEx+fuEmW9GAOlIWoeSA+thPUV4Y0thKTROLhc3KndhaIq1zo+KY31MXFQEeRJc2upa3xZejKeU6jQ1lp6owSYW+8ZA/gz/Fqg43GfHEa65icov9KITzkFi7lXwBtQnfWhfK5fIH3C7qGGoOU84iObsNiVEiGToqii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622021; c=relaxed/simple;
	bh=foGPidSdaR07yh1t+KCC69o2/ZRBICNas+5tOgPFCQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDQ/UGCZ9R2mWjakjO3/Gkqkp44m/QrSKlv4Z3Al6aF8k+y7AMtDGKUmLiEZZyU5me24WhoyGvpANN0faLYKporRBXPP/MD9qBhKIoonK8reMqpb+bXEzhZ4R2/ukUHIU44d9xHEjXMfJsHXA4fiCO3YzrGrBhPJDuWu/uo713w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gbJQ+onP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723622016; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+VSuOls8jaaOLJrgF/Ih4DIM6pl/q+nzh+7j/SW0fpc=;
	b=gbJQ+onPTlZW2nAA1O0zk/MWkLaxi0C+/XK54Wjh2Kt1WtskBx0siA24++bVfU/oGSCNntS4ht4YtmdmJuavFq0pESOY9ZgmOiNvXUyPYkY9p+TgMEhSZ5ZhZcaHpEfhGESwEbUGorOemKQAmFLNeXA9SAgT4x1f0Y33f9ic8oA=
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCraQFC_1723622014)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 15:53:35 +0800
Message-ID: <c82a3834-f1c9-472f-9900-0d8885092943@linux.alibaba.com>
Date: Wed, 14 Aug 2024 15:53:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baohua@kernel.org, corbet@lwn.net, david@redhat.com, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com
References: <20240814020247.67297-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240814020247.67297-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/14 10:02, Barry Song wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Add thp_anon= cmdline parameter to allow specifying the default
> enablement of each supported anon THP size. The parameter accepts the
> following format and can be provided multiple times to configure each
> size:
> 
> thp_anon=<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>
> 
> An example:
> 
> thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> 
> See Documentation/admin-guide/mm/transhuge.rst for more details.
> 
> Configuring the defaults at boot time is useful to allow early user
> space to take advantage of mTHP before its been configured through
> sysfs.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Just a small nit as below.

> ---
>   -v4:
>   * use bitmap APIs to set and clear bits. thanks very much for
>     David's comment!
> 
>   .../admin-guide/kernel-parameters.txt         |  9 ++
>   Documentation/admin-guide/mm/transhuge.rst    | 37 +++++--
>   mm/huge_memory.c                              | 96 ++++++++++++++++++-
>   3 files changed, 134 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f0057bac20fb..d0d141d50638 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6629,6 +6629,15 @@
>   			<deci-seconds>: poll all this frequency
>   			0: no polling (default)
>   
> +	thp_anon=	[KNL]
> +			Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
> +			state is one of "always", "madvise", "never" or "inherit".
> +			Can be used to control the default behavior of the
> +			system with respect to anonymous transparent hugepages.
> +			Can be used multiple times for multiple anon THP sizes.
> +			See Documentation/admin-guide/mm/transhuge.rst for more
> +			details.
> +
>   	threadirqs	[KNL,EARLY]
>   			Force threading of all interrupt handlers except those
>   			marked explicitly IRQF_NO_THREAD.
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 7072469de8a8..528e1a19d63f 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -284,13 +284,36 @@ that THP is shared. Exceeding the number would block the collapse::
>   
>   A higher value may increase memory footprint for some workloads.
>   
> -Boot parameter
> -==============
> -
> -You can change the sysfs boot time defaults of Transparent Hugepage
> -Support by passing the parameter ``transparent_hugepage=always`` or
> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
> -to the kernel command line.
> +Boot parameters
> +===============
> +
> +You can change the sysfs boot time default for the top-level "enabled"
> +control by passing the parameter ``transparent_hugepage=always`` or
> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
> +kernel command line.
> +
> +Alternatively, each supported anonymous THP size can be controlled by
> +passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
> +where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
> +``madvise``, ``never`` or ``inherit``.
> +
> +For example, the following will set 16K, 32K, 64K THP to ``always``,
> +set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
> +to ``never``::
> +
> +	thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
> +
> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
> +not explicitly configured on the command line are implicitly set to
> +``never``.
> +
> +``transparent_hugepage`` setting only affects the global toggle. If
> +``thp_anon`` is not specified, PMD_ORDER THP will default to ``inherit``.
> +However, if a valid ``thp_anon`` setting is provided by the user, the
> +PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
> +is not defined within a valid ``thp_anon``, its policy will default to
> +``never``.
>   
>   Hugepages in tmpfs/shmem
>   ========================
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1a12c011e2df..c5f4e97b49de 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>   unsigned long huge_anon_orders_always __read_mostly;
>   unsigned long huge_anon_orders_madvise __read_mostly;
>   unsigned long huge_anon_orders_inherit __read_mostly;
> +static bool anon_orders_configured;
>   
>   unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   					 unsigned long vm_flags,
> @@ -737,7 +738,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>   	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>   	 * constant so we have to do this here.
>   	 */
> -	huge_anon_orders_inherit = BIT(PMD_ORDER);
> +	if (!anon_orders_configured) {
> +		huge_anon_orders_inherit = BIT(PMD_ORDER);
> +		anon_orders_configured = true;
> +	}
>   
>   	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>   	if (unlikely(!*hugepage_kobj)) {
> @@ -922,6 +926,96 @@ static int __init setup_transparent_hugepage(char *str)
>   }
>   __setup("transparent_hugepage=", setup_transparent_hugepage);
>   
> +static inline int get_order_from_str(const char *size_str)
> +{
> +	unsigned long size;
> +	char *endptr;
> +	int order;
> +
> +	size = memparse(size_str, &endptr);
> +	order = fls(size >> PAGE_SHIFT) - 1;

Nit: using get_order() seems more robust?

> +	if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> +		pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
> +			size_str, order);
> +		return -EINVAL;
> +	}
> +
> +	return order;
> +}
[snip]

