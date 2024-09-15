Return-Path: <linux-kernel+bounces-329828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D84979674
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739581C20D70
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A591C3F33;
	Sun, 15 Sep 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkH+d+D7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCB38C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400430; cv=none; b=dGKwC0CpMX4I9ZKRqbf5SKiDta1xLJRLuhKX+f6oKjJC3gFpleQq6pk47vQLJ26Ag2r5WOZYGhuEwo+qfxnf4BgNv110FVvzTdPIXb8fmJFU2D1Pr/Pn8OUuqShxVOb+/IzHwWhCL2bTrfQoyPTBfrGwIKZANoiQ0JEgKBS9Ggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400430; c=relaxed/simple;
	bh=qpG5FvqDX9/bq3PfSZRPFDyEbORTIN4lxDZtuQvKAxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQR+6T9KUQPcT59bhhTpSBdwdRyg9QQttuYM9CaHYVdDuBgSlFZ/e3ZVqwsIQ/1IdMQ+iac7R3UEstO9F3DR4QpwX6eiaqE1vBWRu7D4cQ3ZN0+mE+VTv4GqFbPl05sbV9IWM/QngcDQKoeLAhE1mhlG/6aNqv+WYOCuUCVtibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkH+d+D7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726400428; x=1757936428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qpG5FvqDX9/bq3PfSZRPFDyEbORTIN4lxDZtuQvKAxE=;
  b=fkH+d+D7ohPTAaQVxHUNxvSey8njECKkZMPfTrj376DsD4PSyzPplh82
   j7xvTqoi7+yHU9X/yUTabD9J6UKLgzycjmMdnEtf8EXBBJU12VgSMKXb2
   yQvuSVL+fiP+5wCS5wjGpkF3N/N27ASv4FMseV7J5dILcS5uG76I/+DVp
   sQbafAN41VDQT9XN+bM7RfgnNuQb0gB0GVl5V7IWPd4b+IV04yrdgtVYG
   Sw22vvl/Wyrv9+u3ZHhRND4QITGBVPkgvET34pTDNhE20HD7bz7NymqMk
   axZLUybDYDWdMKkDaNUxuwxgeZUZzIj5//eqI9rypybOmT5qnQ/ciWFfE
   A==;
X-CSE-ConnectionGUID: 9UEP/fhVQ5O9bT78Lw0hnQ==
X-CSE-MsgGUID: 4KG6OmrDTTaWDlm7g/TAIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="36630301"
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="36630301"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 04:40:27 -0700
X-CSE-ConnectionGUID: s0XK6YRCRK6bXZykdXmYyw==
X-CSE-MsgGUID: 7p254ljQSwOdCGac7tPY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="68307618"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.221.130]) ([10.124.221.130])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 04:40:26 -0700
Message-ID: <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
Date: Sun, 15 Sep 2024 04:40:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
To: John <therealgraysky@proton.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/24 04:05, John wrote:
> +config MAMD_CPU_V2
> +	bool "AMD x86-64-v2"
> +	depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG_VERSION >= 120000)
> +	depends on X86_64
> +	help
> +	  AMD x86-64 CPU with v2 instructions.
> +	  Run equally well on all AMD x86-64 CPUs with min support of -march=x86-64-v2.

If these are going to be exposed to end users, we need *some* kind of
help text that helps end users select among these options and what the
pitfalls are.

I actually don't have the foggiest idea what an "AMD x86-64 CPU with v2
instructions" even is.  Even saying "AMD x86-64 CPU" isn't super helpful
because "AMD x86_64" is kinda a generic way to refer to all the 64-bit
x86 CPUs, Intel included.

I assume that the compilers have grouped the CPUs into epochs that have
some similarity.  That's great and all, but we need to tell users what
those are.

Why are there v4's for both AMD and Intel that do the exact same thing?

+        cflags-$(CONFIG_MAMD_CPU_V4)	+= -march=x86-64-v4
...
+        cflags-$(CONFIG_MINTEL_CPU_V4)	+= -march=x86-64-v4

Why is this copied and pasted six times?

+	depends on (CC_IS_GCC && GCC_VERSION > 110000)...

I'm also _kinda_ surprised we don't have some kind of Kconfig option to
just pass random flags into the compiler.  That would be another way to
do this.  That would also be a, maybe, 10-line patch.

Alternatively, anyone wanting to do this could just hack their makefile
or (I assume) pass CFLAGS= into the build command-line.  Why is
something like that insufficient.

In the *WORST* case, we shouldn't be doing this with bools.  Do this:

config X86_MARCH_VER
	int "Compiler Micro-Architecture Level"
	range 2 4
	depends on (CC_IS_GCC   && GCC_VERSION   >  110000) ||
                   (CC_IS_CLANG && CLANG_VERSION >= 120000)
	depends on EXPERT
	depends on X86_64
	help
	  Specify a specific compiler "micro-architecture" version.
	  You might want to do this when...
	  You can find the best version for your CPU here...
	  The pitfalls of this option are...

Then you can do fun like:

 config X86_L1_CACHE_SHIFT
 	int
	default "7" if MPENTIUM4 || MPSC
+	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || ...
+		       X86_MARCH_VER >= 2

which has the added advantage of never needing to be touched when v5
gets added.

Oh, and this:

>  config X86_HAVE_PAE
>  	def_bool y
> -	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
> +	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64 || MAMD_CPU_V2 || MAMD_CPU_V3 || MAMD_CPU_V4 || MINTEL_CPU_V2 || MINTEL_CPU_V3 || MINTEL_CPU_V4

is rather silly when M*_CPU_V* all:

	depends on X86_64

right?

So, taking a step back: Please convince us that this is something we
want to expose to end users in the first place, as opposed to having
them hack makefiles or just allowing users a string instead of using the
existing CONFIG_M* Kconfig options.

Then, we can discuss the structure of these options.  Should these
"versions" be new "Processor family" options?  Or, should they be
_instead_ of selecting a "Processor family"

Then, should the new Kconfig options be a series of bools, or an int?

Last, how do we deal with multiple vendors?  Or do we need it at all?
I'm not actually sure at all why this has the AMD versus Intel
distinction at all.

