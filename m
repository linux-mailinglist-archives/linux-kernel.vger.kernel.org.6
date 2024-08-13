Return-Path: <linux-kernel+bounces-284307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4C94FFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811F3285D73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3BE170A27;
	Tue, 13 Aug 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4IxLIX6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE1170A0C;
	Tue, 13 Aug 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537284; cv=none; b=FQiIE1rLJy0Ulk4N+6Jd0mBxUzfb0rPrnowKZmRBEG7fyBHUc5A4mOgVa8QB5Xm0NLEBTR/p5YIlUPRmtfOVgxWR1i+DHg13JnDsJ+A8M2ps7qPMH0zYPgG8/dTRhIQiYSrmBUwkFVdkHzH9bbvy93sE0zR1JevyU7AHiYDkNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537284; c=relaxed/simple;
	bh=L7hqzthwmI7OmC2MLx1ogsTcW6REgXrYtGxgGoOhF6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GR0RoM5Mj0KBXsDZTEhit6087Z3xTuIOSOfqPGRufuwK76HCpWXD1usRir4Qgav0iuJSxM/360gopj31JsFVNyLSSz9tTOC+2y6atNrj2qxOfKBZ5rLWvHDa17H32+MaH/JE7L1cTTGDNrYPj8ZPtpaOxKc6TT9B1i9N8/h7mVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4IxLIX6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537283; x=1755073283;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=L7hqzthwmI7OmC2MLx1ogsTcW6REgXrYtGxgGoOhF6I=;
  b=f4IxLIX62I0lWUoHjyoteqfFrgs9Va3kOniE7ftEuARlJaLcc0Siwj+B
   fUDoIM8ysTFerfrecjS3TOTomRn9yS/h3VbSnc+alDntL5zMGgecbU9+4
   a/HMH93WcYLkyWb06GlvyiKUx8Dci19M9K/ogv6cG9UnWwU+6NZL2bUol
   0KshvYmb907sGlL8f1w+PoTiU/uqE9WWcqH2WAAw5b0Cde/hkvqcLfRMF
   G+UGXNG1YRUQtP5W3QEnY0s1SA4tbSq3+vE9UC13VEKPdKTOOeQMJ2VDV
   Ekko1m9uP/HIXSRqxxbl8RJcCvtvAQk8X4A2y70SstsOI00ybV8Z+0scM
   w==;
X-CSE-ConnectionGUID: nxPeYkJKRJG6X08Xw/bgpA==
X-CSE-MsgGUID: Ispb+u/oQaKxNtS9zyachA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21327792"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21327792"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:22 -0700
X-CSE-ConnectionGUID: ms+czj99QzuHH3izpo6LNg==
X-CSE-MsgGUID: CEBqrMPfSw+Rj9VoOApOzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="81817241"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:21:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
 corentin.chary@gmail.com
In-Reply-To: <20240805234603.38736-1-luke@ljones.dev>
References: <20240805234603.38736-1-luke@ljones.dev>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add quirk for ROG Ally X
Message-Id: <172353727690.2056.11852281867225547096.b4-ty@linux.intel.com>
Date: Tue, 13 Aug 2024 11:21:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 06 Aug 2024 11:46:03 +1200, Luke D. Jones wrote:

> The new ROG Ally X functions the same as the previus model so we can use
> the same method to ensure the MCU USB devices wake and reconnect
> correctly.
> 
> Given that two devices marks the start of a trend, this patch also adds
> a quirk table to make future additions easier if the MCU is the same.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: asus-wmi: Add quirk for ROG Ally X
      commit: d2dfed310aae0739dc87b68c660357e6a4f29819

--
 i.


