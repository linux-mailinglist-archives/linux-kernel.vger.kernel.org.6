Return-Path: <linux-kernel+bounces-206122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B52900484
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3759C1F22534
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFF194098;
	Fri,  7 Jun 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbNHu0uU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2E15DBC1;
	Fri,  7 Jun 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766574; cv=none; b=pmuskYLnt14vC8+wQlVwGPeePiN/ypd3kh1NIAca2gHtSmJyDmeFHGP1ta50qQNIQiZuPjzmc/KirioBYc1t+/XsqAzl6O6JL8oIOLQ5i5t/bxMK698/JhXieCxjtvgd5881Z6ko7vYngszohFKFYwe6VuIkZ6R3pWhNgVGewqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766574; c=relaxed/simple;
	bh=HA7k21McxCzM1Wd5tina4b9xJX2yCPad3KU7yAY27LI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRL1l4YR09UnyfNQtnG2it70wL8fFVJcryq61HCIzOIMSMZhjsa9W5sL7g5cpJV3GIqF22BvreyV54NQCjBTSGJvEONTUuQ9Ncu+4YFgvO+D2dWBCxyhe2q0/6xn5RojsA+BzWGsU212U1/QnJnbfl+rqcVbVtm/Vwi4bbdrxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbNHu0uU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717766572; x=1749302572;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=HA7k21McxCzM1Wd5tina4b9xJX2yCPad3KU7yAY27LI=;
  b=IbNHu0uU4aStn8jEiJQK9gVfngAuBh3xBF7JMLc6fWHySlBmBLC0tSDY
   sT2jeLV9NyY8ZoCYGkZ6Ql8+XMI/2HrOqYG5DWsziA9FmG2BhJ/UPRrme
   oHBI+Bl5KC7slVICRJEKVfPqXML7lTexlWxSaGjEJ9jPEh6e7hz5iq1lD
   8gHY7UlmiZeq0dNlYxg0jguTn7+VfNQx/Zbo7jZ4E50QNa2yYN8+CNCOA
   vIeaIJp5RCGZUdw7GHByXU8FK5Zbau+r464IrIS79xwtQp360qtgg21B2
   /+ccr2YL896LVuB6QXYUPppZK726eVjGKTEdraKKZk4+DmxjFWlAGUFLp
   g==;
X-CSE-ConnectionGUID: G4NkuM9IT4u/Ni/22LDVgA==
X-CSE-MsgGUID: /MwOVzQbR7eZW+FJwnEi2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14290983"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14290983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:22:52 -0700
X-CSE-ConnectionGUID: KIY+D643RKSGlC9J2katxA==
X-CSE-MsgGUID: qkTb7GKBRJqJFt9ioBHCtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="42741001"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:22:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240604-dell-pc-double-free-v1-1-6d81255b2a44@weissschuh.net>
References: <20240604-dell-pc-double-free-v1-1-6d81255b2a44@weissschuh.net>
Subject: Re: [PATCH] platform/x86: dell-pc: avoid double free and invalid
 unregistration
Message-Id: <171776656561.2612.17760986388744096307.b4-ty@linux.intel.com>
Date: Fri, 07 Jun 2024 16:22:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 04 Jun 2024 23:41:24 +0200, Thomas Weißschuh wrote:

> If platform_profile_register() fails it does kfree(thermal_handler) and
> leaves the pointer value around.
> Any call to thermal_cleanup() will try to kfree(thermal_handler) again.
> This will happen right away in dell_init().
> In addition, platform_profile_remove() will be called although no
> profile is registered.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-pc: avoid double free and invalid unregistration
      commit: dd637f5cd5f334d2d014872544470031415cec3b

--
 i.


