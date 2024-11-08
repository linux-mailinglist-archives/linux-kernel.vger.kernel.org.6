Return-Path: <linux-kernel+bounces-400869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32889C1372
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593E7283357
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8DDBE49;
	Fri,  8 Nov 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5WRaqsu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F818BA27
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028374; cv=none; b=He24Eh3m2gwUZSkgBZaUdTYwixT0RCIZHWEpn64G/8+Anf+JDcefCzx28Yv1P5yMYfnvOLvXIX51p3tj5Hj/jeR7+H8WTh0UKOnU+eS4+1orCtVw8xr22Xoj4vahZnqlKDDOMbNSPnlfkPtSfy95PO/Pr7Qn2A8GCTKv6ObpF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028374; c=relaxed/simple;
	bh=8C9mHlOz7lxiBqy6ivlhTg8m4o0ypwKwA+m0GRU8G6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRDyDqAvQDPxZvUTjsirYi8mb/UzcftdcdnVxcgbq2o/Wgfb6ADWzTaDmgZCZO/W1rYtlj4RN5ThkOHy0HQm1SoPWgZoPzZDN5y0wSKBdmLcHAS2qxef9yxFEwKHSYaaw5onk0sJYiyvZfct0YrUPyeFuQ8O7QvxMqmpFW/JasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5WRaqsu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731028373; x=1762564373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8C9mHlOz7lxiBqy6ivlhTg8m4o0ypwKwA+m0GRU8G6E=;
  b=U5WRaqsuFNMec3ZSjSMeBs6UXus4efUNlxModRpsGzZXTJgPnTVAMZJM
   5IM/sRo4kiilWG+58Gc2SMHZVM6oglMUtpIYPUCJyrs4wW8wLAtpqpiU2
   nCekYIh93vx3MX2Niye3BRQflJLFhR+cT/tJIgkCMGUsSwg7J7pO7XsR/
   frapkmOX9Hf+qimb/VgCLrhUwHR1kKxkzhRXVS5Th4S/BZVDv1FpeNzHx
   kk/O7Srian/S7yD0BdrJVX1ojr3InfDiUzfsdQfyipWCxCW+kcyQ4PhIK
   JJp7DVKvI/AoNfYenIqorulqrpSzfYwtim4dCKJLYTYn7UepwhS+UKFMk
   g==;
X-CSE-ConnectionGUID: IEDXN5enQ9aEEzVzOupyHA==
X-CSE-MsgGUID: 1OE3seBOTjiJ6oJVvZNXmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42301434"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="42301434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:12:53 -0800
X-CSE-ConnectionGUID: 8jnXaZrfTA+5wk8RR0LFZQ==
X-CSE-MsgGUID: R2WLYbKjS9C4tv+tT6ci6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85233233"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.222.202]) ([10.124.222.202])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:12:52 -0800
Message-ID: <4c01a30a-67d9-4918-8781-240b78944c42@intel.com>
Date: Thu, 7 Nov 2024 17:12:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
To: "H. Peter Anvin" <hpa@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org
References: <20241107233000.2742619-1-sohil.mehta@intel.com>
 <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
 <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
 <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 15:49, H. Peter Anvin wrote:
> Be careful - these bits are used in module strings and so modutils need to understand them.

Yeah, very true.  But I didn't ever see these features get used in a
MODULE_DEVICE_TABLE().  Do you still have concerns if there was never an
in-tree user that used X86_FEATURE_P3/P4 in a MODULE_DEVICE_TABLE()?$

Sohil, go look at:

# cat /sys/devices/system/cpu/modalias
cpu:type:x86,ven0000fam0006mod008C:feature:,0000,0001,0002,0003,0004,0005,0006,...

and, for instance:

# modinfo /lib/modules/5.17.0-rc4/kernel/arch/x86/kvm/kvm-intel.ko
filename:       /lib/modules/5.17.0-rc4/kernel/arch/x86/kvm/kvm-intel.ko
license:        GPL
author:         Qumranet
srcversion:     ED99EA15FCA9B58172BAEB4
alias:          cpu:type:x86,ven*fam*mod*:feature:*0085*

Those magic strings get matched up by udev (I think) to auto-load
modules when the CPU 'modalias' matches the module 'alias'.  Let's say
we had an ooooooooold module that did this:

#ifdef MODULE
static const struct x86_cpu_id foo_cpu_id[] = {
        X86_MATCH_FEATURE(X86_FEATURE_P3, NULL),
        {}
};
MODULE_DEVICE_TABLE(x86cpu, foo_cpu_id);
#endif

which generated a modalias like this:

	alias:          cpu:type:x86,ven*fam*mod*:feature:*0067*

and then we recycled number 67:

-#define X86_FEATURE_P3                  ( 3*32+ 6) /* P3 */
+#define X86_FEATURE_WHIZZY_NEW_FEATURE  ( 3*32+ 6) /* P3 */

udev might try to load the old module on a new CPU with
X86_FEATURE_WHIZZY_NEW_FEATURE that's not a P3.

I sure hope we haven't been using too many of these synthetic features
in MODULE_DEVICE_TABLE()s, because we tend to move them around, but I
guess it's possible.

