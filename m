Return-Path: <linux-kernel+bounces-536497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F6A48090
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77F7189462D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F882309AA;
	Thu, 27 Feb 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5va8Thr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF39233120
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664987; cv=none; b=fCqZInUsv1g7bGXH6qxnYy9Pfb5nNURkWBUXZVLAtJF5s/f+cc1uexY1jZ+6r/C8+AsxPqsbJhspa2sJAf/pMESZPk0A95XzLVUeV4m92lcTOcAsTIJzscgauQkyBLgEKqrAl6i0pnAmDU7wQVkoIU2nfkF62KbmnqkaSzS4jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664987; c=relaxed/simple;
	bh=rF4R9E3R8iJoYzAAad6PRC7+Gtk8GNmQmk4DUkE+qO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+iEQBihyPkgTUW+e/bj0qcToZ+L0h2Ht6B0qDoR36/N7X3atTqmUV3yH/s7Xk7cbClyn+ixtHucEjJzb8YnEQA2LLs4lCmNX9DdZV270BkwKyZlCtlyjoa1ueZxobiC79bW7TmHiukPuFQhCPmEjXYkugLbGaq1vq/oZZf2RE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5va8Thr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740664986; x=1772200986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rF4R9E3R8iJoYzAAad6PRC7+Gtk8GNmQmk4DUkE+qO8=;
  b=K5va8ThrLQPIfZCOUYn5M+rSXg2mme0M/K6WZ46d1xjeLJEdAA//6o8p
   HgnQXEVPtoQXDxPaOQdYBeytRHUIdHe0WOsPFaldVdhDxx4u2GxGEX2dL
   0aQxZtGv7LHaoCRDtIiUm6J/F665dToUCo93EmA6lcQxYVjqwhiMYnjJJ
   Py0geMS/KiewfHXe0bw0ZrxTCXbF1BTsFmsu7dsMljmXj5s1lKEzWswSE
   dPzp6n9QLH8CpB6z10mdfPbLKSAvJaO3Y8i9bt/3e1ELbcVv7GOvqfRxT
   GoJuMaXqtbEUDYGnJa25qlab1SAb7xTySuYDXpZPR7Xq0kbPWUnVC+fuV
   Q==;
X-CSE-ConnectionGUID: eda+zhRDSg6/hPCPMBr6uw==
X-CSE-MsgGUID: wN2jW/sMRNWd9VRtWl9lsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51761224"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="51761224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:03:06 -0800
X-CSE-ConnectionGUID: o50pmxeoTJuwCFXCEOFtNw==
X-CSE-MsgGUID: WD927cQaTVePraIHBQJQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147951887"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:03:02 -0800
Date: Thu, 27 Feb 2025 16:03:00 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lee@kernel.org,
	giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
Message-ID: <Z8BwlFk-mnrMSxUe@black.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com>
 <Z78VIjgkzf_GlauU@smile.fi.intel.com>
 <Z78VkEnJh8l9MWF7@smile.fi.intel.com>
 <Z7_0gJJL_h6lq4cz@black.fi.intel.com>
 <Z8ASOo-TcQrZtgbj@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ASOo-TcQrZtgbj@surfacebook.localdomain>

On Thu, Feb 27, 2025 at 09:20:26AM +0200, Andy Shevchenko wrote:
> Thu, Feb 27, 2025 at 07:13:36AM +0200, Raag Jadav kirjoitti:
> > On Wed, Feb 26, 2025 at 03:22:24PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 26, 2025 at 03:20:35PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:

...

> > > And also Subject, you have currently 3 different names for the same:
> > > Kconfig, Subject, filename.
> > 
> > Yeah just trying to dial down the acronym syndrome, you know how it has
> > plagued our minds.
> 
> Right, but in MFD we are trying to follow some common schema(s) for file names.
> Currently the most clear one is for PMIC drivers. Let's keep going with the
> rest as well.

Sure, I'm also a bit confused about how to wire up Kconfig here.
Should PPS select MFD or depend on it?

Raag

