Return-Path: <linux-kernel+bounces-421859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AC9D9102
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19437282547
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFE42AA2;
	Tue, 26 Nov 2024 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLyfyMUb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A210E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595127; cv=none; b=J/DNKQCF2u/ZxrFT+3inUebd3V6Qal2mskgfPtGkC4wruKMwApI4JOPx+i8ZNTOWkm6FEOfFHQKxECeFx6qCXPQBrkG91kbtCown0W/AfQ58L0yNMLi4iOWosJpn0Tmj0/K2xN1l+wo4d1Bjx0pHuB1xu4+ewNd80RBUg0k5l5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595127; c=relaxed/simple;
	bh=hJe1oyqLJsL9uK91I1zXI7O5UVM5DjcsmNtdSXIrogg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfmPQ7wHE6Jug1AMvr7vloG6svvzdyPcB/byJCcOybFYoub58F8NMLcdFeV69+qNxSidnluXzti0Ze4XtKrUa8B7a5yfcYYeLzqWefnlwwtZW8lMSuSnjhMG7p8Cxp4lioSX7GvHyNVpRaGjoRGDmPKZCAYU+tv2qYu6qChzj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLyfyMUb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732595125; x=1764131125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hJe1oyqLJsL9uK91I1zXI7O5UVM5DjcsmNtdSXIrogg=;
  b=MLyfyMUbIdBAl/rLWK2QQIlVPlncC9Rm57XtXY84mAhi2edGwqnSekld
   q2JU6X06Ko0xf+kyNohAo/aB7b3Cmtgx+9cejHyocIZSCpH11bE7Q/lVf
   lYProGTtC5MOVBwwys4wCZ9C9GV+4qhpe6ajBSn6TsqfApRW0ky5Ay6Wz
   KAegFRWplFqv6sxtE9EVeIeX84CJ9y2Am2Yq3sKOFhNDzf+i52MdVX5qk
   3XYvfa2lEiLG/YgrZTYKJzvK0tiGxnOXywGs0+zgwWmJXbmqGN6mVkW8O
   CpA7HT/xXS79qNHg1tbaOAVPN0sRDZIA/+BahFZsHXfqpAoIe4ZE0oYf4
   Q==;
X-CSE-ConnectionGUID: Ro4yQiMETOOD3qkts7/xFA==
X-CSE-MsgGUID: wCL0Yt/9SqilboeFBik3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32476590"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="32476590"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 20:25:25 -0800
X-CSE-ConnectionGUID: sBjWIBC9Qk6JLBxx23t7AQ==
X-CSE-MsgGUID: KCvK5p7DRamHS1xdWxmjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="91378855"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa010.jf.intel.com with ESMTP; 25 Nov 2024 20:25:23 -0800
Date: Tue, 26 Nov 2024 12:43:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 09/11] x86/fpu: Move CPUID leaf definitions to common code
Message-ID: <Z0VR8xqYgC0sGUiN@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195339.6BC10FDE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195339.6BC10FDE@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:39AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:39 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 09/11] x86/fpu: Move CPUID leaf definitions to common code
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Move the XSAVE-related CPUID leaf definitions to common code.  Then,
> use the new definition to remove the last magic number from the CPUID
> level dependency table.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/include/asm/cpuid.h      |    2 ++
>  b/arch/x86/include/asm/fpu/xstate.h |    4 ----
>  b/arch/x86/kernel/cpu/common.c      |    2 +-
>  b/arch/x86/kernel/fpu/xstate.c      |    1 +
>  4 files changed, 4 insertions(+), 5 deletions(-)
 
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


