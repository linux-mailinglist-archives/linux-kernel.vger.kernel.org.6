Return-Path: <linux-kernel+bounces-548978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E10A54BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC37A1898062
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D20DD79;
	Thu,  6 Mar 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3UaXmGN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068A20D50F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266699; cv=none; b=PgvrRYmYCWULQqvt66hT+ITmH/b1FMnpQwAl2HVg25W0gqsvf6ErjCNZhT+Yd11bkvbFQ5UcOEU9Zu240RWZzTljLifOQSnrCc+AHHMtw7MdJ9pwif4la2uH/Ti75tTPhE35MaiI2LoORpt466km55+PlkeZvOZrOZsK+lDdYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266699; c=relaxed/simple;
	bh=OW0AABwV4kkghFUrMLhVQ5s89X7j+zKJ/MGBR1bvqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azqIxnBU2YThXDVv7JjQKmFORtXLnsjjmnUM/HMG1d7sgiw9upXZr+sR0aJ/pQlbzxZCaL7o9LtaQQO9jpzv2k1apybKWPHonlRJnKTDJK3oXouo9WXTbNurLZKrRy6/j0IzpZZHfuiJfYsFJpJZsiURyVx/e3Lqu0W4j/eqAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3UaXmGN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266699; x=1772802699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OW0AABwV4kkghFUrMLhVQ5s89X7j+zKJ/MGBR1bvqJc=;
  b=C3UaXmGNWkUC3YPwhtDCOaN52jOvVp4WomXiUsxWCchHa5WW2ol1E5o8
   WMuU3dYPHgGisSxGzQEAmqkhQ5yLbTlKrhNnu9/VeLezxEEazr7QgE2sF
   Dfh7AZPltNAZtVsLejCmtljNroo4oNAgkjx5LtsxX0M5Gfd5lAv7FIVEI
   0VMssFTN5/8MJ2e7+DMa5pJjm59r4ibIh6pCciVS/6cobfI8FU3IawMQd
   w6gsYh/q2RS6G6CX4321QsAdAok7OQj2SGx+hJdZIXzdOe5IyyjMIRaoQ
   KBv89Y/4Eo4pGzgEerLM8qdtjzwMacrmrmbZEnn1kk1nieZ0dvRbODLG2
   A==;
X-CSE-ConnectionGUID: PFNkWBReT+GxkCaJN5ZjSg==
X-CSE-MsgGUID: uFUFP22RT/mXzfYTtIpB9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42469757"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42469757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:11:38 -0800
X-CSE-ConnectionGUID: fqQKbtOCSR2n84cNr4NstA==
X-CSE-MsgGUID: MfgAeYkFQyWBYaFxQV0Gkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124230241"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:11:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqB0b-000000007id-3ppG;
	Thu, 06 Mar 2025 15:11:29 +0200
Date: Thu, 6 Mar 2025 15:11:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
Message-ID: <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Add some additional tests in lib/test_bits.c to cover the expected
> results of the fixed type BIT_U*() macros.

Still would be good to have a small assembly test case for GENMASK*() as they
went split and it will be a good regression test in case somebody decides to
unify both without much thinking..

-- 
With Best Regards,
Andy Shevchenko



