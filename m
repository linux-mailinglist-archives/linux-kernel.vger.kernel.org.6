Return-Path: <linux-kernel+bounces-210003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A8903DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A513528642F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6817D372;
	Tue, 11 Jun 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IISbKsrB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEEC17C221
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113948; cv=none; b=lnLMOaCW7zZmee1AknqtKwZtuuM1criTJTMdkJJFhPpbRl0crPJgq4o+waLieSTrVYjpPJHCETAw+M6PS3bAJIYbYIFfMW/5L/K9lyhkQ1pWwvoT9XTvPk1ccfkswJlarxHuRWdvrp4/jfvNAkbwJ14zU3lb/d8s4SC/F5Pzsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113948; c=relaxed/simple;
	bh=+xPq7PN8qFotnsXgzZ1PotNLq0Vo1Ezxm2VpjgwIDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGy040wrqZcaJcrstg4dn7aaFam3fav2Zgn4quti/CPYXoM9nSCvzUMHoz8fCe4Ywrv3VLtEfhtEPd3+aJWneJf81MRXZpfzNaNN+5pHakGHMVicoNE+BxYpBmUmHElbJqmztxjz3gnoZ589FDGy7B/feKVoKUfLD5xs120xebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IISbKsrB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718113947; x=1749649947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+xPq7PN8qFotnsXgzZ1PotNLq0Vo1Ezxm2VpjgwIDL0=;
  b=IISbKsrBfA/wrA3G64efqFVCWLYuudLfCQE/DzP8uAdYfHMt5FJjXpq4
   2RjB8rD6SGaJaJe2Fdw/0amCMDGnHR83KvEtO4HU6xLdugoHuv4mD3So1
   Rlcv04WDAVeengHsRyqwq0MuZVJ5Z4GmujdOCG7ddf9htMm9WM7UIwhub
   FCqCV9+fYHMTq+UzVd7c3Ts7CtmY+5Ywu0u97GlQLSfZM91NPSuGWlh5P
   y3R34oO77abrE9UiqW1o/3FPF1KsRUBNP84Gz4joERU2dQV7qUw/x6i6u
   K7R8xTEPVXbQAfBqBw4E6y4Gdpal6fT5KE9/DYYcd4S3PnzwxljNmIk6G
   g==;
X-CSE-ConnectionGUID: YC+BlbPxSuuRpNSiajitOw==
X-CSE-MsgGUID: BOk9PTMRQKuxilJ0kujMtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14548371"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14548371"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:52:27 -0700
X-CSE-ConnectionGUID: ZfJEIhDxRbaogqIOohkNxg==
X-CSE-MsgGUID: 9aJmdwhBRaWscwcH7RYvCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="43995280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:52:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sH1vB-0000000FYWK-3iPD;
	Tue, 11 Jun 2024 16:52:21 +0300
Date: Tue, 11 Jun 2024 16:52:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
Message-ID: <ZmhWlRC22XQcJVnV@smile.fi.intel.com>
References: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
 <4e13caf0-c6f5-4df0-82b9-be72ffe06beb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e13caf0-c6f5-4df0-82b9-be72ffe06beb@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 11, 2024 at 06:46:12AM -0700, Jeff Johnson wrote:
> On 4/25/24 05:56, Andy Shevchenko wrote:

...

> I'll remove this from my series

No need, Maxime already applied, and I see
665415092eca ("drm: add missing MODULE_DESCRIPTION() macros")

> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

But thanks.

-- 
With Best Regards,
Andy Shevchenko



