Return-Path: <linux-kernel+bounces-559452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505BA5F3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A93BD806
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE293266B4C;
	Thu, 13 Mar 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hISbuJqL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5F2673B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867841; cv=none; b=ulRu0fE3jGSD21a1R41C9wHwyF3f6NGgpw1GwovxiVDXlS2sXJ8jv93KDNygFTYA0WlkJHKcG5AhtUIQRp+myfvCHiUWYz4UPtkclUZEBjqjNWhtndsGvtawHPAlw2d2KTaX/64ptkIBeb8jixdxopzLoIUOsI/hvV6bN36Rln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867841; c=relaxed/simple;
	bh=GyXIuBWGwxiTj76FQXVod3bhrQqXHfw/uGSzUCIShy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGdYi5kLOvA6hjwmO+aHW7JM6kE0ZYKw2oQ8SVtuyXHX1Tdq5bVLS05dRVgx6XpLWGCybCT9Sv3Hg0yMImR+RYmgMUzcqPixQ75l/SPayc0oxEDxNsEztLFmvTFyMg/3oIu1HOO/vhekjXfhRLk8mH0sc2Sfc7MimCdcPtZVHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hISbuJqL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741867839; x=1773403839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GyXIuBWGwxiTj76FQXVod3bhrQqXHfw/uGSzUCIShy4=;
  b=hISbuJqLzBYifT0AQZeliXf0Bkhro1hjXHpDjIDiBreGPfMGaq2p+gf/
   0xghTvjL4WpYWDbp2thaBRFQ2VASroLI9zJ5Bst/zv1bHPlqky3VqopkP
   hIKrVZQN/pkp3s3uDEv1NzmZbmm+tx4HnZTQfjloMRMLsvaFo5Tz7+0p0
   /U2DNTMuhT1snC8UeVDEuIttr6pPksdezFuS64Qve6HU2R/jyM+laFoP4
   uNGhgJt8H/PzkM7Y7/uRQco6yo93GwjS4mcyF+GgdRDhJl8+zJkR0lHTi
   Dz58xE0Br/gWRq7aS5C9eJXk7GNK2lwBeDZ+m8SndxvFJI7bJqAHetJg1
   w==;
X-CSE-ConnectionGUID: hJz/iN+GQ327m/UKC1nIdQ==
X-CSE-MsgGUID: j5VXJ6d3SK2M81LrK/QycQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53617729"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53617729"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:10:39 -0700
X-CSE-ConnectionGUID: MqQtqtljTYKZX0drLigzmg==
X-CSE-MsgGUID: pa1+gZoQTYixoBcJEPkr0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121635190"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:10:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tshOU-00000002AMK-2Kf9;
	Thu, 13 Mar 2025 14:10:34 +0200
Date: Thu, 13 Mar 2025 14:10:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: mtdpart: Do not supply NULL to printf()
Message-ID: <Z9LLOthvgonKIc6U@smile.fi.intel.com>
References: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
 <e6616c70-7579-6114-95b0-3c4a94f98aa0@huawei.com>
 <Z9KgxKocER3R1aPN@smile.fi.intel.com>
 <a5d38df2-4679-9bb9-4b01-2cfa184cd1be@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5d38df2-4679-9bb9-4b01-2cfa184cd1be@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 06:54:40PM +0800, Zhihao Cheng wrote:
> 在 2025/3/13 17:09, Andy Shevchenko 写道:
> > On Thu, Mar 13, 2025 at 09:24:21AM +0800, Zhihao Cheng wrote:
> > > 在 2025/3/13 4:16, Andy Shevchenko 写道:
> > > > Compiler is not happy about NULL being supplied as printf() parameter:
> > > 
> > > printf -> printk? The title has the same issue.
> > > > 
> > > > drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> > > > 
> > > > Replace that with "(null)" to fix compilation error.
> > 
> > > Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > 
> > Thank you!
> > 
> > But I think my approach is a hack, the best is to move this message to the
> > after the follow up conditional and drop that ternary completely as we have
> > already another debug message before that. So, the parser == NULL can be
> > deducted from the appearance of the one and not the other one.
> > 
> > I'll send a v2.
> > 
> > > >    			if (!parser && !request_module("%s", *types))
> > > >    				parser = mtd_part_parser_get(*types);
> > > >    			pr_debug("%s: got parser %s\n", master->name,
> > > > -				parser ? parser->name : NULL);
> > > > +				parser ? parser->name : "(null)");
> > > >    			if (!parser)
> > > >    				continue;
> > 
> > (move it here)
> 
> After looking through 8e2c992b59fc("mtd: mtdpart: add debug prints to
> partition parser.") and 01f9c7240a90("mtd: partitions: factor out code
> calling parser"), I think we'd better keep the debug message before the
> condition 'if (!parser)', it is used to inform us whether we get a parser
> and which name it is. And the debug message in mtd_part_do_parse informs us
> the result of the 'parser->parse_fn'.

See v2, please. From information point of view no piece would be lost.

> > > >    			ret = mtd_part_do_parse(parser, master, &pparts, data);

-- 
With Best Regards,
Andy Shevchenko



