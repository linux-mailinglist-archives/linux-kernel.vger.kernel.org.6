Return-Path: <linux-kernel+bounces-318389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6196ED12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE05B22498
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80866156C5F;
	Fri,  6 Sep 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="SRrPV2AA"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFD15696E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609727; cv=none; b=AhKl8P9lXmod7SUtIQ5JnhMxJTAn8TnlCAhIJ7W5k2ZXtt8rDXRPP7B2oDesHY11++BWOXm0WavPc9QOp5+tGZY32vvldZb+hCmxknWofQVKF2xHKNYNg+klDQb6pJe7u7Pb73FRMfV4sLM/nis15rMUCY7jpkJ68jrKNnKljW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609727; c=relaxed/simple;
	bh=o9pGTqsQcE+/z7gan0ogj87sXnEw/68q8S9/VpMpJ8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luW0WWb0vjZDkWFd782qM+xUb3dwopbJnhedter+ECTisG3z+kBBRvqDWQrz1oH9fCdb5BUsfFYKVsS9CbbjTkfDEOsP7E9Z6OKKSSs8mfjvPLz4xm0XIh540zSFI+pkfdp6uWgl5AjOXVhSTfhUWZ7xmNW9+CoAn8wGzpHg2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=SRrPV2AA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725609724;
	bh=auxBVDOvEOmImq2J3vhx19p045HkeZw7jePHVT3b+3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SRrPV2AAuKnBQYblNqSotOODMgxWezzWyC1Nfo6BEkA+9ovKz8YnAKKOt7tpuMSIF
	 YLXjkYb9469DcTqyYE5vu5mvtsOpyaQb5tSzmYn/3mIrENTxavCHhFz8Dx8l+b4nAD
	 +R0uMxEKeze7rXFc6yX/jUyBSdns2aDdymXI2jak=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A63DE1A3FF2;
	Fri,  6 Sep 2024 04:02:03 -0400 (EDT)
Message-ID: <d13fd45583d57080e4b81eeac55b787378cbcfa2.camel@xry111.site>
Subject: Re: [PATCH v4] LoongArch/percpu: Simplify _percpu_read() and
 _percpu_write()
From: Xi Ruoyao <xry111@xry111.site>
To: Uros Bizjak <ubizjak@gmail.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 06 Sep 2024 16:02:02 +0800
In-Reply-To: <20240906065807.1103275-1-ubizjak@gmail.com>
References: <20240906065807.1103275-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 08:57 +0200, Uros Bizjak wrote:
> _percpu_read() and _percpu_write() macros call __percpu_read()
> and __percpu_write() static inline functions that result in a single
> assembly instruction. Percpu infrastructure expects its leaf
> definitions to encode the size of their percpu variable, so the patch
> merges asm clauses from the static inline function into the
> corresponding leaf macros.
>=20
> The secondary effect of this change is to avoid explicit __percpu
> function arguments. Currently, __percpu macro is defined in
> include/linux/compiler_types.h, but with proposed patch [1],
> __percpu definition will need macros from include/asm-generic/percpu.h,
> creating forward dependency loop.
>=20
> The proposed solution is the same as x86 architecture uses.
>=20
> Patch is compile tested only.

Boots fine and per-CPU variable seems working fine (tried with a kernel
module defining a per-CPU variable and operating on it).

Tested-by: Xi Ruoyao <xry111@xry111.site>

