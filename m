Return-Path: <linux-kernel+bounces-330437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBD979E91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8581528386A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0935149E0B;
	Mon, 16 Sep 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcT7ebs6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FA1482E5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479561; cv=none; b=g/NXczvHnjyj12zcmyRQkUp2DvwAEEvS4tVlC1+XF+Wc6GPGP3fbmBY1Hn7b7JoBOLxBCJ3QJgXI3cQbWd30nja+lEA5V/+WanFS8/fULnU7uoDdVbBS1NTPnrUNElEZUA7+gXOs7Pmj/ILSKBHNnFqiOXKTsvqBPj07CeJ4oec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479561; c=relaxed/simple;
	bh=QzWF49JVlJGlig+zureYxqNLiHfy9HRwsAhR4VX124U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI8ewlYVP0jB+smfAprc9GVOfkFQSbKkfwEFzFR4DitnWOnzjbBTo8DTvcRxNLy+WcHMj7/26SCbAmFKcCzbLXzQCC3W8e1+9i4Zcfl0SoOOnVrHFebAp3kPqjhRsSkjOrpBqOzXur5/b06k6kM9SVJxwthtAEc9OLqWmLA2j6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcT7ebs6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726479560; x=1758015560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QzWF49JVlJGlig+zureYxqNLiHfy9HRwsAhR4VX124U=;
  b=JcT7ebs67870B+Wnnlsv0XlEuzsYfrS6PblBpRFR10Zmgqx99JPPtC0y
   P/AIZ5hj6R5mos3gsSeJN6pJNjWFN7vyXcKQRjh5q9Ij7fi4UrQs1Og4R
   48tdIHDBtRTGUYrZslBLD0OwdJSu1G3bCJGUNeZirz4JqKyB35Y3Ss+L3
   IPAWaWfsv7u1JnXCD8w+bLswZI7VPqnN0uEkxv2AcaenMbaxhMxRUFABF
   rzLEyG1g5vrsuz22mB1UgiqoLysssC7ZcACtWNfCh7zt67cfRsBQrntNh
   HnbRerHY2uuDpCqqysgoD9wI37e+RCSuL5qGd6tOm4fR8VCrch+YQssfn
   w==;
X-CSE-ConnectionGUID: xTlBEREnRYyul4SvvQ1rLQ==
X-CSE-MsgGUID: rf6I9Xr5TAeGhxNdjjewCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="24783675"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="24783675"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:39:19 -0700
X-CSE-ConnectionGUID: ja81wgzCR465jyGYnmyEwQ==
X-CSE-MsgGUID: HPQyYopwRiCy/OsRLB8M9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="99498188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:39:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8CQ-00000009PNQ-0QLv;
	Mon, 16 Sep 2024 12:39:14 +0300
Date: Mon, 16 Sep 2024 12:39:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier
 to print GUIDs
Message-ID: <Zuf8wQEwsAX_1hI0@smile.fi.intel.com>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
 <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 12:38:08PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
> > On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> > > On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> > >> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> > >> <andriy.shevchenko@linux.intel.com> wrote:
> > >>>
> > >>> Replace the custom approach with the %pUl printk() format specifier.
> > >>> No functional change intended.
> > > 
> > >> Thanks, the patch looks like a nice simplificatrion.
> > > 
> > > Thank you for the review.
> > > 
> > >> Rijo, Devaraj, does this work for you?
> > > 
> > > Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> > > but in this driver IIUC it's guid_t (UUID LE).
> > 
> > No, this does not work for us. I tested this patch, it does not work as expected.
> > 
> > %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
> > But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
> > 
> > Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
> > While, in our TA naming we are using 3 hyphens (-).
> 
> Ah, good catch! Can somebody add a comment there to explain that this uses
> non-standard human-readable representation of GUID/UUID?
> 
> P.S. Thank you for testing!

Alternatively we may get rid of that hyphen. I can send a patch.

-- 
With Best Regards,
Andy Shevchenko



