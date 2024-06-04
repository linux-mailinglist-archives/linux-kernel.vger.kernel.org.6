Return-Path: <linux-kernel+bounces-201411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC918FBE22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F81C286751
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56D14B977;
	Tue,  4 Jun 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2qf6uQv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AB84E1C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537119; cv=none; b=QWVF3qqqiZwoj4AIUfrL1lfAp40BjMByRkO2LXPhRoE1ZeSjTd3CtIALvqhiDMIDTtJxgO/0KBVpext57Z+XN4tE7KvuIPqerB4aHDB0NV/n7X/o90PqhLSRLURT1SLnGBZiTep56EPR4VduyIGgWq9YmEMe8pMZbnN5ypAAz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537119; c=relaxed/simple;
	bh=96F07kfBenUy8WriVf3SkvLFWZePh996qzWpyKNaZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee/NbEWGyBPK7seQQz5wfyB5R4ekQIsB4IcBDCm2B36hyPU6vTXQmjoLISgYQhOc7AQFNrpaXAn34pC4yKJLDIg3J1IvuEWABr3QXbx6z2QlxO1txS0AKtIMnOecbigUDTXJISFdYweoESI3EsCpTtfKEQ0yv39Pm3z34qPl+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2qf6uQv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717537118; x=1749073118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=96F07kfBenUy8WriVf3SkvLFWZePh996qzWpyKNaZcE=;
  b=M2qf6uQvXdqyEpgNskLLT/UswqnnPClLWm8GDNkXzrTIrXpX4RX9p9Rm
   xd4h9enSYnSb2zTrAF+XeWsqOi75XE3z4nNSyqQJXDRr7nDXRNfk5kuZi
   G72ijTytFPUWBRMWtJGVPVPp2dARlLWpKa66mIyvQDGNswg8QLfG+FbMs
   VHAD80Wn6LaR1HeWrm7sEiymFeJeFRK+tM+O4cKi95xR2z5UYqa58h/CI
   50j+dAHntPWSKpmlqYlv0kOhKlPoZ6e9k0hqs7vKqRO77EQ9LnxYLAcaR
   chAW7SVyONwCPVPuGP65BRvn8QlSghJyof39CkuWoXzcQw0FLzpHJefX+
   Q==;
X-CSE-ConnectionGUID: cwEIrgq7R9umfamqwGQybA==
X-CSE-MsgGUID: LylMOkilTROa7J9Zl6gx+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31653894"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="31653894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:38:37 -0700
X-CSE-ConnectionGUID: KMocsjVCR4Wae0uDsVfAUw==
X-CSE-MsgGUID: Ni7C9kpKSQ+Q3OHTUJkssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="60563426"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:38:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEbrP-0000000DfcA-0jPP;
	Wed, 05 Jun 2024 00:38:27 +0300
Date: Wed, 5 Jun 2024 00:38:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resource: add a basic test for walk_iomem_res_desc
Message-ID: <Zl-JUkLoxqraKciw@smile.fi.intel.com>
References: <20240604213200.672279-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604213200.672279-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 02:31:46PM -0700, Chia-I Wu wrote:
> This mainly tests that find_next_iomem_res() does not miss resources.

In the Subject:  walk_iomem_res_desc()

> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

...

> +	res[2] = (struct resource){
> +		.start = offset,
> +		.end = offset + SZ_1K - 1,
> +		.name = "NESTED",
> +	};

We have respective macros. Use them.

-- 
With Best Regards,
Andy Shevchenko



