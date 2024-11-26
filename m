Return-Path: <linux-kernel+bounces-422501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A59D9A60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A68B2B269
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0C1D61A1;
	Tue, 26 Nov 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx+nGmh8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440D1D54CF;
	Tue, 26 Nov 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634590; cv=none; b=AeCKPAWQVON93XjXGO078rynogHz+lxC1UqHTCyINL2F45INo5b4JWuJmztgz1KfYw1KzAINPGx7+AO/kf1h19YjtqsxTrFINkYPbjfCBpXs4qgYKa4qMlArrrTF5TzYP9sQlc2tCoTibuqVjcUTKzSMUnSCLodlKyCkG0Dbc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634590; c=relaxed/simple;
	bh=BRSfxCCbOwhi2VADRh6D9j6oW5F0hLtYWnvHVw2D4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMmExANA/m+ZZYofEwSLhCBiYWK23eLRZ/Qwdbjzn8s/Uz05NMCMqEMFcEagbEHM76Y5QDTanmBjaj8Fzo34Zc8ou/WWw4Znz7fPXAXSjPlBttc8NKHbRRk4iJAcOx1NiJrV0HklJOoqsCdr6JH6Q6TdTvLnn1Cm9xnN6RyX6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dx+nGmh8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732634588; x=1764170588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BRSfxCCbOwhi2VADRh6D9j6oW5F0hLtYWnvHVw2D4Ok=;
  b=dx+nGmh866NMJ10Tg1nsKlLBgD3mDDZzwdoWfw/kZhdxYzIpG2tadKTz
   afUGkC9SUjB+yg3FbweK70maJyKCz1l5G3m0OCILxELlr2oMkGzLG+MXf
   I2YSlZkSQ5xcmtSDJ7rtfHUI7uEMkwTvDiEq5V/aA7idOTbvSO726/Ldy
   912qZVQx2InkEDrH0uMdhzgB2ljuCi69sVXjPzhiD1wbAiTMh+LpIBMp4
   RWgiCXITUoyLs4ecIyWULgI8VjwUFvywVNzScsPfpvQ4dZLmw76ayD5eC
   KlJh4F46wzSeMleBE60Yu4HRTJmideCgcGO+/T9YYZjX5TzD3itFc58/x
   w==;
X-CSE-ConnectionGUID: SVCN5uZATneZegSmZm0V/Q==
X-CSE-MsgGUID: avPopEO0RbWgX59trlVKxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32859266"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32859266"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:23:07 -0800
X-CSE-ConnectionGUID: uzI9OrRkRESc0LNpJIAMGg==
X-CSE-MsgGUID: QH5wPg5HS+SufPvb1ivXHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="122496182"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:23:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFxP3-00000001JiU-3m2Z;
	Tue, 26 Nov 2024 17:23:01 +0200
Date: Tue, 26 Nov 2024 17:23:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Nicolas Belin <nbelin@baylibre.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
Message-ID: <Z0Xn1fMvuwR4KQbb@smile.fi.intel.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
 <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
 <d7bf7863-fd24-4f8e-8cd0-d84867a997bb@sirena.org.uk>
 <dad2ecb7-e624-49c2-a7d5-0ff53b6a1686@baylibre.com>
 <Z0RkaqfID9v0age_@smile.fi.intel.com>
 <ed50c130-076c-4697-9f11-fe602c7ca03d@baylibre.com>
 <49fa1677-db35-497b-afae-caa5dccf3747@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fa1677-db35-497b-afae-caa5dccf3747@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 26, 2024 at 11:37:26AM +0100, Alexandre Mergnat wrote:
> On 26/11/2024 11:29, Alexandre Mergnat wrote:
> > On 25/11/2024 12:50, Andy Shevchenko wrote:
> > > On Mon, Nov 25, 2024 at 12:32:13PM +0100, Alexandre Mergnat wrote:

...

> > > > Actually, after test it, "linux/of_gpio.h" isn't needed at all anymore.
> > > > 
> > > > That mean all added include in this patch aren't required.
> > > Do you mean the driver doesn't not use types from types.h or dev_*() macros
> > > from dev_printk.h? I don't believe this, sorry.
> > 
> > > 
> > > Basically what you are trying to say is "let's move of_gpio.h implicit
> > > includes to become something else's problem". It's not what this patch
> > > intended to do.
> > 
> > I'm just saying that I've test a build/boot with "linux/of_gpio.h" removed and without all
> > include added in you patch. My understand is "linux/of_gpio.h" act as proxy
> > for the includes added in your patch, my first idea was "if I remove it, build should fail cause
> > of lack of other includes". I can understand these missing includes are mandatory, that
> > probably means there is another proxy header ?
> > Maybe my test isn't consistent because it isn't possible to clear all proxy ?
> > 
> > If that's the case, consider my review-by.

> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Thank you!
Mark, would be enough to apply the change?

> > I've validated some include manually. Are you using a script to parse
> > the file and raise all necessary "linux/*" include ?

-- 
With Best Regards,
Andy Shevchenko



