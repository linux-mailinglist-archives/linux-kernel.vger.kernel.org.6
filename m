Return-Path: <linux-kernel+bounces-524697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99494A3E5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579173BCC23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DDC264611;
	Thu, 20 Feb 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2qBODrk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B61E9B32
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083870; cv=none; b=mJWNHqYy7BthWWLiK4RP88xUh4Si9P3+fQb/Cu6IvJrw7btMoh33lZbciv3MEUqakBAOu3uRe97gE2WahFXhvDVGtxNbT3RdvJJWhrS68KpW8H5z7uOP2Z4PB0Pv7uFB/Y5PC22nyF1OBQH4kb7FaWx9+V797Xk7ef4gO0VCLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083870; c=relaxed/simple;
	bh=W7jrMa2gf8FB8Fk6qyuO5AujkakbCuz0WvgyR8jZLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5k8bkHQJHTZS08+o6YT4W94KBm75TDVBVjzYjxp1RneEdMXT2K/cCJpw76KikptFjApgHuVgTqujRB8AKOXD4i9g6lZ3QL7wtVoaPKoIPy9e4kUcM8YZ94Gan1opBGlRp2hweCl4phARDDa1c7/Pas4Ln6cc8mJ8prbzpv+m18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2qBODrk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740083868; x=1771619868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7jrMa2gf8FB8Fk6qyuO5AujkakbCuz0WvgyR8jZLto=;
  b=C2qBODrkziiTYd4oAPCBUt3e+LD/N06JJbsUTDdL6MU0nq/h3cEwwN0u
   2h8zJTPx3w5YliERe4T7xCKGc4vXRUBqVVJAhTUrKH4UXbLL924i+/1gQ
   bMzCptEz3r5hispMr7cG1G0+zEHecUBHLXDORHRoGoihtraTWa9WtIbo5
   9haM9Eu6OIL7wmBi0FcU6O23pTs9bg5/waLGpw9zd7ZlMcPy4k+QbGG7Y
   9KX4x8vgZDYrjC/SGrmqxVJZVsndRbLZ/ksFQ5gCfG+MdG57G99OVv6a/
   +QL5/3yhPDCz8Sgiwp4v8XVCEGx9+1dNyLAqz2YefduyjS6PHX3rgv3Pn
   g==;
X-CSE-ConnectionGUID: f8tA6webS4qBA+iRPhkp9g==
X-CSE-MsgGUID: I9XcgJwrQHiakldgPYlA1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51506399"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="51506399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 12:37:48 -0800
X-CSE-ConnectionGUID: 8Q6TvtNzQUmDVpFLupZxDQ==
X-CSE-MsgGUID: /g/ZEPGNSs2z2uL7zdOUHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120268866"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.117])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 12:37:47 -0800
Date: Thu, 20 Feb 2025 12:37:45 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: linux@treblig.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvdimm deadcoding
Message-ID: <Z7eSmfcdNeYr1rWa@aschofie-mobl2.lan>
References: <20250220004538.84585-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220004538.84585-1-linux@treblig.org>

On Thu, Feb 20, 2025 at 12:45:36AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   A couple of nvdimm dead coding patches; they just
> remove entirely unused functions.

I see you've been sending patches for dead code removal
for several months. What tool are you using for discovery?

Thanks,
Alison


> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 
> Dr. David Alan Gilbert (2):
>   libnvdimm: Remove unused nd_region_conflict
>   libnvdimm: Remove unused nd_attach_ndns
> 
>  drivers/nvdimm/claim.c       | 11 ----------
>  drivers/nvdimm/nd-core.h     |  4 ----
>  drivers/nvdimm/region_devs.c | 41 ------------------------------------
>  3 files changed, 56 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

