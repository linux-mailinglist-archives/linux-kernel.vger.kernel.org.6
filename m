Return-Path: <linux-kernel+bounces-387967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BC9B5889
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2691C22B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94B11CA0;
	Wed, 30 Oct 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJAOdKba"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAF15E96
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247832; cv=none; b=h+Dn2YL9i1mvzkXX2GLbNloR1tug1xaq15L+5DNiv923y3nkDbxsSS0RC7taaZGl8YnIbUBEpenFLAoOZa8HFece6f3gt6XTfK92UgjHmOjgasDX1+3PMvdfZZ2yOJKN5Lltp5/uQUBwhBtZ/FJJkY2rD+X1q3S88Om2rf2WCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247832; c=relaxed/simple;
	bh=GHfETdSyjX6krjvZ1dZY7pSrOLnViSj7Ze1+c6iEIuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zeba7bryGK4o2F0KTnN/+UH7eVRLXhFAUERQYqK5r11tN6yEIMOUcRbP1/YpyaXKPwGLFAQFgKhYZyCvJA6gnW3vl9t+K5xlriLWRlTwZTuPz2Ox77zE6vr+JBFHno3GqTIN3L6tluALtth3L6P5FbRO/PEzDive+qmB4nfo4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJAOdKba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730247828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzjco5Yp88oO9yhhTyX9hZkpJ8eqlDl8kNCtlxrNZFY=;
	b=XJAOdKbafkjaw2lNJWsTYQI0PYx6W4lSO5VS1ShNP76yi82svZ5RMu8nJ+1fjXZqWRl3cj
	tLN+Kg6uX9vKVlivWAT+l/vGWN5nbv57eeuRRotp3VGg/BR2MO5fcZ4h4e5QEYBorZ6e+i
	eKq133r1zd/WPcAkV0R4laVZRfFc6ok=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-z0ZnbXe_PAes8HpY0Fu6jw-1; Tue, 29 Oct 2024 20:23:47 -0400
X-MC-Unique: z0ZnbXe_PAes8HpY0Fu6jw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e6c5fbebfso6557455b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247825; x=1730852625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzjco5Yp88oO9yhhTyX9hZkpJ8eqlDl8kNCtlxrNZFY=;
        b=QOC6Vk1CJcxksH7c6Cl0QeD+e67DRbeqU5j6piXhQKu4MjRKqdT+Zc+9SjxcalyTFE
         Je9s2ms7gpptpZPrcttbuxTJ7skfrtObj3bExXvFkuwbNJH8fpCkArKoWI5FiSXJvWdw
         fec1ZH3Q3dLA5BE9pJf2E5QEhOvJbaR7HuNcym2LAvIwiPHoZlDsqUqqrORHCskT5AN9
         U2yn7l/7WdpgBwMGnqqEyuYMV8GIDgoPLQ55n7jXRkJknKJSqM7do2xPmMsrD0zkFsc3
         FT8s2vmNX/n7H4vnVYexvt9Irp9ba8SHnNI9zcQ3tuDSfaopo0cDuQQoKKXLNbfztFXp
         5nKA==
X-Forwarded-Encrypted: i=1; AJvYcCXXhX0rsfLn62hn7vo7xSAsuBkGSK2s56Rap7eclfdT37DwQjzR7ZztxY5H5Gs39uzgGKw3i0CbDeIjfTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpPY1jua1CNeq0GBCuaYK3dXScn349T0of9EHsnlobg05uxKH
	KPRfOhuWK/ghB4wKTxRfkiaAOvKGcMpSgZGestnLWIpQ3YnSUNEeWgUPAHZ6yHbYD87E0f3cBxM
	8JyhDtwHD5kx4Me3Ped3RO8Gcvwkn1Gtyq1XYTDcDcpVZ0GCzmeXlu30iwJXl/fBG+WYDsruw
X-Received: by 2002:a05:6a00:2315:b0:71e:5f2c:c019 with SMTP id d2e1a72fcca58-72062fb2169mr19297953b3a.9.1730247825092;
        Tue, 29 Oct 2024 17:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDVeC+K/m1JudRIxQdtRApAx35LcqTPMPDCcyu4TrmSrIJs0qyIuUY63xL0+Wlk1AbrDcLww==
