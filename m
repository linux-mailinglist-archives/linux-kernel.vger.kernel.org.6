Return-Path: <linux-kernel+bounces-432089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51499E4631
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A9BBA49BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE501F03FE;
	Wed,  4 Dec 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPPIFP2/"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BC1F03FF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341111; cv=none; b=dyC8x36mljUc493EhwMCgnbDM1CyvQF45+k1T1m9CmIsiRrA6+t67qHUx2n/ZZ8+/nt6761NZWIzoWJcEgb9s8EpTlcQaJmcjzvpwFcLub6bEIo9j/ZOZSxGlV8+OB9hul6/i2dNr9YoghTBzW14PGeFG3d/0KLtsYcype8rMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341111; c=relaxed/simple;
	bh=YQT4drBY7tScD1DUIq0hp7zQqqa+RMUYBdm9PfSPvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+SX1JW47fcPeZXgHpFB84Y39LgwKEqPk+j/XgLaXaLBACjEoOvpakuP9Pt5GXfdgQkWkdrcXd9BX0tapMkkFIbNspDApyaFxCAsVVQdD8mLcAz2Kdsszc+QQz7o0YpqXFF+wa6k21Ojlk0LighCtuLTUfppRQVAyUURCAxH2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CPPIFP2/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso139629a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733341109; x=1733945909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pEkYOP8DWRCVJGmJ8XdCFkWDl0dAyfXQuWbp6O8DcxU=;
        b=CPPIFP2/+cxYLrC0N/Zf4Pb6Ku9HUUZRmbnZ66PUR8fWI0hTof9Ef65vYboKUm2ulH
         wt+h3255dmzj5YE4NeGy0cYUYQWUwUfDb/JtIhJy873w+42TcQv8n4cpiN9opfFZCYCx
         EPbCScz0DMqNxOmdrAiX3n0eAEMNGnJm2rZTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733341109; x=1733945909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEkYOP8DWRCVJGmJ8XdCFkWDl0dAyfXQuWbp6O8DcxU=;
        b=W5IbYN3TtUK4mAyHiHJETJasRCP/YvlmVSqbwLIgTrsatTOF7a0IUxNxR+L7TwJfY3
         xJo4sbWZnnQjUd3Bs73WOHJ501Z2Ah8r5JJ1yMGc8mfAn4LP9txJ1LWzinnxnvgYRZRG
         J5JxbF9NUNZLkNM8qnnN686s/A/emmWh1UjqFD9M1KBJ42A6FbwQUqNxBGhV4VcMGmyE
         Nq6sXRiS7E1fRZptEGOZp/afM5d9CCplxCB9ir4v4maf0k4aaxeDPCVo/umgAlaAHDXo
         U2HMLw7Eq1/Zcuf2DPUU5IHE9c/0VTJc03aXHlEKNNOcbM/gci/DHc6KtmnF4d74ZTKK
         mRHA==
X-Gm-Message-State: AOJu0YweAQv3SY6Wfzmzw/oXCXaQnSF1grUiR8NIyPklwiB+hw5IKnyg
	mNjvqOev1OiRX1Xk8Gm1UVKKLf1wAkINdnXNbTATjN4R/Cx3HDfJl4qGwuQPHg==
X-Gm-Gg: ASbGnctqueW2Pee69B4KOrRZ1ELohAX0y5tQwbMlcDdoUwInsI0OTuNZ4umNtyF8T4B
	GsVDcbv7IML1FVmE8YHFDGYeoI+ITTTLlPs7IVRwEECdK+zmiVHKRHEc8TTCiK/P5wJXMZAbhv3
	NisELegAthUPWCloQaeP3fAgKpwWN/yaGl1SdSJFzVlzBrG2CgQ3mRar2bcfpinPxGQEmZ4LnXN
	vq3ZBZ78x/39cc129eW+OXWIuOzsFdxuofL8rUPze9n30E1XbWmk9TJaCL8FQgncxvoJSvvr1gK
	sjACSmEmCSCt
X-Google-Smtp-Source: AGHT+IFNB0C42TjAbUDS23zWcK1xjIKXEKMvRIoan0OfO+4kulipHTZoHnQzUMSLAmc8D4LMu5IPuQ==
X-Received: by 2002:a17:90b:2547:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2ef01274f35mr9109441a91.32.1733341109636;
        Wed, 04 Dec 2024 11:38:29 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:8ab8:57a6:96ad:47f7])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef27066dc4sm1805536a91.48.2024.12.04.11.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:38:29 -0800 (PST)
Date: Wed, 4 Dec 2024 11:38:27 -0800
From: Brian Norris <briannorris@chromium.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kees@kernel.org, nathan@kernel.org,
	yury.norov@gmail.com, linux@weissschuh.net, gjoyce@ibm.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] cpumask: work around false-postive stringop-overread
 errors
Message-ID: <Z1Cvs1xNSDQRJ1Ri@google.com>
References: <20241112124127.1666300-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112124127.1666300-1-nilay@linux.ibm.com>

Hi Nilay,

I see you didn't CC the maintainers for this file. You might consider
looking through:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
And:

$ scripts/get_maintainer.pl -f kernel/padata.c
Steffen Klassert <steffen.klassert@secunet.com> (maintainer:PADATA PARALLEL EXECUTION MECHANISM)
Daniel Jordan <daniel.m.jordan@oracle.com> (maintainer:PADATA PARALLEL EXECUTION MECHANISM)
linux-crypto@vger.kernel.org (open list:PADATA PARALLEL EXECUTION MECHANISM)
linux-kernel@vger.kernel.org (open list:PADATA PARALLEL EXECUTION MECHANISM)

I'll leave the full contents intact below for their sake, with a few
inline comments as well:

On Tue, Nov 12, 2024 at 06:11:24PM +0530, Nilay Shroff wrote:
> While building the powerpc code using gcc 13, I came across following
> errors generated for kernel/padata.c file:
> 
>   CC      kernel/padata.o
> In file included from ./include/linux/string.h:390,
>                  from ./arch/powerpc/include/asm/paca.h:16,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:23,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from kernel/padata.c:14:
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> 
> Apparentrly, above errors only menifests with GCC 13.x and config option
> CONFIG_FORTIFY_SOURCE. Furthermore, if I use gcc 11.x or gcc 12.x then I
> don't encounter above errors. Prima facie, these erros appear to be false-
> positive. Brian informed me that currently some efforts are underway by
> GCC developers to emit more verbose information when GCC detects string
> overflow errors and that might help to further narrow down the root cause
> of this error. So for now, silence these errors using -Wno-stringop-
> overread gcc option while building kernel/padata.c file until we find the
> root cause.

You might consider running this paragraph through a spelling checker if you submit a
v2.

> Link: https://lore.kernel.org/all/7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com/
> Cc: briannorris@chromium.org
> Cc: kees@kernel.org
> Cc: nathan@kernel.org
> Cc: yury.norov@gmail.com
> Cc: linux@weissschuh.net
> Cc: gjoyce@ibm.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 87866b037fbe..e5adba7a30f1 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -120,6 +120,7 @@ obj-$(CONFIG_CFI_CLANG) += cfi.o
>  obj-$(CONFIG_PERF_EVENTS) += events/
>  
>  obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
> +CFLAGS_padata.o += $(call cc-disable-warning, stringop-overread)

Personally, I'd recommend a comment here, noting that these warnings
seem to produce false positives on GCC 13+. But otherwise, this seems OK
to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  obj-$(CONFIG_PADATA) += padata.o
>  obj-$(CONFIG_JUMP_LABEL) += jump_label.o
>  obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
> -- 
> 2.45.2
> 

