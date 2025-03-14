Return-Path: <linux-kernel+bounces-561593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20970A613CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5518978FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E0200B85;
	Fri, 14 Mar 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJS9ch9R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7A1FF7B7;
	Fri, 14 Mar 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963102; cv=none; b=fhOX3pQiQC/e2heqMUsuhESQw5soorN1ktuN2wsHii18PZmRBhQ0Myw+/4BMCvVDsbvrGGkvFtBnf6uQnSi5FPP57ZpTF5+/uKjEJE21ocbs8nvA9Neh7k5ldw8pYdH6TphGEeyfiY4V8JT8MDJVSRTalJuyHTjfhk0JW4VPedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963102; c=relaxed/simple;
	bh=7Xy5Hrkgm3Yk0S+DRubh13I7X1BUmB6WJ7puEzumslM=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=GemspcLS+JBiALPfAcRTJkziSo2O6TfGssheN8F6vs6Nm4G0v5W5uj1ntZ3Gz7KkS0mSU8FWpifxjths2tLmQRF5yDAlYOJ8alDj7eBBmNmVSU1txPSkh+SGre07MyeV/QWG16FoQ6zXjX2gB4f9Oq79RF6YAsy8OdmbWeAiCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJS9ch9R; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741963101; x=1773499101;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7Xy5Hrkgm3Yk0S+DRubh13I7X1BUmB6WJ7puEzumslM=;
  b=fJS9ch9RYKC2LT1QTq6uDLvUZc/aJfqHbU1Eq1zl2WF8zWEbO/drP9cx
   6QJ/BBqHWMmZB+NJ6j9+r8jUWa+syyP6aBa9QdEjjJ8dzsQ/XqWEfu8eW
   SE4uqvuuzMrOTwHyR4CWw7R23daiqQjQmZPPwm0J82DL43g/afx035ed6
   paIsA36i+z6VHWcd0y80sXv/oYotAZOE7+VOP0/fk617/VGjFF3U5nJiW
   4V9Vers436qADSsF/2SZOqKV/UnCmuoAvSWWbAvhuI6fdOKuZ4COzrBt2
   3QjmSL2LwlezDmfzZPpE64mS4PDdIzZjbwg3pwhcyfao0YmyBAcDg1wC3
   g==;
X-CSE-ConnectionGUID: Rj6teqEuRQ2cM7+kWMx9kA==
X-CSE-MsgGUID: UHzFvp0+QD+s+9/oEo5mCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42980508"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42980508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:38:20 -0700
X-CSE-ConnectionGUID: QXKqHijXRziQIz0eVCl4Yw==
X-CSE-MsgGUID: gWbHpttISvivz6SwXBTeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="158451756"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:38:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 14 Mar 2025 16:27:43 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.14-5
Message-ID: <pdx86-pr-20250314162743-238386141@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.14. The diff is a bit
larger than I'd prefer at this point due to unwinding the amd/pmf
driver's error handling properly instead of calling a deinit function
that was a can full of worms.


Fixes and new HW support:

 - amd/pmf:

    - Fix error handling in amd_pmf_init_smart_pc()

    - Fix missing hidden options for Smart PC

 - surface: aggregator_registry: Add Support for Surface Pro 11

Regards, i.


The following changes since commit 376a8c2a144397d9cf2a67d403dd64f4a7ff9104:

  platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA (2025-03-05 13:33:42 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-5

for you to fetch changes up to 03fc0a2dc9f8c292fad8a1bcfb6d1f0dec1824be:

  MAINTAINERS: Update Ike Panhc's email address (2025-03-14 16:03:45 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.14-5

Fixes and new HW support:

 - amd/pmf:

    - Fix error handling in amd_pmf_init_smart_pc()

    - Fix missing hidden options for Smart PC

 - surface: aggregator_registry: Add Support for Surface Pro 11

The following is an automated shortlog grouped by driver:

amd/pmf:
 -  fix cleanup in amd_pmf_init_smart_pc()

amd: pmf:
 -  Fix missing hidden options for Smart PC

MAINTAINERS:
 -  Update Ike Panhc's email address

surface: aggregator_registry:
 -  Add Support for Surface Pro 11

----------------------------------------------------------------
Dan Carpenter (1):
      platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()

Ike Panhc (1):
      MAINTAINERS: Update Ike Panhc's email address

Lukas Hetzenecker (1):
      platform/surface: aggregator_registry: Add Support for Surface Pro 11

Mario Limonciello (1):
      platform/x86/amd: pmf: Fix missing hidden options for Smart PC

 .mailmap                                           |  1 +
 MAINTAINERS                                        |  2 +-
 .../platform/surface/surface_aggregator_registry.c |  5 ++-
 drivers/platform/x86/amd/pmf/spc.c                 |  2 ++
 drivers/platform/x86/amd/pmf/tee-if.c              | 36 +++++++++++++++-------
 5 files changed, 33 insertions(+), 13 deletions(-)

