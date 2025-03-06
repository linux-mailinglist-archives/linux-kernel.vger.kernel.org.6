Return-Path: <linux-kernel+bounces-549356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF20A551A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F00175BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1832405F6;
	Thu,  6 Mar 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OEkaV7oF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61323FC5B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279450; cv=none; b=Xl8SrWuZUMR1lcqrEOB+VxmzYc2LHF1iKx106L1qXd+WP9bogdLD8GF15U7KXl8sJazpzB2A2CESQakr+xixlFBSe7izbl6GcZTUuAOAZNeGpYa5OrL7pet3pJD4XUNCXHpgY8+zDza+YGtjmOnRK0o2i74eHt53+Kb+sEP+qgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279450; c=relaxed/simple;
	bh=z1BY6ouQA/c2Sv8LeROsY8VhNlpfb6blGqE7p9XSLCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDlsjuMDOWps/Qgs7Cn5wn8IMiu9Hru+51ZrnsBhg3zWTYWIOr9XhyEHqcIfnG4YeC7lkUP7jnCHYFjHXVV4tpnlZ7kDP6HniaU82jYZfl+sZEoBV4sgmV42L/JmMNRJuH7DFBgWbr2mlDeZsasLoIungSD0XLkZrq8I9UcffDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OEkaV7oF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bcad638efso5749115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741279445; x=1741884245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShoYw58ehpsrQYbnJ7nHU0dRrMyBrcfiule3tNowvNI=;
        b=OEkaV7oFqjPJenbxuFTDa1gha+ogrzoqfX0EMuxN42+sgUdzCmxDhFYeOkUaB9guBX
         VwG/Yqqm3CkaFaF14ISPDz9aCM1wfzHFjW/DJe9PS6Kv5kfhzOpTzT36anrInv/ItYaG
         sG76FCL+cP+2z+5qqmwXJYU0OvzUUpgzqR7MtU4KjSU2qP07TV9+V/DNvJ9yixPbf8cU
         P7yOgi/NqoGox9fJgWI4PgkXNOGAcIbvp9/d/LSiEZmOAi7Bc+rzvvx1omNbqBK3LgZs
         anRDaf+mtN38ZCL9/iKfD8ziTyp8ijXEZvLkg758LsVcDBlMRrlzTJqWuI+TOWcrtEZh
         HXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279445; x=1741884245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShoYw58ehpsrQYbnJ7nHU0dRrMyBrcfiule3tNowvNI=;
        b=SX9ZIjyGCGEQ0Y8T2a/nTz1olDFtdBJfOy0BSuS0Vm5ZD9qZ715qAs1WGJXp+tuMNz
         eLu3/jcfO3xOjuM0VWrD126bEdHXs4VfaNMAFOM9cWkUyajpW2MaDVwqfAjRzMTQy7r4
         +HxBbmVoajXp0wwhpxVXCMk8b/WdkN/U3kG0cQ9dZG90/rRL49xhNavOv6PY1yOqFCuA
         aKGlsr8PLPVMafBdgBqNLf3cNZc90YFJc/QYbiDXVzIQjxomLINY0RgvYBN4wpVCAlPs
         6+ZyKFqRZEOLlbcitLpG5iSMJhP4g0wiQWDBECRvo0b+8wcwyGwZxzEYEmmK+uya2DmS
         EfuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ItoQhACV5Qv6qKI6IjDGMcTJEMuSQmGdIlMxoJ8+Lx2+qXwgPoM+UJlj/l3WlriGrSfErvSUJdvK2Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe24UgFsSM5QJBd1EVJB7zsiuQGjTVV9XpFInJPfvbJTiNeK0s
	ROinCITT9yrLR/2YYNo+8xvK9mp1WJhje+mmW+nBbyluLS5F9F4dQEcCDTAO4BE=
