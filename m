Return-Path: <linux-kernel+bounces-295068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5A959644
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B951B1C2161B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C39C1ACE0D;
	Wed, 21 Aug 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc4Ka6b5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E91B81CB;
	Wed, 21 Aug 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226149; cv=none; b=YO4qv/OP62MdhBA2xqsvaNDdzffWzx9sbngXiNtzaVv6P/B8GCiGr3oN9BvX5EaEKUNYQGgJkiqVWCuY2BLmL8SfQl6AObp4EIEsecxvM/CEfXQgcb/SlGOZ12473WFKZmx+6LfReUGldL+x1eA5L2Ar5WE84P6iabk5LODyLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226149; c=relaxed/simple;
	bh=t448hFoOS1T0zzj+LYQiiToiW+KeZz0OuV3kcahtYxU=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=uAq8P+GydVqiytFf9siJGDKXHnyM9qpwai2rrL6AcWzO85Kum2xCk72pdfUs4efcJxn+jBIr8vOVrMJ6/hpWrcIxW2tm5G8v4ZUNGrWqLaTM7KcOg0L+oryKCqpToEjBSIShT0ONSQUf7YpiNv6zH5Agv0eBVTMoXLCeHyHUCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc4Ka6b5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724226148; x=1755762148;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t448hFoOS1T0zzj+LYQiiToiW+KeZz0OuV3kcahtYxU=;
  b=Hc4Ka6b5HVquXQyplhPkwAVFdMa7h1kBDAjv1YT2SwntVypJ+8OIDYxE
   Yf6CGupMuWyHpEDubZb/RjTjE8iEkvARyeC2l0u1GNnEgSFPZs2kfHp91
   j9WdnfHa/CTc6s3vZb36GjkkfhaABtQh1EbF84hBz4aJq6pvAY/W2+smb
   tLpq1dH4O6W+PLDSKbtNaO5bEOUtSf4K04kZaSu4WeDLZbjto4icvdOY0
   xrFzyYaUkauQl2ZBXoqpfNxqh7yBeWnuwox14OjMH3t2n0tpu6tp3BfSD
   QBJWSdiMeGvBopyYVPt9GTxuRoAXbEeDO2fB5y3I8cTVr9Sw5ku+z9LkU
   A==;
X-CSE-ConnectionGUID: xnPLsjcZT361hEHXmCyYIw==
X-CSE-MsgGUID: hgD3/wtgRyeLCgplSoYSHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13128425"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13128425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:42:26 -0700
X-CSE-ConnectionGUID: ML12ENFJTXeKeK1l8SGATA==
X-CSE-MsgGUID: Pc2xMlQRTGuMKN1n9t0BJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65848552"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:42:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 21 Aug 2024 10:40:10 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-4
Message-ID: <pdx86-pr-20240821104010-1325128977@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.11.

Changes:
- ISST: Fix an error-handling corner case.
- platform/surface: aggregator: Minor corner case fix and new HW support.

Regards, i.


The following changes since commit 7cc06e729460a209b84d3db4db56c9f85f048cc2:

  platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands (2024-08-08 15:03:09 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-4

for you to fetch changes up to 46ee21e9f59205e54943dfe51b2dc8a9352ca37d:

  platform/x86: ISST: Fix return value on last invalid resource (2024-08-20 14:19:09 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-4

Changes:
- ISST: Fix an error-handling corner case.
- platform/surface: aggregator: Minor corner case fix and new HW support.

The following is an automated shortlog grouped by driver:

asus-wmi:
 -  Add quirk for ROG Ally X

ISST:
 -  Fix return value on last invalid resource

surface: aggregator:
 -  Fix warning when controller is destroyed in probe

surface: aggregator_registry:
 -  Add fan and thermal sensor support for Surface Laptop 5
 -  Add support for Surface Laptop 6
 -  Add support for Surface Laptop Go 3
 -  Add support for Surface Laptop Studio 2
 -  Add Support for Surface Pro 10

----------------------------------------------------------------
Luke D. Jones (1):
      platform/x86: asus-wmi: Add quirk for ROG Ally X

Maximilian Luz (6):
      platform/surface: aggregator_registry: Add Support for Surface Pro 10
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
      platform/surface: aggregator_registry: Add support for Surface Laptop Studio 2
      platform/surface: aggregator_registry: Add fan and thermal sensor support for Surface Laptop 5
      platform/surface: aggregator_registry: Add support for Surface Laptop 6
      platform/surface: aggregator: Fix warning when controller is destroyed in probe

Srinivas Pandruvada (1):
      platform/x86: ISST: Fix return value on last invalid resource

 drivers/platform/surface/aggregator/controller.c   |  3 +-
 .../platform/surface/surface_aggregator_registry.c | 58 +++++++++++++++++++---
 drivers/platform/x86/asus-wmi.c                    | 16 +++++-
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |  3 +-
 4 files changed, 70 insertions(+), 10 deletions(-)

