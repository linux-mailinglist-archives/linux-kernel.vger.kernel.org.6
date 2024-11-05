Return-Path: <linux-kernel+bounces-396627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143939BCFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A411B21FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76451D47AF;
	Tue,  5 Nov 2024 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foZUO75B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A22EAD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818373; cv=none; b=b4OxT7Kyxy0GGa1npaSR1QA5AFi6l1/jE4Wwqc+SheCO5jeFas5TOhyEDoa478aWOR+uXrSjaprEe/o2FpxKpLQ+uGUsAwI7TxdZ4RLjUAifpHkqJNJ4VWuL3z6jqSlopOq2vLt++33g6dtbX5mJZ44EdlBV8iyS2rRK3nLCNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818373; c=relaxed/simple;
	bh=oS1UtJRkGgWYSIVrgu3Zwnqs1nX1BOqO/RVxvfwpDj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG6EJPbTwqUEJ2crvbwXyTt36dvkpTOYiiGVUFis1WV0kJ9UITmHlZqaVlP6nVSEVzdh4gLt4nF0S/RyaMWZ7JwsNbmI8Omvfv+25USx6JPxR9SU8oql8WGkJ7uKdqUsyMyP/Ze7zvW1MrnfgrNla/VYY0w0Gdr/y9+PsgoSvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foZUO75B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730818372; x=1762354372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oS1UtJRkGgWYSIVrgu3Zwnqs1nX1BOqO/RVxvfwpDj4=;
  b=foZUO75BrByftqFIMGCHqvEjQQpkT+NPpcUfgBKum2BCQHBWCvo+mtad
   eYaEuUscF+M1opIp2Q7ku+GakuI+0QCVbyNoAsavVLCLyEZQEI6TaZ61u
   vnWCKYvM/hKpK98ChukGOGvfTx/aztuulb3bynuesQTv2BZyuV8BzYBTd
   pFtep/4z5+FjLaIAmfyFV4RVO7PkxpbBbcZEUUAIZrSZALOYZUvu92tdj
   pAvvXdJszAz7wb7kD6uMvu8E6wmPoPulyImy17lEh6RMWwkGxiSBZM8qN
   O8voPXRT7jUUg/Bwt7GsSCXcgCrEFc9Ts7hU9dp5EMfk1eiE8B0cOWPad
   Q==;
X-CSE-ConnectionGUID: WQ+9kZKfSeuLnB9QuNz2Gg==
X-CSE-MsgGUID: eJbo9WVCQDaVf/vwNo71pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34502063"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34502063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:52:51 -0800
X-CSE-ConnectionGUID: VxKT+gv+RDOu/cFglGsvwA==
X-CSE-MsgGUID: fKL7wu0BQVmUsUl53XABrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88847401"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:52:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8KvF-0000000BRCT-2IdK;
	Tue, 05 Nov 2024 16:52:45 +0200
Date: Tue, 5 Nov 2024 16:52:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/intel-mid: Replace deprecated PCI functions
Message-ID: <ZyoxPQPupkorXPoa@smile.fi.intel.com>
References: <20241105112521.58638-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105112521.58638-2-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 05, 2024 at 12:25:22PM +0100, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
> respectively.
> 
> Replace these functions with pcim_iomap_region().
> 
> Additionally, pass the actual driver name to pcim_iomap_region()
> instead of the previous pci_name(), since the 'name' parameter should
> always reflect which driver owns a region.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> -	if (ret) {
> -		dev_err(&pdev->dev, "I/O memory remapping failed\n");

Btw, do we have a similar message to be printed inside the new call?

> -		return ret;
> -	}

...

> +	pwr->regs = pcim_iomap_region(pdev, 0, "intel_mid_pwr");
> +	if (IS_ERR(pwr->regs))
> +		return PTR_ERR(pwr->regs);

-- 
With Best Regards,
Andy Shevchenko



