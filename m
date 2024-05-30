Return-Path: <linux-kernel+bounces-194918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F758D443E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AC91F22F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782B139CFE;
	Thu, 30 May 2024 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FKFqrS3j"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50118139CE3;
	Thu, 30 May 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040387; cv=none; b=JkrSHEDpVswJuMOYg9sqZvhNvu8cDk0oY4PqFE0/sWO6Usv+8YEqx4U+sBGmWoxxiCa3tSRVoA9a8Z3RNGH0+zP3DMbK2DGaQkovGNX577NbHFt29gCrcAGi4p0F+zYu/P3Asqf61AVrcB14Y2KuNrWOTbehGSNTKMcZfQ1stnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040387; c=relaxed/simple;
	bh=W+5Ks2nSljVj8pYcDqby5hGNu9Ghhwrfc6A07R0SAhQ=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=alp36N/rDURZVd72ZeFHmeYLL2yRDBiLu4qtTLHlUxXAaiVLZZAaK6+ILaPkIJIJUlBV7oIq25WCNn2o1dY7rwOXZ6LTrCtEAl+npxXz5yrp8ART4rMnus+KMCDXP/pY2OVwd7VmuPzNKlK9Dbuk7dHIvbwNcA4ytuA3iyim868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FKFqrS3j; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1717040372; bh=W+5Ks2nSljVj8pYcDqby5hGNu9Ghhwrfc6A07R0SAhQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=FKFqrS3j1RoFBSUkSreTg0fwKG/h4vqEAuHwKtmweFQJOhgE8b2GuKAnCPgaAeBtU
	 CKT3tE1Ev7wuYI7GvwxySsx+q+5ks3t7YA8KtDik6QSS/5Nb/9qAxQmeSyk4uS9Hbb
	 oZIjZEgnMhs3kd89ZBHHQJ3Gap+r5XD80HH170eU=
Received: from smtpclient.apple ([2408:8207:18a0:162f:64ab:dad6:af9f:27b2])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 93BB5C3A; Thu, 30 May 2024 11:36:59 +0800
X-QQ-mid: xmsmtpt1717040219t0woo2fy3
Message-ID: <tencent_C5BBD6F106D73F662084BD91904F54504805@qq.com>
X-QQ-XMAILINFO: M79JLxWTMB1h2KmKdGdTSvzFCeQgQlHjNQ+9jX7TiUQ/waSoCje4RE7QVI5LyL
	 6+gfl1aJiH2luTL0EegevsOBf2YN64de+BAHGvNykYNmxYgYEss0DiRcvo1MyBxz7r/10zUbHyF5
	 FYPT1igb/Bk3U8TfJp2gCgQ/lvofOwh95DU3U1sn0nrUDPqKdxqytJZ++u5QdS6+jhz0M4tw5cgN
	 Z8eeRlHmo7DB8owyGW8jmymZ24mJJEbVKb9wCsI7ttIz1FKhVmDhUw5e1opLaaNx+IKenwTtmLDD
	 TCiwPAK+3ZyW/3vpvd9WjbfkrkN7YMQrV1PCto48y77kUWTGhup/l14fVX9XBzo0mYuygO5iZng5
	 JmdbFB1+OTodbJdxWjoJv0NKPv4xtCMYiDt8Pd4iEquB3zYphMiQtNWQcpqTcmNV5n5I2S5lyzLQ
	 rR+iNYsU5ge5y4LI/5JMNyDROpeeozN9FvaT6nGinTwycdU+T+aURcfoLzkZyJZLyQziOIqZUVoN
	 fNP13btjlBNhwVWkYyZSvkSO9+ko1p4m4QLGXj7EnvAa26Li8tuEYlt8ArRZ5/UZRWvUv43SSvTu
	 gAsARXT8u+Ib9qLHj2Io4vbYaovuZDtcUDxv02JTDkM6aNxh0ESQ+rxn+IqSV2Dlnw4XwLb9ljjF
	 aClPDHiHZQeSgQEvjR3Byxur/miE8BNPrwJLaYzRutNxWeyDstqsX2hXnFMgvxqKTzCDgHgyxiip
	 k15o/bG0cSX6nZwbp1f5chwTueYg38QQhJwylmwPSzOGFWwA2OC5js0p7n+086cDUt3ewhDaI86M
	 HPKjbhWomC0jsIXVPRBUlWGM43sOxr7Z/m/z2BoctKg9d3jl/rERFcGce+IaJBqv6Wuu/h9yTkgr
	 N55Tno5FGxS2dji2DW0gN9ku0CyG0yCTT1iPEDB3gqAciSAYf7zeLTETE3NFhMP0aadGLDg84f1R
	 iCvl37TOKehlKEbFmJVx6MxdtjuP6UscReRyd1uvJoWJsqUbBCJGGFxMI8dQHv
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] RISC-V: hwprobe: Add MISALIGNED_PERF key
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240529182649.2635123-1-evan@rivosinc.com>
Date: Thu, 30 May 2024 11:36:45 +0800
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Jones <ajones@ventanamicro.com>,
 Andy Chiu <andy.chiu@sifive.com>,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <4AAEA79D-BC7A-43A1-BD4E-B8CE355DEC0D@cyyself.name>
