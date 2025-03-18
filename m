Return-Path: <linux-kernel+bounces-566768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBAA67C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2963A7AA52F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC11DD88D;
	Tue, 18 Mar 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKMZgfEg"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C44204C39;
	Tue, 18 Mar 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323805; cv=none; b=r/PcA7i191Qmmv5G8/o9IJgigRM1QlPmuARv5rFLQgwNg8hwpaJRq78gRqlfAuLdNzImYpnRtoYr4KQabhzuVPvKbv0dYP2F32JZovXSrugajbZ+ULFfI7SF8lUPcJZjcRg6zOoI/cRk0z6wuFaYxe81Cvaqfv7DChNLTuM0IbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323805; c=relaxed/simple;
	bh=JTtJXooRaCFGaLfZgLcEkASBnuGN2RcajjeNDhmr7ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtRghsBlHyR2zcXz799pKofu0kZb219eWPFdWDhBldMZoe4RtSDwekEh4I+1rvXIfjepwS/R1Zo7qlpV+idWnLj8xNY3oKoIiptNLs8+Vo3hYirQTNdpsWRTmEvU9gWfkjLoIcNphTNdLA/iOs0k1bhkqV0SkSe47jQqfwmo+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKMZgfEg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so106287185ad.2;
        Tue, 18 Mar 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742323799; x=1742928599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvBzgKY8AnSeiJiUjk4KLtfzxZlqCpNPWgfY2kq6vxw=;
        b=TKMZgfEg3n2IFu0zA4F3kGkk2GNeKTm0sR162/7APsNi2/tmKBMEdTADpTMuVz8wxL
         VdrHYx04a6J+xit9XwEnK3xIsNVpqenLc/iCeJvsHQaIv3W7mXkFnk6xh5+EGv5euAbs
         1Tyjt3XENygsw0wyK+GFv9utafSVQ7dYBF7FpYz4JWeKApmRZyGlxsEA9XT1wMYgElTH
         QZXMO+FbdyxWNd+5OGJvmILnlM4tE5bCnu3MpMjDFDZq/F0e5RJOKreQ6SWRNDBApd5q
         2XbNJWgzkPaZdu/G3hFjMgp81Rx/zptPy1TFfcq46k8IjeIW9bgfYcAdRCAm99iLGCg4
         IE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323799; x=1742928599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvBzgKY8AnSeiJiUjk4KLtfzxZlqCpNPWgfY2kq6vxw=;
        b=KONrxlrcJ70b1RJxJmYsrV372owkXDpzjRSePHrwXqbVxxNkQ3XFXgDjeOokvJIyUA
         Lo8prNs9jBmOgNb4aE2ns/Eb92tSvHk9syqYC0kkVYGRXp05LT6gURp7BPsI+KRN7YaU
         D13fYaZvOEQRC7KxZFFkbC+6ZSx+l48dluMd4DRVUnIPwD4pA2wXXXAIHRByFBdhFPYt
         YnQKHt2cOjVSmmPQNTaRzwSD/Hqgke4xWTdt/l0NEpVOYw5pkdhnY0M8UH1EXrWXDXlF
         L+/u9lYUYD/XsTLKaDPHcvFuj5y0LinxGyAm7rhx5NSF3JdlJ01/7g0Y7OOwAG8FCGpt
         atOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV415MP8xJfIGab8t0C3A8lVzpj1Xee0efCzb+RA7yt0so8dSqAxkbQgEKEvu7IZ9bP8f17/hL3ghNtfFA=@vger.kernel.org, AJvYcCW8Oa41t/AWwScRWVEUPZ8Vi3oD17kw7DlhWxQhy1OMJCcM4V6+YW9TUn6VNImh3dIRwscA6AOq/zbGj32lLKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsL+LJBJfUxpioczM5kEXgjsWUgyifpjcGBgO6jOhOIq683jg
	qENoTHnCeetzrYNN6JbZqTdcvw87ukxAlHEufErx5HiLxhzlwtTp
