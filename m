Return-Path: <linux-kernel+bounces-238153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72579244F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5323B1F217AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067E1C0043;
	Tue,  2 Jul 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3g2nMbV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45F1BE23F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940604; cv=none; b=h2Pf7VMN+G7/MCHQbXDCnGuL7gA3k4vyBPimHXeQWlWCfQ4o8jiDaZgn6okVJYY7w40DSPUhcTF0AOu0pHTnKptDezaAMcPbTqwERfaOPVXsc/HG3t+5vqCkUPtEN6p1Yb8vJ008H8MCK+3LF0bnHrkINw+OfSCmDkLLyDJEnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940604; c=relaxed/simple;
	bh=C3j60canvGPUuCR7dSKydtKZSnkNQmPoIPzquCxsWus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI6HHRxCGEF8QIwAKeHTPMDmUsc3PCoDH8Yyc4pGtDjoA2fRajInMaWRon1+CB389QCVSlwIlpftAljVN8OV+4C6qHkrbsPWSI43kq2yj3OLiWtWbqbLK4r1Wj5po/NCBMTp9WAvnVPJtCO19myWNl+exdmFFlgUBIvxyH34//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3g2nMbV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719940603; x=1751476603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C3j60canvGPUuCR7dSKydtKZSnkNQmPoIPzquCxsWus=;
  b=U3g2nMbV+3QqJ28osWNF2iB/kkQvCXHeRTJZMTmFzVpVq92jjHUz6x2b
   iU09gcBNM0k8ULHgCh1OgfElC0V7MDjDYpfaxQBFGoKqSzfrShXVAFDgP
   OEkkVUlDwR6bDbI2Pru9oKgXEfVG06bbde8dSnSWobbbs9NZE28UE7Xnv
   sO7oUcOdlLWxDcapwz1o9FQacacfKkbKZS+dWDCubgNR07q5acwdCwIR2
   dEczd9RI3PBIa5YXR0lhnxkXA1NJxp76lG4hrahaZIRU7YkbMXPybDEgq
   13pS4aGA5jao4ZqY5PpFFexzrWETgQ+8WRjCvAdW0eGgcrJmJkOUlz2XA
   w==;
X-CSE-ConnectionGUID: Qcg6N7EYStW2x+5HIQq9gg==
X-CSE-MsgGUID: cFHdBgQUTDWw9l2psqUg8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20032509"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20032509"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:16:42 -0700
X-CSE-ConnectionGUID: /2yoOLtkS7esvdn37AdY4w==
X-CSE-MsgGUID: sdejj7ZzTiWc2l1X95wlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76709409"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:16:41 -0700
Date: Tue, 2 Jul 2024 10:16:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v23 14/19] x86/resctrl: Handle removing directories in
 Sub-NUMA Cluster (SNC) mode
Message-ID: <ZoQ1937ntIdMNQwL@agluck-desk3.sc.intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
 <20240628215619.76401-15-tony.luck@intel.com>
 <20240702085337.GAZoPAEaEBtT18iD3V@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702085337.GAZoPAEaEBtT18iD3V@fat_crate.local>

On Tue, Jul 02, 2024 at 10:53:37AM +0200, Borislav Petkov wrote:
> On Fri, Jun 28, 2024 at 02:56:14PM -0700, Tony Luck wrote:
...
> ... and this are almost identical hunks.
> 
> Why isn't there a helper which gets called here?

A helper will avoid this duplication. Draft below. Is this
what you want? Is the function name OK. I wasn't sure if the
"mon" looked better at the beginning. Or as rmdir_one_mon_subdir()

I've also fixed up part 17 to use msr_clear_bit()

Are you still digging through the patches?

-Tony

static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subname)
{
	struct kernfs_node *kn;

	kn = kernfs_find_and_get(pkn, name);
	if (!kn)
		return;
	kernfs_put(kn);

	if (kn->dir.subdirs <= 1)
		kernfs_remove(kn);
	else
		kernfs_remove_by_name(kn, subname);
}

/*
 * Remove all subdirectories of mon_data of ctrl_mon groups
 * and monitor groups for the given domain.
 * Remove files and directories containing "sum" of domain data
 * when last domain being summed is removed.
 */
static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
					   struct rdt_mon_domain *d)
{
	struct rdtgroup *prgrp, *crgrp;
	char subname[32];
	bool snc_mode;
	char name[32];

	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
	if (snc_mode)
		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);

	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);

		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
	}
}

