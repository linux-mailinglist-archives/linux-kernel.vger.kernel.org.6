Return-Path: <linux-kernel+bounces-539269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F5A4A2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D3189A2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317261C54BF;
	Fri, 28 Feb 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ht/lGsCH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E81AB52D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770899; cv=none; b=m7GaRROLQXE/S3NeiuOxeji4idXZ9gqw3V2aqMMqKdOHEZvv0sSYoKlIAkx5gpDPWKaZsvLRwXTlktvh0NpNDDvPX0B7IKbqDgXl9Ih+85Ioi82aYnB1rRAV5YuIEFcgI2NnKqzNRDVANdsicIBrj7MQZk4t23dBpxRozQnlzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770899; c=relaxed/simple;
	bh=bMNE1+FtXthtBV6xe6/WKypQlZMCOZD4DwDJEHmThwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVo/q/XBwqzYTNOaYoGpIV+/q8rvqRudjGekp7r/uH5q2DHEPXp+8Iihge6cChxRYqLG/JTde5BF8sktP/svIwFCa/XP8mgG+e9HtU0gFG45fOGVXX0zPJBlTF4DN1tBFtA7kj95E64Nci4dTERC5DvRtyyWLUTqLi64VSHgF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ht/lGsCH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 195A840E01AE;
	Fri, 28 Feb 2025 19:28:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zk7zKt3Z1Gos; Fri, 28 Feb 2025 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740770891; bh=hbKSqT5ogdcwFG9GwwLyiZqAO8sr+LZDOMZ2DyDjSpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht/lGsCHgAlua+8daF04DXGqC7WPz0wygWFN8zRTqMnFFDrvMQmS0L2raMSrPHZCc
	 s6AIDxkWnMj0fhhASTz5uia6R4Rkk17ePut6uElEanlA1QS4xiNKKdK1wtSTNU0WQa
	 KLvMlbg5Pwm/NWElXZR8sA7DeqrEMsNN23EiDwAbfhC59WvxAbwRigHjUp3ShDyl0/
	 jTmXOHedL/ksMfDbcdB0f2Y2e1oZFfWwfxeRj9XSfg/0nmhWuWA0ZqjnjOqqbyEEnY
	 x1gMqgjUsCLl9jEW9WqZGd5UpsIZAi3+hFbS298WIDbQrL5y1vDUCTZvkcGeDbDWHq
	 MeOp3lvLxC+GDUZLV1FLRk1T7As/BezKAz47+MISdI+yL/JQ7hXQSKT59hyM0n29A+
	 Yoi5EX13MG5jyvJP6KiDkX8y8bd0GyrseZaRCInjK2Einl8h2yLE0aAxB8oSZAXIED
	 QDhofx7SZRjKVEkT8bTEKf518w0C6JlsgNEF7StY8G3u6ciso0Qsyg51Tc64eaznNi
	 J+bC93oJkwgaE3vHbQfhjQtTAySqVMtfnypyrwGfSBMOADxu0sIVQWBQTb5R7qR4BR
	 gJP1veaqXWHWfQfu2Q1MMYK+4Pc86R6R2zY/gsR8r7ZgSxoih9OPZ6y8wZCSPuJay+
	 GiRQ41XxlZsA21dEI4GgujvY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A615F40E0173;
	Fri, 28 Feb 2025 19:27:52 +0000 (UTC)
Date: Fri, 28 Feb 2025 20:27:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 02/13] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250228192747.GFZ8IOM2WkIx1lbCt1@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-3-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:37PM -0500, Rik van Riel wrote:
> The CPU advertises the maximum number of pages that can be shot down
> with one INVLPGB instruction in the CPUID data.
> 
> Save that information for later use.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  arch/x86/Kconfig.cpu               | 4 ++++
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/tlbflush.h    | 3 +++
>  arch/x86/kernel/cpu/amd.c          | 6 ++++++
>  4 files changed, 14 insertions(+)

As discussed, changed ontop.

 diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
-index 2a7279d80460..981def9cbfac 100644
+index f8b3296fe2e1..63864f5348f2 100644
 --- a/arch/x86/Kconfig.cpu
 +++ b/arch/x86/Kconfig.cpu
-@@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
+@@ -334,6 +334,10 @@ menuconfig PROCESSOR_SELECT
  	  This lets you choose what x86 vendor support code your kernel
  	  will include.
  
@@ -37,14 +36,14 @@ index 2a7279d80460..981def9cbfac 100644
  	default y
  	bool "Support Intel processors" if PROCESSOR_SELECT
 diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
-index 508c0dad116b..b5c66b7465ba 100644
+index d5985e8eef29..c0462be0c5f6 100644
 --- a/arch/x86/include/asm/cpufeatures.h
 +++ b/arch/x86/include/asm/cpufeatures.h
-@@ -338,6 +338,7 @@
+@@ -330,6 +330,7 @@
  #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
  #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
  #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
-+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instruction supported. */
++#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instructions supported */
  #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
  #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
  #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
@@ -63,7 +62,7 @@ index 3da645139748..855c13da2045 100644
  
  /*
 diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
-index 54194f5995de..3c75c174a274 100644
+index d747515ad013..0e2e9af18cef 100644
 --- a/arch/x86/kernel/cpu/amd.c
 +++ b/arch/x86/kernel/cpu/amd.c
 @@ -29,6 +29,8 @@
@@ -81,11 +80,11 @@ index 54194f5995de..3c75c174a274 100644
  	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
 +
 +	/* Max number of pages INVLPGB can invalidate in one shot */
-+	if (boot_cpu_has(X86_FEATURE_INVLPGB))
++	if (cpu_has(c, X86_FEATURE_INVLPGB))
 +		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
  }
  
  static const struct cpu_dev amd_cpu_dev = {
 -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

