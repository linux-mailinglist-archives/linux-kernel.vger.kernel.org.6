Return-Path: <linux-kernel+bounces-545642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4207A4EF86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2048172F53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F0B24EAA8;
	Tue,  4 Mar 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHJKtJGn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6D1DB125
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124871; cv=none; b=NuDDZbwGiPCn/PCwcNi8rOLo0uYyUjzczIhgSoPJ67eLJ+OgBh4hoWmEj5n+TmvLxa2gk3wGc+KAr+qPE6m2thbDg/VEhFEQZWmWwTZS7rDxtk6dUmSlEkrzcee34LG3N//rCI7F5IN3zX0LkKUMKx02Z9J5IqcckTevueex62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124871; c=relaxed/simple;
	bh=VwlzzgKMUFwDAtJ/A1ptWhja2oX5n3COvS1Xyq1Pm4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr9WFbXu9WWBj/KNpzUw5VwbmH5zQT35HWxZMnfPjxWyjWGhg321Lcd+9Pasr9PZSlJhg4mxwYs9gf2IhOsBrWwSAJLj96IiTtePnmsHDOTzybL27DyGpOhElum3VlQ2NU6DxtnSg9IUF5nNbwazfx+ekH6dNd0fPoIRXkMi+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHJKtJGn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741124870; x=1772660870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwlzzgKMUFwDAtJ/A1ptWhja2oX5n3COvS1Xyq1Pm4U=;
  b=lHJKtJGnSe7LXoABuGLs7kn5RNR3gdzs8hxrHwLgniffIU1iaD0mZ7ZX
   PdYx1CVIcZb6aFMAzkqhSYdLlLBAqPf4ckMA1IgP6x+KKg0KR+jPJJE/d
   2NFuNNSNkygH0RL54sfERsDly8z/LZHR8F7C77KXjTQFpfp+TEwZJiPj9
   nc1OwGfDAwZz4mWk3Ob0VWRE133LvpeWtSSTMF6lEy3wUcPNMtKrXTRQ0
   4BmAo5o48shfWAIOtspKrQtwqGOSy7wlEVldS2Rxx5KGYaGvobOYroTWi
   FXjP2zjLHpRWnmAEetkZTKiHIePSOLcD2bV3WAiqNAmt5ml1z/5qqS0pG
   A==;
X-CSE-ConnectionGUID: c2OfoMUaS0ioX9AlGk3nNg==
X-CSE-MsgGUID: WwNsuhsbSsKqJoKMhpvTqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45841050"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="45841050"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:47:50 -0800
X-CSE-ConnectionGUID: tyd+2jSjQIysXjBxYSPcwA==
X-CSE-MsgGUID: 7xpOxhIaRrSqeRCw5vdVLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123694091"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 13:47:48 -0800
Date: Tue, 4 Mar 2025 13:47:46 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
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
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Z8d1AjhSVuS4wRP5@agluck-desk3>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>

On Fri, Feb 28, 2025 at 07:58:24PM +0000, James Morse wrote:
> Changes since v6?:
>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>    that don't join up.
> The last eight patches are new:
>  * The python script has been replaced with the patch that it generates, see
>    the bare branch below if you want to regenerate it.
>  * There have been comments on the followup to the generated patch, those are
>    included here - I suggest they be squashed into the generated patch.
>  * This version includes some checkpatch linting from Dave.
> 
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there should
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
> 
> The driving pattern is to make things like struct rdtgroup private to resctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to disable
> it at compile time is added.
> 
> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
> or for those who want to regnerate the patch that moves all the code:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
> 
> 
> As ever - bugs welcome,
> Thanks,
> 
> James

Upstream is at -rc5, so it's time to pick what to ask Boris to
apply to tip for the upcoming v6.15 merge window.

There are several open issues for Babu's ABMC series. So it
isn't ready at this time.

Also several against this MPAM series from James ... but IMHO the
first bunch of patches look to be in good shape with a
full set of Reviewed-by and Tested-by tags on parts 1-7,9-11,13-17
(things get murkier in the 20's and maybe more likely to have
issues due to skipping patches that don't have all their tags).

So I applied those patches on top of v6.14-rc5 (all but one applied
automatically, patch 10 had two line "fuzz" due to skipping patch 8).

Resulting kernel builds (with W=1), boots, and passes the tests
in tools/tests/selftests/resctrl.

In the interests of making forward progress, should we ask Boris
to take this subset of the MPAM series?

-Tony

