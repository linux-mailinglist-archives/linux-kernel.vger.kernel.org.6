Return-Path: <linux-kernel+bounces-553731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F7A58E32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D16916B39C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8C221F12;
	Mon, 10 Mar 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8F/EfAd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE193F9CB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595478; cv=none; b=RUmmWMytbiZ9pUdZIt/VrJXbt8f2Ahqq0NdMkY/BnG79nshXv4AJ1ZE4pSVkdjv5AHB8HJwG7J0MZDC8LErGQouhHDeyhIIhUGPVYpRf1IiiHchLANNNSlr4JdRZjqs/TBJ25nLAFncV7Peq/Bf8KLdFpyd7G9Vfd6KQ+P5pO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595478; c=relaxed/simple;
	bh=TeeFYbNtcQil/Jl34UEc4QL5JBoHsqXapj7AgqfV4Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5x+UjgightHCFbVu1G7X4+o6yscT43fGn7t8ub0TtpQwu+ZEPD3WJJfezaH9YznRtzlIv63m0OpXdv+ScwD0h4VujOe1zGvcMqoMVqD3Ha3zzthVO2sDdOCu4FEH/aqvRA2n14hqkp8BXKcqb70Sys49h044UnxRXwiyuYiUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8F/EfAd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741595477; x=1773131477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TeeFYbNtcQil/Jl34UEc4QL5JBoHsqXapj7AgqfV4Yo=;
  b=e8F/EfAdu43IXTxR3zNiS2AAdL5rBTEOCZbsAYjvEHE7v64pMcixVIwH
   K2TZEaKBa9SmtMw8HJ8hy/QmTkFlBhkD6BzzmJGnrjl4ngQ3WmAQELK64
   yXBuGZzjPdtWZ5SU4RfTwprkjNtH8uSNvloCByH7Bh4VAq/9WLrG8Ffmb
   LpCGylofp9U9O5tix7ohpCSVPS6jFDNTX0ouQzEbgoBMj7jICunUVHe4T
   Fw4ZibpmfQCOwR4S0QjwwfJg8bAs/GjkwrCXwZiW79LnmNqr0cCu4EPP7
   dzKLrWvlamLKysFHv46guIZhGkVKOYw8x4UuVglq4W+YUdt/gafxquFKX
   A==;
X-CSE-ConnectionGUID: n2gZLbboQoS0teM6KI4e3w==
X-CSE-MsgGUID: lSjfArm2QCCH19AbaDmmNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67939855"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67939855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:31:16 -0700
X-CSE-ConnectionGUID: m2DFTbx2QeSC5htncF8+Xg==
X-CSE-MsgGUID: 8yonNio2SJKaIHLuKChv1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124088037"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:31:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYXW-00000001BwA-3quX;
	Mon, 10 Mar 2025 10:31:10 +0200
Date: Mon, 10 Mar 2025 10:31:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH next 2/8] test_hexdump: Create test output data from the
 binary input data buffer
Message-ID: <Z86jTvOdq0fgvqRO@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
 <20250308093452.3742-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093452.3742-3-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 09:34:46AM +0000, David Laight wrote:
> Using the same data that is passed to hex_dump_to_buffer() lets
> the tests be expanded to test different input data bytes.

Do we really need to kill the static test cases?
Are they anyhow harmful?

-- 
With Best Regards,
Andy Shevchenko



