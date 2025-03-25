Return-Path: <linux-kernel+bounces-575402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1BA701F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396E917D11F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE073259C9C;
	Tue, 25 Mar 2025 13:16:46 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9513B58A;
	Tue, 25 Mar 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908606; cv=none; b=hfrtJVCc6XaLl5EnbqRRbyfuUd15erE9jsFgB+sIG5ouip8vJWXG9U87xL8saPJZutqKES/+Lz005zT0uXNGTq7JUC6ie6jj9TLbXo+RaLqAjCdBzceZXWQA4r0kxTBaFNkrnN1xCaR7Q4nJyOsBy8xAudbpNXECbwPdTCihfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908606; c=relaxed/simple;
	bh=TOtQbODRyOQXw/R+sPSuiV/4n6xwFBolNRfGAi3+ckg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcQrf98+4AtJc4EpDRyX41olwvLK1indNH0yrDtEGRrKEX/JqjyIPE6L4O68K+3k/9hHq09IVYtL180ts7wTqJlfJyHqDWMHle1uH/poYnonQQq+oyLCa6zbp10Djz0pHe46he/mQJx8Iyrti3Up5rn4CI/hlldcXN2K7sUN148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E71620487;
	Tue, 25 Mar 2025 13:16:34 +0000 (UTC)
Message-ID: <b0c2f8f3-3630-4704-b9a0-fb7a325d57fe@ghiti.fr>
Date: Tue, 25 Mar 2025 14:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] RISC-V: add vector extension validation checks
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Eric Biggers <ebiggers@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
 <20250312-eclair-affluent-55b098c3602b@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250312-eclair-affluent-55b098c3602b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepfedurdefvddrkedurddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdefvddrkedurddukeejpdhhvghloheplgduledvrdduieekrddvuddrvdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 12/03/2025 14:11, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Using Clement's new validation callbacks, support checking that
> dependencies have been satisfied for the vector extensions. From the
> kernel's perfective, it's not required to differentiate between the
> conditions for all the various vector subsets - it's the firmware's job
> to not report impossible combinations. Instead, the kernel only has to
> check that the correct config options are enabled and to enforce its
> requirement of the d extension being present for FPU support.
>
> Since vector will now be disabled proactively, there's no need to clear
> the bit in elf_hwcap in riscv_fill_hwcap() any longer.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   arch/riscv/include/asm/cpufeature.h |  3 ++
>   arch/riscv/kernel/cpufeature.c      | 60 +++++++++++++++++++----------
>   2 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 569140d6e639..5d9427ccbc7a 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -56,6 +56,9 @@ void __init riscv_user_isa_enable(void);
>   #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>   	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
>   			    ARRAY_SIZE(_bundled_exts), NULL)
> +#define __RISCV_ISA_EXT_BUNDLE_VALIDATE(_name, _bundled_exts, _validate) \
> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
> +			    ARRAY_SIZE(_bundled_exts), _validate)
>   
>   /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>   #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c6ba750536c3..dbea6ed3f4da 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -109,6 +109,38 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>   	return 0;
>   }
>   
> +static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
> +				       const unsigned long *isa_bitmap)
> +{
> +	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int riscv_ext_vector_float_validate(const struct riscv_isa_ext_data *data,
> +					   const unsigned long *isa_bitmap)
> +{
> +	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
> +		return -EINVAL;
> +
> +	if (!IS_ENABLED(CONFIG_FPU))
> +		return -EINVAL;
> +
> +	/*
> +	 * The kernel doesn't support systems that don't implement both of
> +	 * F and D, so if any of the vector extensions that do floating point
> +	 * are to be usable, both floating point extensions need to be usable.
> +	 *
> +	 * Since this function validates vector only, and v/Zve* are probed
> +	 * after f/d, there's no need for a deferral here.
> +	 */
> +	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
>   				 const unsigned long *isa_bitmap)
>   {
> @@ -326,12 +358,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>   	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
>   	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
>   	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
> -	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
>   	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> -	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
> -					  riscv_ext_zicbom_validate),
> -	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
> -					  riscv_ext_zicboz_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
>   	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>   	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>   	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
> @@ -372,11 +402,11 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>   	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
>   	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
>   	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> -	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
> -	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
> -	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
> -	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
> -	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts, riscv_ext_vector_float_validate),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(zve32x, RISCV_ISA_EXT_ZVE32X, riscv_ext_vector_x_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts, riscv_ext_vector_float_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts, riscv_ext_vector_float_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts, riscv_ext_vector_x_validate),
>   	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
>   	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
>   	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> @@ -960,16 +990,6 @@ void __init riscv_fill_hwcap(void)
>   		riscv_v_setup_vsize();
>   	}
>   
> -	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> -		/*
> -		 * ISA string in device tree might have 'v' flag, but
> -		 * CONFIG_RISCV_ISA_V is disabled in kernel.
> -		 * Clear V flag in elf_hwcap if CONFIG_RISCV_ISA_V is disabled.
> -		 */
> -		if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
> -			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> -	}
> -
>   	memset(print_str, 0, sizeof(print_str));
>   	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>   		if (riscv_isa[0] & BIT_MASK(i))


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