X-Gm-Gg: ASbGncsu5AxyCWSo4HBtv2gGM1CX6qweCj4kZEza4zG+d/1e3zRIQ44VVnfO275X6SD
	4DopvwTIla8AVRrXNRDbm+TrW9oWCB/Dn8fZZZZuGFcmQoriVIjwU9AwRJeC9FqkxZRw4dPJWzM
	YT9uAIiirVClAaIPj3Wp0EmlDmnNoZaA5dsi37sUL5ybgaDyhIeMCb9o1C7/DeGJ8SjJ47wlOPG
	PrWrNJx66jWxSbrUtnFBCHeFsIzNfLpQi+28jQ6/2fwSg8zgjFQCuPc1+xxOJgXEPYfepVpMwq/
	R4KoSMIhXzr03NjQgRl7Gv98BUZA3pnsP9wvSdMg5MUbu6mjAUkach+oLyesUuhvpRum
X-Google-Smtp-Source: AGHT+IFMn+IzjHiArm7HU+DT958yA199541TH6ymhgP8Ofid+CL92NtDHij9ZZ3H4iHhpglgSswz0g==
X-Received: by 2002:a05:6a21:a4c9:b0:1f5:6e71:e45 with SMTP id adf61e73a8af0-1f5c12cd6b5mr25977751637.27.1742323799067;
        Tue, 18 Mar 2025 11:49:59 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9f59b3sm9451006a12.33.2025.03.18.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:49:58 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:49:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Adds bitmap.c and bitops.c Rust bindings.
Message-ID: <Z9nAVIokrWqoRiFR@thinkpad>
References: <20250318164221.1533590-1-bqe@google.com>
 <20250318174756.1625571-3-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318174756.1625571-3-bqe@google.com>

On Tue, Mar 18, 2025 at 05:45:45PM +0000, Burak Emir wrote:
> Adds helpers for bitmap.c and bitops.c to get Rust bindings
> for inline methods __set_bit and __clear_bit (these are
> non-atomic variants) as well as bitmap_copy_and_extend.
> 
> These are needed for providing a basic Rust Bitmap API.
> Update MAINTAINERS.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS                     | 11 +++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/bitmap.c           |  9 +++++++++
>  rust/helpers/bitops.c           | 13 +++++++++++++
>  rust/helpers/helpers.c          |  2 ++
>  5 files changed, 36 insertions(+)
>  create mode 100644 rust/helpers/bitmap.c
>  create mode 100644 rust/helpers/bitops.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c43d66bd85f3..50f44d7e5c6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4029,6 +4029,12 @@ F:	tools/include/vdso/bits.h
>  F:	tools/lib/bitmap.c
>  F:	tools/lib/find_bit.c
>  
> +BITMAP API BINDINGS [RUST]
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/helpers/bitmap.c
> +F:	rust/helpers/cpumask.c

Are you sure you wrote it yourself? I checked next-20250318 quickly
and found it was me!

Please build your work on top of -next as soon as you need those
bindings.

> +
>  BITMAP API [RUST]
>  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
>  R:	Yury Norov <yury.norov@gmail.com>
> @@ -4049,6 +4055,11 @@ F:	include/linux/bitops.h
>  F:	lib/test_bitops.c
>  F:	tools/*/bitops*
>  
> +BITOPS API BINDINGS [RUST]
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/helpers/bitops.c

Please make it a separate patch. That way I'll be able to ACK only
this record.

> +
>  BLINKM RGB LED DRIVER
>  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:	Maintained
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 55354e4dec14..6bd4396b9cd3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <kunit/test.h>
> +#include <linux/bitmap.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> new file mode 100644
> index 000000000000..a50e2f082e47
> --- /dev/null
> +++ b/rust/helpers/bitmap.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitmap.h>
> +
> +void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
> +		unsigned int count, unsigned int size)
> +{
> +	bitmap_copy_and_extend(to, from, count, size);
> +}
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> new file mode 100644
> index 000000000000..0ea1611b95dc
> --- /dev/null
> +++ b/rust/helpers/bitops.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitops.h>
> +
> +void rust_helper___set_bit(unsigned int nr, unsigned long *addr)
> +{
> +	__set_bit(nr, addr);
> +}
> +
> +void rust_helper___clear_bit(unsigned int nr, unsigned long *addr)
> +{
> +	__clear_bit(nr, addr);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..74e5e10694a4 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -7,6 +7,8 @@
>   * Sorted alphabetically.
>   */
>  
> +#include "bitmap.c"
> +#include "bitops.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog

