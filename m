Return-Path: <linux-kernel+bounces-422499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6219D9A59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B62814C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EAC1D619F;
	Tue, 26 Nov 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PF344+5B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5417591;
	Tue, 26 Nov 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634538; cv=none; b=uKwH0wcgDk9RCAKncw1zJT/C5MMR5KlfYn697zifiE4usrBnsf911EWNC7PcufcVAUPHu214aYMN+V2Hc0W/3p75j38KO46V/A4I9uOlPtU8Am+zyjGoskMwYPlDo4R5U4YhojsDPcVE2Y4UxJCJl6+l6I2FESkxuqJd+kucgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634538; c=relaxed/simple;
	bh=769bkhalWPrlCV5hGTXjnG0wp9G7hdn+3+311XvR27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqbzLRrsrkZPdlzWIxUI0KN0LlMVdN2CAYBIOIfa19u9mDBUZNLqVBDkS4EQWjY/szST3qr/A4IQACh2TdbFooFRTZmpTxggQH42eLDmza2xW7FqAJMnaTs7XzL3wuMxhC2Uaj9Xfrpwjim1QJErE7IHR3XlqxONLTx9VqZrI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PF344+5B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732634537; x=1764170537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=769bkhalWPrlCV5hGTXjnG0wp9G7hdn+3+311XvR27I=;
  b=PF344+5BJzrwjojNggW+/GOivO3XNO1g1+zCmwXfAiTuSgBAXSIMkbBm
   CdklEnt2ryHeo8aeo4RRT/yL+m9TBbRsdgGkSUQApxt8T6Fskqh/lpHS+
   YHtegXtc+bTDH01D/pyIYiWVKZB4BHOSzLyUvQJUpuI8F7lyQ1sgL3Bok
   j2rVy0JNE9oslXIk59G79U5e461X9BeEDtiMysjUEUQKcthp28pBhz4iS
   GumGPUzAo6D47plYSnuWACfV8vPKyqTUikmu2PwJbPogcfcXI8saQj2bP
   Vs26lBd6jKKoWpGt/MhidzWYkxe478v7MKn27i11AomxhNpGs8A40lyhS
   Q==;
X-CSE-ConnectionGUID: b9DQaLr9Rguh5mlLj+r5TQ==
X-CSE-MsgGUID: 2U1fovowR72RZ+yVwyYSmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="44187798"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="44187798"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:22:16 -0800
X-CSE-ConnectionGUID: QrTNqsCbTraNCx0G5LvIlQ==
X-CSE-MsgGUID: 67t1Dgv4SeaAZjdYw1di1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91757434"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:22:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFxOD-00000001Jh2-3PzD;
	Tue, 26 Nov 2024 17:22:09 +0200
Date: Tue, 26 Nov 2024 17:22:09 +0200
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
Message-ID: <Z0XnoQQlsDwFh58h@smile.fi.intel.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
 <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
 <d7bf7863-fd24-4f8e-8cd0-d84867a997bb@sirena.org.uk>
 <dad2ecb7-e624-49c2-a7d5-0ff53b6a1686@baylibre.com>
 <Z0RkaqfID9v0age_@smile.fi.intel.com>
 <ed50c130-076c-4697-9f11-fe602c7ca03d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed50c130-076c-4697-9f11-fe602c7ca03d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 26, 2024 at 11:29:28AM +0100, Alexandre Mergnat wrote:
> On 25/11/2024 12:50, Andy Shevchenko wrote:
> > On Mon, Nov 25, 2024 at 12:32:13PM +0100, Alexandre Mergnat wrote:

...

> > > Actually, after test it, "linux/of_gpio.h" isn't needed at all anymore.
> > > 
> > > That mean all added include in this patch aren't required.
> > Do you mean the driver doesn't not use types from types.h or dev_*() macros
> > from dev_printk.h? I don't believe this, sorry.
> 
> > Basically what you are trying to say is "let's move of_gpio.h implicit
> > includes to become something else's problem". It's not what this patch
> > intended to do.
> 
> I'm just saying that I've test a build/boot with "linux/of_gpio.h" removed and without all
> include added in you patch. My understand is "linux/of_gpio.h" act as proxy
> for the includes added in your patch, my first idea was "if I remove it, build should fail cause
> of lack of other includes". I can understand these missing includes are mandatory, that
> probably means there is another proxy header ?

Exactly. The compilation can't be done without respective headers to be included,
so one way or another they are somehow got included, meaning that other(s) header(s)
are "proxying" them.

The idea is to have less of the dependency hell (you may find this term used
many times in the relation to Linux Kernel project), so the (leaf)
modules/drivers should follow the IWYU principle (Include What You Use). With
that in place it's much better to clean up the headers in order to decrease
the hellish dependency tree.

> Maybe my test isn't consistent because it isn't possible to clear all proxy ?

Theoretically it's possible and even practically, just requires a lot of time.
(Or a lot of resources to make a flag day or so, but seems not many are interested
 to take the job)

> If that's the case, consider my review-by.

Thank you!

> I've validated some include manually. Are you using a script to parse the
> file and raise all necessary "linux/*" include ?

Nope, it comes just from my experience in the project, but I love to see
such a tool to exist!

-- 
With Best Regards,
Andy Shevchenko



