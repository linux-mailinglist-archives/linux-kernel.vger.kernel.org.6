Return-Path: <linux-kernel+bounces-557933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD87A5DF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5667D7AE220
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA82451C3;
	Wed, 12 Mar 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+hrYdOG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46701E5B7C;
	Wed, 12 Mar 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791134; cv=none; b=KXws7XFcFIVrS/MGmgNVYoOF+WYvHcKTxWo5NTXaiyIoTkdyM66ppdC6hjFufLxUVEAWXilGdVTxIgX7e0OScFCiKZOVUt9kx560MvZQWGZaYb/uAT8CQKDdcbSd93DKiFIvKRgOkWSqotVuKDmcc76kMkfOxeeCMFVAlMXINd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791134; c=relaxed/simple;
	bh=j1+DQrW2hu38Z+BntXeNALD5D4vpTA/plK8+3CxmS2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ5sKgzL3F3Z5ypc1J6lgB1DGLFBSPZyXDFHfCpj2iHvkYHdgm8OOUe9OJ5o3nBVanBH7xoVuZUAMJMfeelqHo5OakUuN7YO4tO8GG+PJkt+KScrw3QuKiWpt8XOss2Xe5ErAozmIFdyne5e+0kXjy0WD7r1QSbpptcQEOE52Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+hrYdOG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741791133; x=1773327133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1+DQrW2hu38Z+BntXeNALD5D4vpTA/plK8+3CxmS2I=;
  b=n+hrYdOG03wrJNFg6SNT20GDRMzAoNZU998s03wQTdmRhUWtf4QVBv3L
   icOrX4F2HiPmrYaWnV8CNjTgpu72Dlg6Ge8B4pDnIXol6uerCpR5vxLVd
   YXDSgpoLa2j5r8KmgwGnNh4521k4fW4j5WZojROreC2d7Qhxz8MgS497f
   QrV6V8twFnsuvCiJSrtSpMHT9wDX8mnGY32kDpgsAsrURFcQRw2h93mWF
   KMn+cLlvlZxv6Ou917/L//3ZGyK+13yYWLnv0IyKZ1u/1sMc8kqVghTsF
   2ZV1lJti12g4Ja65sB6FZO1cjY6HDlIjk99y+NGKNOPQ8P/c1glR9Wxc2
   g==;
X-CSE-ConnectionGUID: 4JfMrWb7TVuGVtkA3pjVbA==
X-CSE-MsgGUID: xj7Xb7yqTzqsCd2NLx5mRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42600339"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42600339"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:52:12 -0700
X-CSE-ConnectionGUID: L65x+ikNSseKTt09nxHYjQ==
X-CSE-MsgGUID: Fg9byZGeRBm4zhT4C3KFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125842851"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 07:52:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsNR9-00000001tVs-3Stg;
	Wed, 12 Mar 2025 16:51:59 +0200
Date: Wed, 12 Mar 2025 16:51:59 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Aditya Garg <gargaditya08@live.com>, Aun-Ali Zaidi <admin@kodeit.net>,
	Maxime Ripard <mripard@kernel.org>,
	"airlied@redhat.com" <airlied@redhat.com>,
	Simona Vetter <simona@ffwll.ch>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH 2/2] drm/appletbdm: use %p4cl instead of %p4cc
Message-ID: <Z9Gfj_f0Ug7vLIfd@smile.fi.intel.com>
References: <ABAEA9D0-97CB-4ADD-9606-A12D5815335A@live.com>
 <33F3F7E2-24AE-4F29-9053-3B502D075BA8@live.com>
 <be2f49b5-dcdc-4954-b650-90670dfa70b9@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2f49b5-dcdc-4954-b650-90670dfa70b9@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 12:51:33PM +0100, Thomas Zimmermann wrote:
> Am 12.03.25 um 10:06 schrieb Aditya Garg:

...

> If you want to print out protocol-header tokens, why not use formatting
> macros as we do with DRM mode? There's one for the format string [1] and one
> for the argument. [2] It's not as fancy as the conversion code, but you'll
> get something for your driver that is easily understandable.

The benefit of the specific code formatters as in this patch at least in the
stack usage and hence a lot of code generated again and again. I believe you
can get rid of dozens of (kilo?) bytes in DRM on top of compensating this in
the printf() implementation. This backs us to the discussion on how the best
would be to implement custom printf() specifiers...

-- 
With Best Regards,
Andy Shevchenko



