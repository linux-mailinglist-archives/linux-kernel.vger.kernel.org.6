Return-Path: <linux-kernel+bounces-355802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCFE995755
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B651F25BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141D20CCE3;
	Tue,  8 Oct 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibvgLOia"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D818C922
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414137; cv=none; b=g9gbI8vq6HWqgDG8A1XCxW0wHpQRtRyh24CAz4JT31PshDPn45Z91vT6FE4ADZSETw+C+7fiI2KIx3515C/sIGDfMzgOWgWVRFWuuTSWuTHyYet8MD7XCwrWRrICJ9mD9okHrp4eC3nDa5/jCp3mjDZ1VqI9x5yeiMkY9qObTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414137; c=relaxed/simple;
	bh=z55YpffX5Tf6wcva47un+XD+Yzzzx4nIpTFTXYlk3ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJwqnWjHt7Ca0UJ9VTGo2rpFs7Mn3WO8yWwNaHxxSXHUHZHI1WRzRfx2kRLd+gSBaLksbhuqAh5osnKJ4xtiERIOzvkBBcWo9UyQydSSqxeQj0Rtxel4dB3/4XQMNtEd0wXRPpVm7TWXSyWueQ7MudvlCy2toyyAT8obBwJbJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibvgLOia; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414136; x=1759950136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z55YpffX5Tf6wcva47un+XD+Yzzzx4nIpTFTXYlk3ys=;
  b=ibvgLOiaRNTC5hLoLlXyrV00CIoQBxu//wdNimWx6Ovsf5QbpTANQfu5
   IrIW2J1H0OvBdnXVNR2MO4WyLg1meYGaYaNYlFY2UUw9LAqDdTtWRCZ4N
   PpEFdEAQzUqIaazPBUIPSyE947pXqrvsTPXOtkpHCMqU8V+dADRTNZmrq
   4VvmLPhFQ3iwXY0yMV5bh7v9F5pE+d1xaP3wyLt+L8woDnnd/fZwDQXt/
   zwqZpbDjTEbucioVjGWvALy89FgnMl19tKoGEqB6DbTnQGfLKCiUfBIPL
   hZNNP4k6EF25Yit9i0Y7KfVnU5Hs5NFgEG15gjV/ost/sarpbcJmLeVSH
   g==;
X-CSE-ConnectionGUID: s2xTyVl7QFmauXviW0Jqmw==
X-CSE-MsgGUID: LhPoBg44SRaDJH7/P3IUYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45115183"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="45115183"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:02:15 -0700
X-CSE-ConnectionGUID: ZsseQqHsRt2aoEJx4mwPKA==
X-CSE-MsgGUID: S1hM/MfeTqqd2nuJ8kEeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80735778"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:02:15 -0700
Date: Tue, 8 Oct 2024 12:08:03 -0700
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
Subject: Re: [PATCH v7 1/3] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241008190803.GB24312@ranerica-svr.sc.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>
 <20241008155106.GMZwVU6gjw45z2gn8x@fat_crate.local>
 <20241008170015.GA24312@ranerica-svr.sc.intel.com>
 <20241008184145.GGZwV86Y_BJEdADyCa@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008184145.GGZwV86Y_BJEdADyCa@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Oct 08, 2024 at 08:41:45PM +0200, Borislav Petkov wrote:
> On Tue, Oct 08, 2024 at 10:00:15AM -0700, Ricardo Neri wrote:
> > IMHO, this patchset is needed in stable kernel because
> > /sys/devices/system/cpu cpu0/cache would be broken on Meteor Lake and
> > processors like it.
> 
> Is Meteor Lake and processors like it an already released product?

Yes, Meteor Lake was released in December 2023. It can be found in various
laptops.


