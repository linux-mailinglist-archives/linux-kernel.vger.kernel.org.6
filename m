Return-Path: <linux-kernel+bounces-560261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E96A60124
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DDD17F083
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412771F30BB;
	Thu, 13 Mar 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gCTXiXIb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566011E8353
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894014; cv=none; b=Lm7WJoZuLQ+zxkmfKoBBjKJYXg6Ng+8RivA6NPfbNQp2h9p0pT20g9LkzyjtViZO/Pq937Q09TMkqtFHCKSPbqnGFAV5/0JPcmZRUrRYWn4TFCpgwNqR4YBD+T4pdD9AfjdNp5uCB5jBgTmS2+dX3sYDCDdRBYWZO4kokQEnsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894014; c=relaxed/simple;
	bh=vfobcrC7uYHl5aIagul0kneEB07/v+no5IZ0QVC8YH0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FhKBE/olLK1mz+UsBG73tdDAC00Qc5wU7RZeNg73dDQpnTKJh8EkYZAjMRYgpfdiDxA6p2ilTPyzeTVG8M7nD0Ro8Qp84ZrsrjxHpdrRXC0shsKMo973iflu4EzREcP2/hCXhORLUvvRmD161/Bx22VL4hhsiNtQSocrOHPhv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gCTXiXIb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28FCA40E022E;
	Thu, 13 Mar 2025 19:26:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Mdt4pq0Hz4x; Thu, 13 Mar 2025 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741894001; bh=FY8zFsP65DD/JJDFbnrqjcgWeFNbwzLGfQLupp2+Ho8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gCTXiXIbPa5hoXuMtzfoYLw8AFITmhONvKS5jPoHaEol3/h0QrjlsaFGr7J4sCFE4
	 JrHcnTrE6GzBmzVdw6UKfEXIoK1HEJG6D2wR2P2nPLCtxaxKJBVcfH36GQ27Ervxld
	 jjYukjSwdOq9jJnSiDZmoMM3k7sa9Cg4TDGX0LbSwSiVHoE6evOQTeGukhVqf/ypwn
	 6hbBC7KF/7EmAYK7hLOgjvg0khfNeJ0X5ezbKR7BxNgsSrpvbYsu+WatUINpBpTO8D
	 lQemMmlDi7gVYyw5jr7GOS7Zvrs+/Pequ2b2KwqvdkVK9SOsuMd9PxsYkDKIHnN30L
	 05p/juQ+1GhYMiAYgnsnfrh23msmXz7ejQvxBADa9+OVwQoO7grkEn2x+p0N8peOgP
	 2Czb2STMrUSmvFg2dMZrkxluhAMHbAgh4mycAtFrujQu1kFwJlR0j2j/z3m+EzktWm
	 S+Wwj7/Wkqhm2yq76nnAqgqKPTHUMJ7qBAD8cL/XIpOMA+Gw1OtX54O0QjbyTtUm5g
	 dwreTX6LkX7sw5xSKDEyBaDpyrhjyoem5CF2Udm/N7C1WL1qUY3E0UnAADFR3DT1uF
	 /CWbCAzh2twplLajUG+rN7UNrD2bCTujuIgnAEsIufpjA8z089YMfykgR0bOwLRoJI
	 MAGZkl2fewRAlWhzVBsRlUD4=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:266:6540:81ab:a9fd:fb89:8f56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2626040E0219;
	Thu, 13 Mar 2025 19:26:34 +0000 (UTC)
Date: Thu, 13 Mar 2025 20:26:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/asm=3A_Use_asm=5Finline=28=29_?=
 =?US-ASCII?Q?instead_of_asm=28=29_in_amd=5Fclear=5Fdivider=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250313191828.83855-1-ubizjak@gmail.com>
References: <20250313191828.83855-1-ubizjak@gmail.com>
Message-ID: <96E2026E-CEF1-4A4C-B107-7FCE2CD9121F@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 13, 2025 8:18:09 PM GMT+01:00, Uros Bizjak <ubizjak@gmail=2Ecom> w=
rote:
>Use asm_inline() to instruct the compiler that the size of asm()
>is the minimum size of one instruction, ignoring how many instructions
>the compiler thinks it is=2E ALTERNATIVE macro that expands to several
>pseudo directives causes instruction length estimate to count
>more than 20 instructions=2E
>
>bloat-o-meter reports no code size changes=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/include/asm/processor=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index 5d2f7e5aff26=2E=2E06e499ba4fe8 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -707,7 +707,7 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>  */
> static __always_inline void amd_clear_divider(void)
> {
>-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
>+	asm_inline volatile(ALTERNATIVE("", "div %2", X86_BUG_DIV0)
> 		     :: "a" (0), "d" (0), "r" (1));
> }
>=20

So there's no point for this one=2E=2E=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

