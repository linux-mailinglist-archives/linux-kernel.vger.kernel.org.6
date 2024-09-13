Return-Path: <linux-kernel+bounces-327901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073AE977C73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412591C218E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D61D79B4;
	Fri, 13 Sep 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DghWpUcd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C1BB691;
	Fri, 13 Sep 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220542; cv=none; b=YHrE9riHaLi3OJwhUHKg3jyqBChC2VzukudfFu2BslyleQ1qMg5QauxmrymnMSygXDMFvVWoHUMUf/A2yQ/1dq+HhM85hkUU18qGcoWGZEvEtFDd4JfM2bCg/povzoJ51vQhLdj6oKPtzbQcBp7XCOCg1lsYMCOsQygYzdNypEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220542; c=relaxed/simple;
	bh=I/efSkz7mVWHAkEcQ9g5Lmv7coFvWhBd9YvtsQNEWVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqbu1t2C9b72Rv6OFPPqjK1d70dAwHnRn24EoCOVuyrq1jddRuVh8Y6KcKXZ3Hns35OJTNPKDUZf81FkpZYOfeRZM2CWZ7RgzsrvOrgD+IOoKKqwqIUZmlCKmnhTyAqQ+gm4isRC3LRjcyo5oSlYSyhah4MyRCOaPjafAPlj9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DghWpUcd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220541; x=1757756541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I/efSkz7mVWHAkEcQ9g5Lmv7coFvWhBd9YvtsQNEWVk=;
  b=DghWpUcdpr1/izcBCdjLPiwbxkf8iMTPvkC+O6IqiFNAON/xQc6Dxvmy
   jdgCFEvgV2Xbhr1udVBJJWvdvtvIv9Y/YR2bekQ6JuxWWGBmrSQp0O22j
   j96XMrT/aJ1YRdZtMLl7OO3pvl0LWqvaq/k2Vy/X6w2WR/oVIzJGX9WfD
   QDuNrlREUb/sJDwtZWkWettJ1rMxAGTdZttUy9/gH+epMSCwdZNNZmrPG
   IWD5vG5/OoUJJlEbHMlOd/Ott8iTFvNESjD+YY9eNdmxwAInmHWJR2Z75
   CuN7e8PJbHtX6dffNjlUiORuyBjyZHtCXq/lyLczMbkCgSsbJH4rEBvkJ
   g==;
X-CSE-ConnectionGUID: o1gOYxABRk6veZ+It4HqvQ==
X-CSE-MsgGUID: gevrJZLzSGmN9ZIZm9nQXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35780145"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35780145"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:42:20 -0700
X-CSE-ConnectionGUID: MvbTAdetTyixA+iw3Ef87g==
X-CSE-MsgGUID: CNcK0jXvT2ixwsGvFI7WnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105454676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:42:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2oh-00000008FMQ-3V1W;
	Fri, 13 Sep 2024 12:42:15 +0300
Date: Fri, 13 Sep 2024 12:42:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v1 1/2] xhci: pci: Use standard pattern for device IDs
Message-ID: <ZuQI98wLOyqGCLa7@smile.fi.intel.com>
References: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
 <20240913084411.3309911-2-andriy.shevchenko@linux.intel.com>
 <9ccea075-5724-3a9c-738f-03eb2d519c45@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ccea075-5724-3a9c-738f-03eb2d519c45@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 11:51:48AM +0300, Sergei Shtylyov wrote:
> On 9/13/24 11:43 AM, Andy Shevchenko wrote:
> 
> > The definitions of vendor IDs are follow the pattern
> 
>    s/are//?

Yeah, thank you for catching this.

> > PCI_VENDOR_ID_#vendor, while device IDs — PCI_DEVICE_ID_#vendor_#device.
> > 
> > Update the ETRON device IDs to follow the above mentioned pattern.

[...]

> >  	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> > -			pdev->device == PCI_DEVICE_ID_EJ168) {
> > +	    pdev->device == PCI_DEVICE_ID_ETRON_EJ168) {
> >  		xhci->quirks |= XHCI_RESET_ON_RESUME;
> >  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> >  	}
> >  	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
> > -			pdev->device == PCI_DEVICE_ID_EJ188) {
> > +	    pdev->device == PCI_DEVICE_ID_ETRON_EJ188) {
> >  		xhci->quirks |= XHCI_RESET_ON_RESUME;
> >  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> 
>    Hm, these 2 *if*s seem mergeable?

It's out of the scope of this mini-series, but seems a good catch!

-- 
With Best Regards,
Andy Shevchenko



