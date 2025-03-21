Return-Path: <linux-kernel+bounces-571866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27EA6C359
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0316189BD17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD730225A20;
	Fri, 21 Mar 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4PaQ799"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8322C35D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585475; cv=none; b=UOg4I8KSOQSDng/GNSwP1Nl4TGFJA4B5LBgaKrTouQjF/F6dSp33N0ZyB/afv/xvljF9UXgU29fYobxL049VJbpFu+O/Z7fcTuT2znPi+HUdzRVd+XwzFjXYOfajneCrqW46YHfU7pluV+U40UblwElDLqGljSnIXJ5IUkW827U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585475; c=relaxed/simple;
	bh=TU+4P72CTJfVNP7+no4HhfCPdFLjeAD8PbJh0fR4i5c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH/f1PhILtIKGhrwcL7MQlE/z3d8MV7kgWXjTMqq9fyY5sGc1jQ8hRsMXhIlI6PjKtTh0ywBN9ZCstxpU6VZS95MhgPcegOgEu2n/es46GhhUZmSRBLKuqLhmff1Gwr6IyHxYILsYWgaJxE+6v2h1eRDbhhSeHxxLlGHmAiWkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4PaQ799; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742585474; x=1774121474;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=TU+4P72CTJfVNP7+no4HhfCPdFLjeAD8PbJh0fR4i5c=;
  b=f4PaQ7993+f/XXDTFb8cEZowM+uC+VXVyt1+yO4Z3wL0+11kDYommMeb
   CRl3jCrPAmkEsZ82bv5CHzvD0ucdGxiqER7LxLfeWtS7K/NVtCjoR+08D
   JC/yBvdcHYDdLhnICAm1SHjFBRFv0PrUnmvVrAGlaHK3SCfBfZtKEcNnU
   6QrGmrLylS9VGQ6jK5KgHsgjma+z5QEgzpMt3dWESnXNPW3AePiVdDmUk
   XC9KbsJ/d5YtnlwZK293l/skq9hdLbETeqkb4OmS1xLXrb/SVn2fe5BFg
   RRuHylsKkbMk3hmM5P2ppjFXfD58zkJwUeyTWIGc2Yc3wh+g9EKgLBFNS
   g==;
X-CSE-ConnectionGUID: OPFhfyxHTiypbedtVDu5sQ==
X-CSE-MsgGUID: GhxmNAp0QzSFfnjWW5T8DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43879737"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43879737"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:31:13 -0700
X-CSE-ConnectionGUID: h02yA1/HTkWDcX1DY1ghlw==
X-CSE-MsgGUID: DAJqzZMRTCC4OTdRnbDCAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="154383976"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:31:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvi5F-00000004blC-0IBO;
	Fri, 21 Mar 2025 21:31:09 +0200
Date: Fri, 21 Mar 2025 21:31:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i3c: master: Drop duplicate check before calling
 OF APIs
Message-ID: <Z92-fNE5hrX7Oy0g@smile.fi.intel.com>
References: <20250321192527.457324-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321192527.457324-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 21, 2025 at 09:25:26PM +0200, Andy Shevchenko wrote:
> OF APIs are usually NULL-aware and returns an error in case when
> device node is not present or supported. We already have a check
> for the returned value, no need to check for the parameter.

Ignore this, it is partially done.

-- 
With Best Regards,
Andy Shevchenko



