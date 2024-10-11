Return-Path: <linux-kernel+bounces-361558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48799A9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A4D1F23801
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112D19F118;
	Fri, 11 Oct 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO9EzeDC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0B1885AD;
	Fri, 11 Oct 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667073; cv=none; b=smSaXbauSbehlxhT3zoGv0oo4TSBs4L5UrohhEONGPNT4oMO8DwGAQ+QjRw2Dg5NaF4Yflm27RkuP30I1bGmtftNsrdea8TzuKoz8mp9V7FJHybH90lcOQqefsIeuOtDcLEIsRMcpK4MSuzhzqkgp0UWlS1RAitdOIML4ec83ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667073; c=relaxed/simple;
	bh=pkBAqpG7XSDDkbeiXIU/xXtZJwy+sM5Znhd8x7fr7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxzo0HP7wpnkn17C2XCnJezredqKRQUayrClLBKMjvIdwWbYHcQsaMRuNpCGUGhXXS5x+QGH57YWKX7ywTVJ2DDHsk8vNM4jeZ+tEtYHzf/ebnUok+jB5414EJCEcawA/YPs9CB5d5ATzIzrksve+vpCJ7jRblPo4bRwRX+QlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NO9EzeDC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728667072; x=1760203072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkBAqpG7XSDDkbeiXIU/xXtZJwy+sM5Znhd8x7fr7hk=;
  b=NO9EzeDCyQM8pfIk9d7jImFtTd1K+tCy6Wg051f1J+K8UpvGQyGwmksw
   eleuGrsotGVtBdm83K8ocRTW94d/2PdF0o2LUrhQG1pUN2g4c9IUsQsr/
   50W/SF3Ge4Y1u/1c7UVrpf6Bdv+jOPyB2CF+ukUGccusgfZ06NDPxe3S5
   Qs/X9o+Bv42wO119szY5Fz48l2gnbhSy+zEVBnp/ljgudiDHw4uWrD6zb
   +CgREzuPnLWnnIxgoSy161pc62q3/1hWUM82Rt9Y5VZgaXNzYmau/ZcG0
   VwG6fHLtZi2t8r1HlpD4MqtMQeJySzxCRNStoa7PdpMMjS5/+fVd1QOZc
   w==;
X-CSE-ConnectionGUID: 5v9kgSRKSFC6BkJIhxdUKw==
X-CSE-MsgGUID: XSgfV6DtQ42tnOmvV+X39A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28236907"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28236907"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:17:51 -0700
X-CSE-ConnectionGUID: 5OhZymknRJ2EdMhZxx0YMw==
X-CSE-MsgGUID: HP/n5oIVRrOPRtJIR7kRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76881728"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:17:50 -0700
Date: Fri, 11 Oct 2024 10:17:48 -0700
From: Tony Luck <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Message-ID: <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>

On Wed, Oct 09, 2024 at 12:39:44PM -0500, Babu Moger wrote:
> +/*
> + * Called when a new group is created. If `mbm_cntr_assign` mode is enabled,
> + * counters are automatically assigned. Each group requires two counters:
> + * one for the total event and one for the local event. Due to the limited
> + * number of counters, assignments may fail in some cases. However, it is
> + * not necessary to fail the group creation. Users have the option to
> + * modify the assignments after the group has been created.
> + */
> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ret = 0;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);

This overwrites the value from allocating the counter for total event.

> +
> +	return ret;

But none of the callers check the return. Indeed it is ok (and
expected) that counter allocation can fail.

Just make this a "void" function and delete the "ret" local variable.
> +}
> +
> +/*
> + * Called when a group is deleted. Counters are unassigned if it was in
> + * assigned state.
> + */
> +static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int ret = 0;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return 0;
> +
> +	if (is_mbm_total_enabled())
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (!ret && is_mbm_local_enabled())
> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return ret;

Ditto. No caller checks. Make this a void function. Dig down the
call chain here. It looks like rdtgroup_unassign_cntr_event() can't
fail, so it should be a void function too. Ditto resctrl_arch_config_cntr()
> +}

-Tony

