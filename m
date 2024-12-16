Return-Path: <linux-kernel+bounces-447809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B120C9F374A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446CB1890B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD3204F75;
	Mon, 16 Dec 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PajtvaV6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0302046BA;
	Mon, 16 Dec 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369438; cv=none; b=o+tJ7kg7PoJ5v02F6Yjl/BwQCoUP7OI4LYsMxTrGPfuYR3NL+FuezLjzamvMu66Npiu+/pQzKsPZwKXgeg+fbkzX/caJY7p4qyLtnRDkRwDW5HSDnayEPQ8eo0OL4YcsWadmTj2SeLkFHjoOHCgrWVG6ljTKHXaIwgC4eF//5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369438; c=relaxed/simple;
	bh=rvhls9t1TahU3KXKeXMQWn6cCbvrx0/fTmszHUCqIGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gaqmAiWlR9qi4OMvPY/xoEfiJMGsv0no6xQrhZWxt+uQIQC2t+qVcLunnHOOF86HiuxgbEaUD1Mk+jMEEvX1Y0EpH1nwKVWynXF/hby3cqtOg0CNyV/4hZk4Uem/D13CIIKX1sD/Cc+FURBEGPVpzKHhA8vPOwkg1JUXTiBL2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PajtvaV6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734369436; x=1765905436;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=rvhls9t1TahU3KXKeXMQWn6cCbvrx0/fTmszHUCqIGk=;
  b=PajtvaV6YnrOfwyBq17Grmms+SFbQCBXUwufVHWyh7/xYehOh9RNkVCj
   sJgw4T0f4ykVUuwvPl6k3sSC2TYzj/9p6rlDOIVEnT+Kb0Q+hELDTHjM9
   nCPAEIVhbG3pcnaG+T1lDtTiUyGZgY1fB+fvyl6xPVzXaUxhs7Xdihjz3
   vuoejJwVuKdQ2dBK1Ds8X96s0xvkW+FLsBhKYjzwGf1pPDA4bdrEbmd7N
   W0tD89KxLeHhgNmYvFqEY0S1x4EpLqFaNCrDOJ1VdLzvwDOhpuRcldeQH
   6dKlFGzZEjBi6jb8bRkgT1ACQjd1zfbajwxKtRKBaDmp8EavhGDYRyU5d
   g==;
X-CSE-ConnectionGUID: a5X4h/ZtTe+gcspUmgUwJw==
X-CSE-MsgGUID: 0dXK8GUuSHGKECb2sM7lOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45460332"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45460332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:16 -0800
X-CSE-ConnectionGUID: eEG35q4LTO2fTcIeo0o5yw==
X-CSE-MsgGUID: wyRXEIy+RKS0ewlaXbk70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120519914"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:17:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Tero Kristo <tero.kristo@linux.intel.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216083409.1885677-1-arnd@kernel.org>
References: <20241216083409.1885677-1-arnd@kernel.org>
Subject: Re: [PATCH] platform/x86/intel: bytcrc_pwrsrc: fix power_supply
 dependency
Message-Id: <173436942795.2913.1575411898084058366.b4-ty@linux.intel.com>
Date: Mon, 16 Dec 2024 19:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 16 Dec 2024 09:34:05 +0100, Arnd Bergmann wrote:

> The driver now fails to link when the power supply core is missing
> or in a loadable module:
> 
> _64-linux/bin/x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_irq_handler':
> bytcrc_pwrsrc.c:(.text+0x2aa): undefined reference to `power_supply_changed'
> x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_psy_get_property':
> bytcrc_pwrsrc.c:(.text+0x2f6): undefined reference to `power_supply_get_drvdata'
> x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_probe':
> bytcrc_pwrsrc.c:(.text+0x644): undefined reference to `devm_power_supply_register'
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel: bytcrc_pwrsrc: fix power_supply dependency
      commit: 6bcb50954580caa48fceeeb4b4af0fef746a89d6

--
 i.


