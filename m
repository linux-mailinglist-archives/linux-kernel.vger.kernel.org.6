Return-Path: <linux-kernel+bounces-380054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09749AE83F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47481C22828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF461E379E;
	Thu, 24 Oct 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="maAodgYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cm27pJe/"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB61D9A72
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779000; cv=none; b=aBh8I21NhkXxGxPXiB9KsVMYZn7fC5VU9jTB5IN1mcjdSvu9wgGeoYTk+uHe16Z+WjDTP7POgHt1LfAdfSnZFXLEE5KitBGQOpphTLrjKaAVX165N3eLWYUow5JU7rX9kA6yaxh0SIXsmu90tDb1CKYbDoQSpiOw52yqdXRgEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779000; c=relaxed/simple;
	bh=gi5NYNq6nMcRb/Zj3/2KY5xfSMY2Mch28E/DDO6DMug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQpjwqKah/35c8wSsuZrajXp87s+ksaJLYQnAS3HmOGxm29y/IgWNsQgdOowVii4MywlMXKUq3xcvE/9zdVF+5baTSH9QF24XmhtX8WDLA0dW5WUw2LtHldbtkBsfurm330aYpjuux19J4eGVzeRNOOfHZFuxjmQgGUcFtOm0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=maAodgYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cm27pJe/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 206D11380725;
	Thu, 24 Oct 2024 10:09:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 24 Oct 2024 10:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729778997; x=
	1729865397; bh=BablkuEKMDkouwory0yuVR+wl3esknKOue/ju6paBWQ=; b=m
	aAodgYu288Dbh8Y/Es/0sZr5/ws4kDr/e+xlbcyTs0hwkaAlDSImJYdFeXgm7DyQ
	vCpGx8TNUxoWRY8GospkcEc1sb7MTLOg3nsknB6wa+noQMBI5ATPSKZ/4+Hrhvb3
	CdW42hl/7ZArmtV7fCPn7s5SSVGeoyaZGBTKnwXLfDeZrlHIM6ss4YOIYskPMvj+
	nNDXBVTHl72782bdwatSHtUV6eQ6EnwsTMVTqdRhu9Ms7JFrNWzcqw97HlV+7ZM2
	V8V3Iz+ojjjRkvfMdbbemaE0ICildaadltbzucuNUh8i/4VL++4GVt5tFQBc3/bV
	Camo5+rW/Im7FgGZW2+sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729778997; x=1729865397; bh=BablkuEKMDkouwory0yuVR+wl3es
	knKOue/ju6paBWQ=; b=cm27pJe/ERqJHg8jZqKNWevybLqnQQ4ld8+7DLNR7nbJ
	YQDvx8GBziIVpsW1mxhi/3otYOVogPFMqtEYjsaH7NYDe1rvXU4d85sf5C/t7CL6
	C7Ht6vBMcF4N4LKxHJBHIZQ0R17ukFSLb7HzfzsQB45wIdOPfsr4qDTtLJ1v7jDc
	c/xARbnLsT0lT70bN+GmUbR6IRGsdE2IB9hbYucrveIAAV2dlBhJgog1L+GJ8my5
	G63jRDmDHSYLAZc0DLDqIijTCvP5s+D7WVrdafWwsXKAq/8Z1x4VUpjTuiKE9E+1
	2i9q3+Eg8rCObaQoSnmwiBwCHjvEuTyGZWE89waBWQ==
X-ME-Sender: <xms:NFUaZ3SwGKDwsg8MzJCfHbMo5INOaTvEAPyTsXAwm5tZsmZLTUK7hQ>
    <xme:NFUaZ4x18eNxpzkb41XZBxfkLw1c501BU4D8Ku93-4tUQNweaUXAmZfErzRXlgmBm
    vCsm1PkH3BJ_bzaELE>
