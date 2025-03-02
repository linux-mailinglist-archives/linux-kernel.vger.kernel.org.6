Return-Path: <linux-kernel+bounces-540826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A6DA4B58A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB1E16C212
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1EA1DF968;
	Sun,  2 Mar 2025 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYJ4ZNJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BC23F396
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740959549; cv=none; b=j6tvx6iMFAz1FvAinY8bWFww5VY4hm6z80M5Oe++PBCAW/xYe59WF6I9IafhmSrg8X0caYQ2fU1IJwlsmm4jRBA/6T3EDPp1vuGPEiSNlquGsxlk8SwWOoMnXSpbcFmlLhTHkFiCAs2JRdO2UJPGxqNeMmEOzhQK7EWvx2DoDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740959549; c=relaxed/simple;
	bh=ZCHiDYAhlovsWxCqC+x+dRnRzJjE1HzBfBSQe8cnIkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAjeA6blrsnVGHPpN7wgU1XpEHfOlW/pOf6a2CeCMlezpcmpQfIDzQr7B6afE6e0Jh4K2vJszVC6Tp4nHySU54PvxsRETxqkDPHJdwH54v0/eP1g7PnkpX1Jfc+nCDVA6q5rKmb37R0bk1GxWWxUZ+XpIAYCwE1ttVNoO4xwbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYJ4ZNJQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740959546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYg5YEi6qBDiPq4yW7kt5bdYtpCwTDMo82ocwV6poUo=;
	b=eYJ4ZNJQSeuYHNRZBZWxPMnQACC1aELVfxIfCBhbGet/RsT/ZfRF/JNnphhddVEcZAKt8w
	T2/OAAGN71HOg6vjIfFz1d5FGvJbvLaYaiecYzuDeHKx5IKXmH2km7IVa6M07qWPNRo7D+
	CbZtnPo49ps3/oj9DgN3tnDJTswv1/U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-uiGX-zglOhSJJJQUlZf3Ig-1; Sun, 02 Mar 2025 18:52:15 -0500
X-MC-Unique: uiGX-zglOhSJJJQUlZf3Ig-1
X-Mimecast-MFC-AGG-ID: uiGX-zglOhSJJJQUlZf3Ig_1740959535
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f6cb3097bso106607395ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 15:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740959534; x=1741564334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYg5YEi6qBDiPq4yW7kt5bdYtpCwTDMo82ocwV6poUo=;
        b=wBAjFPW2jpoP1ydMgQQLeDxEeBeKuzk8Jl/g192VnUFrvB/5+FRxwoAFexgkzMAVQ9
         s6CJxdiLuPkAQ1uRwYIx1mWEE8fKNX5y6PIlOgAuRkJv9kNm1BQCDTjER/G8sHMZKe66
         0MDaAtqsicWmpK0Orb7XeJ6S00wL88tHs2r6Xyr2flrk2+PAq5bRDuZD74isKcYXwgLf
         yIg8Cbtq+MgWnppEtpaDtcPxopnXZRDSflZbFXMMFhD8BkD/UmzP2AHW57ow8VKtOh7C
         amHcfqB7Bgm2/u7WpxF7Tx6t+Io8T2nP8CBSJVEY5jeqFDjGgTDtCCOnxU1jm940oOBA
         aoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXHFOG+yBDBOhLfGIGsdMScWzvpiyaXh9AKYHmGRZWOH4nWHDiJT5sXDx8QVqUZ+lrRUNPCtxK4QROeqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUSlkruiEMCqtL+KYEWWsSGRWyUYHNNrViq1fdo2A0+EKTqYn
	EJuo8pE2PYUo6EOSXDrGgaRJqSRqxJby3F4FjqX+kuVqr6bDEnSQnsBI7nFpGRagua3GnPvGkQs
	9R+yaHqSI3eVZVDf0a5knwcwDxOzs+fT0v64Zq1pg1w0ICtDFeaq9yO8WnHSd+g==
