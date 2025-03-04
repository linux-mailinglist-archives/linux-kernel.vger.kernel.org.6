Return-Path: <linux-kernel+bounces-545501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6879A4EDED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C66F3A8740
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100A25A334;
	Tue,  4 Mar 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRf3wzU/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E8189F5C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118121; cv=none; b=Bzop+rGBoDBG5Eim4+/N6Q2nttIYYAHY9PVmPOKafMmdIgmJiS4z4krNBy0QGhaNOhHRVodQ7k6MpSNvVmKHy7DYC6vfPAQRsWJ15h3RMClnUARzbeG2TBqvPOmfUl4DqxYckIf8aA2qsWU/Ei9ZXkPOmEZEQTqbiSYzOyF0Jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118121; c=relaxed/simple;
	bh=nRlQMQIfDvAI6b8+m0o68n9PK7KqytnFSAtRsiy6rkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SA7TwLCMloy8JOX+k3BjepuQ7eywVNSQCus/4DAs3DZGM4Hcp9cKQd0x88LH1j/xCeGUlbLdLwDBdYzg8K/c3w4oOEHgpiL6fBDCZdVnkv32tbI/TYRj0cXjPbMS2hMXW5hQGwAzrXoQ99PO1Ej1lJVJYVjKvw4yRDZJLpGLMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRf3wzU/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741118120; x=1772654120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nRlQMQIfDvAI6b8+m0o68n9PK7KqytnFSAtRsiy6rkA=;
  b=jRf3wzU/QRtbXzxPm68V+vgpMrINwiUHURkWzvmsVKNz7iJesURUhAwy
   CFvlHWGy5spRsBuzOaEYk5UrJ9Sdeo625RAWk8jxlX5q5//IBEurJj80B
   IcscPvDHLuxoJaq2jflPqI5yOp3YPF+lYvpmaaY6+pdr5jRQCwGYO+Ac2
   LENQtSrMEDLfpl+XTTcIoEyoEyUhbGLtQ8ANXrydaqfc1jLVicwv22Fpm
   x9dnJgPTFLwYzRBH6kBxgBLyEE2Jf6IEq1HogGxFHE2pNztgzRiblNueh
   ADMf7SF4SoP1U2U6wjZ/3n0bfVZEzlJY4BPu+XO9m9JzSuCVlCgWVHlHd
   g==;
X-CSE-ConnectionGUID: hDLlND3nSs6abHg+fdCO3Q==
X-CSE-MsgGUID: khlG7BakTLOUyqjl/nv+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53043661"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53043661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:55:20 -0800
X-CSE-ConnectionGUID: znH4F/z3RcmuXKXIsUSdXA==
X-CSE-MsgGUID: fWNTE6UMQ4O1jkpUUXuOZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123591139"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.222.110]) ([10.124.222.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:55:18 -0800
Message-ID: <b4f7090b-3f16-4541-bd8d-d7a2f22ba164@linux.intel.com>
Date: Tue, 4 Mar 2025 11:55:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
References: <20250304143340.928503-1-arnd@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250304143340.928503-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/4/25 6:33 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When extra warnings are enabled, the cc_mask definition in asm/coco.h
> causes a build failure with gcc:
>
> arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
>     28 | static const u64 cc_mask = 0;
>
> Mark this one as __maybe_unused.
>
> Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
>   arch/x86/include/asm/coco.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index aa6c8f8ca958..9e9204cfca6f 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -25,7 +25,7 @@ u64 cc_mkdec(u64 val);
>   void cc_random_init(void);
>   #else
>   #define cc_vendor (CC_VENDOR_NONE)
> -static const u64 cc_mask = 0;
> +static const __maybe_unused u64 cc_mask = 0;
>   
>   static inline u64 cc_mkenc(u64 val)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


