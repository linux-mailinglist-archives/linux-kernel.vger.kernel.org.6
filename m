Return-Path: <linux-kernel+bounces-420963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542C9D8528
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38431B6084C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B3199FBB;
	Mon, 25 Nov 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM8LmYuf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207F376E0;
	Mon, 25 Nov 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535411; cv=none; b=GrIkAOfqecBeUGvdb6iUGzWFfoUaEsX1yEW25fLzjrET44IoFGri2hWXQ7BkZRePZwsSke8M9jj31+1+cqDKIHgnRBJuHOl4u+Xfku20TNyuTWLnXGUuXkNnyBE7Fr8OUEMSgct38ekmuyjFJZ3BFj89rws4+Ax+YQRaOQG1uTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535411; c=relaxed/simple;
	bh=kSYSImDUvkzfXkaqiB+cnw9SCsDTqsyLlK3fME3dMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlZJJF8/gNZiUtU5IraM2Pwl1t5vW+NgohoKB2+tK7SDj7+KLcatjW6zq/E46T3ffxAJrzoyZlsfe2rG0LpWOP8CIcR5bwn1SWBTBEgyQE3+fln0/aSe4/XrfbbV2txnlYtew3s3rcYc6YgXKZ7uzRCVKTn925Oxih5jRRv7yFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM8LmYuf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732535409; x=1764071409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSYSImDUvkzfXkaqiB+cnw9SCsDTqsyLlK3fME3dMxw=;
  b=bM8LmYufjsZTbsS1tysY/ttm6jBLJrVZxPu8tiAq/Mh4i1cZtH8k2eaU
   4rDqcQs/G2pTCtFMdB1n89mBwBseiBUO4rsIGKjmwYbaoORNgXCg7UZv9
   bjeRGmJd+8S1yjNacS8Nb0coSgkUee0UDPdFh6LmSvAH49Go088E7j/jY
   qb6EDoLS7r9o7L0eox9JIv0Ohh7b3wcUVqNptHxD+Jkh90SNzgLyyfoxK
   jCIaIMXA4HUS8ieO6sHxIJQH0nRd8Ejul25bJFlSAYw8XCyndKnt2Yjc5
   SjFeTLLHBD5wk0MMIDlrEnwfUvpo1BNUfFJvbx35ahhpEf6Uv9IOPWW8A
   A==;
X-CSE-ConnectionGUID: rhQKMbmWTxa8Ql/x9J9oJA==
X-CSE-MsgGUID: zOGUX84DTyyJpsRs0TBc1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="44017392"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="44017392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:50:08 -0800
X-CSE-ConnectionGUID: mhL5UBfPSYuWDQnQLKUlgw==
X-CSE-MsgGUID: 6j3M5iBBQp6hsk0gnibVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91589894"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:50:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFXbO-00000000joT-27qB;
	Mon, 25 Nov 2024 13:50:02 +0200
Date: Mon, 25 Nov 2024 13:50:02 +0200
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
Message-ID: <Z0RkaqfID9v0age_@smile.fi.intel.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
 <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
 <d7bf7863-fd24-4f8e-8cd0-d84867a997bb@sirena.org.uk>
 <dad2ecb7-e624-49c2-a7d5-0ff53b6a1686@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad2ecb7-e624-49c2-a7d5-0ff53b6a1686@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 12:32:13PM +0100, Alexandre Mergnat wrote:
> Hello Andy.
> 
> Actually, after test it, "linux/of_gpio.h" isn't needed at all anymore.
> 
> That mean all added include in this patch aren't required.

Do you mean the driver doesn't not use types from types.h or dev_*() macros
from dev_printk.h? I don't believe this, sorry.

Basically what you are trying to say is "let's move of_gpio.h implicit
includes to become something else's problem". It's not what this patch
intended to do.

> On 04/11/2024 22:12, Mark Brown wrote:
> > On Mon, Nov 04, 2024 at 09:06:26PM +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 31, 2024 at 12:27:25PM +0200, Andy Shevchenko wrote:
> > > > Update header inclusions to follow IWYU (Include What You Use)
> > > > principle.
> > 
> > > Hmm... I think we are waiting for somebody to Ack / review this change?
> > 
> > Yes.

-- 
With Best Regards,
Andy Shevchenko



