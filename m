Return-Path: <linux-kernel+bounces-193997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF78D3540
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F7D28B2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58F16EBFB;
	Wed, 29 May 2024 11:14:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46188167DBD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981271; cv=none; b=LaBHki1f56Bsq9LJofOBEbk1S6sQxetJF7Os6jepZxm/s3dBuTwl+8vY+NK/5Edy3akPslWUFpK+dOL+Cneoca7viZsWFRuB4dxp9dalZ0JzkU+tnDbBDuoPXRHqCbaYLlW2x0hCWunmMJSLz2g5PdcqDQILWDbRY/XkHKUmOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981271; c=relaxed/simple;
	bh=2iOnoOqaH1ns/TUfviGdLnP1bua85YpsSllsgPuidfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QntT4UBNk5sdqdccR4U7YQttv8rn4ZFRaEBbQGerGGN0EUwkZWhTo/HA20t8D+Nrx6iOjBgU8oKNT00VR2lub8dNOgyMk2k1OU9iCBPgRylqRUX/Z8hlS8vLHe7yQ3nmZsCT1FwJk2SFX07N+n+YWJ868Zib+V1iNsTd4vmbDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5E2339;
	Wed, 29 May 2024 04:14:51 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B335E3F792;
	Wed, 29 May 2024 04:14:25 -0700 (PDT)
Date: Wed, 29 May 2024 12:14:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Message-ID: <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
References: <20240528120844.3523915-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528120844.3523915-1-arnd@kernel.org>

On Tue, May 28, 2024 at 02:08:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations __const_iowrite32_copy() does not get inlined
> and gcc runs into the BUILD_BUG():
> 
> In file included from <command-line>:
> In function '__const_memcpy_toio_aligned32',
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
> include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
>   468 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
>   193 |                 BUILD_BUG();
>       |                 ^~~~~~~~~
> 
> Add a check to ensure that the argument is in fact a constant before
> calling into __const_memcpy_toio_aligned32().
> 
> Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/io.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 4ff0ae3f6d66..44913f227060 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -199,7 +199,8 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
>  static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
>  					  size_t count)
>  {
> -	if (count == 8 || count == 4 || count == 2 || count == 1) {
> +	if (__builtin_constant_p(count) &&
> +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
>  		__const_memcpy_toio_aligned32(to, from, count);
>  		dgh();
>  	} else {

I don't think this is the right fix.

The idea was that this was checked in __iowrite32_copy(), which does:

	#define __iowrite32_copy(to, from, count)                  \
	        (__builtin_constant_p(count) ?                     \
	                 __const_iowrite32_copy(to, from, count) : \
	                 __iowrite32_copy_full(to, from, count))

.. and so __const_iowrite32_copy() should really be marked as __always_inline,
and the same for __const_memcpy_toio_aligned32(), to guarantee that both get
inlined and such that __const_memcpy_toio_aligned32() sees a constant.

The same reasoning applies to __const_iowrite64_copy() and
__const_memcpy_toio_aligned64().

Checking for a constant in __const_iowrite32_copy() doesn't guarantee
that __const_memcpy_toio_aligned32() is inlined and will actually see a
constant.

Does diff the below you for you?

Mark.

---->8----
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 4ff0ae3f6d669..f4350aae92d5d 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -153,8 +153,9 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * emit the large TLP from the CPU.
  */
 
-static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
-                                                const u32 *from, size_t count)
+static __always_inline void
+__const_memcpy_toio_aligned32(volatile u32 __iomem *to, const u32 *from,
+                             size_t count)
 {
        switch (count) {
        case 8:
@@ -196,8 +197,8 @@ static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
 
 void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
-                                         size_t count)
+static __always_inline void
+__const_iowrite32_copy(void __iomem *to, const void *from, size_t count)
 {
        if (count == 8 || count == 4 || count == 2 || count == 1) {
                __const_memcpy_toio_aligned32(to, from, count);
@@ -212,8 +213,9 @@ static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
                 __const_iowrite32_copy(to, from, count) : \
                 __iowrite32_copy_full(to, from, count))
 
-static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
-                                                const u64 *from, size_t count)
+static __always_inline void
+__const_memcpy_toio_aligned64(volatile u64 __iomem *to, const u64 *from,
+                             size_t count)
 {
        switch (count) {
        case 8:
@@ -255,8 +257,8 @@ static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
 
 void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count);
 
-static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
-                                         size_t count)
+static __always_inline void
+__const_iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
        if (count == 8 || count == 4 || count == 2 || count == 1) {
                __const_memcpy_toio_aligned64(to, from, count);


