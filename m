Return-Path: <linux-kernel+bounces-314021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B996ADC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7260B2296B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5E5C96;
	Wed,  4 Sep 2024 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKZwdAJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294163C;
	Wed,  4 Sep 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412965; cv=none; b=eHOSG+6UgCHD5S1HzV+WirjrSLEpR2/iLDZOwjKpi2U5yN13YFLgiOByiNXvUAx0XHH+zI9qWFR3QK6zZisJl5OEPnCRy7xOuRtom6dleZEvJZAGfUwQVyGuBrz2omZbcewIwmLvvFzGAF/tiaQeoq4Eo1kz5G3AoH0Zz+S/aOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412965; c=relaxed/simple;
	bh=BjK9SFJulTgseXgLqwCl5bq1PUetP1k8wnv/zim9rzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgyEKT9M8VwLLeH2WQrFh/PK0TgirwqGeZnxulLJ6jfPUbhfF8Y0xi0CF+UEKLifh144uX/krrOpjiz9MRY6W8yu2rEdLfNCeudb7iEqaYWKSyR6T8nkvuygqN2lUsPvo6Ne2XAesMSdwvIfoSOzmJeKVWvD86oiueLx81pQOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKZwdAJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D4AC4CEC4;
	Wed,  4 Sep 2024 01:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725412965;
	bh=BjK9SFJulTgseXgLqwCl5bq1PUetP1k8wnv/zim9rzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKZwdAJTEXoIma8Qspr2p8DXcjD5SPY5JEVuAxoV4TdIHiZnzSPBSF9rwK0B/bsWS
	 TpygwfiyqlpxFmxUWeNqBr/UFFOXLiSCrn6KbTTPw5pDvvpG+UPGmYi7yC2GvQUzim
	 WcidqbPkevoPMcvl0WPqKlWHpcpdzYp4xriV3BApu/fqRkHcceEix+UfbjElcZAAYM
	 h50QODaxCCcjkSsU3pebb7ykYNBbapIsU60UfJFeZm4iMLx1jXCUQ6cl1YYd8q0SVk
	 cCpSu788OuRuEdFRXQW1aTP5RSo/8f6j7UxNv2BE9ydujSkn8TVQHpq9okUnhVk3M9
	 9+3HDFLZ9A7Tw==
Date: Tue, 3 Sep 2024 18:22:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gergo Koteles <soyer@irl.hu>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <20240904012242.GA1110859@thelio-3990X>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
 <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
 <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
 <Ztct4P_PvQmeq_ih@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztct4P_PvQmeq_ih@smile.fi.intel.com>

Hi Andy,

On Tue, Sep 03, 2024 at 06:40:16PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2024 at 05:29:02PM +0200, Gergo Koteles wrote:
> > On Tue, 2024-09-03 at 18:14 +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> > > > On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > > > > First of all, it's a bit counterintuitive to have something like
> > > > > 
> > > > > 	int err;
> > > > > 	...
> > > > > 	scoped_guard(...)
> > > > > 		err = foo(...);
> > > > > 	if (err)
> > > > > 		return err;
> > > > > 
> > > > > Second, with a particular kernel configuration and compiler version in
> > > > > one of such cases the objtool is not happy:
> > > > > 
> > > > >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > > > > 
> > > > > I'm not an expert on all this, but the theory is that compiler and
> > > > > linker in this case can't understand that 'result' variable will be
> > > > > always initialized as long as no error has been returned. Assigning
> > > > > 'result' to a dummy value helps with this. Note, that fixing the
> > > > > scoped_guard() scope (as per above) does not make issue gone.
> > > > > 
> > > > > That said, assign dummy value and make the scope_guard() clear of its scope.
> > > > > For the sake of consistency do it in the entire file.
> > > > > 
> > > > 
> > > > Interestingly, if I open a scope manually and use the plain guard, the
> > > > warning disappears.
> > > 
> > > Yes, that's what I also have, but I avoid that approach because in that case
> > > the printing will be done inside the lock, widening the critical section for
> > > no benefits.
> > > 
> > 
> > This is intended to be an inner block scope within the function, it
> > does not expand the critical section.
> 
> I'm not sure I understand.
> 
> scoped_guard() has a marked scope (with {} or just a line coupled with it).
> The guard() has a scope starting at it till the end of the function. In the
> latter case the sysfs_emit() becomes part of the critical section.
> 
> > > > 	unsigned long result;
> > > > 	int err;
> > > > 
> > > > 	{
> > > > 		guard(mutex)(&priv->vpc_mutex);
> > > > 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> > > > &result);
> > > > 		if (err)
> > > > 			return err;
> > > > 	}
> 
> But looking again into the code above now I got what you meant.
> You have added a nested scope inside the function, like
> 
> 	do {
> 		...
> 	} while (0);
> 
> Yes, this is strange and not what we want to have either. So I prefer to hear
> what objtool / clang people may comment on this.

So this does not appear to happen when CONFIG_KCOV is disabled with the
configuration from the original report. I have spent some time looking
at the disassembly but I am a little out of my element there. If I
remember correctly, the "unexpected end of section" warning from objtool
can appear when optimizations play fast and loose with the presence of
potential undefined behavior (or cannot prove that there is no undefined
behavior through inlining or analysis). In this case, I wonder if KCOV
prevents LLVM from realizing that the for loop that scoped_guard()
results in will run at least once, meaning that err and result would be
potentially used uninitialized? That could explain why this change
resolves the warning, as it ensures that no undefined behavior could
happen regardless of whether or not the loop runs?

Josh and Peter may have more insight.

Cheers,
Nathan

