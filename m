Return-Path: <linux-kernel+bounces-426752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 576419DF749
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C889BB217DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D81D90B6;
	Sun,  1 Dec 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zj2B7J5P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F21D86F1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092483; cv=none; b=WVpOaGNKEedv6CRtc+XlLquUK6TyC8iSOh/f1zOJS7uNhanRS8Png8m1b7gU439crN2TIDjHOoRdLY9PXnhD2yBGCa3gbZvNHVUsCF+sRqrWHCfX/f1FPRkf4AdMMyD0ZTjw+nh93WdPlOXtQSk5Ur6WKEZn5Z+yNk5aAHhdLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092483; c=relaxed/simple;
	bh=IFwmBVbzBRqg2ywzgY5eNOxdl5gMnb7JrJRyq21REnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1cAdwgsz6KY04XnWyOgpgZ8kK0jQfJI5/y0hd4UtyPMwhNx3sRP1y0oB3EXNZyv0JehIrB+nnKIkjDhcpQmnVM7MwXxPbDp5pcOQ0/zleEDnPpTarjXxW4n0lH9SM9UsNU33A7NtmBL9p2yslyumc0XCMrqm/uoKfgv9QStEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zj2B7J5P; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733092482; x=1764628482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFwmBVbzBRqg2ywzgY5eNOxdl5gMnb7JrJRyq21REnU=;
  b=Zj2B7J5PkH/waeB5QJmbhAGs9o10ifV3Xhp1JabMwCeV1uFxRPFtmaRk
   2aMSJnciTOfiqiXCacvhb2HuUD0q7OOz54U329itpX1dIgwuewLmtBJug
   Duluv10g5u3P9Ojg035W6+8lLGB8phTRRFoLjZv4EEHHFZ4QOSYiK+57Q
   Twif4UngYolMUrRsg9TaUb79rS1HEBMHvKyVNh8RyoPjyTU/lIdVtJqJF
   +Q5SUsep4k1sBB3hwk4pVY/h5f0y5CyRe3jZoSn89le549axyeXSeaIfR
   ApK54JlgCCCs7crwn8UrpLwimfK4BkAeRBtpd3lxJuLRkyTzMJOlQpj6z
   w==;
X-CSE-ConnectionGUID: Dyd6Yn5vTrGkrWpWqE4eiA==
X-CSE-MsgGUID: 2+YmHm2CQEW8Zi+JTKcSpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="36114391"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="36114391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 14:34:41 -0800
X-CSE-ConnectionGUID: jFh4aLx3SJClRebzmgj1LQ==
X-CSE-MsgGUID: E5m3nIRVQPyOFQmEuT90TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93775723"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 14:34:42 -0800
Date: Sun, 1 Dec 2024 14:41:26 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20241201224126.GB32487@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <1C6C4601-9478-4020-B4A7-47017E9A57F2@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C6C4601-9478-4020-B4A7-47017E9A57F2@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Nov 28, 2024 at 10:30:46AM +0100, Borislav Petkov wrote:
> On November 28, 2024 1:22:45 AM GMT+01:00, Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> >Changes since v7:
> > * Merged patches 2/3 into one. (Borislav)
> > * Dropped wrapper functions for ci_cpu_cacheinfo. (Borislav)
> > * Check for zero cache leaves in init_cache_level() for x86.
> >   (Borislav)
> > * Removed an ugly line break. (Borislav)
> >
> >Changes since v6:
> >  * Merged patches 1 and 2 into one. (Borislav)
> >  * Fixed an formatting issue in allocate_cache_info(). (Borislav)
> 
> I don't think you should keep the tags after those changes...


OK. Should I post a v9 without the tags? Perhaps I could wait a few days
in case reviewers and testers want to chime in.

