Return-Path: <linux-kernel+bounces-227694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A7915598
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3319287ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331A1A00DC;
	Mon, 24 Jun 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htW79obl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A819FA8C;
	Mon, 24 Jun 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250835; cv=none; b=A5K7XE+NyZ1m4ORU8QioNxSUYd9UT7UBHrWMlpbsBmXGTxaFTgWwpGxnvhpYs5f4Y2ZX4fepQ6SM9XfDN/FNwUFnFPbemsivR4ZgPkp53l22mGfiwfLw4n/1K9d7zX9mMuiUCXSgkD7PxiU4dgx6PGaScj8ikhAnaDTMGGJ5kWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250835; c=relaxed/simple;
	bh=z1Kf5EeWUndBUk5AnId/gIfRD4oVKv2FV9xR1dZLOIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GQ2LVAcUWaaFf4x26dNFYcnLa0JDElS3tzh9zLbCf2yvgD8jYI4hMDGlNqhGE+lqROmaE9lhtRo3UKKExBhypuUxGxe+kGMkeIMZAdhgGrmaNTA93oIVDejRoBqGsJa9Nz+VZwQU8ADZh6lsJ2D+G/cKtNZGl2Q3s0pAfTUot7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htW79obl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719250834; x=1750786834;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=z1Kf5EeWUndBUk5AnId/gIfRD4oVKv2FV9xR1dZLOIw=;
  b=htW79obldMqarSEjDgDvrRJo6aI1SEopNboKjcju+UC61Kg+2uuj79T/
   6qnWQvndw2uDrgIFx0VlDN5OAP9wHJ42wea4o2pZlR8BCP88searE7aaW
   Uy144pxud5h5F+hJ61X552H4/TwI+bFErAw1xQby0+OGmaeIw2ns5mNFv
   sdNUBR0tTQSp5DGVPoISdIYeWYPJ4fPju8XkNG015HCgvCq1HZiiSEhk9
   6/6Pzcq+y31lgCsF3eaClyabEyoKfNgP33T94D2VQ4RYB9rvJmT/NuVqm
   H/GMiq6i8/zMG3QmSKLNkUwcTjLnYqb9T+ZVn60MjJkM8CoyB8aLttSaU
   Q==;
X-CSE-ConnectionGUID: 0fQj4BcaRZiptyj0Fhjbeg==
X-CSE-MsgGUID: eMWXuGo9RDmAW73wuXmQhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16112068"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16112068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 10:40:31 -0700
X-CSE-ConnectionGUID: kUyIY7jNQJmOglPawkpxNg==
X-CSE-MsgGUID: P7YvPGmYRt2/E50zsz1kDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43457395"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 10:40:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240624173116.31314-1-W_Armin@gmx.de>
References: <20240624173116.31314-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 0/2] platform/x86: wmi: Add driver_override support
Message-Id: <171925082256.3544.1603018074608040428.b4-ty@linux.intel.com>
Date: Mon, 24 Jun 2024 20:40:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 24 Jun 2024 19:31:14 +0200, Armin Wolf wrote:

> This patch series add support for using the driver_override sysfs
> attribute with WMI devices. The reason for this is that there will
> exist a couple of generic WMI drivers in the future for allowing
> driver developers to directly access the underlying WMI device.
> 
> Since those generic WMI drivers do not have an ID table, the
> driver_override mechanism is used to bind them to WMI devices.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: wmi: Add driver_override support
      commit: 12046f8c77e0ed6d41beabde0edbb729499c970b
[2/2] platform/x86: wmi: Add bus ABI documentation
      commit: 618ba6abfc57bde2c2cea7c2b23e4c27fd5a04b4

--
 i.


