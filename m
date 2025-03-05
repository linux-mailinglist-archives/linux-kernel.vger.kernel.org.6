Return-Path: <linux-kernel+bounces-546808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED35A4FEF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE03AC59E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957222331E;
	Wed,  5 Mar 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxVzKQp7"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A51E7C24
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178802; cv=none; b=RExm8Fx0O7Ls8XosZcfnnGPtvvziDBDxCa8VlNeIYDPgGgrcdn9MtJvZns4f7BdbTbfmT+gJtZyz8qHuf2JF/RgE4E2EiESqbmt8/IybLm/U2eCRMnThLJvPvPvdV6SAYMZ1bNqLPXGZu6LiHHXWRrxLgj8WFSpFDYYFmZCnunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178802; c=relaxed/simple;
	bh=WdS934lDxFuI+lDi4WoiWzb2Te4Np1NHLjMjIUYas7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL5CV6W0/hOi1V/A+6BolUM67XhRj81p9X/pSSYjJ+wuAAvRfGoa5YhqwRIMKE1nCEp0WVpU40ipitWLAJkMAamB94BesdU6RFAbpDRylRMYOyiv5OPyVv2swaZjqV2Mz4D09Pb9K3ow2U2YqUHVd3vffyxU6yi8Bm6xxgk2bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FxVzKQp7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f406e9f80so5137536f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741178798; x=1741783598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KijU2RK+5QiUTMaMHbVobX3TCajOSEvmIS7Lj9sfhOM=;
        b=FxVzKQp7cZaM+4mdVVPpvwZdWqQF4tPb/k3yWkANko/ac8GB8GHSavmos/mkTnbotl
         5t7Zhj4ElTHAw+OxBE2pXfWgHFTETcwRsztNa/JGr4h9K2kMvJbq5BKrXk0oLp0lj4AD
         qOQoDggpJFK9ZdNasDnDOF2L7pjAiz1bqtub2dk05WMashNTmPaisAeCoZcRnOPs+hTF
         WN/qachUuOHOWD1HfyX9ctvMteY1n5Dc2H8vSaC4xmLqkWobwxy3ppc6+091lclOrs1k
         1glW+3HYbu5Yqkxn4XEt3uhU88PJfrVGyvET73R+pBcTyCUTzS26LhuPEyYBlTgrSQ2S
         Df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178798; x=1741783598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KijU2RK+5QiUTMaMHbVobX3TCajOSEvmIS7Lj9sfhOM=;
        b=r0bOX+VsqQoJkLAjM2qPuCEZch1Ntq9SmODW5Wxte0B8NXgl81raAibpkmEDI8ppuM
         J2jrlhGkZjq/N0dXTl2qIy5UL91O9BEAFwKpuzQ7I5j8pz1cWsDhk9ORw7iGujHCH5s4
         ZMACYhQkh5rHc/SEbbsRdYiytaEo5EEG/I1hGSH6lVXuNfsFB1NK/W+HS2LbGp+FL1CL
         NRHHruFIIe1KQEsPXs8wQL6HfTbGmWL/wJt6B9tTXDBZchvKjzm3dfhZIy0dLfT/SRsh
         +uctRc9odcLxuX8jGfpSSrmz+05sNJ6/Bcftb/puAsnZW1pY3hbtQEUgif1GtE1c1dlf
         x3qw==
X-Forwarded-Encrypted: i=1; AJvYcCX7SKiw4TAkd/kovfZGEGz1yKqCPzgSX0qAOwKokySXVnrQxf6WJJ3nHzX5KNCN4hNDKEK12N2+kRpuFx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUG+UyUxPlzjKOOL4e3d8iLEHZzBslptuiAZqmMxCGzP1pjCHs
	uhaNyDuq5rs6LajLT63BkgOvUw6lzaRkUVTIx8TnsgHDZJP2BDWrO9nTLoX16Qg=
X-Gm-Gg: ASbGncuUFJy/zPp5nvhC0qRRHw/o+MzmgPDfKEi2VKl2AK6bCkZEcq0txw1J3fflDnN
	C+rDQmgRmTdxPSi7TETXWEVLdBv744yDTQdMzmIssXWZ8zpgjVcmK4+JzQ3/xOJxTZsFJJKndPf
	LaV1RvVnoOfnZhrnRuU9rOpKv3BvCmBJA27hleu2vEc6vnEg7xYQSY7cTtmeaXwWzw1S5nK0Mdy
	RjlI4ZA8cIFH1XDQOIqh+IUf+EC3NTiivKpfxcgVv0HtDzhxGUQYICj8cEleMEY0WhusiCDF7OD
	vqlzgaONq61Q6CRk69fUhyC1G+5uskGpWB6dt+HJqqeEZjM=
X-Google-Smtp-Source: AGHT+IEPLJpRRf5FYWw3IKOdFaaLj6UT7vruoSQtSNaRt2Dkg2TweUaV2rcBDSTkZ88x2LYdtyxZrg==
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id ffacd0b85a97d-3911f7bba1fmr3029040f8f.35.1741178798392;
        Wed, 05 Mar 2025 04:46:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a9fsm21175534f8f.36.2025.03.05.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:46:37 -0800 (PST)
Date: Wed, 5 Mar 2025 13:46:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <Z8hHrIz2wwAMtQc8@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:20:00, Tamir Duberstein wrote:
> Convert the scanf() self-test to a KUnit test.
> 
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
> 
> --- a/lib/test_scanf.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -15,48 +13,35 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> -#include "../tools/testing/selftests/kselftest_module.h"
> -
>  #define BUF_SIZE 1024
>  
> -KSTM_MODULE_GLOBALS();
> -static char *test_buffer __initdata;
> -static char *fmt_buffer __initdata;
> -static struct rnd_state rnd_state __initdata;
> +static char *test_buffer;
> +static char *fmt_buffer;
> +static struct rnd_state rnd_state;
>  
> -typedef int (*check_fn)(const char *file, const int line, const void *check_data,
> -			const char *string, const char *fmt, int n_args, va_list ap);
> +typedef void (*check_fn)(struct kunit *test, const char *file, const int line,
> +			 const void *check_data, const char *string, const char *fmt, int n_args,
> +			 va_list ap);
>  
> -static void __scanf(6, 0) __init
> -_test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
> -	const char *fmt, int n_args, ...)
> +static void __scanf(7, 0)

This should be:

static void __scanf(7, 9)

Otherwise, the compilation with W=1 produces the warning reported by
the lkp@intel.com kernel test robot, see
https://lore.kernel.org/r/202502160245.KUrryBJR-lkp@intel.com

> +_test(struct kunit *test, const char *file, const int line, check_fn fn, const void *check_data,
> +	const char *string, const char *fmt, int n_args, ...)
>  {
>  	va_list ap, ap_copy;
>  	int ret;

Otherwise, it looks good to me.

With the above fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

