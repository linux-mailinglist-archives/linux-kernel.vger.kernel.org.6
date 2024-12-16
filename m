Return-Path: <linux-kernel+bounces-447055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5D9F2CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C0188A6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0F200BB9;
	Mon, 16 Dec 2024 09:15:11 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E46200BB3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340511; cv=none; b=GwMWVl45wPBEpPzNGlq72oJsVohOY8ry+v3MekfkB6Ubg6720YHQkn+l9ZkhSvuDPYBmHisv4gHILU59Pjl/88/gIpf2xCTTsgWQG8kGrcwrxBGZsOM66xUU5fTue7tl9Cr2GsPG0Y9M8U7umw6XqhVLQ3ZNCDrXyEeEYKSRsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340511; c=relaxed/simple;
	bh=CCa+OYkYsQANC8hKGEJB2Q1uclZYuJMdk95TIj6d534=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTJ5D3wAN9lNtNGh1Q6eKUfUYSo4U/co/297xIARhM21CSMG9YwAkv7/04nyMXT8Anx34zdyAyGOC6kdMcw6tSR9AwBHyI58+P5TsypfGYd7vn70j3x/BObFN6J3oFS8H0ElMIfpNXL/jKtLaS8qJuU8uFtj11ohh7Kw1fenQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96E66C0006;
	Mon, 16 Dec 2024 09:14:58 +0000 (UTC)
Message-ID: <330c7596-cd93-4ae5-b00d-789c72a944aa@ghiti.fr>
Date: Mon, 16 Dec 2024 10:14:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add riscv_force_qspinlock for early_param
Content-Language: en-US
To: guoren@kernel.org, conor@kernel.org, alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com,
 leobras@redhat.com, peterz@infradead.org, parri.andrea@gmail.com,
 longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de, will@kernel.org,
 corbet@lwn.net, Guo Ren <guoren@linux.alibaba.com>
References: <20241214043510.3795984-1-guoren@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241214043510.3795984-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 14/12/2024 05:35, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit qspinlock
> force enabled. See the Kconfig entry for RISCV_COMBO_SPINLOCKS.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>   arch/riscv/kernel/setup.c                       | 13 ++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3872bc6ec49d..43d0df2922b2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5887,6 +5887,11 @@
>   			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>   			CPUs.
>   
> +	riscv_force_qspinlock [RISCV, EARLY]
> +			When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit
> +			qspinlock force enabled. See the Kconfig entry for
> +			RISCV_COMBO_SPINLOCKS.
> +
>   	riscv_isa_fallback [RISCV,EARLY]
>   			When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
>   			falling back to detecting extension support by parsing
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 45010e71df86..74b13bc64c9c 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -247,6 +247,15 @@ static void __init parse_dtb(void)
>   #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
>   DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>   EXPORT_SYMBOL(qspinlock_key);
> +
> +static bool force_qspinlock;
> +
> +static int __init riscv_force_qspinlock(char *p)
> +{
> +	force_qspinlock = true;
> +	return 0;
> +}
> +early_param("riscv_force_qspinlock", riscv_force_qspinlock);
>   #endif
>   
>   static void __init riscv_spinlock_init(void)
> @@ -267,7 +276,9 @@ static void __init riscv_spinlock_init(void)
>   		using_ext = "using Ziccrse";
>   	}
>   #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> -	else {
> +	else if (force_qspinlock) {
> +		using_ext = "force";
> +	} else {
>   		static_branch_disable(&qspinlock_key);
>   		pr_info("Ticket spinlock: enabled\n");
>   		return;


What's the use case for this early param? To me that implies that a 
platform may have another extension which would allow the usage of 
qspinlock, so why not listing it in riscv_spinlock_init() instead?

Thanks,

Alex


