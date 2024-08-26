Return-Path: <linux-kernel+bounces-300827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D602195E8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F41F22B39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091E84D0F;
	Mon, 26 Aug 2024 06:28:32 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FE839EB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653711; cv=none; b=SnuoMgWvOPMCicFVzCgRxBLCedFuoeNVmG/qNPXyIN9bUiRCwsDi3xDbCzE79tolgTs9S+VzN0NY16wM35RKaINyijCW2d20uFCT0JSb62VHHe/arB0JxG+tZ4NiugsHEGCSEf8wP1Aaa5KTZz3cN0KUtejazIgpw/TQge+uab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653711; c=relaxed/simple;
	bh=UjXX22+VZ36Jtbmb3nyI5q9wezZLngfbcCGdeDC0oyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcN+FyKm1kReK1+1TV4EUhBvGJaHmhaopNg+dGuteg2OGGtZZ0rx9AfZvOGLZ6OrSZJvbS+EznnNjdRgRImPmAhTDU+RpXwEYyD9iijd0gftSRFL7uEnMkIDp3hiUYQreDsJLe1zCiWvs+LhF0kxIR/G+EsKKVo4HdRBVlWcDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32EFE240006;
	Mon, 26 Aug 2024 06:28:17 +0000 (UTC)
Message-ID: <422ee6c5-048d-498e-a823-97deef02326f@ghiti.fr>
Date: Mon, 26 Aug 2024 08:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RISC-V: hwprobe: Use BIT macro to avoid warnings
Content-Language: en-US
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-kernel@vger.kernel.org
References: <20240822203913.2306574-1-jesse@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240822203913.2306574-1-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jesse,

