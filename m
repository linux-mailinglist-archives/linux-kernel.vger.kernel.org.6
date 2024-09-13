Return-Path: <linux-kernel+bounces-329000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93A978BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEFB2285C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36017C9B2;
	Fri, 13 Sep 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqQwau0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47D1474C5;
	Fri, 13 Sep 2024 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726270408; cv=none; b=cOheAHofWHMyXBeCQqInmOzfXiyU4k0klfXHWzk2x2mToTN5uqDl/goArJJleExMFPulw0t2CvNF5su9fhwxKppRuOhAR+aqTqh72fSWk3M3aHEeNzHBRTAtfRs7y8TEkD9QWSN2tPmMlzHLgl6KP3P+hc3H1qdAPyhOxYhoZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726270408; c=relaxed/simple;
	bh=bgKoP7vxY/6YbFJKlVCwJxBMEcxQ3xe33ph21bUxIu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbitJQ3nzxy/Nj63zAU5zqzFRAuyLx0uKg6gPeZZGUjycT/U9NX0fXifW40+OU2w8reoInm/bjjw1f9W1pgHYCsag2+4XTP8yPeHX9l0df3F0VgJ74OteRymG/MiphSvcFYtl2f3fXnrPer5K+sUS6CpPWyIG6sSrWlOp6wJ+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqQwau0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1116C4CEC0;
	Fri, 13 Sep 2024 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726270406;
	bh=bgKoP7vxY/6YbFJKlVCwJxBMEcxQ3xe33ph21bUxIu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqQwau0xH4pYCVY3+rXeKifSyGe89LzR55hYuppjH4jIk3FkA05o1iq3lUzE1qXwb
	 2gkJcNoA1CWuycKS6SriIdrpfLgHfN1OMOeq8oEMqLPM7YHkOrqGAW0eXLxou2vEjV
	 vsgjwGRV9EjCR4bnB9IVPNW7g32YmiJCVVOmE/E1gj6I72hpXrQAKu6c2duTorwltn
	 T7tEjPYYacGaKYiE/Bqmr6CJKFb5pa667s1x/P0Oy9EPSVGvXMraVYUyQacgz5H4RG
	 lzGYwbgjYJZuB+BXxUrn1zYea4Y/PTtazKLLvm0iuggd8aPY9fSSffy5AUEDVRe5NE
	 rIaRdY7IId9Ew==
Date: Fri, 13 Sep 2024 16:33:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <20240913233324.GA306935@thelio-3990X>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <20240904045201.v3mp4u7pcqj7qrdp@treble>
 <Ztg1wzHB-so2qV2L@smile.fi.intel.com>
 <20240906031601.4yodvhurcyi26qb2@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906031601.4yodvhurcyi26qb2@treble>

On Thu, Sep 05, 2024 at 08:16:01PM -0700, Josh Poimboeuf wrote:
> On Wed, Sep 04, 2024 at 01:26:11PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 03, 2024 at 09:52:01PM -0700, Josh Poimboeuf wrote:
> > > I'm not sure I buy that, we should look closer to understand what the
> > > issue is.  Can you share the config and/or toolchain version(s) need to
> > > trigger the warning?
> > 
> > .config is from the original report [1], toolchain is
> > Debian clang version 18.1.8 (9)
> > 	Target: x86_64-pc-linux-gnu
> > 	Thread model: posix
> > 	InstalledDir: /usr/bin
> > 
> > (Just whatever Debian unstable provides)
> > 
> > [1]: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
> 
> The warning is due to a (minor?) Clang bug, almost like it tried to
> optimize but didn't quite finish.
...
> In this case, mutex is an unconditional guard, so the constructor just
> returns the original value of '&priv->vpc_mutex'.  So if the original
> '&priv->vpc_mutex' is never NULL, the condition would always be true.

Thanks a lot for that Josh. I have a somewhat trivial reproducer for the
clang folks to take a look at. I should have some time on Monday to get
that reported upstream and I will see if I can find anyone to take a
look at it.

For what it is worth, I don't think the workaround for this is too bad
and it seems like it only shows up with KCOV.

Cheers,
Nathan

