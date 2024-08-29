Return-Path: <linux-kernel+bounces-306115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0D96396E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C6C1F23612
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C0139CEE;
	Thu, 29 Aug 2024 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJPqSPC+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FB647
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905892; cv=none; b=Vddid6jy8Uk8Gm5qb8UTDt4+cGbDf7mql6GdfM2+egfKqrUgmqxSuzcrmUYl42jAFQku6EHhdje3y4JqeuqpK/cCxPni/RD3BXUCg4qdtFa4+ItvSwrK4fdiV/Su6C6LDcZlSH5q9bAzVpCaest38Da9OgXfGGseBcba2bJ9yfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905892; c=relaxed/simple;
	bh=BWeXZcdyskPtRX6fUsJdUUI66xAicNiMFMIsnyYaFjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0saF7EQJa9uPeW2/aRMyiMMoN+Mzm3dW7/p5UFd5Y0GYVNX1KYq1yiQGDet9bnU545iGXa7lbJwwN4kHzP6tUUESBGOIy3pcFv9JJZFJk5Rdvhj+fnKENR0+XpuK+CIQe+yz89fbokcx6sIQ2zK95QcMJ/IFXKYAp/VJuSRSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJPqSPC+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724905891; x=1756441891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BWeXZcdyskPtRX6fUsJdUUI66xAicNiMFMIsnyYaFjM=;
  b=SJPqSPC+l+f7dbOLlIyvz3+AtRz/S3mqRu9OTK+c7C3BZ6JbmaGTWzMu
   YuGnYWpGzFrivM6uRsdJDiZVZNB7eDnSyv0OJGDSNTQkm8lYZ/kPbsYX2
   ALpbUFgdoYAjuhS/npjzUpU5lBfz5ILSl91IhzWyXrZXf2/7pJgzuOuie
   /oVpNv+a4s0tRKEjDRV2TooNUSMagTmrBJuoJ4GyS+NG3WG7Ff8Ah6GbN
   k4bYUf5GeCEQY/FdHoLK+UoGwU3xu4Uv3U+/XeySvF1WQZEwS34XJy53P
   xstrwqjqJ5fuRs4hP7+Gr71Hdh3BJ95HbwH2LFizzbMLKYtBJi5KZZr8v
   w==;
X-CSE-ConnectionGUID: VgQYDuhYTcK9YZ2Wf8HX2g==
X-CSE-MsgGUID: TnSqc9aCTrGUAl1oA6NLzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="45990439"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="45990439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:31:30 -0700
X-CSE-ConnectionGUID: tL4reAndQDesjsQ3ijQoCg==
X-CSE-MsgGUID: bnqqWW1bR6eTemk+bMo4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="100964160"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:31:29 -0700
Date: Wed, 28 Aug 2024 21:37:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
	Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
Message-ID: <20240829043719.GB4229@ranerica-svr.sc.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
 <c613d2d5-cb7b-40fe-b322-45ddb43c6382@suse.com>
 <Zs8svzZPTUmF7NP0@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zs8svzZPTUmF7NP0@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 28, 2024 at 02:57:19PM +0100, Sudeep Holla wrote:
> On Wed, Aug 28, 2024 at 04:16:00PM +0300, Nikolay Borisov wrote:
> > 
> > On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> > > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > > adds functionality that architectures can use to optionally allocate and
> > > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > > arch specific early level initializer") lets secondary CPUs correct (and
> > > reallocate memory) cacheinfo data if needed.
> > > 
> > > If the early build functionality is not used and cacheinfo does not need
> > > correction, memory for cacheinfo is never allocated. x86 does not use the
> > > early build functionality. Consequently, during the cacheinfo CPU hotplug
> > > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > > pointer:
> > > 
> > >       BUG: kernel NULL pointer dereference, address: 0000000000000100
> > >       #PF: supervisor read access in kernel mode
> > >       #PF: error_code(0x0000) - not present page
> > >       PGD 0 P4D 0
> > >       Oops: 0000 [#1] PREEPMT SMP NOPTI
> > >       CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> > >       RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> > > 
> > > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> > > not done earlier.
> > 
> > I assume instead of duplicating "memory" in the subject you meant
> > "cacheinfo" ?
> >
> 
> Good point, +1 for the $subject change. I clearly missed to notice that.

Ah! Yes, it should read cacheinfo: Allocate memory for cacheinfo if not done from the primary CPU.

Thanks for spotting the error. I will update the subject in the next version.

Thanks and BR,
Ricardo