References: <20240529182649.2635123-1-evan@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 2024/5/30 02:26, Evan Green wrote:
> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
> causes problems when used in conjunction with =
RISCV_HWPROBE_WHICH_CPUS,
> since SLOW, FAST, and EMULATED have values whose bits overlap with
> each other. If the caller asked for the set of CPUs that was SLOW or
> EMULATED, the returned set would also include CPUs that were FAST.
>=20
> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
> returns the same values in response to a direct query (with no flags),
> but is properly handled as an enumerated value. As a result, SLOW,
> FAST, and EMULATED are all correctly treated as distinct values under
> the new key when queried with the WHICH_CPUS flag.
>=20
> Leave the old key in place to avoid disturbing applications which may
> have already come to rely on the broken behavior.
>=20
> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
>=20
> Note: Yangyu also has a fix out for this issue at [1]. That fix is =
much
> tidier, but comes with the slight risk that some very broken userspace
> application may break now that FAST cpus are not included for the =
query
> of which cpus are SLOW or EMULATED.

Indeed. Since the value of FAST is 0b11, the SLOW and EMULATED are 0b10 =
and
0b01 respectively.

When this key is treated as a bitmask and query with
RISCV_HWPROBE_WHICH_CPUS if a CPU has a superset bitmask of the =
requested
value on the requested key, it will remain in the CPU mask. Otherwise, =
the
CPU will be clear in the CPU mask. But when a key is treated as a value, =
we
will just do a comparison. if it is not equal, then the CPU will be =
clear
in the CPU. That's why FAST cpus are included when querying with SLOW or
EMULATED with RISCV_HWPROBE_KEY_CPUPERF_0 key now.

For me, deprecating the original hwprobe key and introducing a new key
would be a better solution than changing the behavior as my patch did.

> I wanted to get this fix out so that
> we have both as options, and can discuss. These fixes are mutually
> exclusive, don't take both.

It's better to note this strange behavior on
Documentation/arch/riscv/hwprobe.rst so users can quickly understand the
differences on the behavior of these two keys.

The C code part looks good to me.

>=20
> [1] =
https://lore.kernel.org/linux-riscv/tencent_01F8E0050FB4B11CC170C3639E43F4=
1A1709@qq.com/
>=20
> ---
> Documentation/arch/riscv/hwprobe.rst | 8 ++++++--
> arch/riscv/include/asm/hwprobe.h | 2 +-
> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
> arch/riscv/kernel/sys_hwprobe.c | 1 +
> 4 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/arch/riscv/hwprobe.rst =
b/Documentation/arch/riscv/hwprobe.rst
> index 204cd4433af5..616ee372adaf 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -192,8 +192,12 @@ The following keys are defined:
> supported as defined in the RISC-V ISA manual starting from commit
> d8ab5c78c207 ("Zihintpause is ratified").
>=20
> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains =
performance
> - information about the selected set of processors.
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated. Returns similar =
values to
> + :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`, but the key was =
mistakenly
> + classified as a bitmask rather than a value.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_PERF`: An enum value =
describing the
> + performance of misaligned scalar accesses on the selected set of =
processors.
>=20
> * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of =
misaligned
> accesses is unknown.
> diff --git a/arch/riscv/include/asm/hwprobe.h =
b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>=20
> #include <uapi/asm/hwprobe.h>
>=20
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>=20
> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h =
b/arch/riscv/include/uapi/asm/hwprobe.h
> index dda76a05420b..bc34e33fef23 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -68,6 +68,7 @@ struct riscv_hwprobe {
> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
> +#define RISCV_HWPROBE_KEY_MISALIGNED_PERF 7
> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>=20
> /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c =
b/arch/riscv/kernel/sys_hwprobe.c
> index 969ef3d59dbe..c8b7d57eb55e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -208,6 +208,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> break;
>=20
> case RISCV_HWPROBE_KEY_CPUPERF_0:
> + case RISCV_HWPROBE_KEY_MISALIGNED_PERF:
> pair->value =3D hwprobe_misaligned(cpus);
> break;
>=20


