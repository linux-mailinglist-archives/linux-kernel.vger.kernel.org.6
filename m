Return-Path: <linux-kernel+bounces-357677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABD9973F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314241F24504
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1B1E0481;
	Wed,  9 Oct 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqQ1t0Wz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097A1E132F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496974; cv=none; b=GUQtJPJyJixJfT3HWZojUi3VyC8obKfpzPba8kw2yFIyEBMt1P1+ZOsZ6ng+lCW4RRlhtxBFWufDwIMPmuygjoLo3vqkEJTqZxLnOOi6X2qP+hNwZwxlAeG+Q+4HVFoM5VlGslHhQoStfpceI/TJAUfjoV9Iv5fEuCr9z5gchFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496974; c=relaxed/simple;
	bh=tKTMoOuajLWdXL878ngPL+Xkt0x2VzlntbO4SRCQJ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwo+x7tV+mwQW0YzqeQqBbCib3DcVXkq7fo3QiBoaoSbCzjjiDCQHaFSwIAvGo6n05ANGoW9t6+vAJnZSPLBJU7kkHBb3xCdiuVMEb4VLmnEeB9CVPUQ9Fe0yb9UzWEkoVZrEHdlPm0CEO0FwewoSqoH7o3obAWcfCOki2q8eZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqQ1t0Wz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728496972; x=1760032972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKTMoOuajLWdXL878ngPL+Xkt0x2VzlntbO4SRCQJ9o=;
  b=VqQ1t0WzAK9vdxv2nzU/JW8dh0OKrmkto0cqxQQvVxxWwlWvd93N4Scp
   kf6eVM8RuRcLdzbMG/s0jlA8nhOVGCoH9eznNy16thwwxubuAPrGR6KFh
   RXUyOU2XQWQ2EW7+IS/QsVhprf3MgIOHR1NAY/LfU/O7VbDHnB1W0n6su
   rac2eXuXw7dwTdp4cCx32dVoQdBLXolhMqsOccAVmPpQ7gXBXEjRKfe8U
   /BFxpbiLopGEGzaB2+lYiNvZDp7/+S7ileWVqM0owli2Vvb8X7p51bwc5
   E/tcdYpmrMAepcmblPgxPmzd1VMdR5R6iDNVfNNE8ReF9LH+2v7JdZZBm
   w==;
X-CSE-ConnectionGUID: Ofh1jDJZSDmSntXvm1FykA==
X-CSE-MsgGUID: DNYZ+5iiSmqiO4O9TuRONw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31519027"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="31519027"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 11:02:52 -0700
X-CSE-ConnectionGUID: ufqKTkf4SLiAD8gwwvX0/A==
X-CSE-MsgGUID: WSUALnXtTbWwwFdVuosd/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="77166920"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 11:02:51 -0700
Date: Wed, 9 Oct 2024 11:02:50 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 07/40] x86/resctrl: Add max_bw to struct resctrl_membw
Message-ID: <ZwbFSorNKhURT5Xe@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-8-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-8-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:14PM +0000, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 8d1bdfe89692..56c41bfd07e4 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -57,10 +57,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> +	if ((bw < r->membw.min_bw || bw > r->membw.max_bw) &&
>  	    !is_mba_sc(r)) {
>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> -				    r->membw.min_bw, r->default_ctrl);
> +				    r->membw.min_bw, r->membw.max_bw);
>  		return false;
>  	}
>  

Heads up. There is a patch to this function in the TIP x86/urgent
branch. So will likely go into v6.12-rc3. So this patch will need
to refactor on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=2b5648416e47933939dc310c4ea1e29404f35630

-Tony

