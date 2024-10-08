Return-Path: <linux-kernel+bounces-356058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D2995B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893D91F25BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CA21790B;
	Tue,  8 Oct 2024 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIztn8PS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D41E0B8C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429861; cv=none; b=CBJXGervQo11mnMr01UyRhpoKXDbNnG1hUOP9KWsG/x149ovcSJRD9hifQd9VjuEnQLn7GLpeIkl8M7Y+bkqvLaW0uRtHKN1JNF6lEZebMBqWoqnQW5AmDX59hVhEkeeOWY85hxRje8W7omtIHMHGjQvqQsdC5G6i7lg488fr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429861; c=relaxed/simple;
	bh=tWQr383OqzVLsUxLEpjf1l87yFti1TD5JN6yMYbxfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJMJoVAONqyo3aSY+XGDlOH776lSc9KK4X1rVXVBY+58KFdVk9S3aOuj2krkft2Ehz4wxzOhy33R5SFMFsT8tZr9C/sxzIR2VqA5Fg79YqVHVXBJD9d0w8pYuKkwZRiBDMax2QGOwYzpKqmcV9AJ+qcYIdXU0PrvruFRPBoQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIztn8PS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728429860; x=1759965860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tWQr383OqzVLsUxLEpjf1l87yFti1TD5JN6yMYbxfCM=;
  b=hIztn8PSg0MlkNHL4iYDvIUGTq9eR+e2UISgkY4+sWzNbjAcOEiMhS4g
   uw2ochLqiSLtzLfGVxwd51GydVrxIYRD2xJjvlxxZkez26Q+T4uVeHIdW
   e9prgp6zGamNFR/iQErVr/TeIELgm+7WUGTrvFgo6m144wpu9FSDLgXnM
   HX+WKP8BsafRJMewVJlyK8SZMZPLmAETZzidqXwhWUUyblOQtHPqms6Dv
   7tdod6YBaoRYuZfJks56nK83uVjV3tNZsrYd2FA6VWX+2XsUAVQyK0Geu
   sWao5Uk1uIbt7cRqp+AC6YeE5ew7rWVlMa3T1RaGBSY8DjogdipMtj9Ba
   A==;
X-CSE-ConnectionGUID: 4QthEqG8Tk2gv2hYPIiwVA==
X-CSE-MsgGUID: GWN+FDawTp6UwhPIlFGoqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45207287"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="45207287"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:24:18 -0700
X-CSE-ConnectionGUID: PPAeAFP5QmuHGNm0lRn3lg==
X-CSE-MsgGUID: oCpZqBRbQfOmVWh+c2GsHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="80506210"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:24:18 -0700
Date: Tue, 8 Oct 2024 16:24:16 -0700
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
	Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZwW_IAggzU2T-lml@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:07PM +0000, James Morse wrote:
> Changes since v4?:
>  * Dropped the percentage/mbps distinction, this can be future cleanup as I
>    think the difference matters to user-space. These are both treated as a
>    'range'.
>  * Picked a pre-requisite cleanup patch from Christophe to make merging
>    easier.
>  * More of the __init/__exit stuff has consolodated in the patch that removes
>    them from filesystem code.
>  Regardless, changes are noted on each patch.
> 
> ~
> 
> This is the final series that allows other architectures to implement resctrl.
> The final patch to move the code has been omited, but can be generated using
> the python script at the end of the series.
> The final move is a bit of a monster. I don't expect that to get merged as part
> of this series - we should wait for it to make less impact on other series.

I've been playing around with this series (after running the python
script to get the full effect of where the code is headed).

Things seem to look pretty good. I haven't noticed anything failing
(but I haven't done extensive testing).

I've skimmed over the patches and posted some nitpicks on a couple
of them. I'll try to find time to make a proper review pass.

Just to see whether I still understand the new layout I took my
patches for mba_MBps[1] and applied them on top of all of this.
The process was pretty simple, most functions that were changed
just moved to fs/resctrl. Just a few places where I needed to
tweak things to fit on top of the changes (like using the
new resctrl_arch_get_resource() to lookup rdt_resources
instead of indexing into the rdt_resources_all[] array,
of function names changed to add "_arch").

Overall it looks pretty good.

-Tony

[1] https://lore.kernel.org/all/20241003191228.67541-1-tony.luck@intel.com/

