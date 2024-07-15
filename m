Return-Path: <linux-kernel+bounces-252298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B793112A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F297F2839B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8016186E35;
	Mon, 15 Jul 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEnL1L1l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C866AC0;
	Mon, 15 Jul 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035676; cv=none; b=Y1a68euJF18/xC0oodU5AmiIH2I3tEiQT+XQZ5kAdWNmt/JqkAkF8ZWaBMHvRUy31cGyPzHXaVkz7W8wZEwINjfnzWml0fZ0p3nW+QmelYzZEmv29fjk4+0qhstDxlRWluaTDAZAjP7Wmo3OLewMyNitfqzqhXfMmrKWkfc62PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035676; c=relaxed/simple;
	bh=4HrD0MVt1a5kb0h8Uz1TwttE8DDSwiBNZBqPaE2aJCo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BROed/wZt8QA71s1vYybAz/ptLiKsnn7Gs8R/TQtrTxg5nOp3fE74WIvL9QDRjZ5H5fYc6UBGGZKGBqXUrl8zWbGpd1gOf6eg4PWwyJiyMU+1bRDANRhra8w5bEw3HLMXyxQj8MQFPrCKwvnnRS2QfZ+H66d+3RY4XDvi9DIDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEnL1L1l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721035675; x=1752571675;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4HrD0MVt1a5kb0h8Uz1TwttE8DDSwiBNZBqPaE2aJCo=;
  b=AEnL1L1lZdEsfuS1QcaC2I4DQ6EscVDgcHHM4KBRkUT13p+4bXPaUqRk
   13nvE5ztOkM3n9e+vm+jsz08DvuVg4TAtUoauNpQJJ54DYvc9bT5ayNbo
   LZG0eDZ2wZ+FVerX9XLAABN2HCdd+MKrSSqBcmLEHrwWXC9P6XPGoUDlR
   8wpwMj+sf883qwCNnfDxw9rPR8MnIlWv802aSfE5gbkoOkNIDx2xhtB/G
   OTb4tNBXXRyIEb9rnwCIrO11ffbE9ocB9mkEYGYcrugbIJAxPaIBvQ7Xt
   bulxwXz4i787SwR3K0LIeE/x5Xmk/F2l/RzCfZluFMAeel8DSD/QBEndn
   Q==;
X-CSE-ConnectionGUID: B6+hFjzrSPCENimVtXw3uw==
X-CSE-MsgGUID: 8m0Hg2SRQgqGhsfzXuNMzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35833910"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35833910"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:27:53 -0700
X-CSE-ConnectionGUID: LU6z5m6xT2q9aX/CBGdoAA==
X-CSE-MsgGUID: T/i+Ufc8Q9Go39EbnR+W7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="54389077"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.131])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:27:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Jul 2024 12:27:45 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH] Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support
 variant of TUF RGB")
In-Reply-To: <20240713074005.66254-1-luke@ljones.dev>
Message-ID: <5c4ef8d8-2806-5bb6-2946-368cf1ebbac6@linux.intel.com>
References: <20240713074005.66254-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 13 Jul 2024, Luke D. Jones wrote:

> In kbd_rgb_mode_store the dev_get_drvdata() call was assuming the device
> data was asus_wmi when it was actually led_classdev.
> 
> This patch corrects this by making the correct chain of calls to get the
> asus_wmi driver data.
> 
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Your tags seem messed up, Fixes is in Subject in place of shortlog that is 
completely missing.

Could you please correct these issues and resubmit, thank you.


-- 
 i.

> ---
>  drivers/platform/x86/asus-wmi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 799d928c7d3d..2935af013535 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -879,10 +879,14 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
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
>  
> 