X-ME-Received: <xmr:NFUaZ80s27muBWMJl26B5CQYQOFlPg0U2HtoGhK_qeSomWwI4shzYbYkm70XXSKK5jUY3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvtdfglefhtdekvdef
    kefffeeiheeuueevudeuheekgedugfeukeffheeuvdduudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhgvghtuhhsvghrrdhssgenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthho
    rhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvg
    hrfeestghithhrihigrdgtohhmpdhrtghpthhtohepjhhpohhimhgsohgvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:NFUaZ3CtcWRUH51v2OsZQS2So8UDQcAGu-t66iW8Z9q502EM9eXbqg>
    <xmx:NFUaZwg9vSVlbtTvHvylmJ1vez3AK3xbidJSHmz9PIS0o1uXfZJzyA>
    <xmx:NFUaZ7rIrsrd-lPAc0kX8ndL2MVidL-tjKuu25JREe2cKPzj3qdzEQ>
    <xmx:NFUaZ7gk2B6WzLCQP2RzTFby4fJnQmOg-_ZqKkSCTwkTkeH2EyiMkg>
    <xmx:NVUaZ7Uao_eR_TwwtGrP2Md56cD8-8StlQxpZArg7SOdrpAHNtUOxw0W>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 10:09:54 -0400 (EDT)
Date: Thu, 24 Oct 2024 17:09:49 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <zvqilmzjja2writdqrjutnoszjkjiio3zk5jcbcxmw2s7rvx2i@mdwzolbmgwzz>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024013214.129639-1-torvalds@linux-foundation.org>

On Wed, Oct 23, 2024 at 06:31:59PM -0700, Linus Torvalds wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index f1040cb64841..d671f78f658e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -69,6 +69,7 @@
>  #include <asm/sev.h>
>  #include <asm/tdx.h>
>  #include <asm/posted_intr.h>
> +#include <asm/runtime-const.h>
>  
>  #include "cpu.h"
>  
> @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
>  	alternative_instructions();
>  
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> +		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
> +
> +		/*
> +		 * Enable this when LAM is gated on LASS support
> +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> +		 */

It will be safe to uncomment it once the patch in tip/x86/urgent gets
merged[1]. We clear X86_FEATURE_LAM if kernel is compiled without LAM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=3267cb6d3a174ff83d6287dcd5b0047bbd912452

> +		runtime_const_init(ptr, USER_PTR_MAX);
> +
>  		/*
>  		 * Make sure the first 2MB area is not mapped by huge pages
>  		 * There are typically fixed size MTRRs in there and overlapping
> diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
> index d066aecf8aeb..4357ec2a0bfc 100644
> --- a/arch/x86/lib/getuser.S
> +++ b/arch/x86/lib/getuser.S
> @@ -39,8 +39,13 @@
>  
>  .macro check_range size:req
>  .if IS_ENABLED(CONFIG_X86_64)
> -	mov %rax, %rdx
> -	sar $63, %rdx
> +	movq $0x0123456789abcdef,%rdx
> +  1:
> +  .pushsection runtime_ptr_USER_PTR_MAX,"a"
> +	.long 1b - 8 - .
> +  .popsection
> +	cmp %rax, %rdx
> +	sbb %rdx, %rdx
>  	or %rdx, %rax
>  .else
>  	cmp $TASK_SIZE_MAX-\size+1, %eax

Maybe worth adding assembly macro for the runtime_ptr?

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 24e3a53ca255..563566f361f7 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
@@ -58,4 +70,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 4357ec2a0bfc..f7589d4142cd 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -32,6 +32,7 @@
 #include <asm/errno.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
+#include <asm/runtime-const.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
 
@@ -39,11 +40,7 @@
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	movq $0x0123456789abcdef,%rdx
-  1:
-  .pushsection runtime_ptr_USER_PTR_MAX,"a"
-	.long 1b - 8 - .
-  .popsection
+	RUNTIME_CONST_PTR sym=USER_PTR_MAX reg=rdx
 	cmp %rax, %rdx
 	sbb %rdx, %rdx
 	or %rdx, %rax
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

