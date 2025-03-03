Return-Path: <linux-kernel+bounces-540949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CF4A4B6D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2873ABB28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F31D5CDE;
	Mon,  3 Mar 2025 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ+Hr7iC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F26F073
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973374; cv=none; b=fMxo+KUN0gE17IoWBlbIaRRH+3ogsAtOfZ+j0hCs3SxgBv1y3l9SKro/cuyVWvnBLHAjBJgPGPaQ6cpJC7plibw2nij3izWUxytouFOkKN5SovKzs3jwTkaxSe8jJwTuwOfrjUEmdt+6jUe0VIJj8lCUthHIJ7emiHItyJAsinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973374; c=relaxed/simple;
	bh=38g/wttyi0OVix58IXmMb9keoqRC6204XM1tdy05KJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itauGEApPo7v1YK0LPpsx0fNZ96WD3rNm23zW13vcEV9bGwRJ+F/j2KUB5yq9SZyAMXBLf79PMKHqcJ5qKThS1jFibPFeJEFbaFyRXQZwZSyLgKkmWD8XkaWjWqPNHJr3IvSPGsvNHnVEJFL+MW+TxUEcV+BL9DaodGFsPWd9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQ+Hr7iC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740973370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEDc5a+qaJ461fEOorI0aPSdSVAqOPF0WWp/svcyhEc=;
	b=EQ+Hr7iC0Y3AnvZAuO2P6LNNkDnQTJ7sxOupxIe9s52xwej0yO1QH8NF3iBsA3rdmskPwD
	+Nw7LFJjvltDtRfhDPoaI9zGL9JDTGZOHre0h31Hd2HA0xCLDE/UCfhAGACiDq2whRL+qW
	7eq+WGVM31l8CKLoAgup/TC9q3epnZE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-iUlQxot2O_qh6UjMR5f25w-1; Sun, 02 Mar 2025 22:42:39 -0500
X-MC-Unique: iUlQxot2O_qh6UjMR5f25w-1
X-Mimecast-MFC-AGG-ID: iUlQxot2O_qh6UjMR5f25w_1740973358
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so4247049a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740973358; x=1741578158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEDc5a+qaJ461fEOorI0aPSdSVAqOPF0WWp/svcyhEc=;
        b=hy7ZWg41UNuAhggqn5psouUdtQJURVJbUVqzVTfhu4COmCHdvS4cXWF7uPoD9k72tf
         j4+bZ/wA8X0ksk89zNR3v7GwiEHwWZ1P7G0FzwVepvXj6rHnOm1/VuYPysBwqkn6xz9D
         K88B4B0V3XkrRlb0aCVbVAMATJJr8hO/DNL1R3pXji1ppjOE8rWupJ6yD8AYtUY5GaHM
         dlvIFnu7qTOQQtqJcjOZo0VID2PR+jQ7pMnN/JxXmonnct8SIgFbeaAVUa+t6MirFBfz
         wdqPDue6s8BC2yqUuz0AOLiWHIpguwZ7uDNl4VJGABX2pS63xy9PcGkF8pdF2djJZrri
         ytAg==
X-Forwarded-Encrypted: i=1; AJvYcCVhyRgLuEFxiydXdZqFlyS5azCJM7eSjOCDMDKx4q7wXTK4NOqMO/D1k/I7FWWcK5ZE+ar8/8lg8j8lbcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwX0U5+oTkImcgzMOxOs2XGCx8qnMs244Tn0f1CUK/qY5KheJ
	G2svqU+c3xQukM0KBulu31T5uIbK+o4E54HX+m/vlt7fNZRv8+qK62HC4uoS0AA5Mg0DlneGFvq
	SbifIuyZcrwA517llJWdURVTKv4ojrJA1zpJQwgssgoD5g5GHiLBpzH6a2+T+sw==
