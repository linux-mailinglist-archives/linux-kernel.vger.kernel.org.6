Return-Path: <linux-kernel+bounces-386178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDE9B4015
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4711C21192
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BC126BE6;
	Tue, 29 Oct 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ju1K9N7R"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C881863F;
	Tue, 29 Oct 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167446; cv=none; b=el/GMBkgscd81hAn2mnX+PAUUdtIxcmdzCEXFT4KRuiuqAXzQ9EZmuuKER4jmEIYGWLVLjbZmfThfXVUufWENFX4J/TjAfldZgz290qg0lJqH5Bt07vVlPwjL7ghMzq6OymX4Yrf/fm7pvU4tha1GvlA8V3c//kfLdSviDtQrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167446; c=relaxed/simple;
	bh=ZsO1ZU2TXg/NGu3J2x38UomRJPb4lMdm98glWHaQhxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QArAaXSL/2dG0Saq0T0wHv8kONHQLGFdD1ijvx/oEczmAWreYNukN6yA0er0R36LjEFK38KEHGqjZAHJ7QZDyyN8ugeANB/j8GhbQ7anV+luLFoRW1K+xwalBqbu1WjRb7XkXZJcsOhgDRXHGVS77MNtQxwQgiamxCALosxfcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ju1K9N7R; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730167440; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cJLV2I3mm++zjsZzUs9QwwWBlESHcgMWR+goQ5ld/5c=;
	b=ju1K9N7RJJJ+w3jgF1CRis4GaECwQBLcCvEEZEyEdeLb+FMpR26wfmnAM6/ngHMjjLa+v21tY/rY2RFqFBo5Y4pG4c/f6VQrDO21uVWzezSn//iWNbbUHm0WdiZ/A37hl+uhg2MvR89Q2sLwLrEq6Uwt8h4MmvGXkCQLJ/BDEbE=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WI8M9ZI_1730167438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 10:03:59 +0800
Message-ID: <6044e56a-7747-45d4-82c9-7a070950ddd2@linux.alibaba.com>
Date: Tue, 29 Oct 2024 10:03:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: shmem: control THP support through the kernel
 command line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241029002324.1062723-1-mcanal@igalia.com>
 <20241029002324.1062723-3-mcanal@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241029002324.1062723-3-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/29 08:13, Maíra Canal wrote:
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

Just out of curiosity, do you have any performance benefit data when 
using mTHP for DRM GEM objects?

> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  7 +++
>   Documentation/admin-guide/mm/transhuge.rst    |  6 +++
>   mm/shmem.c                                    | 53 +++++++++++++++----
>   3 files changed, 57 insertions(+), 9 deletions(-)
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
> index 44282a296c33..26c1eb1b4b1d 100644
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
> @@ -624,6 +622,20 @@ static const char *shmem_format_huge(int huge)
>   }
>   #endif
>   
> +static int shmem_valid_huge(int huge)
> +{
> +	if (!has_transparent_hugepage() &&
> +			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
> +		return -EINVAL;
> +
> +	/* Do not override huge allocation policy with non-PMD sized mTHP */
> +	if (huge == SHMEM_HUGE_FORCE &&
> +	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>   		struct shrink_control *sc, unsigned long nr_to_free)
>   {
> @@ -5070,14 +5082,10 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
>   	huge = shmem_parse_huge(tmp);
>   	if (huge == -EINVAL)
>   		return -EINVAL;
> -	if (!has_transparent_hugepage() &&
> -			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
> -		return -EINVAL;
>   
> -	/* Do not override huge allocation policy with non-PMD sized mTHP */
> -	if (huge == SHMEM_HUGE_FORCE &&
> -	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
> -		return -EINVAL;
> +	err = shmem_valid_huge(huge);
> +	if (err)
> +		return err;
>   
>   	shmem_huge = huge;
>   	if (shmem_huge > SHMEM_HUGE_DENY)
> @@ -5174,6 +5182,33 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
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

Looks better. But shmem_parse_huge() is also a common part, and what I 
am thinking is below:

diff --git a/mm/shmem.c b/mm/shmem.c
index f8b8b1ad2631..646d8943950a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -629,24 +629,39 @@ static unsigned int 
shmem_huge_global_enabled(struct inode *inode, pgoff_t index
         }
  }

-#if defined(CONFIG_SYSFS)
  static int shmem_parse_huge(const char *str)
  {
+       int huge;
+
+       if (!str)
+               return -EINVAL;
+
         if (!strcmp(str, "never"))
-               return SHMEM_HUGE_NEVER;
-       if (!strcmp(str, "always"))
-               return SHMEM_HUGE_ALWAYS;
-       if (!strcmp(str, "within_size"))
-               return SHMEM_HUGE_WITHIN_SIZE;
-       if (!strcmp(str, "advise"))
-               return SHMEM_HUGE_ADVISE;
-       if (!strcmp(str, "deny"))
-               return SHMEM_HUGE_DENY;
-       if (!strcmp(str, "force"))
-               return SHMEM_HUGE_FORCE;
-       return -EINVAL;
+               huge = SHMEM_HUGE_NEVER;
+       else if (!strcmp(str, "always"))
+               huge = SHMEM_HUGE_ALWAYS;
+       else if (!strcmp(str, "within_size"))
+               huge = SHMEM_HUGE_WITHIN_SIZE;
+       else if (!strcmp(str, "advise"))
+               huge = SHMEM_HUGE_ADVISE;
+       else if (!strcmp(str, "deny"))
+               huge = SHMEM_HUGE_DENY;
+       else if (!strcmp(str, "force"))
+               huge = SHMEM_HUGE_FORCE;
+       else
+               return -EINVAL;
+
+       if (!has_transparent_hugepage() &&
+           huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
+               return -EINVAL;
+
+       /* Do not override huge allocation policy with non-PMD sized mTHP */
+       if (huge == SHMEM_HUGE_FORCE &&
+           huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
+               return -EINVAL;
+
+       return huge;
  }
-#endif

  #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
  static const char *shmem_format_huge(int huge)
@@ -5104,16 +5119,8 @@ static ssize_t shmem_enabled_store(struct kobject 
*kobj,
                 tmp[count - 1] = '\0';

         huge = shmem_parse_huge(tmp);
-       if (huge == -EINVAL)
-               return -EINVAL;
-       if (!has_transparent_hugepage() &&
-                       huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
-               return -EINVAL;
-
-       /* Do not override huge allocation policy with non-PMD sized mTHP */
-       if (huge == SHMEM_HUGE_FORCE &&
-           huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
-               return -EINVAL;
+       if (huge < 0)
+               return huge;

         shmem_huge = huge;
         if (shmem_huge > SHMEM_HUGE_DENY)
@@ -5210,6 +5217,25 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
         __ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, 
thpsize_shmem_enabled_store);
  #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */

+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
+static int __init setup_transparent_hugepage_shmem(char *str)
+{
+       int huge;
+
+       huge = shmem_parse_huge(str);
+       if (huge < 0) {
+               pr_warn("transparent_hugepage_shmem= cannot parse, 
ignored\n");
+               return 0;
+       }
+
+       shmem_huge = huge;
+       return 1;
+}
+__setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
  #else /* !CONFIG_SHMEM */

  /*

