Return-Path: <linux-kernel+bounces-552139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FFCA57620
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132E01892B73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A42533DF;
	Fri,  7 Mar 2025 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2kUD9xc"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7591A8F97
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390388; cv=none; b=OPwH5h5g/W8fZD9KDfblw5yVft95F5Yns7H/41v7bz2+nkNoggr2mxw6HyirkfMWKL728emv040Hwlzsww6bP4B9iLlXxoWC+ScFW/LPhgWEYUsJL5UjKi36UoG+euIqf1K8MqcZL8wScojk1jfBZxpzaKxWKNc9uEvKZ+nW0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390388; c=relaxed/simple;
	bh=L4aJtPrE2GfnROL3oS1K4BKrQk2bSyTkmLWv+1Ga//g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1EcH6TmrX7ArfN55Wy744m485igQEoVRKvBQ006qP0TobO4+K2tTA/i9zD9LU5WqX0hMRXqpVqyU6gOvfTQpJCoddZsoao9zikn4w5P19LEjTJfqChiEa4/YJ/lQICye3s2m3KIvRNRXbL7C2p4yXJpGkhu0Qy5u2y/xTCMzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2kUD9xc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso58461439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741390385; x=1741995185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFXO9D6YwhROjoFlwWSesjCYFiKET0NT2Feon19Q6U=;
        b=k2kUD9xckJ57FamQavIRngz9SRxwGmFBVrm5lTB90cHRqkkg83eegNh0ge0KBCmfIe
         /QRw4bppDOf14fwz+RBsTHMrCwZiM3OtI9PXu/PH0zun5gk/GVI52Bci+3jX3nTorKb1
         9ACZb+alUl/YTdI6a9on1h35z8ZvxDEh6isuzEeIPw3vg18G+XkC1plEcmgfaqqGldjM
         0OHAnnRwtYXUb1o/MncUoYp7RN3ZKyDEjpZ8eXJ6V4BNBfJDQP00hJaFNUyH0gmwz5r0
         FddyrObyjEBI0OSKCGCmcbIGQxpP46NMk+D+0ZlZRoXKD/qtDRP5BrfCTN+haGvzTGyg
         Igiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390385; x=1741995185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHFXO9D6YwhROjoFlwWSesjCYFiKET0NT2Feon19Q6U=;
        b=hp6E4f1DCCvtqlPZbO8rgG8j4kPkudprGYfUq89mRJaPjA5HuwP8C0tSkbXtzgA2YI
         Bnjn97L+Y2vAtYI2llYrdOyhCpmeBCCELN0K5XT74PjdMMA9Df/xZc5cRWVxSJAjO5p3
         biL6H7kN63O2YAXGup5Sm7g4IEGY81agCtbM1EDZErei7pwkgj7oL9tbMcH7oA7AMlte
         ZPv2KoYS/IccqDMXQevy1+vWO8CpyWsNu947IT4APXBPSYT02odjAB3F83eQcMoskw7y
         v2z1CYBhuPrHJS/Spcc13BH9QwwMdx9NB5p3xWZWnckOhJPbjagyImcncyM/ohsIqxjE
         nqaw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmsjWmd8j4k2b9k1lBMeWZELTOGyxqeJPI7DiL0+iDIpm8qMOb46gu9qiYphLz4agWUP0ms1ip7pRaEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YDyyoLCxbAxS6FMTY7uAHYWxNg6CoySDpzuGC2UxQiuUKEBr
	ieg28Yqjo3rlUJ/icF7rOEYgfrnP9Kc+cBLSxqK3HjYwAudqtpl2Nsi7USNt0w==
X-Gm-Gg: ASbGncvUq4XO5ULqd0izec4RqnBpM3YEiuZRJp8uhs7PHZJ6wwsYAWmYAnAMGtkkwhf
	TIBKVXbOgKCqMmZ4OsthBaN+W11p4hK138EYiWhAfMHy1QOu06Iqs+7aXP79kdtb9tFECD4ncJ2
	Zc/gWJhUaDiixdrJhzozlTGytt7y5565CWzpfCdvBXvlC4ybVY49PQvuVeVHdr1k1BPQNihC5pz
	ezxMUHux8kzrd27O31kWvZLwlAlHSBtHyo97daZi6UZXYuKjjBcn/7rlyAUD7ND2NYXA86X+0Zt
	zaox5f4I/w5ZHvBiUqc9sotT1RO48ev5nYWmLVwRpdMtd6vpVPttewIGT23Do1zCDGjldII6bRW
	KZEA1gcdM
