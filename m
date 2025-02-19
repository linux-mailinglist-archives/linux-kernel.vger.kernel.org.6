Return-Path: <linux-kernel+bounces-522703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41046A3CD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D371D189CF80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A025EF8B;
	Wed, 19 Feb 2025 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBHNtxrR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5925C708;
	Wed, 19 Feb 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007848; cv=none; b=b4RRYNh3QU5i6vdPlnUM28Nb50PjDrgPGw/8deObl91ogkPM7fGL/b4ccz3mm5eI6HvpGY8R1F0+dSqcdKjoRno1dTBIV+f0ySioCzhCYGUrPt/uygYi0yYgqQO96jbGr8Lo4KOENumDWDT5D6J4CrcA6j1JXC1ZIcwMKhY1QBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007848; c=relaxed/simple;
	bh=tcH227GyjKJ5hX9Pf/elTGU/np5lpy2A5toqwS89S8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7INmG3bezhdls5+vs4DXHK8+1yyOjIYW3szu0Wmdkv4Sp2LZWa7CM/HuDHoPN2tj5Uz4gKehTFXuuY5pLotoNEWyCwGDqzHCqVFcWKz8BcSTWg6W4H3kDvX6M524T5c+T2G7QFlEnpcAr3yHJo3HVLnz47QPKVvmk6w7fiaCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBHNtxrR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f3ac22948so173546f8f.0;
        Wed, 19 Feb 2025 15:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007845; x=1740612645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyvyq2lJRxuQLrIeQSGTnuwykD7l8YgAhKyJ7T0zXzs=;
        b=dBHNtxrRK51w8UmQqrhhG60iCPgMwHYbEBChGSjr0sL/2aZYBohdHIx7LuulLQgqf7
         0dUPKPSWALFcgsybcgSFb0Bd8PV7yIBpxTMkiBxPThvaE7SUmcwmZtITD76I4l0iNhGD
         CIW4n/L1Ajn6PVtRMhmKPQ6JqXUGAw5+P1UJxVUGQu1U1Nc0KrpaNB2FFaiHbXddrAQb
         kG0U/+TQagfQZO35KyVgrfEADiyKS/jXLdKcz1rFrdbtjnsyJ2ab3egFl5MiMVJEnX+9
         iJrVwJAxJn5ndib5cF58f7D2I0NkMSIkGsZc2V8gEpRSfuQap6LTHMgS41wu2O7xDqnX
         UajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007845; x=1740612645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyvyq2lJRxuQLrIeQSGTnuwykD7l8YgAhKyJ7T0zXzs=;
        b=PN/ZeYg3SW26KuaV89hiQb04tDxD753mTA3Qe0gOF6LR++/wUxF/VeXJn8ymrTeAE7
         RIFGco6O9cXI0j/xpkxuNgEgCgj6DVYQ/4dROyXGtoIbwH38QpaFlaYobnzq7WYJk4a2
         px3OfyHPciITWsWCiNRCTXpAE3fKSA0b0YhSU+h8Sd+kbEre9zVOc3sqZneT4gnHp0IC
         YiYdW3BV4nGUiNeqEPytOIy68Mai35ScLNuE/9LJIMF6o07Pc8ChtcCUp9tnqyK0a+Tz
         WQ+WyjnNdimtbJVL7ifoBi7vM2/UnfuFTfeX4KiD0zDI08a8Y/0SVv0g2lfmRxNi2Lgf
         RbWA==
X-Forwarded-Encrypted: i=1; AJvYcCU8gV7it3rX9Oxc68a5nRiGEhpQJol/zml3T9F+Z9l/p1nhstrWqhw/GjSI3nEQdVPqfW6IwtDLgXAgYWQp@vger.kernel.org, AJvYcCUuYvXdKlOtPzMRyqGKNsUsJb/1Q5hJ9h8EK91ybNhzV9YEVYQ7UI3PFbj9hs0wqJMZKIXuC5e9uQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuMBmnuoCIZF1r8AEcglZ6jLiIqKNpgtxnaNW5Nr5fyw+oqmU
	yU1e0JluPd/bAIaifK6em2GTloLXGq5oZDcTNVcbTlxsPSJkv6v7jaVZCS4EhX3zwWrRTgcabqu
	A9QvPZ/ihCOxEVN3+cG8L1//Gdb4=
