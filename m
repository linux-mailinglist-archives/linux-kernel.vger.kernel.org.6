Return-Path: <linux-kernel+bounces-393566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C004D9BA267
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004F01C20B0D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C51AA7AB;
	Sat,  2 Nov 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KUE4E6J6"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE554EB50
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578689; cv=none; b=ElxVqihZIDUeC1pyd715K8uQUk5JgB+S9LmqxC0Yuq1s96t0PLjakSRJrXIz7fEcI9ctqrrVvxgtGPjtrMvoOzP539kVIu7vJV+3GIKFpeD3MXSemkTi2Lnf2bFHslEnC/Tu9nMIhmTn2YG4FaLr+pBCL4OCpbAyZHkg4qSZmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578689; c=relaxed/simple;
	bh=pfu4WC958or0l++WDyoyo0Va13J5EJ8ud60SL6edK24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MV+zdC7XYwdoyuvQuDgFvoqpUXnhwe6cENxi44F3ZY8LK4Rdhqm6axsBdilGv/gki/cs3SGWjYg6NX5WcrwoluvHZS/xnE6vA9DaVkjPxLRwknzSm+LSAqfurHK0RHXFCFFP6i+4ABogt9/RnUqJWBHrSq5fXiV4OuQ6YxcXQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KUE4E6J6; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso125886439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730578687; x=1731183487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uv6c+k0dm8ixfMK+kRUbChJ5vy9Z65ImLeSVIElSlFk=;
        b=KUE4E6J6+9dJpVpONZ0HeD9BsMTMpGIcGZELD2p64CSUNfzsX7vkVt+FSXnKk5azll
         850j7cNzT0nPmR378n2qegK8Ie8Q30vgEvvafjzdjEci3ODG5eJuDfz+jo5w1C2JhZL1
         fYpikLcSolgfg3hGxUss4v/xzr99Z1xMjj9uJ4Dx3EVpgXH97TR3uUU0bM4zWhu8eaEO
         RnElrD3l1+TOSBFZryeUz+RwZO8fVtBIv58xwDm+zlPcv969FWNbdOWUFAZ8eBZAmz79
         e1BLwkjH7CSEbxaEQaP71dgwa6u0IQDvHeyRV+OdylVGu/4JaqNn2JQ9zBbDt4qTIBXc
         oRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730578687; x=1731183487;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv6c+k0dm8ixfMK+kRUbChJ5vy9Z65ImLeSVIElSlFk=;
        b=TukTkv2DmSlrxy34TffRSjewniVc8vmk7uuAa/2CiWGxFYrLM/1/a+9PAP0980piDq
         9mpUTPQWJSYJVqGrxWMt8nJWJA6d7R43lSW8XJgnwu+OZH4tBpQIS0dPgFEm0I8nI21/
         LCOX3H++SJdbe+9zMge2ClX5VjluAS3VGZeP8QSmRttxRQZrB7l6nfi6vmdbMY7MJPZ4
         cB7GExyzVSVUXRSIZUkIO869Mg7Awbn0iiuTQGUHRnFlXYzxyWZ6LVKo1NQT3DFLDFdd
         D9Xe2ZAPviezLUjmZo6jJBJ3akhUP3vxg+qePakHHCqL38oJG9UbF0Xjq0Hz7ihpcM5T
         875Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXAo2NHesOB7XD4LIvE3a9xB1aYXafktkW/PTUbHunW/B0fD4tJjvuiLG0rqMYOE/c8Zjo/BZND5pFYrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRVbCECfwWRx1kWsiLGRYhOOxBNRgbNckSmbbtTsw+w4P0usx
	pzRAZ5ZFyZvcOB3ecuvz0QBYeZ4wAdcQrXG5EJiJt7qXsCutxyEpQYD/x62c1vE=
X-Google-Smtp-Source: AGHT+IEJc+EiNFpj9B5V/ByTf51tnyN0Vtl+t+p6pQirqCmqUqbkma3bOQA4lF2nU6yG6Loqga/zcQ==
X-Received: by 2002:a05:6602:2d8d:b0:83a:97e7:8bcf with SMTP id ca18e2360f4ac-83b5676f6c7mr1760042139f.11.1730578687159;
        Sat, 02 Nov 2024 13:18:07 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de0497794asm1274337173.88.2024.11.02.13.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 13:18:06 -0700 (PDT)
Message-ID: <9617eb4f-842d-4678-926e-478471de479b@sifive.com>
Date: Sat, 2 Nov 2024 15:18:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] RISC-V: separate Zbb optimisations requiring and
 not requiring toolchain support
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, xiao.w.wang@intel.com,
 Andrew Jones <ajones@ventanamicro.com>, pulehui@huawei.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20241024-aspire-rectify-9982da6943e5@spud>
 <20241024-chump-freebase-d26b6d81af33@spud>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20241024-chump-freebase-d26b6d81af33@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-24 5:19 AM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> It seems a bit ridiculous to require toolchain support for BPF to
> assemble Zbb instructions, so move the dependency on toolchain support
> for Zbb optimisations out of the Kconfig option and to the callsites.
> 
> Zbb support has always depended on alternatives, so while adjusting the
> config options guarding optimisations, remove any checks for
> whether or not alternatives are enabled.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig                    |  4 ++--
>  arch/riscv/include/asm/arch_hweight.h |  6 +++---
>  arch/riscv/include/asm/bitops.h       |  4 ++--
>  arch/riscv/include/asm/checksum.h     |  3 +--
>  arch/riscv/lib/csum.c                 | 21 +++------------------
>  arch/riscv/lib/strcmp.S               |  5 +++--
>  arch/riscv/lib/strlen.S               |  5 +++--
>  arch/riscv/lib/strncmp.S              |  5 +++--
>  8 files changed, 20 insertions(+), 33 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


