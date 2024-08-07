Return-Path: <linux-kernel+bounces-278103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518194AAEB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CE7B229A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9A8286F;
	Wed,  7 Aug 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDBgWqbA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB6823DE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042733; cv=none; b=sBKgu8OF8UwHrQ6lNvNaG+52ZYO5q60TN8W/MEHdYmNvZyKcNo4I8INE+NIlSN5LV7Jz5idr47LYRH6YKTGR6MSanxhvldNNl0BsWggT3iSBzENlzncbqtpL7+ucV+dekrrr1L2EI+SCgpbwlkm54gZWq3aT8otOhzj/Z4opyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042733; c=relaxed/simple;
	bh=2fItWewwxFGqhmsqb2jSiwgO6+kgU3T+Q2F51ZJQ8+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2j9bU7emBls4AEswO9mVTM8OXUYVlznBt1ArD09vQLzQqXq4NuEveoaW6wK6Q1pr2HZHh7/EWx//HuP+ZK750eVDtIEEVl1+J5ZGom2J6KrW0pggr0T3nMXaIWc0TiLz6SimzP3iEt+qHnGuxrx7uzoKGopGz70NZbg4qDSv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDBgWqbA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723042731; x=1754578731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2fItWewwxFGqhmsqb2jSiwgO6+kgU3T+Q2F51ZJQ8+I=;
  b=JDBgWqbAp23Rxe73VNHCfI1z0G+hiOOG35Ekhvv37JNfXTNasP7//s6M
   BgLc1WQowWVwyqgFdX59c03moPXgocakVrKcELsu1K3ckS95Y1yvV549H
   uj9Qv1xTtVei3kxRs+Kh+oqwFNiqBtL02CDcFLg4DRcY9ivJzbtT3aLhb
   HY92Ev3rRnD6pYfJt98FeldPk2MY5fm/FJOWuIwvQS+qdQn9a3f1sNws+
   p9/kV1fDKhy9Ruf9Ik1grglA9j92fuAVwoEwsjlSkwk4yZNweWTE+IgtN
   Df+WECM3wOAQn481nZeDW+ncAp9rlYYNGe1hzWRWQjF/Eo2Ws5/A1kdem
   g==;
X-CSE-ConnectionGUID: Eb9wzdnOQnqxCmcGgqSnNA==
X-CSE-MsgGUID: js2t5FqHQoyM6aeMie5d6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32520886"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32520886"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 07:58:50 -0700
X-CSE-ConnectionGUID: VlmhSiYLTeeDTDHJqqa1uA==
X-CSE-MsgGUID: 0gbQH6ABSa+3Udj6lGs5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56970199"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO intel.com) ([10.245.245.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 07:58:45 -0700
Date: Wed, 7 Aug 2024 15:58:30 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915: Explicitly cast divisor and use div_u64()
Message-ID: <ZrOLlofTKS_xKWrC@ashyti-mobl2.lan>
References: <20240802160323.46518-2-thorsten.blum@toblux.com>
 <CH0PR11MB544400E7751E4A4090DBB387E5BE2@CH0PR11MB5444.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB544400E7751E4A4090DBB387E5BE2@CH0PR11MB5444.namprd11.prod.outlook.com>

Hi Thorsten,

> >  			/* This check is primarily to ensure that oa_period <=
> > -			 * UINT32_MAX (before passing to do_div which only
> > +			 * UINT32_MAX (before passing it to div_u64 which only
> >  			 * accepts a u32 denominator), but we can also skip
> >  			 * checking anything < 1Hz which implicitly can't be
> >  			 * limited via an integer oa_max_sample_rate.
> >  			 */
> >  			if (oa_period <= NSEC_PER_SEC) {
> > -				u64 tmp = NSEC_PER_SEC;
> > -				do_div(tmp, oa_period);
> > -				oa_freq_hz = tmp;
> > +				oa_freq_hz = div_u64(NSEC_PER_SEC, (u32)oa_period);
> >  			} else
> >  				oa_freq_hz = 0;
> 
> Non-blocking suggestion: this looks like it can be inlined.  And if the
> inline route is taken, it might be best to invert the conditional check
> like such:
> 
> oa_freq_hz = oa_period > NSEC_PER_SEC ? 0 :
>                                      div_u64(NSEC_PER_SEC, (u32)oa_period);
> 
> I think this is just a matter of preference, though.  The explicit if-else
> block is definitely clearer.

It's also stylistically wrong given that now the if/else don't
need the brackets anymore, triggering a checkpatch error.

Thorsten do you mind resending it either following Jonathan's
suggestion (my favourite, as well) or fix the bracket issue
following the kernel style.

Andi

