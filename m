Return-Path: <linux-kernel+bounces-325304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374B97579C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4DA1F27EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F31F1AE84D;
	Wed, 11 Sep 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exc6C06e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E41AAE2F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069877; cv=none; b=kTuLARabI3/Pg/pM6fnQIldMHQ5QGghbC0zmQfsuqKedyeD0uB61DBR8Tei4raEAhOM74UmHx8RYJ/3Uc4rngsLSZ0OIIw0PhcG9sIoBe0Pqy9mWVxASQZ0TCaSiQkMSavmO7ahGbARUvqhKDwhF04aTmgWwqxP1HOe/faXYCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069877; c=relaxed/simple;
	bh=JxlfBYucx7xxHB+35BbYWgl3l5xFlnvnRc7jwE56vGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiGm2zNGvjaCtIUyBTx+dxQ4cXHD45LH53DRtUM/WX6I6tnDhjRqe6uXXMElX5tAHYmXsnsJf1wm/UVhsrMwBzfEqCi1huzyDW4dkS2kRZa+r2h8dLolZr+ufA1RiXidE6F2UMHPXWGADhZCh14/CIqyIloPy4DSckkH+PYQ9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exc6C06e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726069877; x=1757605877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxlfBYucx7xxHB+35BbYWgl3l5xFlnvnRc7jwE56vGU=;
  b=exc6C06eO8jHJnq7ADK/MTg2jxrQlHEumgWaNwBuOSYOZM4u1PkwgP9T
   e3aly5AjRTv8vElAl5HWMVmdsqkpNi0HSfo83f5j752M2x26Y8CEs5Ugc
   CryC2ozqVGoKJBmbEwla/vqJj4U1Bg7b/3E6PdxKyN2T9Cx5S1r5VJdDl
   SNB03nk3PxoayEOlgfoMapWWEPwMyT4P+6mRxUJkUWmOrZyCr7JPCB5TH
   K3b+Sj+qzsi094VLoABXavEmL2FpRDNujHh354q2iz5yZsqwE3tMlpQA4
   v6oz86qOmfSnMQWpM4FzCIuCtLhbG3pyy4JDUyI+XRtM62v0aLkNtMgaQ
   A==;
X-CSE-ConnectionGUID: bSF7ux0LQ1uDi+vw0BkrIA==
X-CSE-MsgGUID: r/m87jMjSb6bitbuzCbgJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="50295422"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="50295422"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:51:16 -0700
X-CSE-ConnectionGUID: M6BMuS2tQHmc4khBVudRpw==
X-CSE-MsgGUID: LQ4+cGPkT5iqZl7w4xXO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="72197042"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:51:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1soPcd-00000007brw-18w9;
	Wed, 11 Sep 2024 18:51:11 +0300
Date: Wed, 11 Sep 2024 18:51:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: sre@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in
 ssi_protocol Driver Due to Race Condition
Message-ID: <ZuG8bshFbcmjVC9L@smile.fi.intel.com>
References: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 11, 2024 at 11:19:15PM +0800, Kaixin Wang wrote:
> In the ssi_protocol_probe function, &ssi->work is bound with
> ssip_xmit_work, In ssip_pn_setup, the ssip_pn_xmit function
> within the ssip_pn_ops structure is capable of starting the
> work.
> 
> If we remove the module which will call ssi_protocol_remove
> to make a cleanup, it will free ssi through kfree(ssi),
> while the work mentioned above will be used. The sequence
> of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                    CPU1
> 
>                         | ssip_xmit_work
> ssi_protocol_remove     |
> kfree(ssi);             |
>                         | struct hsi_client *cl = ssi->cl;
>                         | // use ssi
> 
> Fix it by ensuring that the work is canceled before proceeding
> with the cleanup in ssi_protocol_remove

Sounds legit to me. But I have no time to review, FWIW,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I believe Sebastian will conduct a proper review before applying.

-- 
With Best Regards,
Andy Shevchenko



