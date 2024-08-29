Return-Path: <linux-kernel+bounces-307079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D596479B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10F21F24413
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680F1AED2B;
	Thu, 29 Aug 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z400QnWl"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151E1AE846;
	Thu, 29 Aug 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940422; cv=none; b=oL4sNNVwgGLr5hi5cwjflshJB8xlwmBKyvdhul9tTJktc4s9fjxq3VgLu1+HjsiyHmeelMhSiZMHkE3lTzTRAA1cg5NkEGblzWwc2RgyRcdNMmxWuetHkSeLrW9SdFfUC/RC1SOFbzZ4rwGkBLxUsVlCPs4T8cHk8BhVN3y9Sos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940422; c=relaxed/simple;
	bh=Dnc97RZIVh4Cs30Qnu+fHSGTdzuC4rmOQI0ZaXzgC7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg/pLHN4FVbV7viIfBud9zQDjgPnZxaUcNiOQNbwiMIrHKjXhcGzo0GzgjM/2qYykChc1V9NHGIL7rPCWea0C2zqnThaiu4kavUi6UwLwk+scX9UbnpSlycYcb+BHy7F78i0eHdiCZI8YJnlgkouCBrh2LUWqEA2QnHjFeB3lYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z400QnWl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7142e002aceso575596b3a.2;
        Thu, 29 Aug 2024 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724940421; x=1725545221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iK1IVOMJIxyZnFgv4BStIpf1YlI4C67hPRkMhKa7i/g=;
        b=Z400QnWlTcuha2HuzdoMffJXpysUx0OY/fWAl5Zm+dV19b2OZW/e2JY7HhfRAmlWDp
         YJ5fQ3faFu0ovLOCL8nfRKHFl61sKfZLNQcC8pI4rgVg6h+R9lDwSBioXH0Eo2FisKLS
         XeEVIJ4G3qW3RziJmEugzfbRmY58W8sYZ1hVLwvqKP/6BDRir3Rw//gA199Lu/aQsYJz
         3jESmTc5xxw+yXh5js9vaqrch6lSRlNWfpXo4iBIB0VottC9sLIdrzpsB346KiXof14d
         PJPPjhJMXeLwvwLjTP17/+uu/t2JLljGDpcfR6dqpqbsD4W2PtUGoHd3QPoWhufe8SQC
         QqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724940421; x=1725545221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iK1IVOMJIxyZnFgv4BStIpf1YlI4C67hPRkMhKa7i/g=;
        b=SJmGc57NfJgXl/qt34Dg0A2uMFpDPY1tLGe6R5IQOBGgSv//vtmSWq5kDk6gDkDP/3
         S+3d/0/3ZQOOoSYo3Eclz4H7cDV9Wgbf5eJwHH92zWXja3bKui+5gQbeenhQxbCytGUr
         idcVBUJBlCPxX8GIjI68apgjGQ4434nzd8iqlmax6n7/Zts2SJYdpQKHeiYkNsc4RRsF
         8CjfXoc60Lx0foKdJ5urLjn+GwmwDOWHqhudDWKyFYyoUvAhFmyZroEp+t6nlpebu2qB
         dd+Fzir+nS6jh4qXLY3LG4bGqeQ8O/UstPFhHgBFJ9njxvVbLlOOCD+UIgjLz0pEzQer
         X2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSqcvwFDz9pSv9ru5YjNmvjl0u/6ndIga8H6ydo3dVlIBp6ouoWKx03IzPd9kaKa/KnyCIGRGcqv0@vger.kernel.org, AJvYcCWMYGa7M8zYpuMDKfUlvzDN4Tvh6hzfonY3z+ALoKWu7nVMjfz5q4ukaq4Ud16GfSNdbwO7TOGLycaimby5@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzCLw1VYY/MEnamulIV/hIns8tfXCH/hOlmWbQT/B7Uas3VqT
	qjDKY+AajLPb+ObxOVabcaCFHyIpBI00e77Mdwb5LUjn/tgYWv4jemDBFKLHHMc=
