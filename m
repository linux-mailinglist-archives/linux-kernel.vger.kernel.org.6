Return-Path: <linux-kernel+bounces-228551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4391618A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF228678B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F40148FF2;
	Tue, 25 Jun 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ukaz8MbU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84371148857;
	Tue, 25 Jun 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305137; cv=none; b=YZfcZfvVYGxA83cLo949MjLpyD1clnzFtL9DNamsoRnNxJ1UXVYXhdQMB/mnPK90/5N+s6qDBLawZYzigU73rHL4PD7LWGxPV4HBh0HTJAZfc/e3R1JF2mRRKQwAu9qqMwmj6mgR4NvAfWOQU9qVe9IpwCMy1PKqTXgbRZ4Xw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305137; c=relaxed/simple;
	bh=cSzwfwQvatqP0mqCOO7xRPpAbEDIgXPHwTfBJVvsfhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkxppDc8sfGWAyE3xFmpFzITY9vVZEijM7wxcM9RVDZ7mdcVRCL8O4ZTo4vKLb3rj2CNWPP7/mU7rMsvIv+3n1q/lxJqakPWNeTe+hRnMH+F6/x2fcN+jVR/r7N2sL9g7sIvQqIcHuolcgsIgFQobGiQl/IjqCaBZFpFrxmy81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ukaz8MbU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305136; x=1750841136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cSzwfwQvatqP0mqCOO7xRPpAbEDIgXPHwTfBJVvsfhY=;
  b=Ukaz8MbU8XpkCcGgsyHGAq0cgdrv+UWRonwSlVKctQBg/KfiuelrmTJv
   ZULzt3w5ysLbnhgYYyk22uqJstn4ny43mPAXw+tgv24aee62itQe/Luk/
   gQkk8TBZG3dKJj29lb54y07eot0r4tttqiyzylIaHE8op1il0sgWsZF3U
   pbsF9TSoCMjy6szzrsbcPhX0zapFAcSxA/jpksFzH2Mi6C+A7KftTAvfm
   rv8Yge2FBMxO8d9gcYTIko/Kap36WGh+/Eo7/r/NY3Bpyrj3ky5XlBHM7
   dwcrEA+xHMCYfh57QR75Yl67RhFbMkUQWDycSgVTjOmRecR6rRaYg/jAo
   w==;
X-CSE-ConnectionGUID: +mUgvtcJQBmLfJJtAPvEoA==
X-CSE-MsgGUID: 8Wryb9aqSbaTwoiwGfCCVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33764671"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33764671"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:36 -0700
X-CSE-ConnectionGUID: in9nkK3JSxqKMpioX5l7qg==
X-CSE-MsgGUID: bnjcO7PeQOSxxnzUvD6WVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43561262"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:34 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id AAA0111FA94;
	Tue, 25 Jun 2024 11:45:32 +0300 (EEST)
Date: Tue, 25 Jun 2024 08:45:32 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v4 3/5] mei: vsc: Utilize the appropriate byte order swap
 function
Message-ID: <ZnqDrFgrKCSyCAwj@kekkonen.localdomain>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-4-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625081047.4178494-4-wentong.wu@intel.com>

On Tue, Jun 25, 2024 at 04:10:45PM +0800, Wentong Wu wrote:
> Switch from cpu_to_be32_array() to be32_to_cpu_array() for the
> received ROM data.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

