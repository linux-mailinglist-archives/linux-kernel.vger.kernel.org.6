Return-Path: <linux-kernel+bounces-322794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50287972E20
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE01287F10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231E18C32E;
	Tue, 10 Sep 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2S/WxUd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434118C324;
	Tue, 10 Sep 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961174; cv=none; b=hH2ovjyowvNsWOVxH/F/B6UAlEIKIABWKuNZYsXlbQFH2G+1oOHgerizmWY8gL5dYLq/RMSNwaW3zVvPi64eotmtXxDvyBQhgMQeJT7ciT5d3+xc+aMc8bj9F0VMj+sOuImLfzsUrAqmyaWDbX8BS3bQDdCT1DkYjo5UUbN2XHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961174; c=relaxed/simple;
	bh=/HFsesU4JBmKCgdLae1k+5oS9Uch7EoN1ToR7+wJglo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E1EpCJ4XCD8rhhJNmqQtuRKc5tPdeqbsyH7IC1aCvZrUaChMXjB+y1gE+Wx5W+0bX7b6SwfpbYxdWSp9THNf8cYU9K+QneNs2JC9C6p8tB5j9xdKDRyvXrYajMbvNNsv5ZCohhv+bLAY2ijoQgKRAigLpGBQovDq3ciCZDVrKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2S/WxUd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725961172; x=1757497172;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/HFsesU4JBmKCgdLae1k+5oS9Uch7EoN1ToR7+wJglo=;
  b=G2S/WxUdtLsxFUNCl2snB13dvUhb/HhIQrTQpMJiCNrGVBAIvC3Mjo/L
   sk0jUeY0KgPzMOctXY2MDWKlBcJptS9HxlagB5YovL32qzRpZRS5Ck1Ji
   oMsYsq+Wo6yeIjRGrEy46CKRp2YUV/elEp7obFjkZ3RaOhp6cAc+1zEYi
   XTjsN0TZ0QM+2B6d8UCPHiqgenf5hhCmNbby3Gg1DG6xJq28OvtAB7iwk
   lqxyNxA/g6rGfCVPhqmYaEy2ZRBFtzCpsC4kOZvjCaODDDeeE6seaJJ6x
   GXTzpUJtWB9q2x92q7gL7t8N3V/7PnTb/7glgtJrq/lY4NdSoiqm1mMDw
   A==;
X-CSE-ConnectionGUID: H+kJz2r5S6GII9vgBjMsIg==
X-CSE-MsgGUID: poBVVnp6Q3iDs1LEVHO6yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="47214115"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="47214115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:39:32 -0700
X-CSE-ConnectionGUID: hT/55hIiQHebLmLLUza3FA==
X-CSE-MsgGUID: fOtpBdu8Qj+97IWFV0jnUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="67722288"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:39:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Sep 2024 12:39:25 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH] platform/x86: asus-wmi: don't fail if platform_profile
 already registered
In-Reply-To: <20240910045443.678145-1-luke@ljones.dev>
Message-ID: <baebdb06-0ada-cab0-b9c3-154346be4e72@linux.intel.com>
References: <20240910045443.678145-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Sep 2024, Luke D. Jones wrote:

> On some newer laptops ASUS laptops SPS support is advertised but not
> actually used, causing the AMD driver to register as a platform_profile
> handler.
> 
> If this happens then the asus_wmi driver would error with -EEXIST when
> trying to register its own handler leaving the user with a possibly
> unusable system. This is especially true for laptops with an MCU that emit
> a stream of HID packets, some of which can be misinterpreted as shutdown
> signals.
> 
> We can safely continue loading the driver instead of bombing out.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index fbb3345cc65a..d53c4aff519f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3876,8 +3876,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  		asus->platform_profile_handler.choices);
>  
>  	err = platform_profile_register(&asus->platform_profile_handler);
> -	if (err)
> +	if (err == -EEXIST) {
> +		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> +		return 0;
> +	} else if (err) {
> +		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);

Don't print __func__ in user visible warn/error/info messages but use 
plain English please.

>  		return err;
> +	}
>  
>  	asus->platform_profile_support = true;
>  	return 0;
> @@ -4752,7 +4757,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		goto fail_fan_boost_mode;
>  
>  	err = platform_profile_setup(asus);
> -	if (err)
> +	if (err && err != -EEXIST)

Hi Luke,

Hans had a comment about this line against the previous version.

Also, this patch has entirely lost the version information. It's v3 now I 
think.


-- 
 i.