X-Google-Smtp-Source: AGHT+IFyRzzf7mMzUIJI4y0Th6wZ9sjI35nBIcnhd9RXwZh9GmhLYqRpDr7OO9MYwGSF0/lxYav2hg==
X-Received: by 2002:a05:6602:4006:b0:855:ac69:32a4 with SMTP id ca18e2360f4ac-85b1d053032mr663250139f.1.1741390384993;
        Fri, 07 Mar 2025 15:33:04 -0800 (PST)
Received: from google.com (26.80.59.108.bc.googleusercontent.com. [108.59.80.26])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22079b1dfsm382085173.118.2025.03.07.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:33:04 -0800 (PST)
Date: Fri, 7 Mar 2025 15:33:01 -0800
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Bill Wendling <morbo@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3] ubsan/overflow: Enable ignorelist parsing and add
 type filter
Message-ID: <upvdnfozcexlpb2x4auimec347adozkl2al4hu2yp3kfagdeyp@dqs2ft6wdmog>
References: <20250307040948.work.791-kees@kernel.org>
 <20250307041914.937329-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307041914.937329-3-kees@kernel.org>

Hi,

On Thu, Mar 06, 2025 at 08:19:11PM -0800, Kees Cook wrote:
> Limit integer wrap-around mitigation to only the "size_t" type (for
> now). Notably this covers all special functions/builtins that return
> "size_t", like sizeof(). This remains an experimental feature and is
> likely to be replaced with type annotations.

For future travelers, track the progress of type annotations over at
[1]. There's still discussion on how these will be implemented in Clang.

> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> ---
>  lib/Kconfig.ubsan               | 1 +
>  scripts/Makefile.ubsan          | 3 ++-
>  scripts/integer-wrap-ignore.scl | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/integer-wrap-ignore.scl
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 888c2e72c586..4216b3a4ff21 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -125,6 +125,7 @@ config UBSAN_INTEGER_WRAP
>  	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>  	depends on $(cc-option,-fsanitize=implicit-signed-integer-truncation)
>  	depends on $(cc-option,-fsanitize=implicit-unsigned-integer-truncation)
> +	depends on $(cc-option,-fsanitize-ignorelist=/dev/null)
>  	help
>  	  This option enables all of the sanitizers involved in integer overflow
>  	  (wrap-around) mitigation: signed-integer-overflow, unsigned-integer-overflow,
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 233379c193a7..9e35198edbf0 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -19,5 +19,6 @@ ubsan-integer-wrap-cflags-$(CONFIG_UBSAN_INTEGER_WRAP)     +=	\
>  	-fsanitize=signed-integer-overflow			\
>  	-fsanitize=unsigned-integer-overflow			\
>  	-fsanitize=implicit-signed-integer-truncation		\
> -	-fsanitize=implicit-unsigned-integer-truncation
> +	-fsanitize=implicit-unsigned-integer-truncation		\
> +	-fsanitize-ignorelist=$(srctree)/scripts/integer-wrap-ignore.scl
>  export CFLAGS_UBSAN_INTEGER_WRAP := $(ubsan-integer-wrap-cflags-y)
> diff --git a/scripts/integer-wrap-ignore.scl b/scripts/integer-wrap-ignore.scl
> new file mode 100644
> index 000000000000..431c3053a4a2
> --- /dev/null
> +++ b/scripts/integer-wrap-ignore.scl
> @@ -0,0 +1,3 @@
> +[{unsigned-integer-overflow,signed-integer-overflow,implicit-signed-integer-truncation,implicit-unsigned-integer-truncation}]
> +type:*
> +type:size_t=sanitize

Hi again future travelers, sanitizer special case list support for
overflow/truncation sanitizers as well as the "=sanitize" comes from a
new Clang 20 feature allowing SCL's to specify sanitize categories, see [2].

> -- 
> 2.34.1
> 
>

The plumbing looks correct,

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://discourse.llvm.org/t/rfc-clang-canonical-wrapping-and-non-wrapping-types/84356
[2]: https://github.com/llvm/llvm-project/pull/107332

Thanks
Justin

