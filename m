Return-Path: <linux-kernel+bounces-429072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53529E179C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9E4B30755
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3171DE2B5;
	Tue,  3 Dec 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuN+jZvg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3D1D9694
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217417; cv=none; b=ZRE1leCj3TXurzFFNxGnMBXyis4Imk608b8sTl84U/5NOPStPMvJ2d2GAdicpGBR/c1UHMXFW3X9eaYc4CRsIcyJpC3macKD4JDO3W1QUQRcyf7jaTUyT60Xz2lA1rHDwHlNMMEoIUYN6ioc3eTrk9jre2NHq2d2XG2QiK5n0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217417; c=relaxed/simple;
	bh=I2zQ7EO3CGd28eCNenVKyQMSLC2mesZFA3OoilbDqi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl7pw6kKufeir555irRt/OVJAfVuD14ku7db22czkU3Ao2S+gVoV4m0lEgRgfgCTsTsDmk7RX7U6PUcmxa6w+4qd9N/MZQmhvm5X2tWGoloU0md8kHj+6qYNdI3MeSUhrFZQSBj8+l9iVPD6mu0sFxTsNcBMMPAAza5LN1y/gXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuN+jZvg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733217416; x=1764753416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I2zQ7EO3CGd28eCNenVKyQMSLC2mesZFA3OoilbDqi0=;
  b=JuN+jZvgCbnStC65e59TRFrWpoNUW4pwd3JHce7Q9qr5LXQokUAyo/KH
   DkYeV4im8PFLKuuNTK/7q1fE5ETJHciSiu71DJbxdPPgPjEaadF/PYUzk
   B80NFZF4APRTsN1h4w9IXsMKpQH1NsUI8hllJMwq7S2ZN+2bwBbGd6vqK
   5MtHLvyP7gsamkS9Or6yvsNWO9LkrquRQCxYLGB22iJIc+G7tIv+1+2LY
   FPYxAI7velDPT8XF3yxJzquFPPia+8kUVU9PzWaO+vI9dZGO6FXJRFoJ6
   gVNIFzGGgvtEdlV/DYEOXmR0vnxXpigjK7SF4MzaRLVJzVbflpL5nwKA7
   w==;
X-CSE-ConnectionGUID: ORSxTswQRkadvj1SkYm50A==
X-CSE-MsgGUID: E0mMuczbSOWuF6p9IWA+Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33340425"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33340425"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:16:55 -0800
X-CSE-ConnectionGUID: L+DEmwe/QXSGw3R8sydsuA==
X-CSE-MsgGUID: V2m+cSg1QAOtvEL89cxbKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93572855"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 03 Dec 2024 01:16:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 03 Dec 2024 11:16:51 +0200
Date: Tue, 3 Dec 2024 11:16:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	airlied@gmail.com, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Subject: Re: 6.13-rc1 graphics fail
Message-ID: <Z07Mg2_6y2MW22qV@intel.com>
References: <3b097dddd7095bccabe6791b90899c689f271a35.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b097dddd7095bccabe6791b90899c689f271a35.camel@sapience.com>
X-Patchwork-Hint: comment

On Mon, Dec 02, 2024 at 01:40:59PM -0500, Genes Lists wrote:
> 
> 6.12.1 on same system with same userspace works fine (as did 6.12)
> while 6.13-rc1 boots, but without working graphics using gnome with
> wayland.
> 
> Laptop is raptor lake with Intel XE (lspci attached).
> No kernel errors are logged, but GDM fails, leading to frozen screen
> with some messages logged most notable seems to be quite a few of this
> one:
> 
>   Failed to ensure KMS FB ID on /dev/dri/card1
>        drmModeAddFB2WithModifiers failed: Invalid argument

Probably https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13057

-- 
Ville Syrjälä
Intel

