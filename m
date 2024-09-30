Return-Path: <linux-kernel+bounces-344374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D481598A8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117931C22689
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24494192D78;
	Mon, 30 Sep 2024 15:40:30 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788D192B9E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710829; cv=none; b=t+vOycJ4yANqJoVCAO9WPt0G2hilz/9guzbrhbGiKl7eAL8nL2cQzWaW/0ZxNBOcpMHGm9rLyaxOXzngdiV0UojjMRenz066hltZFKDm4xjvYKiie5SzLdPyqE3QrGBC0hEwAZ5kKQfTN53b1RO8Q4ORNKS0VKUd7KgGlxKJ2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710829; c=relaxed/simple;
	bh=pnqknXO9IJu8xTFekZlGtw3rThcC71VWxLS91NdgUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUwMy9YQ9dV/xk5jBoXG6bryTJN/D3y6IiSCe98Ym90chx59Yxs17+ax9Gy4QE0h1q8KYGgJ2RNinoeBYqtuY3e9Y3PQOMeZgtXgaDvXykumKrW5cODTkAQvUVCQBDDLV1qU/CTXLTqIJTqpNhbaE1T3a/im+q1c8Hk7j9mkS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 48UFeNb9006225;
	Mon, 30 Sep 2024 17:40:23 +0200
Date: Mon, 30 Sep 2024 17:40:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Thomas =?iso-8859-1?Q?Wei=DFschuh'?=" <linux@weissschuh.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/nolibc: compiler: add macro __nolibc_fallthrough
Message-ID: <ZvrGZ78XvvKrs/0Q@1wt.eu>
References: <20240930-nolibc-fallthrough-v2-1-2e8d10fe3430@weissschuh.net>
 <61eb467389f24216b77aaedb85006153@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61eb467389f24216b77aaedb85006153@AcuMS.aculab.com>

Hi David,

On Mon, Sep 30, 2024 at 03:29:26PM +0000, David Laight wrote:
> From: Thomas Weiﬂschuh
> > Sent: 30 September 2024 06:35
> > 
> > Recent version of GCC and clang gained -Wimplicit-fallthrough,
> > warning about implicit fall-through between switch labels.
> > As nolibc does not control the compilation flags, this can trigger
> > warnings for when built by the user.
> > Make use of the "fallthrough" attribute to explicitly annotate the
> > expected fall-throughs and silence the warning.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Add a do-while loop to improve compiler compatibility
> > - Link to v1: https://lore.kernel.org/r/20240929-nolibc-fallthrough-v1-1-5ee07ea9a683@weissschuh.net
> ...
> > 
> > +#if __nolibc_has_attribute(fallthrough)
> > +#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
> > +#else
> > +#  define __nolibc_fallthrough do { } while (0)
> > +#endif /* __nolibc_has_attribute(fallthrough) */
> > +
> >  #endif /* _NOLIBC_COMPILER_H */
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index c968dbbc4ef8137e237b859bf18a6d2970230cbf..3892034198dd566d21a5cc0a9f67cf097d428393 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -15,6 +15,7 @@
> >  #include "stdarg.h"
> >  #include "stdlib.h"
> >  #include "string.h"
> > +#include "compiler.h"
> > 
> >  #ifndef EOF
> >  #define EOF (-1)
> > @@ -264,7 +265,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
> >  				case 'p':
> >  					*(out++) = '0';
> >  					*(out++) = 'x';
> > -					/* fall through */
> > +					__nolibc_fallthrough;
> >  				default: /* 'x' and 'p' above */
> 
> Doesn't this break any old tools that would have parsed the /* fall though */
> comment (or any of its variants)?

Apparently not, I had rechecked with gcc-6.5 which is the one that
used to expect comments, and it's apparently fine as well with the
macro, probably due to its name which contains "fallthrough" in it.
Anyway that one was broken when running cpp separately from cc1, so
those at risk of seeing any warning already see it in their programs.

> If you move the ; into the define the 'old' definition can be empty.
> And then it is possible that:
> 				case x:
> 					xxxxx;
> 					/* fall though */
> 					__nolibc_fallthough
> 				case y:
> 
> will be processed correctly be all tools.

Missing trailing commas is a real PITA, which can even cause indent
issues with editors, better not do that, frankly.

> I know I had to lower the warning level for one of our kernel drivers.
> But I've forgotten why - that code has to go through a lot of
> compilers - including Microsofts.

Probably a case like I mentioned above: pre-processing being run as
a first step, making the compiler not see the comment and complain.

Cheers,
Willy

