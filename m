Return-Path: <linux-kernel+bounces-551608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A851BA56E82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C193B3C96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3423C8A4;
	Fri,  7 Mar 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3CNkEe8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7A3B1AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366932; cv=none; b=GFNexgBbUkXHHOxD75aUKxMr0kCIkofJMlYmyOlcmG/pB3y01L94M9n5DMnTrha9TTUeafIIov69vxE9gJ1Bc4SDcNe9rRw/D/wdHRhWWgf71e7Ng+/cmwLDgOeYVxkaj7puFJO7PywqRqCqnLXJrSGHPVidYCkJy2abv6QY8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366932; c=relaxed/simple;
	bh=+ngKRgYPFRP1DKAN8/vuq3GJjjgWSePXYp/7NdE2gsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8HQaG0uT/KNIy9yPsvzjujXM3BJ1w7teLJa8Ef1z4rPhUG+b02vQQObUIjxnK/0wtEk9VHwoBqcIpbdgjgGvyLsnvONF6xW7XJ78L3Iuoe3PnxZr2y6SNQvrkR4FpzlAWnmFdpsq+Y9gpVmCveLxR9pdW65X8YZ6YT1JreD91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3CNkEe8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741366931; x=1772902931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ngKRgYPFRP1DKAN8/vuq3GJjjgWSePXYp/7NdE2gsE=;
  b=h3CNkEe84RY5TnyRE13gTaXU9f8B/SuMtwqlAMkc+yxUlh2DpUJ/1kbr
   rbUXYsvHFU75sfE8ds1tiSCJa0trzrEZddckoUYPP6STXaHzCEgDMVkn4
   9c/HMUiPS9QNeeYjTZwVDU86otMxUueUbjFof8nNLjUAzUvTse+ORNnlB
   WESod6Pw7jUM8cWmHKvdykzIzWXjbIYM5xza9VWWmI6dik1lU7/7igs1Z
   E5f5j6gO0oFruqfY2oo5Ejr4hc6mc4jWgBBXaBUBDHdXTZthWuns/1scT
   xvNNdD9IXMu1Mr45LOuGcqZydtZ0R3EDnjAvAB4tYhrGsDYJlbslND27V
   Q==;
X-CSE-ConnectionGUID: MQjJ2pmLT3+zVboTezQEHg==
X-CSE-MsgGUID: WT0WyL50RXuoe2+PEz6tUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42458415"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42458415"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:02:10 -0800
X-CSE-ConnectionGUID: QW4aWxzZSUexDlOTQqLNMA==
X-CSE-MsgGUID: HCHpg8mUSaOHgETTxlZYpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119362898"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:02:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqb5K-00000000Sts-34bO;
	Fri, 07 Mar 2025 19:02:06 +0200
Date: Fri, 7 Mar 2025 19:02:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 5/7] auxdisplay: panel: Make use of
 hd44780_common_free()
Message-ID: <Z8smjviZhatCV3Td@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-6-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW=hfoKZkCtByCb13XaO4vKkk5LBx83ei=ac2CUKWJPjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW=hfoKZkCtByCb13XaO4vKkk5LBx83ei=ac2CUKWJPjg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 10:05:56AM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Use the symmetrical API to free the common resources.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

> Perhaps fold this into [PATCH v1 3/7]?

Since we are changing not only hd44780 parts, I made the split.
But if you are insisting I may fold them.

-- 
With Best Regards,
Andy Shevchenko



