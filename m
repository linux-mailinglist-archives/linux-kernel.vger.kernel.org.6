Return-Path: <linux-kernel+bounces-402657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD69C2A27
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45469B2179D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16212DD95;
	Sat,  9 Nov 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilvezxgd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154FA55
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128353; cv=none; b=A1VwgiVAbqOZvi5twlmNdk8FnvWRYd87RTHLiKaVM+IB9Q+0PJ0rTgoPz8vu8aozbMDBmndsxunlgtb2x3QqcW2p6F3u/5AGR758gwmtxpWpO/H5hoitLRXg0eENGK9KyDcfYFVUYKlXt8I2Viob1UBA0ngwCgU8c4/oMZmVP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128353; c=relaxed/simple;
	bh=kzK2jE0HKYuaD7CRPhr1fZGjcx3HToiKewwEiYmcfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz0F8QWEBwqwC6PgeNKXJ0Krn9TX6Vohg1oUYaw53RO9ZJAIn0yI/3z54sJksTpfveMLF+JQsEwyjgg85DFGg5T0Y/uDxiNUohsXsJ+Z4rroxHnxf9rzVD18tyzHzISeksCKAAcxFldQqcw30DfJnvmKx2RpYo8uhMbT+eE9PyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilvezxgd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731128352; x=1762664352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzK2jE0HKYuaD7CRPhr1fZGjcx3HToiKewwEiYmcfac=;
  b=ilvezxgd/x/GshfrLV2nnMw5CGZ2e3Emq0ZrpKfK+C6AJaXeSGvXo/V+
   9UM7KegymDOnsvkdAYaPFdbGCrQwcqiibTpgFfmWJEgFw0YU/p8vV0iOn
   6GvjOfTu6MvEtN+xvQSPgdjrhKvKLYPqvZROHvC/64sfgM+xdGiPty6kg
   AzMODSADykJrIHypXbKAINmKTgrIEX+lCVY34sw3RcmNUduHqXiTOvoyq
   LIv6+dkpKOchxotw9yKX4iuOFwIC2ZI62KzR/kmO9+tw4mhXzLvo7n9+x
   f5Hisj7FzMVpollyd3szDSafvGSdpXElQ0j3A2ZE2jAViqd842LD4TS2z
   g==;
X-CSE-ConnectionGUID: Pu+Wz7X0T5CyX7f0Obz0xg==
X-CSE-MsgGUID: 0sf1SgOzSPyQVjCQ85prlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="42401039"
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="42401039"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 20:59:11 -0800
X-CSE-ConnectionGUID: Pw+2fAUwQse62+p9HyjKYw==
X-CSE-MsgGUID: S6K9YXcCTSCUpxpDH/y7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="109190814"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 20:59:11 -0800
Date: Fri, 8 Nov 2024 21:05:50 -0800
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
Subject: Re: [PATCH v7 2/3] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241109050550.GA15450@ranerica-svr.sc.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>
 <20241022132050.GHZxemsmJSLg8Q_7U7@fat_crate.local>
 <20241023035022.GA2484@ranerica-svr.sc.intel.com>
 <20241108115825.GAZy384e9IEr7DWvaJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108115825.GAZy384e9IEr7DWvaJ@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Nov 08, 2024 at 12:58:25PM +0100, Borislav Petkov wrote:
> On Tue, Oct 22, 2024 at 08:50:22PM -0700, Ricardo Neri wrote:
> > I agree. Another wrapper is not needed. I did not use cache_leaves() because
> > it was internal to drivers/base/cacheinfo.c I can convert it to a function
> > and expose it in include/linux/cacheinfo.h. I can rename it as
> > get_cacheinfo_leaves(unsigned int cpu).
> > 
> > Would that make sense?
> 
> I think you should use get_cpu_cacheinfo() everywhere and simply access the
> struct members like ->num_leaves where you need it. No need for a bunch of
> other silly one-liners.

Sure, I can do this.

> 
> > The only caller of init_cache_level() also checks for !cache_leaves(cpu). I
> > saw no need to repeat the check here.
> > 
> > Also, I understand that the purpose of the function is to initialize
> > cpu_cacheinfo::num_levels, which is not used on x86. Moreover,
> > cpu_cacheinfo::num_levels do not depend on num_leaves.
> > 
> > Having said that, I see other architectures initializing both num_levels
> > and num_leaves in this function.
> > 
> > Adding this check probably makes the x86 implementation more future-proof
> > in case callers change their behavior.
> 
> But you're practically zapping its body in the next patch. So why does patch
> 3 even exist as a separate patch instead of being part of patch 2?

Because patch 2 deals with cpu_cacheinfo::num_leaves whereas patch 3 deals
with cpu_cacheinfo:::num_levels.

I think I see your point: it can be argued that both patches deal with
init_cache_level(). I can merge these two patches together.

Thanks and BR,
Ricardo

