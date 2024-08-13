Return-Path: <linux-kernel+bounces-284557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDC950265
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F15E286E51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795C18B480;
	Tue, 13 Aug 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0YvIW1w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192F208AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544746; cv=none; b=Zh5/X8BY8OAxFgnzldICWQrmN8Kr8Fsiczkm7GXs5cWJLrGE6yGqu418z74EqFsq9oV4EECa050lF+OYaPsgpe+YHzIcaiH1uzjzsoOveAN02jGK1AIQwKy9p6Qu1gMHBfa8sT8E+JGzoJZLBwg2KZte3JqwV1khp7gt5ABhIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544746; c=relaxed/simple;
	bh=Q9WkyHx53MsFELKub6AflyoHbkSjJrwxA9qcqbkaVXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOZKa8JEhqriSgg9+lUx4IcAVZEe7hCPIa0kH7+IW3Pku8LLRlV78gQPWF8t0OP7MRIWPkrxqG+7SVQ5ZWwArUJYpsV41qd6yivy5TkwwSfn0PXXHYwib7Pttw15RF/u6O8c+4miFe+M5PiJ5F6A+/DL9jGa3BvA43YnsSvIZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0YvIW1w; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723544744; x=1755080744;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q9WkyHx53MsFELKub6AflyoHbkSjJrwxA9qcqbkaVXQ=;
  b=f0YvIW1w66e1h8m/SM5jlCuiJvg+SuRJuvs/CBLTCaScU3VhRRKcmNmM
   rzK3q1+4X3T19ajEjd2uIeOaag5KubBWjiax5Nt+xjFE1MCcDa5/B6PbN
   JSFRnBqSoKX8sFEnIHnFGc2X22B7hHOFWVlvQdKIsFWPp3rPnDlOD3C4C
   t/pzzaG35e3zY8W3buPzt8lKZFGnd0KQn/BB5EhAk/ig87rXu5vU1L9sw
   6aosM1ViuIMbXkefHX+Ih+qkQfmPhk9M5EPB0KFGt5qn/2ZHufEZ9EVcy
   aUaguDsu5SZCl9hkvf3FDgaWRdHztNYRHxqrifiQWwaj+1inga2bTChtx
   g==;
X-CSE-ConnectionGUID: CwUfft11RTOzg1VPCMpdrg==
X-CSE-MsgGUID: LDDK4+X3SECzHVJZxL6fjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33080789"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33080789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:25:43 -0700
X-CSE-ConnectionGUID: PJACcPrpTTKypRG/hjEJJA==
X-CSE-MsgGUID: pwrt27J3T6azRNrLAmM05w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63481849"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.234])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:25:39 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm: fixed: Don't use "proxy" headers
In-Reply-To: <ZrscJvDZqMQNFgR3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
 <87r0exs067.fsf@intel.com> <ZiqPAeps9uiG63qD@smile.fi.intel.com>
 <ZrscJvDZqMQNFgR3@smile.fi.intel.com>
Date: Tue, 13 Aug 2024 13:25:36 +0300
Message-ID: <87zfpgzplr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 13 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Apr 25, 2024 at 08:12:33PM +0300, Andy Shevchenko wrote:
>> On Mon, Apr 22, 2024 at 09:49:04PM +0300, Jani Nikula wrote:
>> > On Mon, 22 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > > Update header inclusions to follow IWYU (Include What You Use)
>> > > principle.
>> > >
>> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > 
>> > Assuming it builds, and nothing depends on other stuff from kernel.h via
>> > drm_fixed.h,
>> 
>> For the record, I have built-tested this via `make allyesconfig` on x86_64.
>> 
>> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> 
>> Thank you!
>
> Who is going to apply this, please?

Pushed to drm-misc-next, thanks for the patch.

BR,
Jani.

-- 
Jani Nikula, Intel

