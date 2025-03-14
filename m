Return-Path: <linux-kernel+bounces-561493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F96A612A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FD64631F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02B1FF7C1;
	Fri, 14 Mar 2025 13:28:58 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5781FF60C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958938; cv=none; b=AXfG39wbBj5pV2WmdBMHbl5dqosfhhRqdnciK0t1xHJhW4oo4w0KphiBFKlDfuC79zSrPW5quEbI261dmhfLJYG17AEu4HZU7eOztkBd7Q76EZt2rFRIkW58hFlMCmVoKsSPXngYYo0n1GGaVcli0RTu3vZUgQw+RQYC9KcLnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958938; c=relaxed/simple;
	bh=pj1oke2D0Ei4sgqV6PyINJdX243tfGX3NgfsHlcRgZE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SDy4w85JXknZ2v4SMbNw2ON9F/kKUCBgP/v3Jt5T2chXrteYARA2Ej8SISUt6LhSaHV4RyGLn5dbc3UFscDzseJTayfTWABfn1gxc5V7peC1srmMam8R2VAWFQi6Q9/sNQoGiVn0cai26BZtmJ1o9YsK1qbhajlm0fdXcaibzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE96044380;
	Fri, 14 Mar 2025 13:28:52 +0000 (UTC)
Message-ID: <9a94c74f-4826-479f-aaa0-e87b3bfd30ff@ghiti.fr>
Date: Fri, 14 Mar 2025 14:28:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 1/4] riscv: implement user_access_begin() and families
To: Cyril Bur <cyrilbur@tenstorrent.com>, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paul.walmsley@sifive.com, charlie@rivosinc.com,
 jrtc27@jrtc27.com, ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <20250221000924.734006-2-cyrilbur@tenstorrent.com>
Content-Language: en-US
In-Reply-To: <20250221000924.734006-2-cyrilbur@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejffetjedtkeefheelkeetteffjeetgeefkeethfdvleehjeetuddvuefgjefhieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvgdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemugehrgefmeehsgeisgemuggvfhekmeeltdguvggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheptgihrhhilhgsuhhrsehtvghnshhtohhrrhgvnhhtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepr
 ghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjrhhttgdvjeesjhhrthgtvdejrdgtohhmpdhrtghpthhtohepsggvnhdrughoohhkshestghouggvthhhihhnkhdrtghordhukhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Cyril,

On 21/02/2025 01:09, Cyril Bur wrote:
> From: Jisheng Zhang<jszhang@kernel.org>
>
> Currently, when a function like strncpy_from_user() is called,
> the userspace access protection is disabled and enabled
> for every word read.
>
> By implementing user_access_begin() and families, the protection
> is disabled at the beginning of the copy and enabled at the end.
>
> The __inttype macro is borrowed from x86 implementation.
>
> Signed-off-by: Jisheng Zhang<jszhang@kernel.org>
> Signed-off-by: Cyril Bur<cyrilbur@tenstorrent.com>
> ---
>   arch/riscv/include/asm/uaccess.h | 63 ++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index fee56b0c8058..43db1d9c2f99 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -61,6 +61,19 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigne
>   #define __disable_user_access()							\
>   	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
>   
> +/*
> + * This is the smallest unsigned integer type that can fit a value
> + * (up to 'long long')
> + */
> +#define __inttype(x) __typeof__(		\
> +	__typefits(x,char,			\
> +	  __typefits(x,short,			\
> +	    __typefits(x,int,			\
> +	      __typefits(x,long,0ULL)))))
> +
> +#define __typefits(x,type,not) \
> +	__builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
> +
>   /*
>    * The exception table consists of pairs of addresses: the first is the
>    * address of an instruction that is allowed to fault, and the second is
> @@ -368,6 +381,56 @@ do {									\
>   		goto err_label;						\
>   } while (0)
>   
> +static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
> +{
> +	if (unlikely(!access_ok(ptr,len)))
> +		return 0;
> +	__enable_user_access();
> +	return 1;
> +}
> +#define user_access_begin(a,b)	user_access_begin(a,b)


Nit: no need for (a,b) here


> +#define user_access_end()	__disable_user_access()
> +
> +static inline unsigned long user_access_save(void) { return 0UL; }
> +static inline void user_access_restore(unsigned long enabled) { }
> +
> +/*
> + * We want the unsafe accessors to always be inlined and use
> + * the error labels - thus the macro games.
> + */
> +#define unsafe_put_user(x, ptr, label)	do {				\
> +	long __err = 0;							\
> +	__put_user_nocheck(x, (ptr), __err);				\
> +	if (__err) goto label;						\
> +} while (0)
> +
> +#define unsafe_get_user(x, ptr, label)	do {				\
> +	long __err = 0;							\
> +	__inttype(*(ptr)) __gu_val;					\
> +	__get_user_nocheck(__gu_val, (ptr), __err);			\
> +	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
> +	if (__err) goto label;						\
> +} while (0)
> +
> +#define unsafe_copy_loop(dst, src, len, type, label)				\
> +	while (len >= sizeof(type)) {						\
> +		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
> +		dst += sizeof(type);						\
> +		src += sizeof(type);						\
> +		len -= sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> +do {									\
> +	char __user *__ucu_dst = (_dst);				\
> +	const char *__ucu_src = (_src);					\
> +	size_t __ucu_len = (_len);					\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +} while (0)
> +
>   #else /* CONFIG_MMU */
>   #include <asm-generic/uaccess.h>
>   #endif /* CONFIG_MMU */

There is a bunch of checkpatch errors to fix, see 
https://gist.github.com/linux-riscv-bot/98f23fd1b04d6da7c23c6cb18245a158

Why isn't there an implementation for unsafe_copy_from_user()? Let's 
take the following example:

user_access_begin()
unsafe_copy_from_user()
unsafe_get_user() <==== This one will fail since unsafe_copy_from_user() 
-> raw_copy_from_user() -> __asm_vector_usercopy() which enables and 
disables the SUM bit.
user_access_end()

Another thing is that with this patch, we lose the vectorized user 
access functions, can you fix that too?

Thanks,

Alex




