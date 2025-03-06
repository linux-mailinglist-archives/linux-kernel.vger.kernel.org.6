Return-Path: <linux-kernel+bounces-548567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF20A5468A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026E51890573
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA71209F2D;
	Thu,  6 Mar 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M5TqjAZM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983C209F25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253918; cv=none; b=Pu17SEztNA0SW6v0B5YpRtAyWIQkygDaAKTJDrA4+dZ44OrVKYJOtYrlk9hfkhmm6w0CS2kCsP7TiHUSrLmSBQmGO87OXbl7K1pYem7lEKduKPza5G++NOjIdlIHZbetQx2uOj48aAY7MIVIILJ8aNUvMsqc4oXSPrl1LoWmBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253918; c=relaxed/simple;
	bh=QRxYtULG3gOZzTU+e59fvPCAV7jDKkmzMdnB662pk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAb8ZBe7Hd0mMzTxmvOEGhOfFuRFcJVNPD7QR59fWBOqgtn+z31STYvlR2e6AA5yQf10nCnOeU5jCJJlf/0HaVr/hsJmlpGPOvw27v5SGZXLTkDfgw+CO8dYhkJaJHYTOzAAXpkxwq3ogIyZUtChdPd31PaZgAzSzbxOlNcTDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M5TqjAZM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bd732fd27so3660315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741253915; x=1741858715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wpzq/njrY6l758uuXjkU5Yg1HQdxYKPq878SD5ejP+g=;
        b=M5TqjAZMn2MDPTS2NGj3BTbOkze8ZILd9knkxIGPgFn+PhfnavBv9ZMwnf0voMHm/3
         lH0RSiDXIqMGUg9XjOnzgoaDcJuOUmlL0iT/p190tUBRdRfKnD9kh4IIiNJL31QqW5qc
         EoCCYtTeYE8kobW1iLagEi5Z5/1CTKFIdNdGKTHQyDlrPKKOAZ6PTwF2lp/WSf7vjDfO
         X4AZREQzlEM79wgvgzBAgFzs0rfb5C7jFUj4W0uQ1N34yD0ycq4hMycWQZs1fnN88ueV
         iJEwxVAkgkWyGfRWQQBaRuxu+9Qjmm5RqLVE/IpefHomXBpriviwLCqGyLnjLz7IGxSA
         zuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253915; x=1741858715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpzq/njrY6l758uuXjkU5Yg1HQdxYKPq878SD5ejP+g=;
        b=PjMQB0UObkuPce9mRXQeIY8y79KBNAhAhwGYp2zb87iwXCerfFWECFxGApt6/MgVt2
         IwWqc2ZMhsieI80xTfLlu8wQ8t8IkT3Fp+2XPyUAWRrtQYFBu4eqA8hujdcin55DvfMb
         Or+/z88KgiFqWCIOCkU0+bgHPjtvUIg4NRqI9PXmlHe9Qur0bWDFsXuHBKGEVF60IUm9
         3bIZzKfl2dkSfDS3gqoOUOCUnbr6Xe9okpDgvjW3F//2MiBFaObRzyCVEdYDtJ2cryW2
         U22LKZLazmx0w8kif6nqsXy/5AAPScgb5YQ/Fl8XxkGk9DWq/yb13P0xkMUzinMwVaXm
         Fkfw==
X-Forwarded-Encrypted: i=1; AJvYcCVoUuVDPEe76B9qvM2PfZUhtNBOIa0GHP7RSGQOf0KjFKx+/hUvqnlP3LbICYuitWPKDkV1qXfZ6BjAyns=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwxnWlZlFJtXXX50OTqv6ku27I0Gke2BbyFZ0MUQg42RuoL8X
	HoQ6GeG0kmqMYLkWc+Z0aIn2bzktowsgm5v8lzpHVyTrwI8wiv/y9Sjh9bM3j8X9cNui5KfYUpL
	K
X-Gm-Gg: ASbGnctk26dvTMsyScH8tnl1DIVA+DXdWgTUxMZN5wPueiRQcCksgSjdSdDE3h6cQn3
	evQgFSM2ykUDc4gcJt5E4q2lqueCO/hkrkS9ERCo4008Go2atZpNDnTKAmoiYC+lf1AHcKaQr8b
	B8yv3GPAIiYb8xH/s0r1t5e4znizT1gXeO6tzEh9p8JrPDZdmdFfHzcviRY98hHtY8HqyCe7Rjf
	OaQYTwJcBAZVP3ijiiXHWRJ227a9N7wPDvtxe1xKl0kvAP3aj4vKpVv/69zlNDhGo4gdN6Z6MtD
	mQOQ3MimfEXaU2UF1VkG8pb/UcDaauzU0EHvBaWs75SQ16I=
X-Google-Smtp-Source: AGHT+IHFSps8QHofBQVEj8kAVEUhy1LU39PEl0Eivc++Qzt0gHMDxzgZsRqrnZ16eKWtWOaX2mAIaw==
X-Received: by 2002:a05:600c:474b:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43bd295853emr47566885e9.8.1741253914734;
        Thu, 06 Mar 2025 01:38:34 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93c9b6sm14167405e9.29.2025.03.06.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:38:34 -0800 (PST)
Date: Thu, 6 Mar 2025 10:38:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8ltGEp7NmhTwPRW@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
 <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
 <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
 <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>

On Wed 2025-03-05 10:57:47, Tamir Duberstein wrote:
> On Wed, Mar 5, 2025 at 10:55 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > > On Wed, Mar 5, 2025 at 10:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> >
> > ...
> >
> > > > >  #include <kunit/test.h>
> > > > > -#include <linux/bitops.h>
> > > > > -#include <linux/kernel.h>
> > > > >  #include <linux/module.h>
> > > > > -#include <linux/overflow.h>
> > > > > -#include <linux/printk.h>
> > > > >  #include <linux/prandom.h>
> > > > >  #include <linux/slab.h>
> > > > > -#include <linux/string.h>
> > > > > +#include <linux/sprintf.h>
> > > > >
> > > > >  #define BUF_SIZE 1024
> > > >
> > > > It would make more sense to do this clean up in the 3rd patch
> > > > where some code was replaced by the kunit macros.
> > > >
> > > > I would personally prefer to keep the explicit includes when the
> > > > related API is still used. It helps to optimize nested includes
> > > > in the header files which helps to speedup build. AFAIK, there
> > > > are people working in this optimization and they might need
> > > > to revert this change.
> > >
> > > Yeah, I don't feel strongly. I'll just restore all the includes.
> >
> > It will be blind approach. Please, try to look at them closely and include what
> > you use (IWYU principle). I don't think anybody uses kernel.h here, for
> > example.
> >
> I think I'm getting conflicting instructions here. IWYU is indeed what
> I did: bitops, kernel, overflow, printk are all unused;

I believe that the headers were added for a reason. And this patchset
keeps most of the code. This is why the change look suspicious.
And I see in the patched lib/tests/scanf_kunit.c:

  + hweight32(), BITS_PER_TYPE(), BITS_PER_LONG which looks like bitops stuff
  + is_signed_type(), type_min(), type_max() from overflow.h

So, I would keep bitops.h and overflow.h.

The printk() calls were obviously removed in the 3rd patch so printk.h
include should be removed there.

I do not see any obvious reason for kernel.h, so I would remove it
in a separate patch.

>  string is used only for sprintf, so I made that replacement.

Makes sense. But please do this in a separate patch with this
explanation. It might be done together with the kernel.h removal.

Best Regards,
Petr

