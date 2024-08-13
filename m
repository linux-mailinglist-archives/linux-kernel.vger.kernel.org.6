Return-Path: <linux-kernel+bounces-284831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2995059B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE15284864
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0119ADA6;
	Tue, 13 Aug 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwLVNos1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715631993BA;
	Tue, 13 Aug 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553615; cv=none; b=eKR1ArHv4ntgkqzdJncpJgZWzW2Y5/0Fwp9SgpxWkFA5b/6GVnooAke1XuXyN3lrHqpG5+jQEZ0jmJxSah9x5sSsdKCZKy3EFCoU9uQRSer/uIhmSyC5AhLlRXLqqh+7fcdPF9gaQi0hRz7R20kFNnit3WvVbFiH+6FeKYyNX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553615; c=relaxed/simple;
	bh=s3WViNmjNJ6o3NfDc+gVFx6Ybq9EcXt5R1mltnGBdKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOLJPB7NcVyCOe5P+kQ6tN+ggxihUXBHSIj0KNHQUSiKGE68RX8h5gRTbYlwfc5/cclurs6f8+PUkqbGHN8kf3W4bfsLzKk+NKrt4XOnRUKJ7gv1FKmt64+W8TmAqoFCx/Tlq44zojD/4IPzLrmtkRsaILFS5y93Tjn4eohkA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwLVNos1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723553613; x=1755089613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3WViNmjNJ6o3NfDc+gVFx6Ybq9EcXt5R1mltnGBdKE=;
  b=FwLVNos14bauskWYbsW4bstXfRkXT2Ri3Ts4Ch9vjaIhDMMwxDLuz0DY
   R+so4HEJKsnv2WDfvRxSbOXOb0PLs+BjHjQJWkXOrSjBK6chnE2WBtsZ0
   iaDRpfFubCSAVpnQ+ktk/NqQbFSOS6lLMYyOtZX+E28K3NF1qJrbqOEje
   tpUQwtViHKuhJQVq+JK75FeYFUpsteQDPBwaw2BQSoWvaiX5TGPcawN7N
   7VhDQufxFc1pCOe7glliGB+/Oz1gubN6KfrrtU42IIRUAZRtlvDYzoNWV
   FA+moG+J00JLEwtVMT2GdkEEmMJNgJcyivkjZHaXCupKNY3SLNFp+qqKu
   Q==;
X-CSE-ConnectionGUID: q6YUYli1Q9SKs7+UwEJ0cg==
X-CSE-MsgGUID: FsmOBv+RSNG3nPCDoF+2FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39163793"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39163793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 05:53:32 -0700
X-CSE-ConnectionGUID: qW8nmxWuQcCi7KvEjkkwXQ==
X-CSE-MsgGUID: YBZBrvvTRwmZiwNFcbn3DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="96189629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 05:53:28 -0700
Date: Tue, 13 Aug 2024 15:53:25 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrtXReujITKx4rHH@black.fi.intel.com>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
 <ZrtCIU8On4ZKILmh@black.fi.intel.com>
 <ZrtHz1aY_Lf_XIsL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrtHz1aY_Lf_XIsL@smile.fi.intel.com>

On Tue, Aug 13, 2024 at 02:47:27PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 13, 2024 at 02:23:13PM +0300, Raag Jadav wrote:
> > On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> 
> ...
> 
> > > > +	/*
> > > > +	 * HW register value is accumulated count of pulses from
> > > > +	 * PWM fan with the scale of 2 pulses per rotation.
> > > > +	 */
> > > > +	rotations = pulses >> 1;
> > > 
> > > In accordance with the comment the
> > > 
> > > 	rotations = pulses / 2;
> > > 
> > > looks better.
> > 
> > This change seems to cause a build error in v5.
> > Something to do with __udivdi3 on i386.
> 
> No, it's not this change.
> Please, read report carefully.

CI seems to point to DIV_ROUND_UP(), but it's been there since v1.
So not sure if I entirely understand.

Raag

