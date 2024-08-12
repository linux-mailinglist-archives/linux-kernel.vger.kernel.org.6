Return-Path: <linux-kernel+bounces-283418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0D94F234
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A6283B10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DE187342;
	Mon, 12 Aug 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HR+s279r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576A18732E;
	Mon, 12 Aug 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478258; cv=none; b=RaHhl+JDLTLpGnAwILjm/zPo2/hiUsV3v9R6fzW7zSw47xsIEBkQI2pTqYcWPQXL3iuovbgb5I/4+ykdNeq/EmQ0XdjFCC6k+qdLOAdbh4IaRjM/PEiUHdHhxV4oPg9NAHV/3r4iMVEXVv+PlKCXmSwBHUifx8hCgcbVkrCLZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478258; c=relaxed/simple;
	bh=oKAtC7O7pozKt9AtQSMuJW3MHkZZVJT9z7q4eY9medc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=itvVXaTTgsSbFFFNSbdKoV4mcM3Rrr+NWG1zn8n2Lz724iIOXfapefZJrv79cvd8wboN8HifgDRKgtEv+TBDB1lYEOZP+sP2YpZts1xRDO7tiMCI2IOakgMskdLhN6bBvecySipC6jBVjxu9vufD6q/DBHE2JFp1QEBJje63WWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HR+s279r; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723478257; x=1755014257;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oKAtC7O7pozKt9AtQSMuJW3MHkZZVJT9z7q4eY9medc=;
  b=HR+s279rq3M9fgKQJtK9yJAOwr4aVHcdCAbuRda8Swb176lWBYm0BVy0
   9PwQ5IijgrwRpIgp6n1+9EEkkiBHPCg43HFKKhZuK2C9RqkFEt9qR6WVk
   pdPAT5zM6J0n8u2oeYQhAbtDAZW4bp800wo5NFp8mRzW1RRjISfJAJMeY
   g6uuWVJzO7LSGs17tU/iSG7jJxMmd2oRZnEaaDTbnxWxIv3biMKq3f9wb
   4o8y6cUBb5Lw7+XephMhJxar9x3Ua1fkNSVrHnE64snNd4WoeSjkxS/KM
   1EeJdDvcT+oHlrWp74JfsVQ1QbOb85hY4rtb+RtxVYAlVoiskB9FVJ3ua
   A==;
X-CSE-ConnectionGUID: JOVf8VJJRzKrd2DKDSwWlQ==
X-CSE-MsgGUID: i8JljWEJQ+OA4xWAb7799Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21473454"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21473454"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:57:36 -0700
X-CSE-ConnectionGUID: FPYbT12sRhCDnpyjOKlFWQ==
X-CSE-MsgGUID: SRzSoY6eRc2po280KtfpCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58372732"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:57:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 18:57:31 +0300 (EEST)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: mustafa.eskieksi@gmail.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <8e06b567-8471-4109-bab1-f44a8d9780da@redhat.com>
Message-ID: <121c2aa1-c89b-49bc-c71e-73009b4e04fe@linux.intel.com>
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com> <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com> <8e06b567-8471-4109-bab1-f44a8d9780da@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Hans de Goede wrote:

> Hi,
> 
> Thank you for the new version, much better, almost there I would say.
> 
> On 7/19/24 11:59 AM, Carlos Ferreira wrote:
> > This driver adds supports for 4 zone keyboard rgb on omen laptops
> > using the multicolor led api.
> > 
> > Tested on the HP Omen 15-en1001np.
> > 
> > Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>

> > +static int __init fourzone_leds_init(struct platform_device *device)
> > +{
> > +	enum led_brightness hw_brightness;
> > +	u32 colors[KBD_ZONE_COUNT * 3];
> > +	int ret, i, j;
> > +
> > +	ret = fourzone_get_hw_colors(colors);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	hw_brightness = fourzone_get_hw_brightness();
> > +
> > +	for (i = 0; i < KBD_ZONE_COUNT; i++) {
> > +		for (j = 0; j < 3; j++)
> > +			fourzone_leds[i].subleds[j] = (struct mc_subled) {
> > +				.color_index = j + 1,
> > +				.brightness = hw_brightness ? colors[i * 3 + j] : 0,
> 
> I think it would be cleaner to drop setting subled brightness here and instead
> call led_mc_calc_color_components() below ... :
> 
> > +				.intensity = colors[i * 3 + j],
> > +			};
> > +
> > +		fourzone_leds[i].mc_led = (struct led_classdev_mc) {
> > +			.led_cdev = {
> > +				.name = fourzone_zone_names[i],
> > +				.brightness = hw_brightness ? 255 : 0,
> > +				.max_brightness = 255,
> > +				.brightness_set = fourzone_set_brightness,
> > +				.color = LED_COLOR_ID_RGB,
> > +				.flags = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN,
> > +			},
> > +			.num_colors = 3,
> > +			.subled_info = fourzone_leds[i].subleds;
> > +		};
> > +
> 
> With this all setup, you can now call:
> 
> 		led_mc_calc_color_components(&fourzone_leds[i].mc_led, fourzone_leds[i].mc_led.led_cdev.brightness);

One additional thing, having a temporary variable for fourzone_leds[i] 
would be advicable to reduce the line lengths / complexity of the 
expressions.

> here, this makes how the subled brightness is set here (on init) identical with
> how it is done on set_brightness calls which is more consistent.
> 
> > +		fourzone_leds[i].brightness = 255;
> > +
> > +		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds[i].mc_led);
> > +		if (ret)
> > +			return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}

-- 
 i.


