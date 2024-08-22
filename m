Return-Path: <linux-kernel+bounces-297303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821495B5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016D31F23AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE221C9EC5;
	Thu, 22 Aug 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0itSgc3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CA13C90A;
	Thu, 22 Aug 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332049; cv=none; b=TsYVwNL2Hv/TMwM0IKjaGW+cNNr+pTGm5u2bKII/UKfttQuNUZmvwTJiTiFU861VTbT97axfbw8vfHMj7EmiE4zUIBhFAVh2Tdk8kgqA+OYCe9x7x3LppF2cjuIvajeTucWlmcDHnexV3QJ4BJofImvzfPn4UDgR9l9EP6f/WxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332049; c=relaxed/simple;
	bh=FTZod2zV53ZpMX5MVD7MMUJ0Id3Kb379EvWtTLYeLTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHRf4gdRWSyKmqAKrTz0agUq89kgUUAogzaOuPx+afoHSJLDL77XgZO1ytGNzIxQJnndXxmRcRhnprP0Bsjk1BUTSGM3vYcAcOpc3PdiMVuCBP2mlsX8QG2M8VRHFulLO7v+j6EnYl0D1wexlu43W+EqSzOZbnhYoMr6HHxA02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0itSgc3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332047; x=1755868047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FTZod2zV53ZpMX5MVD7MMUJ0Id3Kb379EvWtTLYeLTU=;
  b=M0itSgc3b3QDurpLy+Uq+V2+qwa18gv0Rw7Ht7P7qmwyVpBXPLqigNz+
   y2254Q32eRV7Vb0b1MW8sk5OKbASstOGXqYdMuDBGehJP9PL0bbZj0ccG
   4yZtjuThufvxLlLX2XKrgr212iVwzenB0llLCB5mp6aGXEoFPxYoUgLAy
   y/9OqZ7eschw+tmnGQyg3+no9cWiEqXmEaxB+F9a8DCIHvT989HmDVsoJ
   6deQvJtx+WTyNIrN7h7urLrK3IHKMfBiwxncaQ19zb7iJ/JucoVir/IK+
   vtgG7rLf337q6h4TT3gPZB10w3Z7MFJBMRGxWtYbDbDObno3O56lKELDH
   g==;
X-CSE-ConnectionGUID: UYL+cWs3QLe3BrkL16ewcg==
X-CSE-MsgGUID: SOr8KB1MSkGG6JTnKGscdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26538866"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26538866"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:27 -0700
X-CSE-ConnectionGUID: A7sh7M3FSAaz+v+odCwidw==
X-CSE-MsgGUID: /Fap3h5ERUKf0MqqiYXI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61146772"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2024 06:07:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 733D22F2; Thu, 22 Aug 2024 16:07:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 0/4] platform/x86: int3472: A few cleanups
Date: Thu, 22 Aug 2024 16:05:37 +0300
Message-ID: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few cleanups to the driver. It includes an amendment to
dev_err_probe() to ignore 0 error code. The patches 1 and 2 are
dependent, while patches 2 and 3 may be applied in any order.

Assumed to go via PDx86 tree if no objections to the code.

v2:
- amended code example in the documentation (Ilpo, Greg)
- added note about -ENOMEM and 0 to the kernel-doc
- fixed kernel-doc warning (no "Return" section)
- added tags (Ilpo)

Andy Shevchenko (4):
  driver core: Ignore 0 in dev_err_probe()
  platform/x86: int3472: Simplify dev_err_probe() usage
  platform/x86: int3472: Use GPIO_LOOKUP() macro
  platform/x86: int3472: Use str_high_low()

 drivers/base/core.c                           | 13 +++++++++++--
 drivers/platform/x86/intel/int3472/discrete.c | 14 ++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


