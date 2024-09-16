Return-Path: <linux-kernel+bounces-330435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D8979E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF43C1C22D52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E11494BB;
	Mon, 16 Sep 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7t9/noA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65487BB15
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479494; cv=none; b=buGTTpRBUXTQy4Mrt1IKRodcweog5yRKFfc9B4jZIJrgn0fYI5qo/I7WZ1eJk7eGaYA8F934LXaMVVUiq/z33MnbyVl7eMJ1sVZQvCrMKIB1fM2/jcc9mcCY7hZ6WNlZYEbrJ+HjZ5SP+diyDOhzLy371k1Prs/NVSDEhl6nVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479494; c=relaxed/simple;
	bh=g2thI+DV+li3hwhTtS+AuQRCD96skA1S5l4K8wuGXsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww3mLpO5IcmiSvRaCSo4HChOc5YjckK7LXDLulQSNZyFhulPsQnLwBuo5aSZv+ZPAjkl3OxRvOWE7VboDSlAI3UZLpH9jfTTQ3yYnlBVBd6UtlbEgz1XVZGgbu7M2GLVaOLI4/xA7bumEvKTtZdcEYmOzDb86xM928t7+3PPEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7t9/noA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726479493; x=1758015493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g2thI+DV+li3hwhTtS+AuQRCD96skA1S5l4K8wuGXsk=;
  b=c7t9/noAo9DG1Msw3uT603qdznIqP9klGP2tSoJPPZiO00qIsyXrsllb
   5RrcUmIXfk3bk4tNQQ4hvNtESKxgVErfhAW+8o1a4TCCsEEUth9OfLtNl
   GLcM70591geSt5NUhiRhuP14PKLI2zvyNSoIfgq0yUDTZYy+r77uWIRim
   /3BWEp10+Or88fPqgPH+VLVm/tx75DCW5985h9SYbKyaBndrglXimIFUh
   KyCUiDBrtHvvJkA02CJy7vHtvsr8ifShFksS1CzyAO8j3Kzstvmvipi1u
   9HDfqtDYDw9jMrOG7Cb4IVn7hmTHBra32o7+eMjUGs8kBXeP/1scpy2Dn
   A==;
X-CSE-ConnectionGUID: svouYsjvQLaALWAZLPvEBg==
X-CSE-MsgGUID: Kn+yWP9dSU68/XzVzrPzeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="36431487"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="36431487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:38:12 -0700
X-CSE-ConnectionGUID: 9O/5w+V6SEy2Ju/e85QoOA==
X-CSE-MsgGUID: l/OGRKCBSauay9Y0SUGXsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="68511675"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:38:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8BM-00000009PMS-06c8;
	Mon, 16 Sep 2024 12:38:08 +0300
Date: Mon, 16 Sep 2024 12:38:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier
 to print GUIDs
Message-ID: <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> > On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> >> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >>>
> >>> Replace the custom approach with the %pUl printk() format specifier.
> >>> No functional change intended.
> > 
> >> Thanks, the patch looks like a nice simplificatrion.
> > 
> > Thank you for the review.
> > 
> >> Rijo, Devaraj, does this work for you?
> > 
> > Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> > but in this driver IIUC it's guid_t (UUID LE).
> 
> No, this does not work for us. I tested this patch, it does not work as expected.
> 
> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
> 
> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> While, in our TA naming we are using 3 hyphens (-).

Ah, good catch! Can somebody add a comment there to explain that this uses
non-standard human-readable representation of GUID/UUID?

P.S. Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko



