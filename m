Return-Path: <linux-kernel+bounces-521783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC2A3C23E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA490188853B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFE1EFFBD;
	Wed, 19 Feb 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPNM5W0l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD71D5CFA;
	Wed, 19 Feb 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975724; cv=none; b=PFwGMKNY3Ob5VMF5Iy5Udvjpp2cfeorPo3JMZovlcVvCBU/tz2wzGsIFDEjlVs/hOcc1UpthTB3X4PlQnDBUkZQ5WWV6kJTu85IYodBojcyenoeUUMQPTOm3QPZPPALTE8dW19iv8wQjJQC90/ly5dYrW2JQklMFi4e2x9ulc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975724; c=relaxed/simple;
	bh=GyuvvvFLxtnOcvSEUGEfHzjE6V8NMOmriruOGMT11eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trr3TFD7CUcyTPSNKuB+dPSkA69VK3v1/lMzx1na4yuxTHILyUYXYPGbE+frDcgSsQ1FWH1xKHZhMrXEN1seoBQKtOKvvuvi+sQk1dswaT86Ygo683AskyuenuXKZyy0BQ5XxeSfWES18+tbuNi2exKJffYfAxvZu/iK2XRMuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPNM5W0l; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739975723; x=1771511723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GyuvvvFLxtnOcvSEUGEfHzjE6V8NMOmriruOGMT11eI=;
  b=cPNM5W0lS0Jen/i5eySxOnEkEUmJzGBlVYgVAzsHOmneVt6EWgABXips
   BXrafCRsyVkJM3JR+MmuDAHjbzWYYDgfWh5jRL7t5jB5EgkhrQZRsL4bJ
   Ly39a5iPbJaAkmZHeeM5vCFI8Xe9hcVO2vCm3ZutWVpbjokMgjkxg6+u3
   5fX8dzMpxSflZzSrHo8EdazdHn1WE8cElt6jvuqH4fIk9g8eeCBqXlXVI
   B0BM2DW9is8kBcSpNHZVEGcxZWU6v8xopu4LbKjqmAzwSRgpP3LIgCNKj
   yWvcDw4J45uZUErxwdheAJckizeTGix2k2kDZyv0NAZWXD0uvzsb2upl0
   w==;
X-CSE-ConnectionGUID: d/Cr62llS5aG0UEgnvEtPg==
X-CSE-MsgGUID: C1J6V2/UTFSRfKYRXdtrxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39900488"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39900488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:35:22 -0800
X-CSE-ConnectionGUID: fmFzTx/vQCefXey2Fcv+Dg==
X-CSE-MsgGUID: Pmgxd7ivQsmeps7a3kBPug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115638986"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:35:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tklAT-0000000D34y-02Pv;
	Wed, 19 Feb 2025 16:35:17 +0200
Date: Wed, 19 Feb 2025 16:35:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Prasanth Ksr <prasanth.ksr@dell.com>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 1/4] platform/x86: dell: dell-wmi-sysman: Use *-y instead
 of *-objs in Makefile
Message-ID: <Z7XsJMwFhZLk-0S4@smile.fi.intel.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
 <20250218194113.26589-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218194113.26589-2-kuurtb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 18, 2025 at 02:41:08PM -0500, Kurt Borja wrote:
> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
> instead, which is usually used for kernel drivers.

I haven't received a cover letter. Please, make sure when you send a version of
the few patches under the same thread you add a cover letter. You may consider
using my "smart" (not really) script [1] to send patch series to LKML.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



