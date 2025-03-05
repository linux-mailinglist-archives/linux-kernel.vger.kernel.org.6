Return-Path: <linux-kernel+bounces-546425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D1A4FA92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFD3A6690
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18A204F82;
	Wed,  5 Mar 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="epMLIdSe"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8171204694
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168044; cv=none; b=uIcFLiwldaaG9csq2lAza3mfFbhMTnWBYe+P/Lz3grgaHNN00py8/d040E+mib2VVCFrP0/JhRV0vrKyyy9EQuByG+MjiEAaerJvga5ZFTF60Dj1WLht/V9EjT9q92yeqWUQk4alQxQqVvgWpwqN6zZV8fTK0Mh/B2ASbvg8ZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168044; c=relaxed/simple;
	bh=Z+VMDSOKrwtG6lviKJiCsWBEfYDhlcUqD9qS1eoXGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLq42SvtFMOYAaK49C1TyMWfXUhFoFJwrDZnlsjdcDRL/+neK6R1hZUaIn4ClcegOqtF+E8YIXnXyrXWG/A5lBjbl2zKrWr4N+0GMekGbH9g9mfP6jePzIMSudXmJxt4AaTSpTpXrNJ+BkNArs7HwEdJsWlaYg3Tb0wrlWX3YbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=epMLIdSe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3452239f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741168040; x=1741772840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EMPfkT27lV8Ojg2DFZYdlrmMaeah6M4ccrm/4GlS09M=;
        b=epMLIdSeTSMn7obw5QuRDczC5fsK7bKRQQLbYNU+9nGOtoIo0ZRyhK/uk4T7A/SltK
         QsdQXKvkQKNZYqR8/cSsKU15Pma014EUYQEeEVe2LQ3V6wIu+2poI90gL+auiSW0fCOt
         Cqx/DJIlPFRUrFhTGMLoNzokeMxnc930S2ykHwMZUFUKEmSXul1tYOGjTeeEmdMWG+1L
         5BDXrKR/dZYc1kCRZBoAVJTEPNclxddEBhnQOu87oNtvdTsIs6QyNborgl/OI3X8lNxY
         u5yLEmTnIsLGmgKOY9lO8N8LpTkq6gqJRSNHUyPNqpjwqV0LD/OM3vSVNPEFGu9j0glH
         4q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168040; x=1741772840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMPfkT27lV8Ojg2DFZYdlrmMaeah6M4ccrm/4GlS09M=;
        b=LW8Ftl63oH+GGEqapNeL/9761+RmBZBky+xCRKefoU5rjOs56ZQH3oTccrVbdZ+2I9
         IsEl61yMriLh0Oj5f3h1sLhXAeGvAUYAQP/LKFn6Qx8k5HgMQ7ljNxbWNiz0zcHyBmGI
         JuZ8IU4BnzuDY0Qillk0bX5EOfcmkHynEm7m/mPZxHiWno0fWIOig00G/JOHjwOQg4V5
         pmYuRYvyPNylnuN5gmWjpI8DVdJxzbU9b19BMBRkwoJUbcL9hOiNzR+vCztIe2MHdAJa
         uHtyLtwYYr4oWGB8g7huFrWEA2otmaqsk98uyKWpkbnfcE+cDyNzhlJBViYHeMn+ptYS
         9wAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnLlDdI8y3EZMflk6+nSu2kgEv9RtzN3nKRrw9gbF9GdxWQWkyUO0oDrtbF41NQmarMdPr8AgRUwNvKyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6UDsU7kzTSj+fMD5SY6tu77A3jJJ/lBfQGX+G64VrxcUcggj
	M1vPHZD0EhLX6gA5SXMKREvp7SrXc1zsjz/8VXrD/GXC0o59+wnjqLstbzeQoF8=
X-Gm-Gg: ASbGncvJh+3saysZ4RwLdLXGPOIEMTXmvcbLEfR4i7ebjowVkgd1gmyrKRUh+EbEOEg
	911TBKTucJy1+emsSZ3dJHZbKsLerNRoa4O9+Wh1x4TRuccLHeHI3swtXkDumVi1n7GbFRLPMfS
	RX03nfoNsInT7FEUeNGivPkFHOqy7TQ5XQKOpzrK4AwPr8O89V7QqBikMDP59/iFZ1UoKyLluST
	6fFvMWQ+oeZTYIbNLLupywR7cRz8cv3YOcpdaQhCSG8vwhjHQ9uclvJJQztw9sxwxROI+LYuZYc
	42IumUxCn8xEkfTQUTCHzLn67ql7v3ezqEbdkH72q3NarhY=
X-Google-Smtp-Source: AGHT+IFcrWp+Eg2JeW3nr+EIF9j4IDp9lzyAN7AdFjhbyzx7Y+kawoeWfXaT79Mlsm2wvfce/91S1g==
X-Received: by 2002:a5d:6486:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-3911f7ce121mr1800951f8f.50.1741168040117;
        Wed, 05 Mar 2025 01:47:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd429215asm12099625e9.11.2025.03.05.01.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:47:19 -0800 (PST)
Date: Wed, 5 Mar 2025 10:47:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <Z8gdpSErMCMCZZNP@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
 <202502160245.KUrryBJR-lkp@intel.com>
 <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>

On Sat 2025-02-15 14:52:22, Tamir Duberstein wrote:
> On Sat, Feb 15, 2025 at 1:51 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Tamir,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]
> >
> > url:
> https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/scanf-implicate-test-line-in-failure-messages/20250215-002302
> > base:   7b7a883c7f4de1ee5040bd1c32aabaafde54d209
> > patch link:
> https://lore.kernel.org/r/20250214-scanf-kunit-convert-v8-3-5ea50f95f83c%40gmail.com
> > patch subject: [PATCH v8 3/4] scanf: convert self-test to KUnit
> > config: sh-randconfig-002-20250216 (
> https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/config
> )
> > compiler: sh4-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (
> https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/reproduce
> )
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> https://lore.kernel.org/oe-kbuild-all/202502160245.KUrryBJR-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from <command-line>:
> >    lib/tests/scanf_kunit.c: In function 'numbers_list_ll':
> > >> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll'
> might be a candidate for 'gnu_scanf' format attribute
> [-Wsuggest-attribute=format]
> 
> I am not able to reproduce these warnings with clang 19.1.7. They also
> don't obviously make sense to me.

I have reproduced the problem with gcc:

$> gcc --version
gcc (SUSE Linux) 14.2.1 20250220 [revision 9ffecde121af883b60bbe60d00425036bc873048]

$> make W=1 lib/test_scanf.ko
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC [M]  lib/test_scanf.o
In file included from <command-line>:
lib/test_scanf.c: In function ‘numbers_list_ll’:
./include/linux/compiler.h:197:61: warning: function ‘numbers_list_ll’ might be a candidate for ‘gnu_scanf’ format attribute [-Wsuggest-attribute=format]
  197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
      |                                                             ^
[...]

It seems that it is a regression introduced by the first
patch of this patch set. And the fix is:

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index d1664e0d0138..e65b10c3dc11 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -27,7 +27,7 @@ static struct rnd_state rnd_state __initdata;
 typedef int (*check_fn)(const char *file, const int line, const void *check_data,
 			const char *string, const char *fmt, int n_args, va_list ap);
 
-static void __scanf(6, 0) __init
+static void __scanf(6, 8) __init
 _test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
 	const char *fmt, int n_args, ...)
 {

Best Regards,
Petr

