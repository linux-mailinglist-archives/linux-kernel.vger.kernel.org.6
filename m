Return-Path: <linux-kernel+bounces-402065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415659C22F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C105C1F22D37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53D1EBA1A;
	Fri,  8 Nov 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIcmiu6p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBA193081;
	Fri,  8 Nov 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086963; cv=none; b=go2fzfK590M8JNH9jXdVlkm1AXIq462s5QEASf8dj7uikMnEZKh8gWCT0YqGZsEtC/6lpJN6+9z8ki2s84sszyU7lF0cvkePtZm7Npsp45lLUjYtMFKdd+uciaT/S88JHOnJtGZkyz/kBGqAagnSf28K2F58r5ubKl1ts0m9GmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086963; c=relaxed/simple;
	bh=H6G9e/WKDFIcjg+8qKalloGBWfdFi+J+6QVFHInmJxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLqoGyM/GBQYscsbwd2UcvayNnnLS87NBFa+UjxVabJe8CdJtosvy7utkUyc7O5V/8/YFU9ykjypfrXgFDsFWiaTGpgeTSd+SvrEoke8Qi+nM5A0TCBJiweZnp3w5F8w6EcLIgVC+ALU8Kj5U3xrg1efDot6ETTbKzqnhATuwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIcmiu6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D4FC4CECD;
	Fri,  8 Nov 2024 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086962;
	bh=H6G9e/WKDFIcjg+8qKalloGBWfdFi+J+6QVFHInmJxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIcmiu6pPw6mnR2MH9U14mtULrfYBXCcVcrmKGCf4c1odKxNiAFyoGeAJDe24/jU3
	 ky8Kp9XLZkkfhPdLKjOGyCFng+ebkx7SnLSdF4+EchVaqfqOpMACT2PBcPq/TeCNTR
	 xalR4JqXI4dPkI/UCQDoajDa6dP+8L5IoU5R2CNY7HFvicF2wS2VJThZ6CXBKNOdsV
	 B4TbnClc3vCVH3oo2iG2kVlRgyHFlDyeghygiE+A47PwP3+5sLLIKSoX47b+y4DiXh
	 dBnxMRg7Gma22B6T3saJ44Pak2XB20XVyW0WehINsseTMqBCmrr/r3dWMRCOs+l4Zz
	 azLfXLozusAzA==
Date: Fri, 8 Nov 2024 10:29:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v5 1/1] x86/cpu: Make sure flag_is_changeable_p() is
 always being used
Message-ID: <20241108172920.GB2564051@thelio-3990X>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
 <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com>
 <Zy4xHC3MCtAqlSxy@smile.fi.intel.com>
 <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com>

On Fri, Nov 08, 2024 at 04:48:16PM +0100, H. Peter Anvin wrote:
> On November 8, 2024 4:41:16 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Fri, Nov 08, 2024 at 04:35:17PM +0100, H. Peter Anvin wrote:
> >> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> >> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> >> >inline functions for W=1 build").
> >
> >^^^ (1)
> >
> >> Looks good to me:
> >> 
> >> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >
> >Thank you!
> >
> >> But another question: why the hell does clang complain about an unused static inline function?!
> >
> >Does (1) shed a bit of light to this?
> >
> 
> How on earth is that supposed to work?! We have static inline functions in headers all over the place that are only used in certain circumstances. 
> 
> Is this a good thing, really? Or is it noise?

Did you read the commit message of 6863f5643dd7 or just the title?

The difference between Clang and GCC is only around static inline
function in .c files, not .h files.

  $ cat test.h
  static inline void unused_inline_in_h(void) {}

  $ cat test.c
  #include "test.h"

  static inline void unused_inline_in_c(void) {}

  static void unused_in_c(void) {}

  $ gcc -Wall -c -o /dev/null test.c
  test.c:5:13: warning: ‘unused_in_c’ defined but not used [-Wunused-function]
      5 | static void unused_in_c(void) {}
        |             ^~~~~~~~~~~

  $ clang -fsyntax-only -Wall test.c
  test.c:3:20: warning: unused function 'unused_inline_in_c' [-Wunused-function]
      3 | static inline void unused_inline_in_c(void) {}
        |                    ^~~~~~~~~~~~~~~~~~
  test.c:5:13: warning: unused function 'unused_in_c' [-Wunused-function]
      5 | static void unused_in_c(void) {}
        |             ^~~~~~~~~~~
  2 warnings generated.

I do not think there are too many instances of unused static inline
functions in .c files but Andy might be able to speak more around how
many instances he has had to fix across the tree. I can see how this
difference can be useful for catching dead code and maybe even making
code cleaner but if it proves to be too much of an annoyance for the
wider community, we could potentially discuss reverting 6863f5643dd7.

Cheers,
Nathan

