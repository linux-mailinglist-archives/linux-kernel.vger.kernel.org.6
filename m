Return-Path: <linux-kernel+bounces-330455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C86979EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FB1C23015
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ADF14B94C;
	Mon, 16 Sep 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYJfDJW/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52D14A095
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480281; cv=none; b=DuWZd13kRq2ByEOTKSez/3xgeR4rP8O2pM7iNxETA33pGtYv2OOt/lpyx4BH6BugfJlCPWtAZWZlvU4nPz+qG8YEITPBJpGbs6CC38lcfmFNLFZ9fh559vENM5rw7rFUptZxjQmQt58555VxhCr3y8Q76FR/ZSqs4d6liU8tooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480281; c=relaxed/simple;
	bh=FMJEhBEVfrGmWhEdCvi6KeEFMm+PB3xGrghjFAYz9I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lah43tF2zjwnVeT2wbP5r5ktj+iV4oz1CAjmeu2c0DxwuoPm0/yUz3L79XZkZDmKkJ94BLHJZBDO81gPLjJHVf+t+Z6M+3uNvFrTloEIyddl2mw8jVtBuvTgP5LlFp8y9vFTEAEbYHeJxVkgeyu7WBX6BRP4+mP6j+AD6zcL5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYJfDJW/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726480280; x=1758016280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FMJEhBEVfrGmWhEdCvi6KeEFMm+PB3xGrghjFAYz9I4=;
  b=BYJfDJW/ZFFhfqlLIpQSNLJ2WpJ3PVoMkA8hT8iEwQv9h2NdoYbZMNe0
   O7Q2xTgEURWNzhZb8LSd2Ab6HVi4eHd3wU+MLhbktTDnL5x6rKaxbJC79
   uIVO9vLwENFH0O3WpaOGSNOsiuRK9yYYofPFmV4zbuGdZufEPwqzvwl/I
   /LOBj1A9VyiNmCjz09kjqDQVa3vujnAI9j1WDFmY05//VQj7kEOYsdNap
   6srpMqttrzgK78QmULusVTFvuzxHhd+kSerp7ZlJTnHop9bwghW4j2i7M
   K5FA5iTjfEpU7WEePjxho2mFBJmhu5C6Bpy9b74osRzAUyn42CSGPtSy8
   w==;
X-CSE-ConnectionGUID: CTwMDqQHQTulWdPcilI2lQ==
X-CSE-MsgGUID: P7TLm+U3RI2g7S7ELjl5Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25128995"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25128995"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:51:20 -0700
X-CSE-ConnectionGUID: C3FmMEZvR2yOYE5/fGyZ9A==
X-CSE-MsgGUID: B5GwJZwbTb2mHRsjHf9uEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69128767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:51:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8O3-00000009PZn-1Sj4;
	Mon, 16 Sep 2024 12:51:15 +0300
Date: Mon, 16 Sep 2024 12:51:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier
 to print GUIDs
Message-ID: <Zuf_k3z4DBiiMoSp@smile.fi.intel.com>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
 <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
 <Zuf8wQEwsAX_1hI0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zuf8wQEwsAX_1hI0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 12:39:14PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 12:38:08PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> > > On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> > > > On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> > > >> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> > > >> <andriy.shevchenko@linux.intel.com> wrote:
> > > >>>
> > > >>> Replace the custom approach with the %pUl printk() format specifier.
> > > >>> No functional change intended.
> > > > 
> > > >> Thanks, the patch looks like a nice simplificatrion.
> > > > 
> > > > Thank you for the review.
> > > > 
> > > >> Rijo, Devaraj, does this work for you?
> > > > 
> > > > Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> > > > but in this driver IIUC it's guid_t (UUID LE).
> > > 
> > > No, this does not work for us. I tested this patch, it does not work as expected.
> > > 
> > > %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
> > > But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
> > > 
> > > Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> > > While, in our TA naming we are using 3 hyphens (-).
> > 
> > Ah, good catch! Can somebody add a comment there to explain that this uses
> > non-standard human-readable representation of GUID/UUID?
> > 
> > P.S. Thank you for testing!
> 
> Alternatively we may get rid of that hyphen. I can send a patch.

Something like this on top of this patch (meaning squashed at the end):

+	/*
+	 * Firmware name uses non-standard human-readable GUID representation:
+	 * %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x (no last hyphen).
+	 */
+	p = strrchr(fw_name, '-');
+	memmove(p, p + 1, strlen(p + 1));
+
 	mutex_lock(&drv_mutex);
 	n = request_firmware(&fw, fw_name, &ctx->teedev->dev);

What do you think?

-- 
With Best Regards,
Andy Shevchenko



