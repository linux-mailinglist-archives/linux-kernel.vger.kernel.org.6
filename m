Return-Path: <linux-kernel+bounces-297863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFB95BEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2BEB2264A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF11D04A3;
	Thu, 22 Aug 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zS9TR09t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310076025
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354053; cv=none; b=rLCkRHAbH2w+GZc/ckjDI1lVA5AhO5tDYH/4hONCYS3jFMy2FxrWe+AET+WH2V4sP+kpip9/iyqZ6puyyI3xxLYx17VS0VnhJqgtrmzMdcJmrQ1WxoJFaEro1GCvWqPbMqWurzMKOxI93gI/+ZOxrmllRG1oXdhpYDY3t0la7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354053; c=relaxed/simple;
	bh=kdl9m04IeIhLS7PfVFGy7WD8kTp/VKtBqIsyLvNi4Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRsKRJhEaIVZWoz5A9Yg4Xhc7bk7q6hPhdwjG5711OOSjROSmOfNtQFOJZCM3B8CEc9tAFgaFq/v8ngqGB7YLFgY8XqWCyzP1M2kKKrOP2z1Eemt8ldxWJv0V4A6QlRVOT871zGEhT6nQHR1EkkP/Qxe8fX6/BTFQrBcUZHRYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zS9TR09t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e13e682bee1so1938582276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724354051; x=1724958851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaMcsggMRGrmcGjmkJfU9HDzyIESFhgorCuZMXV4ePU=;
        b=zS9TR09tBvX5uvvL3U44zaIz3FwnWsTDYfS4YLW+q7PK1beex0IhbvmbfYiEblMnk1
         xEUhDND7OD43WH/CGd/4JN/804TNbLj+6ZQBPJ3WasjM+wzl9LMLK4FHAsRNpDYcII35
         hIknjMi059LHD9an+JxO58xRaYlvDahCW94VSh6oqFAZ5rRikygfXE/6ICd86JghbUlD
         f4xRka6xwwlNXKFU3JuSnv1/+/6YNeFtVKM2Xr9BFVf9vytt858k8VbRgV0Pi8Fiy0jn
         QBc79DZU2cQJz570VWqGRcmsY59QmIsxPXG1Iv86vsJwpy1Sg5Gup3PC4ItDUoe6dmIo
         3kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354051; x=1724958851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaMcsggMRGrmcGjmkJfU9HDzyIESFhgorCuZMXV4ePU=;
        b=djvPC437HSt8vK5JmzhNoAlSl8o2Z27mEU0AOtFFUxZqbQvuGfXIJYMGe2Riak5yPm
         G9NClCENv1mGA/XDnRTXPC385XH1nQ4xzgC5hg63RafeIrlLZtCeEpfJ4owTS6DtsEKY
         azccRIhAbmV6+87eDpj/t4llgxT0cZATeZxBk1GWf6bRGTuaVqQn36CMorEQGnRglNcT
         LrRxplbpPdymBG/8r5IGsr1TNkOnUPPfrUZb8AYVtpBXOA2dYQ5rE4L1krpwEKlpIb2h
         j9b8sXmNhZZYilOmCW6XRY9HjAd75e52idom+jgCJsfGnRMUFRmlsg5Ru2M/EMLow88u
         Jb4g==
X-Forwarded-Encrypted: i=1; AJvYcCV4y8EKyO4iaHgFK5UMmdud7+CyMaZNv6IHMWYExt9StmKh/twSgmjX0NNlHpPpkE36q2tqcXw5Y+kx0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gmFhBlyw6eulw8FeBIhHcVyxDtSrbxceCbhalLtV/rSxgQl1
	eDyErnaIZ9LqyhDAQqKeoaU1ACwEvKreal3Tmxpvjnrk0Jk1CkJ6UNe7l84H5rOGC1c3rmqxWZw
	Jow==
X-Google-Smtp-Source: AGHT+IHBl6IuQkEvzLArh/LdYV3EHTO/Q8/miBxNSbv712XSc9lkasrB1zLI2uH/r1NHjG6hta0iQtO2RM4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6d54:0:b0:e11:6c69:72ed with SMTP id
 3f1490d57ef6-e166552f9eemr59121276.8.1724354051211; Thu, 22 Aug 2024 12:14:11
 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:14:09 -0700
In-Reply-To: <20230227174654.94641-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230227174654.94641-1-ackerleytng@google.com>
Message-ID: <ZseOAY0OIrEIGG2h@google.com>
Subject: Re: [PATCH] tools: Copy linux/align.h into tools/
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: yury.norov@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux@rasmusvillemoes.dk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 27, 2023, Ackerley Tng wrote:
> This provides alignment macros for use in selftests.
> 
> Also clean up tools/include/linux/bitmap.h's inline definition of
> IS_ALIGNED().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

FYI, an almost-equivalent change went through net/, commit 10a04ff09bcc ("tools:
move alignment-related macros to new <linux/align.h>").  It doesn't have these

  #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
  #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
  #define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))

but I'm pretty sure your use case doesn't need them, so you should be good to go.
And if not, it's easy enough to include a delta patch to add them.

>  tools/include/linux/align.h  | 15 +++++++++++++++
>  tools/include/linux/bitmap.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 tools/include/linux/align.h
> 
> diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
> new file mode 100644
> index 000000000000..2b4acec7b95a
> --- /dev/null
> +++ b/tools/include/linux/align.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ALIGN_H
> +#define _LINUX_ALIGN_H
> +
> +#include <linux/const.h>
> +
> +/* @a is a power of 2 value */
> +#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> +#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
> +#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
> +#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
> +#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
> +
> +#endif	/* _LINUX_ALIGN_H */
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index f3566ea0f932..8c6852dba04f 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -3,6 +3,7 @@
>  #define _TOOLS_LINUX_BITMAP_H
>  
>  #include <string.h>
> +#include <linux/align.h>
>  #include <linux/bitops.h>
>  #include <linux/find.h>
>  #include <stdlib.h>
> @@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
>  #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
>  #endif
>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
> -#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
>  
>  static inline bool bitmap_equal(const unsigned long *src1,
>  				const unsigned long *src2, unsigned int nbits)
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

