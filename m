Return-Path: <linux-kernel+bounces-373903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB49A5EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5380283404
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4801E22FD;
	Mon, 21 Oct 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUCJh/PD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953C1E0B6F;
	Mon, 21 Oct 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499671; cv=none; b=LLHwnCZlHuL7wZu4qR++d7mfKTjCvOH/w9P55PKglD5B0QVjKObDXwg3KZqTIo2+l+WbDot7ADaFocHg10sWQK4v4MKJFqwBZuXlcWzRZMTMzsOgOPz/2NMzlCZsZG0rJVIz2+kShgj2pIcy6WG7q4FBuGz34z0WQvo221OmWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499671; c=relaxed/simple;
	bh=OpWyUIDyQKJuv/TrToaEn3D+5xd+yZppCETeDqmXRoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSKlhTbIDJMrSR8JOl17P55+dcj44Q6tmzSAKaHC+Bvz+L/NA09woBWoFjQ9T5c0QpH7n/Nk+z3CLIjhVWC7j44tZBQ+wpcIlJDjMFBDML7nzZsEslmVFkMhIs7T89xaYJxWhX6hFIQc2GuDV9rqgAgnlq9kD38/tmNZdyeatDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUCJh/PD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729499670; x=1761035670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpWyUIDyQKJuv/TrToaEn3D+5xd+yZppCETeDqmXRoA=;
  b=SUCJh/PD5eEAGcUMrE7vDreYN3Z1xc77lM1SzREXk0a4AmHOiTXozG03
   FEJ9RrhGmO+ZPO4k2bkzH0zIjIUWuxpeejWab/n+G9YkPF4z0qyS9dVoD
   SYvLfD19djPNxW6OeVbORHh+Wf79r9CtfEECpRdkabOUkeQ738hGXi9C1
   mrW3qhONMTaggKOyiXolxn0Vj0yQY3UUv1s790TSw5DSGrmSfA/ykXXUI
   nRTakLnLD+0s2+CcxCpHg+XEumkXKR0pcZLORUIFd4q7VJ8evaMWbu/rf
   REq/66tyx0NgZhl0hiTsmFIcQxt0WHeZrv4QdiT7wp1Rx198zg8ka11d6
   w==;
X-CSE-ConnectionGUID: hsYCEErVR7S47l7O+889zw==
X-CSE-MsgGUID: YwySsfw8Q3GELIqkZiYgFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="31832023"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="31832023"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:34:29 -0700
X-CSE-ConnectionGUID: G6R65nRoQnGnKZ3VmCgGnA==
X-CSE-MsgGUID: hXM79xXBSJuzziw1SYnnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110221943"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:34:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2nrt-00000005Qcr-0R7q;
	Mon, 21 Oct 2024 11:34:25 +0300
Date: Mon, 21 Oct 2024 11:34:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
Message-ID: <ZxYSEPAVR8JbBx-G@smile.fi.intel.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
 <20241016115033.858574-3-andriy.shevchenko@linux.intel.com>
 <20241021070005.GW275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021070005.GW275077@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 10:00:05AM +0300, Mika Westerberg wrote:
> On Wed, Oct 16, 2024 at 02:48:25PM +0300, Andy Shevchenko wrote:
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in the driver.

...

> >  		get_device(&ipcdev->dev);
> > +
> 
> unintended whitespace change?

Hmm... I don't remember, probably.
I will remove this part in v2.

...

> >  	err = intel_scu_ipc_check_status(scu);
> > -	if (!err) { /* Read rbuf */
> > -		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> > -			wbuf[nc] = ipc_data_readl(scu, offset);
> > -		memcpy(data, wbuf, count);
> > -	}
> 
> Here you changed also the check to be for if (err) instead of (!err) so
> at least mention why you did these at the same time you did the cleanup
> change. It is fine by me but good to mention in the commit message.

Yes, this is the part of the cleanup change. It's a byproduct of it.
I will try to mention this in the commit message, however I consider
the text redundant.

...

> > -	if (!err) {
> > -		u32 outbuf[4] = {};
> > -
> > -		for (i = 0; i < outbuflen; i++)
> > -			outbuf[i] = ipc_data_readl(scu, 4 * i);
> > -
> > -		memcpy(out, outbuf, outlen);
> 
> Same here.

Same answer.

> > +	if (err) {
> > +		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
> > +		return err;
> >  	}

...

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



