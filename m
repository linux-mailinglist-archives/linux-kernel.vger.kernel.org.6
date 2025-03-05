Return-Path: <linux-kernel+bounces-547111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902CA50325
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDCF188967A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207A24EF66;
	Wed,  5 Mar 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YGFw0zVy"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617D24EF7B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186915; cv=none; b=TRjceW1jG7qA3bw1IXDPfMANWVDAzuIN2Yt4/XFrG5xZArZLTxflH/pxh3iMoeh9ogulq0dHW9FUhVzdZE+aUzud6Dpt+8iJhThGQuICPMfDnWQ29QI1Oha27NaaAetXl/7mOlqOCZvo4sO10zZUObywwQ81uLfVG4hznyfFlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186915; c=relaxed/simple;
	bh=zKKT2DNZYDc2x71LTbFaTEx2RuLk5HlEdgpYM1jM5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCGP70bZG+uJhfZjLzP+1hS6DJwi+ZMEY9sM7f8hNSgSCOhW5fjhGxMi165vJCs7Y4+AB1YmzZLWRTeHwEMDn5iIEEBDUznvRKBfrOLttInY9AiAN/pUJ/KqLuogMWbMf4cGzPGvfEfaNoLqX6skgCalHkd48DD9vlp/9CTg9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YGFw0zVy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1824199f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186911; x=1741791711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdG7Oh58MvZC/b9QkwGcr8sXSCEuBrBHhrkMxJGjcHU=;
        b=YGFw0zVy3WSA/6putAI2jgf/T8d0KSL3U2g2Z5+AyHEbwchjI242tsnm0yHuNenBli
         ydsP/WwSZbzp3FUtJ3t8JQX+CRCrDCWTRqClGJJ7E/vHo0gaovd0ZJiZT3kEMdqmVF7b
         okHcO2JIGYM3j0SUooA2qN+55hwRqhbEoK9GUNRDqYJiqYR8SmuL3tEbiD6Yml/ixA4d
         Uzn60Hc2ayvlsHE029gVCuILOkVrvjwj4fk2MYeNjIrsIBQ40hs6eZ+xacQzAg2bYzNH
         buhW0oy2nTn77waUl72nc/kiNl8t4aZitQSjKGlqLDwTkfa21rc/ix+r4iRQXa1YrAUb
         3oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186911; x=1741791711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdG7Oh58MvZC/b9QkwGcr8sXSCEuBrBHhrkMxJGjcHU=;
        b=vt5vO7Li/m6fRITiKl3D8uUFeOPeBmpzf7kPq/9i9/G/83VlzkuP443lDSyT4UL4+E
         s9CRkuZ2BAfy0hl+5vW0yGaDtJiDtHBOGvzMKV9qAWMyJ7pB9fijUFJv7oTdt2EryGaG
         7NTAM7jd1bflpmiqpoPbnZcYHmWPyE34ylt4mvMj6x5mbqjAOD87F6HGEK3zHtf8Gjf6
         rUOzOT+adrAalY+CKez/tHsF0bpASOFOaTPxcZFpMA071VltX+Xf8yPRVIFb+hAoGjsP
         utxXlqfL0WDTfr/nbo6CC4NPCYkuEieD+8R5z+egJ7KwO+zwG31GVcNJqaBu/ZctsibA
         uMzA==
X-Forwarded-Encrypted: i=1; AJvYcCW0yUta0TCBi+Q56ts9LjdNIn3b+wvfoqHPH6LFEQozq6jkq7jOBS3b1mFXbYQxVsYXFBobxOVAa1yvtTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KUpnvk9TK2VM8UW1aDbAy3ddOhGXepp1vi/9UdsVZ05NtgsF
	bs0yTgnNIloouR0Hb0WOsxKuzN1waw5CHAg8B6iCo62InSiKqy0cLsqpDJTKFW0=
X-Gm-Gg: ASbGnctNW7LQWUy8Ju41v2V1HVKzcOKoj87h5ERbSsfE/p2HGtqWbWfzVMRD9NZKcTz
	ab7PX9GZ+oMtfAevYyjYz49kUfIJK7GUxMhXu98qqQSMuUkQtIWTu4BrzMY/TmXWe29ObZ7a64I
	VetEPXGyuvWsCxZx2st7pKdTMtG++bf0aHUv2OEtrZb7h16kKc5gCwi3wnJx1K0nayJwTaAJrLy
	p/rzvtfhKe/HfiAXdjGiGd3qPagTec6QyfEV91Xy4xaX1c3Vnnh3S04J94LuE0b4FGUy7n/vy2B
	cUyunCh7BjkGscTfF4u6wKjDFQ1r81qXQAHq3Dn3XqN+Oqo=
X-Google-Smtp-Source: AGHT+IGqBRaV7VEC5+Vtf+25z+O2urVf1kefaBeNF88lAB89SNBcrx+nzT2eKgiA1ohzGWdX3prvOw==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3911f76f519mr3471109f8f.31.1741186910970;
        Wed, 05 Mar 2025 07:01:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm21068688f8f.71.2025.03.05.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:01:50 -0800 (PST)
Date: Wed, 5 Mar 2025 16:01:48 +0100
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
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/tests/scanf_kunit.c | 95 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
> index 3bbad9ebe437..fa215a7db366 100644
> --- a/lib/tests/scanf_kunit.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -4,14 +4,10 @@
>   */
>  
>  #include <kunit/test.h>
> -#include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/overflow.h>
> -#include <linux/printk.h>
>  #include <linux/prandom.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>
>  
>  #define BUF_SIZE 1024

It would make more sense to do this clean up in the 3rd patch
where some code was replaced by the kunit macros.

Also I am not sure about the choice. It might make sense to remove
<include/printk.h> because the pr_*() calls were removed.
But what about the others? Did anyone request the clean up, please?

I do not want to open a bike shadding because different people
have different opinion.

I would personally prefer to keep the explicit includes when the
related API is still used. It helps to optimize nested includes
in the header files which helps to speedup build. AFAIK, there
are people working in this optimization and they might need
to revert this change.


> @@ -50,10 +46,9 @@ do {										\
>  	for (; n_args > 0; n_args--, expect++) {				\
>  		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
>  		if (got != *expect) {						\
> -			KUNIT_FAIL(test,					\
> -				   "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
> -				   file, line, str, fmt, *expect, got);		\
> -			return;							\
> +			KUNIT_FAIL_AND_ABORT(test,				\
> +					     "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
> +					     file, line, str, fmt, *expect, got); \

I am just curious. Is there any particular reason why
KUNIT_FAIL() is replaced with KUNIT_FAIL_AND_ABORT()?

Did the move of some tests into KUNIT_CASE() increased the number of
reported errors?

Why is _ABORT() variant used in _check_numbers_template() and not in _test()?

I do not have strong opinion. The change just looks a bit ad-hoc and
inconsistent.


>  		}								\
>  	}									\
>  } while (0)

Otherwise, the change looks good to me.

Best Regards,
Petr

PS: I suggest to wait at least one or two days with the respin. Other
    reviewers might want to add their own opinion.

