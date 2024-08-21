Return-Path: <linux-kernel+bounces-295715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCC95A074
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990B81F21630
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1B41B250A;
	Wed, 21 Aug 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmZNVl74"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F01D12EB;
	Wed, 21 Aug 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252014; cv=none; b=JG9Me+WpxY9EWjD9qof9eW0iG2+0vs5kFzJEytlgJxPcvNt3KVvyl4RrcTKOp4TYefLbWWvIJK4TOEoEUGPEf132CmPI6BAQeutSPz1KTsQPcA65weSDmSd6g6prtWcOSg2jXpJreEb3oVGQm9VNBu2qQbMEi44qFjVOmWvNF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252014; c=relaxed/simple;
	bh=3a0SdQK6D0YA6byEu0/lPMYxzVJPB+w3eSkokFrQBjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+Hy++1s1m4NTuLmlTdzMnaivILz1mAaCCqiTSeMkQyFc8/ytd4TAi5HQ8+kf95LCqg21p/5GocpnPhEUTle43PfaKttrbWGVHAoaPWTBo6AaHna7BzPe6GilziapJZRfIvhiRhN8NXxo04EL1Dcc1nEvzaAhlxaQ3ttB/0D5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmZNVl74; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252013; x=1755788013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3a0SdQK6D0YA6byEu0/lPMYxzVJPB+w3eSkokFrQBjU=;
  b=JmZNVl74ZUpdl/4dblpFsjvKF5mLTsBLG9gHZ2Wf76e8SKOm2G3+rPlg
   9BUGbwTGUaCU9f4KgW+LSjI1MqRCeGXCJBjoo3bedGLbsKXcgmbLNYcdD
   sEc93fGjT1q/pz0ixr04/7OE5qrTuP6/VnwyEKcX/cQs/7L8ALsVQWbah
   fcV13faxRrAuOMIfHmeqDwrqAYcpJncZcMIYsicXNMtLEEhf/uz8ud+UA
   2zt6ciBMYpmZZ5GAbDk11Jh5TSVb7CLrdIrH6xWkQw+W8+sjlSpCmjZuv
   2yD3GMe5liibtAwppnHxWkl0YptBp8woy6SXnhnzf/JLEV/ZAvpC8VL/z
   g==;
X-CSE-ConnectionGUID: kSCFfSdNS0+kRYeIvCLofQ==
X-CSE-MsgGUID: +XSKwpqRTXuXnSI3F5wQ3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22485380"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22485380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:53:32 -0700
X-CSE-ConnectionGUID: oUecD+0yQj+/o1QqWqbWdw==
X-CSE-MsgGUID: TyIrDd9fTouo2NLbve1AkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91905505"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:53:25 -0700
Date: Wed, 21 Aug 2024 16:53:21 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	andriy.shevchenko@linux.intel.com, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	badal.nilawar@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com
Subject: Re: [PATCH v6] drm/i915/hwmon: expose fan speed
Message-ID: <ZsX_YQLPogCSPfSQ@ashyti-mobl2.lan>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820062010.2000873-1-raag.jadav@intel.com>

Hi Raag,

> +	/*
> +	 * Calculate fan speed in RPM by time averaging two subsequent
> +	 * readings in minutes.
> +	 * RPM = number of rotations * msecs per minute / time in msecs
> +	 */
> +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);

once you find the correct operator here, please feel free to add:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Normally these get me confused, I'm happy Andy is looking after
it :-)

Thanks,
Andi

