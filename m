Return-Path: <linux-kernel+bounces-543249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3828A4D335
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348FD3AA7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5021F463B;
	Tue,  4 Mar 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRxl63Yh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3731F3FCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068090; cv=none; b=lGa6xssYLfsfxzstnkdznIKbipcQnia8iAeXYNWdGm7RANvG3CNXxmj8d7GNaX5+RwDzD4rF0TsaaZo1djoqWJqa5QxcB9AbbJC3O++RoCrjTuTmvNsg9TR27N72CJHGqSWnFhcFWHwrqtkX2nlRtVhpN8iJArxj1icki8bmXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068090; c=relaxed/simple;
	bh=eL87BOoGzXVDBj2SXPjQdFK+ZlB7bcDHzO1QoGp1gFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTM978ubw6YfkF9+Cd23cH3cBNRDwP5f9Cn5/2rvrOHxIt9Alt33oqsdwdGhR2cLRs+J97Ue1q+rnKup83k5rrva1TKseZsLcF+QY4A8uSu8nFPZUZng+0jwGq3eWXLr/zDNG7mh8oVhYdIdEhkUTXEhcM/iTmAW+NMvgYo8uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRxl63Yh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741068088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boHxbjq3P2vU0fO6UUb8Hfrkk8ida9vHUjKzaMq4o5k=;
	b=hRxl63YhH3cWq5wtgOcWS0xmKRfWoVP4s3YnHbChoSFQx2YGDQQ4doLP2DIFvUn+DB8rLh
	Vjl+z+pG7i2W+m0ec6sYJuTJRuOKxcg6kMOTX5FA+IvbhMVuv/j41JTWF+zu/wyfS5gffZ
	En7Eem8DZqG2tDduQLzNIlwGiAhh/v4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-V29-XvmSMVuufPDzU9xHIw-1; Tue, 04 Mar 2025 01:01:26 -0500
X-MC-Unique: V29-XvmSMVuufPDzU9xHIw-1
X-Mimecast-MFC-AGG-ID: V29-XvmSMVuufPDzU9xHIw_1741068085
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223d86b4df0so18018275ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 22:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068085; x=1741672885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boHxbjq3P2vU0fO6UUb8Hfrkk8ida9vHUjKzaMq4o5k=;
        b=mJpc79BcB+vFTZxRCatSjKIzvZeGUm29UnRpXXWjFPcy7Oe67KpWyV0/juhZBmxO7U
         KzQfHq2IeIu2KUP59uEDMHc4NigL2708AI8gvSx8ikohUpVHFXfeo/mmyRiizAd3VuOy
         GlxC07Mi/8BmiqXWJXqT5+/IGD8GhpzPlEQLO50sAwUfuoQmWMv+svjhno1zj/HQaNoK
         W4FZ/LIVhaYr/d6tWBiw2L3/ML0erR1w2mRe4EjjQQtVJ3Q2BntgrEwWFDYpFlB68TiQ
         IpSdGfq+u39zy/1o4wGjbJl660oxnCOpXE/6NE9yo5JnDibDRroePI1rRyHXbhUdRyor
         lKfg==
X-Forwarded-Encrypted: i=1; AJvYcCWpGT+kYeigVOe6OfOOTn/Io9BqEm2sL+62UCuwuU13fKZ641SDj+lljbX/xkCnBK07yOs33q3ZpsL23M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyaeCGfziNinOZFSlFcs1Rwj5JieHrAN4+SH/GksA51RPuPFFq
	tim24M1iyvO4J0rWv+gVO4QG+Ht+qLhTreeUbmuR7+W9bJ1dnPAU+8ailrPlsRlYRAUd8bgV2al
	OdIoy9K2MfxC5aFIMGNvoZbbHsnD8Dgr9Nvc/r85HN+SAzx1oCjlnggGwnoo+Eg==
