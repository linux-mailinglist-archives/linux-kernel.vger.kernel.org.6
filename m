Return-Path: <linux-kernel+bounces-525526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B6A3F0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D203AD561
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37935204F8D;
	Fri, 21 Feb 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+nN98Uq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08618204683
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131040; cv=none; b=B1Gv10fHKFBs7M2XRVwgbARHOk8w3V7LBUyeW2czydOobRqa088bYFVtXCgOjruUydc8ujsMY2CUeUXSunIH0fak3orh/li+8ECFESE9+22wSgh94mVeWITkh8MmDtwWP22xtl+gJQ9zOAMP4RtzHd4ZICb0goHOQhAumakXDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131040; c=relaxed/simple;
	bh=ieEZ8Sj8IsSSLjadFm3PRFXl2p7vBygmX2ckLVo+/Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzGy2zUIwQVVqEY1N1PaXU8DJNOPP5GRXiTty75LBWHC3dsRneXM4aCCsZlTDm2tCJxb4SoXOboTZbJQF5YL1xuIM4tQcNm5rTDQEz6iSKMjFYVwLsvfElmeLORcXbDjDsuqVnuOzktb1MjhqRiLnbQO9ls+SpfAMOzxQQVPeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+nN98Uq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740131039; x=1771667039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ieEZ8Sj8IsSSLjadFm3PRFXl2p7vBygmX2ckLVo+/Nw=;
  b=Y+nN98UqN67s9+MqVieUmFkww5SNCsntukfqJhksqKDkEhvHdbuTwLvk
   K7rO1f9KMqSu+IFvmThFYCyVcKAdPBMq25aIUjoX+i0SGgSiNORjc69VT
   viISEsUA74DnufT07N+cqLV1wNyqCvseGTMdm8NKrwu9NlEyZ7PU3sLpG
   gszkDOQgNF5+f0+5RA+xL6XfYRjndhCCs0Z8k4rg2zkeD7HaxwqSQOqiN
   fUGIIaqx2B8dBh1TG5Pq3b585pP9bQ9Kj5pN5txYnIgvlyNuNbR/N9kth
   OsI7UiWa3hz5eQ1rVJK2JYm/9zt63ro1VQHJHXwpWCX6QlrMyxZTGbTQA
   w==;
X-CSE-ConnectionGUID: u+xg/VP1QpqXNzPF9bskXg==
X-CSE-MsgGUID: R8ipBJggSS6nj8AWumfHLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58353466"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="58353466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 01:43:58 -0800
X-CSE-ConnectionGUID: v6S1tz5sQgiJeT55/GG1PA==
X-CSE-MsgGUID: aAG5BJMFQQeoX+5mq5NyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120572761"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.245.97.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 01:43:55 -0800
Date: Fri, 21 Feb 2025 10:43:53 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>, linux-kernel@vger.kernel.org,
	sakari.ailus@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, andi.shyti@kernel.org, broonie@kernel.org,
	zhifeng.wang@intel.com, Wentong Wu <wentong.wu@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Message-ID: <Z7hK2ZYt4K30ACc1@linux.intel.com>
References: <20250221083713.25947-1-lixu.zhang@intel.com>
 <2025022134-storewide-greedy-8d4d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022134-storewide-greedy-8d4d@gregkh>

On Fri, Feb 21, 2025 at 10:36:02AM +0100, Greg KH wrote:
> On Fri, Feb 21, 2025 at 04:37:12PM +0800, Zhang Lixu wrote:
> > Wentong is no longer with Intel, I will take over as the maintainer of the
> > Intel LJCA driver.
> > 
> > Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
> > Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d9fd56f205c0..da09f84a87b1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11818,7 +11818,7 @@ F:	drivers/crypto/intel/keembay/ocs-hcu.c
> >  F:	drivers/crypto/intel/keembay/ocs-hcu.h
> >  
> >  INTEL LA JOLLA COVE ADAPTER (LJCA) USB I/O EXPANDER DRIVERS
> > -M:	Wentong Wu <wentong.wu@intel.com>
> > +M:	Lixu Zhang <lixu.zhang@intel.com>
> 
> Wentong also needs to ack this, just because someone leaves a company
> does not mean they automatically loose maintainership.

Not sure how to conntact him, his intel email is bouncing now and
he did not provide alternative email before he left. 

Regards
Stanislaw

