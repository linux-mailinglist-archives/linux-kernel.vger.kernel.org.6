Return-Path: <linux-kernel+bounces-171847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6208BE96B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EDD1C24635
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5A1C121;
	Tue,  7 May 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uxq4qgoj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D0B642
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099770; cv=none; b=pd1TTkaN09545j8aailSuO2WlA/3yX/lGZCftJzvznMwASCjblKzUui31mQ4eNz3dzgGWMUkgqBrQ6IeffnbC51lfH7Bj4/YyABwLIyyaVg6QhcGe1nF/GqzyAPtuwvcYPHJ17/8ES2BJc4eq/Ub0G6y4iaFeVxLykfS96hFvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099770; c=relaxed/simple;
	bh=d3cJOxKg8DFM38H9/m1fiQFLo+hws6/dTsWeKMD8jzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUyOSVZfezrbxdRGB/39qskzYvzZrZwjX0VYHrF+YswInmf8FViHXvX6of6oBHTZ801OXkYewHMNiJochxJfSg2X79kAoMhQE0dyhwll2isAeNiDyE6ItSpmrdUOGRTnRHs3agbwoF+i4lwAlrmRAuh5PnuxRb+47d2Jzm7IE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uxq4qgoj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715099769; x=1746635769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d3cJOxKg8DFM38H9/m1fiQFLo+hws6/dTsWeKMD8jzA=;
  b=Uxq4qgoj2G6WgI8aoQKjmorv2WHMFjWyYqyC1Kj6N0g8d0xp0+sphLS8
   FvZ7sbI88iVKy3vb019R7omuoqfPy7g3c5ZFbWwnnm5QxVNOtJ9/H94Oi
   FbcuohCyOfiddhCFu/eC2oYjbRRZIxTw2Lb8Y2gZbxwIq2O4NIJjQSDSn
   3VIxgKoVDYPmLV1NDOUfLJKBX9LdQl4WRBvrB4WhulFaEXQ9wjOJpie6D
   ApUBORynuf69sMKfeMddYLZ31EPNJDde2EsxZORN6neKKkgbdVtuT5LiK
   FWLG5imYPpT0DF4OuckyVpk/IE1DKUmN8sqHjlgg5Hg2qNR7TKKpGcY9o
   w==;
X-CSE-ConnectionGUID: pHjrMr2IQbmWDlryp6zapw==
X-CSE-MsgGUID: wekMiqb+TBO0vhqQ9BSVMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11065995"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="11065995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:36:09 -0700
X-CSE-ConnectionGUID: qhnMm+OdR/iQVTa6NVuW8w==
X-CSE-MsgGUID: 6Izgtu1hTt+A/QzdryCXsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28669967"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:36:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4NnR-000000056uW-2Ibt;
	Tue, 07 May 2024 19:36:05 +0300
Date: Tue, 7 May 2024 19:36:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] auxdisplay: charlcd: Provide a forward declaration
Message-ID: <ZjpYdYqlzAQ0NJXE@smile.fi.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
 <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
 <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
 <Zhe7wK-OhvHtGTHH@smile.fi.intel.com>
 <ZifjNpEetImWWcOb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZifjNpEetImWWcOb@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 07:35:02PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 01:30:25PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 09:30:31AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Apr 9, 2024 at 6:15 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > While there is no compilation error, strictly speaking compiler
> > > > should know about used types beforehand. Provide a forward decoration
> > > 
> > > declaration
> > 
> > Thanks, I updated locally. Please, see my answer below.
> > 
> > > > for struct charlcd_ops before using it in struct charlcd.

..

> > > > +struct charlcd_ops;
> > > > +
> > > >  struct charlcd {
> > > >         const struct charlcd_ops *ops;
> > > 
> > > No forward declaration is needed at this point, as ops is a _pointer_ to
> > > the structure.
> > 
> > The same way as in all other cases. We may drop all of them, but strictly
> > speaking (as I mentioned in the commit message) this is a good practice.
> > 
> > I.o.w. a forward declaration of custom data types is used for _pointers_.
> > 
> > > >         const unsigned char *char_conv; /* Optional */
> 
> Hmm, so what's the conclusion?

I'm going to apply this. Share you objections if any,

-- 
With Best Regards,
Andy Shevchenko



