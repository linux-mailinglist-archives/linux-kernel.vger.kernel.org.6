Return-Path: <linux-kernel+bounces-295719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB095A0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6932876FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013271B2516;
	Wed, 21 Aug 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRGW8nDA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C0364D6;
	Wed, 21 Aug 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252320; cv=none; b=M0BNqC3kc//WnPZryZy3cr/DFVeUri6/GNeva/ttedI7WlbzmZxkkgTNczrTZ+1GIgYR8buElMMwlKilSK1k6rsmGtDmXTNeZQdaMwzYhpcqoVoUMBACwtquwWq/LAYBmjxHPgHRSvyeuvdD27k9Y3TnKM9dFmOlGDO0bsKj0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252320; c=relaxed/simple;
	bh=SY9ETdA8yCdgJiCqRdXiEsxxrktg3vC2SvzDdQORJJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGwW4t5j9BoKZa5ywmiEFDZLUeZUEXryiCaFOdO31VU3QDF3yTnAdP77wSi3ogUnAnzD2GIj370akcj3IifeaboktEkbmZi4DhcDdJ4vv7MQ/gk6oWyMgBDuUgK9Hc4OdGOUyz1pJf/gclwL0LwexNxoZxT3UbMKf7E5wEK9YEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRGW8nDA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252319; x=1755788319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SY9ETdA8yCdgJiCqRdXiEsxxrktg3vC2SvzDdQORJJ0=;
  b=gRGW8nDAc4TwnXrZtowDjZWNGCRFKoc5xg+ybtr2T2x5sK8xOAJUqmQR
   +OBpyEtDzRohHaHEMbertWpHUETnNjJKKxRpcZcim6jSR84L60qWvfzE/
   2q85kXinK048ylx6BC57Op+MryoBgZH377zb4VRn7xbNsNmxyStXwwewa
   CpfBU8Yj8vExhi+vuELlc5xKxE6hXjRkKaP28DX2tvpSAc95gJHAqg+B2
   2WL5eDN9XtKPFxQxaqFzwNCsCt0cLpisZQ2og7HZkrUUlBBITQrwyK/v4
   yPjqHgEfJxf4/9SAC44HqjBJ3VgM4A3lNQwny0JfD7Hwrj18QNlgb9pdz
   w==;
X-CSE-ConnectionGUID: pMGnUch1TMa6bVUaLML++g==
X-CSE-MsgGUID: oKXVto7uT3u7r+FRwoZKYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33768656"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33768656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:58:38 -0700
X-CSE-ConnectionGUID: Xs4IGRm+RlKOiLFrRKdAXQ==
X-CSE-MsgGUID: CvC3qcL6SvSpU6QwOm8CWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61143035"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.24])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:58:31 -0700
Date: Wed, 21 Aug 2024 16:58:28 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	linux@roeck-us.net, andriy.shevchenko@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v5] drm/i915/hwmon: expose fan speed
Message-ID: <ZsYAlG_4MOUagcGk@ashyti-mobl2.lan>
References: <20240812081538.1457396-1-raag.jadav@intel.com>
 <ZroTN3UudwvIJ7oR@ashyti-mobl2.lan>
 <Zrr9fobk-zahLpIO@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrr9fobk-zahLpIO@black.fi.intel.com>

> > > +	/*
> > > +	 * HW register value is accumulated count of pulses from
> > > +	 * PWM fan with the scale of 2 pulses per rotation.
> > > +	 */
> > > +	rotations = pulses / 2;
> > > +
> > > +	time = jiffies_delta_to_msecs(time_now - fi->time_prev);
> > > +	if (unlikely(!time)) {
> > > +		ret = -EAGAIN;
> > > +		goto exit;
> > > +	}
> > 
> > Can you please add a comment describing how you obtain the speed
> > calculation?
> 
> That's what I initially tried but ended up dropping it in favour of RPM
> formula below, which I found to be doing a better job of explaining than
> a few lines of description.
> 
> > Basically at every read you store the values. Is it possible that
> > we don't have reads for a long time and the register resets more
> > than once?
> 
> Considering a fan continuously running at higher speeds (for example 4000 RPM
> which is quite optimistic), with the scale of 2 pulses per rotation, a 32 bit
> register will take around a year to overflow, which is more than most usecases
> I could think of.

Which can be considered as a worse case scenario. I would have
preferred here a runtime calculation, which means read now, wait
a bit, read again and calculate. The read might be slow, but
efficient.

Anyway, your argument makes sense, so that I'm not going to push
on this, I already r-b'ed it.

Thanks,
Andi

