Return-Path: <linux-kernel+bounces-421851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD749D90EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ACA28916D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7F12C530;
	Tue, 26 Nov 2024 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Au7uwZyn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053B46B5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593935; cv=none; b=ebR+D/M9QT6G6r8qjMZUk6cUapwLKtYZ6wxMuuM4AGOwDKGheu6Y4MFs7cKlH0mKB7N/apuDz1oNtOxsoalR035+6KBli1x7O6qvG5dpefkK8Yqkg6t+dMeUgi90AEFxm7vAnxarEQLHWhPERZdmiQFQL6qeeb6EDo7MbbiGhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593935; c=relaxed/simple;
	bh=9Ioky8h5RaX3oG5t9KKsk+qxjhyYHEcyDnaNB9Jvh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XADbCytUxoLpKppgAEWuHRtwGsG5D2++L/iiCqTkB0ldiEZH3HoEy+Ijz1QJnCdYNL9UrFIbkV6wqVrhLSaLoMRn6O1bLGzHDtNhu31gtMjT8rndSJkUdzlDFusN36Pis4lrNlqzrKauLKes5a8D3AHHjt4dGzox70puCcKJ2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Au7uwZyn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732593934; x=1764129934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ioky8h5RaX3oG5t9KKsk+qxjhyYHEcyDnaNB9Jvh10=;
  b=Au7uwZynPzznqmX5ty6DGu62OcjXPoTNuB6D8JdOAlztQLtNMVo/88cD
   773Aab7cXmqcUiw0sREUkWWEN/ZenrPsJdIBqERmRwr/skZZXxrKYbfib
   WinwonaYFTIByQyRjMgpD8Xj7BAwk/Xfjps87XurXFKOemVtQNwLmBKyP
   wgHSXLFS+J0ZxO+oyfFF1w8FQKq9F7HRJaR3LinR3SB+LREUhjv75XX5x
   ji5Ma/NkyvrXG7Y7aZDzkmxE1X8b5wV4mvn+628T7AKWUTS7KOZ+etSsq
   Ntledg5Szy2trDiTcv59AawMm2MhdL914pC3Gz0gypuUxTFsLPuw+Hdek
   w==;
X-CSE-ConnectionGUID: RSgfhJC/RXSAt8p/7wSNbQ==
X-CSE-MsgGUID: VwiVQQA1SnG9SP8LTPnUMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="58141085"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="58141085"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 20:05:33 -0800
X-CSE-ConnectionGUID: 4pegDikEQ/qRuKHULf96pQ==
X-CSE-MsgGUID: IEu/n8W+REK+WD1aQPhvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96541776"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2024 20:05:31 -0800
Date: Tue, 26 Nov 2024 12:23:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 06/11] x86/cpu: Move TSC CPUID leaf definition
Message-ID: <Z0VNS0MP1bTafUFu@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195335.91B979C8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195335.91B979C8@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:35AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:35 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 06/11] x86/cpu: Move TSC CPUID leaf definition
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Prepare to use the TSC CPUID leaf definition more widely by moving
> it to the common header.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/events/intel/pt.c   |    1 +
>  b/arch/x86/events/intel/pt.h   |    3 ---
>  b/arch/x86/include/asm/cpuid.h |    1 +
>  3 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


