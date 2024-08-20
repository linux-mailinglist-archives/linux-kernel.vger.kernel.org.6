Return-Path: <linux-kernel+bounces-293580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30DE958193
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1F71F239DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122518B489;
	Tue, 20 Aug 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i41hJDdC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA018A94F;
	Tue, 20 Aug 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144437; cv=none; b=hOGYamKvmQROT+sUR2aN5fursZzfAWSXs5yNcJJh6DWLrEUp+IpA4yoVm/eKfK+OIkkOVoBwSiDbSoblFajs1u0KrznuRv7rUKlDlOkkAKtUS1USIiG73QJQ3lO52XwSTUO2vNcNm0kblnilhrXxfxgAahDO2AlFCcQjuQxY7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144437; c=relaxed/simple;
	bh=N/2n6+TMCGjpJV1UloCrG/l1ip+b8yTgzRdVJBE9X4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOPG7zmgqcP8kcFwWMB/g1Jr8mfF3+QPTgiiNjnp9NSjoopL8TQgLv7lydYFdkvaBzticP3tHE2F38JmAxyajpFqxHwiiK4ot3An/jwwMmLVzawbg/zhWsAH6Pqoh7OFKc8TO8++GNFDo1ndRxLJTo3TgCJn6Aab7CUn3gGa1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i41hJDdC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724144435; x=1755680435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/2n6+TMCGjpJV1UloCrG/l1ip+b8yTgzRdVJBE9X4U=;
  b=i41hJDdCtKZVo5OnbgpY8SuDwkyxRA2cgfgtsiZAQttX99AwVgpq6IBj
   SK41mEYkAQcS8r32fMs29aQXw+ii6RQmXfO4dd4jPtu6Cg59JEhVDIFKy
   m6AxQLKIqJfeUMWrn1SqS6fvt/+qdBP+yWfdm4fTq9Nl+5BHN5FxX/CCh
   YcAtFiZfNPPJ09dwLEYv/qJ6uUnJCFVdO2Kz7k9y2yM7aAn8RtpySzscm
   BAecrkexoEWDw16Jp/VTdfKYgmmnr1RfEIvAQBmIvbt+ePxG3ITgs2lyz
   TmZ8hKDNZ2CrLtyGBQFXsT4rUStyh7YY4L87GryclcMkBiSoR/k6DZ7fA
   Q==;
X-CSE-ConnectionGUID: keZWyMHkSBWG0evRQ8aeMg==
X-CSE-MsgGUID: RAFsvtGCQg2vZqMIjMDjTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22595734"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22595734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:00:34 -0700
X-CSE-ConnectionGUID: C7avtJ4oRQG7WfUgBXBFQQ==
X-CSE-MsgGUID: IOrPGsCnQNC6ISeon830uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="98123500"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:00:30 -0700
Date: Tue, 20 Aug 2024 12:00:27 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZsRbK8TEk5GZDl0C@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
 <ZrYEQqs0IwDHWkGx@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYEQqs0IwDHWkGx@ashyti-mobl2.lan>

On Fri, Aug 09, 2024 at 12:57:54PM +0100, Andi Shyti wrote:
> On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> > > Add hwmon support for fan1_input attribute, which will expose fan speed
> > > in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> > > 
> > > $ sensors
> > > i915-pci-0300
> > > Adapter: PCI adapter
> > > in0:         653.00 mV
> > > fan1:        3833 RPM
> > > power1:           N/A  (max =  43.00 W)
> > > energy1:      32.02 kJ
> > 
> > > v2:
> > > - Add mutex protection
> > > - Handle overflow
> > > - Add ABI documentation
> > > - Aesthetic adjustments (Riana)
> > > 
> > > v3:
> > > - Declare rotations as "long" and drop redundant casting
> > > - Change date and version in ABI documentation
> > > - Add commenter name in changelog (Riana)
> > > 
> > > v4:
> > > - Fix wakeref leak
> > > - Drop switch case and simplify hwm_fan_xx() (Andi)
> > 
> > I do not understand why we pollute Git history with changelogs, but it's
> > probably the ugly atavism in DRM workflow.
> 
> I never liked it! Besides it should even be against the
> submitting patches recommendation.
> 
> I don't understand what interest might have someone in a couple
> of years, reading this commit, knowing an unintellegible list of
> differences between v2 and v3.
> 
> I consider it a random pollution of the commit log.

Isn't it already documented?
Documentation/process/submitting-patches.rst

Please put this information **after** the ``---`` line which separates
the changelog from the rest of the patch. The version information is
not part of the changelog which gets committed to the git tree. It is
additional information for the reviewers. If it's placed above the
commit tags, it needs manual interaction to remove it. If it is below
the separator line, it gets automatically stripped off when applying the
patch::

  <commit message>
  ...
  Signed-off-by: Author <author@mail>
  ---
  V2 -> V3: Removed redundant helper function
  V1 -> V2: Cleaned up coding style and addressed review comments

  path/to/file | 5+++--
  ...

Raag
> 
> Andi

