Return-Path: <linux-kernel+bounces-326203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277CC9764DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3821C22F49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272F1922C0;
	Thu, 12 Sep 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsE0IaFr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24E18BC32
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130994; cv=none; b=e7p0U0tfQiAQhSDhmzR4Eoa3jZfhNcB7HaKDakZdT9r8Mskyt5WA3Lwsy96vVyeSbHgpHiEYneQdt+n9j2pwJ3S72IipOP4uxatRQb++ilS9+ZCO5elGpgv/F4CrVkAOmmQ47D54ndepC3eCDjjYvkzDzOjTs4SZyHwf7Vbs7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130994; c=relaxed/simple;
	bh=Dw6vJSOcKXJoxKUfF+YEWcXIuVRn04+szgZm935OPDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAXrQJctNWIOGziCjoxk1L3B3P7FWSGSdZAbp5q5ks/JNJ3ZlHP3FcHZGSj0c6l0Mikoi41gsxGRnX/ZOE9hdm5Q7Fe28W7EwecLFkQKGHj8IxD1+VopkiURpVOZ7szretcgFMSfwsnwjxNAY4X2M/Q6tGFloOXZwuvhqK9THfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsE0IaFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726130991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlbjGqxPrkeon87/oeRHHfBNj7EM9vRLefgULYdvY+w=;
	b=gsE0IaFr6/b/7PzRz7hjQQM8j79xxE5UY3iWN18789CFUlB367YLemVWkafDyMcUMV93Ee
	Bt2Ak2boJ4Mi7f02Md3H0uxIhKX8YhtkAYkc18MhzKNi4ERcfr+YuhOZ+smaUmN4EMCRry
	fHgsQT+sVpKJGgRPiGBm2+Ht+ekH1eE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-KJ1J2bPtP7qvb2zPeLssGg-1; Thu, 12 Sep 2024 04:49:49 -0400
X-MC-Unique: KJ1J2bPtP7qvb2zPeLssGg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2054ff12bb9so8667045ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726130989; x=1726735789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlbjGqxPrkeon87/oeRHHfBNj7EM9vRLefgULYdvY+w=;
        b=uiL05zNBi4z+4qGyV4aTMdkWkTwzgVRgMAwdi2FFOYdP8gZDGCFAAZMz3nIAW/nSQk
         1klnPVZD/E9kUJ50mPWt7glRbZ4BIZzH2uTkzc8YKkFDR/MBLafbCxOshsZQbOiZX3Kt
         VZz/vap84XQZlvf1AlKbccwUSgs4+pQO4jFQ39f22BWrlmKJa6yOneSUlCwEeuw+A7Br
         vM9BV3o5zGh20tBlzAYrk6u7R+xi0b8SyzDJ2HO6Qt/2Y/WxpXOfPhSUoRRTyPDjO1rI
         WoliiZdPm0QSZt1O9+5k6FYg65Js34HITmcCFcN+NEM4lBErsw27GBCgnHhfKtc2YAC3
         +POQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX1wFKQ1tXpiMx9UvPzRKFwBpLcAvhVwPEXgp9xAGc1sg5QBaspTSW8zQOD2hhqmqDQPqNPw46nvyrZX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FiHV2cwZLKOobgXdItNDrybcXIcX28TP2ijc6FtiDdt3kGTG
	gflvSx2ao5SUbNaQeHu+zJO8Ni/yPiUTQ/Txx48qjLPyl2Jo62LTx8zeVQFzwCPxg7RLw/Z8P7E
	vhe/CR+q0DZ/BOjPk8dsImDNryuT3M9RntQQ+N/JoC9htH0eFsG/300kgeIkAAA==
X-Received: by 2002:a17:902:da88:b0:206:b250:1e1 with SMTP id d9443c01a7336-2076e4239fdmr35741795ad.45.1726130988826;
        Thu, 12 Sep 2024 01:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPAkVBoX5O51FPnWXRKfp2ysY+5b/bgkEdmVhjUV5BvvY4BoXMPZkD0mwXpBtdC2wzCEryIw==