>=20
> [1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.co=
m/
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Xi Ruoyao <xry111@xry111.site>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> v2: Add a missing cast and a missing coma in the asm template,
> =C2=A0=C2=A0=C2=A0 reported by kernel test robot. Some formatting changes=
.
> v3: Check the type of _val in _percpu_write().
> v4: Remove type ckecking of _val. Remove unnecessary zero-extensions
> =C2=A0=C2=A0=C2=A0 and truncations.
> ---
> =C2=A0arch/loongarch/include/asm/percpu.h | 124 ++++++++-----------------=
---
> =C2=A01 file changed, 35 insertions(+), 89 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include=
/asm/percpu.h
> index 8f290e5546cf..87be9b14e9da 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -68,75 +68,6 @@ PERCPU_OP(and, and, &)
> =C2=A0PERCPU_OP(or, or, |)
> =C2=A0#undef PERCPU_OP
> =C2=A0
> -static __always_inline unsigned long __percpu_read(void __percpu *ptr, i=
nt size)
> -{
> -	unsigned long ret;
> -
> -	switch (size) {
> -	case 1:
> -		__asm__ __volatile__ ("ldx.b %[ret], $r21, %[ptr]	\n"
> -		: [ret] "=3D&r"(ret)
> -		: [ptr] "r"(ptr)
> -		: "memory");
> -		break;
> -	case 2:
> -		__asm__ __volatile__ ("ldx.h %[ret], $r21, %[ptr]	\n"
> -		: [ret] "=3D&r"(ret)
> -		: [ptr] "r"(ptr)
> -		: "memory");
> -		break;
> -	case 4:
> -		__asm__ __volatile__ ("ldx.w %[ret], $r21, %[ptr]	\n"
> -		: [ret] "=3D&r"(ret)
> -		: [ptr] "r"(ptr)
> -		: "memory");
> -		break;
> -	case 8:
> -		__asm__ __volatile__ ("ldx.d %[ret], $r21, %[ptr]	\n"
> -		: [ret] "=3D&r"(ret)
> -		: [ptr] "r"(ptr)
> -		: "memory");
> -		break;
> -	default:
> -		ret =3D 0;
> -		BUILD_BUG();
> -	}
> -
> -	return ret;
> -}
> -
> -static __always_inline void __percpu_write(void __percpu *ptr, unsigned =
long val, int size)
> -{
> -	switch (size) {
> -	case 1:
> -		__asm__ __volatile__("stx.b %[val], $r21, %[ptr]	\n"
> -		:
> -		: [val] "r" (val), [ptr] "r" (ptr)
> -		: "memory");
> -		break;
> -	case 2:
> -		__asm__ __volatile__("stx.h %[val], $r21, %[ptr]	\n"
> -		:
> -		: [val] "r" (val), [ptr] "r" (ptr)
> -		: "memory");
> -		break;
> -	case 4:
> -		__asm__ __volatile__("stx.w %[val], $r21, %[ptr]	\n"
> -		:
> -		: [val] "r" (val), [ptr] "r" (ptr)
> -		: "memory");
> -		break;
> -	case 8:
> -		__asm__ __volatile__("stx.d %[val], $r21, %[ptr]	\n"
> -		:
> -		: [val] "r" (val), [ptr] "r" (ptr)
> -		: "memory");
> -		break;
> -	default:
> -		BUILD_BUG();
> -	}
> -}
> -
> =C2=A0static __always_inline unsigned long __percpu_xchg(void *ptr, unsig=
ned long val, int size)
> =C2=A0{
> =C2=A0	switch (size) {
> @@ -157,6 +88,33 @@ static __always_inline unsigned long __percpu_xchg(vo=
id *ptr, unsigned long val,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#define __pcpu_op_1(op)		op ".b "
> +#define __pcpu_op_2(op)		op ".h "
> +#define __pcpu_op_4(op)		op ".w "
> +#define __pcpu_op_8(op)		op ".d "
> +
> +#define _percpu_read(size, _pcp)					\
> +({									\
> +	typeof(_pcp) __pcp_ret;						\
> +									\
> +	__asm__ __volatile__(						\
> +		__pcpu_op_##size("ldx") "%[ret], $r21, %[ptr]	\n"	\
> +		: [ret] "=3D&r"(__pcp_ret)				\
> +		: [ptr] "r"(&(_pcp))					\
> +		: "memory");						\
> +									\
> +	__pcp_ret;							\
> +})
> +
> +#define _percpu_write(size, _pcp, _val)					\
> +do {									\
> +	__asm__ __volatile__(						\
> +		__pcpu_op_##size("stx") "%[val], $r21, %[ptr]	\n"	\
> +		:							\
> +		: [val] "r"(_val), [ptr] "r"(&(_pcp))			\
> +		: "memory");						\
> +} while (0)
> +
> =C2=A0/* this_cpu_cmpxchg */
> =C2=A0#define _protect_cmpxchg_local(pcp, o, n)			\
> =C2=A0({								\
> @@ -167,18 +125,6 @@ static __always_inline unsigned long __percpu_xchg(v=
oid *ptr, unsigned long val,
> =C2=A0	__ret;							\
> =C2=A0})
> =C2=A0
> -#define _percpu_read(pcp)						\
> -({									\
> -	typeof(pcp) __retval;						\
> -	__retval =3D (typeof(pcp))__percpu_read(&(pcp), sizeof(pcp));	\
> -	__retval;							\
> -})
> -
> -#define _percpu_write(pcp, val)						\
> -do {									\
> -	__percpu_write(&(pcp), (unsigned long)(val), sizeof(pcp));	\
> -} while (0)								\
> -
> =C2=A0#define _pcp_protect(operation, pcp, val)			\
> =C2=A0({								\
> =C2=A0	typeof(pcp) __retval;					\
> @@ -215,15 +161,15 @@ do {									\
> =C2=A0#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
> =C2=A0#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
> =C2=A0
> -#define this_cpu_read_1(pcp) _percpu_read(pcp)
> -#define this_cpu_read_2(pcp) _percpu_read(pcp)
> -#define this_cpu_read_4(pcp) _percpu_read(pcp)
> -#define this_cpu_read_8(pcp) _percpu_read(pcp)
> +#define this_cpu_read_1(pcp) _percpu_read(1, pcp)
> +#define this_cpu_read_2(pcp) _percpu_read(2, pcp)
> +#define this_cpu_read_4(pcp) _percpu_read(4, pcp)
> +#define this_cpu_read_8(pcp) _percpu_read(8, pcp)
> =C2=A0
> -#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> -#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_1(pcp, val) _percpu_write(1, pcp, val)
> +#define this_cpu_write_2(pcp, val) _percpu_write(2, pcp, val)
> +#define this_cpu_write_4(pcp, val) _percpu_write(4, pcp, val)
> +#define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
> =C2=A0
> =C2=A0#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
> =C2=A0#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

