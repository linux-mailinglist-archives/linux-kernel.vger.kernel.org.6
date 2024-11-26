Return-Path: <linux-kernel+bounces-421829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C999E9D90A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE96286F58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA70433AD;
	Tue, 26 Nov 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYEyTPPT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2C27735
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590360; cv=none; b=AiIxMRMknZLLwJDsxjg5jVCn97CGQGVZ9f6wY//vSurR3vcHBOsivW5aoR2fcr8GwVXVZ7Kjvztew8wBDKeTLPZCGBF/BkuFGs1FZ3aJzphvSWIBOrlxjUaFnP+Oi4Kz7fJqE97I6BtKZYhwA4gSkU9OTleKy2BOEe8qo+6GFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590360; c=relaxed/simple;
	bh=DsCFz8XoXAvhqPENyzKQF0ndJQTmjAZPWAc4WNaCERg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaVn3i6fwTz7hBEkk+B10wi6qHmndbevzLWANDTroO/97Ghu6pTQyvPl4+71te3BiTFTFIWcEQuvm2++WpNfRgWncJBZlfiGoa4BGdBKHJ4tk2R3J7YqW892xJTcPOp6PpcHIbPfsWmv5nhXy9vdUlbaigABALMSHmz5ruRhqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYEyTPPT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732590359; x=1764126359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DsCFz8XoXAvhqPENyzKQF0ndJQTmjAZPWAc4WNaCERg=;
  b=HYEyTPPTlE03g862j9NbxGMaUYhGMUTnXWC2JQUS3wDUFwnll9BRVLM3
   xZZNp5PTAYVZvzvqoMdbGUa6opPYabMVEjl3MhR9jExxxaSJCz4U1NOKm
   Ut51e7SjlrUyHYfuv+NUB/qLE0Yow7q8sDyItLaj65uV7FPPxBAFUBJu0
   K6EqdDdqBCue9Qa0wBKm0qDJegnSQ312MbjApmnvJMaEKqKPXP89Apnur
   WaY8rKy6ilXnAXgRFVhMvX6Gc6pOXrDDdsGdTydcG82xJeOESrkMrQvx7
   4rKdIkkFCj1AivuoIJ8uUHobpCeeD45xOioc8SyrYGrTyOR6ftajYUJ8d
   A==;
X-CSE-ConnectionGUID: C8/9l859S0WkPkCkPi2kWw==
X-CSE-MsgGUID: LTJpPu6jRF6UCyQfF4kqgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36514951"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="36514951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 19:05:58 -0800
X-CSE-ConnectionGUID: NavKi4/uRuajw1tnH6RCTA==
X-CSE-MsgGUID: 9IEU1xGaSvKWa8TKEPGGDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="92281736"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa008.jf.intel.com with ESMTP; 25 Nov 2024 19:05:56 -0800
Date: Tue, 26 Nov 2024 11:24:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 02/11] x86/cpu: Use MWAIT leaf definition
Message-ID: <Z0U/VC2uyC1zcBjZ@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195329.25931E2D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195329.25931E2D@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:30AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:30 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 02/11] x86/cpu: Use MWAIT leaf definition
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The leaf-to-feature dependency array uses hard-coded leaf numbers.
> Use the new common header definition for the MWAIT leaf.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/kernel/cpu/common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1 arch/x86/kernel/cpu/common.c
> --- a/arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1	2024-11-20 11:44:16.169610481 -0800
> +++ b/arch/x86/kernel/cpu/common.c	2024-11-20 11:44:16.169610481 -0800
> @@ -29,6 +29,7 @@

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


