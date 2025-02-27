Return-Path: <linux-kernel+bounces-536676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E42A482EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638D616E15F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF026B2C3;
	Thu, 27 Feb 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDnLIeQz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08E26B2BF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669927; cv=none; b=dA0f0NpF+dStct0u7a4izwL2hBQ+pH1E9FjD56K59VPXoNvi18SI6z54rZ371m7sa5bSlDQ+M+zhrHiR3JWXFvl8Sz7VS2ttcIcxSosZZXQ2p/QOHsGsxfVe7fzO1csg+dDNJ9W4CJU82P+hLctiQRATlg7ZsR70xlagJTUcxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669927; c=relaxed/simple;
	bh=vpomHs3iTwgbfPEKsG61J27840RkikUOBSKgtHFsC1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsmXNgpdd3Tgp27ZTHfi7lTnykssCCjA7R+J05BvmEMJ+CQB8C4YKTWZ60Bj2HhRwy5tz0hKxXG5F+HlFiAYoW6MsZjwQuG/vYSzz8+QKaXHXuiDgx9xD3OAAVSETlsOrrkSndw/tDcSd31/+FT+roN+rOfg8PYcHEZIc8qialI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDnLIeQz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669926; x=1772205926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpomHs3iTwgbfPEKsG61J27840RkikUOBSKgtHFsC1g=;
  b=eDnLIeQz5ePIcsspjHCql+sOASk+TiBK/FoETZeOtlTehcktZF1rKSXL
   DpXRkGjJ2QaacDtLRKayORkUrOyTJgS+5Vyu5Gj0m075lUttBKA3Hz+DD
   RqRoKvgHcHhHFPiUkjSGGWAdCPHGyDcUpwMHceO6HveKgm2gFyYVj5+To
   yL9JGO2uKmkSHBiGekwWbruC03DC9BPLhwIP4rHUzz586uMPG9UuY7PfZ
   q95czdYO6b+g5yD6TlWuaSWJA8Mrd53p95LCnZgvHE4opNzAkflCvQ+1H
   LnlfWy6E+r+KPkeJnJbPQ23dehA93K7jYn38y7JWRrtW0tHx/yCZkANGJ
   g==;
X-CSE-ConnectionGUID: rQqyqNs+R5CAjm2jCKyvkQ==
X-CSE-MsgGUID: jqi7yO28Qtmm/mZYIkFCmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45216484"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45216484"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:25:25 -0800
X-CSE-ConnectionGUID: QLQtorUDT3OwzopKlQ25BQ==
X-CSE-MsgGUID: AcGdgfOeQD6da5wt4RwiLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="147872701"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:25:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnflH-0000000FdFW-3AyL;
	Thu, 27 Feb 2025 17:25:19 +0200
Date: Thu, 27 Feb 2025 17:25:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Message-ID: <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227070747.3105451-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
> This series attempts to cleanup io.h with "include what you use" approach.
> This depends on changes available on immutable tag[1].
> 
> Although this series is too trivial in the grand scheme of things, it is
> still a tiny step towards untangling core headers. I have success results
> from LKP for this series but there can still be corner cases. So perhaps
> we can queue this on a temporary branch which we can use to submit fixes
> in case of fallout.
> 
> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
> headers.
> 
> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com

I believe Arnd can take it through his tree for headers as DRM part is Acked already.

-- 
With Best Regards,
Andy Shevchenko



