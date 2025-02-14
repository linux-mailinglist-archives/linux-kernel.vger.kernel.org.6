Return-Path: <linux-kernel+bounces-515147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D24A360D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863BD170B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A10266592;
	Fri, 14 Feb 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDJH8cDW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185726618A;
	Fri, 14 Feb 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544905; cv=none; b=hPUv7gKBZMhfooxd6/ydfTYSB4zvnwyIlyzAoQ0wb3M04l7R0OHhp5yLlDQuKsflBw0ZhDZlckU5v8Skj2yYxz3FLMjXgxTDCF9X2wWib+eLp3zeJQDVjYMQEC9lNcGinH3Uf5gqRhv3Qcd9YdR3Ul9Uld7t9rGFCVl8Gw5XV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544905; c=relaxed/simple;
	bh=+zgSUoD1ShIEcMj3y0fZlj2imD/ikcTmN0PMrxfOaFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOGNRKDz3RFovHjpz5DkT7bAcGt53wiki9lQu3UjncqDuwgFr4hQhBS2cRFBNfSNuZ4wzElDz2QiPGPewf7/lqM1zpewiEX4kOH0bmhYeFD7JIeHzBlblcPHL3gTWrR8nRi+33sN0ipNNBJ1kqMvj58WJ3BxeTY2LHNVZFEdtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDJH8cDW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739544903; x=1771080903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zgSUoD1ShIEcMj3y0fZlj2imD/ikcTmN0PMrxfOaFU=;
  b=iDJH8cDWJIG8sRD8AriNkpaAAT+cqXNC2XpNZBKSe+yW0c6agoQ64vcU
   bdY8ENoWj8SR1PSI8yD+CgxsumozpGIoFhqdQoY1PAly3rbokBZaJnsly
   bFbbpNE52ZxCSr3EQfjf8oumzZTTD+GdDAd12H9+/rWQJR+Ky/eZlphM9
   dtb3e0MKdyXXN/BOTmbUZ9b39uBwx3tM5a1P6nR9Ud+XXhpU5CpOfPvqV
   Svw/SUxWkveeVA9aW7Pb6NSjcaeEzde/fMG1Xp+d7XwaJXpHzrTtA3dBG
   ybyHdtP0otlj9smcns9zE1hArSm/FiJPw11YZxqR8dDiWtuNxnhpL3jTw
   A==;
X-CSE-ConnectionGUID: YTKOpsISSdqIyOgiqjKv8w==
X-CSE-MsgGUID: XmoR2ONKRkuZEHLDWcA/Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40559709"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40559709"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:55:02 -0800
X-CSE-ConnectionGUID: qaLHR+DHSBadxi12aQSKiQ==
X-CSE-MsgGUID: 8H7xUnA9QbKpHVrOoCpsDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="118509809"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:54:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tix5j-0000000BWS3-3tdq;
	Fri, 14 Feb 2025 16:54:55 +0200
Date: Fri, 14 Feb 2025 16:54:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: subramanian.mohan@intel.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org, giometti@enneenne.com,
	tglx@linutronix.de, corbet@lwn.net, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v14 1/4] drivers pps/generators: replace copy of pps-gen
 info struct with const pointer
Message-ID: <Z69ZPy5T5eXxVTuH@smile.fi.intel.com>
References: <20250214090755.37450-1-subramanian.mohan@intel.com>
 <20250214090755.37450-2-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214090755.37450-2-subramanian.mohan@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 02:37:52PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> Some PPS generator drivers may need to retrieve a pointer to their
> internal data while executing the PPS generator enable() method.
> 
> During the driver registration the pps_gen_device pointer is returned
> from the framework, and for that reason, there is difficulty in
> getting generator driver data back in the enable function. We won't be
> able to use container_of macro as it results in static assert, and we
> might end up in using static pointer.
> 
> To solve the issue and to get back the generator driver data back, we
> should not copy the struct pps_gen_source_info within the struct
> pps_gen_device during the registration stage, but simply save the
> pointer of the driver one. In this manner, driver may get a pointer
> to their internal data as shown below:
> 
> struct pps_gen_foo_data_s {
>         ...
> 	struct pps_gen_source_info gen_info;
> 	struct pps_gen_device *pps_gen;
> 	...
> };
> 
> static int __init pps_gen_foo_init(void)
> {
>         struct pps_gen_foo_data_s *foo;
> 	...
>         foo->pps_gen = pps_gen_register_source(&foo->gen_info);
> 	...
> }
> 
> Then, in the enable() method, we can retrieve the pointer to the main
> struct by using the code below:
> 
> static int pps_gen_foo_enable(struct pps_gen_device *pps_gen, bool enable)
> {
>         struct pps_gen_foo_data_s *foo = container_of(pps_gen->info,
> 						struct pps_gen_foo_data_s, gen_info);
>         ...
> }

Shouldn't Subject start with "pps: generators: ..."?

With that fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



