Return-Path: <linux-kernel+bounces-266178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B993FC10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AFC281C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938215EFC8;
	Mon, 29 Jul 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2zW/mfG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88D1DA24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272961; cv=none; b=JiggbQJYi8v3zc/4tzetGnmkrS59xLy7FcAo8RXtb18xreqW94z3GzLtQ2VHoWd6LxWaTCjmhy1A2YMfX8PfFfDI5UTxqL954x6sq5M4wYAiRLXA0P+l9iNWySmi6Z3SOoqV3ZiNiV9Xiig360YU0RWqBbHrBLyWw2975mxiDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272961; c=relaxed/simple;
	bh=93TyKXXtyYESXRq1Ky6CoBioFtI67DJxcopYIhH4Hco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUcR5AqGbTAGCtB/4/RbLqpqA04A62vzaBu35KOFtjCOGym0xsJK2C3fnVC+iEgvHzpMJ/asVqFTUFzad4zbKAH6Qa5rzIj8gmBmzJR1JEdO5vaeYWbsjE8/KI8jZrntTJcqoYyIjDbQCx6xbYpwSob1l1Ltzim58JXWzle7xEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2zW/mfG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722272960; x=1753808960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=93TyKXXtyYESXRq1Ky6CoBioFtI67DJxcopYIhH4Hco=;
  b=F2zW/mfGoK3Yuh40CUGx/MdDRjAywHUWCRpDv47GgWt/UZ3liA6U+WNG
   PukFW3dpXpWbZqFtHB44ADe7jgoaOXi44aiM76VRwkidNg+Lvr0o930xK
   8dvONVZD2GoKFj4OssVbgeaXEIt8vcQq2IOiMWRIv8VN9iOdFCNQS7jbj
   +CypqwP2Jypse+etS0asLeTQ5vyOeKcpngMwFbJGu36ERrVZ0MGQ/Yc1r
   EMg9I8Nl3UHCRmVj6/OP1jhxQEvjmgnthVIGqnxt5kiwXoANB0fnsMjio
   oJcxWMYXyC+Rrp11PR6chPYpsPjJT60CCQ35EQ36qStI8eud1bfQTH27Q
   w==;
X-CSE-ConnectionGUID: rnpI3fqzRRaJRekw6vkYSw==
X-CSE-MsgGUID: nnDOTeIrRfWoeM9ypH038A==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37521457"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="37521457"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:09:19 -0700
X-CSE-ConnectionGUID: 3YV3axWxSBmlZd94GkuKVg==
X-CSE-MsgGUID: 96axKRTSRJicsPz+KrjLKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="84696790"
Received: from refitch-mobl.amr.corp.intel.com (HELO [10.125.162.4]) ([10.125.162.4])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:09:19 -0700
Message-ID: <1d258c8a-b513-47e7-a94d-60263af8f190@linux.intel.com>
Date: Mon, 29 Jul 2024 10:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] x86/bugs: Remove GDS Force Kconfig option
To: Breno Leitao <leitao@debian.org>, bp@alien8.de,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
References: <20240729164105.554296-1-leitao@debian.org>
 <20240729164105.554296-11-leitao@debian.org>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240729164105.554296-11-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 09:40, Breno Leitao wrote:
> Remove the MITIGATION_GDS_FORCE Kconfig option, which aggressively disables
> AVX as a mitigation for Gather Data Sampling (GDS) vulnerabilities. This
> option is not widely used by distros.
> 
> While removing the Kconfig option, retain the runtime configuration
> ability through the `gather_data_sampling=force` kernel parameter. This
> allows users to still enable this aggressive mitigation if needed,
> without baking it into the kernel configuration.
> 
> This change simplifies the kernel configuration while maintaining
> flexibility for runtime mitigation choices.
> 
> Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM. Feel free to add a Reviewed-by from me.


