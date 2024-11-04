Return-Path: <linux-kernel+bounces-395419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D19BBDAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD6C1C21CED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB41CDA3B;
	Mon,  4 Nov 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRtnWmSy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA01CC893;
	Mon,  4 Nov 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747195; cv=none; b=jish6Uon2tGw+XIfrMvnqK9iMiyIkQR8xPUtnyg63l2QHMBZ90KQjYga27gnB0qoWmLp2J3bKlVEvWxhP5ypNIQE25AujAms1HYXrw5khM9akhhFsmlYHledBfmCuGnF/uVO73zmgfYmTAOS7X1zF6F8CWPgxzxrEQFfcRgyF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747195; c=relaxed/simple;
	bh=Mq6fY7BoRhA0N/3Lw6alJV11PuUSGJNdDgHSu7cCIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDUFaRBOtpIcb5m6wWHcdkpc0w8cauzJYvekzeHvyIzwLHDNxbOnJ82q17nXtcKXgMj4ERhPRvndq+LQIEH2j3zNb3KGCVjt4fbVkD1i7aMimdOuncDyfCUkpSksxnkjda+cEPxcrL9PZSe9K4JhRAnituVarC6VnpxYOo/Y+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRtnWmSy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730747195; x=1762283195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mq6fY7BoRhA0N/3Lw6alJV11PuUSGJNdDgHSu7cCIQY=;
  b=jRtnWmSyzlCyi0CUYWe1CHVwue6mjMXD15UkZKR9OrsmUQ7flHXjwJPf
   cJmhij/bkN8IGHxfObmbLW6p9FK5Vq7A5Waiy1X0PA4Z3wEh5+SjSjVwW
   Ua2CUU7rSiGp/LRu+KRarQbhfFM1F3b3SrdKBajO+/rwNqt2w8cobDhqn
   QbNkXFNhzYfLyHDKXhBzj2Hpf2ubDd59ZJRMJxQFsOu3hoemtrOlwtqba
   +HewVGFRu1HQSsp/nrOPOMNyPFKUbSFqdexKX0EGOh1MAIiZi+VsMqX7T
   yiaCN4CBi/JvPTqwA+pT+2bmWp07mW79I3paESdsLHdpZQEl/2uWwXUHT
   A==;
X-CSE-ConnectionGUID: MTSIpE7/QYCDpOYaQCwK+Q==
X-CSE-MsgGUID: zwxhHAJfTFmfn2Yo9tMgEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30626878"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30626878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 11:06:34 -0800
X-CSE-ConnectionGUID: 0p2G7MeuSNaC+hVQwVNKOg==
X-CSE-MsgGUID: d1XN3jwVSXGF/j5BIDN27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84179430"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 11:06:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t82PD-0000000BA62-0ml4;
	Mon, 04 Nov 2024 21:06:27 +0200
Date: Mon, 4 Nov 2024 21:06:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, Nicolas Belin <nbelin@baylibre.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
Message-ID: <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 31, 2024 at 12:27:25PM +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.

Hmm... I think we are waiting for somebody to Ack / review this change?

-- 
With Best Regards,
Andy Shevchenko



