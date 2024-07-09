Return-Path: <linux-kernel+bounces-245182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBDC92AF62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A33B2107E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699D12D75A;
	Tue,  9 Jul 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyTOuwZY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A25139F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502358; cv=none; b=LFgRJGIQOsgkDeDMcjKNSsr4Kk5p+XLh1EeVPzMBmscC/IG1+vrqPmVFLRKIeYjVFXGx2Mhar+z2k1vRwp3k6kqFa3nZjc1WUTRF6XyWDW8xR+0f/6kembEdfC00alxw1xptXyV47s94xlm7CYD7qJSrP2bciAskAR3pKOjImZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502358; c=relaxed/simple;
	bh=kxxZ4GZi+K29+wA/0D4vq8njOFzYZ2ku8FWTAgcRy2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q275aBjrQNIR3uOead3qSAtbp8BeRedpjh0IOtpKbkcquODoX01z41d9QEAwrVE6adaReIDXEA/ILbf3bYGs1Vr2aQYWoC/20b9tvTvCNVQ9BAIBUObFyMziYrAfOG+BlbO1tjzh0qPaBu22ZrLCwKFnTXUc6nmtKZRNfbI80pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyTOuwZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720502355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NO3dhCc2LGOp3hm3fp51cTnn6RCFGh5hrEz11I777E=;
	b=fyTOuwZY/QM/JV9upN6Hw3tabojJJMZAzJtk9/JcZAUFhjbx6NNTJP5QUcyjAMeZTWUx9E
	IMjl8XJpJ72FcQ7AyRWToqR/j0/625fhG+0uoUJYqHNXMyV+6SCTxg0gfAFNm2xb4050Jf
	XP/+w97y212tK0EZc74GoGendNjRM5w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-qAQakBicM5e3GIy9omGURw-1; Tue, 09 Jul 2024 01:19:14 -0400
X-MC-Unique: qAQakBicM5e3GIy9omGURw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fb4e7cc5d5so16557535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 22:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502353; x=1721107153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NO3dhCc2LGOp3hm3fp51cTnn6RCFGh5hrEz11I777E=;
        b=IsxXC77/ZlJ6T8XU6dx9suc6k40D6PqhcOWMf98rw/vupcX/E7h3dG6tTfGj+2g+uH
         CIdb6iR0Lu19VxdS3DEdFg/Ysa0dHGxhOcfECtyjbuZMO+n95NYoLYWjXtFGQhfdW1S5
         5iUNR9ktn6vMfoB6birq4Khba7kZ7hNBt44YnsyFKVQtNz83vuLqQIPPGEMrE4N7uKOC
         B6FgozUhE+g5PkqqONdaFmJNML95yUdCW8NsaOHoS2WGH3OjoJvGVUyjCgL3PH90ZKKn
         SrPbKWFGVagIG/hpKraSde/o7+QvaEIdxgCn2AuxVgber4kHRaBFAUl8yQ+8lMGFJFEh
         tn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUMi2KA54nryt285FrsU2fIi1CmntrL5/9ymPnBndmGUNN7qjhxJKI8pzdoBtXjjFWP3FPV1lHkCJ6SvHlTR+pgzp3d8IAQGs/DGkmc
X-Gm-Message-State: AOJu0YxW25rm/OTSnz0+K10ax7boxR1wvg10pXxPRFuY1xhz+cplz2Aa
	1uHq2k69E1H2jlbPvWGiGb3aHq43Qs//K/Df+nvft4Qm6uppTbTOUyPBXg53c+guxZlqvu1TGWs
	BN3FYTaFP98mB8TZpePVnAw2KflliyL63RrMX7KLYZB6owwLKKvkDsCVZvOMSnQ==
X-Received: by 2002:a17:902:ced2:b0:1fb:6ea1:4c with SMTP id d9443c01a7336-1fbb6d3d631mr11099505ad.23.1720502352945;
        Mon, 08 Jul 2024 22:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVXcKv//QUkd2zalk0KVeKlO2V4LMxD2AA7tVtpYgxucEKRW687wZfsonrs0t+riLdK1vzA==
X-Received: by 2002:a17:902:ced2:b0:1fb:6ea1:4c with SMTP id d9443c01a7336-1fbb6d3d631mr11099335ad.23.1720502352511;
        Mon, 08 Jul 2024 22:19:12 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a28f83sm7276275ad.72.2024.07.08.22.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 22:19:11 -0700 (PDT)
Message-ID: <3b1c8387-f40f-4841-b2b3-9e4dc1e35efc@redhat.com>
Date: Tue, 9 Jul 2024 15:19:03 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] arm64: rsi: Add RSI definitions
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
References: <20240701095505.165383-1-steven.price@arm.com>
 <20240701095505.165383-2-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240701095505.165383-2-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 7:54 PM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The RMM (Realm Management Monitor) provides functionality that can be
> accessed by a realm guest through SMC (Realm Services Interface) calls.
> 
> The SMC definitions are based on DEN0137[1] version A-eac5.
> 
> [1] https://developer.arm.com/documentation/den0137/latest
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v3:
>   * Drop invoke_rsi_fn_smc_with_res() function and call arm_smccc_smc()
>     directly instead.
>   * Rename header guard in rsi_smc.h to be consistent.
> Changes since v2:
>   * Rename rsi_get_version() to rsi_request_version()
>   * Fix size/alignment of struct realm_config
> ---
>   arch/arm64/include/asm/rsi_cmds.h |  38 ++++++++
>   arch/arm64/include/asm/rsi_smc.h  | 142 ++++++++++++++++++++++++++++++
>   2 files changed, 180 insertions(+)
>   create mode 100644 arch/arm64/include/asm/rsi_cmds.h
>   create mode 100644 arch/arm64/include/asm/rsi_smc.h
> 

[...]

> --- /dev/null
> +++ b/arch/arm64/include/asm/rsi_smc.h
> @@ -0,0 +1,142 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#ifndef __ASM_RSI_SMC_H_
> +#define __ASM_RSI_SMC_H_
> +
> +/*
> + * This file describes the Realm Services Interface (RSI) Application Binary
> + * Interface (ABI) for SMC calls made from within the Realm to the RMM and
> + * serviced by the RMM.
> + */
> +
> +#define SMC_RSI_CALL_BASE		0xC4000000
> +

These fields have been defined in include/linux/arm-smccc.h. Those definitions
can be reused. Otherwise, it's not obvious to reader what does 0xC4000000 represent.

#define SMC_RSI_CALL_BASE	((ARM_SMCCC_FAST_CALL << ARM_SMCCC_TYPE_SHIFT)   | \
                                  (ARM_SMCCC_SMC_64 << ARM_SMCCC_CALL_CONV_SHIFT) | \
                                  (ARM_SMCCC_OWNER_STANDARD << ARM_SMCCC_OWNER_SHIFT))

or

#define SMC_RSI_CALL_BASE       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,            \
                                                    ARM_SMCCC_SMC_64,               \
                                                    ARM_SMCCC_OWNER_STANDARD,       \
                                                    0)

Thanks,
Gavin


