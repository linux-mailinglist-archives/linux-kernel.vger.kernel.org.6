Return-Path: <linux-kernel+bounces-346619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF94798C6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DC0284F58
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E731CEE98;
	Tue,  1 Oct 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izZf7gsR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECA1CEAB7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814157; cv=none; b=UulBDx2gd51ta0oakoQPvuXLATOMxdKlRV/OAMaHtISKw0qI5URsmWK5KmZVNFldSdb6p6Xvoiy5oISdx8/ELH4HP+Sk3uYQzduVN7mow+HlNoyk7iu9STsyuV+nIQPSzQIP5+/m6sL/5VJhKRH6o53ESm0RWHzcWXFE4yNARQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814157; c=relaxed/simple;
	bh=cp6eECymFkBcdg0cbtfsd4FTDZW2nSjZfeaEGc9nT8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfMxM1fIz9X3DTBp7AlbvjlgOlfcY6nAmWbM6uAMdHlEsLqf5CGOQnCm22rTN2VrQzUjqE10QvUBHNmndzop3MdanGX5QLCBgsv9Li+qIZ7hdE1qS9eMUnYVRqF7QCauN1taqMXG2WEO/N2gQKrX3cAEYPOE0w4yzJfOKUGpJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izZf7gsR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727814156; x=1759350156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cp6eECymFkBcdg0cbtfsd4FTDZW2nSjZfeaEGc9nT8U=;
  b=izZf7gsRdqM01am3xbOROyiN19jsp0Ol+mK4r6oiVKDTF6t7cPokwsxK
   ELM5MhtEnyWMBhBMlsMtLCNOixIZi4bx0e4q/Zg0IClUpFkrxigbwsk5t
   p3fHtu7SETeTgZYO1khrREm0e7QdIb69uJTObJSLw5ZRv0yIIbcPW6FBF
   kx+VDP7X8e40CRCBeexZw+m7WVBEgUUPNV0yCLJXqakWkP3G6Az5ix9YZ
   FkceDebJPL358MuiLCTgCZDLCFhi5eoTekqBW1AF4pgo2hnEPIP7juW3r
   fkxTXFIWYzx7UbM89BrzMdNpOmn3IMt/xUuYIHP5ltvZO9jAdrh3lQbRy
   Q==;
X-CSE-ConnectionGUID: 1xVvJ+eDRrOOZFlHuy2kOg==
X-CSE-MsgGUID: QiZIzRx1Ra6r5Tt5z9kGxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38354706"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="38354706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:22:35 -0700
X-CSE-ConnectionGUID: suubo0eVRyy803GSguwsJQ==
X-CSE-MsgGUID: MvrGYteTRIy27PROzQ8AJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73903032"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:22:34 -0700
Date: Tue, 1 Oct 2024 13:22:33 -0700
From: Tony Luck <tony.luck@intel.com>
To: Martin Kletzander <nert.pinx@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
Message-ID: <ZvxaCamN7FP-TX2s@agluck-desk3.sc.intel.com>
References: <a8c3ef3e3d35924781280064a9f8c7dd2ee60565.1727782826.git.nert.pinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c3ef3e3d35924781280064a9f8c7dd2ee60565.1727782826.git.nert.pinx@gmail.com>

On Tue, Oct 01, 2024 at 01:43:56PM +0200, Martin Kletzander wrote:
> The resctrl schemata file supports specifying memory bandwidth
> associated with the Memory Bandwidth Allocation (MBA) feature
> via a percentage (this is the default) or bandwidth in MiBps
> (when resctrl is mounted with the "mba_MBps" option). The allowed
> range for the bandwidth percentage is from
> /sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity
> of /sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for
> the MiBps bandwidth is 0 to U32_MAX.
> 
> There are two issues with parsing of MiBps memory bandwidth:
> * The user provided MiBps is mistakenly rounded up to the granularity
>   that is unique to percentage input.
> * The user provided MiBps is parsed using unsigned long (thus accepting
>   values up to ULONG_MAX), and then assigned to u32 that could result in
>   overflow.
> 
> Do not round up the MiBps value and parse user provided bandwidth as
> the u32 it is intended to be. Use the appropriate kstrtou32() that
> can detect out of range values.
> 
> Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
> Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
> Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