X-Google-Smtp-Source: AGHT+IG2CyT+7KwKUd+VOi3UxpXYONelmRV4w2rkII4YQ8l9bIrb2V+UgLmErP8YyjI2/5thiSzKwQ==
X-Received: by 2002:a05:6a00:1798:b0:70e:91ca:32ab with SMTP id d2e1a72fcca58-715dfaea829mr3436412b3a.6.1724940420644;
        Thu, 29 Aug 2024 07:07:00 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55b9c4esm1192104b3a.92.2024.08.29.07.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 07:07:00 -0700 (PDT)
Message-ID: <e6377027-c4e5-4fd2-abf4-63cf6282542d@gmail.com>
Date: Thu, 29 Aug 2024 22:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/3] irqchip/apple-aic: Add a new "Global fast IPIs
 only" feature level
Content-Language: en-MW
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
References: <20240829110436.46052-1-towinchenmi@gmail.com>
 <20240829110436.46052-4-towinchenmi@gmail.com>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240829110436.46052-4-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/8/2024 19:02, Nick Chan wrote:
> Starting with the A11 (T8015) SoC, Apple began using arm64 sysregs for
> fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
> as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.
> 
> Add a new feature level, used by the compatible "apple,t8015-aic",
> controlled by a static branch key named use_local_fast_ipi. When
> use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
> but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
> "global" IPIs.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/irqchip/irq-apple-aic.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 626aaeafa96c..1640074af2e1 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -236,6 +236,8 @@ enum fiq_hwirq {
>  
>  /* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11+) */
>  static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
> +/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists (M1+) */
> +static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
>  
>  struct aic_info {
>  	int version;
> @@ -253,6 +255,7 @@ struct aic_info {
>  
>  	/* Features */
>  	bool fast_ipi;
> +	bool local_fast_ipi;
>  };
>  
>  static const struct aic_info aic1_info __initconst = {
> @@ -271,6 +274,16 @@ static const struct aic_info aic1_fipi_info __initconst = {
>  	.fast_ipi	= true,
>  };
>  
> +static const struct aic_info aic1_local_fipi_info __initconst = {
> +	.version	= 1,
> +
> +	.event		= AIC_EVENT,
> +	.target_cpu	= AIC_TARGET_CPU,
> +
> +	.fast_ipi	= true,
> +	.local_fast_ipi = true,
> +};
> +
>  static const struct aic_info aic2_info __initconst = {
This patch is incorrectly disabling local fast IPI on aic2, it will be
corrected in v2.

>  	.version	= 2,
>  
> @@ -282,6 +295,10 @@ static const struct aic_info aic2_info __initconst = {
>  static const struct of_device_id aic_info_match[] = {
>  	{
>  		.compatible = "apple,t8103-aic",
> +		.data = &aic1_local_fipi_info,
> +	},
> +	{
> +		.compatible = "apple,t8015-aic",
>  		.data = &aic1_fipi_info,
>  	},
>  	{
> @@ -748,7 +765,8 @@ static void aic_ipi_send_fast(int cpu)
>  	u64 cluster = MPIDR_CLUSTER(mpidr);
>  	u64 idx = MPIDR_CPU(mpidr);
>  
> -	if (MPIDR_CLUSTER(my_mpidr) == cluster)
> +	if (static_branch_likely(&use_local_fast_ipi) &&
> +	    MPIDR_CLUSTER(my_mpidr) == cluster)
>  		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
>  			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
>  	else
> @@ -992,6 +1010,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
>  	else
>  		static_branch_disable(&use_fast_ipi);
>  
> +	if (irqc->info.local_fast_ipi)
> +		static_branch_enable(&use_local_fast_ipi);
> +	else
> +		static_branch_disable(&use_local_fast_ipi);
> +
>  	irqc->info.die_stride = off - start_off;
>  
>  	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),

Nick Chan

