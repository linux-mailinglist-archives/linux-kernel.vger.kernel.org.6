Return-Path: <linux-kernel+bounces-449886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE49F5764
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7878416EB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0A1F76BA;
	Tue, 17 Dec 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOQoR7WS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA00150994
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466450; cv=none; b=bGTf3mLujnVNDdbSeKcj+LsHXCsDok4drIPKvJpnfJmWXAv0G2MK8QcG41iJB6gU9raJIIQwuKtfMeFxQRQZNup0UdSL/39bVBrk+cDMrJtEdQ8MKAAqA+XAytL68nAmlkPOwap28yHp5KuSKC2IjGYol6cLVZXUSgmTIUeMp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466450; c=relaxed/simple;
	bh=mkS8bGIKwgjkAul5XLm+qXbojqTTipaPqyKI4CS0y6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4gyt7YTBU1Lurjwi7oq3uEFFlG7HpKLulIYGSAHMObgtg1t/WuiVNWAEq7Np9ZUK89gaodEX0HcJqd+b+xhot9kjM+sEnHx5rF9RwEkriwdBtiNA1Uwy8oKFZ7HO79Tv3B0E/6FQsb6FG28G7glLRMJBtpF2qVwfUbmzHmR5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOQoR7WS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734466448; x=1766002448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mkS8bGIKwgjkAul5XLm+qXbojqTTipaPqyKI4CS0y6g=;
  b=JOQoR7WSPA0TJS50mPoAkIy4eLW9fwWs13CItYOk5JHoSloNiWhyHFJy
   x9cejLBb6Gl7peEAxDIrf25uSoNqD+3XOFysFtzrpwqJjqe0wROBwbP4L
   +6Yjr+9JwjeAXVY+XyVYvwKFQ5V7ZOOJYHrwM9LUyXTDHyDOwSafosPXD
   DP+34dwhRFpxhYmyHQRJC+Tv5ou+ABPephZ3qmZ5w2vtzOifaGdzANFOV
   FqS3BZI1w2Tzl16+4SNRMA2MNhZmFozHZ9z5QrWFqckqcKarOqTke5Irt
   tEYGJm2khlBhWgvvGSTGLt+BW4UexJXy3QdtbnmLZhJO3V9fnicFXCsqg
   Q==;
X-CSE-ConnectionGUID: ph6/6koKQNWaHa220e+O4w==
X-CSE-MsgGUID: WTTFT/f5SXWEe4Wts6KKpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="37748909"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="37748909"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 12:14:07 -0800
X-CSE-ConnectionGUID: h5Tzdj0bTvi2zArmH+/jcg==
X-CSE-MsgGUID: gcQkEiB0TwmUZvzywvq7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98083216"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 12:14:06 -0800
Date: Tue, 17 Dec 2024 14:14:00 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Arnd Bergmann <arnd@kernel.org>, 
	michael.j.ruhl@intel.com, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"David E. Box" <david.e.box@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Tejas Upadhyay <tejas.upadhyay@intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe/vsec: enforce CONFIG_INTEL_VSEC dependency
Message-ID: <fjforguil5lcij77tgmjk5sw5bzuwg7m34nsdmrzbinnmt2xte@moz3kbsg6tgi>
References: <20241217071852.2261858-1-arnd@kernel.org>
 <Z2HIW4c-S_IA9bWb@intel.com>
 <36bae0e6-9153-4cb4-9c85-8a582a47044b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <36bae0e6-9153-4cb4-9c85-8a582a47044b@app.fastmail.com>

On Tue, Dec 17, 2024 at 08:28:59PM +0100, Arnd Bergmann wrote:
>On Tue, Dec 17, 2024, at 19:52, Rodrigo Vivi wrote:
>> On Tue, Dec 17, 2024 at 08:18:44AM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When INTEL_VSEC is in a loadable module, XE cannot be built-in any more:
>>>
>>> x86_64-linux-ld: vmlinux.o: in function `xe_vsec_init':
>>> (.text+0x19861bf): undefined reference to `intel_vsec_register'
>>>
>>> This could be enforced using a 'depends on INTEL_VSEC || !INTEL_VSEC'
>>> style dependency to allow building with VSEC completely disabled.
>>> My impression here is that this was not actually intended, and that
>>> continuing to support that combination would lead to more build bugs.

why? if xe is built-in, vsec needs to be built-in as well. If xe is a
module, vsec can be either built-in or a module.

>>>
>>> Instead, make it a hard dependency as all other INTEL_VSEC users are,
>>> and remove the inline stub alternative. This leads to a dependency
>>> on CONFIG_X86_PLATFORM_DEVICES, so the 'select' has to be removed
>>> to avoid a circular dependency.
>>>
>>
>> I really don't want us to hard lock this X86 dependency here.
>> What if we add a new DRM_XE_DGFX_PMT_SUPPORT and that
>> depends on INTEL_VSEC ?
>
>Yes, that should work if it gets phrased correctly.
>Something like
>
>config DRM_XE_DGFX_PMT_SUPPORT
>       bool "X86 PMT support"
>       depends on DRM_XE && INTEL_VSEC
>       depends on DRM_XE=m || INTEL_VSEC=y
>       depends on X86 || COMPILE_TEST


that looks good to me.

thanks
Lucas De Marchi

