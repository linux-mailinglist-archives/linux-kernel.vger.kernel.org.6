Return-Path: <linux-kernel+bounces-315163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AC96BEC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB141F222C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436E1DB53C;
	Wed,  4 Sep 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HC1CiubN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006371DB53A;
	Wed,  4 Sep 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457072; cv=none; b=LCoJOkz1k+6ShAO9xJAMr9nMSC/ydKY5xdJNZKb4r29xD+7Cvo3C7/lhyHzS4mPivXaO/zUc4Uy7HYnbQZQsUB9Lik0CR204xlk0fXaeJfrj+Z6VpyWi8sFl+oIJlBXyq8/ZaFX1Hz7ZpuHfLg2Xyjy4ypA42K8Cqq15GVAqQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457072; c=relaxed/simple;
	bh=Lr2tvzzIW7EG34uv09xY/LgQ+MM6L3kGqG3moMZRnfc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N14FoStVvRb9DzU7ruvgzTX/3Vz3FK0IEKeP0ZQ713aSN/3uFMATa1dqOTMUmlxLWfEIen8ewzEnEIdpR92dVb1XlrVE3zQSsDDWZ2HN5EQUR7KNXP5YlpN3z0RiX+hOnOmmNkn6IhVq4t3p7p++CWqJJkazui/mOa2/QpxzPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HC1CiubN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725457071; x=1756993071;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lr2tvzzIW7EG34uv09xY/LgQ+MM6L3kGqG3moMZRnfc=;
  b=HC1CiubNGZzx/87vLIz+yRBN2ro+DIouLgoUJDT9Ixn+fOY8LuEWK8L9
   Gt67S894g4hLwaQ4bJDWqqGX/4bzNpKWNBMvH8FmgMsFF0ZBFFO7v2nbO
   D2soLJF/DO5fE5nf21/M1/E0Hr6E2JSqUevvjfHOg6RH/xAnkLaCjBYvE
   Xb2tKolwFF6Vp42Ox9RGKoh3dXuWXmfBjzXjY91Gq5hnuhnrDSyrDu6nH
   8Zn0mk/amOD+3egvv5sA4L38nON0NHttXy+DoOUpXBDtt4aIvDjjn39fc
   tXt2gtyaq4oqGRWn5x/3L2OpTreyFxS+GBAOwT7MiLewcWUwN2xYq+1qL
   w==;
X-CSE-ConnectionGUID: hf27Qx9/RE2C7Y0q4EE9Bw==
X-CSE-MsgGUID: suQKwTv4R46ovhuYMqm2dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23983272"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="23983272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:37:50 -0700
X-CSE-ConnectionGUID: d30JwPZSR/O7Sn8BqR/Zwg==
X-CSE-MsgGUID: h6249UwVQMKTayI3qMEW0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="102684180"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:37:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 16:37:41 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Ike Panhc <ike.pan@canonical.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Josh Poimboeuf <jpoimboe@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the scope_guard()
 clear of its scope
In-Reply-To: <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
Message-ID: <f16f97d2-6f2f-9c5d-644b-d1c3470de06f@linux.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>  <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>  <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com> <0e53a8b6eeb457f11a8a514b12c0598d1727b43d.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Sep 2024, Gergo Koteles wrote:

> On Tue, 2024-09-03 at 18:14 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> > > On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > > > First of all, it's a bit counterintuitive to have something like
> > > > 
> > > > 	int err;
> > > > 	...
> > > > 	scoped_guard(...)
> > > > 		err = foo(...);
> > > > 	if (err)
> > > > 		return err;
> > > > 
> > > > Second, with a particular kernel configuration and compiler version in
> > > > one of such cases the objtool is not happy:
> > > > 
> > > >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > > > 
> > > > I'm not an expert on all this, but the theory is that compiler and
> > > > linker in this case can't understand that 'result' variable will be
> > > > always initialized as long as no error has been returned. Assigning
> > > > 'result' to a dummy value helps with this. Note, that fixing the
> > > > scoped_guard() scope (as per above) does not make issue gone.
> > > > 
> > > > That said, assign dummy value and make the scope_guard() clear of its scope.
> > > > For the sake of consistency do it in the entire file.
> > > > 
> > > 
> > > Interestingly, if I open a scope manually and use the plain guard, the
> > > warning disappears.
> > 
> > Yes, that's what I also have, but I avoid that approach because in that case
> > the printing will be done inside the lock, widening the critical section for
> > no benefits.
> > 
> 
> This is intended to be an inner block scope within the function, it
> does not expand the critical section.
> 
> 
> > > 	...
> > > 	unsigned long result;
> > > 	int err;
> > > 
> > > 	{
> > > 		guard(mutex)(&priv->vpc_mutex);
> > > 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> > > &result);
> > > 		if (err)
> > > 			return err;
> > > 	}
> > > 	...
> > > 
> > > This looks a bit strange, but is probably easier for the compiler than
> > > the for loop of scoped_guard.
> > > 
> > > But I don't know how well this style fits into the kernel.

It's ugly enough that I'd prefer the initialization of results variable as 
done in Andy's patch.

-- 
 i.


