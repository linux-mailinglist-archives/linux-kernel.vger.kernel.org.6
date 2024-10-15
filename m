Return-Path: <linux-kernel+bounces-365068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDA99DD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65622833DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98293172798;
	Tue, 15 Oct 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUkB3m5s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAD1714C4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964570; cv=none; b=E1speC9723QJIM5FPB9ucTd41HEIMywUJBckJ3SjmcQelvv9w/ClVDcFHDf+f6eShFodWlrkCST/NG+hyLoOBr1vLdPJ3ux4Xd/BYR6ZMuUHVsCQMLQ8s4IPdnyg1y4liuz52F/VzSCzQ/84eJaNEWpmFMx4q0pU8ermN5rUd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964570; c=relaxed/simple;
	bh=MgtyB/AAROrtxH1XraK2lYAW3vbCsCYiprQHNQSY0ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUPD+WuQMUybGMaJgXgFg7/FfKC/15gTaXj2UUFTops+/IOrb2yE40Lu+gCQQ/XkAkwzksGCCsUVnLNz8Yw9NJ8vAfyzFpfYbk4yCezI7j7u4TSH5xiic374AP7htD9KZCP9ql11z01e2I+875HG1+EWSWM2AkeqPmn5BDpVeGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUkB3m5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728964567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gQj7yhKGwHX3tay3bEUPL2aqsF2Bb60CY1YisKDKbg=;
	b=cUkB3m5sEwL9Gssk2oIkeuTrLZL18V44yJzof0LmDTD1ft8NhuHSh4jr35KZmadpgGQl1H
	xuPvyl0NxCKoq4APEa+2hirPjdhUozNi7lxpR4Ky7oZvQh5puZLgUOQHGPbfAhNKFOcOqZ
	mVHSiOxgWX/stK/Q8+T+zTDLS3Ko2pE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-037OPyDUPOKIkW7aeu09Bg-1; Mon, 14 Oct 2024 23:56:04 -0400
X-MC-Unique: 037OPyDUPOKIkW7aeu09Bg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e455defb9so5307979b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728964563; x=1729569363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQj7yhKGwHX3tay3bEUPL2aqsF2Bb60CY1YisKDKbg=;
        b=YeULmsQ4a2k9GM39ZujUB/q1IsFnnMRmTNoVMMqY5U07dj0oeBKOrqeIJSx19jq6yN
         dJwCewVdncX27dUMJBMBWkY8T40fR7yz0G8dQDnK+9yKebNLpywyY6sLqZWfG9Ni7qQr
         sLceFu4/hSdxyBI4w8ssBhhyW0JV+vmjlU+8n3DGUKfpykQakxtJHerebV0sPJyB5/KK
         5R9PwXfaqR8Agt04IzILZwDMsEhU4IDKcqUPkm/hwWfNeKLsAj+2tX63RXPh1q3cxDTi
         QhbcWN71uvt7Q6ZuPDeeNQgzgGR8V1/j9Dht8VGAXWZRLEGOlKq1oIgcGi88m/wupRsA
         JF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1PqXwpVdtrg32UrjEIQYTkcpcjAoIL/K/rev/SxTHZKrIs3v3CsR6qkPyHfN82hUTJ3W47pJu79q979U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0hb1tQAak+5n7c+gf/cNgOund5alG6xYbNNzi4eXv5MndmqK
	71C8OjYJ+XMJeNWdiM/jXezrpRs4DSHAWMI4z+Sj1OVO096yNCHYe5AWt9BIsTSC8yNI/a5zTZi
	2t83pt5/e0j4cmLjh3iChjdUDOWdc0woy/fg5Ayf7h5B+EeyTn+iYYVH3jJE8hw==
X-Received: by 2002:a05:6a21:4d8c:b0:1d8:f894:43f9 with SMTP id adf61e73a8af0-1d8f89445eamr681082637.11.1728964563166;
        Mon, 14 Oct 2024 20:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGybMblrnhP5WbRv8pGItZKUwHcNnS++KdeQ7wfVC+XkNBJwpsFwHEmwrwG693wjo55GOXWsQ==
X-Received: by 2002:a05:6a21:4d8c:b0:1d8:f894:43f9 with SMTP id adf61e73a8af0-1d8f89445eamr681045637.11.1728964562725;
        Mon, 14 Oct 2024 20:56:02 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6ba2d4sm339896a12.11.2024.10.14.20.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 20:56:02 -0700 (PDT)
Message-ID: <2352629a-3742-45e9-a38f-196989918c9b@redhat.com>
Date: Tue, 15 Oct 2024 13:55:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] arm64: realm: Query IPA size from the RMM
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
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-4-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-4-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:42 AM, Steven Price wrote:
> The top bit of the configured IPA size is used as an attribute to
> control whether the address is protected or shared. Query the
> configuration from the RMM to assertain which bit this is.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
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
>   arch/arm64/include/asm/rsi.h          | 2 +-
>   arch/arm64/kernel/rsi.c               | 8 ++++++++
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 

[...]

> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 9bf757b4b00c..a6495a64d9bb 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -8,6 +8,11 @@
>   #include <linux/psci.h>
>   #include <asm/rsi.h>
>   
> +struct realm_config config;
> +

Nit: I think this variable is file-scoped since it has a generic name.
In this case, 'static' is needed to match with the scope.

> +unsigned long prot_ns_shared;
> +EXPORT_SYMBOL(prot_ns_shared);
> +
>   DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>   EXPORT_SYMBOL(rsi_present);
>   
> @@ -67,6 +72,9 @@ void __init arm64_rsi_init(void)
>   		return;
>   	if (!rsi_version_matches())
>   		return;
> +	if (WARN_ON(rsi_get_realm_config(&config)))
> +		return;
> +	prot_ns_shared = BIT(config.ipa_bits - 1);
>   
>   	arm64_rsi_setup_memory();
>   

Thanks,
Gavin


