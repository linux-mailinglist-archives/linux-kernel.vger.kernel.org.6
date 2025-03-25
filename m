Return-Path: <linux-kernel+bounces-575471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA60A702D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948AF1653B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3752561C3;
	Tue, 25 Mar 2025 13:48:28 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40E193062;
	Tue, 25 Mar 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910508; cv=none; b=FYn4fMUw0PFB/pZC/yDkMqijRfQPVcUycZEw5WwiUFw7DeHzBMfy/KrdcWDOuCpIzzpSL16Qbt1mfJnnl7OMwy6u90dg/kkJMPh69N1kc21YztG/B/apRodj/nyUMMxsxav9SOrTWy/qFMjq3IbLH/y3vuy1WIUlCDvqwD5lP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910508; c=relaxed/simple;
	bh=JZliSBmO9R3oqxSMGV6o65XnDID122HEJwJkSr6qQsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmjTtMf1yFHRlndQRf8fArZ1wcBAVMwg6KyTpr9jgRr8ZAxt19popjy6lo0hfUZzr0llkqUrj1tEUShcwSKNfVVpDSyUv2mYa1FgF2ACxJkK1MgtZvpjZms1rKelTY0uC7GZipT3EgkhdODIzLshFQk58FVU4PsMvP9ZzEfIe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF8B8442FE;
	Tue, 25 Mar 2025 13:48:21 +0000 (UTC)
Message-ID: <3e073897-9a58-40b7-8b45-80c73217742b@ghiti.fr>
Date: Tue, 25 Mar 2025 14:48:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] RISC-V: add f & d extension validation checks
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
 <20250312-reptile-platinum-62ee0f444a32@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250312-reptile-platinum-62ee0f444a32@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepfedurdefvddrkedurddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdefvddrkedurddukeejpdhhvghloheplgduledvrdduieekrddvuddrvdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghonhhorhdrughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

On 12/03/2025 14:11, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Using Clement's new validation callbacks, support checking that
> dependencies have been satisfied for the floating point extensions.
>
> The check for "d" might be slightly confusingly shorter than that of "f",
> despite "d" depending on "f". This is because the requirement that a
> hart supporting double precision must also support single precision,
> should be validated by dt-bindings etc, not the kernel but lack of
> support for single precision only is a limitation of the kernel.
>
> Since vector will now be disabled proactively, there's no need to clear
> the bit in elf_hwcap in riscv_fill_hwcap() any longer.


I guess this is a leftover from the split right? No need to respin a new 
version only for that, I can remove it if you confirm.


>
> Tested-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   arch/riscv/kernel/cpufeature.c | 31 +++++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 4fa951e9f1cf..21d3cf361e0a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -109,6 +109,33 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>   	return 0;
>   }
>   
> +static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
> +				const unsigned long *isa_bitmap)
> +{
> +	if (!IS_ENABLED(CONFIG_FPU))
> +		return -EINVAL;
> +
> +	/*
> +	 * Due to extension ordering, d is checked before f, so no deferral
> +	 * is required.
> +	 */
> +	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
> +		pr_warn_once("This kernel does not support systems with F but not D\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int riscv_ext_d_validate(const struct riscv_isa_ext_data *data,
> +				const unsigned long *isa_bitmap)
> +{
> +	if (!IS_ENABLED(CONFIG_FPU))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
>   				       const unsigned long *isa_bitmap)
>   {
> @@ -371,8 +398,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>   	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
>   	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
>   	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
> -	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
> -	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_f, riscv_ext_f_validate),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_d, riscv_ext_d_validate),
>   	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
>   	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
>   	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


