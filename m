Return-Path: <linux-kernel+bounces-406407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FD9C5E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A9A283EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45821744A;
	Tue, 12 Nov 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRyBA0Ec"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016021744D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431708; cv=none; b=GYAmXw1Hu4Vs0lRDnbQy1kPpv+qFxJPvZC0I3OLVs1uoHHOWsZKmlHmfeFxDJIGbaEfBwUtVCmM4n4n9flk2wrg6wRyy9TH5vySnlU0G7ScP7G6j4t6+UqjOt2H01E+3Ihf1SQ28vmkjPUKHxZ8h6fWlMOtv9UQ/93Ff5aFhVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431708; c=relaxed/simple;
	bh=nyh9dhwmH9LR43z/Y9Is5lt2DywQxJmev/TAao+dAEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3IEWAJuJpiuDZ260DVeVQsf4ypAsmtBsGo48cwXp5N445YcFObhE017Y/KPqew1oYwJk3rHUbj4SmRCJOyjNItMAY/iG8uj5Qr/0NzEqbgxuDkb1EvUMzmGzdYp6Nk3a7q4QmUa+/mLCRNbXH7skNdMas/R5dvlqzGPkAtg7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRyBA0Ec; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731431707; x=1762967707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nyh9dhwmH9LR43z/Y9Is5lt2DywQxJmev/TAao+dAEE=;
  b=mRyBA0EcW6b6XJnB4K46EA0rssjpeR3FgKmaibwYA8ijzNH6Y+ThiDY3
   EwVkoy/dOhzIcJb3zkUOYh8QAKZD7+RTg09Qlm6ISJUCDJ5HEB2RRtN1T
   H17/uVSIZkrDUzKAmdpY1PIKn1eYpMkPgxTmIJJM2/CAzRTrGdabz49ML
   wFi/BSc6B4JgkfHyGd/V3IA1GcKYI+EMZwiUoNkl9iHOzcknQ0LnUn/VO
   KQ6mJXVWsj4eZwN8yIbFpRDFMVFCS2pUJI2CW1SsmSUC3jWnUafC9fBIZ
   cdOTT/VLozN1cjVQ7MTkVumlp3ZxeAcvu4mpB1KF8MDDOYy9dNNaETnHy
   Q==;
X-CSE-ConnectionGUID: yIRJJuncSbiX/SvYgi7Zrg==
X-CSE-MsgGUID: mZRZuqV/Rg+lnXsLm7CY4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42670017"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="42670017"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:15:06 -0800
X-CSE-ConnectionGUID: IdqbexO0TrKoY2Nu4Mzapw==
X-CSE-MsgGUID: h/nSa3DBTIie7Dy2ZZRWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="88005627"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.220.61]) ([10.124.220.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:15:05 -0800
Message-ID: <001092d4-8431-488b-a98d-3aa5d4ecb692@intel.com>
Date: Tue, 12 Nov 2024 09:15:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode to
 be a vulnerability
To: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
References: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
 <59718ea7-efab-4975-a4e8-89c1d114a2e5@citrix.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <59718ea7-efab-4975-a4e8-89c1d114a2e5@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/8/24 15:36, Andrew Cooper wrote:
>> You can't practically run old microcode and consider a system secure
>> these days.  So, let's call old microcode what it is: a vulnerability.
> 
> The list becomes stale 4 times a year, so you need to identify when it's
> out of date, and whatever that something is has to be strong enough to
> cause distros to backport too.  Perhaps a date in the header, so you can
> at least report "status vulnerable, metadata out of date".

I don't want to get too fancy about this.  I'm assuming that mainline
and the stable kernels will be regularly fed new metadata.  The only way
to have out-of-date metadata should be by running an out-of-date kernel
in which case you have bigger problems on your hands.

> Also, you want to identify EOL CPUs.  Just because they're on the most
> recent published ucode doesn't mean they're not vulnerable.

That's a good idea too.  But I think it deserves a separate discussion
and separate patch.

> Under some hypervisors, you get fed the revision 0x7fffffff.  Others
> might tell you the truth, or it may be the truth from when you booted. 
> For this, probably best to say "consult your hypervisor".

Good point.  We should probably just say "unknown" when running as a
guest, or just not have the sysfs file at all.

> Failure to publish information, or not publishing fixes for in-support
> parts should be considered a vulnerability.  (*ahem*, AMD)
> 
> Or you could just simplify the whole path to "yes".  It's true, even if
> people don't know.

This series answers the question:

	Has the vendor published a newer OS-loadable microcode than you
	are running right now?

It doesn't seek to answer the question:

	Is the microcode that you are running right now vulnerable to
	anything (that the kernel knows about)?

I think the first question is quite answerable in a pretty factual way.
The second question is much hardware.  It's worth answering for sure ...
with another patch. :)


