Return-Path: <linux-kernel+bounces-361567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4A99A9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7261F24E56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B31B3B2E;
	Fri, 11 Oct 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbnZXLjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2521A08BC;
	Fri, 11 Oct 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667413; cv=none; b=q7aKYl/HAr66dLWiIKBc0Vk4epzojpJOOqGWhlpx8MowWvR6V/glgcW0j2nfRZwytZhzw1VacmK6VF7SqEZaipSTXcGfJknWkrty4RUs4Idgp3GANAAiAB4sinOfDobICz5cyiDtHK5aXGuy3u3IN9KQd2Qb2zITldQgLFENDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667413; c=relaxed/simple;
	bh=eRAi8rQkJunGrDG6t0kcJRTBv9Jq5mSsb16dF6jAqSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM8bC21Y+rIC6KzmXzm/oOVlPI/Dj4igMbIvJZNLb5jBJl2AW3GhQ4aUQ63yERgKwncupJGiB8P52pQV2LnvNkifUkN6qn2VcCu/IIV4//v9bLomr+DIWu90jllaDLitbPeZoCHtl1zS0oPAD2y/JJ9xqWaC6AVFu4YZQif0cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbnZXLjh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728667413; x=1760203413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eRAi8rQkJunGrDG6t0kcJRTBv9Jq5mSsb16dF6jAqSg=;
  b=UbnZXLjhzMmiXbAKVYHVkc2QwTmJemU75piqidvcVyfEHHRQaiKSJzu6
   x1DD7PWbKhvBAhfkeF3tA3lJqnkLrHB7Tmnns4gH1Y4S0i7O+nhPXFKe+
   xhlFRXm68KzLeDEr0ikUvvh/YUXPkVHntbJbIO5TVCQ5HPt5IvpZ4Wi6h
   XvhZaHuqui9arXVjUv9VrBarkuiUlbz/Sno6lHFfly5/2Sk9ZVGAfG4WG
   +6JQCcmI8Tf/gXcDxLyJtdOFSk/O0djX3x8kLSZlKXohYG09Ezjo2Xt3M
   /dNNCExgrZK9q8HhRFlpXCTgww/5uWotcLQQxeDncz7ddbpR8kA0NjIzI
   Q==;
X-CSE-ConnectionGUID: 2kUFze8ITqSAUNwfrYfd6Q==
X-CSE-MsgGUID: moGGYOQGS7G0p2qIGp9gOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38641065"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="38641065"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:23:31 -0700
X-CSE-ConnectionGUID: BKd99AjLSMa8g0Jnq0rqtg==
X-CSE-MsgGUID: oNhlxIWGRAiYJNAKpV3S7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76979895"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:23:29 -0700
Date: Fri, 11 Oct 2024 10:23:28 -0700
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
Subject: Re: [PATCH v8 20/25] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
Message-ID: <ZwlfENV_ijDKjUqW@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>

On Wed, Oct 09, 2024 at 12:39:45PM -0500, Babu Moger wrote:
> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	evtid = md.u.evtid;
>  	r = &rdt_resources_all[resid].r_resctrl;
>  
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {

Better to write this as:

	if (resctrl_arch_mbm_cntr_assign_enabled(r) && is_mbm_event(evtid)) {

-Tony

