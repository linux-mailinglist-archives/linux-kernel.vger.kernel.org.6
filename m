Return-Path: <linux-kernel+bounces-537192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE575A4890A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B743A60CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989C21ABA0;
	Thu, 27 Feb 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0jMFXY1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160B8BEC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684742; cv=none; b=OaYdsOZach1GDOihasYMzrs+v8WTSzgVSb3kDbQ4N+U7d787LlGkpKbGgAFfvpoVm/xTUTQrKwpYKUS3H+jklHZcOeYJjDBkn2hwVdMnL2DoQ+okQIG75+pFcdjyI6oaBrgckrvBKwnirLVRknkZGOM52M7zqylNkaQIDAyzaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684742; c=relaxed/simple;
	bh=+s7LHgAz1icc59OWNGsaw+JXQFb34bsLGHfIYqnQVps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2FZrm35Zm1A9yERLIDbAnXbIHMfN+j8dyZXugtm6bnW4Uz0dto9Y7BDI2q8rCDVfSzqKuyIE91HPlWuZMYhUUVOsQU7xnClOkmZY0cKcEKoUwY50VAxMgNcMa6iYs7J61ajHeeEPfrjpwdByu7WNQaTqYRXoantce9ndBVYa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0jMFXY1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740684743; x=1772220743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+s7LHgAz1icc59OWNGsaw+JXQFb34bsLGHfIYqnQVps=;
  b=d0jMFXY1JDQwFuEsL+zLTqEYda4PSUlDF0C12djabIyLHOit03q48pnU
   IVbs2yhxSrHEUFXSJ2jnJs4uwbZmpXn+hu/wmCMJgONtzTtvlWvD2iH/J
   O+L0myO5SzPb5wZ2xDPwNsfB+VXKlYWlkt/uuzljkYeNzoXG32cBELm2V
   OxY8idQBkEk8yVsjWV7/ih5Ma2myhQAgvcKkIcsEoSGQ1rnR1ctvFjRD2
   nT0sU75BdhSo1rc3jEDMnMtvxkTYveYcaL6n3cqz/MkQli3f3MNoFdBZu
   +rNhgASJQsiKTJZTiAZiXeFfHlQ7KqwXuKnRZScYdR6JMmUdysnwfVSjY
   A==;
X-CSE-ConnectionGUID: XoKL82fOTEuG4dRoQ2Iw+w==
X-CSE-MsgGUID: BrfImpr0RHijjN43iN+kDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51801839"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="51801839"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:32:21 -0800
X-CSE-ConnectionGUID: utUwDyc2S9SQqZiQ8Cc7ow==
X-CSE-MsgGUID: XUgyG2yxSVedUatDxY+1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117145536"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:32:20 -0800
Message-ID: <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
Date: Thu, 27 Feb 2025 11:32:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Ingo Molnar <mingo@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <Z8C3ZcMgHuBtIjFR@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 11:05, Ingo Molnar wrote:
> So why not just reuse the MPX feature number and have some sort of 
> extended feature bit that tells us and userspace that it's APX? The 
> xsave area is getting reused anyway - causing all this indirection and 
> trouble ...
> 
> Since we don't really do much for MPX in the kernel, and APX is not 
> supposed to be used by the kernel either, it should be pretty much a 
> shoe-in, right?

Theoretically, yes.

In practice, no.

MPX didn't have hardware enabling separate from the XSAVE enabling. So
there is software out there that assumes that if it can see the MPX bits
set in XCR0 that MPX is around. Take a look at kvm_mpx_supported() as an
example. Would you be comfortable having an old kernel which had
kvm_mpx_supported()==1 and X86_FEATURE_MPX==0? What about other VMMs?

There were basically three choices:

 1. Reuse XFEATURES 3/4 (MPX)
 2. Create a new out-of-order XFEATURE 19 that reuses MPX space
 3. Create a n in-order XFEATURE 19 that needs XFD and an opt-in

#1 risks breaking old MPX code in weird ways.

#2 requires teaching OSes about the out-of-order XSAVE offsets.

#3 is really nasty for hardware and software

So, you can blame me for picking (or consenting to) #2. But I do still
think it's the safest option. I'm not looking at this diffstat and
regretting the decision at all.

> What's the scope of MPX support in actual processors out in the wild?

IIRC, it showed up in Skylake, roughly 2015. By 2019, it was deprecated
and was mostly fused off in the "10th gen" CPUs:

> https://www.intel.com/content/www/us/en/support/articles/000059823/processors.html

APX is not out yet. No CPU will ever have APX and MPX, obviously.
There's also a ~5 year gap between CPUs that have one or the other.

Is that what you were asking?

