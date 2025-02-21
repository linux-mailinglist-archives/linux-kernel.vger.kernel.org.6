Return-Path: <linux-kernel+bounces-525342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E787A3EEC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D423B6349
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADF1FE470;
	Fri, 21 Feb 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDkOPOVi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F491F9406
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126945; cv=none; b=cILf1GbI8u2XdRQJQgwpwGTxW+n3h9ZuAu4xqy8EOcJAAdBXbgn/siuONGeX/2RIEx/FHkg+sl/lLQLuPlLQyHSaeqgSZPReg0QSc7cl6YvV4ak8M9v4xmsytI1dlR6X2pQFUtkd8Gg16dRjjvmsiPbrgis48qP40ENH0uKDYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126945; c=relaxed/simple;
	bh=vRMTExWknSwq+DbTBMTdQ5/bthEQ5Q5f110qr5gkm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsHiwokkWk0xATr1DqxdUjn45d0Sb4nvAsIepJ8K23VPTfnIrgRaxZzihYI7HZUlTQB+sKGzybDeeCAoYBaelPSC5AVHfL+Xd+drt8eKdTyHEhbdd00Fl0YA+GCpc2BNu2LokB1pPKDCMa15zcuM6r2gkO3SX4+X3inkTqo6+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDkOPOVi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740126943; x=1771662943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vRMTExWknSwq+DbTBMTdQ5/bthEQ5Q5f110qr5gkm6M=;
  b=ZDkOPOViFkmnsy8Nm/EPjqgypgNrjEHAKWZN6XcHyF01BCtDgLp8dg7e
   OH81ukcb9wYDIEuKfmB2LvEPMaHnDtGCnkzG4OCQbeWZGK2ERnKr9pHsa
   z2Df2lRhSrNGf5gLR5oQ54JFkxfBRQZu5YguGu4FJznU4w3UmdnFZre+3
   wozIb80TlyoC8RUZRPX8UNw6Q4yyA5Dt/Lbz+TJ9ul7eKVd+maivKFPSG
   RDQ6A2/LhzNASIrK/qXv8Kx0bknMRlM/eAcFu02o32nlVIJfPucqnbOkD
   oLBgPIqje4PHATbKzkLUaT3qpiTVfu1SgNDKhXtIyYN/XbdiXjEo/hwvR
   w==;
X-CSE-ConnectionGUID: 1Q0Z2f4sQrupA/DdOnN4cQ==
X-CSE-MsgGUID: XfB9SShmQvejkrvRjFePzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40165624"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40165624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 00:35:42 -0800
X-CSE-ConnectionGUID: i9odgwhKSjKhOQ2CulcSvQ==
X-CSE-MsgGUID: OBammDWgR8+oU1xpWCLSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="119929207"
Received: from iscp-l-lixuzha.sh.intel.com ([10.239.153.157])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2025 00:35:40 -0800
From: Zhang Lixu <lixu.zhang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	stanislaw.gruszka@linux.intel.com,
	zhifeng.wang@intel.com
Subject: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Date: Fri, 21 Feb 2025 16:37:12 +0800
Message-ID: <20250221083713.25947-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wentong is no longer with Intel, I will take over as the maintainer of the
Intel LJCA driver.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9fd56f205c0..da09f84a87b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11818,7 +11818,7 @@ F:	drivers/crypto/intel/keembay/ocs-hcu.c
 F:	drivers/crypto/intel/keembay/ocs-hcu.h
 
 INTEL LA JOLLA COVE ADAPTER (LJCA) USB I/O EXPANDER DRIVERS
-M:	Wentong Wu <wentong.wu@intel.com>
+M:	Lixu Zhang <lixu.zhang@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 S:	Maintained
 F:	drivers/gpio/gpio-ljca.c
-- 
2.43.0


