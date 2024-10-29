Return-Path: <linux-kernel+bounces-387120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE89B4C33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595831F23EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF90206E79;
	Tue, 29 Oct 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brlEQOHR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A811361;
	Tue, 29 Oct 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212547; cv=none; b=l2b/pkaD/tVLHG1U1S7QH/lCOvP8fXzgMbkF6WpJPiQW/ZFqpPnmu+FEFzlfKKXNLbzsemE57RwdgqnkbVD3NyYUT6YHFqrP+Kf1Wz1MtgmoeQKfcx+KDQ2U7lLTqbQpOdA65CTEvmxcsTZU27pDyaaludMvXJarCPp+xz1mlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212547; c=relaxed/simple;
	bh=XQYPCdG//h9n1D5bA82LeVGGe26ya7GVj2pU71BtCuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fthKvggVVJ5doYuw5UzZav/UZgYVy/rQSH9Ug2tLBolte1O8bWYZQc2BZUZZ0UtC3Ynb/VCVuvYk4wJmiAxdziwKfKbZH3W04P2YsfVKl/Bl6Dmxi+VmR6+7eN8x817Ue43X46Ts0oR7gJkwJsWYnG9bMYXoSL9+yQTL38eYNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brlEQOHR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730212546; x=1761748546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XQYPCdG//h9n1D5bA82LeVGGe26ya7GVj2pU71BtCuI=;
  b=brlEQOHRpsY4Zr6BJODsOih+AAxIpv5cUP5E8QjsRMENXmpMk0AIW2Ws
   4nDgLxqbyZgLPLD4ot0FJSowq2zR5C+kXfluf8N+Bm52mDm7M1CgxifRX
   AG4AQV2V2PF5VJOLxr8S2iYWT3rmB8diNozDhFdaYuaLqvvVkczzlQa1u
   gCKOgMAasSzk90qWQP2gvcdjCmJjeZuUUbB9T44UFpLs6hrjAHrsxXotU
   VC04yx+216zaZ+DCsh8XCGQChrF3ODAQVk3AmlfFyfBIe5R27UMkx7BAS
   LqLjcuiiOFNKlrdt6OodwoNQQbaERgWMcbEZwyP88zyhabvM7pryEnHDy
   Q==;
X-CSE-ConnectionGUID: r/Na/m2hRt+alUMZQNDhwA==
X-CSE-MsgGUID: KZwt67MCT3KL/OtH/fNpRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29993232"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29993232"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:35:44 -0700
X-CSE-ConnectionGUID: Uv7NIGJHSs2k4uq1dXl0UA==
X-CSE-MsgGUID: 8NwKKm5WRASyKfHensucGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86593202"
Received: from jerrycli-mobl2.amr.corp.intel.com (HELO [10.125.224.112]) ([10.125.224.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:35:43 -0700
Message-ID: <9ef41b96-8b96-441e-b053-4d7c7d9aa74a@linux.intel.com>
Date: Tue, 29 Oct 2024 07:35:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/bugs: Check VERW mitigations for consistency
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, hpa@zytor.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <3ed45a10e2f7fbecce31d9964b1da1372e8cb838.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113911.GVZyDJX3rg8kh_4kYb@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241029113911.GVZyDJX3rg8kh_4kYb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 04:39, Borislav Petkov wrote:
> On Mon, Oct 28, 2024 at 04:50:34PM -0700, Daniel Sneddon wrote:
>> There are currently 4 mitigations that use VERW: MDS, TAA,
>> MMIO Stale Data, and Register File Data Sampling. Because
>> all 4 use the same mitigation path, if any one of them is
>> enabled, they're all enabled. Normally, this is what is
>> wanted. However, if a user wants to disable the mitigation,
>> this can cause problems. If the user misses disabling even
>> one of these mitigations, then none of them will be
>> disabled. This can cause confusion as the user expects to
>> regain the performance lost to the mitigation but isn't
>> seeing any improvement. Since there are already 4 knobs for
>> controlling it, adding a 5th knob that controls all 4
>> mitigations together would just overcomplicate things.
>> Instead, let the user know their mitigations are out of sync
>> when at least one of these mitigations is disabled but not
>> all 4.
> 
> Please split this commit message into smaller chunks for better readability.
> For example:
> 
>     There are currently 4 mitigations that use VERW: MDS, TAA, MMIO Stale Data,
>     and Register File Data Sampling. Because all 4 use the same mitigation path,
>     if any one of them is enabled, they're all enabled.
>     
>     Normally, this is what is wanted. However, if a user wants to disable the
>     mitigation, this can cause problems. If the user misses disabling even one of
>     these mitigations, then none of them will be disabled.
>     
>     This can cause confusion as the user expects to regain the performance lost to
>     the mitigation but isn't seeing any improvement. Since there are already
>     4 knobs for controlling it, adding a 5th knob that controls all 4 mitigations
>     together would just overcomplicate things.
>     
>     Instead, let the user know their mitigations are out of sync when at least one
>     of these mitigations is disabled but not all 4.
> 
> Thx.
> 

Will do.

