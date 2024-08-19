Return-Path: <linux-kernel+bounces-292377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C218956EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8030F1C2216E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6627A3C463;
	Mon, 19 Aug 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT1Rsg+D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5F347C7;
	Mon, 19 Aug 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080959; cv=none; b=sFG7Ew8xnjo9p+ADjU0aovW5yghWGvflhhTw7n09SxaTpqj1sRCMDEtzPnoBCXIRlJHVMpEpPzigZmI6MQukJDkC5F3K2u/+lnIQkGSTB/HRiPDbUp4O7mJyNXUBtIjHZkgbmx1Eud9yTe/y8mejtSpVjSly/h35rdgXNnfwYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080959; c=relaxed/simple;
	bh=9JWfjIa1vdn38FsVkvDYMYCfzjwxvlY4s9IpqPG8eFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjUGT8VYZ2LTi9JyHJtCGPG05IXD7tAkRqwTzdA+59vvPzZ1HBanlXM9dumA8zq0KBOVtLBPG06SV1nqDv4bCmMKGXmcss11AH4zkORSIfuJnVA0Zh9idibN/nZyTS+tMVfVIh00yzZ6DD43y0YGNiQwb4W5x0LDlW99ZDwk7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT1Rsg+D; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724080958; x=1755616958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9JWfjIa1vdn38FsVkvDYMYCfzjwxvlY4s9IpqPG8eFw=;
  b=mT1Rsg+D2pL1acEAH6ht/Asb+9tHyPdcpMiKrHNKd1ARNUFt7HVwytuJ
   Mq51kl4UfiAD//GKh/ah0AiECv3O0pU6n2nRGrV9q4hxe5t/cdibrQwOU
   CP+2AyqFGVazIIpJzdBIlSmZkCc8txKpWhJn6cIxYdY8suJvPEHiu0eRy
   kueWrk4JBbI60wmLq90jyRlB3+am5RdEKm92MWFca4lDBmgzIZI+66fGB
   51ATZRC+JfloXVfX3iDs24x330KWnueQY8dNFXvJtGutRO+H/h6c1mkmF
   Fz7Ei0YFi1l0OR8QDR71fUC22XcVOJGo2Yu7E80LAzd0g+d1kdjnlDvCT
   Q==;
X-CSE-ConnectionGUID: bvBpU9KvQUWfsWSIqkQvXA==
X-CSE-MsgGUID: k2rNx8dHRDyIApqS9e3+qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22509903"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22509903"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:22:37 -0700
X-CSE-ConnectionGUID: h/Lf2QjnTJWLwtRYtsKpRw==
X-CSE-MsgGUID: FkCpXxoHSjSKEccMTCJLlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60068171"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.73])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:22:32 -0700
Date: Mon, 19 Aug 2024 17:22:29 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Nilawar, Badal" <badal.nilawar@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZsNjNSu5tCsRUxJ9@ashyti-mobl2.lan>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <23dc7824-50cd-4ba3-be5a-df141e8fe69a@intel.com>
 <ZrXslA1c-BhO6zYr@ashyti-mobl2.lan>
 <88320f60-d55b-4aa5-881f-530375659c27@intel.com>
 <ZsLrJVdBmfZhZaaR@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsLrJVdBmfZhZaaR@black.fi.intel.com>

Hi Raag,

I'm sorry, I missed this mail.

On Mon, Aug 19, 2024 at 09:50:13AM +0300, Raag Jadav wrote:
> On Wed, Aug 14, 2024 at 02:07:44PM +0530, Nilawar, Badal wrote:
> > On 09-08-2024 15:46, Andi Shyti wrote:
> > > > > +static int
> > > > > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > > > > +{
> > > > > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > > > > +	struct hwm_fan_info *fi = &ddat->fi;
> > > > > +	u32 reg_val, pulses, time, time_now;
> > > > > +	intel_wakeref_t wakeref;
> > > > > +	long rotations;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (attr != hwmon_fan_input)
> > > > > +		return -EOPNOTSUPP;
> > > > Using a switch case in rev3 is more logical here. It will also simplify
> > > > adding more fan attributes in the future. This is why switch cases are used
> > > > in other parts of the file.
> > > 
> > > it was my suggestion and to be honest I would rather prefer it
> > > this way. I can understand it if we were expecting more cases in
> > > the immediate, like it was in your case.
> > > 
> > > But I wouldn't have an ugly and unreadable one-case-switch in the
> > > eventuality that something comes in the future. In that case, we
> > > can always convert it.
> > 
> > My rationale for suggesting a switch case is that in the current alignment
> > hwm_XX_read() function is designed to handle all possible/supported
> > attributes of the XX sensor type.
> > With the proposed change, hwm_fan_read() would only manage the
> > hwmon_fan_input attribute.
> > If a single switch case isn’t preferred, I would recommend creating a helper
> > function dedicated to hwmon_fan_input.
> > 
> > hwm_fan_read()
> > {
> > 	if (attr == hwmon_fan_input)
> > 		return helper(); //hwmon_fan_input_read()

I'm not really understanding what is the point of the helper, but
if it looks cleaner, I have no objection.

Thanks,
Andi

