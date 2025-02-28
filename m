Return-Path: <linux-kernel+bounces-539211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA2A4A214
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC183AF4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175751C548C;
	Fri, 28 Feb 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dep51ZPc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F0277034
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768334; cv=none; b=V7U91zC65BObdRS2W3zYqMqscniZd7qRyvOV7vF0wvxD16vGohWiZD6lCDr725cJa4eo2om0k0CSz8qYzRLbSBzE6eZs+ZHizfKhOa2Z+nNvcR50CSqvLBtuZ417LKVPywR11wuuf3EPGB+JaNKVPxv9hsvdOk1t1h3SIdFF9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768334; c=relaxed/simple;
	bh=I9i7WEDJeTbHTS4Sjg3NNb1JSrfW/lMc3q9CM/reqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjpTq5NtlCsCKhh/0P1w2XK/rEwjp+y4GPWAsuxKQ7E4mMWN+OFcc0WxcubgbTPPyyp3RqKvD8yzXX3342+JkjeZetqPmG6Hr1vnw+tbq0yk885GPpawxLJEG6u5p7rGJVmO0SEKqtIDMYGJwbNBdaGGvsglIZ/+ZVh3P+9hkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dep51ZPc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768333; x=1772304333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I9i7WEDJeTbHTS4Sjg3NNb1JSrfW/lMc3q9CM/reqqY=;
  b=Dep51ZPcWX42M7Tf7dL9yFDimJ82UW9h2cZZbUYr2+f+U5mVreK4JvAR
   eG4A96TZbN4VGVTdgS+7thH4LDUlFb4mSJGnP3eRixEQKUvmmV0p5OUOo
   Jz5ZLpMSPd/fmi+7j/vftxk5SONWuJ8k6DOa6keZOdjnR1Iw06iKTXD2N
   aiX5F4oxQV2uE15bP1c07IA9VfT2BgQAqGPZF2xa2IFI3MOI0L3yBS+ya
   5WYDjnRjqnIZvF2KLi3Po++dO7ua/K/jwBccPKhNiOUhrCiCSnUoNO5yQ
   Lz1/Iu6bSrGszQPsTtT3NjboVxrXk6zK2qh+VB6PN0duC+hNVPCi/sCKT
   w==;
X-CSE-ConnectionGUID: /MzceviIRl6FymtdvQwRlQ==
X-CSE-MsgGUID: P7wmp7qMTVi5aQhILHticQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="44523971"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="44523971"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:45:32 -0800
X-CSE-ConnectionGUID: HLl2blIbR8yFHT9Uma1kFA==
X-CSE-MsgGUID: mAYGcmtzQgKlv4s5ufWYCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117437640"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:45:29 -0800
Date: Fri, 28 Feb 2025 20:45:26 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8IERmwHXUuJoD4S@black.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
 <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
 <Z8H1Y2_RlFnXeNEa@black.fi.intel.com>
 <Z8IDXD2bkO1t71yB@smile.fi.intel.com>
 <Z8IDgmrLx5DQADxJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IDgmrLx5DQADxJ@smile.fi.intel.com>

On Fri, Feb 28, 2025 at 08:42:10PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 28, 2025 at 08:41:33PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 28, 2025 at 07:41:55PM +0200, Raag Jadav wrote:
> > > On Fri, Feb 28, 2025 at 06:11:16PM +0100, Arnd Bergmann wrote:
> > > > On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> > > > > On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> > > > >> This series attempts to cleanup io.h with "include what you use" approach.
> > > > >> This depends on changes available on immutable tag[1].
> > > > >> 
> > > > >> Although this series is too trivial in the grand scheme of things, it is
> > > > >> still a tiny step towards untangling core headers. I have success results
> > > > >> from LKP for this series but there can still be corner cases. So perhaps
> > > > >> we can queue this on a temporary branch which we can use to submit fixes
> > > > >> in case of fallout.
> > > > >> 
> > > > >> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> > > > >> headers.
> > > > >> 
> > > > >> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> > > > >> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> > > > >> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
> > > > >
> > > > > I believe Arnd can take it through his tree for headers as DRM part is 
> > > > > Acked already.
> > > > 
> > > > I've applied it yesterday and not seen any regression reports so far.
> > > 
> > > Probably because the immutable tag is already in -next?
> > 
> > Is there any?
> 
> Ah, you mean devres related?

Yeah, couldn't find it on Arnd's tree and I'm not sure if this series
works without it.

Raag

