Return-Path: <linux-kernel+bounces-253598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED019932394
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2992B1C228B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C6198857;
	Tue, 16 Jul 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVnzFSMO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29844369;
	Tue, 16 Jul 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124441; cv=none; b=tewJVO1dM6KuPZBfqMs5iIfrmJBYRbnmgcwYAV8fBVfsr+2i4dFiq5LjYh7JmsCyP9duqNU4jTLRSaKKLy0mzrQGLFy47UiWA4lz8s4DUVVCE0c+P8dD6hrYPK4YYiGsZ8qIhttUEPaEa+DFBQYpNhJbwSVDCL4Y3R/AysZz+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124441; c=relaxed/simple;
	bh=3zE6ikIX0FQeoKFbzrnOX+xEwyLxQMGxtSsYhRQcMWQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GRd/Sg+uPGoVaOY/60pe8Hx1WBWiIvT2G0g0bFfO7kD9mnINHyaoSopSpF4cGHavQqS2106jkQpEq/7GgP6AESGxU8DGgLUQL2S1t0jM9ukDuP6yAcs0EOXy67eYetlA7wy72DxnKhRIV3nn8y38CDYIwmPeVJyDzAIz0vFVF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVnzFSMO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721124440; x=1752660440;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3zE6ikIX0FQeoKFbzrnOX+xEwyLxQMGxtSsYhRQcMWQ=;
  b=LVnzFSMOaTuBWq2d7yNwVOPAFk/VLt2TFju0hSIqnr9kP52+f2dq6ncc
   hkKHb6crMYF5r1ok45ekfRIiOh/5kwnVVEXSaIbc7/Ht2DFjoClBafG7S
   Gz3r4KHs3BIv5WWqUK189jQBkg6jIiGkVqv4a6I28DvnNGkG+6YDg5moo
   QFFT/ZYfBTS4AMBaNmldxjKnheqYQJKN9FcENsZS1gMTZAqnq1x6CFSQv
   wIoIqwsyg8g7H5M+YPlobe36zt71nH9qh7n2nH20paDtZ+cfYr7Bau0/P
   mTtJap7VQpTudDw32A/2XztWW+74XYgcN93A7CH8+VXyGS4jj1gLhnJNm
   w==;
X-CSE-ConnectionGUID: gVwXFWYTR1Wv0/TRV7NMaA==
X-CSE-MsgGUID: N4CdFr3aSrGIzdxrMKSs5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29699277"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29699277"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:07:20 -0700
X-CSE-ConnectionGUID: 5STF6bgJTbCV+jA3Ye4Y1w==
X-CSE-MsgGUID: l6mdr8y7S8S9IKv2RKPk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49704832"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:07:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jul 2024 13:07:13 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: fix TUF laptop RGB
 variant
In-Reply-To: <20240716011130.17464-2-luke@ljones.dev>
Message-ID: <529238c2-ec4f-1807-8cf3-1e74ca6a172c@linux.intel.com>
References: <20240716011130.17464-1-luke@ljones.dev> <20240716011130.17464-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jul 2024, Luke D. Jones wrote:

> In kbd_rgb_mode_store the dev_get_drvdata() call was assuming the device
> data was asus_wmi when it was actually led_classdev.
> 
> This patch corrects this by making the correct chain of calls to get the
> asus_wmi driver data.
> 
> Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support variant of TUF RGB")
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 7d87ff68f418..2b968003cb9b 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -906,10 +906,14 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
> -	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	u32 cmd, mode, r, g, b, speed;
> +	struct led_classdev *led;
> +	struct asus_wmi *asus;
>  	int err;
>  
> +	led = dev_get_drvdata(dev);
> +	asus = container_of(led, struct asus_wmi, kbd_led);
> +
>  	if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &speed) != 6)
>  		return -EINVAL;

Thanks. Applied to review-ilpo / for-next and will go into Linus in the 
main PR for 6.11.

-- 
 i.


