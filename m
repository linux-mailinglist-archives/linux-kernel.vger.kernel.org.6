Return-Path: <linux-kernel+bounces-528994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEEFA41EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26E53AA3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62852571B7;
	Mon, 24 Feb 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f5qtBwvS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E31D540
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399294; cv=none; b=rhlwbtReSyL40Zvj/3c8SQ9KRL2tNSv2xO5QG4yecHoOfeIXEpnNXRpFFig0F8c3HKTzjHGnxPI7w0RFnKICoD6QP+Co6uSep4DPKo5jPTwXPN3FWFuXRDAtheNNPFrWZ6fRKlxz+UWsTS3cgtpZC9JTmsOneSDrwpeHOcqc6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399294; c=relaxed/simple;
	bh=YCh++1ULCr/r55pj5INBB3ZeU2aoKb36FwPl248cnlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azIC12nU32ATK9XOhQBYmd6zYgeJ/96uCCfAMMKa534oWwx0U0z6QGmmertOVNkpRl+g8aFDNj0ALEO8SQ/6hAJC8KNumYYXzdMrtxddOyu3ngH9amp9XEUj2ATGwd3LXuGj+x3LlOVZNK1zEPDEKaxocmsI7afi3eQk4H4EX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f5qtBwvS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E786040E01AE;
	Mon, 24 Feb 2025 12:14:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K6HgFcyKJ6Zt; Mon, 24 Feb 2025 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740399286; bh=lhImJPjIcI0AMJM7iOO1E6DHn/v6OyLBkgq4ZZyrkPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5qtBwvSoiNLuR8DI8xbFYUVsZPYy1K69o15yw+zk1YwsQ3PxPN/4eI3w5PBjev4f
	 NPxdZx2aWk6AzZ4XSZc95LefTiwwlst/g1caGg3B0bqYao8QxImsmXyeIzXwyzZxun
	 IZzJvT3PcK9LIbgeyhw84Nc88Ds83C97WrX7Kr45jMirgGcZ23La85iGJAf3VL0EzO
	 kQxlaDk3OPJSKEx6zXbeWeqS+Q8oiB7+X5DrDKI6McSlFW4coizLXfnl9t2DtnUDJX
	 Oe1iHMvbA1U1Rj2/l8LDq1dGNxrxd+GpPQnQmIB/v+KnHKeTlhIcpzSZY7HSik6Hrt
	 YRMRHR4tln45EYRkF2Vkk+DblvvVVblz+zXpf6LETYKsau+ockj9n31B+Fto52Pg7w
	 40XejAFZs5gF1tG8o2DtmNZBkMLuYx0xaR3juWsaawX3osGPWStMvV1Z7kJ/ZpdrfX
	 Uz99rXlMviPx3MdokKKbQmiRKQPAtt2GbJjeAyou9B1c31Fr4vsmU+3sr1AduVnDBg
	 vEBuOmdUHdpIyH0Hq/Ex1Pm3tLMMDbVF8paRHm2nT7Azo422Eyj2sn7O1tm2errCeI
	 8N9o5ZhnrKAVOjpFpeipBDeX5KT+1NXwx/AasGNe226DkOvNybb8DXm2/PXNM1Ucwu
	 +gbBtG7PKO7GGzBQhR36fl/M=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A79C840E0184;
	Mon, 24 Feb 2025 12:14:27 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:14:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v13 03/14] x86/mm: add INVLPGB support code
Message-ID: <20250224121421.GEZ7xinWhjstV_xPU_@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-4-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:53PM -0500, Rik van Riel wrote:
> Add invlpgb.h with the helper functions and definitions needed to use

"invlpgb.h" is stale now.

> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b05..95997caf0935 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -129,6 +129,13 @@
>  #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +#define DISABLE_INVLPGB		0
> +#else
> +/* Keep 32 bit kernels smaller by compiling out the INVLPGB code. */

No need for that comment.

> +#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
> +#endif
> +
>  /*
>   * Make sure to add features to the correct mask
>   */

...

> +/* Wait for INVLPGB originated by this CPU to complete. */
> +static inline void __tlbsync(void)
> +{
> +	cant_migrate();

I could use a comment above that one...

> +	/* TLBSYNC: supported in binutils >= 0.36. */
> +	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
> +}
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

