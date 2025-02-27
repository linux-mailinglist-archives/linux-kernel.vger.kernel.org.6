Return-Path: <linux-kernel+bounces-535605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF19CA4750B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0C188B668
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27C1E8344;
	Thu, 27 Feb 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuV5TBOr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D93209
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632930; cv=none; b=HCVzlpX/WCxIf5tHriQoe0DgP5Z4xfZh01bEWa9tQ7z/Ze/yCHek3KxlGYKQQvke51yA8+Aje2Rv1vKmezoUXAstEAq8RY/fDiQdhliuXK8ztDn5cpFgy41IofT4Xv2GheRzBg+EYC4v7mfv8QFw6+zJ75gD1DOrBZWunJ5tM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632930; c=relaxed/simple;
	bh=NDDgMeJgLCAZUBxSybshIV85+zSQmnmQCi6nuFmjIoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9Kvtnlyk0FnQ5O32lq89a2Zr30c+XnydIF6eZhfWMKM+qVuxaHUXwkW2HSuVT2NhLuhI4RNFR2x+6VOtnirKroodkswBj7UpJG5XJoHaRtfkmUrXRHHoIuI14A8N6EcvtuE0Ly6YDzr9onEtKZBlItWNHemq71soHPrwJhchYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuV5TBOr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740632930; x=1772168930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDDgMeJgLCAZUBxSybshIV85+zSQmnmQCi6nuFmjIoU=;
  b=RuV5TBOrPsybsSS9l5E/U5a9a4rWz0Vffnb2AnhisPtM5BRg4YH2AFLl
   +kCbbtssQd+hK5PURuaDx3IfTAzkTOdfaHg0tVwnPU5P+hPkfghu33DyF
   vNvhjHWBdRmeIZZrt/dAgqTtNI42PFQ7H9i+dQQFtUzvdUNj81Sy7yq0H
   UfdX6sIlZP9pL/sKW3NN66xn47d7B5ViREql3uGGPnQhz1RsKuYAFT40u
   ECiYgu67w9stCpfVFdTzcSoDWqJK6QKP+3JKDrgfcR/S5pDKBGHrWLfPR
   4QuzH0ljMME9IXXDLC+DfffrxOiEb5WLJZuTnoic7jq3sMX4+7k/Ie518
   A==;
X-CSE-ConnectionGUID: Y71rQvxqS8qGtYuObxgMwg==
X-CSE-MsgGUID: fSte7hhLQD+DzssOWBqrRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41637807"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41637807"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:08:49 -0800
X-CSE-ConnectionGUID: UPvUqPgfRw+NzTbI+bhAKA==
X-CSE-MsgGUID: f6WXdPd3T4KzZMJQKvfQZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117405986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:08:46 -0800
Date: Thu, 27 Feb 2025 07:08:43 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] pps: generators: tio: split pps_gen_tio.h
Message-ID: <Z7_zW3rlWtZZ7BiM@black.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-2-raag.jadav@intel.com>
 <Z78M5iTHgdHnqbz2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78M5iTHgdHnqbz2@smile.fi.intel.com>

On Wed, Feb 26, 2025 at 02:45:26PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 26, 2025 at 11:45:24AM +0530, Raag Jadav wrote:
> > Split macros and structure definition to header file for better
> > maintainability.
> 
> > +#ifndef _PPS_GEN_TIO_H_
> > +#define _PPS_GEN_TIO_H_
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/pps_gen_kernel.h>
> > +#include <linux/spinlock_types.h>
> 
> This missing time.h and types.h.

Aren't they guaranteed by hrtimer.h and spinlock_types.h?

Raag

