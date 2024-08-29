Return-Path: <linux-kernel+bounces-306116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5CA96396F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA88285DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64B54652;
	Thu, 29 Aug 2024 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkUTaJma"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13940487B0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905978; cv=none; b=GcqCnFmK5IsRcrB7p18ZktN2cb7qBN/OrCjD2S0E5Ysc3sT0c2q/YBNKv5r0kgAA9lk++t7715/+1T+r16g89iRG3ESjYJ5Nu5iVnL7+g4oiyPMbk/M5HOEqJdZ4Rr68mRO3q9lDlWKVGI0guCOCMFXL/DoNwztK5WDtM3GOFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905978; c=relaxed/simple;
	bh=K4JmfXolqxQ4+xNueQ+uyQ2Fo8kZb0EdXkaNAnCE+yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhTwTQYZtZHv4dj6GKFj4w8JLXH5s50KBkbdC7Qc0GnCWZ9ZHTB8lH847pV08e8Uusf7GYyrqwNjzUX/SG0JJpn+0skx46AtpBUNuViA7p1V4ZWXi9UKljS1e1jKTRIfQGbd2nlvtOHWUTUOGzGxUw1Zvb6STK3vTRPSvZBuWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkUTaJma; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724905977; x=1756441977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K4JmfXolqxQ4+xNueQ+uyQ2Fo8kZb0EdXkaNAnCE+yo=;
  b=IkUTaJmajlT7fNcSC2Yj7Azu1C8gRlRj18ZGaDhN4Hz8U13O6zXm/PPn
   Uqx1vFy/WqlK0+D/cK3JfrgAGBn2nzPw22+Pmd5pBOglN7t15sdj9jxYN
   vy+W/7YbfnSpfJuFGa6YZ8m1BmMlpm+MGiZLALssVTdMMzps+1dJXSElS
   WF9tYR/B8Xu3s61ZZp/o1PMhLT+vvdab7jeO4qxWbnOhvaZqMGjJnmDhI
   k3z2webFI5felOuCPqnvSXSvj9IibEqoekcS9/sLNdHUchwIg2C3mne14
   QIH8w18kxpu54CLmChmy4jw2WfdgE5VOe2WwDn7T2nvMn/Mgc9KhknQ6s
   w==;
X-CSE-ConnectionGUID: sPHDb99wQcSmmj3kNKaLww==
X-CSE-MsgGUID: /ux6/3EvS1yKOaQpZq4jEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23050658"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23050658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:32:56 -0700
X-CSE-ConnectionGUID: 4+8UYnRORcGhzkrqWa/bTA==
X-CSE-MsgGUID: VvLymoyqRkKrSU71kJ4LdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63393614"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 21:32:56 -0700
Date: Wed, 28 Aug 2024 21:38:46 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/cacheinfo: Clean out init_cache_level()
Message-ID: <20240829043846.GC4229@ranerica-svr.sc.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-5-ricardo.neri-calderon@linux.intel.com>
 <135b7be6-b31a-4104-abd2-986114323745@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135b7be6-b31a-4104-abd2-986114323745@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 28, 2024 at 05:01:38PM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> > init_cache_level() no longer has a purpose on x86. It no longer needs to
> > set num_leaves, and it never had to set num_levels, which was unnecessary
> > on x86.
> > 
> > Replace it with "return 0" simply to override the weak function, which
> > would return an error.
> > 
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thank you!

