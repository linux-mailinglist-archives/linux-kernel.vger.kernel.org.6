Return-Path: <linux-kernel+bounces-361866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450099AE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE11F21AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235881D151F;
	Fri, 11 Oct 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+Hur7jc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166E193436;
	Fri, 11 Oct 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682616; cv=none; b=IVZTAxitdJURiS9N9wq/dvg+twqx44BndwA7McLQ5b+95fIm88zM4K/jpagu2aTLYXDVcREm/0IdWJjJmB2NT43uSZeRXw1LSMfr9+Mc35sCDRikUroeOLcGh/GgSxlMOyjHOM+d/6Wj5MY9hmJiztffLSiDneKRsn0qiXj/pA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682616; c=relaxed/simple;
	bh=aDQfs9YAcUIWbWginV2/zdeeoyKXVYhIFV7RZFTGRqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUpQ9sc7E0sdygHo6U+9RQu/3bdZi2tR5hmrVoQe23zEzBWcuk8RnEfJ9FZcCKb14OGkYUagQgdP2anPYU3VSASVmGBAUI/RaS+8KFQR7Wq7VhpQoWBt2z/7TZD3IPtcFRYVyStsKV9tYPtAE/fyYuInBPWYz98yolmbWFu+Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+Hur7jc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728682615; x=1760218615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDQfs9YAcUIWbWginV2/zdeeoyKXVYhIFV7RZFTGRqs=;
  b=E+Hur7jcWHT9BapI20El4UaCTb4zPUMAkBrMV9wslxuDctHIJh0iLUWF
   CGMYgoF+g9634usfWz0t6jY5fHodrw8QPFcy4op86kPkuBW/C5JZkVWx5
   /t4fgA2uS0rGZND76/5nyL/JTkOL2I6+jiGNHL+1zC7JsGJ1XweZYjMXf
   lceSAirlyGsTabKHDNgJGMW/prqL95bMXhsoLJA0otn3w37OY674clneJ
   4mOCcfH+lb8wK2NKZzjiDlJyRh4ze0wVA2s3X69gM7FbvIDownaV3J1QF
   YlETaOKzH+r6HpZ4LRrpgfMqGfcoy5UaM5fTdJaULvEnh1cab3t56es7Z
   A==;
X-CSE-ConnectionGUID: TsuixL9rRQ6JXXhW8M/KOg==
X-CSE-MsgGUID: e51fW2ZcSQiHDPXoQDz9OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39474229"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39474229"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 14:36:54 -0700
X-CSE-ConnectionGUID: K7hRfXewTnOaXLExOnuvVg==
X-CSE-MsgGUID: KDBE7+pWT7+5SlZ//AkYug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="100335606"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 14:36:53 -0700
Date: Fri, 11 Oct 2024 14:36:52 -0700
From: Tony Luck <tony.luck@intel.com>
To: babu.moger@amd.com
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
Message-ID: <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>

On Fri, Oct 11, 2024 at 03:49:48PM -0500, Moger, Babu wrote:
> > Is there some hardware limitation that would prevent
> > re-using domain 1 counters 2 & 3 for some other group (RMID)?
> >
> > Or is this just a s/w implementation detail because
> > you have a system wide allocator for counters?
> >
>
> There is no hardware limitation. It is how resctrl is designed.
> In case of Intel(with two sockets, 16 CLOSIDs), You can only create 16
> groups. Each group will have two domains(domain 0 for socket 0 and domain 1
> for socket 1).
>
> # cat schemata
>     MB:0=100;1=100
>     L3:0=ffff;1=ffff;
>
>
> We may have to think of addressing this sometime in the future.

In this example, the hardware would support using the instances
of counters 2 & 3 on socket 1 for a different group (RMID). But
your code doesn't alllow it because the instances of counters
2 & 3 are active on socket 0.

If you had a separate counter allocation pool for each domain
you would not have this limitation. When counters 2 & 3 are
freed on domain 1, they could be allocated to the domain 1
element of some other group.

Maybe that isn't an interesting use case, so not worth doing?

But if that is the goal, then there is no benefit in having
/sys/fs/resctrl/info/L3_MON/mbm_assign_control allow different
domains to choose different counter allocation policies.

E.g. in this example from Documentation:

/child_default_mon_grp/0=tl;1=l;

This group allocated two counters (because domain 0 is counting
both total and local). Domain 1 is only counting local, but
that means a counter on domain 1 is sitting idle. It can't
be used because the matching counter is active on domain 0.

I.e. the user who chose this simply gave up being able to
read total bandwidth on domain 1, but didn't get an extra
counter in exchange for this sacrifice. That doesn't seem
like a good deal.

I see two options for improvement:

1) Implement per-domain allocation of counters. Then a counter
freed in a domain becomes available for use in that domain
for other groups.

2) Go all-in on the global counter model and simplify the
syntax of mbm_assign_control to allocate the same counters
in all domains. That would simplify the parsing code.

-Tony