X-Received: by 2002:a17:902:da88:b0:206:b250:1e1 with SMTP id d9443c01a7336-2076e4239fdmr35741415ad.45.1726130988229;
        Thu, 12 Sep 2024 01:49:48 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25117sm10632455ad.39.2024.09.12.01.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 01:49:47 -0700 (PDT)
Message-ID: <8e17105a-8732-46df-8f3e-01a168558231@redhat.com>
Date: Thu, 12 Sep 2024 18:49:38 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/43] arm64: RME: Check for RME support at KVM init
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
References: <20240821153844.60084-1-steven.price@arm.com>
 <20240821153844.60084-8-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240821153844.60084-8-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 1:38 AM, Steven Price wrote:
> Query the RMI version number and check if it is a compatible version. A
> static key is also provided to signal that a supported RMM is available.
> 
> Functions are provided to query if a VM or VCPU is a realm (or rec)
> which currently will always return false.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v2:
>   * Drop return value from kvm_init_rme(), it was always 0.
>   * Rely on the RMM return value to identify whether the RSI ABI is
>     compatible.
> ---
>   arch/arm64/include/asm/kvm_emulate.h | 17 +++++++++
>   arch/arm64/include/asm/kvm_host.h    |  4 ++
>   arch/arm64/include/asm/kvm_rme.h     | 56 ++++++++++++++++++++++++++++
>   arch/arm64/include/asm/virt.h        |  1 +
>   arch/arm64/kvm/Makefile              |  3 +-
>   arch/arm64/kvm/arm.c                 |  6 +++
>   arch/arm64/kvm/rme.c                 | 50 +++++++++++++++++++++++++
>   7 files changed, 136 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/include/asm/kvm_rme.h
>   create mode 100644 arch/arm64/kvm/rme.c
> 

[...]

> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> new file mode 100644
> index 000000000000..418685fbf6ed
> --- /dev/null
> +++ b/arch/arm64/kvm/rme.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/rmi_cmds.h>
> +#include <asm/virt.h>
> +
> +static int rmi_check_version(void)
> +{
> +	struct arm_smccc_res res;
> +	int version_major, version_minor;
> +	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
> +						     RMI_ABI_MINOR_VERSION);
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
> +
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -ENXIO;
> +
> +	version_major = RMI_ABI_VERSION_GET_MAJOR(res.a1);
> +	version_minor = RMI_ABI_VERSION_GET_MINOR(res.a1);
> +
> +	if (res.a0 != RMI_SUCCESS) {
> +		kvm_err("Unsupported RMI ABI (v%d.%d) host supports v%d.%d\n",
> +			version_major, version_minor,
> +			RMI_ABI_MAJOR_VERSION,
> +			RMI_ABI_MINOR_VERSION);

This message is perhaps something like below since a range of versions can be
supported by one particular RMM release.

     kvm_err("Unsupported RMI ABI v%d.%d. Host supports v%ld.%ld - v%ld.%ld\n",
             RMI_ABI_MAJOR_VERSION, RMI_ABI_MINOR_VERSION,
             RMI_ABI_VERSION_GET_MAJOR(res.a1), RMI_ABI_VERSION_GET_MINOR(res.a1),
             RMI_ABI_VERSION_GET_MAJOR(res.a2), RMI_ABI_VERSION_GET_MINOR(res.a2));

> +		return -ENXIO;
> +	}
> +
> +	kvm_info("RMI ABI version %d.%d\n", version_major, version_minor);
> +

We probably need to print the requested version, instead of the lower implemented
version, if I'm correct. At present, both of them have been fixed to v1.0 and we
don't have a problem though.

         kvm_info("RMI ABI version v%d.%d\n", RMI_ABI_MAJOR_VERSION, RMI_ABI_MINOR_VERSION);

> +	return 0;
> +}
> +

Thanks,
Gavin