X-Gm-Gg: ASbGncvA0YtE/fGleyTcNr2us7+h4RwrxfcFOJDQSswyBq0Ri10XmlBEgnefQyBB5K7
	it0ahy59RM5wgbDizwpoZ18PiKWAiYAT7KL6puqXzx7x55Pq85nX6N2XEW358XUvwSyhF45/8Gf
	N+2HR7cFLx6WXooaIkBIKaE3Wmy265JehvFFWhywCO/+fVFWxCoFdGDlBQCapfHw1Po3qK9+Pyv
	aTE9YLUI/gamDqRVJD0Qo++2jgrbUWIEVCLs/6kwD0txDuOhOSif2EHbs3QGm568AELu+24pnBX
	iC2oe7yUhjjcLjOmdA==
X-Received: by 2002:a05:6a20:1585:b0:1f0:e708:56e2 with SMTP id adf61e73a8af0-1f2f4cffa11mr18287086637.22.1740973358556;
        Sun, 02 Mar 2025 19:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5c7Qc3VVFcg30Esq5DIzJh6RfeW5P5eI8KFXRrs6oJHF3s/m+eXSunL5iyzYk2nV2q0PqZA==
X-Received: by 2002:a05:6a20:1585:b0:1f0:e708:56e2 with SMTP id adf61e73a8af0-1f2f4cffa11mr18287060637.22.1740973358238;
        Sun, 02 Mar 2025 19:42:38 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7362e3b1c61sm4421335b3a.22.2025.03.02.19.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 19:42:37 -0800 (PST)
Message-ID: <8f08b96b-8219-4d51-8f46-bc367bbf2031@redhat.com>
Date: Mon, 3 Mar 2025 13:42:29 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/45] arm64: RME: Add wrappers for RMI calls
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
 <20250213161426.102987-6-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-6-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> The wrappers make the call sites easier to read and deal with the
> boiler plate of handling the error codes from the RMM.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes from v5:
>   * Further improve comments
> Changes from v4:
>   * Improve comments
> Changes from v2:
>   * Make output arguments optional.
>   * Mask RIPAS value rmi_rtt_read_entry()
>   * Drop unused rmi_rtt_get_phys()
> ---
>   arch/arm64/include/asm/rmi_cmds.h | 508 ++++++++++++++++++++++++++++++
>   1 file changed, 508 insertions(+)
>   create mode 100644 arch/arm64/include/asm/rmi_cmds.h
> 

With the following nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
> new file mode 100644
> index 000000000000..043b7ff278ee
> --- /dev/null
> +++ b/arch/arm64/include/asm/rmi_cmds.h
> @@ -0,0 +1,508 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#ifndef __ASM_RMI_CMDS_H
> +#define __ASM_RMI_CMDS_H
> +

[...]

> +
> +/**
> + * rmi_rec_aux_count() - Get number of auxiliary granules required
> + * @rd: PA of the RD
> + * @aux_count: Number of pages written to this pointer
                   ^^^^^^^^^^^^^^^
                   Number of granules
> + *
> + * A REC may require extra auxiliary pages to be delegated for the RMM to
                                         ^^^^^
                                         granules

> + * store metadata (not visible to the normal world) in. This function provides
> + * the number of pages that are required.
                     ^^^^^
                     granules
> + *
> + * Return: RMI return code
> + */
> +static inline int rmi_rec_aux_count(unsigned long rd, unsigned long *aux_count)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_REC_AUX_COUNT, rd, &res);
> +
> +	if (aux_count)
> +		*aux_count = res.a1;
> +	return res.a0;
> +}
> +
> +/**
> + * rmi_rec_create() - Create a REC
> + * @rd: PA of the RD
> + * @rec: PA of the target REC
> + * @params_ptr: PA of REC parameters
> + *
> + * Create a REC using the parameters specified in the struct rec_params pointed
> + * to by @params_ptr.
> + *
> + * Return: RMI return code
> + */
> +static inline int rmi_rec_create(unsigned long rd, unsigned long rec,
> +				 unsigned long params_ptr)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_REC_CREATE, rd, rec, params_ptr, &res);
> +
> +	return res.a0;
> +}
> +

'params_ptr' may be renamed to 'params'.


[...]
> +#endif /* __ASM_RMI_CMDS_H */

Thanks,
Gavin