X-Gm-Gg: ASbGncspuepSuk+yFkhhAha0zmyhaSvRI7thV0KK2GjtXIkV6MD0x6oUQTUU6Nh5Z8H
	t5ZEHZ7WSXQiJxMhVHku743sy9O982dsQOn4caS0aglUqy3Msd5EFbXAatpEcCDeQk/c+KD+s9o
	wT6gAeXtDnMo5PCOQDMIphtDjSMG8oKGHxtAd7D8IEWUrwAMOfottVeY+PXY/q4w2VddjQ1KdeD
	mcU/2pjn9mfMnX3P7+HofSz/eoKGCUAg8fcz6kZPutxtTHpwd/5ofjf5IrKhgwjC5zwcCkDlTp1
	jnypyVmjNHowWbrTxA==
X-Received: by 2002:a17:902:d543:b0:210:f706:dc4b with SMTP id d9443c01a7336-22368f8901emr239972405ad.13.1741068085383;
        Mon, 03 Mar 2025 22:01:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHElCuS6yRgRylUHMYlinoo6CRmRHfyntq1vELw6NqviCnDfsX3HH8S1d66GYPIYgVFC5KeFg==
X-Received: by 2002:a17:902:d543:b0:210:f706:dc4b with SMTP id d9443c01a7336-22368f8901emr239972065ad.13.1741068085037;
        Mon, 03 Mar 2025 22:01:25 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc6desm87837665ad.168.2025.03.03.22.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:01:24 -0800 (PST)
Message-ID: <12b5ba41-4b1e-4876-9796-d1d6bb344015@redhat.com>
Date: Tue, 4 Mar 2025 16:01:16 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/45] arm64: rme: support RSI_HOST_CALL
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Joey Gouly <joey.gouly@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-29-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-29-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> From: Joey Gouly <joey.gouly@arm.com>
> 
> Forward RSI_HOST_CALLS to KVM's HVC handler.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v4:
>   * Setting GPRS is now done by kvm_rec_enter() rather than
>     rec_exit_host_call() (see previous patch - arm64: RME: Handle realm
>     enter/exit). This fixes a bug where the registers set by user space
>     were being ignored.
> ---
>   arch/arm64/kvm/rme-exit.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/kvm/rme-exit.c b/arch/arm64/kvm/rme-exit.c
> index c785005f821f..4f7602aa3c6c 100644
> --- a/arch/arm64/kvm/rme-exit.c
> +++ b/arch/arm64/kvm/rme-exit.c
> @@ -107,6 +107,26 @@ static int rec_exit_ripas_change(struct kvm_vcpu *vcpu)
>   	return -EFAULT;
>   }
>   
> +static int rec_exit_host_call(struct kvm_vcpu *vcpu)
> +{
> +	int ret, i;
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +
> +	vcpu->stat.hvc_exit_stat++;
> +
> +	for (i = 0; i < REC_RUN_GPRS; i++)
> +		vcpu_set_reg(vcpu, i, rec->run->exit.gprs[i]);
> +
> +	ret = kvm_smccc_call_handler(vcpu);
> +
> +	if (ret < 0) {
> +		vcpu_set_reg(vcpu, 0, ~0UL);
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> +

I don't understand how a negative error can be returned from kvm_smccc_call_handler().
Besides, SMCCC_RET_NOT_SUPPORTED has been set to GPR[0 - 3] if the request can't be
supported. Why we need to set GPR[0] to ~0UL, which corresponds to SMCCC_RET_NOT_SUPPORTED
if I'm correct. I guess change log or a comment to explain the questions would be
nice.

>   static void update_arch_timer_irq_lines(struct kvm_vcpu *vcpu)
>   {
>   	struct realm_rec *rec = &vcpu->arch.rec;
> @@ -168,6 +188,8 @@ int handle_rec_exit(struct kvm_vcpu *vcpu, int rec_run_ret)
>   		return rec_exit_psci(vcpu);
>   	case RMI_EXIT_RIPAS_CHANGE:
>   		return rec_exit_ripas_change(vcpu);
> +	case RMI_EXIT_HOST_CALL:
> +		return rec_exit_host_call(vcpu);
>   	}
>   
>   	kvm_pr_unimpl("Unsupported exit reason: %u\n",

Thanks,
Gavin


