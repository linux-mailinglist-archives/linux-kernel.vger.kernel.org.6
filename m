Return-Path: <linux-kernel+bounces-537526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0948A48CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C781C3B681D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777122E410;
	Thu, 27 Feb 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5dHJCBS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941372C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700488; cv=none; b=aLLSPYBCrdK2AYpJGrNKlGyua4DZrI5SoUuOw3rLaTpeD3EyQ2zYt6tkYU1u2sDqHbmCUa24YMJoe1kvE5+8QmwPmurk4epFUdt6bjfwIjScqfQ2far2Q8JWQsDrT9iO2A2cF+tm7r+8bfUk7S9f0kNDnSphnIxSx9cjOGFLK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700488; c=relaxed/simple;
	bh=ZuRY4AZ42lYucTwqvZhIz+dHNeznVu/o9CZn731z3b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYLtkefr4Z0V3bhvpRLeFMfTQR+NMiFkqOn5yiayQ4l9Q+EhiBeFab0Ha/onDemS/YfwiMasWTeUR3a5kjKQe4cuuEFSlhbZx+i57cYV84asUhey1wrdjXHRsQkzbMa51zxYkM7C9EvIkEISV8FdphpebD+sDIjdYwRVAtOoifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5dHJCBS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740700487; x=1772236487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZuRY4AZ42lYucTwqvZhIz+dHNeznVu/o9CZn731z3b0=;
  b=S5dHJCBSNeFn84GCI022zDuYVnGm3BLRleezEoAeHCnlNyhlGVlnbUi/
   SwmZYex1XtCMqkXGzTJYEbUpiPTe9Rpj3dKJgn6w3Sfuwzu50V9FOt0sW
   mDZdrrsHuF/S6OPEiBIBfRkF8mOLoZfb1A2dogqcvJQcCGLPeBekmZf25
   mN9Wm/zHQlNhadhzOdbjEOW1Tnh6M3gZqVs3cWvlEbhhBGSq+iUiFuQaf
   NAmjfG7TxBX0DoWBVaXkjOGSTY5FLupsn4RF6GnXBzRDjpTxVMnR7THc2
   w0dYbGm5+wM4t86fUcAWqMZ0/7uUsb0OLk+Nu6MqxkhbbfU5wAc8dI2+/
   w==;
X-CSE-ConnectionGUID: MVRUjb2cQ7SURsYHC52EZA==
X-CSE-MsgGUID: ZJNQd+ofTqK8bXdjZcj5Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41744778"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41744778"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:54:46 -0800
X-CSE-ConnectionGUID: m0Fl0/XXTiKgdfyuz/k58g==
X-CSE-MsgGUID: Ji+0V7DRQK2VQqOYZ/pKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154361872"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:54:46 -0800
Message-ID: <d1b46250-793e-41a5-9b65-95ed6312bc4a@intel.com>
Date: Thu, 27 Feb 2025 15:54:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Ingo Molnar <mingo@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com> <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
 <Z8C-xa7WB1kWoxqx@gmail.com> <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>
 <Z8DE0K2EEDe1dQdh@gmail.com> <4c71fc86-2d70-4d50-b041-d6ef8c1baf4c@intel.com>
 <Z8DLKj8qdLb7MllO@gmail.com> <1fb9325e-4430-4ac8-956f-c5255c9c9971@intel.com>
 <Z8DbEqXaxEB_4wmI@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <Z8DbEqXaxEB_4wmI@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 13:37, Ingo Molnar wrote:
...
>> Like I showed in my earlier example, the CPU enumerates which XSAVE
>> features are available. These enumeration bits in CPUID leaf 0xd *ARE*
>> set at boot independent of any other enabling or enumeration. In this
>> regard, XSAVE enumeration is quite independent of the other parts of the
>> ISA. This could, in theory, be changed to become dependent on some kind
>> of APX enabling. But that would be novel for an XSAVE feature.
> 
> Yeah. That would be novel for an XSAVE feature - but so is the change 
> in ordering. With my proposal we'd avoid the 
> xfeature_noncompact_order[] indirection table AFAICS.

Yeah, so with your proposal, we could toss out most of this series, so
roughly 100 lines of code.

The downsides are:

 1. It can still confuse userspace, arguably in an architecture
    violating manner because the SDM says: "If XCR0[4:3] is 11b, the
    XSAVE feature set can be used to manage MPX state and software can
    execute Intel MPX instructions." (this would be for userspace)
   1a. Userspace like GDB still needs code to disambiguate XCR0[3:4]
 2. It would add complexity in the XSAVE enumeration microcode. CPUID
    data that comes right out of a ROM today would need to check some
    CPU enabling state and change the enumeration.
 3. Linux would still need to go fix up KVM in the kernel, like:
    https://hansen.beer/~dave/intel/mpxapx.patch . Every APX-enabling
    VMM would need something similar.

KVM folks, would you have any issues if XCR0[3:4] (the old MPX bits) got
used for this new APX feature? You'd basically need to add code to make
sure that XCR0[3:4]==0x3 don't imply MPX support, but _could_ imply APX
support instead, paired with another bit of enabling.

Looking back at Chang's series, I think there's ~40 lines of code
related to xfeature_noncompact_order[]. We'd need something like:

	https://hansen.beer/~dave/intel/mpxapx.patch

and, honestly, just hacking that together, I really dislike the idea of
reusing bits. Even little things like this hunk:

-       "MPX bounds registers",
-       "MPX CSR",
+       "MPX bounds registers or some APX registers",
+       "MPX CSR or some other APX registers",

look really funky. So, we'd need some MSR bit twiddling, some KVM fixups
and special casing of the xsave_cpuid_features[] checks. We'd save, at
most, ~20 lines of code.

Honestly, that 40 lines of code is looking pretty good.

