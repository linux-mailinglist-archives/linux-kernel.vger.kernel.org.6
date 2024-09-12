Return-Path: <linux-kernel+bounces-325768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E2975DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B612BB21FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC94685;
	Thu, 12 Sep 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iecaVI58"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3F1877
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100602; cv=none; b=P1fdknQWbCzVN2x8lyLxhORurqIzI/sq6DWnYz0Q3ShwnPyjaPJdKcD0faQIYc3gfyZHE1PXq8ymJEG2bNv3o2xqLdalZoPCn5Xo3kUqnFQ+o6ziEiCH5m3IhqrSwh6p+MPCxGnocTZlXsi5k2RpCQTJvzzJ4TcNMxHDC8It1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100602; c=relaxed/simple;
	bh=CiR8o9L9CqezBdCRlOwKUcbnA8aSStZB2KaWJ8GnIiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9epTFAGU6uBUfpFNQgz8+8eMpLho0ia+iC3ejU+4X/16F39w8+pNIJeV0iDqL2Y06Q7Zux/dt4KpaatQld8Xa4SsfVVy4bCtRmVOckEPk03Y+ciT9GIV/eUOqkSKG7CBeiuVuPeYLFJKzQRiF3Df6QGTcS0kFk/1sQzfTR6+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iecaVI58; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726100600; x=1757636600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CiR8o9L9CqezBdCRlOwKUcbnA8aSStZB2KaWJ8GnIiQ=;
  b=iecaVI58VJ9VUmpBI0a9eEqGqDV0l8WbVLfiOu5G66+00kLQ351mrxXp
   2tOt/NDI+1vOvfSYZfF3QH87vh7Lfze79GQXkKrXPvU1Fe8kgzNzroCJ8
   NzUVogrMMk4U4VVRkHwwN8MvLRuxxM51lm1Ee+YN2EAm0VoOO5Q+ZoCwt
   9L1d/fooVoloYTBiQIcZ0cFBRED24zjlvacSI+kG2bBWYQaHBEhEXfCIf
   0dN3rKkObklwu+hPcjn2jE52kBYN27kQ9UbMCp4WSMs/QtpNQJhqBtQ/S
   Z6JY9xcOeoxmeqAZZEFOptOIRO/jopw/ZX0O7BIlFQd6JdjvYknDHwHrA
   w==;
X-CSE-ConnectionGUID: 4NLfqXQUSqOPPpGvSaD+Yw==
X-CSE-MsgGUID: q70bHFYIQE6lS/ArafhTEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24420718"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24420718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 17:23:19 -0700
X-CSE-ConnectionGUID: xbJ5DSq+TsihI8G/1gHitA==
X-CSE-MsgGUID: jzzAgGozTW2yEHCeAGNJ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67527291"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.223.221]) ([10.124.223.221])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 17:23:18 -0700
Message-ID: <3328e53d-b0f2-4516-a6a6-51ca33642683@intel.com>
Date: Wed, 11 Sep 2024 17:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, andrew.cooper3@citrix.com
References: <20240911231929.2632698-1-xin@zytor.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240911231929.2632698-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/24 16:19, Xin Li (Intel) wrote:
> +/*
> + * The WFE (WAIT_FOR_ENDBRANCH) bit in the augmented CS of FRED stack frame is
> + * set to 1 in missing-ENDBRANCH #CP exceptions.

I think there's a bit of relatively irrelevant info in there.  For
instance, I don't think it's super important to mention that FRED is
involved and where the WFE bit is in memory.

FRED's involvement is kinda a no-brainer from the whole X86_FEATURE_FRED
thing, and if you're reading exception handler code and don't know that
'regs' is on the stack, this probably isn't the place to explain that.

> + * If the WFE bit is left as 1, the CPU will generate another missing-ENDBRANCH
> + * #CP because the indirect branch tracker will be set in the WAIT_FOR_ENDBRANCH
> + * state upon completion of the following ERETS instruction and the CPU will
> + * restart from the IP that just caused a previous missing-ENDBRANCH #CP.
> + *
> + * Clear the WFE bit to avoid dead looping due to the above reason.
> + */
> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		regs->fred_cs.wfe = 0;
> +}

Can I suggest a slightly different comment?

/*
 * WFE==1 (WAIT_FOR_ENDBRANCH) means that the CPU expects the next ERETS
 * to jump to an ENDBR instruction. If the ENDBR is missing, the CPU
 * raises a #CP.
 *
 * Clear WFE to avoid that #CP.
 *
 * Use this function in a #CP handler to effectively give the next
 * ERETS a free pass to ignore IBT for a single instruction.
 */

I think original comment really needs a "How do I use this?" sentence or
two.

A comment at the call site also wouldn't hurt:

 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)){
 		regs->ax = 0;
+		/* Disable IBT enforcement for one exception return: */
+		ibt_clear_fred_wfe(regs);
 		return;
 	}

I'm finding it kinda hard to concisely differentiate between the
"disable IBT at one ERETS" and "disable IBT forever", but I hope this
sounds good to folks.