X-Gm-Gg: ASbGncu83P7QmWujErTD09xNNDG2s/ONnDAXOzymyDc6vtWGCZSWDrYLv4rRXolZajx
	dqAoVPJLe466uYA0fVI1sjlkGvKwQHTuFaZpEPytpJs/OwMkoMuYnoNRhtG6yDWiEscFM4f1j4Y
	lJTDTyXLnpYVCDmExRFLcpJA5ohhU/O6DVl4D5UhNnQRIWVpx2Ja8l1mkhCCsRTo9NTpnD8nPZJ
	ptX5ppcYm0RuDwpwALpYtu8vOEpfY98Wubz4wKeSaQS7A/ofj8Y9jw7d9/2iK1a2KtmSiNfRfmg
	FySmZ6z5x4bVwriQC/YvaH7AYOkIedE4Psz+g/o7+qPV1uI=
X-Google-Smtp-Source: AGHT+IFd7b+2c3n2/3ricwGLn/lNyHyrhR79mvLaq9Hu+pYWcGfA3QA0G41/DOvWu3YCV95G+BwDLw==
X-Received: by 2002:a05:600c:1506:b0:43b:bdf4:1c9 with SMTP id 5b1f17b1804b1-43c743cd2admr33565e9.29.1741279444950;
        Thu, 06 Mar 2025 08:44:04 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbd27996sm45419025e9.2.2025.03.06.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:44:04 -0800 (PST)
Date: Thu, 6 Mar 2025 17:44:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/3] printf: break kunit into test cases
Message-ID: <Z8nQ0vCNgz4lEJEj@pathway.suse.cz>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com>

On Fri 2025-02-21 15:34:31, Tamir Duberstein wrote:
> Move all tests into `printf_test_cases`. This gives us nicer output in
> the event of a failure.
> 
> Combine `plain_format` and `plain_hash` into `hash_pointer` since
> they're testing the same scenario.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/tests/printf_kunit.c | 331 +++++++++++++++++------------------------------
>  1 file changed, 121 insertions(+), 210 deletions(-)
> 
> diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
> index 287bbfb61148..013df6f6dd49 100644
> --- a/lib/tests/printf_kunit.c
> +++ b/lib/tests/printf_kunit.c
> @@ -38,13 +38,8 @@ static unsigned int total_tests;
>  static char *test_buffer;
>  static char *alloced_buffer;
>  
> -static struct kunit *kunittest;
> -
> -#define tc_fail(fmt, ...) \
> -	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
> -
> -static void __printf(4, 0)
> -do_test(int bufsize, const char *expect, int elen,
> +static void __printf(5, 0)
> +do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
>  {
>  	va_list aq;
> @@ -58,59 +53,64 @@ do_test(int bufsize, const char *expect, int elen,
[...]
>  
>  	if (memcmp(test_buffer, expect, written)) {
> -		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'",
> -			bufsize, fmt, test_buffer, written, expect);
> +		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'",
> +			   bufsize, fmt, test_buffer, written, expect);
>  		return;
>  	}
>  }
>  
> -static void __printf(3, 4)
> -__test(const char *expect, int elen, const char *fmt, ...)
> +static void __printf(4, 0)

This should be:

static void __printf(4, 5)

The 2nd parameter is zero when the variable list of parameters is
passed using va_list.

