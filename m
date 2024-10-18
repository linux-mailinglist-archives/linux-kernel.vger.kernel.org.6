Return-Path: <linux-kernel+bounces-371887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE39A41CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D124B25665
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6301FF606;
	Fri, 18 Oct 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlX6x9lZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CD1EE03D;
	Fri, 18 Oct 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263402; cv=none; b=pqpIsk9nrby5SF8hyBqyHhg4vuga+IKEPnUFGqM+4Pt9ktPAMW/2QS5ZawAlmO4IyKrymthANYzFhLNx5weBiFa8Z2pZwzjJ/DaGwUEDSneMzSYd+gco/iCJE+hiZpnchndAM8bKS6n8ewWkMOPmzws+TBP/FjXOYTZcR+4trTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263402; c=relaxed/simple;
	bh=VHmtKiOi1NhA86gGNEa9z1Zv0gxn4WJNZDUDnqnD5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfVPK53CZJROeerofCyPnticzVCPGviUvsz/bjnep/K/mToE/n12OGVszMSaTOIycr58kMj7z7Hqmi7CeQliOgNl0wm6LxTtQJatnAKkUhpLPUKGbVcZGlOBsV1vUgFiv2BrnXRVA63OXIns2PZrXf6+Rvina8Wu1ZGC+CIPHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlX6x9lZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729263401; x=1760799401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHmtKiOi1NhA86gGNEa9z1Zv0gxn4WJNZDUDnqnD5Io=;
  b=KlX6x9lZTb0Uw9nReQOtlJTzFLOh1Bs8PAcWuyWNHK+TqErmOuHKNUsc
   QVnXDK0kX7MB/BznltpJ9KAFmI4Dbg05Wa60exxi6Fj5FlbshWdYrXFpn
   DALN+qDY9GAjaq33RvfdIMi4Z9Iy8HT38npR9w1Lc8is/6D7Tt4bHK7SQ
   vnmipOOlj3AnIKA0YIC7wTVvz1KkiXoowdy553Db3nlyPIahUDQbpRowY
   7X1Tow/ax2AqLkZMzbtsedcee2DmSUKCeFFseJ/ycJ4JwUoFYqu7ARHur
   86K9PpyFLSqKivpDTxUBN3jAP3ndTOwIXwnkTiOxxljZH8ZhX5VPMv+9C
   A==;
X-CSE-ConnectionGUID: 3xTM3OW2R5yNVUMDsPV4vw==
X-CSE-MsgGUID: R4KQaCKyTymZwaK4m/M5Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39385726"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="39385726"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:56:40 -0700
X-CSE-ConnectionGUID: bMKlOZoiQHuyQEE+IkTohA==
X-CSE-MsgGUID: Q+LQnwbCRE28U5AqXJv94w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83955360"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:56:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t1oP3-00000004VMq-3BNU;
	Fri, 18 Oct 2024 17:56:33 +0300
Date: Fri, 18 Oct 2024 17:56:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
Subject: Re: [V1 4/4] Documentation ABI: add PPS generators documentation
Message-ID: <ZxJ3IQYAFsuZ9mZZ@smile.fi.intel.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
 <20241018143915.3877425-5-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018143915.3877425-5-giometti@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 04:39:15PM +0200, Rodolfo Giometti wrote:
> This patch adds the documentation for the ABI between the Linux kernel
> and userspace regarding the PPS generators.

...

> +Date:		October 2024

The rule of thumb is to have the date of the estimated kernel release where
this ABI will be available from.

Citing our internal recommendations about this:
"The field Date, usually in the format MONTH YEAR, should be aligned with the
release date of the first release of the kernel where this entry will appear.
The release date can be predicted using the prediction machine, AKA Kernel
crystal ball."

The prediction machine URL: https://hansen.beer/~dave/phb/

-- 
With Best Regards,
Andy Shevchenko



