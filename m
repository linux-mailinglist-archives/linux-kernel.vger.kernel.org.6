Return-Path: <linux-kernel+bounces-400619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C329C101A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF641C22B62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C92217F51;
	Thu,  7 Nov 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMyc/ZeE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB6322E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012670; cv=none; b=nWby22mvlb+DnLxZVydN0LVe2uvNaZmEy4M0IjnxsY+9qozHDIil5ot+R3Of8FViGVh8vb9yyje4+uYH0aWg14e9P1xCXRiU9ta/TmL+H4D5lU6fIZRadESjVzkWHwt9KyU3kuiKLLHfGGr2Lxg8N5AJUjM/+gAf8KhZZSSbrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012670; c=relaxed/simple;
	bh=kRJoVTUXG8G70ybxoGzz0nR4dujFkNavSr4lZrNY1Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqEqzU2ceAo/ulA5xLIiOZmcUcyiDGTi3NGbIFO8iUT/r32GdaoBtBOqqBpYUaPanU83vd9WiUX7juM4sIc1d836fIWIy1GdWIvI4wVdsRABuT1sT4DTNF4eRv5lKm4RNtNsf3J/DKjTX4HZ0Pp6/KbFZV0t+KJ1mok36iOM2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMyc/ZeE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731012668; x=1762548668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kRJoVTUXG8G70ybxoGzz0nR4dujFkNavSr4lZrNY1Mc=;
  b=LMyc/ZeEgOsx/ZQywFbMTyZM16WQeroLZm6eCKTplTI3LAy2hdPFSvNV
   +gJNMdXimDDNXdJWo26FfZEOMbVgRnNf/gqTOC9SJiTn6DLAym8j1oI/Q
   xRfi4KnsIDBpXrMmVBR/jVTBSALnFcocVvf80kWxw5RrvcskZbnYSi87P
   mTitPx9BXSK0vS6K4MfaQI4OIn5KfvhMVQbjBk9fxqhhgLXQ0kSYhRISq
   Fz6topu/+z3iCzrtomWsuESHG1OcdLTBjxmtjeoBH1nY2uSPs6JUY2MtU
   b0FzgWX/EBg5zQi0SuYKaf0q9hNsQZFjshWHg4rMrNXSTvMr0Qd13Xsdi
   w==;
X-CSE-ConnectionGUID: GpjowHO+Qdau+JCpfMTWCw==
X-CSE-MsgGUID: Iu4H+nD1SauCiyX/eLQrJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48338389"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48338389"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:51:07 -0800
X-CSE-ConnectionGUID: 65PJcFZTTqGbJq5cmtxBQw==
X-CSE-MsgGUID: AzpKdEemS+WHpf4/TEmQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85383636"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.222.202]) ([10.124.222.202])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:51:07 -0800
Message-ID: <05745387-d391-4709-8bd8-6d82650e052f@intel.com>
Date: Thu, 7 Nov 2024 12:51:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, andrew.cooper3@citrix.com
References: <20240916181000.416513-1-xin@zytor.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240916181000.416513-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/24 11:10, Xin Li (Intel) wrote:
> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
> 
> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
> is left set, because the CPU IBT will be set in the WFE state upon
> completion of the following ERETS instruction and then the CPU will
> resume from the instruction that just caused the previous #CP.
> 
> Clear WFE to avoid dead looping in missing-ENDBRANCH #CPs.
> 
> Describe the IBT story in the comment of ibt_clear_fred_wfe() using
> Andrew Cooper's write-up.

I should have responded to this earlier.  I do see why Andrew thought my
earlier description was off base.  Let me see if I can try for a better
changelog:

The kernel can enable Indirect Branch Tracking (IBT) for itself.
Hardware generates a #CP exception if a kernel indirect branch lands
somewhere other than an ENDBR instruction.  The kernel #CP handler then
decides if the it should warn or do a fatal BUG().

The BUG() case works fine with or without FRED.  But the warning mode is
broken with FRED.

In short, the pre-FRED architecture clobbers the kernel IBT state of an
interrupted context.  That includes clobbering the state of IBT when the
#CP went off, suppressing future #CP's.  This is bad architecture, but
handy for a #CP handler that wants to suppress those future #CP's.

FRED, on the other hand, provides space on the entry stack (in an
expanded CS area) to save and restore IBT state. Since the hardware
doesn't clobber the IBT state, software must do it instead.

Aside:
	Why does without-FRED case work? There is only one CET WFE bit
	per privilege level.  The #CP handler itself has an ENDBR
	instruction.  That ENDBR clears WFE on the way to handling the
	#CP. Consider what would happen if a kernel indirect call landed
	on an XOR instead of an ENDBR:

	  CALL (*%rax)  // sets WFE
	  XOR %rax,%rax // uh oh, not an ENDBR
	  #CP
	  ENDBR	// first instruction in CP handler, clears WFE
	  ... handle #CP here
	  IRET
	  XOR %rax,%rax // No problem, WFE still clear!

	See? The handler clears WFE and lets the XOR run.

--

Is that a more complete (and accurate) story for folks?

