Return-Path: <linux-kernel+bounces-522706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24EA3CDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825AF189BBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAA25E453;
	Wed, 19 Feb 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLjJMF8n"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38621B9E9;
	Wed, 19 Feb 2025 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007900; cv=none; b=asOeHtHIUpwsxCqCtsC5IkSxcfso4/Hp3rzp+NYSpVFP0BGiyUr1mJOJgoxrLBoQmXHl8Fk1FL1HwYQSL0ISR6kfKIRJnJH03+JpoaTc5wmRgKW12lZhaBO7r4w75ZiepZsFyFr7aKSuerD34n3tP+NcjzQJs4fDByKlMuOcrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007900; c=relaxed/simple;
	bh=kZFF/UGapITVALZqnqj0yQm4FGUA/GNIjxqdzKNT9gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHg/4+Wb3WI5viPliE+JdHMHzTu1iyQ6bTC++JbEuj9lUP6G6ax8rywB7OUNhz2G0k0svTliMzKPhGfGQBHKQEdVaVko9Idw7hajrhEpIqh59ZsHQe5k9gXofqm+QJr71ceNkSTaOdxQFgC8a6NGt/ctOx/68qXikxeCcEWCzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLjJMF8n; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so164293f8f.1;
        Wed, 19 Feb 2025 15:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007897; x=1740612697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmA3kpoVqZacttI/kLsBWuEw55LbtbyDIck2OB1DMsE=;
        b=eLjJMF8naIgRnHNqF9xN+eageQT+KZESvboc9hHELlHgZyr5hxRs7n5cTxndFHPMQj
         d+QqsHh3Vc+IcSB1kL5KlLFJyuQ5rQsckdfqfigwFr/eFGpPdH7docKadouBAASVlNoa
         W92cXwNGJcWp8/8LR4TWVUPD0yFYaRIjP199imgRBxqhJpgsJf58asLvijUCWXf6fnUg
         PBAKcJLi7peimm1pxLpBzKrgoAhIboWiJh1/BrMbQIiN55AkBD6qJGDttFXzhga6cEGx
         THQHjpdyo25Lm6vx5473nA6xISG2wgdEFthtVC98agQSccAnU6EKW8L9VvfRLCwuA68n
         +dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007897; x=1740612697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmA3kpoVqZacttI/kLsBWuEw55LbtbyDIck2OB1DMsE=;
        b=C7In6rB5LBceyV7aN2blOX7kC8+Lsi57NOE9CyMNjk6yghTK0F+nkSDbiGxVLGdOLl
         EwBzPffhCPmiieWfVyWL9YGlV97CujEOQcGCzZRGipzu5wZ2MQ6K4vffkXyBLh47PPoi
         2+WhITaLidEw8CvoqyAWCWBGr+/fbx9xS9g6Opav1PW4VsEEheh+ELlk5jBC2GaveRlI
         UYkkyNoMYdIKlpji4m8mmekBFbgaV9rbr1CfUf/ekwUKJjp/tV1Ymv8Ccp5Rmv1k/aW+
         i5Xos1grb3Pk36x5zkUiONBJC/vD8+cwTt83s4kIIi9L1qE+a+XiudKkpmWSEfI3YmI7
         U13A==
X-Forwarded-Encrypted: i=1; AJvYcCUj0slQeg3H+nC8koAz2Y088Z//y8K5sm09q+8zjTlj46qFyJN97lxLyR2Q5U4VWLMcYG3yeqIwPGsHxmG/@vger.kernel.org, AJvYcCXWT6KIDNVvm3obgOpKRQQXvx6G8O7a+yBYCT7fWyUhGY+jKfXRV6Sn1nDdi0c9P6hJBHSBMlyGYzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFOXDg3/KMZJQhII9eeTVLWJkkb58/SXBOloJnjzOB93kn4nk
	8StRM/EvcktAbGVvV4zgIaIrcoh+Mc17yz544L+W07adHwFDaU6xJFxvdXlvVYCA9voukChe8X0
	JI4Thf08U9nMFIO+0956X/2m/Tnk=
