Return-Path: <linux-kernel+bounces-332492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337997BA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D96B21AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530F180A6A;
	Wed, 18 Sep 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Np/Y5Moz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730D17E44F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653300; cv=none; b=Z0nlDOUBxjt89QRInOg+GTf7GunaVaApzORs8MgXNdwq8qLvtto9Uw/OhF0E66OQOIj7Elwif7l69s3ssZ+kEr46x472nXjm5JZ1L66JaKtTxgutIp5Akx5VXUVbTi4NMjcmebC6LYFS88nydiwMDW1Ce8Qu00YtBdBNpXnvWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653300; c=relaxed/simple;
	bh=+zr7tNMOR3efLGHCn2JGk9O1Z2BpOM4E+d/bDLkml7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeqUOYwHwSNhO9MfOfmfp6uwJOMhJSIXnRfMj/eIvci+Chfbuaika0ld3cv6U0mE+EGNZEirRt7A0XFvBve5KQ20d7nD4FIxBIgtze5PtNeJYLwRc5B2F5NLX55CoTdWcNvv8yL0yxUHcFFZj06e6gG5NceD40NXcqF1UoAT5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Np/Y5Moz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726653299; x=1758189299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+zr7tNMOR3efLGHCn2JGk9O1Z2BpOM4E+d/bDLkml7c=;
  b=Np/Y5MozoTNADhU3MMzRqtR8tYe9olFXP7eRwVhyldsxvpD8BwgWmZPL
   RrgOizhzcmt+ahp4EF1jAATPNkMSt6UfCB03lGGKYuh0EaPxk6TOG060X
   6Nc6YFnkrMEwZoV9vn31x86hYn70ea4ujrnzxxQj4m8ExDjqJfzA29yuW
   C0lKyARLChWaBBZBtDgdUy7HYxN6jyWhXN4Ub9jvbJYYhcmgfjuk4zFNk
   jDQEVNa7oS7oe/C3GUGEtrXJ6yWNUwckF7eLf05v/+jxgCmYBLlsQ5U2B
   J0Aw4ffwzvAs3aKb4wK0KD0272PQfa6ONDY5AjEb3xmJBQ80+SGKcVbVG
   w==;
X-CSE-ConnectionGUID: qhKILtPZTLq8VSIsdG6KQA==
X-CSE-MsgGUID: BeFdZk2PTAyUyL2msl44qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29340986"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="29340986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:54:53 -0700
X-CSE-ConnectionGUID: Ys9dOQQWQRKrrsvLg/Yukw==
X-CSE-MsgGUID: uTLtbHumSBqatuvZgxlmfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="69821590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:54:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqrOY-0000000A8O2-3SeS;
	Wed, 18 Sep 2024 12:54:46 +0300
Date: Wed, 18 Sep 2024 12:54:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Rijo Thomas <Rijo-john.Thomas@amd.com>,
	Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier
 to print GUIDs
Message-ID: <ZuqjZswbhLY1iEfr@smile.fi.intel.com>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
 <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
 <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 17, 2024 at 09:22:19AM +0200, Jerome Forissier wrote:
> On 9/16/24 11:38, Andy Shevchenko wrote:
> > On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> >> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> >>> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> >>>> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> >>>> <andriy.shevchenko@linux.intel.com> wrote:
> >>>>>
> >>>>> Replace the custom approach with the %pUl printk() format specifier.
> >>>>> No functional change intended.
> >>>
> >>>> Thanks, the patch looks like a nice simplificatrion.
> >>>
> >>> Thank you for the review.
> >>>
> >>>> Rijo, Devaraj, does this work for you?
> >>>
> >>> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> >>> but in this driver IIUC it's guid_t (UUID LE).
> >>
> >> No, this does not work for us. I tested this patch, it does not work as expected.
> >>
> >> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
> >> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
> >>
> >> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> >> While, in our TA naming we are using 3 hyphens (-).
> > 
> > Ah, good catch! Can somebody add a comment there to explain that this uses
> > non-standard human-readable representation of GUID/UUID?
> 
> Could this be due to some copying/pasting from the OP-TEE code base which had
> a similar mistake prior to v2.3.0 [1][2][3]?
> 
> [1] https://github.com/OP-TEE/optee_os/blob/2.3.0/CHANGELOG.md?plain=1#L40-L45
> [2] https://github.com/OP-TEE/optee_client/commit/a5b1ffcd26e3
> [3] https://github.com/OP-TEE/optee_client/commit/365657667f89

Interesting... Is somebody going to update this to follow the proper format?
(yes, I understand that the old one has still to be supported)

> > P.S. Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko



