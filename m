Return-Path: <linux-kernel+bounces-197665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C188D6D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814481C215B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473CAF9F5;
	Sat,  1 Jun 2024 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab4o4/ay"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379788F6D;
	Sat,  1 Jun 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211334; cv=none; b=Mi6old4Al4mF6EMWxngGDZg95hO+YNiyaZL7j/Eh1uGwUN+3APxU5QtfOqDc5Gz3H0cZkJPSikW1kRfxHjtpXOUxn3qi5/w11sOLaZv8yVY3mLvsGjyz7owrUFjnvc5ZWK6JkHCuOz731FLr9Lm8WGhY39XwC6fNImLFeuGQ0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211334; c=relaxed/simple;
	bh=RE3qHNzoy8N5TEow/a0xutXu9qWJADKo+JiRs+q55CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrwvAnZ9I/IGgSn/xbUbzO682LHZ6npL4dLyGGQ95wICtxqr5JWjIl98bw9cjlrZJBCKDl4Gwuwod9SAavOMsfnuveUQM4V8rbPlnO8Cbfs1FfuVm78zNvE+NQuQAq8gkyJEQXKh+p4vzbW/6+KLNYfYzDcFqVQvQmjyPn0f5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab4o4/ay; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so2026263a91.0;
        Fri, 31 May 2024 20:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717211332; x=1717816132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXYz7GiH88A8zLPQACNqNvtyNZv+QlPs7OBIHwl3S6w=;
        b=ab4o4/ay7U3062hGCwztXJ7OEwMUkf6EMkO/SGZe27DsCTqLufsJzfbSA3HAF1NMQu
         iIYcfJ9OkXzjVVzsEfU6v4oPg3FAnCBLedkw5RCrIu1jWM4e500r/QK5cmzLQZtp4ZKP
         JhWqPo420hGzd7T+O2PTxbkj07eA1f8C451YlZe0YkEpZGkwF7l5mSDo7WF7KLxp5r4o
         GkOPgXzGOfcOo4HNrNDncoyFxGsgu15bWy3OiLLvHNr4HjZcZStKqGUyN0Oeblkw5/WV
         31J5Kq9tl/wZCJwdR71olqX+LbBysSXQPbw5t+lSs7r7j8CYAYLoMKAFKGMx++h+2HRZ
         LybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717211332; x=1717816132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXYz7GiH88A8zLPQACNqNvtyNZv+QlPs7OBIHwl3S6w=;
        b=NeSLx4nb1mbFsQ9ymR4i0KyytLzYaGUJ6dmVvMtRX9TAo75DE+ErU386Stz8yIPSXb
         4nt6Fdcr1j97ie38lX8JMEIytiUPxJInTzSdOx78e4+t/YmRuqXtzYStNIZz8bPZcf80
         lS8hA/6QI+ItlQ/YfdLwBOcTASlufVjgtK+nkFxzbhj+dlivjXqGGmGTWDT3GQ61w28W
         47R3P9pY2YTuqckJjNdyPAMkBKwpI4MjmnNu3I2yEDTcZv3Va5kEszUxXIKhAybBP8oO
         PNvnpImpxWUPNeqP+SQ5f/704TzsVMV6yyWMD2h4ZeiKljrg+46Iyo/KHrXSgpN/CCYD
         kkHg==
X-Forwarded-Encrypted: i=1; AJvYcCVk66qhO4t7GtqCieTQrAgFx1S+5b07K828PiTkGS55dFgOlrPBOWb2Xhx/uxkKjw6DS3em5ecyu0FdTnQ+aS2kueTf3jWlACz4TZeFoqxod/NTdp0VIHOKpKKktEhdrEchFFJKmrjSbCN+C6DR
X-Gm-Message-State: AOJu0YzXLk+BbXDtz3uqBgvVcPvGnF5ezvgykyXVGZJ/QcVaM7hV11d/
	5KMKmy/qRQcmw3VX7IiVZsgWV8sodFOhiOarhoy1dJ76iq2Gon74
X-Google-Smtp-Source: AGHT+IGvuSVZVfkdbBdGY63RaDH0bfRFJwukOyln3Qq0aRV4DBD+DIA0T+7/n5Iixr3hQPgaQem2/w==
X-Received: by 2002:a17:90b:124a:b0:2bd:b3c2:d2dd with SMTP id 98e67ed59e1d1-2c1dc58fd92mr3323639a91.24.1717211332372;
        Fri, 31 May 2024 20:08:52 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1ab9e9993sm3792382a91.50.2024.05.31.20.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 20:08:51 -0700 (PDT)
Date: Fri, 31 May 2024 20:08:49 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib: bitmap: add missing MODULE_DESCRIPTION() macros
Message-ID: <ZlqQwbOVxw9an-qZ@yury-ThinkPad>
References: <20240531-lib-bitmap-v1-1-45a782cf3686@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-lib-bitmap-v1-1-45a782cf3686@quicinc.com>

On Fri, May 31, 2024 at 09:03:11AM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/find_bit_benchmark.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cpumask_kunit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> This is the subset of "missing MODULE_DESCRIPTION()" which fall under
> the scope of the BITMAP API entry in the MAINTAINERS file.
> ---
>  lib/cpumask_kunit.c      | 1 +
>  lib/find_bit_benchmark.c | 1 +
>  lib/test_bitmap.c        | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
> index a105e6369efc..6b62a6bdd50e 100644
> --- a/lib/cpumask_kunit.c
> +++ b/lib/cpumask_kunit.c
> @@ -152,4 +152,5 @@ static struct kunit_suite test_cpumask_suite = {
>  };
>  kunit_test_suite(test_cpumask_suite);
>  
> +MODULE_DESCRIPTION("KUnit tests for cpumask");
>  MODULE_LICENSE("GPL");
> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> index d3fb09e6eff1..402e160e7186 100644
> --- a/lib/find_bit_benchmark.c
> +++ b/lib/find_bit_benchmark.c
> @@ -194,4 +194,5 @@ static int __init find_bit_test(void)
>  }
>  module_init(find_bit_test);
>  
> +MODULE_DESCRIPTION("Test for find_*_bit functions");
>  MODULE_LICENSE("GPL");
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 6dfb8d46a4ff..65a75d58ed9e 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -1486,4 +1486,5 @@ static void __init selftest(void)
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
>  MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
> +MODULE_DESCRIPTION("Test cases for bitmap API");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240531-lib-bitmap-7ce67db2d173

Applied in bitmap-for-next.

Thansk,
Yury

