Return-Path: <linux-kernel+bounces-368411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D592C9A0F82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A01A284B43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571720FA8B;
	Wed, 16 Oct 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQWT4P5/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DB45008
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095650; cv=none; b=A9hpbfvyb83YAScfInRyhsoxto/4UC9Tvq+GOv98TWxa9bJmD0WLDLUCefW+4FwfmLzFi8hJqJzoErlkwcBFOF1mng9tmKrlOYzuhaLZT+S8FK45l3uP71gZcdm5LGy3MUDsRm556RScnkhjqfqjjWojZ36sFJ1ynuXGu4pW5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095650; c=relaxed/simple;
	bh=iBkG4+zAwhk26ShbCL5udFHUhJ7WGnxzNbq5nCIqSjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKaOlLFBDrmuaYR3Z7f34TSLNrt3xBAdv+5G7HJw10/lA2cIIEiEzXnSz5EVe122vjM6wU25qzzCnjLAyPz/Vo/ID7Gu1ASkwsySOoPo3yBveKbnOPYGotFVSLLqz/E65YW7wJLG6fKsZiAuqP9MQ7icDpd8M2+LMxui+MzVIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQWT4P5/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729095648; x=1760631648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBkG4+zAwhk26ShbCL5udFHUhJ7WGnxzNbq5nCIqSjQ=;
  b=LQWT4P5/9IpEfzY7z9+xulDkvb5u1hjLbWRAdr0kqIyyqMHRpK74ptim
   1+hiW5F4UDcFrnsqfNYU2hYKf4wXHRjn5QveDD4+s2bg+vuLjiAxcGUHB
   eJ+AwWDLfyX/2wsAztNTx+AXnGBH0AsNluoVePcMf/9GV24i06mn0eLbb
   ITMOVaqPO00UzKHkgMvBi8YfhS3LJBX6cQrEnNIImCb78zRZYHmBB59gX
   kbdNBv3S5P4BR5WVmmocFcvtIz0so2Hqs+MbwLkwhwaZD6HlMVSPb8f/r
   zYqbR+my+EDqlFgqNBcfHnv6rgBh8FfJ6fClVT9g1lWbhcnVow2YEaUYj
   w==;
X-CSE-ConnectionGUID: PhxFML/oRjiabWURddzZow==
X-CSE-MsgGUID: bIuBMRPSQ6quaMI9NBCwPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31417651"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="31417651"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:20:48 -0700
X-CSE-ConnectionGUID: iWijfoktTwqzQUYgRI8Fow==
X-CSE-MsgGUID: ys1v6TV/TkqZRpG2+Vhn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="83355392"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:20:48 -0700
Date: Wed, 16 Oct 2024 09:20:46 -0700
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
Subject: Re: [PATCH v5 11/40] x86/resctrl: Export resctrl fs's init function
Message-ID: <Zw_n3kpOGuGxRFrX@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-12-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-12-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:18PM +0000, James Morse wrote:
> rdtgroup_init() needs exporting so that arch code can call it once
                        ^^^^^^^^^
> it lives in core code. As this is one of the few functions exported,
> rename it to have "resctrl" in the name. The same goes for the exit
> call.
> 
> Rename x86's arch code init functions for RDT to have an arch
> prefix to make it clear these are part of the architecture code.

You aren't "exporting" these symbols in the Linux sense (as you
point out elsewhere in the series resctrl can't be built as a
module because the kernfs routines are not exported.

Maybe this commit description should just say it renames functions
to make it clear which are on the filesystem side of the boundary
and which are arch specific code?

-Tony