X-Gm-Gg: ASbGncuB4sz1XjL969eNkr1x8CUQt4CZ+mEfLd8X4yHWPiP2SsbfirzfG0g24wvzCMC
	/GQXfDWhzhP4mMOMU6p5JCTN/y55gkC97NcNTbXTWWuBx50ywWNNpHAmzJE/xS9BvBOYQqYpFuk
	M=
X-Google-Smtp-Source: AGHT+IHZfSzvxjzwwqUfoRfSbt1O6bww8e/f91PrR75G5joTfFDT2SujsALHP/CGMVLShEI4KvhD5J4ptOHfp9wh9iE=
X-Received: by 2002:a05:6000:1fa7:b0:38f:4cb4:b822 with SMTP id
 ffacd0b85a97d-38f4cb4ce41mr9832739f8f.26.1740007897194; Wed, 19 Feb 2025
 15:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:31:26 +0100
X-Gm-Features: AWEUYZnqbVnkwo7RUnRvKpv13p7_X9As-mP0O1dDctMW1ycjuPipkHqXbxnM_MQ
Message-ID: <CA+fCnZezPtE+xaZpsf3B5MwhpfdQV+5b4EgAa9PX0FR1+iawfA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] x86: Make software tag-based kasan available
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

On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> Make CONFIG_KASAN_SW_TAGS available for x86 machines if they have
> ADDRESS_MASKING enabled (LAM) as that works similarly to Top-Byte Ignore
> (TBI) that allows the software tag-based mode on arm64 platform.
>
> Set scale macro based on KASAN mode: in software tag-based mode 32 bytes
> of memory map to one shadow byte and 16 in generic mode.

These should be 16 and 8.

>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Remove KASAN dense code.
>
>  arch/x86/Kconfig                | 6 ++++++
>  arch/x86/boot/compressed/misc.h | 1 +
>  arch/x86/include/asm/kasan.h    | 2 +-
>  arch/x86/kernel/setup.c         | 2 ++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f4ef64bf824a..dc48eb5b664f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -195,6 +195,7 @@ config X86
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN                  if X86_64
>         select HAVE_ARCH_KASAN_VMALLOC          if X86_64
> +       select HAVE_ARCH_KASAN_SW_TAGS          if ADDRESS_MASKING
>         select HAVE_ARCH_KFENCE
>         select HAVE_ARCH_KMSAN                  if X86_64
>         select HAVE_ARCH_KGDB
> @@ -402,6 +403,11 @@ config KASAN_SHADOW_OFFSET
>         hex
>         default 0xdffffc0000000000 if KASAN_GENERIC
>
> +config KASAN_SHADOW_SCALE_SHIFT
> +       int
> +       default 4 if KASAN_SW_TAGS
> +       default 3

What's the purpose of this config option? I think we can just change
the value of the KASAN_SHADOW_SCALE_SHIFT define when KASAN_SW_TAGS is
enabled.


> +
>  config HAVE_INTEL_TXT
>         def_bool y
>         depends on INTEL_IOMMU && ACPI
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/m=
isc.h
> index dd8d1a85f671..f6a87e9ad200 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -13,6 +13,7 @@
>  #undef CONFIG_PARAVIRT_SPINLOCKS
>  #undef CONFIG_KASAN
>  #undef CONFIG_KASAN_GENERIC
> +#undef CONFIG_KASAN_SW_TAGS
>
>  #define __NO_FORTIFY
>
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index 4bfd3641af84..cfc31e4a2f70 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -6,7 +6,7 @@
>  #include <linux/kasan-tags.h>
>  #include <linux/types.h>
>
> -#define KASAN_SHADOW_SCALE_SHIFT 3
> +#define KASAN_SHADOW_SCALE_SHIFT CONFIG_KASAN_SHADOW_SCALE_SHIFT
>
>  /*
>   * Compiler uses shadow offset assuming that addresses start
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index cebee310e200..768990c573ea 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1124,6 +1124,8 @@ void __init setup_arch(char **cmdline_p)
>
>         kasan_init();
>
> +       kasan_init_sw_tags();
> +
>         /*
>          * Sync back kernel address range.
>          *
> --
> 2.47.1
>

