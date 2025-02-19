Return-Path: <linux-kernel+bounces-522315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD49A3C88B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93165189BACA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF122ACDF;
	Wed, 19 Feb 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fleSNih+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993B22A819;
	Wed, 19 Feb 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993104; cv=none; b=bDSPtcUQu/nAUr4G872VUg/XqNzch4KtVKj4vssYDNmIG6kQdTfMW+Unhf8CUg+J2aEvn7iET8z+CZehj9M/itvTjDqifkKNFO/RDI5bjG/phJ4z4f18kDLvzevf9kZXF4LBJ1SBsvHgJJyRGyuktBT6LG0MK/Q9+IhuSRb3hYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993104; c=relaxed/simple;
	bh=4xkjxsKSnDG+ejxVEfbphpK/6goWvTkMshFWpmtRGeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OfxV3MGUefmwRufsQEZU8DXGkOgqLkfscYZ06Sj20xvBz+Wlvhid6LzqRlQKPSkag2YO5gO++aMrYwJcImWKkeoqUhGUjge/trUeBNUe08jxO3368A0TIPGZMI2FcKMIOMcHgm4aKdWi9h15S+l7MQfVBvseW/klxkHj9+KCQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fleSNih+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993103; x=1771529103;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4xkjxsKSnDG+ejxVEfbphpK/6goWvTkMshFWpmtRGeA=;
  b=fleSNih+rQIRNQmvCjmSFGbM3RUb+ZuTYk7Z3y1gI/CKRE3aez8XRrvX
   Mm0dP7Gnj/dZeinbYIQ/S/+HR/vYZw07QB62uN8NFZlSW2fwCV5hRFOUI
   9K8+s1URn2NDC5a4ZDazdVLwSi0BOG84kQ8yOnW13+LN0Dtw+cE/3g3cI
   PVj2xOkpsHOhhJHLANJa7aB5srIR2ZNc7cR1qMNsem5YpnVNYvmHnyR6X
   ACvKglWqNvxXQVxOhlcMUb/74tpWpBUFCoRsiQBpnD3FtpE1OvoxoKekv
   hydZF+QIVt0XU52p6ywxG5oKzDMcbLnPRfThlJEstCcNbioaKwGWdIpZI
   Q==;
X-CSE-ConnectionGUID: aOdavW0RRAaww0BU75viLg==
X-CSE-MsgGUID: /HsYx9OCQIOXk9dZHmUClg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40604683"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40604683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:25:00 -0800
X-CSE-ConnectionGUID: sT6FCgk1RDag9ulyZnQRTg==
X-CSE-MsgGUID: v13zxD0XTXmGo28FPVA9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114791542"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.160])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:55:18 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jim Qu <Jim.Qu@amd.com>, Lukas Wunner <lukas@wunner.de>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Takashi Iwai
 <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Su Hui
 <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
In-Reply-To: <f608a3b5-320a-4194-bd03-cf08be04c317@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
 <87zfiim09n.fsf@intel.com>
 <f608a3b5-320a-4194-bd03-cf08be04c317@stanley.mountain>
Date: Wed, 19 Feb 2025 20:54:41 +0200
Message-ID: <87r03tn4su.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> On Wed, Feb 19, 2025 at 05:17:56PM +0200, Jani Nikula wrote:
>> On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>> > The "id" variable is an enum and in this context it's treated as an
>> > unsigned int so the error handling can never trigger.
>> 
>> When would that be true with GCC?
>
> The C standard give compilers a lot of flexibility with regards to enums.

This I did know.

> But in terms of GCC/Clang then enums default to unsigned int, if you
> declare one as negative then they become signed int.  If they don't fit
> in int, then they become u64 etc.

But somehow I'd failed to appreciate GCC/Clang actually do use unsigned
and signed on a case by case basis. I thought they defaulted to signed
int. TIL.

And I still consider myself a rather experienced C coder. There must be
something wrong with either C or me. Or possibly both.


Thanks,
Jani.

>
> enum u32_values {
> 	zero,
> };
>
> enum s32_values {
> 	minus_one = -1,
> 	zero,
> };
>
> enum u64_values {
> 	big = 0xfffffffffUL;
> };
>
> regards,
> dan carpenter
>

-- 
Jani Nikula, Intel

