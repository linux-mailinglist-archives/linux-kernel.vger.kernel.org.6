Return-Path: <linux-kernel+bounces-412622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E189D0B85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3D22819FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAD188904;
	Mon, 18 Nov 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaauD3Vz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581F17C224
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921659; cv=none; b=eqqCjFqNFOTJxYIp+fgbGwa57k9NWjOz446RbDCEuoeZI/TtOqbiLIltUBfuAobugWb3MtdCQtP03xONQ2ZQC9oetdxhV2jni7CBnWkquFgHWYPxBk3uD6EuFfjfwWS/EcLDfa8ZX6Ug6FcoZYyGeZh0/9wkgr3ylJjxnFa9Eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921659; c=relaxed/simple;
	bh=ugfZnn5J96rAO7xJaylkbIGnNeAO2t/ZYiEJsCSX0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1KweA9+CDsQPEh+RfQnLGBImIvu7Tmi89jKhwj/MHPO2S3nbdyNgz1Fl5NI0rlvMk0MUW1CJcRGc0bWIU5ftWTxq9s1jc8qq9Rh1bDLdlm8KWUsHNqAg/z4epxzb/JNPgKkGMGesPne4VKP1QRQt8wAnNGRGm59o/dliUdweLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaauD3Vz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731921658; x=1763457658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ugfZnn5J96rAO7xJaylkbIGnNeAO2t/ZYiEJsCSX0/A=;
  b=aaauD3Vz7kttVFWEEMoODNLD3we0EwPnyEDb8F0DphbOXBRarpkU+T09
   aZkmG74aXlK8MXhzgDsyyGGYgHArVdIXKeE3s9Xmhs7tZpRnC1+5WBgUx
   JoH7SFZ+SbCJeEpFYgLhWAjDeOn8wcNN/WOAsUawT93RrvPsdcg0Tl6Ib
   AfYzjlh586wITWKlV/Pop54Qwp4h+n+uIqo8T8MTuCl4bYMxiHITc5/ws
   g9nitYwtv/qwqep1AMg1mN5V6xEyTDR7+HT+VXCeObAzMsGzIjkAW3JPu
   XhmWLP3cjCI9LcjQzgff9B56M9uT9jviCqz+3mcl3ywtpw06Sq9NyXlhc
   g==;
X-CSE-ConnectionGUID: b/FgioCKQeCpZq8hiwVJpg==
X-CSE-MsgGUID: L4IxNC0+SS2WRzAO5U0H8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="54367159"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="54367159"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:20:58 -0800
X-CSE-ConnectionGUID: vyZTs5DpQiKdNdoeJy54xA==
X-CSE-MsgGUID: ggMpVe6gQ8Wd/iuMyoVi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="120022881"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:20:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tCxwC-0000000Fwtr-1EaC;
	Mon, 18 Nov 2024 11:20:52 +0200
Date: Mon, 18 Nov 2024 11:20:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <ZzsG9EjzV82Crl2W@smile.fi.intel.com>
References: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
 <5b44abcc-f629-4250-9edf-7f173b78172c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b44abcc-f629-4250-9edf-7f173b78172c@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 16, 2024 at 11:44:35AM +0100, Christophe Leroy wrote:
> Le 15/11/2024 à 14:38, Andy Shevchenko a écrit :
> > Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
> > and structs with appropriate alternatives.
> 
> Looks like you don't really have an alternative to
> of_mm_gpiochip_add_data(), you are replacing one single line by 11 new ones,
> and that is done twice (once for cpm1_gpiochip_add16(), once for
> cpm1_gpiochip_add32()).

True, but that's the issue that we have of_specific API. If someone propose
the common API for the agnostic approach,  it would be nice, but I am not
the one. And TBH I do not see the advantage of it right now as almost every
GPIO driver is using its own labeling schema (*). Note, that this patch also
fixes a memory leak as a side effect.

*) the legacy API is mostly used by PPC code, do you want that of_mm_* thingy
to be moved to PPC specific code instead of killing it? Would be done this
way as well.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   arch/powerpc/platforms/8xx/cpm1.c | 119 +++++++++++++++---------------
> 
> Does not build:

Crap, I most likely built something else and not these files...
I have carefully build-test this for v2.

Note to myself: Never ever send the patches on Friday evenings! :-)

-- 
With Best Regards,
Andy Shevchenko



