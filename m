Return-Path: <linux-kernel+bounces-528750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EBA41BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE18A171013
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F28460;
	Mon, 24 Feb 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYidwaXZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAF146D59
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394795; cv=none; b=V8+5L34l+McCMxKSWbOIF10Qec0JWNNieBFYTOkbK5HZzhdUYJhRqaw0dYE3LPl6wK87GJCNPnprnvvWgJ61cwIbp5ez7CBn92nqf6cdwJac6Q+djNj3nfSmKK/CzUt2B9w29eDnae3gd3sE6dg8F7mn17llKnII6llQq7mEoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394795; c=relaxed/simple;
	bh=2VAPN/YFIe72X7+c5zYKU5APQ15E0BUAbd602TiZYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJElEhH9CYNBJrdLztQntksQ+Y6UtVRo6d0/CekKOTkAsZA2zloj+9xD5rBDcKqCJbiEuduepL4RX4vqpTslxP0d77eWPP6OUoN9rnzmouh2l3qldMfuZNs4P+3Vr2w91yZTLU+im6t8/Vw9UFNGNOkhON8Vn/qwGeGt1sIOM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYidwaXZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740394794; x=1771930794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VAPN/YFIe72X7+c5zYKU5APQ15E0BUAbd602TiZYLM=;
  b=IYidwaXZgd5Dou0MZiFvJIYeI/deNlk2o0ga2jWs+oh3e+7H+qvUkYgj
   Ndt7Xgi830OVwidWpYQrtxTnZ6NslpDuz9XtuyGS0jSDASntECok/iMBW
   GZ90zYm1DsYGrmZYsKWWxJCOB1R8a8986PWjnlr+97ZSg8LQ1LBYAX9vN
   SLZd3GjmdVk/2bFdvA6yN2GLZPCvHqyjnjovRzpe3OuJX/Pmw0/Wve84W
   5EUvgZ5zq+PucuWfcTr5gEdHFg74yWRY8u835145rGKSBj5niy9OMO22s
   Rrgl7Jk3nK5fDSr2X3BC8zIXXONHEQsi2KEquqIdQeXTM5NKxgsY88aGx
   g==;
X-CSE-ConnectionGUID: mSS/6X5USF6Ww6XNFbmjtA==
X-CSE-MsgGUID: UCDEhLR1Rx+LmL/+9EFM3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44795211"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44795211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:59:53 -0800
X-CSE-ConnectionGUID: 8H+5arURRgypSvOy7xSQEg==
X-CSE-MsgGUID: Ztv91BT8SdutOovpI2GjCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121295256"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:59:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmWBh-0000000EfoG-19CF;
	Mon, 24 Feb 2025 12:59:49 +0200
Date: Mon, 24 Feb 2025 12:59:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: sre@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH v3] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
Message-ID: <Z7xRJbUVEcbWnCgO@smile.fi.intel.com>
References: <20240918120749.1730-1-kxwang23@m.fudan.edu.cn>
 <88CA06F7CB097DC8+6c5e0521.3de0.19535fad611.Coremail.kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88CA06F7CB097DC8+6c5e0521.3de0.19535fad611.Coremail.kxwang23@m.fudan.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 11:23:06AM +0800, Kaixin Wang wrote:
> At 2024-09-18 20:07:50, "Kaixin Wang" <kxwang23@m.fudan.edu.cn> wrote:

> >In the ssi_protocol_probe() function, &ssi->work is bound with
> >ssip_xmit_work(), In ssip_pn_setup(), the ssip_pn_xmit() function
> >within the ssip_pn_ops structure is capable of starting the
> >work.
> >
> >If we remove the module which will call ssi_protocol_remove()
> >to make a cleanup, it will free ssi through kfree(ssi),
> >while the work mentioned above will be used. The sequence
> >of operations that may lead to a UAF bug is as follows:
> >
> >CPU0                                    CPU1
> >
> >                        | ssip_xmit_work
> >ssi_protocol_remove     |
> >kfree(ssi);             |
> >                        | struct hsi_client *cl = ssi->cl;
> >                        | // use ssi
> >
> >Fix it by ensuring that the work is canceled before proceeding
> >with the cleanup in ssi_protocol_remove().

...

> Hi, I noticed that there are no relevant replies to this patch that I sent
> several months ago. Is it missed?

Seems like fell into cracks...

-- 
With Best Regards,
Andy Shevchenko



