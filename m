Return-Path: <linux-kernel+bounces-566767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F58A67C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF14519C47D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12612204C39;
	Tue, 18 Mar 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bDZIZMNh"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15411C4A10
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323785; cv=none; b=sPAAjIVr4GpjakdwDKTknKiN04RsAm40lAcUnjwYJfbj7gddf50TdSHzAShoVIliqjCTaheHwDXNDPYqMB7ctu5IF0PrXT1ef2NLtB84a3mFmgsJWr9qwGTursXep90icC0RW3XMbcGntKOY9AcKgYQ3ylmwRt+tl/lh0+r3gN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323785; c=relaxed/simple;
	bh=2hIlV4Rjq8ZUEhLucaCijFVFt59HZyfUX5/43udPnBo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LH97dBI4XTw8Gjq7TWh/HVVZyglJHOQng2EWjagLS/8P5jUjTxscPsH/5hg043TseGaeuxOwC375+P+gLsDd6fAmdYHXaPuUraMsDCAF42XLcc3IDMTpmuIygdWzQkraSsDLnzCPtDRhg8nWdoWqPzn0tHVhPq/V02LfBnDM7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bDZIZMNh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52IImgMK1145890
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 11:48:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52IImgMK1145890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742323723;
	bh=/bolONloc1q7bOq4cOYivfMo9Ruvbjm+IsWnon4fd3w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bDZIZMNh7DPC2XzO2gu9B50WcoXWddKp8sxJLcMN/0exa2AZILUzRRQgR5kfsRYyD
	 4QXONQab8B3FazP+LrKBpHXXiYgU7NjvmNC+51wfFYx+h7e0Z0FErU7n60Qhh3K7EJ
	 AQHj0CtC2QlJQEPF7FT3yFhwKtuQPW9NXY3LCn4XmKDwI2DNJwLF3fgZwrwyngfWGR
	 ONyyqI9jv/ZAxc4gYdxUuHvlmTuOhuITYfed+fbPnHLotQRdIBKkHwVQwZD7JPJ9Ox
	 N61qqIJ/L6M+2GSSuX+LW7De918lYP+kfGHiKNhgqUNN2y7PyRS5Lgix8NamiFhHhz
	 wTQYIdr7/ZVEA==
