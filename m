Return-Path: <linux-kernel+bounces-303556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C96960DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC91F247EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1151C579D;
	Tue, 27 Aug 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCol5NrL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61171A072D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769820; cv=none; b=NUA/tT8MFL9BX7wkOhjt6pD/PPZxH3vEP7ppnvxu56ZLeHWWGwhAJiKw73FtQaPxIBZRrLT9hZYPNUdfcj2CHXNnUPt/DCgMrHupwWJfqsPWFl9NfoDLraEgZRebrxI4UIuZMjxYwkTwkla9yGvqvKwY8FQpwENdn8fzxMvAHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769820; c=relaxed/simple;
	bh=SJ1lGJe1QsNdx/N8x2ePS2IF/LhDBpafxENkfbaCHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLy4+Z6yADgITzuoKcchMzIuddgWQ3VC0t1rB+1bBDrpmH/n5dan6ja/2FHM7ap2soFYYFag12PHkBGGB7BeEn+wL3juEIitkJIY97UImvyNFyA5JKtcUph2KNGchzNNOo/LywdnpIK88YuqlCxLmjLjO95apVEcjk+n7WAlL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCol5NrL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769819; x=1756305819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJ1lGJe1QsNdx/N8x2ePS2IF/LhDBpafxENkfbaCHr8=;
  b=ZCol5NrL2syZIIzuKZ1yexCDBl0fIgYNiY5v0fIVcVvCI+q9l3nl5pLH
   T5YtX2OKc7cFy6PBBeLNXKRWlIpefenGwq8PNQMoGGsg0/Aev9TDn1Tpg
   vHKlLWvI0JVQVAGz3nD8HgsNnCSh0B9f7WAUVS27XXhrg/GamC8XnWl9R
   WdHQKG/HMITNY55ogbJEnb8V6HWLNnCQwHIkYMMaLUwUpitqSC7jHX2aU
   Kq28/dgqJgw65rBJn4z2XYvgjMF3VbW7fcs5GkJm4DwEsyPDfmUkOYpR+
   V2b9fOMIcUs8Q2ABFCOpPHur1Iu9E3bHvbsJee7CS2q6TNkEs3/glC4ME
   g==;
X-CSE-ConnectionGUID: mKEuAxG9SWi84FnuzqKBog==
X-CSE-MsgGUID: KC3umk7WRAqo57dll42y3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23426302"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23426302"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:43:38 -0700
X-CSE-ConnectionGUID: HILE0BngQs2LpvXnAUo60Q==
X-CSE-MsgGUID: T7wX/i4mTX6PLQdcVdiPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93678168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:43:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixPy-00000002IWa-0fFf;
	Tue, 27 Aug 2024 17:43:34 +0300
Date: Tue, 27 Aug 2024 17:43:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] regulator: fixed-helper: Add missing "Return"
 kerneldoc section
Message-ID: <Zs3mFYpNtN-MjnbK@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-8-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:47PM +0800, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for the function
> regulator_register_always_on().
> 
> Add a "Return" section for it based on its behavior.

...

> + * Return: pointer to registered platform device, or %NULL if memory alloc fails.

s/alloc/allocation/


-- 
With Best Regards,
Andy Shevchenko



