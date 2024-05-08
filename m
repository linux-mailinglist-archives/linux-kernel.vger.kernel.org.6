Return-Path: <linux-kernel+bounces-173700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914A8C0456
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0862D2869A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653612CDB0;
	Wed,  8 May 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPuir/jw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EE54FAA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192946; cv=none; b=U0wKFDpEbrplR/Y2scPc1i5LpBvriEmxDezW9iRFZdt2coNGKMKpf+Qf9AlNP67vY0LlzjtovonYn8AXm+KMzbSc7I6+CKR0/0JPa9u9E/h7L2H1hOuWOS+tFD9dTvwwFwQOLtfiZlsPQDtyN9D+n6bdodQbd35eY+QaeIp9wh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192946; c=relaxed/simple;
	bh=w3kZgmXnnJRsJLju+dT3OUItaJu9Z1c9zg2md9E1tiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6am5Kh+aQ5NPtEgsx51bZ5WosH3Y+si/Ljk43DxDFsc8BQ4fBxHNDTl51/01CKVkEm1bwTImhOvyvTx4svUyzoN4omz+XWN1KJMoE8RHP6AAzqQfHlFfdWQljlbJL3ysQ9fofe0jMCkyFfUSx5xCeJoo876d96uNwk4SslXEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPuir/jw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715192945; x=1746728945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3kZgmXnnJRsJLju+dT3OUItaJu9Z1c9zg2md9E1tiA=;
  b=CPuir/jw0T5x0y3CwrqVYvfxvjS6ekUJpVKa38FPCoUBfaOFNPA86yTR
   gzq4W76NDcj/WN8rpbPDUZWyamSUAa/z2ZD7uVzE29wu5uO7EjPZ7xQ7C
   PSHmgGzbWNyLVeGLgOhqDKD9ZulN7w+MxHJiUcI0eR4kdGbvbPIdp2ztT
   MzMHzT1pPoEagvGWiSogjJTsytphZ8fhIdTovBiBZiDB71BZcYgshzyi8
   2SATfLD6f+9e4HJCkiHrL5EdVCLPK+AcA2ZHwQI7LlQyvuJ3rNHdKEL34
   QBQMyqSCtbemWmpvQ1XYKPDSqAMMq1eMFTbArvi/P4HynNgr542T17yXv
   w==;
X-CSE-ConnectionGUID: hzJ94pHHToyv0X9zxn+6Tg==
X-CSE-MsgGUID: OA8u0srZTFy7SpDXvfSMsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11231592"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11231592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:29:04 -0700
X-CSE-ConnectionGUID: y332NT5ATcS/PqALfhLjhA==
X-CSE-MsgGUID: GaWUBkhQQbq3B1arheGwqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59840609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:29:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s4m2E-00000005XVd-3wSo;
	Wed, 08 May 2024 21:28:58 +0300
Date: Wed, 8 May 2024 21:28:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] eeprom: 93xx46: drop unneeded MODULE_ALIAS
Message-ID: <ZjvEam5paLD0Iv6V@smile.fi.intel.com>
References: <20240414154957.127113-1-krzk@kernel.org>
 <20240414154957.127113-3-krzk@kernel.org>
 <Zju8HpBCiOjjIZ1j@smile.fi.intel.com>
 <6599e2a3-3b04-4ea2-aa5c-a916b66c8009@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599e2a3-3b04-4ea2-aa5c-a916b66c8009@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 08:15:00PM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2024 19:53, Andy Shevchenko wrote:
> > On Sun, Apr 14, 2024 at 05:49:57PM +0200, Krzysztof Kozlowski wrote:
> >> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> >> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> >> the alias to be duplicated.

..

> >>  MODULE_ALIAS("spi:93xx46");
> > 
> > I was stumbled over this (leftover?).
> > Commit message doesn't elaborate this bit.
> > Any comments?
> 
> It is not present in ID table and commit msg removes only duplicated
> aliases. That alias has meaning - someone might be actually relying on it.

It seems no users for it. The only user of platform data of this EEPROM uses
board files which AFAIU bypasses modalias matching.

-- 
With Best Regards,
Andy Shevchenko



