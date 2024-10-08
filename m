Return-Path: <linux-kernel+bounces-354326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C3993BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD87D1C24710
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4044EAD0;
	Tue,  8 Oct 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTSrsogS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DF8C1E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347482; cv=none; b=BTQ3wUQDZ2iCI6ctuBOONAXUcNcpGjTY+e+qnpe6gw65ZAH3cZwTYC0X5aOj0uElmoXOtZh+GkosvtT4emb6YHkUKxQHSV9vuNYWa4LvaaV9B01aOYNQ3odrZT/790DnsONLaebKd9/sG9GUyMBM64yUQ/Q0UUAMNU5D46Xvv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347482; c=relaxed/simple;
	bh=tbchR47/dXjjE+PvPFck7xaGHnvKhi2I53EICNbpweQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpARD5w+LXsZDoUI0bOZBnkS4C2Q3y7TFFdg6q/+6uiSnW6MQoj0bOVVkOfyFMrNvw2Ll4qIlYSyV5m5mruHu30aJpP1+/qTf5FNpHNhqEAqCjgRk622cxmoAps3bxSuHWL5GAVwVsf7OE8a7kvXtNKlGdEa1kxVNIqLH8PxPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTSrsogS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728347479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CIn7L4t98gFCcpAeot65WzEAFvBmvmwmESlA16rbdY=;
	b=iTSrsogSMw6au/JYnAgkuzzjozjtdRw0qEa+qXH4a4dEa4plqr5OCuxRrCOscWn+3XYsSF
	LIcdU6j90Gvtsi10XUbA94vx/tcq/KBeSc6kb6kcN9n9lmAr5i+KVQCLQnesovq5iZdnHO
	AZtd7E0VDoO22QSQvfl2yh/N37gKsQE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-r6E0WrO6Mf-7T42oZQ5vjw-1; Mon, 07 Oct 2024 20:31:17 -0400
X-MC-Unique: r6E0WrO6Mf-7T42oZQ5vjw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e06f5ec69cso5552973a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 17:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347477; x=1728952277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CIn7L4t98gFCcpAeot65WzEAFvBmvmwmESlA16rbdY=;
        b=OLXo6J17+sHJflIBeyQaTji9lgu2d1Pr0k3o84B69S9Kf8ZSLF3V7O0woAPddgp3n7
         iwDo0ppAG3mUGpJdv9QDzpb++0lb0w74j5WSDeo6UnxzfvlyhZhBbefczJFWIZ0aM5vY
         Qe72saVMD6DyX0bHaytSnMHJ4rPXN21uvBl5W0G1Qf5mjObJcNidTckgGrjlqgcDeq9n
         862aGlTNIIZdSDwiw3HRE3HN+9wv9gL8YsjKBlKB1pV5f+05r5nVjbSLQrBXFFm9i1h6
         dytHDboWBMKOIyrLZ92hjAcTw8jrW4WMHZOk5JTQr3njDFX+zmOdWUGcDpsKYv5c0iw1
         4PPA==
X-Forwarded-Encrypted: i=1; AJvYcCUawgqrespr+iKBfcCSdFeuWORZh3LHjXIXScFr29+EPn0aeQJGXMR4GlSJjehpeIBQcV/j9U/5FZjWHKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGzoIR6ogWLHjaA85F8/m4B3LkZ+5HdZ4rlKgBUFolCrnC0D/
	TgVSUTOFi3TDtWWOzfyTvG9FHVtn+mfpD2PUoRrzDE2kTpDezdxZtAll7RpbFt4Sy2VP4zUJx5F
	pcLJgFVq2WWZmDvJq78x4mEKNSQsdnlkJoXCnircALKJvkKTt2bIUnUawg36Fmg==
X-Received: by 2002:a17:90a:db8d:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2e27dd46589mr2313518a91.4.1728347476904;
        Mon, 07 Oct 2024 17:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5g/BMfTrnv3FT9lAmYAR1aeLFXOfl3JqwydJK0b/zrgK05aYoww94UM4wvonucrKKC1IEwA==
X-Received: by 2002:a17:90a:db8d:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2e27dd46589mr2313484a91.4.1728347476546;
        Mon, 07 Oct 2024 17:31:16 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20aebf399sm6231462a91.17.2024.10.07.17.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 17:31:15 -0700 (PDT)
Message-ID: <e21481a9-3e36-4a5d-9428-0f5ef8083676@redhat.com>
Date: Tue, 8 Oct 2024 10:31:06 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] arm64: rsi: Map unprotected MMIO as decrypted
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
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-6-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241004144307.66199-6-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 12:43 AM, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Instead of marking every MMIO as shared, check if the given region is
> "Protected" and apply the permissions accordingly.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> New patch for v5
> ---
>   arch/arm64/kernel/rsi.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 

With the following potential issue addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index d7bba4cee627..f1add76f89ce 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -6,6 +6,8 @@
>   #include <linux/jump_label.h>
>   #include <linux/memblock.h>
>   #include <linux/psci.h>
> +
> +#include <asm/io.h>
>   #include <asm/rsi.h>
>   
>   struct realm_config config;
> @@ -92,6 +94,16 @@ bool arm64_is_protected_mmio(phys_addr_t base, size_t size)
>   }
>   EXPORT_SYMBOL(arm64_is_protected_mmio);
>   
> +static int realm_ioremap_hook(phys_addr_t phys, size_t size, pgprot_t *prot)
> +{
> +	if (arm64_is_protected_mmio(phys, size))
> +		*prot = pgprot_encrypted(*prot);
> +	else
> +		*prot = pgprot_decrypted(*prot);
> +
> +	return 0;
> +}
> +

We probably need arm64_is_mmio_private() here, meaning arm64_is_protected_mmio() isn't
sufficient to avoid invoking SMCCC call SMC_RSI_IPA_STATE_GET in a regular guest where
realm capability isn't present.

>   void __init arm64_rsi_init(void)
>   {
>   	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_SMC)
> @@ -102,6 +114,9 @@ void __init arm64_rsi_init(void)
>   		return;
>   	prot_ns_shared = BIT(config.ipa_bits - 1);
>   
> +	if (arm64_ioremap_prot_hook_register(realm_ioremap_hook))
> +		return;
> +
>   	arm64_rsi_setup_memory();
>   
>   	static_branch_enable(&rsi_present);

Thanks,
Gavin


