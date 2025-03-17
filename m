Return-Path: <linux-kernel+bounces-564772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D972A65A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CD13A936B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41BE202C2B;
	Mon, 17 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEtYwJY0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57581A0711
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231649; cv=none; b=IJoiF5z77qd5euE9OMmzTG5xpNFqH95Pyd3w/fG8R48H+SW0ALhxcTZgJMVplcWahojXs9AKCxGWhTK7b/Ud3pSON+Si4/SxiFm8+ktA0uQFJw92BfRaPhy9OTsfTjM9HRf1G4NjSXGVEA359d0ClmUQpphySXsMioegyYUEd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231649; c=relaxed/simple;
	bh=371ak7RcCXM5C96E3PqJ36SNi+U1cjIckUyTowqGBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB2Tw20lcz1JoDQoQEoezhvz6Xy1M654AV549pi1vjDjmtL3yRfPis1OtvmVyS3UnbBiUBGI7wbRnuvZFtGz1sh8cdfNZrnCh2GWPqv6r033oVA7mBYSqHgi84AzIZkYgVl8GnsZBWY6cX/ZaHQzskW0ABzQxvFASkOCQRQpQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEtYwJY0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742231648; x=1773767648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=371ak7RcCXM5C96E3PqJ36SNi+U1cjIckUyTowqGBvE=;
  b=VEtYwJY0eEDOx29i8uZ+N4n/5qVDLOrRkbY0zFtKnNbGG3Nm4Ltd+tly
   ZF4rxX3OCIG1w1hoGlWyGSiMIjeM2hoYWROl2BIL7+w/tX3egtDVzOrkw
   YvP3omPM/k0OaD4/fd4Eepj3MPnm6PR5u71a7ftYJc6zFcXSJB4j91WGZ
   eNtmpdBVM98M7nLizUJXEFhxmoZ+CBXKNFin9nULO1VTD8PF3Kzw5G93H
   V815uSEAbWXIi4isnMC8TD7RgjmXshstBWA678wePc0fxIhNf9lFO7oBZ
   GgaDDqVmH3I3TRhaDN2U7v4XZ4MF8i52+OldPckkLKl0tmL0ouslL5HVA
   Q==;
X-CSE-ConnectionGUID: yINHcDAQSnStaa0eKIl2Rg==
X-CSE-MsgGUID: t595jL1YSJGrCG4okDrw3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54722601"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54722601"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 10:14:06 -0700
X-CSE-ConnectionGUID: 29f+JTM9QAO5TseZce77cQ==
X-CSE-MsgGUID: B7cKdnhzRAOed+WSO1C8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127087139"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 10:14:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuE2M-00000003Mrc-2rrz;
	Mon, 17 Mar 2025 19:14:02 +0200
Date: Mon, 17 Mar 2025 19:14:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] resource: Split DEFINE_RES_NAMED_DESC() out of
 DEFINE_RES_NAMED()
Message-ID: <Z9hYWmULAhgUMEVc@smile.fi.intel.com>
References: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
 <20250317095654.28fee435e7e29712006682d6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317095654.28fee435e7e29712006682d6@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 09:56:54AM -0700, Andrew Morton wrote:
> On Thu, 13 Mar 2025 18:09:40 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> But the new DEFINE_RES_NAMED_DESC() has no users.  Can we add some?  To
> demonstrate the usefulness of the new macro and to test it.

Sure.

-- 
With Best Regards,
Andy Shevchenko



