Return-Path: <linux-kernel+bounces-358013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF9997932
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93366B229DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86E1E3DD4;
	Wed,  9 Oct 2024 23:38:14 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EF169397
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517094; cv=none; b=gE/3C+f2aPhsdzsNQvHMvHOp3O3GtCBEieJfFK2VUR/1J8LXbCBXTCL6N9jcl+F3XXI/Bdm5EwxSjit6dI7HGu3wQPcSWse8jOeIWI4tPhlcO2BmMLz0WbrGG8NjdYeT6CKJCNLkl4iavzVWWOULiRqdnTV9BLO47dHpGDz1Yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517094; c=relaxed/simple;
	bh=3G/6R++b9vYj4FRd5vTu0OZai85D5ZFaHhqrAG01FuY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuAx7LiElvsxBAKIcm+tj3C4zvALaDE6RMm0wxQLYvS3cdu3CVdwOQ1/5kEz6fnMVzP4ICpxc3MxCFdObV4K/fI9jyDXh56eXIq5cC1Ho3eEJUUIz6XWuqBTHib8onPZJGpVEvPBC95YMyo4rrch6P9abG5lYr7zel8weJJu7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 84804db4-8697-11ef-8860-005056bdd08f;
	Thu, 10 Oct 2024 02:37:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Oct 2024 02:37:59 +0300
To: Sean Christopherson <seanjc@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 1/1] x86/reboot: KVM: Guard
 nmi_shootdown_cpus_on_restart() with ifdeffery
Message-ID: <ZwcT149jx-iOmEfl@surfacebook.localdomain>
References: <20241008191555.2336659-1-andriy.shevchenko@linux.intel.com>
 <ZwbazZpTSAn9aAC7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwbazZpTSAn9aAC7@google.com>

Wed, Oct 09, 2024 at 12:34:37PM -0700, Sean Christopherson kirjoitti:
> On Tue, Oct 08, 2024, Andy Shevchenko wrote:
> > The nmi_shootdown_cpus_on_restart() in some cases may be not used.
> > This, in particular, prevents kernel builds with clang, `make W=1`
> > and CONFIG_WERROR=y:
> > 
> > arch/x86/kernel/reboot.c:957:20: error: unused function 'nmi_shootdown_cpus_on_restart' [-Werror,-Wunused-function]
> >   957 | static inline void nmi_shootdown_cpus_on_restart(void)
> >       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix this by guarging the definitions with the respective KVM ifdeffery.
> > 
> > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > inline functions for W=1 build").

> Heh, I tried fixing this too, and have patches to clean things up, but I ended up
> not posting them because I decided the W=1 warning was less ugly than the resulting
> code in nmi_shootdown_cpus().

CONFIG_WERROR=y is the default (at least in the current defconfigs for x86).
My goal is to match what ARM builds survive (to some extend?), i.e. W=1, so
may one apply either version I provided or yours?

> If we're willing to take on a bit of weirdness in nmi_shootdown_cpus(), then much
> of the #ifdeffery can go away.  Patches attached (lightly tested).

-- 
With Best Regards,
Andy Shevchenko



