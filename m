Return-Path: <linux-kernel+bounces-366886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605C99FBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61CA287FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D51D63D3;
	Tue, 15 Oct 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="En2I013j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94871B0F0D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033071; cv=none; b=BcttucTUjQcFRwR6rPn3kXRlGO14/9Twq3qwdwRna0EbLV6fnG+56pYWVbYhx2ucZeUxdxy+Z1Eehva+xjTYEXkada2g3YGyZ6s0YF8y63OmiTcyBUAovYcf/bWY2yGKA8d+gTev6O+kyBTnU0OWaEQt+0SinAevRxcHhIWMnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033071; c=relaxed/simple;
	bh=vr4BB+dxMaXv4PMO6tf1h4aLh4XEoKAsPXHIiN0pblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+AbArPgRI65cxQpv8/0H0tB22iUQE+MAr+eHOpOlAlPda7B1A3d7/mwGQwVQgMmFQWZbudtcs6eD8qiQoLwigFUxerVw9yKfCo7eeN15y0nIntsM/GL1LLCBDCGbK+2FkJWXwFgbNfh+s1gx5f7ljFB0DmFQKR0K1kkmFLvl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=En2I013j; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729033070; x=1760569070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vr4BB+dxMaXv4PMO6tf1h4aLh4XEoKAsPXHIiN0pblw=;
  b=En2I013jRsQZ7YxvKvCw1r/2Pf/DP+a7lRRhdSLuUk3kKwhXVa8jLaGX
   omELa5S64zL0Z5upxB5THMSr+rOn6BjuApsC8GZ4vSApQvnM6fywKlSuA
   p3D6Cy3vjnBoElYOkwQhQoE72O225NFQWC1wqxaIZI8kHQBLqbExpCcNO
   FX1HnXVjIcNlVny1f6HRFAv01NuSn7UzDdNUsQa7C/cEaN8IK9XmFWWbr
   a4X2fRtkkTF1KPkhN/jJskFJhp7+v32dXkSEd8It1MSSusCyEAGCIHsD7
   /MpmtY9xKi41MG7T0HXJIDGq4ngI+OvITeaKdUayHXRomEwWoy7tuNoz/
   A==;
X-CSE-ConnectionGUID: oo/6RUMfTfGigXGmIXhmnw==
X-CSE-MsgGUID: 7o/DHt6LTWaMR/L0gjaoPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28655993"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28655993"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 15:57:49 -0700
X-CSE-ConnectionGUID: wQnKD7fFTEGxCZQUPrHd0Q==
X-CSE-MsgGUID: LzDqLHZkQy+WwXakY8FmDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78057920"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 15:57:49 -0700
Date: Tue, 15 Oct 2024 15:57:47 -0700
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
Subject: Re: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching
 into the arch code resource list
Message-ID: <Zw7za0Cp0oH6v5w6@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-3-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:09PM +0000, James Morse wrote:
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +	if (l >= RDT_NUM_RESOURCES)
> +		return NULL;
> +
> +	return &rdt_resources_all[l].r_resctrl;
> +}

Is this a bit fragile if someone adds a new item in enum resctrl_res_level
but doesn't add a new entry to struct rdt_hw_resource rdt_resources_all[]
in arch/x86/kernel/cpu/resctrl/core.c

Any caller of resctrl_arch_get_resource(new item name) will get past
the check "if (l >= RDT_NUM_RESOURCES)" and then return a pointer past
the end of the rdt_resources_all[] array.

Maybe make sure the array is padded out to the right size?

struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES - 1] = {
	...
};

-Tony

