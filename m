Return-Path: <linux-kernel+bounces-444072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BFE9F0045
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6F287CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC171DF273;
	Thu, 12 Dec 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSjPVaWT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826A1DED73;
	Thu, 12 Dec 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046670; cv=none; b=qKLTOWiVDqoC+Po7944qcU3wOEF/utJ7Klb4pHhAoGEnA3uFfCNG1J/Gm+kEPZXbX4DwKfs1bZPuIUBKDHTzWYX4qYepjw8f2iFDU1I4BwCoTag6yIYzyLw/y/OtqBH1FWWvKKMDw8eIaQk6p44+fzsuX1fWbL4WqyigacQ5bUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046670; c=relaxed/simple;
	bh=RD1R3uZshcKjVMCmPINeH72aA2ptJrhOkxz4oZOI338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/7Mm1qbb5O4ul7EwZ2jgq3HDwXRG3f6EnLr0UOFHn46ChDgHe4X7KLH7wqO9cACuYnlMKrrAx2vKDGM6NCX8XzRmyxxAkZPGrS/AIMwXVfpequiTm3zCtekKPpJKcTKOzQ6nbrbVgp6kh1vh5Jj17ara9R6JRHZDUyg2UzcnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSjPVaWT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734046669; x=1765582669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RD1R3uZshcKjVMCmPINeH72aA2ptJrhOkxz4oZOI338=;
  b=WSjPVaWTjkoAQM5JRx1slld9+ZMRZBFmjL/DxASnGjXr1RuwdKoVP4ZC
   U68Pz6chtkTk16pC3vb3IYJhjv8lBaZhz1L3GXkDCVBKiwPDNL0IdH0gZ
   ApgvDsEOItAHth5im4Z/Qv4xPKvLfM2+U3ijxs39lYV+t6PZlErLxb71B
   HBQ+Maf0G1wVvNSLuSMjH/TMx4lZCmE6zYF5RsNbxMVC9bNcYkEpXowYT
   LrCxwtNWDnu3F7OvvmEaim+rLcpmnJohE4bEPAWYM4xziIB0KGdWj6FOO
   KcYtL7p9FjtUn9Aj7QtZ90VC1ftSiPuZGgPAUfLawrj1/AIwU4JN07XCl
   A==;
X-CSE-ConnectionGUID: YZByykCuShupudJJXtNcpA==
X-CSE-MsgGUID: GHJk8ELoTKOaWvTm119Brg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34215555"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34215555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:37:48 -0800
X-CSE-ConnectionGUID: V0Pal+3iSgOJLph32nmc+w==
X-CSE-MsgGUID: yxpIU1AmRhyhti0fNs4BYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133752553"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:37:48 -0800
Date: Thu, 12 Dec 2024 15:37:46 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	peternewman@google.com, fenghua.yu@intel.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, andipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v10 16/24] x86/resctrl: Add interface to the assign
 counter
Message-ID: <Z1tzyrUYTFR_iHuJ@agluck-desk3>
References: <cover.1734034524.git.babu.moger@amd.com>
 <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>

On Thu, Dec 12, 2024 at 02:15:19PM -0600, Babu Moger wrote:
> +/*
> + * Assign a hardware counter to event @evtid of group @rdtgrp.
> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
> + * else the counter will be assigned to specific domain.
> + */
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> +{
> +	int cntr_id, ret = 0;
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
> +				continue;
> +
> +			cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
> +			if (cntr_id <  0) {
> +				rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");

Message could be more helpful by including the domain number.

> +				continue;

Not sure whether continuing is the right thing to do here. Sure the
other domains may have available counters, but now you may have a
confused status where some requested operations succeeded and others
failed.

> +			}
> +
> +			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						  rdtgrp->closid, cntr_id, true);
> +			if (ret)
> +				goto out_done_assign;
> +		}
> +	} else {
> +		if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
> +			goto out_done_assign;
> +
> +		cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
> +		if (cntr_id <  0) {
> +			rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");

Ditto helpful to include domain number.

> +			goto out_done_assign;

When you run out of counters here, you still return 0 from this
function. This means that updating via write to the "mbm_assign_control"
file may return success, even though the operation failed.

E.g. with no counters available:

# cat available_mbm_cntrs
0=0;1=0

Try to set a monitor domain to record local bandwidth:

# echo 'c1/m94/0=l;1=_;' > mbm_assign_control
# echo $?
0

Looks like it worked!

But it didn't.

# cat ../last_cmd_status
Domain Out of MBM assignable counters

rdtgroup_assign_cntr_event() does say that it didn't if you think to
check here.

> +		}
> +
> +		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +					  rdtgrp->closid, cntr_id, true);
> +	}
> +
> +out_done_assign:
> +	if (ret)
> +		mbm_cntr_free(r, d, rdtgrp, evtid);
> +
> +	return ret;
> +}

-Tony