On 22/08/2024 22:39, Jesse Taube wrote:
> In uapi/asm/hwprobe.h file, (1 << N) is used to define the bit field
> which causes checkpatch to warn. Use BIT(N) and BIT_ULL(N) to avoid
> these warnings.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> V1 -> V2:
>   - Reword commit message
> ---
>   arch/riscv/include/uapi/asm/hwprobe.h | 102 +++++++++++++-------------
>   1 file changed, 51 insertions(+), 51 deletions(-)
>
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index b706c8e47b02..d0874ff2fd37 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -21,57 +21,57 @@ struct riscv_hwprobe {
>   #define RISCV_HWPROBE_KEY_MARCHID	1
>   #define RISCV_HWPROBE_KEY_MIMPID	2
>   #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
> -#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
> +#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	BIT_ULL(0)
>   #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
> -#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
> -#define		RISCV_HWPROBE_IMA_C		(1 << 1)
> -#define		RISCV_HWPROBE_IMA_V		(1 << 2)
> -#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> -#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> -#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> -#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> -#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
> -#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
> -#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
> -#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
> -#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
> -#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
> -#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
> -#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> -#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> -#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> -#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
> -#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
> -#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
> -#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
> -#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
> -#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
> -#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
> -#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
> -#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
> -#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
> -#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
> -#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
> -#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
> -#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
> -#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
> -#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
> -#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
> -#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
> -#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
> -#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
> -#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
> -#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
> -#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
> -#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
> -#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
> -#define		RISCV_HWPROBE_EXT_ZIMOP		(1ULL << 42)
> -#define		RISCV_HWPROBE_EXT_ZCA		(1ULL << 43)
> -#define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 44)
> -#define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
> -#define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
> -#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> -#define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> +#define		RISCV_HWPROBE_IMA_FD		BIT_ULL(0)
> +#define		RISCV_HWPROBE_IMA_C		BIT_ULL(1)
> +#define		RISCV_HWPROBE_IMA_V		BIT_ULL(2)
> +#define		RISCV_HWPROBE_EXT_ZBA		BIT_ULL(3)
> +#define		RISCV_HWPROBE_EXT_ZBB		BIT_ULL(4)
> +#define		RISCV_HWPROBE_EXT_ZBS		BIT_ULL(5)
> +#define		RISCV_HWPROBE_EXT_ZICBOZ	BIT_ULL(6)
> +#define		RISCV_HWPROBE_EXT_ZBC		BIT_ULL(7)
> +#define		RISCV_HWPROBE_EXT_ZBKB		BIT_ULL(8)
> +#define		RISCV_HWPROBE_EXT_ZBKC		BIT_ULL(9)
> +#define		RISCV_HWPROBE_EXT_ZBKX		BIT_ULL(10)
> +#define		RISCV_HWPROBE_EXT_ZKND		BIT_ULL(11)
> +#define		RISCV_HWPROBE_EXT_ZKNE		BIT_ULL(12)
> +#define		RISCV_HWPROBE_EXT_ZKNH		BIT_ULL(13)
> +#define		RISCV_HWPROBE_EXT_ZKSED		BIT_ULL(14)
> +#define		RISCV_HWPROBE_EXT_ZKSH		BIT_ULL(15)
> +#define		RISCV_HWPROBE_EXT_ZKT		BIT_ULL(16)
> +#define		RISCV_HWPROBE_EXT_ZVBB		BIT_ULL(17)
> +#define		RISCV_HWPROBE_EXT_ZVBC		BIT_ULL(18)
> +#define		RISCV_HWPROBE_EXT_ZVKB		BIT_ULL(19)
> +#define		RISCV_HWPROBE_EXT_ZVKG		BIT_ULL(20)
> +#define		RISCV_HWPROBE_EXT_ZVKNED	BIT_ULL(21)
> +#define		RISCV_HWPROBE_EXT_ZVKNHA	BIT_ULL(22)
> +#define		RISCV_HWPROBE_EXT_ZVKNHB	BIT_ULL(23)
> +#define		RISCV_HWPROBE_EXT_ZVKSED	BIT_ULL(24)
> +#define		RISCV_HWPROBE_EXT_ZVKSH		BIT_ULL(25)
> +#define		RISCV_HWPROBE_EXT_ZVKT		BIT_ULL(26)
> +#define		RISCV_HWPROBE_EXT_ZFH		BIT_ULL(27)
> +#define		RISCV_HWPROBE_EXT_ZFHMIN	BIT_ULL(28)
> +#define		RISCV_HWPROBE_EXT_ZIHINTNTL	BIT_ULL(29)
> +#define		RISCV_HWPROBE_EXT_ZVFH		BIT_ULL(30)
> +#define		RISCV_HWPROBE_EXT_ZVFHMIN	BIT_ULL(31)
> +#define		RISCV_HWPROBE_EXT_ZFA		BIT_ULL(32)
> +#define		RISCV_HWPROBE_EXT_ZTSO		BIT_ULL(33)
> +#define		RISCV_HWPROBE_EXT_ZACAS		BIT_ULL(34)
> +#define		RISCV_HWPROBE_EXT_ZICOND	BIT_ULL(35)
> +#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	BIT_ULL(36)
> +#define		RISCV_HWPROBE_EXT_ZVE32X	BIT_ULL(37)
> +#define		RISCV_HWPROBE_EXT_ZVE32F	BIT_ULL(38)
> +#define		RISCV_HWPROBE_EXT_ZVE64X	BIT_ULL(39)
> +#define		RISCV_HWPROBE_EXT_ZVE64F	BIT_ULL(40)
> +#define		RISCV_HWPROBE_EXT_ZVE64D	BIT_ULL(41)
> +#define		RISCV_HWPROBE_EXT_ZIMOP		BIT_ULL(42)
> +#define		RISCV_HWPROBE_EXT_ZCA		BIT_ULL(43)
> +#define		RISCV_HWPROBE_EXT_ZCB		BIT_ULL(44)
> +#define		RISCV_HWPROBE_EXT_ZCD		BIT_ULL(45)
> +#define		RISCV_HWPROBE_EXT_ZCF		BIT_ULL(46)
> +#define		RISCV_HWPROBE_EXT_ZCMOP		BIT_ULL(47)
> +#define		RISCV_HWPROBE_EXT_ZAWRS		BIT_ULL(48)
>   #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>   #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>   #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)


Why isn't this one ^ converted too? I did not look but are there other 
occurrences in this file that should be converted too?

And what about the rest of the riscv sources?

Thanks,

Alex


> @@ -85,6 +85,6 @@ struct riscv_hwprobe {
>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>   
>   /* Flags */
> -#define RISCV_HWPROBE_WHICH_CPUS	(1 << 0)
> +#define RISCV_HWPROBE_WHICH_CPUS	BIT(0)
>   
>   #endif

