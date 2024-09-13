Return-Path: <linux-kernel+bounces-327878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0A977C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BF4B20B67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67C1D6DBB;
	Fri, 13 Sep 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3kE5u6e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C831D6C67
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219781; cv=none; b=ru3I9Qo16b8Rdh2VYEJjiSTRoHwqNU5NPy3OkxVG9UGAwK/b/TLvR0xxIpJcd8wsN3Zgu6gMbsZk+FF+mNgPxuyds2Rvhsvjxl+dxkl82vMx9NJNWknMAMqJdQJc5jKQW7NgFX+WBAcQRQb9QHPhS8+vafzY1OuZm91gR4qWdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219781; c=relaxed/simple;
	bh=yfZrbgn3jpcUXaaZpUJrliWwD0Utzm2VwlMncZIaxrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLsIyFw7VDY0DAXy2JJb6D7zpV3HokKl7Mb2FBxgZ/E3AXNzCYnRTf/g4ZG3d+pd3XxzGYLcxp4S7AxgGKwsgFWGUfxbtLBlAWYGVFFwWyjIdU8p+mZRQVYFqWibsKw8MQqS2+8pA/llZK1wqPlmdvMbnrafDyfIY0KoWsT+r4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3kE5u6e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726219780; x=1757755780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yfZrbgn3jpcUXaaZpUJrliWwD0Utzm2VwlMncZIaxrE=;
  b=P3kE5u6eQ4LH/ycAWPft9T0952W8hEX8ZQKffgPknRQ5rFmyrTk4Rpi6
   tNjONTYclAsgqJpCEbLmXk9TH4ZGykb0Y4zabgOS8PSZ/lNkWdeU33vY5
   WpPa+mJweTXs7shd//fZZNGJ/IVF3qrYZAVLeV/LrsmgnVgdklFjV6kd5
   MEoMWLNLCcSuMUVvt/S0geXKESlrpab6AT/ZGqBn1rKhNPcbbZ8XVDD7q
   5kuZL+TdNTKtatLkJ+R1fuew+Z75DevPemj+m0O25FeescXqauQe1r0fK
   imNZ4wzcK0rqh1MgXLQMOFP5mX3oa/byvnI9FTeRqpAHoJNp3U1NOSwiP
   Q==;
X-CSE-ConnectionGUID: FMF34kjxRDGm/RzJOLGNYQ==
X-CSE-MsgGUID: hx2eP/ftQaehndMwEhjJFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="13509517"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="13509517"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:29:39 -0700
X-CSE-ConnectionGUID: /st1aPXhR3aBQ23tzbjCgQ==
X-CSE-MsgGUID: YMUCbZPEQ+Kmnf8LSOo+pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67842630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:29:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2cR-00000008F8J-2K5W;
	Fri, 13 Sep 2024 12:29:35 +0300
Date: Fri, 13 Sep 2024 12:29:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Rijo Thomas <Rijo-john.Thomas@amd.com>,
	Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier
 to print GUIDs
Message-ID: <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace the custom approach with the %pUl printk() format specifier.
> > No functional change intended.

> Thanks, the patch looks like a nice simplificatrion.

Thank you for the review.

> Rijo, Devaraj, does this work for you?

Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
but in this driver IIUC it's guid_t (UUID LE).

-- 
With Best Regards,
Andy Shevchenko



