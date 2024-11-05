Return-Path: <linux-kernel+bounces-396703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC59BD0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4631DB23477
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E613B2B8;
	Tue,  5 Nov 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io+J4iQR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CF45027;
	Tue,  5 Nov 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821421; cv=none; b=mruZTtL90Wyxphcw9T3fziTCgOCO4NcaJC2wtJWtZcHVZpHg7LWwHIKzgJezceZrsjUyYcq7TwXl088qC3htfDfXPnAS4obZr+vMIYgKeKy2d+QFvjmJWIgGJYm+ysEsh6lKg0symorBfKYFGBRrC3oLvELqwyDkfgP10Q/1hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821421; c=relaxed/simple;
	bh=U7N4Tas2wjzfxhfgpGb23nqSUHuBo7MwtvH/7ZhJMH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLeRQB7SGw//T1TzmwSSTTypWcM9AHsYdA/Yl/1QBzsi4BTr9UIaSka2Shh8AiaN7yeURx+FhIz3K1yyAEvlkeEyX3ver1uLnumD2H1KG2iQ6elHvnaaCgCx4dWbJmefD+WC5KmQ6nbbclZ0jDJPkf5GZUhs1ww4CMXLnw87+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io+J4iQR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730821420; x=1762357420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7N4Tas2wjzfxhfgpGb23nqSUHuBo7MwtvH/7ZhJMH8=;
  b=io+J4iQRTTAXJlS9uSdLv+uVG8zkiU53+ZiouvAF0c2x9b+snqPdhr06
   odOAoVY19xgfTX2Ln8NjcYPs4PS76C/DDKKNRgPpLIBSU/NN+8+JV9d3Z
   XKtlFImyVRugNAKxerNkepTK5KGJmNnRy08GBpTLTU+8yf2UGFrm0Ptmy
   J0Bfsa3NIkukZ+AcFTgAnNbDC5QusILs61J+ObNYe7RHzTJ14AH5hfk+Y
   InJ9AcybX2SEDQbU0X2VT/WO91PwqAfCWs4RpIayuvDe2ORfWWn91eKnf
   TURRJIfesV1P+NFR289vP5A2slxnHMhjlro3eisYg5acqLJfbp1jSCwIt
   g==;
X-CSE-ConnectionGUID: vOjX3nQUSg+ClW/jPo4flQ==
X-CSE-MsgGUID: dxP36uJ8RnOAnL1xitwTUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="55974204"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="55974204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:43:39 -0800
X-CSE-ConnectionGUID: /B2vCChZRa2je0Fr3dO0Jw==
X-CSE-MsgGUID: UjHQNn/ZQmS2ud7EScLyfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84186161"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:43:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8LiQ-0000000BSMv-3jdE;
	Tue, 05 Nov 2024 17:43:34 +0200
Date: Tue, 5 Nov 2024 17:43:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in INTEL TPMI DRIVER
Message-ID: <Zyo9JmxZt2lm9J6A@smile.fi.intel.com>
References: <20241105152813.60823-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105152813.60823-1-lukas.bulwahn@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 05, 2024 at 04:28:13PM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit df7f9acd8646 ("platform/x86: intel: Add 'intel' prefix to the
> modules automatically") renames tpmi.c to vsec_tpmi.c in
> drivers/platform/x86/intel/, but misses to adjust the INTEL TPMI DRIVER
> section, which is referring to this file.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the file entry to this file renaming.

Oh, right. Thanks for fixing this.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