> +__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
>  {
>  	va_list ap;
>  	int rand;
>  	char *p;

> @@ -247,89 +225,44 @@ plain_format(void)
>  #define ZEROS ""
>  #define ONES ""
>  
> -static int
> -plain_format(void)
> -{
> -	/* Format is implicitly tested for 32 bit machines by plain_hash() */
> -	return 0;
> -}
> -
>  #endif	/* BITS_PER_LONG == 64 */
>  
> -static int
> -plain_hash_to_buffer(const void *p, char *buf, size_t len)
> +static void
> +plain_hash_to_buffer(struct kunit *kunittest, const void *p, char *buf, size_t len)
>  {
> -	int nchars;
> -
> -	nchars = snprintf(buf, len, "%p", p);
> -
> -	if (nchars != PTR_WIDTH)
> -		return -1;
> +	KUNIT_ASSERT_EQ(kunittest, snprintf(buf, len, "%p", p), PTR_WIDTH);
>  
>  	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
>  		kunit_warn(kunittest, "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
>  			PTR_VAL_NO_CRNG);
> -		return 0;
>  	}
> -
> -	return 0;
>  }
>  
> -static int
> -plain_hash(void)
> -{
> -	char buf[PLAIN_BUF_SIZE];
> -	int ret;
> -
> -	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
> -	if (ret)
> -		return ret;
> -
> -	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/*
> - * We can't use test() to test %p because we don't know what output to expect
> - * after an address is hashed.
> - */
>  static void
> -plain(void)
> +hash_pointer(struct kunit *kunittest)
>  {
> -	int err;
> +	if (no_hash_pointers)
> +		kunit_skip(kunittest, "hash pointers disabled");
>  
> -	if (no_hash_pointers) {
> -		kunit_warn(kunittest, "skipping plain 'p' tests");
> -		return;
> -	}
> +	char buf[PLAIN_BUF_SIZE];
>  
> -	err = plain_hash();
> -	if (err) {
> -		tc_fail("plain 'p' does not appear to be hashed");
> -		return;
> -	}
> +	plain_hash_to_buffer(kunittest, PTR, buf, PLAIN_BUF_SIZE);
>  
> -	err = plain_format();
> -	if (err) {
> -		tc_fail("hashing plain 'p' has unexpected format");
> -	}
> +	/*
> +	 * We can't use test() to test %p because we don't know what output to expect
> +	 * after an address is hashed.
> +	 */

The code does not longer print a reasonable error message on failure.
I would extend the comment to make it easier to understand the
meaning. Also I would use the imperative style. Something like:

	/*
	 * The hash of %p is unpredictable, therefore test() cannot be used.
	 * Instead, verify that the first 32 bits are zeros on a 64-bit system,
	 * and confirm the non-hashed value is not printed.
	 */
> +
> +	KUNIT_EXPECT_MEMEQ(kunittest, buf, ZEROS, strlen(ZEROS));
> +	KUNIT_EXPECT_MEMNEQ(kunittest, buf+strlen(ZEROS), PTR_STR, PTR_WIDTH);

This looks wrong. It should be either:

	KUNIT_EXPECT_MEMNEQ(kunittest, buf, PTR_STR, PTR_WIDTH);

or

	KUNIT_EXPECT_MEMNEQ(kunittest,
			    buf + strlen(ZEROS),
			    PTR_STR + strlen(ZEROS),
			    PTR_WIDTH - strlen(ZEROS));

I would use the 1st variant. It is easier and it works the same way
as the original check.

Anyway, it is a great clean up of the pointer tests. I have wanted to do it
since a long time but I never found time.

>  }
>  
>  static void
> -test_hashed(const char *fmt, const void *p)
> +test_hashed(struct kunit *kunittest, const char *fmt, const void *p)
>  {
>  	char buf[PLAIN_BUF_SIZE];
> -	int ret;
>  
> -	/*
> -	 * No need to increase failed test counter since this is assumed
> -	 * to be called after plain().
> -	 */
> -	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
> -	if (ret)
> -		return;
> +	plain_hash_to_buffer(kunittest, p, buf, PLAIN_BUF_SIZE);
>  
>  	test(buf, fmt, p);
>  }
> @@ -739,11 +664,9 @@ flags(void)
>  							(unsigned long) gfp);
>  	gfp |= __GFP_HIGH;
>  	test(cmp_buffer, "%pGg", &gfp);
> -
> -	kfree(cmp_buffer);

I belive that the kfree() should stay. Otherwise, the test leaks memory
in every run.

>  }
>  
> -static void fwnode_pointer(void)
> +static void fwnode_pointer(struct kunit *kunittest)
>  {
>  	const struct software_node first = { .name = "first" };
>  	const struct software_node second = { .name = "second", .parent = &first };

Otherwise, it looks good to me.

Best Regards,
Petr