X-Gm-Gg: ASbGncv532uvWYlemZxm0qkxbzSyZYjF1Wow9Nx0pdkZrL6JFYr+EBi9uHyiMDHxXrg
	p0gf6HQI00SDQ5yvKj6UUnEGjIVPt/zMwKX/jVlOX3XNbManRunSd4IaXhifWyqCc1by7jjSYL8
	Y=
X-Google-Smtp-Source: AGHT+IGseMQ09wMlftf0S31IcDCmvH/2XCIbgKJZ4vMRGW1oprX1xhCTfYNu+V/QxrTLfB/+OtK8LLpcPdlzuT7FUW8=
X-Received: by 2002:a5d:64e6:0:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38f33f1193cmr15640895f8f.7.1740007845049; Wed, 19 Feb 2025
 15:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <7099fb189737db12ab5ace5794080458d7a14638.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <7099fb189737db12ab5ace5794080458d7a14638.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:30:34 +0100
X-Gm-Features: AWEUYZn8UfE_qbgWwdI_ZYXhFInJYUvvOaq2gnq6N0Mq2Y5hHq0QKSqyoBFpmX4
Message-ID: <CA+fCnZf16dzSjOLSeWXMaJLUR-b9x9_CY0JunaRaet_O_XNcsQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] x86: Add arch specific kasan functions
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:18=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> KASAN's software tag-based mode needs multiple macros/functions to
> handle tag and pointer interactions - mainly to set and retrieve tags
> from the top bits of a pointer.
>
> Mimic functions currently used by arm64 but change the tag's position to
> bits [60:57] in the pointer.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  arch/x86/include/asm/kasan.h | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index de75306b932e..8829337a75fa 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -3,6 +3,8 @@
>  #define _ASM_X86_KASAN_H
>
>  #include <linux/const.h>
> +#include <linux/kasan-tags.h>
> +#include <linux/types.h>
>  #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>  #define KASAN_SHADOW_SCALE_SHIFT 3
>
> @@ -24,8 +26,33 @@
>                                                   KASAN_SHADOW_SCALE_SHIF=
T)))
>
>  #ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +#define arch_kasan_set_tag(addr, tag)  __tag_set(addr, tag)

But __tag_set is defined below. I think these need to be reordered.

> +#define arch_kasan_reset_tag(addr)     __tag_reset(addr)
> +#define arch_kasan_get_tag(addr)       __tag_get(addr)
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +
> +#define __tag_shifted(tag)             FIELD_PREP(GENMASK_ULL(60, 57), t=
ag)
> +#define __tag_reset(addr)              (sign_extend64((u64)(addr), 56))
> +#define __tag_get(addr)                        ((u8)FIELD_GET(GENMASK_UL=
L(60, 57), (u64)addr))
> +#else
> +#define __tag_shifted(tag)             0UL
> +#define __tag_reset(addr)              (addr)
> +#define __tag_get(addr)                        0
> +#endif /* CONFIG_KASAN_SW_TAGS */
>
>  #ifdef CONFIG_KASAN
> +
> +static inline const void *__tag_set(const void *addr, u8 tag)

A bit weird that __tag_set is defined under CONFIG_KASAN:
CONFIG_KASAN_SW_TAGS (or no condition, like on arm64) would make more
sense.


> +{
> +       u64 __addr =3D (u64)addr & ~__tag_shifted(KASAN_TAG_KERNEL);
> +       return (const void *)(__addr | __tag_shifted(tag));
> +}
> +
>  void __init kasan_early_init(void);
>  void __init kasan_init(void);
>  void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int n=
id);
> @@ -34,8 +61,9 @@ static inline void kasan_early_init(void) { }
>  static inline void kasan_init(void) { }
>  static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size=
,
>                                                    int nid) { }
> -#endif
>
> -#endif
> +#endif /* CONFIG_KASAN */
> +
> +#endif /* __ASSEMBLY__ */
>
>  #endif
> --
> 2.47.1
>

