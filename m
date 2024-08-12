Return-Path: <linux-kernel+bounces-282995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545094EBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5781F2246A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0851741FA;
	Mon, 12 Aug 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW9gQ9Ks"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA1166F2D;
	Mon, 12 Aug 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461415; cv=none; b=DcUNK3vnyX1ELqOZYUMF2l/PRf8y7QBhKUwLJlPp1or/tG0h+k1+BCB8s+EmA5regAD6aA75crwDEGdruXzl+s1xiYyh/JZsShBts3CyETZaEnmFw+G+8Yv/8t5aBypaLknA0jKd3pAhcTfCoM9ZFLLWBw+yFzH4GB1hmGDnKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461415; c=relaxed/simple;
	bh=7YxXuZF6kvLDCv2XMBaLGRznts0EST5DjEdKKHbhj7E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=maYM3r2rAMUtEC7l+V8D2/dTPEKrsP4/etklCke48z8r+Op6TYzgx5IuzaRs/usSuU+UKlHEVwY4WMOSsinLepzZSNeMygJ/QUlUNPyMOE0dX23RCzWOM7MmoKfkJD7SrS50RWTy+1jhFeQWAclTF7s6ULEIqlhshgAwNhONhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW9gQ9Ks; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723461414; x=1754997414;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7YxXuZF6kvLDCv2XMBaLGRznts0EST5DjEdKKHbhj7E=;
  b=bW9gQ9KsJGTTq7DYI9SIl6Dbr0kYJwQjAXFT71aEUdD6tofAJWyRNSQM
   DgJV5PIvptyLOnBYwPcp034xHKxv8MUTyMZlwVW31xj1iGyPaVe9szWJF
   CiGCespgdirLbEebpqrhehV2dxVApWHluRDH7xA528XGss9e1hbjrYYmI
   L/0xa+014WZpUE4BmP7x6ZbV6BnkTzvMkBDYMt/EGojr62FYk/kM+qb8J
   +YswbumtzKhJXYsDYC9IXVkKcTXXDYlvEBmBSl8C91m6rGGgAbOtxuVG4
   rFM01oQMENclRBksSDbVWNt5vW1aYIdwyZZjJ4DG9LCK9GYw6p4VdqBcb
   g==;
X-CSE-ConnectionGUID: 1aL89uJeSaCP6xcjsGwO3g==
X-CSE-MsgGUID: OpOm1jlPQAakDRW/ZH4yTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21694692"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21694692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 04:16:53 -0700
X-CSE-ConnectionGUID: +VjV+JLuSWu8xLgHEwfIqw==
X-CSE-MsgGUID: BN3ZDA6+T1mLrO6xwE5sDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="95747911"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 04:16:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 14:16:46 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Do not present separate
 package-die domain
In-Reply-To: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <cd7cc6b8-4993-937b-072b-8fbc1e309a4d@linux.intel.com>
References: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jul 2024, Srinivas Pandruvada wrote:

> The scope of uncore control is per power domain in a package and die.
> A package-die can have multiple power domains on some processors. In this
> case package-die domain (root domain) aggregates all information from
> power domains in it.
> 
> On some processors, CPUID enumerates the die number same as power domain
> ID. In this case there is one to one relationship between package-die and
> power domain ID. There is no use of aggregating information from all
> power domain IDs as the information will be duplicate and confusing. In
> this case do not create separate package-die domain.

Hi Srinivas,

I got confused by this changelog because its order is quite illogical.

First paragraph talks about case A. When you say "all information" 
is "aggregated", I immediately make the assumption that the aggregated 
information is what is wanted because, well, you normally want "all 
information" and nothing else is being told here.

Second paragraph starts to talk about case B and then suddenly switches to 
talk what should have been done in case A (that aggregated information is 
useless/confusing).

So I think some reorganization of the sentences would be useful to not 
jump between cases mid-paragraph without any hints.

(I hope my explanation is enough to highlight why it was hard to follow).

When I finally understood what the changelog was saying, I found out the 
code change is fine too but it first looked like it was doing exactly the 
opposite to my expectations/reasonale given in the changelog.

-- 
 i.


> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> index 9fa3037c03d1..6c2e607968f2 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -427,6 +427,9 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
>  
>  	auxiliary_set_drvdata(auxdev, tpmi_uncore);
>  
> +	if (topology_max_dies_per_package() > 1)
> +		return 0;
> +
>  	tpmi_uncore->root_cluster.root_domain = true;
>  	tpmi_uncore->root_cluster.uncore_root = tpmi_uncore;
>  
> @@ -450,7 +453,9 @@ static void uncore_remove(struct auxiliary_device *auxdev)
>  {
>  	struct tpmi_uncore_struct *tpmi_uncore = auxiliary_get_drvdata(auxdev);
>  
> -	uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
> +	if (tpmi_uncore->root_cluster.root_domain)
> +		uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
> +
>  	remove_cluster_entries(tpmi_uncore);
>  
>  	uncore_freq_common_exit();
> 

