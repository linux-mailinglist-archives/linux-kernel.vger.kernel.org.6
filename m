Return-Path: <linux-kernel+bounces-206302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D485E900793
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46863B23CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE219AD9D;
	Fri,  7 Jun 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvHzy/nM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71B195B2E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771472; cv=none; b=UsNON2uP6zro3UMCq7BWU5k+l2YLVoL1jjDlw1HJ7slgfRXTTIwAtd7jL0C1iKjufUIyiuR0+n+qbyLOnGLK0vBt51JEEiak8ao3dx+bz8GVnoggLYMgliP5GCPfeMise4SFGtUkMPSbPmjaVjwrQWOkUr/DCuI2xqhAB8jhucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771472; c=relaxed/simple;
	bh=trC8zjKdFoxKnt0LPm3AF+tVZcf0sdu9cvB6t+sMDf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gohc5qSaVBJjQ4qB/KWDgQySM+0oIZZAcl2bZ2nYL3CL+RaDbX6H7SRL8ia4bYoIJPSk5+zcugB2RkwD53VTlFe5e6DJgQvHnBbLbc+g502v7UKniZFTgMWUGKGnvraIUJkSxI/kwf8OfrJkEw4iKo7jCkPmrhj7pXBeStVTCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvHzy/nM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717771472; x=1749307472;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=trC8zjKdFoxKnt0LPm3AF+tVZcf0sdu9cvB6t+sMDf0=;
  b=LvHzy/nMwgZdYxKArfZkeh9cNebLMvegaKUTGvodKckb6S+lC6+LEanX
   d94/7aF85POeqld1sqENZhDWANq/27TsA03VnXEuAzUvaJyHX5zqVm3Gx
   0MTeviXz4gPgxooYGIa1cFlyLh0bDiH6LyByU808uswfQUN87ZEYkWrRa
   wRDwBHs2BrR7PkrEO7gVpBLQyU5FNmk6pFo2vohV358jarUWNGurzQYOt
   PbWlOzMINQud5IFtGvURfkxqMq0ePlfHEYureVm1D8fHmNKT69OlT1SQr
   cRz63pJDMG87TkmnKKxPHKaK6QR9zYS1vGgd4Ije5rmvTxu1+GRE9Haov
   A==;
X-CSE-ConnectionGUID: w8cBAxwMRGm1CIkqpSTfOQ==
X-CSE-MsgGUID: 5Fc+uSdvSbKnJqi8xO4XEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18285784"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18285784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 07:44:31 -0700
X-CSE-ConnectionGUID: McnHDPOqQXu8ZXa06yJZCA==
X-CSE-MsgGUID: Xi0V/LR6S9y0ihvmx1VdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38277942"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 07:44:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drm: have config DRM_WERROR depend on !WERROR
In-Reply-To: <87tti5j5d2.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240516083343.1375687-1-jani.nikula@intel.com>
 <87tti5j5d2.fsf@minerva.mail-host-address-is-not-set>
Date: Fri, 07 Jun 2024 17:44:26 +0300
Message-ID: <87le3glsmt.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 07 Jun 2024, Javier Martinez Canillas <javierm@redhat.com> wrote:
> Jani Nikula <jani.nikula@intel.com> writes:
>
> Hello Jani,
>
>> If WERROR is already enabled, there's no point in enabling DRM_WERROR or
>> asking users about it.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Closes: https://lore.kernel.org/r/CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com
>> Fixes: f89632a9e5fa ("drm: Add CONFIG_DRM_WERROR")
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>
> The change makes sense to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks, pushed to drm-misc-fixes.

BR,
Jani.

-- 
Jani Nikula, Intel

