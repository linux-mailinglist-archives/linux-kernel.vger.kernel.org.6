Return-Path: <linux-kernel+bounces-552155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947CFA5764E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924E23AE170
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776F212B3C;
	Fri,  7 Mar 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vwXPcN9"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AA20F063
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390803; cv=none; b=UYzOGrQYiHGuldu6n/WcAEnjUqEkeuplj6nfjfhCkLg5kIutVMl8QjN/Qrmtl+qGe/YrJIsVwd7CUAdBdURbOkTZqWAld5OhVPYpv0Mt/JROP76uhWJRKP/3ysqcl8rso/xH1gtFGbKi4GK90xPOM0MBsGBZ4LGoP+a17YkS9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390803; c=relaxed/simple;
	bh=w436wgjGcjzJ3dyS3A6//n+WNelqPnxFh6A/g8MJI18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap8FXnTWTuTPHHV18xtivMEoGNjSjNMK5Jxdd1h+cjBdxmGNUijTraJHs4/bXh6/z0L5VpJIVn/C5qwAjnbN5FVo2jua5XbHsSWFTDhk7qs15897q7Fvg/KzIGJsh/i4XgCLu/rXSyayy9sQNf2W2bZkKwzgB0FtU6q4K9qIiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vwXPcN9; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85af81a1febso74628739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741390800; x=1741995600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDc72lD8Mhnu3NfUsPcD1oy818yB1nERuThSEkGUHkw=;
        b=4vwXPcN9EGBJ8ArVBWRV4hhuiBxfqvIWxYMwiZbdrqCsMPfdc5jLTlnroiaktJRLbm
         LTglMy81pePPJdHIi6qUoTDil3fjiSrhxYyDzkhnXFI8V0m8Zc7Br5HQJo2ASz0+8ZIM
         yaD3t/44crfxvTVhTdlycs1+v1A0W2VIkIvEXoFyHWbejQ37hsCOVtSNQ6TqScOa+C0s
         LK7ztbCcQnFMyTifJQdOFzoyjrwdOq1iIvZiVSv/tiTE4vMhUwC2blVrh14fiQyIVsfy
         aRwx8/pM4W3SGR/L1T9smglthFDByAXMQSf+jELc49CjcWOljOlS+uQzHEkKery5Edih
         ioWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390800; x=1741995600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDc72lD8Mhnu3NfUsPcD1oy818yB1nERuThSEkGUHkw=;
        b=VgFYqhHjcLJ58nhMMtkredGsh/uR63HiiTLs1p80UJmrYcgswMOR+C2hmYtHQtvS+c
         frnzrGdkjTf6l+dsdv03h6zkuGOoHtuppkLbZ5lg7qlmngMO5WW8ZVVwZnDTO3g2bGmR
         lcU+WC+O+dPFqh6diH6Lws2qxEoVNe/TCCLCyiKaQ1yVoftiQn+d3EURu44nDQLDjMg/
         aX0Jn+85fo+zg6zcbmMTftSr1W49SoSFauNFgR3E1Q/jnlhN9eYW7QaTUCm+DzC4nnv+
         zATjtmg3GIvT+jdUNdtQqc35sycEwqqOVuxDB2XbY4bZZOAGnt+GXwGHHPxWmFuaJAiq
         Wv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8CatChW7xNpFSv9RV12+9JL1XRwrAc79hWAJOp/nmBT5aHz/NjMJ0EroGOsGwIM2IE3NChqRs3jguQQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfIsakGv4bfRgxy3W5x0bHRNHxQPmHAEpaQaZbaJRuonHkqty
	TQcixNeX0bK/k4ssmP+PIKAbq/6gROp2dEavn9nbO6CXJeJAKKrIBhHMAUgqFA==
X-Gm-Gg: ASbGncumgIjOqHgFwTgdL07SQQcZSQTv9pkrR5pHLkka3duFj87PAhlZjOcVoqG0g4U
	hOG9RHyEEXCM9GcjdwjB52Lb0oELnD320YcFUqOGDGA9AvLoZ7UdOdbozC5KSXs3jMw+g2ow81d
	3EhjY2o2UTyUYfUoJbtqS2Vdh0I2Inieo4FOs2DASBcS73Jn7ViaOJrrJFfDi2gYe8ZGPG2Xzt1
	4IqS2h7fx+s0BCF+CyZ0uI1qhSK5TJBQmKtassiCjejHGHbmuJxDJPCdoOI0RPoz7zyUPT9Mqw+
	Y1stek4UH4LblItyUDff31nqvvaNhiC7mmP/G8eQ8iTOPQyjaQA+YMU+MLm5qswtfAooTmlwo09
	vrqWsC6xy
X-Google-Smtp-Source: AGHT+IE5GWqkBP7F2KuCtSZMj3O7YCqwL1LClyQ1d+IKR/y1v4SzZvWajbv9qbfRqrrAzp37TIieCQ==
X-Received: by 2002:a05:6602:474b:b0:855:9c88:7894 with SMTP id ca18e2360f4ac-85b1d03fb51mr700353139f.11.1741390800315;
        Fri, 07 Mar 2025 15:40:00 -0800 (PST)
Received: from google.com (26.80.59.108.bc.googleusercontent.com. [108.59.80.26])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06b059sm1193908173.136.2025.03.07.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:39:59 -0800 (PST)
Date: Fri, 7 Mar 2025 15:39:57 -0800
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
Message-ID: <52samxs253u3t2cmm5xwbmrwzyof36w7xczpuvbkarqwonwl32@2jbmkagpk7za>
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

On Thu, Mar 06, 2025 at 08:19:11PM -0800, Kees Cook wrote:
> Limit integer wrap-around mitigation to only the "size_t" type (for
> now). Notably this covers all special functions/builtins that return
> "size_t", like sizeof(). This remains an experimental feature and is
> likely to be replaced with type annotations.
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

Forgot to mention this in my intial reply but we have to be careful
with what types are added here. Kees, I know we're on the same page from
offline chats but for others: using sanitizer case lists to discriminate
against types for the purposes of sanitizer instrumentation may not work
properly through various arithmetic conversions. Mainly, implicit
promotions which tend to break this particular approach.

Now, for size_t we got kind of "lucky" because there are no implicit
promotions with size_t, it doesn't get promoted. This is not the case
for other types. This further necessitates the need for canonical
wrapping types backed by in-source annotations/qualification -- coming
soon in Clang.

> -- 
> 2.34.1
> 

Justin

