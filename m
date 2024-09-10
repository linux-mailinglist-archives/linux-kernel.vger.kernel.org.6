Return-Path: <linux-kernel+bounces-322236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74897261B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FF2284CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC5AD31;
	Tue, 10 Sep 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbmVZlYj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A679D2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927527; cv=none; b=dbXEMU2bCcRmEUI7m8b5FPLGJEmYO+wGsCuY6cdPH9+HR31iIqUD5uR+TL662gjx5iD1gYoOT3SgtYVT+Ow8G11wb7w7SP5PG/V6EMpPA2/iQ8tqvSdnSSPiW9VDjvHjB0xPCgy3uIqVfWE00nBdFcekC14sAdqltWleA7z0iT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927527; c=relaxed/simple;
	bh=L3a2g1E/6DmPzoCid4NmrExadsFZujU2lIAaLeWmoB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh35lFWshYzvSBwJhi5zxlbYbdaWLCZ9cjfSuSkfEYl0woG2o2Jh7b7Zea3FAi1bXZeTkQOOc2dWnYcAedeA4GrSpGFhRb3MS0MVov3tZbAu6DDDT2v1zSMbhrvqh6xxZeUe+AgIHm8DL9puhnO8uTpUWnId738gkGhsgVLDz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbmVZlYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725927524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qDUKZkW1qm/U7nIsNHl6u/vxYb3LmdiiRvhpMXyqBg=;
	b=HbmVZlYjLV/FzAiTvJ1wpeLM0praOaMuYBvMoCTmBOxgx//L9lIekaNW1MtwSS9YMa36wR
	YO4FzqoECpn25MrUzNn+R66D6nK1iqQG89ZzbXVJV3Di3/y/lnH1f04kP3zz+q8C+e+KMO
	KpKOnNZEVFMOt+mKT54IJ3Mq+aUi6nk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-nsOucS-CMvykULshrDLCKw-1; Mon, 09 Sep 2024 20:18:43 -0400
X-MC-Unique: nsOucS-CMvykULshrDLCKw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718e82769aeso373549b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 17:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725927522; x=1726532322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qDUKZkW1qm/U7nIsNHl6u/vxYb3LmdiiRvhpMXyqBg=;
        b=V8gSMMnaw/PVV2U+mAOkn7EFpGFjatW3EjDvJCpCrJ/uWtzKZq2U205uCxfiwf/h6E
         KeenqJr47D2U7TpQIOBxUzs+CvM2JZy0oo2VGfe150iAfGYW2sRkAZE/SxOQKFIDHzyF
         WaPVb0vZvztXvSyBxs4Jgq74Lv2KT5fS4wkaTqdUjHr8HVRIpS4pt6jIt68CA+ncuxS+
         OKittXaOzk/2JjEj8qsQofkTN2PQfKjKW6Vg6L/YB/l21WIF0JSNwkaxCR+KmmKdHjSo
         hTR4JKeLTbXr3JASxhZ0CNIEU+XSYV/J9XixHLHzF8SHNJkQWxYDU5qy8Z65rIrEP5CN
         0/AA==
X-Forwarded-Encrypted: i=1; AJvYcCXw8jVz3jkAOI8MnhP8WX0GXQhes3WxKbVokp5m0CSsBuH2xndh3ujyrgLUlz85JQJa0y3NQEHP9OTIwqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bPoar1e4pl+yPS7nfaQ0a+t/UkgRlIjEwsjX0kxpwqheYdPt
	6qTf0l2IXAxUH3plfitVtFPYQzUyyvkr4oGl5DNH1NmiWbtjj21XgSWQfIAVZBUyZnfLO9tX3u/
	nell9+dGxwcdqSKtvobtkOVjj2th/z2aUsqS5hqK+uR16HqW1koVEIJwgsXIuiQ==
X-Received: by 2002:a05:6a00:3cc4:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-718e33a0050mr14892327b3a.14.1725927521933;
        Mon, 09 Sep 2024 17:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyd0cypr7QA7LSQQ0FAqADYQZb+J27E549rmhRMytoKbFbGfFE8ni5SsRVpLPAZanhv86dsg==
X-Received: by 2002:a05:6a00:3cc4:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-718e33a0050mr14892272b3a.14.1725927521353;
        Mon, 09 Sep 2024 17:18:41 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909222bsm284268b3a.115.2024.09.09.17.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 17:18:40 -0700 (PDT)
Message-ID: <b5eab951-c2bd-4d4f-84c7-9617cc8d29cd@redhat.com>
Date: Tue, 10 Sep 2024 10:18:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/19] arm64: realm: Query IPA size from the RMM
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>
References: <20240819131924.372366-1-steven.price@arm.com>
 <20240819131924.372366-7-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240819131924.372366-7-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 11:19 PM, Steven Price wrote:
> The top bit of the configured IPA size is used as an attribute to
> control whether the address is protected or shared. Query the
> configuration from the RMM to assertain which bit this is.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v4:
>   * Make PROT_NS_SHARED check is_realm_world() to reduce impact on
>     non-CCA systems.
> Changes since v2:
>   * Drop unneeded extra brackets from PROT_NS_SHARED.
>   * Drop the explicit alignment from 'config' as struct realm_config now
>     specifies the alignment.
> ---
>   arch/arm64/include/asm/pgtable-prot.h | 4 ++++
>   arch/arm64/kernel/rsi.c               | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 

One nit below.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index b11cfb9fdd37..5e578274a3b7 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -68,8 +68,12 @@
>   
>   #include <asm/cpufeature.h>
>   #include <asm/pgtable-types.h>
> +#include <asm/rsi.h>
>   
>   extern bool arm64_use_ng_mappings;
> +extern unsigned long prot_ns_shared;
> +
> +#define PROT_NS_SHARED		(is_realm_world() ? prot_ns_shared : 0)
>   
>   #define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
>   #define PMD_MAYBE_NG		(arm64_use_ng_mappings ? PMD_SECT_NG : 0)
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 128a9a05a96b..e968a5c9929e 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -8,6 +8,11 @@
>   #include <linux/psci.h>
>   #include <asm/rsi.h>
>   
> +struct realm_config config;
> +
> +unsigned long prot_ns_shared;
> +EXPORT_SYMBOL(prot_ns_shared);
> +
>   DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>   EXPORT_SYMBOL(rsi_present);
>   
> @@ -72,6 +77,9 @@ void __init arm64_rsi_init(void)
>   		return;
>   	if (!rsi_version_matches())
>   		return;
> +	if (rsi_get_realm_config(&config))
> +		return;
> +	prot_ns_shared = BIT(config.ipa_bits - 1);
>   
>   	static_branch_enable(&rsi_present);
>   }

Nit: It's probably worthy to warn on errors returned from rsi_get_realm_config(),
It's hard to debug and follow if it fails silently.

Thanks,
Gavin


