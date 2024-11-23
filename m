Return-Path: <linux-kernel+bounces-418880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4AA9D66A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1642BB219E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1A17C2;
	Sat, 23 Nov 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+lajtLY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAA195
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320644; cv=none; b=gxAFf08b4yzU8NDk9ubLUBu6PSD0+VCUrdmagIOe7qUxF6iEs52hwX118WoGRJR3JM7k3UUl8/+2J7EEUps1eMcrLZnb69j20rsB85Lo+xsMPFtve53MOoPjMdYeFX4LkfGfZqtXtyqIxaEIT32B2UQNw6XOjt+jhPKK64fEnSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320644; c=relaxed/simple;
	bh=pYYA81g6gIKe22BoyOHssFLTj0HWjJtutYjcYEhXwkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emRuiY3+4INbYU8cuIpP/QaAO2fmNl2FswgIHlrgBFuFf9dYH+NbtdEjxu6Zp/lFU+lKVGES94b3A59FSd/qKemjs9A15xqChKzIFIqX8HY6qnNHpnDRKReZFeblNEr+vK87DjbJmrJc97+ItW2fCwz+QE82lL3FgDxGR33GqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+lajtLY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732320643; x=1763856643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYYA81g6gIKe22BoyOHssFLTj0HWjJtutYjcYEhXwkY=;
  b=X+lajtLYLAgNfoIWt/cjV/8v56XGxzBU8ANQVPeqxGBxlJZ3BYk3AT+U
   ls1XbKytDtwDVoTHrX9cku8BXesMDhLpT97bPwUfG/0vwovv/O0poeQsC
   sXCeUHWsMmr7GrdRTDdcI56eFXEAOm4f/yR/yJScTIVi+OxeAJ8pbQX4b
   oc3AANvUiuyYAvlY0mxaNJWbHdtObal/Ok0AHoVe52lpztDiHIST85hLY
   7GJRHVBsiNSyk4VnANlTOx4qhCb5SGxmXLB0dFVfGe7xaATWgvwbh2a3n
   wDlmZh7OPINh7nLmdWpw3ZgoU1jv9/IIvp0rMEenL8qE7ugh263QhvP0m
   Q==;
X-CSE-ConnectionGUID: SSii2DfrTQW0a/sX0IUmjg==
X-CSE-MsgGUID: Q3A27Wx1QMqpRKodSiPKLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="20078921"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="20078921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:10:42 -0800
X-CSE-ConnectionGUID: PR/IHcSZTpC+jN2T6z0gtQ==
X-CSE-MsgGUID: IJDe6C6PTCuSGt2Cji6W6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90852691"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.110]) ([10.124.220.110])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:10:42 -0800
Message-ID: <cc87a7ae-4022-45fb-9ec9-c75c65d886c1@intel.com>
Date: Fri, 22 Nov 2024 16:10:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU
 is XRSTOR'd correctly
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
 mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com
References: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
 <20241119174520.3987538-3-aruna.ramakrishna@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241119174520.3987538-3-aruna.ramakrishna@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 09:45, Aruna Ramakrishna wrote:
> PKRU value is not XRSTOR'd from the XSAVE area if the corresponding
> XSTATE_BV[i] bit is 0. A wrpkru(0) sets XSTATE_BV[PKRU] to 0 on AMD
> systems, which means the PKRU value updated on the sigframe later on,
> in update_pkru_in_sigframe(), is ignored.
> 
> To make this behavior consistent across Intel and AMD systems, and to
> ensure that the PKRU value updated on the sigframe is always restored
> correctly, explicitly set XSTATE_BV[PKRU] to 1.
> 
> Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
> 
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Suggested-by: Rudi Horn <rudi.horn@oracle.com>

I still think this changelog needs quite a bit of work for someone to
make sense of this if they read it in a year.  Perhaps:

--

When XSTATE_BV[i] is 0, and XRSTOR attempts to restore state component
'i' it ignores any value in the XSAVE buffer and instead restores the
state component's init value.

This means that if XSAVE writes XSTATE_BV[PKRU]=0 then XRSTOR will
ignore the value that update_pkru_in_sigframe() writes to the XSAVE buffer.

XSTATE_BV[PKRU] only gets written as 0 if PKRU is in its init state. On
Intel CPUs, basically never happens because the kernel usually
overwrites the init value (aside: this is why we didn't notice this bug
until now). But on AMD, the init tracker is more aggressive and will
track PKRU as being in its init state upon any wrpkru(0x0).
Unfortunately, sig_prepare_pkru() does just that: wrpkru(0x0).

To fix this, always overwrite the sigframe XSTATE_BV with a value that
has XSTATE_BV[PKRU]==1.  This ensures that XRSTOR will not ignore what
update_pkru_in_sigframe() wrote.

The problematic sequence of events is something like this:

Userspace does:
	* wrpkru(0xffff0000) (or whatever)
	* Hardware sets: XINUSE[PKRU]=1
Signal happens, kernel is entered:
	* sig_prepare_pkru() => wrpkru(0x00000000)
	* Hardware sets: XINUSE[PKRU]=0 (aggressive AMD init tracker)
	* XSAVE writes most of XSAVE buffer, including
	  XSTATE_BV[PKRU]=XINUSE[PKRU]=0
	* update_pkru_in_sigframe() overwrite PKRU in XSAVE buffer
... signal handling
	* XRSTOR sees XSTATE_BV[PKRU]==0, ignores just-written value
	  from update_pkru_in_sigframe()

But otherwise, I think the code is fine:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

I can fix up the changelog at application time if everyone is OK with it.

