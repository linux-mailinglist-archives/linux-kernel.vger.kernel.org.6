Return-Path: <linux-kernel+bounces-418301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A399D6017
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286CF1F214EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE82BB04;
	Fri, 22 Nov 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei+EfTmb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93D17C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284084; cv=none; b=c+D0cjz1K/eYaHxEJsMufilKEXRfyboabNAoPkCO6SikIbQWkLRouNuWip2QX2g2jWF78pYJ2h+9wlqxSlch/6ITszeSZJQwgG4NkGr5WTSZXpjDhMdwicjNZ/wNBlkPa9Smlez+Q/DH5/9W+kjJVXWRYwxOsXtbBrCfJeai4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284084; c=relaxed/simple;
	bh=dQLCzDSbSHWbQE2TE0Muii5xptJIQVljwPuXC1CIlJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsCyZ9qGE9hVNQGzw6POSIQnczHZ7aO5qryjBizyExdkgzaxxh3rYaCHs5wq2bbVriAsZMpcx3Z+qGs7kY7C0oP2KkUNNMqxzkyQrQIpgKcN/IIzPJvMgx8gIQY/oDoNh6x9HQNTqLUMKHjoTe/H9dbpe2gU6wSmpdq/tONshD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei+EfTmb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732284084; x=1763820084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQLCzDSbSHWbQE2TE0Muii5xptJIQVljwPuXC1CIlJ0=;
  b=Ei+EfTmbPERyHp74mv/bwjf1SEjw2iqpPiuo4MC62JrDRyq9j7+xonWW
   +X/ozmZl2VjOWYPatKU6Ey0qs7I6PsR1grWjonMgaLiGfqOOhA0R5nEL7
   78/2BlrH2oyycENHzEnmts+xy6IJ4NYYFF++Amds7QFBqmnJdwzxRAdG6
   LF60x6GU5W+OpPIwFgaEBCbH7o+lr5gn22yEk832KEaWGRTQzRcStCE5z
   5lfPrvmEvKb5iuTg1DBEYL9qA7iA0ZUcL2H2ittMK52YwTfWpz7f214K+
   YX0NhZHJ0Y997BwKlqepMXNEaWQHYp/biQPqLiVck66UD48vaw89MvQj5
   g==;
X-CSE-ConnectionGUID: nxuNLWDfS5yEeU/R0EMDiA==
X-CSE-MsgGUID: 8pZqMPBiSw+v699MKkTFfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32596712"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32596712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 06:01:23 -0800
X-CSE-ConnectionGUID: WbzW5FAMTXWx2s3Fr+iYLw==
X-CSE-MsgGUID: 8XmMjLTzRy6iwNjn1+Cmqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="121450789"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 06:01:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tEUDn-0000000HQuA-1SaB;
	Fri, 22 Nov 2024 16:01:19 +0200
Date: Fri, 22 Nov 2024 16:01:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: Synchronize cache for the page selector
Message-ID: <Z0COr-MXJTNwF9xv@smile.fi.intel.com>
References: <20241122134734.1336768-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122134734.1336768-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 22, 2024 at 03:47:34PM +0200, Andy Shevchenko wrote:
> If the selector register is represented in each page, its value
> in accordance to the debugfs is stale because it gets synchronized
> only after the real page switch happens. Synchronize cache for
> the page selector.
> 
> Before (offset followed by hexdump, the first byte is selector):
> 
>     // Real registers
>     18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
>     ...
>     // Virtual (per port)
>     40: 05 ff 00 00 e0 e0 00 00 00 00 00 1f
>     50: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
>     60: 01 ff 00 00 ff ff 00 00 00 00 00 00
>     70: 02 ff 00 00 cf f3 00 00 00 00 00 0c
>     80: 03 ff 00 00 00 00 00 00 00 00 00 ff
>     90: 04 ff 00 00 ff 0f 00 00 f0 00 00 00
> 
> After:
> 
>     // Real registers
>     18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
>     ...
>     // Virtual (per port)
>     40: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
>     50: 01 ff 00 00 e0 e0 00 00 00 00 00 1f
>     60: 02 ff 00 00 ff ff 00 00 00 00 00 00
>     70: 03 ff 00 00 cf f3 00 00 00 00 00 0c
>     80: 04 ff 00 00 00 00 00 00 00 00 00 ff
>     90: 05 ff 00 00 ff 0f 00 00 f0 00 00 00

Oh, while it works in my case, it is not the final (*) version I have!
Scratch this, I'll send a v2.

*) it has better check for the selector to be present in the virtual window.

-- 
With Best Regards,
Andy Shevchenko