X-Received: by 2002:a05:6a00:2315:b0:71e:5f2c:c019 with SMTP id d2e1a72fcca58-72062fb2169mr19297927b3a.9.1730247824651;
        Tue, 29 Oct 2024 17:23:44 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3bd53sm8173830b3a.185.2024.10.29.17.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 17:23:44 -0700 (PDT)
Message-ID: <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
Date: Wed, 30 Oct 2024 10:23:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
To: Jeremy Linton <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, sami.mujawar@arm.com, linux-kernel@vger.kernel.org
References: <20241029141114.7207-1-jeremy.linton@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241029141114.7207-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On 10/30/24 12:11 AM, Jeremy Linton wrote:
> The TSM module provides both guest identification as well as
> attestation when a guest is run in CCA mode. Lets assure by creating a
> dummy platform device that the module is automatically loaded during
> boot. Once it is in place it can be used earlier in the boot process
> to say decrypt a LUKS rootfs.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/include/asm/rsi.h                    |  2 ++
>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
>   3 files changed, 24 insertions(+)
> 

I don't understand how the TSM module is automatically loaded and arm_cca_guest_init()
is triggered because of the newly introduced platform device. Could you please provide
more details? Apart from it, some nick-picks as below.

> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
> index 188cbb9b23f5..1b14a4c4257a 100644
> --- a/arch/arm64/include/asm/rsi.h
> +++ b/arch/arm64/include/asm/rsi.h
> @@ -10,6 +10,8 @@
>   #include <linux/jump_label.h>
>   #include <asm/rsi_cmds.h>
>   
> +#define ARMV9_RSI_PDEV_NAME "arm-cca-dev"
> +

Maybe 'ARMV9' can be avoided since RSI is the specific feature to ARMv9.
Besides, we already had @rsi_present there. So I would suggest to rename
it to RSI_PDEV_NAME

>   DECLARE_STATIC_KEY_FALSE(rsi_present);
>   
>   void __init arm64_rsi_init(void);
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 3031f25c32ef..ad963eb12921 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -8,6 +8,7 @@
>   #include <linux/psci.h>
>   #include <linux/swiotlb.h>
>   #include <linux/cc_platform.h>
> +#include <linux/platform_device.h>
>   
>   #include <asm/io.h>
>   #include <asm/mem_encrypt.h>
> @@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
>   	static_branch_enable(&rsi_present);
>   }
>   
> +static struct platform_device rsi_dev = {
> +	.name = ARMV9_RSI_PDEV_NAME,
> +	.id = -1
> +};
> +

         .id = PLATFORM_DEVID_NONE,

> +static int __init rsi_init(void)
> +{
> +	if (is_realm_world())
> +		if (platform_device_register(&rsi_dev))
> +			pr_err("failed to register rsi platform device");
> +	return 0;
> +}
> +

Those two checks can be connected with '&&' and '\n' seems missed in the
error message.

         if (is_realm_world() && platform_device_register(&rsi_dev))
             pr_err("Failed to register RSI platform device\n");

> +arch_initcall(rsi_init)
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> index 488153879ec9..e7ef3b83d5d9 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> @@ -6,6 +6,7 @@
>   #include <linux/arm-smccc.h>
>   #include <linux/cc_platform.h>
>   #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/smp.h>
>   #include <linux/tsm.h>
> @@ -219,6 +220,12 @@ static void __exit arm_cca_guest_exit(void)
>   }
>   module_exit(arm_cca_guest_exit);
>   
> +static const struct platform_device_id arm_cca_match[] = {
> +	{ ARMV9_RSI_PDEV_NAME, 0},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, arm_cca_match);


/* Comments here to explain why @arm_cca_dev_ids[] is needed */
static const struct platform_device_id arm_cca_dev_ids[] = {
        ...
};

MODULE_DEVICE_TABLE(platform, arm_cca_dev_ids);

>   MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>   MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>   MODULE_LICENSE("GPL");

Thanks,
Gavin


