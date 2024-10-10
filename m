Return-Path: <linux-kernel+bounces-359205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601129988AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E5AB29BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A01CB524;
	Thu, 10 Oct 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agTfd7tU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1801C9DFC;
	Thu, 10 Oct 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568954; cv=none; b=j6R/+HDjnvwF89PDRRpV1cGA7RvwmbN/95Jix7R2D++uBHo6zLi8xCMJaFE0PuDmCeHrXDbdZzVH3P70uzW626JrEeNnN07hMGUZ10FN37GnLZLCLvj9hwZ91KoiRGhiL02DCChaUUJvPy4PgASsyPn4ifRcEodTJtvGbVj1i/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568954; c=relaxed/simple;
	bh=qc+c7upa6u//iAYuKNiHURLkJCG0QR3yUpeIWwmRxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7fGkIgYPtIq7/rEoXCWnqkQtuYWGFmmP++tvNLvbg3heqiaWMEmY8nizdEohgfnW7fYa9ZjV18Wd5FmeikInoiap/A7Bo5by3SgYqD8JdkpF1RGYdpi+7fVxKAqmF2y5LEUitVarXq1cRk457axfhCKbrQ9u0/Z8jaZ7GPsc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agTfd7tU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728568954; x=1760104954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qc+c7upa6u//iAYuKNiHURLkJCG0QR3yUpeIWwmRxfs=;
  b=agTfd7tUFnTXB7p2vFtehE/wTwRpvEzZhlm2Sc7PqOq3zorNeiuszBr8
   +61BGgsAxXJdY5HY9SNqblTaQhQMO+aR7VRHcietgGYviY3JganDkoj7R
   KtvpsX1lQd9dvnqAd071FOSBrZa3ND6v3UjHeaI1UPa+8khpplRIZREfo
   O4zN2ZLFpiK4S0z4iXP/wxggGWXbw8wDhVeqwCoUC7xfnhJr0vCrZp2zP
   fj2zJsGt9viOQBbNY0TrSwZH2vmwAoSYMIBDun8F7o19xRoQ7Uzb4LlWV
   vOh07NvikqjcouLUusXJEzpChw8sCJfCRJkp6lR+EjYqB8vRTqNLdszX7
   Q==;
X-CSE-ConnectionGUID: tZUlWOMFSxmcnWsyhBwcbQ==
X-CSE-MsgGUID: nzjENuDCTMiiAWwT4EVh6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31822812"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31822812"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:00:48 -0700
X-CSE-ConnectionGUID: xnRaNaP4Ski0hc2pAhvUgg==
X-CSE-MsgGUID: NQKHUR6LQreeR3iTAug+TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81401717"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:00:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sytic-00000001YTH-2qBL;
	Thu, 10 Oct 2024 17:00:42 +0300
Date: Thu, 10 Oct 2024 17:00:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jai Luthra <jai.luthra@ideasonboard.com>
Subject: Re: [PATCH 10/13] media: i2c: ds90ub960: Reduce sleep in
 ub960_rxport_wait_locks()
Message-ID: <ZwfeCoXbv4mo8T1c@smile.fi.intel.com>
References: <20241004-ub9xx-fixes-v1-0-e30a4633c786@ideasonboard.com>
 <20241004-ub9xx-fixes-v1-10-e30a4633c786@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-ub9xx-fixes-v1-10-e30a4633c786@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 04, 2024 at 05:46:41PM +0300, Tomi Valkeinen wrote:
> We currently sleep for 50 ms at the end of each iteration in
> ub960_rxport_wait_locks(). This feels a bit excessive, especially as we
> always do at least two loops, so there's always at least one sleep, even
> if we already have a stable lock.
> 
> Change the sleep to 10 ms.

...

> -		msleep(50);
> +		fsleep(10 * 1000);

USEC_PER_MSEC

Can also a comment be added on top of this call to explain the choice?

-- 
With Best Regards,
Andy Shevchenko



