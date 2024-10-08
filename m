Return-Path: <linux-kernel+bounces-355210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E31994B69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D2E1F2731C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AF1DED47;
	Tue,  8 Oct 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LsXQjQRL"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EB1DE2AD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391315; cv=none; b=jMvqCBWcyvhmyuJyv5y25j1eULJtU6xof/bRYWmWeIQ+npmXpS1v8T5T13qtc41zMuHsT1JdFjVu4Im3SeS73agqXD+gvkKaWR3u9ku1aXk4AbQYikJYtZhwMuX5vQ7O9JrI5e3Kepj2412eBQUAZgvSawMInkZ0LUEcS6XZG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391315; c=relaxed/simple;
	bh=ppY2uYa3n+q3XFHA0jjXrfGLFMX2jL29tocJKfcBewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSBfYxto9vEyQzNagNRDrZ/evStfOS1hBj2BOYJwul/tTFBxlLbAEFiClm29j34MSOcLdoZA5Hs23huHF3qce/Oqz60ejKY8iSUyEANHLLkASmDpbZbZd4YehDe4/aHZXHDwsfOgodZVW87vYo81tIwIz784j4uJmeKSKyb0cnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LsXQjQRL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d2d320711so439010f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728391312; x=1728996112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJ8+14rlAhUuQl+nSWsKW23MJba4r7VOgiSaqw0OwFc=;
        b=LsXQjQRLkkhkAC2d/jo+vT4Xatqgs491dX3u8TeA5C28KnHIe3xXcOu/5hk69PECNA
         fi7nWCxLIQZgPcw6ojTgFRgB5x+bsuKaa82K6mvFp3Tf9A6HHYCv3cCjUwf4o6rUXsQA
         zky2rvqMkFb2DttTjYhueBOkkWTNnHleSJFsM/rMUVh5ioxavwTFwDTXiyo6DmjBRt9J
         JMm0BYfHgrBZ28F8hnc+mCfnjl5Dav6BrZ28/NakGPdZL60cDLIouy2VVekIbU0JR4UM
         C8neOuLWpRjpg2aNj7O6fXBcKTl3sE45IUh33SgEPmwGFrW1ys0Bzv6DufboCtB5L34+
         ouEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391312; x=1728996112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ8+14rlAhUuQl+nSWsKW23MJba4r7VOgiSaqw0OwFc=;
        b=sQYMELdIoIFX1Qm5hibtqZFOvLZ/58U3S6ohB4YPwqZna4VpDzuejtgRLXOiTQ+Y7E
         o48Dbkwp6d/TXFjUFvMeJDlzs5l+mFdJHlaWq2EjCvOVtIrB1zfZj30KHCCpy/jumPkR
         4Xdg2cG+Q2gC10u5HRWip8Pez8YMu7V0rFGXR2SaZlDqxAZDxI+hNV6JTM0KYZlKU4bo
         CKqTm9f5YV4NRvy6kgwoqRCEhsUC67IuSU+TExnmkinW2QmSUsKyZJA4XHrkVknI2XQw
         KEC3tZCCMhbupD4ZqKW1GL8AgmTBYRsRVDhmX367WVk0GkS1ghkdX5Z8fCLbitTVCF6H
         wyPA==
X-Gm-Message-State: AOJu0YzGPzsaD/83wZpmB+Sxll9GUsBQ9GnZObJeRTvAk75b0H2VnGdc
	6qhuGJz2MQda2vSVumYMF37HV7xfaSKJDZydrwmOJ/HpK9ew7kaAuwoDG+vRZfw=
X-Google-Smtp-Source: AGHT+IFx/kgmfeB0AcIMA21wvHdodaEBVhLBa+Qy4XKuGQIxitnY2HiW9YqYQNgcy2fkIr1HnlZIJg==
X-Received: by 2002:a05:6000:402b:b0:374:be11:22d7 with SMTP id ffacd0b85a97d-37d3886ca9dmr13082f8f.13.1728391311603;
        Tue, 08 Oct 2024 05:41:51 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2d45c225sm1463726f8f.57.2024.10.08.05.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 05:41:51 -0700 (PDT)
Message-ID: <542216b7-7453-4fe8-b63a-cbe2fde0d4c2@suse.com>
Date: Tue, 8 Oct 2024 15:41:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/34] x86/bugs: Restructure bhi mitigation
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-14-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240912190857.235849-14-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.09.24 г. 22:08 ч., David Kaplan wrote:
> Restructure bhi mitigation to use select/apply functions to create
> consistent vulnerability handling.
> 
> Define new AUTO mitigation for bhi.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index eaef5a1cb4a3..da6ca2fc939d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -82,6 +82,8 @@ static void __init l1d_flush_select_mitigation(void);
>   static void __init srso_select_mitigation(void);
>   static void __init gds_select_mitigation(void);
>   static void __init gds_apply_mitigation(void);
> +static void __init bhi_select_mitigation(void);
> +static void __init bhi_apply_mitigation(void);
>   
>   /* The base value of the SPEC_CTRL MSR without task-specific bits set */
>   u64 x86_spec_ctrl_base;
> @@ -201,6 +203,7 @@ void __init cpu_select_mitigations(void)
>   	 */
>   	srso_select_mitigation();
>   	gds_select_mitigation();
> +	bhi_select_mitigation();
>   
>   	/*
>   	 * After mitigations are selected, some may need to update their
> @@ -222,6 +225,7 @@ void __init cpu_select_mitigations(void)
>   	rfds_apply_mitigation();
>   	srbds_apply_mitigation();
>   	gds_apply_mitigation();
> +	bhi_apply_mitigation();
>   }
>   
>   /*
> @@ -1719,12 +1723,13 @@ static bool __init spec_ctrl_bhi_dis(void)
>   
>   enum bhi_mitigations {
>   	BHI_MITIGATION_OFF,
> +	BHI_MITIGATION_AUTO,
>   	BHI_MITIGATION_ON,
>   	BHI_MITIGATION_VMEXIT_ONLY,
>   };


Since this series refactors all mitigations how about taking ON to mean 
AUTO which would result in overall less states for the various 
mitigations. If we take BHI as an example I don't see what value does 
_AUTO bring here.

