Return-Path: <linux-kernel+bounces-192757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEB8D21AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B31C22958
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E3172BCE;
	Tue, 28 May 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7HyPM8L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E132F9D6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913993; cv=none; b=P5CfQwxsbRTcYqkQSZqWpSOjaTPCqw/zD0Wc5TW1GvPsAji3P8rLN7FnNY2ghpdaEOh79OnLjId3fRQbLS0I1XZUIPZkspTxT8chGpkSMWrR0v8G2/XY+tnN7aiRSKnsz9hce22ZpbabZg84f1QITE8pXe13IgIR6abwQ168VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913993; c=relaxed/simple;
	bh=Y3IeOlopAAI95IiEoENHSZ9iQzcKrxtetwlnH07VNeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1FqM1msMtiNIKtJe5zP/zvzL7Di8rJEW1qzkD323Prj5DRKBdc0FUzPPNjibt1NQLXES8rGLZ2XF5mk4MvC96LK1Lz3m/wvlscGFDQC8G9iEaEK+Q4JLPAoK2BBNpxdkrbbdheLlDsIrQI4dT31j6ozllD9oqMdQvpPL9Ip3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7HyPM8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716913990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o5rbBnotOGv3YE0/3Cgz+9VtslNbF6EOnYPi4Gp56T4=;
	b=E7HyPM8LPEDm1liW0ACk1ueIQvcBOLn/c/5Jz71KdGpHCTX6MDmPjestSG8bjhjavbNL4Y
	nYcXdDfMs0E+NlFZMblXW/HgYQ2OkQTZ5x+UCoWaXmtu15tomBJ4tHXLDpLa9bRwaFiI+M
	A6SauinsAxGRHic5gdN8tsE8OR4wRAM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-bAfIZ4bbPPe0MMAYKoBEVQ-1; Tue, 28 May 2024 12:33:08 -0400
X-MC-Unique: bAfIZ4bbPPe0MMAYKoBEVQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6266ffd474so59434866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913987; x=1717518787;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5rbBnotOGv3YE0/3Cgz+9VtslNbF6EOnYPi4Gp56T4=;
        b=ah43WcKduw+Gvp6IXQckEW6I/FfoT2hFpIvbttDbvr+sBQ2nvwIv44caAoYYSOm90/
         5qJPdY5/eK1A9Ji6Q0pUnAf31qPFeVTx034PJe99L9Zl3lSgvU9neasyYK18pBxjtF2v
         uRLrnFWLYFjbKrkmKsp5v7S4qOEcD5N87O3dvcCgTImZuvZQ8Wr5Z0YVZzZTrzCImmcn
         3NtKbt4b7t0+AlyOxO89fYV9D/ON1Jq7pSDtP7Q9k8B7nGLrF+2GpOSLWKgtZCpIO23v
         2W5l5DFvV62xya/gdLXcROy9/MjCHRDS3Fm1HCNU7A5W+7tTOa/G65FmEgKEA3Cb5hBO
         YGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHqMJMfr2Gta+xaiM/A0AsvenkmLbKs3qj2HdeycGa4lOilG9uHQdywnjQ1Vlyn3UJuXFrZ4GAavkqPBXCgruJN6Dhj4cWaRqTxFra
X-Gm-Message-State: AOJu0YwtRuzmpELZP235ZGWwp67P7a5k8wKpMXKUapQ55jxL2rETtaJD
	UcNnbW46Yt65gsnMvXDYopaptg+Uzl4h67B10nI0bLMWvHMgfnHj2BgEvoae01DqboeHqYEcl9R
	0dgwytxUNpGcVG1MWhJw6NpBHAtSlIRg7ntaze4PnN0kyxPfVV8XpawLvdDfGjA==
X-Received: by 2002:a17:906:3104:b0:a59:c23d:85ce with SMTP id a640c23a62f3a-a626511b0c9mr1278596966b.51.1716913987606;
        Tue, 28 May 2024 09:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomPpdyLhHHN2mbD5AC45hBSp7q69Ft30B3Cje2wT/LJg0L8j/hbtGHYBkpjl+hS2DfRqpBQ==
X-Received: by 2002:a17:906:3104:b0:a59:c23d:85ce with SMTP id a640c23a62f3a-a626511b0c9mr1278593566b.51.1716913987183;
        Tue, 28 May 2024 09:33:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a626c937716sm629352366b.51.2024.05.28.09.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:33:06 -0700 (PDT)
Message-ID: <9626063d-40ed-4caa-8ac5-ba2e88b6e398@redhat.com>
Date: Tue, 28 May 2024 18:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] KVM: SEV-ES: Disallow SEV-ES guests when
 X86_FEATURE_LBRV is absent
To: Ravi Bangoria <ravi.bangoria@amd.com>, seanjc@google.com,
 nikunj.dadhania@amd.com
Cc: thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 michael.roth@amd.com, pankaj.gupta@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com
References: <20240523121828.808-1-ravi.bangoria@amd.com>
 <20240523121828.808-3-ravi.bangoria@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240523121828.808-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 14:18, Ravi Bangoria wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 489b0183f37d..dcb5eb00a4f5 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5308,11 +5308,17 @@ static __init int svm_hardware_setup(void)
>   
>   	nrips = nrips && boot_cpu_has(X86_FEATURE_NRIPS);
>   
> +	if (lbrv) {
> +		if (!boot_cpu_has(X86_FEATURE_LBRV))
> +			lbrv = false;
> +		else
> +			pr_info("LBR virtualization supported\n");
> +	}
>   	/*
>   	 * Note, SEV setup consumes npt_enabled and enable_mmio_caching (which
>   	 * may be modified by svm_adjust_mmio_mask()), as well as nrips.
>   	 */

Since it consumes nrips, just make lbrv non-static:

/* enable/disable Next RIP Save */
int nrips = true;
module_param(nrips, int, 0444);

Paolo


