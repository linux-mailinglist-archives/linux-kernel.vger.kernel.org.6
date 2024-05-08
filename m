Return-Path: <linux-kernel+bounces-173453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786C8C0098
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672EFB21091
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D13126F05;
	Wed,  8 May 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJyg5OjN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8969D29;
	Wed,  8 May 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180816; cv=none; b=lrocmcDeLXR2dJa/kmzIZ34lzmboxD7SEZUHqs9AbcV7irrTgzak9+qE3eMq+dL8S0pNMm15eNfMA11pfr3l2A1MUD3VTB8AVhmBZGP3ANqmiHokBlAci05+Y0926IfyknySPNUeYv1biQocL+kQneqp4oATYcHtE52ADQMLM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180816; c=relaxed/simple;
	bh=v5MiUA9DTlKONnt0SBn4aw4JvqbNC1DtJQVmFvcZPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJLhd59feKMlnVpb9kHNTu5aBJbnxFrwaSFOB5veBeumMx0gZF4LPOmJhlmFCFVyWswQoi7olRb0VM3jAOcalbajTBS8zRSa3FV9QmTXelSUvNnJGPlylKlCatBbemC1SPdIUlm/pLsdP3d0QkXyckCsmWX2qA6n+pgSqvrB5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJyg5OjN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715180815; x=1746716815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v5MiUA9DTlKONnt0SBn4aw4JvqbNC1DtJQVmFvcZPtE=;
  b=jJyg5OjNQvQvlm3bIZtKVVVK5B5HEmgZSojI91ldbcQqL69FBPxMKLgI
   vzgGhNKU4++CULtFZWNJcPwYOlz00ErGZGiNFoHv87T+2F6Ed4BZfNCNa
   MtFiG/p6p85hF0cUBZZZNTST3uFbPyW14UYHPItqrucee6Ivz19splaCW
   IICogaj5dryQhVAI5+CXBSInUu/fRH8kMkBWrCa09aA6WtlDJ6x/OQpVn
   BoQxynZZoiHiQOCQ8p5Mvadk9clxxmZa1d9aGcyDblJsMb77N/jjwi/5X
   t3V3hnqHoiMguPmqyqBbkh6S3M85nu3jzmT9eSUfggqZzTIPssR6DfDSR
   w==;
X-CSE-ConnectionGUID: 7opiOhjMSuOjgvVcqS/8/A==
X-CSE-MsgGUID: uVudBaQoRR6cFxwAp9PxYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22441864"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22441864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:06:54 -0700
X-CSE-ConnectionGUID: tGQnIkQQQwuurRWpgH/mpg==
X-CSE-MsgGUID: SCYgCp7nTxeB0UCGo3Lfxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33474428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:06:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4isc-00000005TlZ-3C2a;
	Wed, 08 May 2024 18:06:50 +0300
Date: Wed, 8 May 2024 18:06:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usb: fotg210: Use *-y instead of *-objs in
 Makefile
Message-ID: <ZjuVCvQw4aL0x42W@smile.fi.intel.com>
References: <20240508150406.1378672-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508150406.1378672-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 06:04:06PM +0300, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.

Note, the original approach is weirdest from existing. Only a few
drivers use this (-objs-y) one most likely by mistake.

-- 
With Best Regards,
Andy Shevchenko



