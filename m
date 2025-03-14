Return-Path: <linux-kernel+bounces-561453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD7A611F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050EF7AB7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168071FA272;
	Fri, 14 Mar 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FVC0cYeu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD821EB39
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957473; cv=none; b=X4ZQh/HU7ZqhvVYwegNYaNE4Cb7uYrz645V30XeMrtVUFBe/p4Io/V4MKoVwdz1K45MT7HgRciQjm0PyRmosOTXE6wZudExteSrEV4HTGs91QsWGURdbWAsBYvzY+Ju4gPupU6xKA+OlgsJ/U0f51Y4qka/BOQBJdpjcWwyoFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957473; c=relaxed/simple;
	bh=YrtvhfhP/Znn3fNZU4UiIYAYE8ptrotjbF/EGYUxQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmETt6AVKpROQLiIoOjiCnPLBF0YKvXmf4OKzSAsQDYLtqKXR6DWDYWM/UQQ9Lo3jgU1zWYa9czRiWf9BVzwxLXqzU1gZW0qSaw198SQhEaLFxWWpDBeEsCs7ILVIAAMRDTy4dOXVJJV8tSDfXqi9G+gcEAXzdmVYVUKsVSPX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FVC0cYeu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso14325765e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741957470; x=1742562270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXEAhjO+FZzhjAKSipo0fbPH75GS1MBoxQtrIWgvBF8=;
        b=FVC0cYeuzs7pNCqvicGAQv1g5hluybS2mHAoYAfP8+fJkhAEl4aS3EE0v69oB0agcE
         sahcxak3kFs4otGN7ipVLs0mriF+NknzUr3rwMInepXp2fJuk74f7XngBuY0iGC7qyoQ
         ZntLWyuWR9zeRCQp9ugBIDfPcM6pPdi0QZ17McEb2HsWBBlpnmIv8rL/QtdgW8jRER1X
         gtbNsy+cG5PualPgGUSIutNm1seLKBgq4ah7NgQNm14sUWlagQ4V7n6MQsjPKoF2WfMb
         3nndap5ssyZmceFZ/3K1V1UFknitgeNwfSXW7LiLs2koC/tEQC76l8v2APMxV8zYtlLR
         z5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741957470; x=1742562270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXEAhjO+FZzhjAKSipo0fbPH75GS1MBoxQtrIWgvBF8=;
        b=sy05Y2kGttFaTu+7l6ev+pPB6YasGr61Ubcowvh8iitMYL4JJjcBlZpIcLxib2UDvd
         1RSLvqvJ9hVXV5En/ErYhF7F+JHbAiA8c0X3cq4PUP4KVjZbltDOz4nPyFnHf9QzCYtm
         2iWmYwb7x71T7iD1z1dgD0+Ig1UOreIuhuVe8YxxTBkFam2rHa155T+7qQtRaU7lknkf
         ZbslnZh8h4+GOWERxFBaHXrDdVt3ZvvexBCLS+kthps2YGMtISW2JW572gXy9VbNZClr
         h5M3zreNr1r7A5ORj09CBCzT6qfGBwhQL8xVOCylT3OhnDvwi/Ag3GTPwZTO9i97BE1h
         ZlRw==
X-Forwarded-Encrypted: i=1; AJvYcCVGm+oId90uXQmlVSAz+MmiAKvo0MaAVfwBYoTT+5X3RpDm0OEtaHYkQAPAcGSFgUwCDfWYQy0a5nSbvG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlF5zLSpPZ2GF4nKC8ok9b1eV1/XEeLGErhDuAJWYQ5GtxMfQ
	ho9Ex3nB9+9BxVXSmARh5zQhEy+7uWuCymltntZ79MlqZXi0idoMfvjYNSEdyWs=
X-Gm-Gg: ASbGncsto0xaqM+l9b9ssWzVjMPPfeHsr5FzGpmtPwqPneC4389Jb4ysfE17NaG6tYI
	NPTlUyBvndltf1r1IYp8vKpbUJrgAaY8hXfouhY76ktU0Nf5jXn7W000ouMXV+WwYp9IB2riKJq
	vHuwrZLzGA5WAtdlETkE/SwDnR4c+P+FI8fu/Nwqhe8BTjrSQmOoxj8jIU2iJAZteJUrNHvlIYf
	OAsYcjPOpsCvlgJnHhROkQtuPiX6rldjZ4/kUpy7CELxOzzLVXUfP568+pdGGG/3/mhkseZnH7K
	tadSEgn5+dmn4oy2Egbzxuma8PP0K6I2WyqqcAzJhmXj6WM=
X-Google-Smtp-Source: AGHT+IHX8lnwJXQp9lmsaTQS54crU+G64pDcAvklWf9R0V2hsgHpJVwfSwI5w9rxAsR7GygmwCqXlA==
X-Received: by 2002:a05:600c:1c29:b0:43d:ce4:ef3f with SMTP id 5b1f17b1804b1-43d1ecbc1damr30518925e9.12.1741957469797;
        Fri, 14 Mar 2025 06:04:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc4173sm16908685e9.20.2025.03.14.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:04:29 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:04:27 +0100
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
Subject: Re: [PATCH v9 5/6] scanf: tidy header `#include`s
Message-ID: <Z9QpWwlJn1U3tTjP@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:38, Tamir Duberstein wrote:
> Remove the unused `kernel.h`. Replace `string.h` with `sprintf.h` as the
> former doesn't seem to be used directly.

> --- a/lib/tests/scanf_kunit.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -5,12 +5,11 @@
>  
>  #include <kunit/test.h>
>  #include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/prandom.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>
>  
>  #define BUF_SIZE 1024
>  


The change makes sense and looks good to me. I would go with it.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Further improvements might be done later in a separate patchset...

Best Regards,
Petr

