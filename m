Return-Path: <linux-kernel+bounces-438594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D79EA33E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17E91887AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3F6CDBA;
	Tue, 10 Dec 2024 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxiED/4q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7AA934;
	Tue, 10 Dec 2024 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788859; cv=none; b=AVxp67xPD0fLcr0UBmaFX6MZ5oViJsHayiUy+AeorMwHXvSX7d4I2Vh5+ZConZ3Tl2H9qlLCQiedDw/y0/SbyAey9DYIgDvHbVJ9cyrUex8K5XblhYOew795RExsFlM1hYD7cflr6q2Pi9l6XWkFg/bGcmqxgFB3ZLQfZffmtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788859; c=relaxed/simple;
	bh=Hx3TYCfv8vO1GHDfioqECB6aGnBv+pYMSPSzeHD0ACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOBU8SUd1iY83gZvDSc4rZPF4eVv0P9w1rqsntBBKNwgEm964tbdID/LoEEQRC+vxJpbPHJ+XMt3UKV2KSaojP1yoqagPNXkeNxEXRzqr15qR8dbrKf9PmVuQbt7eGfhorzHlHZdjj22jPv2LZh5gYjx11lb2hbsHl5K00+nfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxiED/4q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733788857; x=1765324857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hx3TYCfv8vO1GHDfioqECB6aGnBv+pYMSPSzeHD0ACM=;
  b=kxiED/4qWgdjC8syHpcQ/oBSt6TehmN8CqDPcrmesjwGYrR4b+zABNOR
   pPka+VVmu0Ied4rHDt2RARryuxBEZtc+SmP8TI9abNm1UZ/GIFmQDUNL5
   TGH3TIfjxHgiE2Ey3kn2joO0QnncLvj//19BafU9NFyMiIJNoUzyYl55+
   G8YzMt/qpthbRSDQF27OUpEOPl1WgAI1BskUyRsyJwGqx/maGrb2yMD4w
   m/Z/I+iFVuqYBXytHoFMDpuvbPhUg0Ykmiftl50xNG3Z4FN5OMl6YFR7K
   Ctu//wNnA4tngjhOqc6fzn5oNN19B6M/R3YETqc90danguAbsxhIXko3C
   Q==;
X-CSE-ConnectionGUID: HtBvaavbTyaz/aIQwm+riw==
X-CSE-MsgGUID: ch2bNqTkSf68VnQ41V09wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45493623"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45493623"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:00:56 -0800
X-CSE-ConnectionGUID: FrHyAsf+TsSInDwzX9C6WQ==
X-CSE-MsgGUID: fvwvGNsbQQub6ODNnUFruA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95095907"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:00:56 -0800
Date: Mon, 9 Dec 2024 16:00:54 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare for per-CTRL_MON group
 mba_MBps control
Message-ID: <Z1eEti6Kswtb3HC5@agluck-desk3>
References: <20241206163148.83828-1-tony.luck@intel.com>
 <20241206163148.83828-3-tony.luck@intel.com>
 <20241209204519.GAZ1dW3-NjcL4Sewaf@fat_crate.local>
 <SJ1PR11MB6083BA367F2CDFC92D87FDA1FC3C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241209222047.GKZ1dtPxIu5_Hxs1fp@fat_crate.local>
 <SJ1PR11MB60830B8ED36CCA7E304D9E97FC3C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <678cef69-78ef-4951-bd31-10abe646e6d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678cef69-78ef-4951-bd31-10abe646e6d8@intel.com>

On Mon, Dec 09, 2024 at 03:40:12PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 12/9/24 2:35 PM, Luck, Tony wrote:
> >>> mba_mbps_default_event isn't architecture specific. The mba_MBps
> >>> feedback code could be implemented on any architecture that supports
> >>> both measurement and control of memory bandwidth.
> >>
> >> Yes, and it should be moved to that header then, right?
> >>
> >> But not earlier.
> > 
> > If you feel strongly about it then go ahead and cut the line from <linux/rectrl.h>
> > and paste it into <asm/resctrl.h>
> 
> I am not sure about this ... I expect the code needing this initially will
> form part of the filesystem code so it may be more intuitive to have it
> be located in arch/x86/kernel/cpu/resctrl/internal.h as Boris suggested.
> As part of the arch/fs split it may then move to fs/resctrl/internal.h
> 
> mba_mbps_default_event may even stay internal to the fs/resctrl code with an
> arch helper created later to initialize it. This is because I think
> the initialization of mba_mbps_default_event may move out of
> get_rdt_mon_resources() into resctrl_mon_resource_init() that is being
> created as part of the MPAM work [1]. An example of current fs initialization
> done in arch code that is moved to it can be found in [2].

Reinette is right. The post-split home of this is not <linux/resctrl.h>
but fs/resctrl/internal.h which doesn't exist yet.

So Boris is right, this declaration should be added to arch/x86/kernel/cpu/resctrl/internal.h
by this patch to be moved later.

> 
> [1] https://lore.kernel.org/all/20241004180347.19985-17-james.morse@arm.com/
> [2] https://lore.kernel.org/all/20241004180347.19985-20-james.morse@arm.com/

-Tony

