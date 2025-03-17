Return-Path: <linux-kernel+bounces-564897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139BEA65C77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C50E883C58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5871CDFD5;
	Mon, 17 Mar 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrj/7YEq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361091A7AF7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235796; cv=none; b=tcI5A5tGIpi0fxWnBX7GEB7321aDZWPE9LS6uuLZCyivoKiO3ZhVuay5Nj6N1FBFC/myGQWxxAzOdreD2IxfC1zZhWaBk+S82gsJL2dclbGt73zEho4Hhi1GE1r/ovWdIcl1nQSGtGpmp5D5nmW5M/fHOZ7I6Wli8OY9P3iH7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235796; c=relaxed/simple;
	bh=4w2t8ziQ3MaQSWNJnAtKVR9xCLHkPnm+0yL66gLdGMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1gT9Zhpw1DONu+F5BLXBjVif3m+TnXtchYlgr6usBzlhYa+QWfJM2l7B4UqY29MWJDu6VhYevqtXT2wHQJm/pb13Td76nxmRw7dRCnGCifupWNjYvqJXM6xfGlLKxGYAplo3X2bcjdNfR/LNxVHdbLXdu6j9eQsUejzuMhFPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrj/7YEq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235795; x=1773771795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4w2t8ziQ3MaQSWNJnAtKVR9xCLHkPnm+0yL66gLdGMY=;
  b=lrj/7YEqiwLPJl2NCuswzCy1X0WdaLv1VnzF6n6lCYJuyYBZ35PPT5D9
   /FiBYzHUDapyLJwTkRDBlnwm7YGBZkOTltMqwhr4wnmb2txMJhTHCOlJi
   +fEMDpelh2rTRV2iyNpt43kytcswme9VjZY9k/CEO9IrZTIQqm+q1Xi3+
   ddthoCn7LXGAmSCLim2K1xqVbne/RKNLo3akFTiU//ZuvUoFe0Q41GTmG
   IC5LS3Vdh5lxRYnA9Z8UsLztgSXBhjpH41uAfC20xZ04U6VbHkrrHZuaW
   +nEKAMByBWQBTmp75/MGnAWhpD0aQwKfGxrgJN1Dps3qj4FZo7zATLWwj
   A==;
X-CSE-ConnectionGUID: Jm9votP0SWm+TEvTxmbYfg==
X-CSE-MsgGUID: BMNzRkTJTv6r9GmGLw7IJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="47235925"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="47235925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:23:14 -0700
X-CSE-ConnectionGUID: fZX/3bVJQW6gDdd5wJXL3Q==
X-CSE-MsgGUID: dW1/HaRuSGe9/hUl9tNyNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122001407"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:23:14 -0700
Date: Mon, 17 Mar 2025 11:23:12 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/resctrl: Refactor to make adding extra MBM events
 easy
Message-ID: <Z9hokNv4PvUILFjF@agluck-desk3>
References: <20250314202609.5753-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314202609.5753-1-tony.luck@intel.com>

Here's my other bug:

> @@ -4162,31 +4156,29 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	size_t tsize;
> +	int evt;
>  
>  	if (resctrl_arch_is_llc_occupancy_enabled()) {
>  		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
>  		if (!d->rmid_busy_llc)
>  			return -ENOMEM;
>  	}
> -	if (resctrl_arch_is_mbm_total_enabled()) {
> -		tsize = sizeof(*d->mbm_total);
> -		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
> -		if (!d->mbm_total) {
> -			bitmap_free(d->rmid_busy_llc);
> -			return -ENOMEM;
> -		}
> -	}
> -	if (resctrl_arch_is_mbm_local_enabled()) {
> -		tsize = sizeof(*d->mbm_local);
> -		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
> -		if (!d->mbm_local) {
> -			bitmap_free(d->rmid_busy_llc);
> -			kfree(d->mbm_total);
> -			return -ENOMEM;
> -		}
> +
> +	for_each_set_bit(evt, &rdt_mon_features, sizeof(rdt_mon_features)) {
> +		if (!resctrl_arch_is_mbm_event(evt))
> +			continue;
> +		d->mbm_states[evt] = kcalloc(idx_limit, tsize, GFP_KERNEL);

tsize used uninitialized ... so "random" allocation amount.

> +		if (!d->mbm_states[evt])
> +			goto cleanup;
>  	}
>  
>  	return 0;
> +cleanup:
> +	bitmap_free(d->rmid_busy_llc);
> +	for (evt = 0; evt < QOS_L3_NUM_EVENTS; evt++)
> +		kfree(d->mbm_states[evt]);
> +
> +	return -ENOMEM;
>  }

-Tony

