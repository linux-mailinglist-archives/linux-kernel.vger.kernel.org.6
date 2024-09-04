Return-Path: <linux-kernel+bounces-315892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E351396C83E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931BB1F24442
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78CE145A05;
	Wed,  4 Sep 2024 20:18:40 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACC6BFA3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481120; cv=none; b=IRMB6d2VO2WTy93LkSXVzNu8TjX9tNFy6BEnS2fBVvNwg2wPgzhi9ku0qFr+4sH6NOaDlIYM7GSDcQ1ObsbYfYl4CAVWYke468D/vuGVroiYFsadkMkQwXyD1sNvofgWgtuLRunI97s5+oiIoRxial5LN5wUg9bH8dvIevGDYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481120; c=relaxed/simple;
	bh=k6RsXNwLgxov2po/iQNH02SOvV8DmDra4bYIETXKEiw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOhExJzT5fxykUszqfyXoBcaE6uZkwuDKSaZUVyLO/UQCUCxG5/6sXJ8HsduIra5aCib/biG9N8L6CrTd1Q21onPlBPKni644w53PXCRLaFXSdp1Bsv8K9iAN8azc83SuUTGjfO/QRD2UuBzbZtDQHs9xj5i/pndOPGZTP8tEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id dc229e1f-6afa-11ef-825d-005056bdfda7;
	Wed, 04 Sep 2024 23:18:35 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 23:18:33 +0300
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <ZtjAmavK5tr4mvka@surfacebook.localdomain>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <8a106cfe-f7cd-4660-983a-feba627cdcab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a106cfe-f7cd-4660-983a-feba627cdcab@redhat.com>

Wed, Sep 04, 2024 at 08:14:53PM +0200, Hans de Goede kirjoitti:
> Hi,
> 
> On 8/29/24 6:50 PM, Andy Shevchenko wrote:
> > First of all, it's a bit counterintuitive to have something like
> > 
> > 	int err;
> > 	...
> > 	scoped_guard(...)
> > 		err = foo(...);
> > 	if (err)
> > 		return err;
> > 
> > Second, with a particular kernel configuration and compiler version in
> > one of such cases the objtool is not happy:
> > 
> >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > 
> > I'm not an expert on all this, but the theory is that compiler and
> > linker in this case can't understand that 'result' variable will be
> > always initialized as long as no error has been returned. Assigning
> > 'result' to a dummy value helps with this. Note, that fixing the
> > scoped_guard() scope (as per above) does not make issue gone.
> > 
> > That said, assign dummy value and make the scope_guard() clear of its scope.
> > For the sake of consistency do it in the entire file.
> > 
> > Fixes: 7cc06e729460 ("platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Have you had a chance to go through the discussion?

TL;DR: please defer this. There is still no clear understanding of the root
cause and the culprit.

-- 
With Best Regards,
Andy Shevchenko



