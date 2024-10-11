Return-Path: <linux-kernel+bounces-361631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D729F99AAA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA1B22730
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054321C245D;
	Fri, 11 Oct 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxvVsZag"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA71BDA9F;
	Fri, 11 Oct 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668650; cv=none; b=H3kWOYZYoEp78WDqwK6SMQ4mRSNdpUfAMY/rG9bcxIG4vexdzSXja+CZwIu2Y1fSsOPnWt+uQj27vOazyIiQeAUr9WhH4gqIODqukHNa80j7cVCpqhY/blaYDX3fRhqSHqWSFWnYqLU++W/34zqytmZdbVKOMZYhDwYlfY27SoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668650; c=relaxed/simple;
	bh=rzIUIXnpavhay6Z9wbKellhhV+0fUxTfmtWvunGdrfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT14zZKBcR+TX7bkfDL5i2jJ5OzA6On8OlkZU8x2fzzoBHyTLarnyyY39koMaPbuxgGy60CxH6CHXG8hJjy3Qb8F5i68nLV7AicAsROU2IRdchGUxcCn3xxtcLd/xgRuoj2hVd5PiyGqMZKQKnwyCY+necCS6FSUTcJMV1vaU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxvVsZag; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728668649; x=1760204649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rzIUIXnpavhay6Z9wbKellhhV+0fUxTfmtWvunGdrfI=;
  b=kxvVsZag3rvlQ21MxucWMMcReqSOeZ8x9NZoj7B0ZM+pBJ4k8MMh8+lt
   6Muu5VFDZ2GVg1ftF+oVNj0V47FTmdG5n3dHzE5orKQLugqM+kPIG2rE3
   HWJbtNbsIOnKvI7W+Pa+watyI0JnYIf58eJ8yFXgoEyMJQQO3vZ2n4DxR
   R8Ih3UYwP5eNhLjfxTJCihBOOdqo7vRZJNkjTVWhMtYhD+JOaOzS2wfXw
   afn6NT/Uqd2Tc2xTIM7ArVoBsSGhwXOd94IalsziM64QFJJxGo3Ul5CfY
   NLrGtxUiufI5D3X/ag7xQJf7YO4qeyG/5R135GFzF9Ap3zo28OU9OFT13
   Q==;
X-CSE-ConnectionGUID: o+l5jkFzSPyiqq4jLVdNoQ==
X-CSE-MsgGUID: Z8WzPy1KSxmB5TGCukSRng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39449999"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39449999"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:44:08 -0700
X-CSE-ConnectionGUID: N8jYduzIQ/acbZHqLuv53A==
X-CSE-MsgGUID: YT70OPQFTz2SALa9XcneXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81794744"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:44:07 -0700
Date: Fri, 11 Oct 2024 10:44:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Message-ID: <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>

On Thu, Oct 10, 2024 at 03:32:08PM -0500, Moger, Babu wrote:
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> > //0=tl;1=tl;
> > 
> > there aren't separate counts from each of domain 0 and domain 1.
> 
> Yes. There is. Each domain has its own count. I am not sure about your config.

I've been reading the code and see better now.

There are a bunch (32) of counters per domain.

But you have a system-wide allocator. So when making
a group you may allocate counters 2 and 3 for total
and local respectively. Then configure the local instance
of counter 2 on each domain (recording that in the per-domain
bitmap) for total bandwidth. Ditto for counter 3 instances
on each domain.

If the user updates the configuration to stop counting
on domain 1. Then the per-domain bitmap is updated to
show counters 2 and 3 are no longer in use on this domain.
But those counters aren't freed (because domain 0 is still
using them).

Is there some hardware limitation that would prevent
re-using domain 1 counters 2 & 3 for some other group (RMID)?

Or is this just a s/w implementation detail because
you have a system wide allocator for counters?

-Tony

