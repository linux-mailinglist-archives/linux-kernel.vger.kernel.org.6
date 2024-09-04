Return-Path: <linux-kernel+bounces-314402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB2A96B2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C463B23BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90256146A62;
	Wed,  4 Sep 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmNo/ZVH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53379146018
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434662; cv=none; b=buxG5/kP8ULrREH+U5IcszhMBt+1ylRnJR5rTIG7vDgtTtX0g0RjImv5jtuZ3OLYq3LNwpJCnVEGYSynGHeZ1vxFGF0FLbUs6Hvdm3NyfqxXgt45iYIM+W5E47f5V4eZ+pS3Zqpp2gFU9XWIx7jtqO2l6erEjr9AAfYz40H2gBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434662; c=relaxed/simple;
	bh=Dz6GawJBeEhbU4qgcKqn0e28Bz9wtatHn8pfUsGOP1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzveFCUpqy9GR1ukSy7FTcChb8HuG3WMtTFRTPRUy6dQqarQPH+P/JNzco+M0jQD3z8KIopQs3AOL3+4ZknTK7zEJguQshSThEDrwQX+D1/try6nV079IRZd3OkFFCbUg3FOouH46d4Niat7SqQvhFiVVIjoleoFSzPGGwJzJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmNo/ZVH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725434661; x=1756970661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dz6GawJBeEhbU4qgcKqn0e28Bz9wtatHn8pfUsGOP1M=;
  b=XmNo/ZVHt1sUR2mYbID8GgJmU0UPUnTxxSo336VrApCrgK8gE0TSMW+f
   fWngvrt/gS9iXMv1RpmBY+E5Mz3WnTY8VpTxl482FVr7wN3YHdqc96O4m
   zU5mXXvAJa2qTpf3iOiGe9sT4/Je10biB1xKvEFhagEOZzMLdXJ2F2tsW
   66s6u5woUWWV58r5LYuUxDsqx6Ep09wck8izKwaS+WEQYQSp/R49NUL7N
   66EGR7glDdeev87IIjgIGPduCvUu0OVX/JnCAyWHuyS2jXsiGEaTZsLu1
   EQYkyDHhkVMVlWn52nhaAxwWwlmAq72Kk4n7mY20W4batYXsf9un2TxjR
   Q==;
X-CSE-ConnectionGUID: fNlDvasWQF6EeDjulPXXEg==
X-CSE-MsgGUID: P9E07ASHRAqoVAGFRq3h0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23585957"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23585957"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:24:20 -0700
X-CSE-ConnectionGUID: 4QL/Hr+HQG6MjDIn1eQ7XQ==
X-CSE-MsgGUID: btexMqbPQwOgtJE85Qkoeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65240664"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:24:20 -0700
Date: Wed, 4 Sep 2024 00:30:07 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Andreas Herrmann <aherrmann@suse.de>
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
Subject: Re: [PATCH v5 4/4] x86/cacheinfo: Clean out init_cache_level()
Message-ID: <20240904073007.GA3840@ranerica-svr.sc.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
 <20240901180911.GD4089@alberich>
 <20240902074140.GA4179@alberich>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902074140.GA4179@alberich>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Sep 02, 2024 at 09:41:40AM +0200, Andreas Herrmann wrote:
> On Sun, Sep 01, 2024 at 08:09:13PM +0200, Andreas Herrmann wrote:
> > On Mon, Aug 26, 2024 at 10:16:35PM -0700, Ricardo Neri wrote:
> > > init_cache_level() no longer has a purpose on x86. It no longer needs to
> > > set num_leaves, and it never had to set num_levels, which was unnecessary
> > > on x86.
> > > 
> > > Replace it with "return 0" simply to override the weak function, which
> > > would return an error.
> > > 
> > > Reviewed-by: Len Brown <len.brown@intel.com>
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > 
> > Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> > Tested-by: Andreas Herrmann <aherrmann@suse.de>
> > 
> > Test was done with a system equipped with AMD Phenom II X6 1055T and
> > test kernels based on v6.11-rc5-176-g20371ba12063.
> 
> FYI, the test consisted of booting the mainline kernel w/o and w/ your
> patches, checking for potential new errors/warnings in kernel log and
> checking for changes or incosistencies in information of cache
> characteristics as reported in sysfs, and by some tools (lscpu,
> lstopo, x86info) -- e.g. x86info does not use sysfs to gather cache
> information for CPUs.

Thank you very much for you review and testing!

I will post a new version with the feedback from Nikolay and Sudeep and
your tags.

BR,
Ricardo

