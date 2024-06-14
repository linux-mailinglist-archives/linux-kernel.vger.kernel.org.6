Return-Path: <linux-kernel+bounces-215138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3A908E95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF20E1F23397
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D415ECD0;
	Fri, 14 Jun 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BTxB5bG0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785E13A88F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378582; cv=none; b=G5zCTnumhgURAXGIyPE4ZYCwv6St2Sb+oizePjkjXA61xNNIxOLkRxT3wWmNH+yrNKBvKx6oTTDO58jaUtVvJ6EicqOc8kxdhMEFZq0kQVUlZptaFCcCLysGRe6U+aYyCsSf2FWFEPH05hT4PSeLi0l8ufiXNiZDv3rUoU+BgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378582; c=relaxed/simple;
	bh=AUIGtfg4ICjYifW2Qgg9xhGD4jz1jAayOiH3/ZvGna4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlOTaYCgidxH1w/EpQnpOAAaZhwk1MCkNCYHpsZUQcCS344lyfMp1gFIuc4B0BAdnLS4aiCdHmwhZZDfadCdWInw5Hs+SLIF3TX6RKmB6V7i7IlTuo5mk9khdkBBGkDA0oMhObie638V0JJ5dVmbzkYw6jSvpmlFxaLmnmdBa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BTxB5bG0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A5A240E016A;
	Fri, 14 Jun 2024 15:22:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mS8hEX2i89bS; Fri, 14 Jun 2024 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718378564; bh=/L68WT4Ql/gGBaLqKy2yfzhb+B0omWRf8pJB9BKQSyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTxB5bG0Pfd9XaXUUI//Zml+RhUNtQX1WXzPp9y+Cr89sqatBdlaZT77Mn2bNZjGz
	 3ktK21VaG3q6Yc7+xIQRqbj6ILM9HpGQ4x6Oa4kzEicegk2jzZ3uXF/9POBcnj4FOg
	 2wU14XDUj3YROb9IlW/sAVnxXlQBvYCmg65DUs8LAZ/B36KHM0GUl4T9gu+ypuh98f
	 UAPRC6Zj0cW0MCm37ph4eeOpozqWIP6wbV0nFiJjPub6gHkC4m0wF4amMhRHSELdcy
	 eRY6Mklsm3oQOc8VJxuf5yE5cOp1Rh4XDi/GFdBTYeDxRCc+b0Vi2AJCIoXuRpQOy5
	 TCb9tKik9wJ1GCWpubvdYYlMqdD/Gerqzv+8uNgx9cJO+QqBasZb0v7NRDalmT7iss
	 GHIYsfqVs4WysqWGERDHxy1NKZMyl91I4FfASIXQyG60aJf0UtUjsDMoD4kzDo5ND+
	 +KVNnFS8kVJPCgsfY29tH1bbQNsDAxXBdnJkY8AKXV9POh59n/OMuEPYO14Hm2XXhO
	 VEXAn0ek/h7/Pj86lOE7BNTfXYZ9PeKQO8ekYa3w51c7jjtPoJG0025waQvXFEpH75
	 BmpBtpikZjS/4Pxlz6qEK9tX0fswQTG1iQKm997yYQ5JUXn8M/0//YOvB3gF0cK/BC
	 FJnfQ7eZ/VAnXW9Op1w/NAqE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A107940E0027;
	Fri, 14 Jun 2024 15:22:37 +0000 (UTC)
Date: Fri, 14 Jun 2024 17:22:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
References: <202406141648.jO9qNGLa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202406141648.jO9qNGLa-lkp@intel.com>

On Fri, Jun 14, 2024 at 04:15:14PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
> head:   f776e41fdcc4141876ef6f297318ab04c2382eb7
> commit: f776e41fdcc4141876ef6f297318ab04c2382eb7 [14/14] x86/alternative: Replace the old macros
> config: x86_64-buildonly-randconfig-r001-20211209 (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup

That thing comes from:

SYM_FUNC_START(vmx_do_interrupt_irqoff)
        VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
SYM_FUNC_END(vmx_do_interrupt_irqoff)

at the end of arch/x86/kvm/vmx/vmenter.S.

I know Sean had a patchset to cleanup that gunk. Sean?

From reading objtool docs, those functions (vmx_do_nmi_irqoff() too AFAICT)
should have FRAME_BEGIN/FRAME_END  but if I do that, objtool bitches
differently:

arch/x86/kvm/kvm-intel.o: warning: objtool: vmx_do_interrupt_irqoff+0xc: undefined stack state

Suggestions?

The other file it warns about is:

vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup

That is fixed by

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 89fa50d27a08..8cff4626478b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -248,7 +248,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 37596a417094..333b16181357 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1657,7 +1657,7 @@ static noinline void __init alt_reloc_selftest(void)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;", X86_FEATURE_ALWAYS)
-		: /* output */
+		: ASM_CALL_CONSTRAINT
 		: [mem] "m" (__alt_reloc_selftest_addr)
 		: _ASM_ARG1
 	);

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

