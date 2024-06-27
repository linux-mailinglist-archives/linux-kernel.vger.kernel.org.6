Return-Path: <linux-kernel+bounces-232710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1F91AD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F38D1C24D57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4077199E89;
	Thu, 27 Jun 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoBUZh3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFA18040;
	Thu, 27 Jun 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507742; cv=none; b=Ja+TTpAyPCt2ZNpkurqcPdC1YG72Wd4ZXCquo+OV1P4MSi0vQf1T46cu1uewUBPJCk35BsvlBdxj2X8udTorWT2h6ESJYmvNSZrwBnb9WwnaEF5q+zjM2uU5D5m4bOdjha6A2CD78w7cc22X0MCQ0eTUlInMZkyfs8+CqHDR2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507742; c=relaxed/simple;
	bh=SjeeyRQwE/Gd/xv/dHmc+00VP8GHf3kSuSkKYxNX2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDqRmBtuaVBt8U4CWOiddfKwNkiABUGtnROwp1r4ffD+/2tT/HMU4wYgTRzApILw6LTkJW0hVQV6Pez/wENcFSM32B8G2ck6UMoP8KyV5qapR/lUr0btsRyrTa7qzMC5riTIz+W7EXwWwHHwENYIqfJiMyauDBn3ytNvT0Remw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoBUZh3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EDC2BBFC;
	Thu, 27 Jun 2024 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719507741;
	bh=SjeeyRQwE/Gd/xv/dHmc+00VP8GHf3kSuSkKYxNX2cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoBUZh3SmyCAVqjkIKH98iruRgLZjNlsFfGG5ghtoGgun3ornA28W7v3tOecwcE/X
	 ZthwgQP7wsf3WMvm2jY5bL+S7ssUDTQzsGRE1kafdVNIPSZmhuiGOlUr5EDEOXsfK+
	 hGj6x8lJFoHOnq7kyp2cgPOVyj1RnfZ6Euus/sxeaLrzHayNx8JFlKq8Z1VTyjVrT3
	 5KTWSsvlrKiC9R/qU+JDLDv+wYo6LfQZALUCEbKgZDSqmVllclAZCUoTDr+PgYTYkt
	 FPMhvXCi8Dl57paU3l9+YfGpAJBlkis2ki25kPd0qruY8oy/fK8XJnt3F9HpwbXzb4
	 RhSZcRt7HcpMQ==
Date: Thu, 27 Jun 2024 10:02:21 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux@armlinux.org.uk,
	ardb@kernel.org, arnd@arndb.de, afd@ti.com,
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk,
	eric.devolder@oracle.com, robh@kernel.org, masahiroy@kernel.org,
	palmer@rivosinc.com, samitolvanen@google.com, xiao.w.wang@intel.com,
	alexghiti@rivosinc.com, nathan@kernel.org, jan.kiszka@siemens.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
Message-ID: <202406271001.67295EE@keescook>
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
 <CACRpkda-FZmyEyMJrKTdic4t8Zq_VSW8AVrvw6t=B25fiUZNKw@mail.gmail.com>
 <ee44c444-ab5e-b9c2-087b-5db627a72749@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee44c444-ab5e-b9c2-087b-5db627a72749@huawei.com>

On Thu, Jun 27, 2024 at 03:53:14PM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/6/24 15:30, Linus Walleij wrote:
> > On Mon, Jun 24, 2024 at 4:33 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> > 
> >> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> >> stackleak common code: on_thread_stack(). It initialize the stack with the
> >> poison value before returning from system calls which improves the kernel
> >> security. Additionally, this disables the plugin in EFI stub code and
> >> decompress code, which are out of scope for the protection.
> >>
> >> Before the test on Qemu versatilepb board:
> >>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> >>         lkdtm: Performing direct entry STACKLEAK_ERASING
> >>         lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
> >>
> >> After:
> >>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
> >>         lkdtm: Performing direct entry STACKLEAK_ERASING
> >>         lkdtm: stackleak stack usage:
> >>           high offset: 80 bytes
> >>           current:     280 bytes
> >>           lowest:      696 bytes
> >>           tracked:     696 bytes
> >>           untracked:   192 bytes
> >>           poisoned:    7220 bytes
> >>           low offset:  4 bytes
> >>         lkdtm: OK: the rest of the thread stack is properly erased
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > I was digging around to see if this would interfere with BPF
> > trampolines, but the
> > BPF code seems so generic that I assume it already takes stackleak into account.
> > 
> Thank you very much, as Kees said, can this patch go via
> rmk's patch tracker now?

Probably yes (we have some reviews now). Please go ahead and add it there.

-- 
Kees Cook

