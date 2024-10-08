Return-Path: <linux-kernel+bounces-356036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D0995B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF901F24202
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F335215F47;
	Tue,  8 Oct 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kATOozmZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4F1D0F44
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428617; cv=none; b=efBjiSQnKPqaZ3+2BXM6ilFfpF1SV7jkH/SgLUZnkLPdvsKbl+3GFKqazd82hhTDNgG0lqKaKTc/nQjX3qR4g4+c6feByQpC/jbIJQixwkFMSBYJkMde8BDbu6bxgTE8glDVpApSiCQJU/n4/BszC/2F299U0ZuK6YimY7yvsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428617; c=relaxed/simple;
	bh=5hvxAlPWX0LyqgToI+agMcWwCHEqYCMYgWeLZB2yhfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COhe44qbpXDfkY9B2c0c9qD5lP2UnBOUb7O8SwmnZg81e6pKApfRFm7y+kjWSiz9JVtIkzY9PARrL9mNt4/L8iw6TeWP6tgW3qU4IS8AL6W+vTyaROmCeXekMiqS8aczr1K+ey032cf0lVfhyJ0nGwqwr0IKDcab+DKog+41838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kATOozmZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428616; x=1759964616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5hvxAlPWX0LyqgToI+agMcWwCHEqYCMYgWeLZB2yhfk=;
  b=kATOozmZzavrmJ8xAzbqDy2qVeVvWaqF3ixV5qJRB/Om1fLDp2u6UP63
   ISJ8BqK2gpQ+ZjsyM8iTBiILCoKicQhqEf9GrecU3PDfNUPW3FSVETHb9
   VsYMMZgHgSm1F9SYChPRz7jaL8fASP4g2lWeciuz3Ul4Mtyth0gBrzAIY
   Y35xgxs+Zdb0TzFzmJPy+Y2uqHzOAfzJRus6EDop6DofWiyQem6cvfSfZ
   lnz77Cvjhc9bvf+7nywmMpAnE7ZoKzXdrjuXnO+LmfCPzJuYNmF5J4mup
   hutfuppOtG83v2jaxdfv8y3MuQtys5ubKlNEfvZl2rpzP8AMcjNiSCvl3
   Q==;
X-CSE-ConnectionGUID: aKZkL00kRna0A0DO/WmcOQ==
X-CSE-MsgGUID: XnMyIzVLQ0KCa4TubqLWrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53090136"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="53090136"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:03:35 -0700
X-CSE-ConnectionGUID: JttidmRFQFexSFY7Kms96Q==
X-CSE-MsgGUID: K/OPJ4aMRwaZy1nerDvmAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106860738"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:03:35 -0700
Date: Tue, 8 Oct 2024 16:03:33 -0700
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
Subject: Re: [PATCH v5 38/40] fs/resctrl: Add boiler plate for external
 resctrl code
Message-ID: <ZwW6RbkNIml07hbg@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-39-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-39-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:45PM +0000, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> select this.
> 
> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
> /fs/resctrl files to switch over to using this header instead.

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 4b7e370e71ac..973fddf7e9a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,10 +7,9 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <linux/resctrl.h>
>  #include <linux/tick.h>

internal.h already has a #include of <linux/resctrl.h> it doesn't need
another one.

-Tony