X-Gm-Gg: ASbGnct8uVFyCU/XClUADoWE6JFxpU1fbW3Oym3OsBJcMpERmG8QppUfVb51HATKSKw
	BEfVtc1hn6q9408U4WfnvgHxPbb834Z1NNLADTZHfzia9rZNQ2SD/uCQKHJ/gjpE7Vq7G1HMy3u
	IA7gkT9N0wUzwMzgCmFCWy46owEz1TttNb3MMIm1/e3wZC2j551oN2UoXGznGZUfSXhxJeoGOx1
	OFt7OtEJFmXTIB1agj/CZhIU7I6nIgocJUqMOm1i8akrHDyCCiaG88OEs2ZK7HkzdzYGzboqBOj
	GoLl+KjgD1/akUt7GA==
X-Received: by 2002:aa7:8589:0:b0:736:2f20:9d1 with SMTP id d2e1a72fcca58-7362f200c33mr9917277b3a.23.1740959534565;
        Sun, 02 Mar 2025 15:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKlHkk3X/xMjFSbabboBMi1iDhPso9R9B1xGAoC3vDIC/hJIAYOgl7Zpu+TUw2ZN+RUI7UGA==
X-Received: by 2002:aa7:8589:0:b0:736:2f20:9d1 with SMTP id d2e1a72fcca58-7362f200c33mr9917245b3a.23.1740959534256;
        Sun, 02 Mar 2025 15:52:14 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm7554622b3a.153.2025.03.02.15.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 15:52:13 -0800 (PST)
Message-ID: <7c217ce9-588e-4e4a-b395-2cd5d014487e@redhat.com>
Date: Mon, 3 Mar 2025 09:52:05 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/45] arm64: RME: Add SMC definitions for calling the
 RMM
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
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-5-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-5-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by SMC calls from the host.
> 
> The SMC definitions are based on DEN0137[1] version 1.0-rel0
> 
> [1] https://developer.arm.com/documentation/den0137/1-0rel0/
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Renamed REC_ENTER_xxx defines to include 'FLAG' to make it obvious
>     these are flag values.
> Changes since v5:
>   * Sorted the SMC #defines by value.
>   * Renamed SMI_RxI_CALL to SMI_RMI_CALL since the macro is only used for
>     RMI calls.
>   * Renamed REC_GIC_NUM_LRS to REC_MAX_GIC_NUM_LRS since the actual
>     number of available list registers could be lower.
>   * Provided a define for the reserved fields of FeatureRegister0.
>   * Fix inconsistent names for padding fields.
> Changes since v4:
>   * Update to point to final released RMM spec.
>   * Minor rearrangements.
> Changes since v3:
>   * Update to match RMM spec v1.0-rel0-rc1.
> Changes since v2:
>   * Fix specification link.
>   * Rename rec_entry->rec_enter to match spec.
>   * Fix size of pmu_ovf_status to match spec.
> ---
>   arch/arm64/include/asm/rmi_smc.h | 259 +++++++++++++++++++++++++++++++
>   1 file changed, 259 insertions(+)
>   create mode 100644 arch/arm64/include/asm/rmi_smc.h
> 

One nitpick below, with it addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> new file mode 100644
> index 000000000000..f85a82072337
> --- /dev/null
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -0,0 +1,259 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023-2024 ARM Ltd.
> + *
> + * The values and structures in this file are from the Realm Management Monitor
> + * specification (DEN0137) version 1.0-rel0:
> + * https://developer.arm.com/documentation/den0137/1-0rel0/
> + */
> +
> +#ifndef __ASM_RME_SMC_H
> +#define __ASM_RME_SMC_H
> +

#ifndef __ASM_RMI_SMC_H
#define __ASM_RMI_SMC_H


[...]

> +
> +struct rec_run {
> +	struct rec_enter enter;
> +	struct rec_exit exit;
> +};
> +
> +#endif

#endif /* __ASM_RMI_SMC_H */


