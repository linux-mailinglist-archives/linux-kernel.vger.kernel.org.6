Return-Path: <linux-kernel+bounces-314779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464496B870
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332561F217C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645DA1CF5F6;
	Wed,  4 Sep 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ9REuiy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C743FE55;
	Wed,  4 Sep 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445579; cv=none; b=YgFad04lQjKzk9laAfqqRSKAcdAz/RZ8ucCMLBXIU/PQabLCZl8F4DGRNUNl7lABISqVVbXyGpzTqwR7KtZSkgs+R97dorlYFE4bqeMFfnFhcpn15M1rQ7K/QFRNxhwKFPkryWcRysidqpdJP3EPlcUNWOev05xie/oK0GB8f0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445579; c=relaxed/simple;
	bh=1+gcebRb6s/Z1nT4A29rHqvVzXh5X6h2900oe2W26pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoSWLbNQZT45vopLdW0aGDtAYPuOzaF8xf1AB7AJyJaWDpoFvy6oRvrH9K+dFJLrcnjSYJWA41/+6cR16wuWRnwRn2DKOh3uesrI9IbS6H3rRhF6G827Gvb7pX6poRiEWa5eShbx2i6l1lba4W8FCoOPH49FxKb/daVH8AT/CP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ9REuiy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725445578; x=1756981578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+gcebRb6s/Z1nT4A29rHqvVzXh5X6h2900oe2W26pA=;
  b=IQ9REuiyK+6HXO9etzqLVOlDOTry2G2z0kXxwYuFM8Tdqnjv4dP+9tRo
   gwLlpQLfNFRSh3VV6GNiiS5owOpJ/BZrIVuvXUcuAch4x7cSH168ZT6JX
   cEYDv8BLaduIjHZwKVv6p4CB0KMtbLTgPzRQWG6CwqQkDe7RfI2XHcPY2
   JAFL/5DnXUSUPwlquK0Gvu6Cln8GGpN/tdY51w4VtA3cKYCv4tIblIVto
   juMD6RaFJ++gxzE8ql3Sk5hqd55lNgzz3JayKx2x/s6MQQisYlCwOS53I
   IakG4vg43+UwEDcWp/Ar1tdgxZp//nde5fNmpDYos1R9omRZO5asGzDlz
   w==;
X-CSE-ConnectionGUID: hTrYbaXtQgaEd5t3msH58w==
X-CSE-MsgGUID: Sw7XPhHUTM6L/Gbn4D6fAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23658337"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23658337"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:26:17 -0700
X-CSE-ConnectionGUID: LnWLyTQSTOytqkiBGv3DFA==
X-CSE-MsgGUID: 4sJJzql1RpWptRD1/7bEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96021263"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:26:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slnDI-000000051xE-0c8q;
	Wed, 04 Sep 2024 13:26:12 +0300
Date: Wed, 4 Sep 2024 13:26:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <Ztg1wzHB-so2qV2L@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <20240904045201.v3mp4u7pcqj7qrdp@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904045201.v3mp4u7pcqj7qrdp@treble>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 09:52:01PM -0700, Josh Poimboeuf wrote:
> On Thu, Aug 29, 2024 at 07:50:32PM +0300, Andy Shevchenko wrote:
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
> 
> I'm not sure I buy that, we should look closer to understand what the
> issue is.  Can you share the config and/or toolchain version(s) need to
> trigger the warning?

.config is from the original report [1], toolchain is
Debian clang version 18.1.8 (9)
	Target: x86_64-pc-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin

(Just whatever Debian unstable provides)

[1]: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/

-- 
With Best Regards,
Andy Shevchenko



