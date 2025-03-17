Return-Path: <linux-kernel+bounces-563565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C31A64432
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E473170E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A1219317;
	Mon, 17 Mar 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmwO+htk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB5219A63
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197675; cv=none; b=UDO4nzsUwENfknUPVN5K1OiojYuXW0yOyt+1G6OyTuiCO3bjXMxku31f2oXw/7FEsjRZfYfMWqKB3/YfcUjO0HgVqxlyjju/ulD502I87MacI0iaYboCafyG3vCBc22oS0CjmzkvXmg9C62dj6hKuCdaqkujwJruxrN7gdYQW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197675; c=relaxed/simple;
	bh=7yW+fX9hteldDASe7zvWH36CF50mZq34pys1jKTcJZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjWuWz+niRUzEVqOZGgqRdPxkp4A2O9YQqTMh7wkkx+MB4Ff5ZqJrtspaUlmYdv5Dik+L2EEZ5U7zdjMxpzedGNzOnxlS0x3eF0m4GfUczXKkiaf2VYnRpBF5SMCUmNHrLoUt3ooJo7KvHTQIlB0M8+bLTWLF5SQfhY/EUGFj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmwO+htk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742197674; x=1773733674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yW+fX9hteldDASe7zvWH36CF50mZq34pys1jKTcJZQ=;
  b=kmwO+htkfJhtCPZjCD3LCISr84ynRPT6cG2DJBM2vKqBpzMIiWtJO802
   fIxcqa/sCRKkZIt/6sPN5efz6ybNwJvYI7YaOTMDmKZUFPj6jkgH3vRCy
   b1H3VzJy9M8bxhNBc+xoXPX+ybu8d/cFmBhzBZ6vgYMeVhIi+MdytTw9p
   9R6qpyd5AdQW1p/kQBp8Dyf+J4D9eWVrSam9vMSw2v+jBDVzmGkKtkx0I
   prcBSRcJw9Dad2g1eidTlm7JSeC82xjuJfRftpWpyOy2v+XHx5YRxYrjh
   DiXnkJ0+/GUf32KE3H6bbThQ8KkuUvWq9GfrHr2h9X6iioQnJtUu36hk/
   Q==;
X-CSE-ConnectionGUID: pMmyVtfwR9SWlrceso7d5w==
X-CSE-MsgGUID: elhzXI5jQb2ZqjtkqMCoEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43307100"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43307100"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:47:53 -0700
X-CSE-ConnectionGUID: ezSTbnreQWWEO85e+Pa8hg==
X-CSE-MsgGUID: HP5r+XS7TIesphItKxEdtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121860051"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:47:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu5CP-00000003F9T-09hD;
	Mon, 17 Mar 2025 09:47:49 +0200
Date: Mon, 17 Mar 2025 09:47:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <Z9fTpEyXONbsLyu9@smile.fi.intel.com>
References: <20250315133140.1707949-1-raag.jadav@intel.com>
 <Z9fOw6iu37GVxD48@smile.fi.intel.com>
 <Z9fR8sgpzvSYLyn3@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9fR8sgpzvSYLyn3@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 09:40:34AM +0200, Raag Jadav wrote:
> On Mon, Mar 17, 2025 at 09:26:59AM +0200, Andy Shevchenko wrote:
> > On Sat, Mar 15, 2025 at 07:01:40PM +0530, Raag Jadav wrote:
> > > Set driver_data correctly and fix illegal memory access on driver reload.
> > 
> > Do you have it in practice or you are thinking it will be like this?
> 
> I reproduced it but didn't want to bloat the commit message for an
> obvious fix.

Then add a few (~3-5) lines of the traceback and update commit message
to explain that this is a real case.

-- 
With Best Regards,
Andy Shevchenko



