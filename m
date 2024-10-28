Return-Path: <linux-kernel+bounces-384042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A129B238B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624B3B215FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82913C8E2;
	Mon, 28 Oct 2024 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aXBFcDIT"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11B161;
	Mon, 28 Oct 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086309; cv=none; b=Dc1Hzco68UDY5o1IE4x7l7cGmU9F+eiBVUlIkttlzAsNsVsYDJckNix5/fh4Ojt8drYzE8wED1uycnuVgYXgB8q/Etd9WCYyW+CMlKo+vlE8MxR00XGN99dKMFkxZ8y7w3AknHdxKlNYxwjKOrHrUHCvshdUuimeaCsezBk5YA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086309; c=relaxed/simple;
	bh=NRWHADk2xF6wE2yubfrgxewc1P2MuzHDQtcz/tRheTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTux4TcTypgS6zP3vftPzYuopNmJbUhrKjgFfr66tRncwGW2apZ538JX6zOwVExXrkWU5jP8U2hKvTENbcKRsi6Oj9Dm1vgJJRFXiLEuyxVTqpQwqXToxBH47MuOf8DjV1SqD66FVSXZrwj3JJsXk35c1q7p7zR83g+YEfOnZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aXBFcDIT; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730086297; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n0Bx+2LFE8K+t9JD5+qdAGeY9p/tHz0yLBLver5D33k=;
	b=aXBFcDITstC6TTNwzIAA4XOTQOKb5ASnFVph/R8YzTE5bZPliZN503L13DR7Vv6aeWp4GsgwMNrN6OCt9Stjrsbz/Z1qpQo5R9zBe3B3jyfaUSH52opdjKsMrDlTE7I05PdAbgW9UdyaEgvSUDBCx2J3+2waVAmZXtL2xrFdinI=
Received: from 30.74.144.158(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHzFjvQ_1730086294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 11:31:35 +0800
Message-ID: <0d33f2c1-5433-486a-8faa-b85265ecc855@linux.alibaba.com>
Date: Mon, 28 Oct 2024 11:31:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: shmem: control THP support through the kernel
 command line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241027175743.1056710-1-mcanal@igalia.com>
 <20241027175743.1056710-3-mcanal@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241027175743.1056710-3-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/28 01:36, Maíra Canal wrote:
> Add a new kernel command line to control the hugepage allocation policy
> for the internal shmem mount, ``transparent_hugepage_shmem``. The
> parameter is similar to ``transparent_hugepage`` and has the following
> format:
> 
> transparent_hugepage_shmem=<policy>
> 
> where ``<policy>`` is one of the seven valid policies available for
> shmem.
> 
> By configuring the default hugepage allocation policy for the internal
> shmem mount, applications that use shmem, such as the DRM GEM objects,
> can take advantage of mTHP before it's been configured through sysfs.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  7 ++++
>   Documentation/admin-guide/mm/transhuge.rst    |  6 +++
>   mm/shmem.c                                    | 38 ++++++++++++++++++-
>   3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1666576acc0e..acabb04d0dd4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6926,6 +6926,13 @@
>   			See Documentation/admin-guide/mm/transhuge.rst
>   			for more details.
>   
> +	transparent_hugepage_shmem= [KNL]
> +			Format: [always|within_size|advise|never|deny|force]
> +			Can be used to control the hugepage allocation policy for
> +			the internal shmem mount.
> +			See Documentation/admin-guide/mm/transhuge.rst
> +			for more details.
> +
>   	trusted.source=	[KEYS]
>   			Format: <string>
>   			This parameter identifies the trust source as a backend
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 745055c3dc09..9b5b02c4d1ab 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -326,6 +326,12 @@ PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
>   is not defined within a valid ``thp_anon``, its policy will default to
>   ``never``.
>   
> +Similarly to ``transparent_hugepage``, you can control the hugepage
> +allocation policy for the internal shmem mount by using the kernel parameter
> +``transparent_hugepage_shmem=<policy>``, where ``<policy>`` is one of the
> +seven valid policies for shmem (``always``, ``within_size``, ``advise``,
> +``never``, ``deny``, and ``force``).
> +
>   Hugepages in tmpfs/shmem
>   ========================
>   
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 44282a296c33..24cdeafd8260 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -582,7 +582,6 @@ static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>   	}
>   }
>   
> -#if defined(CONFIG_SYSFS)
>   static int shmem_parse_huge(const char *str)
>   {
>   	if (!strcmp(str, "never"))
> @@ -599,7 +598,6 @@ static int shmem_parse_huge(const char *str)
>   		return SHMEM_HUGE_FORCE;
>   	return -EINVAL;
>   }
> -#endif
>   
>   #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
>   static const char *shmem_format_huge(int huge)
> @@ -5174,6 +5172,42 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
>   	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_enabled_store);
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
>   
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +
> +static int __init setup_transparent_hugepage_shmem(char *str)
> +{
> +	int huge, ret = 0;
> +
> +	if (!str)
> +		goto out;
> +
> +	huge = shmem_parse_huge(str);
> +	if (huge == -EINVAL)
> +		goto out;
> +
> +	if (!has_transparent_hugepage() &&
> +			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Do not override huge allocation policy with non-PMD sized mTHP */
> +	if (huge == SHMEM_HUGE_FORCE &&
> +	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	shmem_huge = huge;

The code is similar to shmem_enabled_store(). Could you factor out the 
common parts into a helper function and reuse them?

> +	return 1;
> +out:
> +	pr_warn("transparent_hugepage_shmem= cannot parse, ignored\n");
> +	return ret;
> +}
> +__setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
> +
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>   #else /* !CONFIG_SHMEM */
>   
>   /*

