Return-Path: <linux-kernel+bounces-257135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC49375B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CCB2202E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7FD823A6;
	Fri, 19 Jul 2024 09:29:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7581749
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381392; cv=none; b=TPNpymfmH1/Dp71hhGf/E2+PLwdIRWDnjpS9XF8KIjf3QSjGiN1fkCvmtfsWJfSg23YtIzlJ5TWF1D0u9ZFBhymUJrFegspfZWWJ9MAXITK43DouylkbjvDdn8WkI9TIkqV5/HuiLrXWNh15kBwV08eXen9G4t+m04Is+EeCOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381392; c=relaxed/simple;
	bh=VqXNN504NyNdNrJyQ+4W8yc1WT7Ju5erP86uAsgP/wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv5xhQmQ+1n+Mq0KrXI8wiK1nr+ikiCRYBbrYCukGSWBjUqzI3sCdOa1dZrj3JTecqyLsPFK88cRlnLqk7b0nu9vHg1th7+RubmaqCeUTJCSFK+pQiUsqwUWyvqMlqkDpwhdCwmjS0M61Vs1WJD2y9W5TKmrpWcw6WOZu2jey34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46CE1042;
	Fri, 19 Jul 2024 02:30:14 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810623F762;
	Fri, 19 Jul 2024 02:29:47 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:29:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, alex.coplan@arm.com,
	catalin.marinas@arm.com, jakub@gcc.gnu.org,
	linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
	seanjc@google.com, szabolcs.nagy@arm.com, will@kernel.org
Subject: Re: [PATCH] init/Kconfig: remove
 CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND
Message-ID: <ZpoyBSv7sFW1_Mui@J2N7QTR9R3>
References: <20240718120647.1115592-1-mark.rutland@arm.com>
 <CAHk-=wjVvVfZM-cakf49j7XixrN9mNimyL0P7zZm-zoYKpp0_A@mail.gmail.com>
 <CAHk-=wjQVVXx=vu5O3MxcscKKujvjUZebfUG-QuOkBV1GrnDqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQVVXx=vu5O3MxcscKKujvjUZebfUG-QuOkBV1GrnDqg@mail.gmail.com>

On Thu, Jul 18, 2024 at 10:59:16AM -0700, Linus Torvalds wrote:
> On Thu, 18 Jul 2024 at 09:59, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let's keep the "which gcc versions are scrogged" as a separate config
> > entry, and then have this just as a
> >
> >      default n if CC_IS_GCC && GCC_NO_ASM_GOTO_OUTPUTS
> 
> Ok, I ended up playing around with this a bit more, and it ended up like
> 
>   config GCC_ASM_GOTO_OUTPUT_BROKEN
>         bool
>         depends on CC_IS_GCC
>         default y if GCC_VERSION < 110500
>         ..
> 
> with then CC_HAS_ASM_GOTO_OUTPUT just having a
> 
>         depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
> 
> in it. That looks fairly legible to me, and seems to work fine.
> 
> I left it all credited to you, since you found all the problems and
> wrote that big nice commit log. But it means that if I screwed up in
> my edits, you get the blame too. So if that happens, just point haters
> at this email and say it's all my fault.

Thanks; that all looks good to me.

Just to be sure, I ran a few quick checks (below) and the detection logic looks
sound. I also built and boot-tested defconfig for arm64 and x86_64 with the
most recent broken GCC (13.2.0), and see no problems.

Toolchains which SHOULD work:

| % usellvm 14.0.0 make ARCH=arm64 LLVM=1 -s defconfig
| % grep OUTPUT .config                               
| CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
| CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
| 
| % usellvm 13.0.1 make ARCH=arm64 LLVM=1 -s defconfig
| % grep OUTPUT .config                               
| CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
| 
| % usekorg 14.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
| CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
| 
| % usekorg 13.3.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
| CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
| 
| % usekorg 12.4.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
| CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y

Toolchains which SHOULD NOT work

| % usekorg 13.2.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig 
| % grep OUTPUT .config                                                     
| CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
| 
| % usekorg 12.3.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
| 
| % usekorg 11.4.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
| 
| % usekorg 10.5.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -s defconfig
| % grep OUTPUT .config                                                     
| CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y

Mark.

