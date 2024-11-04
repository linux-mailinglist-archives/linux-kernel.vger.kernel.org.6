Return-Path: <linux-kernel+bounces-394127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D629BAAD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6269B1C209B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA554723;
	Mon,  4 Nov 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nF3ibdzt"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA323A0;
	Mon,  4 Nov 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687625; cv=none; b=EfzrjCkwFw5pEyrvCnJOMaxaVwpZIXj+3oo2Adk9+nHUI4D7tTpL6UEP87tUk29AmltX8KDUPn08PCaREQbgCRzT0Roi5/549+AcedxsYTga/19SCHcVa8kBoZ1JU/2QrkKplQPegVKjgCbLFyP2eBjv0N82Ie6v4Vba9TqaAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687625; c=relaxed/simple;
	bh=G/oRmBDJcCJLwa+QL1ScenWu4cHaDUeRUWfC5Lm+XI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL3jBG5KYwho2M5y2FcXgP143jWnEfDGlWtXEhp0oM9+r2o7mX5A4Wanlm417yJfF3BB93bWrhYUnNBNSJSfdpZkhyi3VXC1b4vfKdYe/8Kxd4YPlrP1SzTP4WdhM7kAssvCGxhpU0+kHx9hFIFgTVo4jE3lwBnXuMpnpik1g8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nF3ibdzt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730687614; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v1/peVX+FsyEZ3e/HuCFZ4YVCmzU5pF7SqzFiNM/ok0=;
	b=nF3ibdzt8SMIifbblHV5nAEq1IPJGB0e3080baIMIKgofLaEDiXfz9FvbU1GEVVgBOVqPqZBq+zPzpT7RPSPPDF4zo+kzpgHPpwHedzaGGBm0i41ddD4CPZa28CL94YXlobDBzH4e4hq3EYUNYnkt3RjVgXAXs51BHVQIUwz6To=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIZh3ES_1730687612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 10:33:33 +0800
Message-ID: <ea5546e6-1c80-45fd-b58e-6739a5a6f357@linux.alibaba.com>
Date: Mon, 4 Nov 2024 10:33:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20241101165719.1074234-2-mcanal@igalia.com>
 <20241101165719.1074234-6-mcanal@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241101165719.1074234-6-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/2 00:54, Maíra Canal wrote:
> Add the ``thp_shmem=`` kernel command line to allow specifying the
> default policy of each supported shmem hugepage size. The kernel parameter
> accepts the following format:
> 
> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
> 
> For example,
> 
> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
> 
> Some GPUs may benefit from using huge pages. Since DRM GEM uses shmem
> to allocate anonymous pageable memory, it’s essential to control the huge
> page allocation policy for the internal shmem mount. This control can be
> achieved through the ``transparent_hugepage_shmem=`` parameter.
> 
> Beyond just setting the allocation policy, it’s crucial to have granular
> control over the size of huge pages that can be allocated. The GPU may
> support only specific huge page sizes, and allocating pages larger/smaller
> than those sizes would be ineffective.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  10 ++
>   Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>   mm/shmem.c                                    | 105 +++++++++++++++++-
>   3 files changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index acabb04d0dd4..b48d744d99b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6700,6 +6700,16 @@
>   			Force threading of all interrupt handlers except those
>   			marked explicitly IRQF_NO_THREAD.
>   
> +	thp_shmem=	[KNL]
> +			Format: <size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
> +			Control the default policy of each hugepage size for the
> +			internal shmem mount. <policy> is one of policies available
> +			for the shmem mount ("always", "inherit", "never", "within_size",
> +			and "advise").
> +			It can be used multiple times for multiple shmem THP sizes.
> +			See Documentation/admin-guide/mm/transhuge.rst for more
> +			details.
> +
>   	topology=	[S390,EARLY]
>   			Format: {off | on}
>   			Specify if the kernel should make use of the cpu
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 9c6f6da612c4..5034915f4e8e 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by using the kernel parameter
>   seven valid policies for shmem (``always``, ``within_size``, ``advise``,
>   ``never``, ``deny``, and ``force``).
>   
> +In the same manner as ``thp_anon`` controls each supported anonymous THP
> +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
> +has the same format as ``thp_anon``, but also supports the policy
> +``within_size``.
> +
> +``thp_shmem=`` may be specified multiple times to configure all THP sizes
> +as required. If ``thp_shmem=`` is specified at least once, any shmem THP
> +sizes not explicitly configured on the command line are implicitly set to
> +``never``.
> +
> +``transparent_hugepage_shmem`` setting only affects the global toggle. If
> +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
> +``inherit``. However, if a valid ``thp_shmem`` setting is provided by the
> +user, the PMD_ORDER hugepage policy will be overridden. If the policy for
> +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
> +default to ``never``.
> +
>   Hugepages in tmpfs/shmem
>   ========================
>   
> diff --git a/mm/shmem.c b/mm/shmem.c
> index dfcc88ec6e34..d2bf98aece40 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __read_mostly;
>   static unsigned long huge_shmem_orders_madvise __read_mostly;
>   static unsigned long huge_shmem_orders_inherit __read_mostly;
>   static unsigned long huge_shmem_orders_within_size __read_mostly;
> +static bool shmem_orders_configured __initdata;
>   #endif
>   
>   #ifdef CONFIG_TMPFS
> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
>   	 * Default to setting PMD-sized THP to inherit the global setting and
>   	 * disable all other multi-size THPs.
>   	 */
> -	huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
> +	if (!shmem_orders_configured)
> +		huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>   #endif
>   	return;
>   
> @@ -5195,6 +5197,107 @@ static int __init setup_transparent_hugepage_shmem(char *str)
>   }
>   __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
>   
> +static char str_dup[PAGE_SIZE] __initdata;
> +static int __init setup_thp_shmem(char *str)
> +{
> +	char *token, *range, *policy, *subtoken;
> +	unsigned long always, inherit, madvise, within_size;
> +	char *start_size, *end_size;
> +	int start, end, nr;
> +	char *p;
> +
> +	if (!str || strlen(str) + 1 > PAGE_SIZE)
> +		goto err;
> +	strscpy(str_dup, str);
> +
> +	always = huge_shmem_orders_always;
> +	inherit = huge_shmem_orders_inherit;
> +	madvise = huge_shmem_orders_madvise;
> +	within_size = huge_shmem_orders_within_size;
> +	p = str_dup;
> +	while ((token = strsep(&p, ";")) != NULL) {
> +		range = strsep(&token, ":");
> +		policy = token;
> +
> +		if (!policy)
> +			goto err;
> +
> +		while ((subtoken = strsep(&range, ",")) != NULL) {
> +			if (strchr(subtoken, '-')) {
> +				start_size = strsep(&subtoken, "-");
> +				end_size = subtoken;
> +
> +				start = get_order_from_str(start_size,
> +							   THP_ORDERS_ALL_FILE_DEFAULT);
> +				end = get_order_from_str(end_size,
> +							 THP_ORDERS_ALL_FILE_DEFAULT);
> +			} else {
> +				start_size = end_size = subtoken;
> +				start = end = get_order_from_str(subtoken,
> +								 THP_ORDERS_ALL_FILE_DEFAULT);
> +			}
> +
> +			if (start == -EINVAL) {
> +				pr_err("invalid size %s in thp_shmem boot parameter\n",
> +				       start_size);
> +				goto err;
> +			}
> +
> +			if (end == -EINVAL) {
> +				pr_err("invalid size %s in thp_shmem boot parameter\n",
> +				       end_size);
> +				goto err;
> +			}

I have the same feeling that these are redundant checks. Otherwise look 
good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

