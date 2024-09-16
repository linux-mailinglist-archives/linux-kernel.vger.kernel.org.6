Return-Path: <linux-kernel+bounces-330707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879697A308
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A381F22007
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EF15747A;
	Mon, 16 Sep 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvsni2og"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA8156F44
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494079; cv=none; b=cAnTPN54h5xdh4uRzyKkRngxfcYO9z2iJssdgQKPtBGPFLZaB3yCLAfn8+Z0MKzlN6UaGG2HP8EQFcIXd6JHxWCxtne9AZYxBcJCJN1h3CPpjfzx0QFh59LmLoFjrNbPLWRh/sfvXB8nfq7vveHobs7f0G0jCHbeSZWUVpGRPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494079; c=relaxed/simple;
	bh=0g3EMHejLuuMkm6mxiBDlLVYvi0sM0OEJ8hru2aH3j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csjLZY/CBhYriKuk7FvZrxDrkETYb73//A7i/Vo1R3gntf5K/ddNNjKvBTgNLj2FCy7ae7jy4ezHxBudOhbpxtzhm+Hi4rryJHFBYl2jacKOqelk9hm83Fd6vIcs4Yay06eDbRprqz3R06yx+84r54qIXZE/JCUdxu6bR1zA0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvsni2og; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059112f0a7so28015175ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726494077; x=1727098877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqVvi9cZ3vz8QdbFNjCT7apLKnLLwRoLcJRWbE0n1oI=;
        b=Rvsni2ogA+mfzHsLD36ybiI2TY825Wq//nVf3EZ5UCHJ1uPeeT2qSWHd5qddwEum6v
         S1nwr7HRmAtwH7V/iRTs9/uhLynDRhsz1XhiYKHk6lJX8qXmVWLpncsCujyGx7VRMuu3
         9ztpoDZ3ckpiJ9rFfu3pgCPw1ABTTfxzAs992eoMthkAb0IXJJ9344HvVixnB7Z5CA4o
         TCMNDl/Qyn3swgtHAlHTyAkOQ54PKH+Ro9AeZs6WkxSzxQWypAnq6PrdBfAs8iYKmtlU
         8IyddHAaQ8GiAUGdZI90XPNTK792TwLVKeV7O1yk3uVRwvp9cg5OQ/dJ7Jpl51ZH87kp
         Q4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726494077; x=1727098877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqVvi9cZ3vz8QdbFNjCT7apLKnLLwRoLcJRWbE0n1oI=;
        b=lpKCaofHnfPs6g04R0yCNuo9hfp1V4RRxvB+1u90V1AbQURjE3mMULjNp3CMnY4xlp
         /8QUsv2r4Qsznm0s3AAHg46w52sTgwa3qc3blf7gf/UmHGL8cAyhKgS0fSJ9j57+sQsH
         SJhpytbLmOBERSTV+SLIjXalFAZ8U8xcPmVYnnhT5nedvx8DOye/TBo7GevUV8XXrULw
         4HF9Sk35FJqacmuXNGReqy9D+KpleqgSH5AOz/c/lXCcruwG6jxrlL/xwtcBxNuPJjpq
         o8EgLmoWVOmZONuBDW9NDuKgR3RbW7ANMLgF9eVktB9un+fMh+hSIQbsSCdKri1p8iF6
         3ffA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAqT4Gw0JY2R5MdweXjy0A4JNXYplV91qGSAyE8teacCqiMdu3W34Mv/PVmfLDiz+ingZ8n1I5XBDo8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVlNgFFR1xB/0L3Ttei3shtP+q2VwlE6U+XyFLV4qfWV/fjxK
	KliHAU4nVurofxRKODyL41kkne3dvVniAVCIx3aMltDHLmd62uY6
X-Google-Smtp-Source: AGHT+IFlyjbLfkpYkFGaqvmb6Ay7rut+3nhxpVVTDBEzxPXDVBK0oQE0XhE6riN/OsOKh+eLDOGgCQ==
X-Received: by 2002:a17:902:d505:b0:205:4bae:afea with SMTP id d9443c01a7336-207829677a2mr197520585ad.23.1726494076937;
        Mon, 16 Sep 2024 06:41:16 -0700 (PDT)
Received: from [172.20.10.2] ([182.153.187.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27dasm35931105ad.172.2024.09.16.06.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 06:41:16 -0700 (PDT)
Message-ID: <f908c9ca-8063-44f4-b534-ddfc067b98c2@gmail.com>
Date: Mon, 16 Sep 2024 21:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: cpufeature: Pretend that Apple A10 family
 does not support 32-bit EL0
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev, Marc Zyngier <maz@kernel.org>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
 <20240909091425.16258-3-towinchenmi@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240909091425.16258-3-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/2024 17:10, Nick Chan wrote:
> The Apple A10 family consists of physical performance and efficiency
> cores, and only one of them can be active at a given time depending on
> the current p-state. However, only the performance cores can execute
> 32-bit EL0. This results in logical cores that can only execute 32-bit
> EL0 in high p-states.
Further research shows that the MPIDR_EL1 values between the two core
types are different. And whether the two core type have any extra
differences is anyone's guess right now. So far, nothing seems to break
horribly without special workarounds for the MPIDR value (with cpufreq
enabled downstream) as:
1. There are no KVM, GIC, ACPI, PSCI or cpuidle
2. All CPUs switch P-mode and E-mode together

However, all of this is broken enough that this piece of code should go
into arch/arm64/kernel/cpu_errata.c, and also generate a
TAINT_CPU_OUT_OF_SPEC for these cursed CPUs.

> 
> Trying to support 32-bit EL0 on a CPU that can only execute it in certain
> states is a bad idea. The A10 family only supports 16KB page size anyway
> so many AArch32 executables won't run anyways. Pretend that it does not
> support 32-bit EL0 at all.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 718728a85430..386698f42172 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3529,6 +3529,31 @@ void __init setup_boot_cpu_features(void)
>  	setup_boot_cpu_capabilities();
>  }
>  
> +static void __init bad_aarch32_el0_fixup(void)
> +{
> +	static const struct midr_range bad_aarch32_el0[] = {
> +		MIDR_ALL_VERSIONS(MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR),
> +		MIDR_ALL_VERSIONS(MIDR_APPLE_A10X_HURRICANE_ZEPHYR),
> +		{}
> +	};
> +
> +	/*
> +	 * The Apple A10 family can only execute 32-bit EL0 when in high
> +	 * p-states. Pretend it does not support 32-bit EL0.
> +	 */
> +	if (is_midr_in_range_list(read_cpuid_id(), bad_aarch32_el0)) {
> +		struct arm64_ftr_reg *regp;
> +
> +		regp = get_arm64_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +		if (!regp)
> +			return;
> +		u64 val = (regp->sys_val & ~ID_AA64PFR0_EL1_EL0_MASK)
> +		  | ID_AA64PFR0_EL1_EL0_IMP;
> +
> +		update_cpu_ftr_reg(regp, val);
> +	}
> +}
> +
>  static void __init setup_system_capabilities(void)
>  {
>  	/*
> @@ -3562,6 +3587,8 @@ static void __init setup_system_capabilities(void)
>  
>  void __init setup_system_features(void)
>  {
> +	bad_aarch32_el0_fixup();
> +
>  	setup_system_capabilities();
>  
>  	kpti_install_ng_mappings();

Nick Chan


