Return-Path: <linux-kernel+bounces-557147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E3A5D43E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1D3B615C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83201547D2;
	Wed, 12 Mar 2025 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3OicoRA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A5145348
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744402; cv=none; b=kcWipJF8QAEUe002ZOh+LGdRRcfDLJ5Fz23dd7iDRToORHG9WWIBJBuVUb5unGgltLJSPJaWzv3ewj5RFXUje3993tWlTWmx+282mewLCrgHjXTTdgQKASBShpIJJKcmw2LTwhnrexTMzn0KfhOflg11JRZOba5qTZB2WHLKi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744402; c=relaxed/simple;
	bh=z6xhq02tkPMcYQAmKs0D7RZO9dRfV+y6s22SJkDtOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiBDEF6wHzDwQq/LX8jmkcWKg69B3eGFKNB84bJsOcdqpOodfB/+I78lcy4FzfnjiZbz4uN3/pFVmdR7wyur9onY0f0p13Z+9/p6mvqVmZpw9mej5tPNulQ2iGxScFfYwQs6lWrD6GYmkMYPrIcAKPzFa9jJHmewZjV0SwAFThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3OicoRA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741744400; x=1773280400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z6xhq02tkPMcYQAmKs0D7RZO9dRfV+y6s22SJkDtOJA=;
  b=J3OicoRAijEya62puEkQyEMy5FgxhcsRrATNO6byH8Zac+rdccS+AU0A
   A8EUQtfHuVqbtohwRibF8IfJJekeZ5yreYf0e12RjK7r8bAv86l+BrWk5
   HfB6z6caoEe257mz06c0j6rhWu6tbfLUWmGo0gGEqjDtzoHQ3yA6ckREq
   7X3tlBtXX35LICddwtUiW1QAHYfgmxzdsLs1zUMXbZ9yJyJoy0az/UBy5
   hxa0il3/qsZ7ObyEcRJvdRz8zuD9tybmwMxgynT1hnT8ra9xaSwzKiKGR
   r2fgmVlAjA4YdfHoL8d4OMlwthqM+l2grzA4z94x4WcrdKXBWMisKuuHK
   w==;
X-CSE-ConnectionGUID: 1R6lTT1fRe+w4OXZng9cMA==
X-CSE-MsgGUID: NxeJ/iNjR4KODUJiTXoHvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42062308"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42062308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 18:53:19 -0700
X-CSE-ConnectionGUID: tcj5AqcmTOiEuJVR+EjHyQ==
X-CSE-MsgGUID: VxCOJe3vRU6WaxKBoxBDrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="157688834"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 18:53:18 -0700
Date: Tue, 11 Mar 2025 18:53:16 -0700
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
Subject: Re: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl
 filesystem code to /fs/resctrl
Message-ID: <Z9DpDKO4wLEfVVcs@agluck-desk3>
References: <20250311183715.16445-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>

On Tue, Mar 11, 2025 at 06:36:45PM +0000, James Morse wrote:
> Changes since v7?:
>  * Series split to the first 30 patches, requested by Boris.
>  * Fixed stale function names, definitions/declartions and typos.
>  * Dropped the use of the default ctrlval helper in cache_alloc_hsw_probe()
> 
> As ever, changes are noted on each patch.
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
> All this is to allow the filesystem portions of resctrl to be moved to live in /fs/,
> which allows resctrl to be supported by other architecture, such as arm64's MPAM.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v8_for_boris
> 
> As ever - bugs welcome,
> Thanks,
> 
> James

Built, booted, and ran tools/testing/selftests/resctrl/resctrl_tests
successfully on Intel Icelake.

-Tony

