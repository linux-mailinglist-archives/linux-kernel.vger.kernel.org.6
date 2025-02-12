Return-Path: <linux-kernel+bounces-510352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2644A31B94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4022F3A2C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEC4137932;
	Wed, 12 Feb 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DC407ej1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC36F30C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325270; cv=none; b=XK+tHy+OtFHTsyBOH0GA9LPriqfiG6hvFTDsselZJ8L9etaIVI8CxwymsVr+LnPjgoA68L/bXff5sVWPHiSmI2UMcOsg487+zIwhVmImZ4A07GeqTEEFTZXy8yaOh66yOM++Z2/UzR0XgOyVFl30SYDD+FOcDGANHR2y9yFT30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325270; c=relaxed/simple;
	bh=MpvlZLbliGPZXTQxvyLmPQJAPN6eqg9lc0dbM+IG9y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxadyIiOqi8QPCJtJnPdbspomLDmuoFDb+Td/aLZKQFACfTBo5tWVwOeTiXIq9cgn6askIMpLor7+xBPS/IE0v+5HnKgjvbJlZJb1QQRRpRXEf4reD6nbZcevzRUOMb1x5QLIe52uQRuPdhQ68nqCBvkHcLRagwJVqNZLCu/t9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DC407ej1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cd48c67so64025195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 17:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739325268; x=1739930068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMURN9Y7AkEPF/m3c0eARRAdPTEEnUTAwfZW2YFlzvM=;
        b=DC407ej1qEQhiGj5opg3KjpKH8HlVNa9hoh4AhG/EU5HKpq9xTMPLFb1OzcUZoDCFA
         X8+7LkGvzI7kmsETFl/+6oCadY8caAKtN6t8U7LGXqM2iBI/hzYOR3c8IBR51jDRifSG
         uoNPzjaFCrr3XEhRKRMKCRL8s+98PphLuT49HrTS/XX47sK5cN9AfxvkUvDaA7PJDAM7
         6w2t8tEiwMDrweKuzpQXAfpzrBR5vEXS7gn9H30cTGo1goy12a2G/7mvcXtnc/JQ7pKR
         pZORNCCmaYwyn4pl55mbuIDrL/pfwUskPzIvALUXiJbqM8S778Tx/Za07nmc1cZQcheS
         6m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739325268; x=1739930068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMURN9Y7AkEPF/m3c0eARRAdPTEEnUTAwfZW2YFlzvM=;
        b=c+kzq4l6fR4WE02jAtWQewvkPtEr1zptISmkdsIKR0LHdziCqPJLhyod5a1WJExzqq
         TgG4ngTBwl+iIcB/oFBZA1/8qIW3oyeYD1mU0IJd0Itz6kSPPTtp2DT3sCMt3Fj5ekPj
         T1fFpxq9MBv1FQOeLyRyJsYIZFeyWqQcqSBuWGuye6lE6fzQNrRIOh49UrVE1lY3wCa8
         VjNNpcOYHc4+I8o55SofjvUsygC6bi9tH6P3QaLoZ5axjx+3h1CechJUPcvTQgQUwxj8
         kFAWt3GHEmJRO1AukMY5CGQG+T1VmFdfjk2OFNCQBO4R9TAL8O4h5HjSRompjKeggX7o
         ahxQ==
X-Gm-Message-State: AOJu0Yw1R82ILEXvKLjzLJ1GgtvBzVga9REcZCpAei1BboTY9AogqrSI
	FwPH+oxWkxG55AA3ppQJc6nfVwygiJDRcMndXBGK7q0BKiyvjqtJ+XWh0FnTPZgmuzE6zw+yh2w
	PAg==
X-Google-Smtp-Source: AGHT+IH9P8xCcYbPtBmw0P9YXo3q6d3jpuTVYvGxSkFNnMtSTojZbCAFgk3LDrVUk4ufI+/GJdZYIbv8Vf0=
X-Received: from pldw12.prod.google.com ([2002:a17:902:ca0c:b0:21f:4bcb:f256])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a8d:b0:21f:5cd8:c52
 with SMTP id d9443c01a7336-220bbde6dfcmr27698625ad.53.1739325267971; Tue, 11
 Feb 2025 17:54:27 -0800 (PST)
Date: Tue, 11 Feb 2025 17:54:26 -0800
In-Reply-To: <20250203223205.36121-2-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-2-prsampat@amd.com>
Message-ID: <Z6v_UjzEpSMyMZN2@google.com>
Subject: Re: [PATCH v6 1/9] KVM: SEV: Disable SEV-SNP on FW validation failure
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, 
	pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0f04f365885c..b709c2f0945c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3040,7 +3040,9 @@ void __init sev_hardware_setup(void)
>  	sev_es_asid_count = min_sev_asid - 1;
>  	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
>  	sev_es_supported = true;
> -	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> +	sev_snp_supported = (sev_snp_enabled &&
> +			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
> +			    snp_fw_valid());
>  
>  out:
>  	if (boot_cpu_has(X86_FEATURE_SEV))
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index af018afd9cd7..b45cd60c19b0 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
>  	return false;
>  }
>  
> +bool snp_fw_valid(void)
> +{
> +	return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);

This lacks any sense of abstraction.  KVM doesn't care if the firmware is valid,
KVM only cares if SNP is support.  KVM _must_ run after ASP initialization[*],
so I'm pretty sure KVM just needs a way to query sev->snp_initialized.

[*] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

