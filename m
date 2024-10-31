Return-Path: <linux-kernel+bounces-390511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1459B7ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20AA2849C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D419DF4A;
	Thu, 31 Oct 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4++ncDN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E51E495
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378243; cv=none; b=XnbqXYJ62cDZH7J5DuAe582wvRoozJL6n2ypPLwQNb+/2n4sPVQPDGNPDJg8VfOSmy3LTEdBQX9juDIJn5+hvKzgtJM7an1Ha/dPxD8jkEgbtNcVL7MBPpEjE2qjYHigMBZxhUQZJD3YAqEzjAfn+OI/XOX7lMuPqfJDw46BIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378243; c=relaxed/simple;
	bh=HoD8ilGuMYtPbxx4dST3nnZ9of8lsIcP2oN0hCFRKgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u53TPPhE9aVJlP11OaP/nq67EQzt7HpLAC605hq2py2HBnf0IMj+1VPVbj0/yPKGaHlA3TVGdsGYkj5wwT/LZrkziBtCAe4/tAW6f4wTFh1Vx2JklpL0jfrbTUj31gL5350hotW1cNTeRmfXmNffWfZdcnRGbhGNJiF7/Z/bGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4++ncDN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730378239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Hal6WHS1aE76VZfKuRs4hvYStmTjVfx8JR8a8dnIgM=;
	b=I4++ncDNbEI4bZxTssQ/mAapF0//TfCXwe0lfMRubRwiRSw1eV5phyGUJiGNbvIr3xrqtl
	9eFRVtzVwCmqmtCMpCXyknwB2LXjbHJtgcN9CT+XU3/1gs/lVCjxoPn5PjxT3cgC9lCPTX
	iwIqf9XaCDqPC8oKkfUNjfXahIAAX1Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-UmY5C1hPMDWMyUemOmhOkg-1; Thu, 31 Oct 2024 08:37:17 -0400
X-MC-Unique: UmY5C1hPMDWMyUemOmhOkg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso5608935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378236; x=1730983036;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Hal6WHS1aE76VZfKuRs4hvYStmTjVfx8JR8a8dnIgM=;
        b=spc1qFz6Y/n7F4R+FO5MIWhtwN3ZG+8n+d6gVuCS0vvetEdMY/Z+Bx9o0CMo+X8DaB
         Yf2nrTz+X+hKeXjQnrnmeIc3KPt0DuwrQLopxVdL2tsys1wNcv43buLF2CVqE7z0qos6
         nAEVKMRJc/fSAqpbzCQzKmJ2pO/dqdI8ncS/H3uD25yq9S46CnZhrZWFs8QAAIZsNhXe
         tDkfKvajapfgpf96fk/nAt8dmTdcSOnmG0mO6RYCbFJ79wXdAhF+oPDVsZ8F7kKMoYfd
         6A/N9Evvk0vzMiuBUpBabuoSZiA1SZGV5rzF7Owlgad/0bmjjCeWL+N4SltY98VXi99W
         PBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qgu4NiYtcGEXIV66oIiZg7sbTJ8rMFmcK1Ym8VcjanLHkXvgh/NKbg7ikRJOmqXJTZ6RdG/64VvNExg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoudyEHNkIpZRh+WmIIiIOO7gFvXdEcalPLoPucy8wA1lNTIBZ
	MURH0Y8GgMpxkPAPGO0ffYiHVQ1LVO0amzDIS2af7SzbRFzgHVjoTe48KG76Fi+yZ8zuronbkco
	N+RWwmKCVj94qBNGX0Fx5wTR1BN9DV3UlVyV3rqTSPNf/LdiFpb3KdYFoW+Jkkw==
X-Received: by 2002:a05:600c:4fd3:b0:431:60d0:9088 with SMTP id 5b1f17b1804b1-4319ac9acedmr180517885e9.13.1730378236476;
        Thu, 31 Oct 2024 05:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSVID/xCV/RTrYmwxSXhv/tUYwNIbN7QNfqet0lWlt3ppFonkE6MHSCcoT38nLBWw61eJ3qA==
X-Received: by 2002:a05:600c:4fd3:b0:431:60d0:9088 with SMTP id 5b1f17b1804b1-4319ac9acedmr180517665e9.13.1730378236072;
        Thu, 31 Oct 2024 05:37:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d698055sm25127635e9.40.2024.10.31.05.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 05:37:14 -0700 (PDT)
Message-ID: <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com>
Date: Thu, 31 Oct 2024 13:37:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-4-mcanal@igalia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241030130308.1066299-4-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.10.24 13:58, Maíra Canal wrote:
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
> By configuring the default policy of several shmem hugepages, the user
> can take advantage of mTHP before it's been configured through sysfs.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  10 ++
>   Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>   mm/shmem.c                                    | 109 +++++++++++++++++-
>   3 files changed, 135 insertions(+), 1 deletion(-)
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
> index 9b5b02c4d1ab..47e7fc30e22d 100644
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
> index dfcc88ec6e34..c2299fa0b345 100644
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
> @@ -5180,6 +5182,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
>   
>   #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>   
> +static inline int get_order_from_str(const char *size_str)
> +{
> +	unsigned long size;
> +	char *endptr;
> +	int order;
> +
> +	size = memparse(size_str, &endptr);
> +
> +	if (!is_power_of_2(size))
> +		goto err;
> +	order = get_order(size);
> +	if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
> +		goto err;
> +
> +	return order;
> +err:
> +	pr_err("invalid size %s in thp_shmem boot parameter\n", size_str);
> +	return -EINVAL;
> +}

Hm, mostly copy and paste. You could reuse existing get_order_from_str() 
simply by passing in the supported orders and moving error reporting to 
the caller.

static inline int get_order_from_str(const char *size_str,
		int valid_orders)
{
	...
	if (!is_power_of_2(size))
		return -EINVAL;
	order = get_order(size);
	if (BIT(order) & ~valid_orders)
		return -EINVAL;
	return order;
}

> +
>   static int __init setup_transparent_hugepage_shmem(char *str)
>   {
>   	int huge;
> @@ -5195,6 +5217,91 @@ static int __init setup_transparent_hugepage_shmem(char *str)
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
> +				start = get_order_from_str(start_size);
> +				end = get_order_from_str(end_size);
> +			} else {
> +				start = end = get_order_from_str(subtoken);
> +			}
> +
> +			if (start < 0 || end < 0 || start > end)
> +				goto err;
> +
> +			nr = end - start + 1;
> +			if (!strcmp(policy, "always")) {
> +				bitmap_set(&always, start, nr);
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&within_size, start, nr);
> +			} else if (!strcmp(policy, "advise")) {
> +				bitmap_set(&madvise, start, nr);
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&always, start, nr);
> +				bitmap_clear(&within_size, start, nr);
> +			} else if (!strcmp(policy, "inherit")) {
> +				bitmap_set(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&always, start, nr);
> +				bitmap_clear(&within_size, start, nr);
> +			} else if (!strcmp(policy, "within_size")) {
> +				bitmap_set(&within_size, start, nr);
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&always, start, nr);
> +			} else if (!strcmp(policy, "never")) {
> +				bitmap_clear(&inherit, start, nr);
> +				bitmap_clear(&madvise, start, nr);
> +				bitmap_clear(&always, start, nr);
> +				bitmap_clear(&within_size, start, nr);
> +			} else {
> +				pr_err("invalid policy %s in thp_shmem boot parameter\n", policy);
> +				goto err;
> +			}
> +		}
> +	}


Similarly, copy-paste. But not that easy to abstract :) So maybe we'll 
have to keep that as is for now.


-- 
Cheers,

David / dhildenb


