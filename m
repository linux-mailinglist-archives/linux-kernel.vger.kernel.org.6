Return-Path: <linux-kernel+bounces-273905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ACF946F6D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA2E281764
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830C59167;
	Sun,  4 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T43VDoyP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404F57CA6
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783402; cv=none; b=KPiKKDQqY2X3q97OxQIt0YockYpE0o6s8VgcoqyQ2ex14RdcvwaGZDER3kt4OJolcQtHN638DWHRg0dHBd0x0nSdppMisFO7aMsQ+VNaUJdGU7cSzfmIKsgEumeEBkesnWpucpTLCkUbXIpVRfM/fuxo74n2NqYsagpWdu1u0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783402; c=relaxed/simple;
	bh=pqNVMKXgkc3C6ADBvsuOOyJ5OixvbI+jYWwSfZ8Fg5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r1Q2BVmm92xLP3W0VIB16e1YZVFAWxGW6m/07V6mk8rUrDowWnKmXDwtNC7AQf12ddq7kWlb8birFBq8zQdfW8a+q2hO9cqojh53rjhZBdDPwiaSUGweL7bH6o0OiiwBweW5xATq81v1bVe6nd9bkPC4QOJZXPhIAGtRAzY8eh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T43VDoyP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722783400; x=1754319400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pqNVMKXgkc3C6ADBvsuOOyJ5OixvbI+jYWwSfZ8Fg5k=;
  b=T43VDoyP6QlF0F1wAyOmwHeLh+RD7xwyJGURaJq93SWAG3oslFmHlt1m
   BTOhajObU/M//qWmsGMi5fI5nIWEnnA32p4lipOB06Gu0ioNJPIFT4sQl
   S7fYpbGtsIwgEOZmypZ8KQCwUf1KrH8WH62u22pdNE4QG866XkYxuVm2K
   ITAnG5oawS+lSe+11a/YItYXXHdkDFwLCLUXaJqF07pu/49SA0Mr3RMSU
   jj/zPewtssdaDPL/yBP/HqDn6sgcJVEgP2IFc5fVDbe4UUFNX+KTP6STI
   fVgZ0+XE84buq29+NEApCxYc8PWX3xWsoudySsg3gZQI7vUs7iHOf3mhG
   g==;
X-CSE-ConnectionGUID: B3YffABrTVqnhVKSor21dg==
X-CSE-MsgGUID: i8PMBvdIQbe7nGMg4AgFdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20559510"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="20559510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 07:56:40 -0700
X-CSE-ConnectionGUID: HAnVlvnPQv2tjec77oUx/A==
X-CSE-MsgGUID: 9ZsKvrYrSZaaM1kHYF+EEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="60053172"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 07:56:38 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	qiuxu.zhuo@intel.com
Subject: Re: [patch 09/15] x86/mpparse: Cleanup apic_printk()s
Date: Sun,  4 Aug 2024 22:45:05 +0800
Message-Id: <20240804144505.25607-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240802155440.779537108@linutronix.de>
References: <20240802155440.779537108@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> [...]
> Subject: [patch 09/15] x86/mpparse: Cleanup apic_printk()s
> 
> Use the new apic_pr_verbose() helper.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/mpparse.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> [...]
> @@ -560,7 +560,7 @@ static int __init smp_scan_config(unsign
>  	struct mpf_intel *mpf;
>  	int ret = 0;
>  
> -	apic_printk(APIC_VERBOSE, "Scan for SMP in [mem %#010lx-%#010lx]\n",
> +	apic_pr_verbose("Scan for SMP in [mem %#010lx-%#010lx]\n",
>  		    base, base + length - 1);

Align the open parenthesis.