Date: Tue, 18 Mar 2025 11:48:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
CC: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
User-Agent: K-9 Mail for Android
In-Reply-To: <20250317223039.3741082-5-mingo@kernel.org>
References: <20250317223039.3741082-1-mingo@kernel.org> <20250317223039.3741082-5-mingo@kernel.org>
Message-ID: <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 17, 2025 3:30:38 PM PDT, mingo@kernel=2Eorg wrote:
>From: Ingo Molnar <mingo@kernel=2Eorg>
>
>Convert all uses of 'unsigned int' to 'u32' in <asm/cpuid/api=2Eh>=2E
>
>This is how a lot of the call sites are doing it, and the two
>types are equivalent in the C sense - but 'u32' better expresses
>that these are expressions of an immutable hardware ABI=2E
>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Ahmed S=2E Darwish <darwi@linutronix=2Ede>
>Cc: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>Cc: John Ogness <john=2Eogness@linutronix=2Ede>
>Cc: x86-cpuid@lists=2Elinux=2Edev
>Link: https://lore=2Ekernel=2Eorg/r/20250317164745=2E4754-3-darwi@linutro=
nix=2Ede
>---
> arch/x86/include/asm/cpuid/api=2Eh | 40 ++++++++++++++++++++------------=
--------
> 1 file changed, 20 insertions(+), 20 deletions(-)
>
>diff --git a/arch/x86/include/asm/cpuid/api=2Eh b/arch/x86/include/asm/cp=
uid/api=2Eh
>index f26926ba5289=2E=2E356db1894588 100644
>--- a/arch/x86/include/asm/cpuid/api=2Eh
>+++ b/arch/x86/include/asm/cpuid/api=2Eh
>@@ -22,8 +22,8 @@ static inline bool have_cpuid_p(void)
> }
> #endif
>=20
>-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
>-				unsigned int *ecx, unsigned int *edx)
>+static inline void native_cpuid(u32 *eax, u32 *ebx,
>+				u32 *ecx, u32 *edx)
> {
> 	/* ecx is often an input as well as an output=2E */
> 	asm volatile("cpuid"
>@@ -36,9 +36,9 @@ static inline void native_cpuid(unsigned int *eax, unsi=
gned int *ebx,
> }
>=20
> #define NATIVE_CPUID_REG(reg)					\
>-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
>+static inline u32 native_cpuid_##reg(u32 op)	\
> {								\
>-	unsigned int eax =3D op, ebx, ecx =3D 0, edx;		\
>+	u32 eax =3D op, ebx, ecx =3D 0, edx;		\
> 								\
> 	native_cpuid(&eax, &ebx, &ecx, &edx);			\
> 								\
>@@ -65,9 +65,9 @@ NATIVE_CPUID_REG(edx)
>  * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
>  * resulting in stale register contents being returned=2E
>  */
>-static inline void cpuid(unsigned int op,
>-			 unsigned int *eax, unsigned int *ebx,
>-			 unsigned int *ecx, unsigned int *edx)
>+static inline void cpuid(u32 op,
>+			 u32 *eax, u32 *ebx,
>+			 u32 *ecx, u32 *edx)
> {
> 	*eax =3D op;
> 	*ecx =3D 0;
>@@ -75,9 +75,9 @@ static inline void cpuid(unsigned int op,
> }
>=20
> /* Some CPUID calls want 'count' to be placed in ECX */
>-static inline void cpuid_count(unsigned int op, int count,
>-			       unsigned int *eax, unsigned int *ebx,
>-			       unsigned int *ecx, unsigned int *edx)
>+static inline void cpuid_count(u32 op, int count,
>+			       u32 *eax, u32 *ebx,
>+			       u32 *ecx, u32 *edx)
> {
> 	*eax =3D op;
> 	*ecx =3D count;
>@@ -88,43 +88,43 @@ static inline void cpuid_count(unsigned int op, int c=
ount,
>  * CPUID functions returning a single datum:
>  */
>=20
>-static inline unsigned int cpuid_eax(unsigned int op)
>+static inline u32 cpuid_eax(u32 op)
> {
>-	unsigned int eax, ebx, ecx, edx;
>+	u32 eax, ebx, ecx, edx;
>=20
> 	cpuid(op, &eax, &ebx, &ecx, &edx);
>=20
> 	return eax;
> }
>=20
>-static inline unsigned int cpuid_ebx(unsigned int op)
>+static inline u32 cpuid_ebx(u32 op)
> {
>-	unsigned int eax, ebx, ecx, edx;
>+	u32 eax, ebx, ecx, edx;
>=20
> 	cpuid(op, &eax, &ebx, &ecx, &edx);
>=20
> 	return ebx;
> }
>=20
>-static inline unsigned int cpuid_ecx(unsigned int op)
>+static inline u32 cpuid_ecx(u32 op)
> {
>-	unsigned int eax, ebx, ecx, edx;
>+	u32 eax, ebx, ecx, edx;
>=20
> 	cpuid(op, &eax, &ebx, &ecx, &edx);
>=20
> 	return ecx;
> }
>=20
>-static inline unsigned int cpuid_edx(unsigned int op)
>+static inline u32 cpuid_edx(u32 op)
> {
>-	unsigned int eax, ebx, ecx, edx;
>+	u32 eax, ebx, ecx, edx;
>=20
> 	cpuid(op, &eax, &ebx, &ecx, &edx);
>=20
> 	return edx;
> }
>=20
>-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf,=
 u32 *regs)
>+static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
> {
> 	regs[CPUID_EAX] =3D leaf;
> 	regs[CPUID_ECX] =3D subleaf;
>@@ -141,7 +141,7 @@ static inline void __cpuid_read(unsigned int leaf, un=
signed int subleaf, u32 *re
> 	__cpuid_read(leaf, 0, (u32 *)(regs));		\
> }
>=20
>-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subl=
eaf,
>+static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
> 				    enum cpuid_regs_idx regidx, u32 *reg)
> {
> 	u32 regs[4];

So in addition to avoid the in/out pointer hack, I would like to point out=
 that cpuid() is now *exactly* the same as cpuid_count with a count of 0 (w=
hich is probably a good idea anyway=2E)

One more thing is that we ought to be able to make cpuid a const function,=
 allowing the compiler to elide multiple calls=2E (Slight warning for featu=
re-enabling MSRs changing CPUID), but that would require changing the API t=
o returning a structure, since a pure or const structure can't return value=
s by reference=2E

