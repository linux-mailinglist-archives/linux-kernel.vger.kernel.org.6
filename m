Return-Path: <linux-kernel+bounces-446213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC79F212F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D487A0F71
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E91B218D;
	Sat, 14 Dec 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd0TmU9O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32529CEF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214733; cv=none; b=a2H4Vf71HYT8nWdWQ18/uV/nBmXvsnqnNMW2OD6t56IgIdVZOGH27bv5/ie85eQSkUN3WgMZdZHKz/O/ILtx6LjXkK9AaB4BptbQiJFD226UtO4AYB2Pe0VDoKfGJqPytATi/iLCQWQgOwcXnokes7eE391yFCw8xFWO3Twmd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214733; c=relaxed/simple;
	bh=rrJn6Y3w1pf8OHmv/ZNQSjjsloyZOFExYTXbxTK9eXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4jtVgu83SPS8/u517rwY4oST237G93cOAmIWcHaa1ab/iofIXykOQ39YnT9WeK5UJSP0BVNsyrTFUUJKNS0ZSUohasU9qWMq8+TsffhuLy8YqQFK4DDkBTt5HaGWH01RZQo4g5dclqr2p/h9UmMJ3lJ+xy1FPA+YAeGc7f3loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd0TmU9O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734214731; x=1765750731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rrJn6Y3w1pf8OHmv/ZNQSjjsloyZOFExYTXbxTK9eXQ=;
  b=kd0TmU9Oi2sMGtc6yhWa6+mw3A+zP/8vWvtVGWidVA1qACZ88aB8wezU
   tLGFMhwyVTwolMuWO2GuhEACKzM2STMmKWY6h5kN+tK8EmarKINX1qXvq
   wDvhHXv3Anp9h/5uEMEx8I1l+o5ZGZ/+CyoW+P+2GUrrZqGOQtSQ7YYp1
   9R1dDQy+yZlHkkkJve35d4idu8WrTT10Cprc88TqMhd50j4GW18hPTWnj
   9LSdsV7LiRD0uRybejckY9HKkUSrg+MlKqnF89xjc4xhA8ydaxomDiMYx
   08eS2vnXYZXWpc2m5/ZM6q1Q1+MDfcK+6sUe3e948gD80g0BH8X2FAOwJ
   g==;
X-CSE-ConnectionGUID: zvBmQG0iSMqAZ+bLCLVtWw==
X-CSE-MsgGUID: OCiUjXQ+Tq6vAyuEZ/p51A==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34515551"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="34515551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 14:18:51 -0800
X-CSE-ConnectionGUID: SRIzwWp+TsKokfDWIcZDeQ==
X-CSE-MsgGUID: aNCuxcMYS92jKAMx48kYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101942157"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 14:18:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tMaTG-00000007voL-0SSV;
	Sun, 15 Dec 2024 00:18:46 +0200
Date: Sun, 15 Dec 2024 00:18:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <Z14ERRHbVALHs8AT@smile.fi.intel.com>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
 <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
 <Z1xp1xwLXAvkKgwD@smile.fi.intel.com>
 <95951cd6-f98f-4793-a35c-22f4e8d743af@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95951cd6-f98f-4793-a35c-22f4e8d743af@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 13, 2024 at 07:01:42PM +0100, Christophe Leroy wrote:
> Le 13/12/2024 à 18:07, Andy Shevchenko a écrit :
> > On Fri, Dec 13, 2024 at 07:28:45AM +0100, Christophe Leroy wrote:
> > > Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
> > > > On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
> > > > > Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> > > > > > Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> > > > > > file provides an OF API that's deprecated. There is no agnostic
> > > > > > alternatives to it and we have to open code the logic which was
> > > > > > hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> > > > > > drivers are using their own labeling schemas and resource retrieval
> > > > > > that only a few may gain of the code deduplication, so whenever
> > > > > > alternative is appear we can move drivers again to use that one.
> > > > > > 
> > > > > > As a side effect this change fixes a potential memory leak on
> > > > > > an error path, if of_mm_gpiochip_add_data() fails.
> > > > > > 
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > > 
> > > > Thanks, what's next?
> > > 
> > > Next step is that Michael or Madhavan apply it I guess ?
> > 
> > Folks, do you have any comments? Can you apply this and we move forward towards
> > removing the legacy API from the kernel?
> 
> If you have some work which depends on this patch, you can also take it
> together with that work through another tree. Just let us know.

Not right now.
If Linus or Bart want to take this via their tree, it also would be good.

> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

-- 
With Best Regards,
Andy Shevchenko



