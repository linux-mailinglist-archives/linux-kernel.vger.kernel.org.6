Return-Path: <linux-kernel+bounces-559070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBEA5EF25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D8317DCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B44263F34;
	Thu, 13 Mar 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dshFhg91"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115A263F21
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856970; cv=none; b=nwWh1CbGAqxtw7cqQqbkiAKoIhnydrTyBvj5oSBQm0lmZgACxuNM3Nt4sZjehaQM9+tY0Aa54YsYLSJwG2B20hCgA7CSlefZEYt61JkaQUOfGs+GdiA1yQp4rG9LB5+8AXW5HABSLaxyOsDLD+LXX0nua5+8zpMVcsjoqyOt3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856970; c=relaxed/simple;
	bh=/aT4jDWdbe0H5Pu8MMORdbKh4I8XNsP23yL2mQme8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+VkzhtBbQy6GqsXKeq+f1eWlQba8ZgBOhs22sWXtRMQdPYL8Um42j9nikRAGGsLy5XeDwv1GMueQ8S8HLhDktmdAlw5UrECN/5W6QjvNI2hObjL2xDoiydIduAy7R3sDyCySOCLUMSvMsr4qcABER5hB1U67C8ndx/tGvAZB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dshFhg91; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856969; x=1773392969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/aT4jDWdbe0H5Pu8MMORdbKh4I8XNsP23yL2mQme8R4=;
  b=dshFhg91aaJirwBCiIGfe9aLIBsltDUj/jruKV/gA00bkRLx+KkTE8xT
   Ilr35SXxYh6NpJKaEkHwPqbrLTkpteVhWugWcDsX1MgdY1WVeeEgBK81l
   rgH54kW5VNt5RUnHyDA1CrC4zZ7P8j9I8jF1o2fs+m8zPNPHTQa16poDP
   DUL31THnnyd4e2dL3oonwSJYPKaqdW+X3EQm1tmDxSGPDG4wzPtk+eRTD
   0grKyganJLUGnDOOlphMcAxM7hqhx0d/nrdm9VsfgFi7OTpHhcOkcO6qo
   +5RPo+G0B13c4h5AlBvs1pZHlCFnarSHC2U+pNbFCTQ1IqeFMQ8j9l5NS
   Q==;
X-CSE-ConnectionGUID: PJClPRbmR8i9RYEOqfy+kg==
X-CSE-MsgGUID: YPy+dcv1RbuB4XdUxk0OHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60505170"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="60505170"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:09:28 -0700
X-CSE-ConnectionGUID: XvxnbidaTfy56Rd+EVZS8Q==
X-CSE-MsgGUID: SxWlc2/4TmCBoCJckr014w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120695199"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:09:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tseZA-000000027t4-17w1;
	Thu, 13 Mar 2025 11:09:24 +0200
Date: Thu, 13 Mar 2025 11:09:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: mtdpart: Do not supply NULL to printf()
Message-ID: <Z9KgxKocER3R1aPN@smile.fi.intel.com>
References: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
 <e6616c70-7579-6114-95b0-3c4a94f98aa0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6616c70-7579-6114-95b0-3c4a94f98aa0@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:24:21AM +0800, Zhihao Cheng wrote:
> 在 2025/3/13 4:16, Andy Shevchenko 写道:
> > Compiler is not happy about NULL being supplied as printf() parameter:
> 
> printf -> printk? The title has the same issue.
> > 
> > drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> > 
> > Replace that with "(null)" to fix compilation error.

> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thank you!

But I think my approach is a hack, the best is to move this message to the
after the follow up conditional and drop that ternary completely as we have
already another debug message before that. So, the parser == NULL can be
deducted from the appearance of the one and not the other one.

I'll send a v2.

> >   			if (!parser && !request_module("%s", *types))
> >   				parser = mtd_part_parser_get(*types);
> >   			pr_debug("%s: got parser %s\n", master->name,
> > -				parser ? parser->name : NULL);
> > +				parser ? parser->name : "(null)");
> >   			if (!parser)
> >   				continue;

(move it here)

> >   			ret = mtd_part_do_parse(parser, master, &pparts, data);

-- 
With Best Regards,
Andy Shevchenko



