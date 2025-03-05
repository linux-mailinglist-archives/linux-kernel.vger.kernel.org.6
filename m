Return-Path: <linux-kernel+bounces-546456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C9A4FAE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1697D16B97C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4C205AAC;
	Wed,  5 Mar 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ay0jmRYT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF0205AAA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168567; cv=none; b=pt4UAFsc1nYS1jVYDNDBE6Zp9YVKPzb563cAMzqev4V00xuF0he8UeQdj78HSlAVDswwGyB9eufrSHQkf/uAzKqLYrH3QkfkRJoed6VyeqZ4n1sshHEYAMZiYK8M+bcImYULleKMNZH/jZqACdQ2JV/5FKynuh53zpbZ1ng7mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168567; c=relaxed/simple;
	bh=lKqS/mAvx4HVq33Hmdz699WevQkr9nXw23GBMPTSQaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd8CDRTHMs5kt9w1X9A+ogplvL4hxaxBNgBWN4EK95UqIcaRJTmxx8GFfXGgRMpGOdGSlPeJDGTt6r3fJ4tCWAb+sWSxkygEIUZuDwKjvQ77AHfyVjWuTQhLOX8jOWj7OAUIr3mE1H02WvZSrIvsw9Eda7wwbStirczMng8rn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ay0jmRYT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so60658665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741168564; x=1741773364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkxl4a4YQVJ31Qn6F9vVuT6sik+nqtnuunl+H2yyS6k=;
        b=Ay0jmRYTWrsl4EYGmT2NWlDmaxS2LENcQf3c6N1UV//uwak0kMRe9fBbxXnaEXnjAB
         MIC+2nvZAOR256+ZlA+uJAj9pe1aB4GmP0iusOBKRZuCaxsbyTyd738N5fAnvYTnse8Q
         LjF384av2iHSOp6e/HAOe6iAI48zxCTKuG5I94LGIeCIA5Z2h1AlHQcOAJccNvjYXzQ+
         6yyjgndL8gtq09OZPyU7o9Zvjqeem5ttUjHUEoWN/HVvqayS9t2JrhrjoYmHE7kU4xUN
         +a2Ocl3Za1WNRDMie1mukCL8ZALNnN2f/WJvw9isvN2t6eKbeJGF5DhhxfUr5WHQVg0L
         Nnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168564; x=1741773364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkxl4a4YQVJ31Qn6F9vVuT6sik+nqtnuunl+H2yyS6k=;
        b=m/BGpV1gaUSnF5jEhj+3qPq//MZccaD5aYfosqGo1+7FGl0dq9B8c2GPKYlXRWj4Bc
         bDjxDzKmb06PsB+pYKYSyOk0Cvjs/ZE4m6zbxsHMftItwmSEQXSHaw79H62XksqiD6L/
         upBICrXF6sCzAZGvU0smMrWc8TP4WAvr5EmJApzLgJ7war5q+97GyDkQmkqi0bnJymXR
         UTKjndDUBYRfMIYxcUmsGobfnLC3EhAXGr4JmDtO67KiW0MT55UryrwLhjaIVRymfMkh
         2zr+obQEhyKAThhlHmgfxjftDN9zdA0zM3f+thEuEPNqK2i6Sgkqlq66uyClo9h1XW8k
         L8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXah9jSOlFAxAJgaPKDqcTiEfWKRLXrFIzx6vsUwN7fRL/lLSDhXTvHU2qjc/O9JXuGdUC00PfLNtz3plg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WNKhDK0hY8cRKYVmqrA9SOljGkL7YmGROek/aq8FzYwxsbRU
	TDS501e+OgB1o2ogP7Zd7qcLCRpKJVEnO67qet+VZb2YRWuD5ysYxGs/9KLpktw/hULnIp8wbHW
	1
X-Gm-Gg: ASbGncukh0JqzhkLDE4+ovupf1BdNDm4nm74FiZtBFrSfOCvNufciRX+2tVZJK0kV9h
	1gPoJ0KH+1BTPM+yRYI8ZP1n4BTAXoLZZY0gFhQgwP4xnD4v8vzaeh10Y8D2zG6OH+ErBzGO9Ad
	FPTACrcuxwXdx98go39wI6Z3XepE3ESpl9q3jBFqnBIJdy2ABGydZwflVqqVotSqnmjO2hfPV9l
	dQHDIXOYPRRqM+/yC947X+iUwxY5ZlpLTZ4ElxDjeA7VmGrfHm/hWMpeL5thEJl10Pr9qWREzsk
	qRWSYJsPqDe3tkzDZJYWG+3afDMCBdYVcrxl3puchrOitFU=
X-Google-Smtp-Source: AGHT+IFavas8h9Jpgn+Nt6h5D6vRmK+7QGtc1IeskIoqBgpTaq4AuCMVrXevu5HZeem2ji3RiSe5Tg==
X-Received: by 2002:a05:600c:190f:b0:43b:cbe2:ec03 with SMTP id 5b1f17b1804b1-43bd2aeaa86mr15746195e9.27.1741168563908;
        Wed, 05 Mar 2025 01:56:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844c0dsm20059607f8f.80.2025.03.05.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:56:03 -0800 (PST)
Date: Wed, 5 Mar 2025 10:56:01 +0100
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
Subject: Re: [PATCH v8 1/4] scanf: implicate test line in failure messages
Message-ID: <Z8gfsd5V9wrPKkiA@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:19:58, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/test_scanf.c | 66 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/test_scanf.c b/lib/test_scanf.c
> index 44f8508c9d88..d1664e0d0138 100644
> --- a/lib/test_scanf.c
> +++ b/lib/test_scanf.c
> @@ -24,12 +24,12 @@ static char *test_buffer __initdata;
>  static char *fmt_buffer __initdata;
>  static struct rnd_state rnd_state __initdata;
>  
> -typedef int (*check_fn)(const void *check_data, const char *string,
> -			const char *fmt, int n_args, va_list ap);
> +typedef int (*check_fn)(const char *file, const int line, const void *check_data,
> +			const char *string, const char *fmt, int n_args, va_list ap);
>  
> -static void __scanf(4, 6) __init
> -_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
> -	int n_args, ...)
> +static void __scanf(6, 0) __init

This should be:

static void __scanf(6, 8) __init

The zero (0) is used when the parameters are passed via the va_list.
The value must be the position of the first parameter when they are passed
via the variable list of parameters, aka (...).

Otherwise, it triggers the warnings reported by the lkp@intel.com
kernel test robot, see
https://lore.kernel.org/r/202502160245.KUrryBJR-lkp@intel.com

Best Regards,
Petr

