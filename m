Return-Path: <linux-kernel+bounces-274040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB59471C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E8D281089
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA613B5A0;
	Sun,  4 Aug 2024 23:28:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D51755C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814116; cv=none; b=JMhnQMPucuUbSGPqD60LSkrTQ+32Xrxdh8ONFscJFuqTWkbnSyPh3YdxMcDi2sASc1K0D8mqtAvBDoUHz8YL6kGJn1slk5cPGmSRTD8j3cbSgTUQg7CNqTuUZmrl0gkzsEnYl82a/muMK/x7D9YhNTnwQhBFdo2Wzc4N+cHB4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814116; c=relaxed/simple;
	bh=UYUBNpu/sQdItWCGWZvfBNbj88e5S8vJWcZ99iNOQiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnxEJomvmzeRanJoWCj6m83b6N7/4X2MeGvRVp83aS39Z3kE9ukXrVqukvP4uXHncm/ilVIKFkK53kKKQVGYA3jlA4lYdg6aYvVDVjkJqmh35QNp68AmsM26gk11RwP5dlSgQAxRpdjXxibqGFq/YQG46mlUhYHcXrkIfq3Jcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A45FEC;
	Sun,  4 Aug 2024 16:28:51 -0700 (PDT)
Received: from [10.163.57.202] (unknown [10.163.57.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6983F5A1;
	Sun,  4 Aug 2024 16:28:24 -0700 (PDT)
Message-ID: <c834a806-215b-4375-a5e6-89954fbe7519@arm.com>
Date: Mon, 5 Aug 2024 04:58:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi: enforce non-asm rule for 128-bit bitmasks macros
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>
References: <20240803133753.1598137-1-yury.norov@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240803133753.1598137-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/24 19:07, Yury Norov wrote:
> The macros wouldn't work in all assembler flavors for reasons described
> in the comments on top of declarations. Enforce it for more by adding
> !__ASSEMBLY__ guard.

Right, this makes sense, should have added in the original patch itself.

> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/bits.h       | 2 ++
>  include/uapi/linux/const.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index bf99feb5570e..60044b608817 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -36,6 +36,7 @@
>  #define GENMASK_ULL(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>  
> +#if !defined(__ASSEMBLY__)
>  /*
>   * Missing asm support
>   *
> @@ -48,5 +49,6 @@
>   */
>  #define GENMASK_U128(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> +#endif
>  
>  #endif	/* __LINUX_BITS_H */
> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index 5be12e8f8f9c..e16be0d37746 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -28,6 +28,7 @@
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))
>  
> +#if !defined(__ASSEMBLY__)
>  /*
>   * Missing asm support
>   *
> @@ -42,6 +43,7 @@
>   * GENMASK_U128() which would then start supporting asm code.
>   */
>  #define _BIT128(x)	((unsigned __int128)(1) << (x))
> +#endif
>  
>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))

