Return-Path: <linux-kernel+bounces-173084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC98BFB48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8F0281F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43E81748;
	Wed,  8 May 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbs/8Hvy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C012E7C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165334; cv=none; b=H+jPajDsOtzGPRze3184WbUngwuSmpIG67up4znILzqcmgF7nM8UAcdhUeMo4bT5RDdtq1KREcZMt2iekLLq9jw95GRZ4+BDnV+6G9PA18AaYvbUkTzvHXEfgdXe6oW4VTv1uUuDpbQdedDVj6h4Y2Lk2pIxPyyRDIDIBz59vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165334; c=relaxed/simple;
	bh=0C5AgGV462+lOg51Wn/vGwtPYKFzY44U3qnezUNglsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJnCOi8yp1KdEjwflE3LjTb75ryYtSoY/IEYSgBM140rzl/pbWBDrlGEnJdWFm6+4C0WX6BakFepB36SZH5sQQbOMDurr1Nagef/GnBbAUmimD4mcBH6iPnCurTJuZTXT9sRBEnCgVjiGP5joaHYmpIzxPy0Jlv3+GxZlzTmKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbs/8Hvy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165334; x=1746701334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0C5AgGV462+lOg51Wn/vGwtPYKFzY44U3qnezUNglsI=;
  b=gbs/8HvyBmzJdYSyiCsETi1+kZQTOwNMfNDf7z2lSiADhdc1Zf4wUJmb
   +EdY7rcqIPEIFpDOF2/vtf2eFa+uWi6Q94xmucHubeVgnEEDRyqVTEUlN
   0IrFTuqQhufHbjXKWcL1l+XjNeYrzHitCesIkJMHicx2x+6yAvEnlBYCe
   g5NqbVH5+PemFdI02OtZwhMO+QQ9vYU1FifZKZFhTKR+UBwy+vlzpetmi
   OCk50w3O7L0EnLdEpORo01ZL4VkF88da4DNwRVO6jG2etDDjul1ii/tsH
   1hqpTQSV+MTWCal3t/PgDSKvg9YApy2P3zRVpT/f2jJMDH1JQnupWmObN
   g==;
X-CSE-ConnectionGUID: CRLtsAbZQv2ZYXBdqfCj/w==
X-CSE-MsgGUID: iWeIZse0QkizaycgLwgQsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14834627"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14834627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:48:53 -0700
X-CSE-ConnectionGUID: 2KeLlfaMRg24192bx6+kvQ==
X-CSE-MsgGUID: F81GQKA7RwukcTaD0egj9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33319270"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2024 03:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 16571109; Wed, 08 May 2024 13:48:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 0/2] mfd: lm3533: Get rid of legacy GPIO APIs
Date: Wed,  8 May 2024 13:46:47 +0300
Message-ID: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is quite outdated from Linux kernel internal APIs perspective.
Update the GPIO part in this miniseries.

The first patch to make sure noone is going to use legacy platform data.
An alternative approach is to remove completely these family of drivers.

Andy Shevchenko (2):
  mfd: lm3533: Hide legacy platform data in the driver
  mfd: lm3533: Move to new GPIO descriptor-based APIs

 drivers/mfd/lm3533-core.c  | 45 +++++++++++++++++++-------------------
 include/linux/mfd/lm3533.h | 18 ++-------------
 2 files changed, 25 insertions(+), 38 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


