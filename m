Return-Path: <linux-kernel+bounces-575936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16DA7090A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060023B18C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED819CCFC;
	Tue, 25 Mar 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Uksu13au"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BF4A21
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927447; cv=none; b=D59vIaV9omn6TvHNXni7cuFTx55sZgwqaAce8JjQNpuPAFAEblNP+2+/2yJ7lfXsGur+FJ6d/WBMJuEMbxOFDDTSLI2hrxzA8EJrZFGe75uqUSyyZvu5qyTdBFrHN03EXRbhGproUpFpZrJkiLNBYlmsVxg6LJt96WVB/7oZl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927447; c=relaxed/simple;
	bh=GFciHWa7zKZwJeudy6t0Yl1lEA51mSneKqemXEUM37M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mbDLJfcobdGM3RI12OyijXgDaWbXWjghyTL6DKYdTv6C66fiGFFxUfSrYlm6otbxId4paQNQJ4/pxcrxXDc6ukLsEIfcKS2NwuCWNbzM+kwQJwaCgLQKlHspluAFpm2keWHoUddWdrX+mA2A3KnqgE6G+fF0DhPssK06i7eQykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Uksu13au; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52PITq5v581349
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Mar 2025 11:29:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52PITq5v581349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1742927394;
	bh=lodP4rIki/32R2ZZAHED9gxnEyrasBz2VvF5zROPFOY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Uksu13aua0h4em1bU7u31TQHW2hm92jPz/W9Isv6MCtKLxGgm31zqkVOmBIQ5mFhI
	 l3SHhZAXm5aHVCkB+v+xMrg33AhHgfWtsTyThgKt177JzrNhUriGeH7AfMmVNDLbHB
	 yi80VgAnynZxtc+tNYDR2QloigLqGXCOOulvlnAJJEs27PsIkc63TkVisLVLwz8/jM
	 OA29skuPVoUENMsh67gmqGblA6q5ZAhH4hej8bx9kmZOxkrUhuD0QDwuUkMY/yL3TE
	 LyL7CmxLDs7eEfU+V2Dhq9rjUOS4eTVKzEGLf5r3+pcKmyuEoKLeu6IFCXDMKGAK3E
	 uuAT6pZyRlzfg==
Date: Tue, 25 Mar 2025 11:29:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_x86/bitops=3A_Fix_false_o?=
 =?US-ASCII?Q?utput_register_dependency_of_TZCNT_insn?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250325175215.330659-2-ubizjak@gmail.com>
References: <20250325175215.330659-1-ubizjak@gmail.com> <20250325175215.330659-2-ubizjak@gmail.com>
Message-ID: <75C56CF0-A414-4AB8-BCD9-29CE5A344166@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 25, 2025 10:52:02 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Haswell and later Intel processors, the TZCNT instruction appears
>to have a false dependency on the destination register=2E Even though
>the instruction only writes to it, the instruction will wait until
>destination is ready before executing=2E This false dependency
>was fixed for Skylake (and later) processors=2E
>
>Fix false dependency by clearing the destination register first=2E
>
>The x86_64 defconfig object size increases by 4215 bytes:
>
>	    text           data     bss      dec            hex filename
>	27342396        4642999  814852 32800247        1f47df7 vmlinux-old=2Eo
>	27346611        4643015  814852 32804478        1f48e7e vmlinux-new=2Eo
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/include/asm/bitops=2Eh | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/include/asm/bitops=2Eh b/arch/x86/include/asm/bitop=
s=2Eh
>index bbaf75ea6703=2E=2E7e3d1cc97c5a 100644
>--- a/arch/x86/include/asm/bitops=2Eh
>+++ b/arch/x86/include/asm/bitops=2Eh
>@@ -248,8 +248,9 @@ arch_test_bit_acquire(unsigned long nr, const volatil=
e unsigned long *addr)
>=20
> static __always_inline unsigned long variable__ffs(unsigned long word)
> {
>-	asm("tzcnt %1,%0"
>-		: "=3Dr" (word)
>+	asm("xor %k0,%k0\n\t" /* avoid false dependency on dest register */
>+	    "tzcnt %1,%0"
>+		: "=3D&r" (word)
> 		: ASM_INPUT_RM (word));
> 	return word;
> }
>@@ -267,8 +268,9 @@ static __always_inline unsigned long variable__ffs(un=
signed long word)
>=20
> static __always_inline unsigned long variable_ffz(unsigned long word)
> {
>-	asm("tzcnt %1,%0"
>-		: "=3Dr" (word)
>+	asm("xor %k0,%k0\n\t" /* avoid false dependency on dest register */
>+	    "tzcnt %1,%0"
>+		: "=3D&r" (word)
> 		: "r" (~word));
> 	return word;
> }

Is xor better there than a mov (making it a copy of the source)? It might =
be more frequently fusable=2E

