Return-Path: <linux-kernel+bounces-541873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2620A4C2C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070861735E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EC213E64;
	Mon,  3 Mar 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kY9Z6ZrA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE721323C;
	Mon,  3 Mar 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010631; cv=none; b=d3pWb+wB6ImDuvs0rn1ZLOPTo0bsJY+JbZA17aDNyuBhzbgRvULtoc6wTC9aXLpUP4FrxI7p/ehbfRn6MUiJPe1jTUD11EEfDhuuUwKQXImOuIHxy0t1mIVNJsSTTweD9Pxi22lFEWV7rZd32zf6LhpLUqN6DKbdUlOq/pLVV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010631; c=relaxed/simple;
	bh=3M2+r7N14N7LteJop0WZk9T0FxrcpfMkX6eQmqm0uI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/QGbvp0xTiSqcKyMFLgHdLP7uNQ+eMiox9N97ThsW4tZ/lWkNfU4K7FPzsI4u2YUFXgrM7Oeb7NXMVjeBjCQLGiedib+5XAFmeCIEY6SFuvIHgp8d3d/kA6tgiSEDqUsyGAiLmxgLmi8trwJzpfmGUUHRxLQOM2syUNBIJ973Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kY9Z6ZrA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741010630; x=1772546630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3M2+r7N14N7LteJop0WZk9T0FxrcpfMkX6eQmqm0uI8=;
  b=kY9Z6ZrA9XW3n1WaPN90uIaCJCyQ3byYSuy0UHB2SHWsRcK7/0RmdB0C
   hXs9EwnDnCblMoSHbp3puTNl9+rE4HsSFqQL9K/Wx0xa3oM8tOKBqY9dX
   aEfvv6R1HCZr4ZmTMlPybH1uoPfGTwbPMMwhByrnJNIyDOnvboVvdD5M/
   CUg+9hUIgdPUcYlqsnCWLRIQtbpFXrDqRWRO5T0wnCMgaTdDF7Dsujhp5
   DwfbkcqqoWm+jqabc0TAM+q1Ydt5X6pMFPu6X2L8EVjk5EuIHlgeyDEqL
   JHoBBy/L4zHBOgtkQtg4vgtdCn1S+Rhs13xZwRDZWg1SiMW6xKw850q6+
   Q==;
X-CSE-ConnectionGUID: Zh/vLd4ESL+irVDKY6Uecg==
X-CSE-MsgGUID: l+nNzpIKS4eCzNMGOLkNcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52091980"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52091980"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:03:49 -0800
X-CSE-ConnectionGUID: k0JxMKBHRRWzV0M2qw2S9Q==
X-CSE-MsgGUID: aa8KhZPTRsGlCqCyY1dVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117803603"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:03:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp6OX-0000000Gpfm-0PCu;
	Mon, 03 Mar 2025 16:03:45 +0200
Date: Mon, 3 Mar 2025 16:03:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: intel: drop repeated config dependency
Message-ID: <Z8W2wFlrkMK6ZP1R@smile.fi.intel.com>
References: <20250303135506.323533-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303135506.323533-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 07:25:06PM +0530, Raag Jadav wrote:
> We already have ACPI dependency for Intel pinctrl menu. No need to
> repeat it.

Makes sense to me. I'll wait for Mika's Ack on this and apply to my branch.

-- 
With Best Regards,
Andy Shevchenko



