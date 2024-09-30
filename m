Return-Path: <linux-kernel+bounces-343642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAC989DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7811C21871
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1771865EA;
	Mon, 30 Sep 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcrsmpcJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F712AEEC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687183; cv=none; b=R25wiZurUxqh1XN9Mhz19MGcxF2mpVV5UMD/oVesoRSYkC6QuPcLrEi+rxMZxrFIuBMLzEN7Lb/M5fuwAa4mfmYKy6CzdQWqKMjyXSjsXEYtTRqyNk0qaiLbJJ2CM5n9e2ZJs1GHBPwotDyoPJBVK+C8NdkdpJYh0fzKfG7SPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687183; c=relaxed/simple;
	bh=iSVTBcAurSOcicu2Du2N+QUxWmgf68TK5DY+U+gfLtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/kmfzaAlqovtllt+X2qr9YqFte8DhQ+PmLGF3bo8QNqWo/2gaN/CNnwMTdGRwZZYZS1JTT4KfPLmdL2YNe1+zEGc7vc4WGNE81SSdHfmHPCLRWMVviK5jJ9CkIKRQqcqqIUrDJbtWIMJTXU/dYrTR7alx08orgooFivm8y1Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcrsmpcJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727687181; x=1759223181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSVTBcAurSOcicu2Du2N+QUxWmgf68TK5DY+U+gfLtI=;
  b=IcrsmpcJHsftwodTzoOUqGWJr1xcAhRiZdt7dL0gKHpub5XHx1Mkco7y
   oduPnrx+RIyzPWiHtEtA8DISjAwqOynKUG0w6L4w0juyAzKPrLAEb8Yop
   HOgGpj3CJaNIGTjTIaJqgfRnhq7DvF75iBmLEHReT/zumnh3Cqg6Idw/B
   V0rjrTaAZIegc3uKV6QqljELSGdKi0PiyFLB+0ssVQPeVCGPVRcaPM5/C
   YdRjUcZuXYQkpq1Ru3TidcdvJ9l7mlbVAU6+R4I2KbET48VxXFPIn/Xfk
   /RK/389NPEKK8S15bZXiBKsU56h6L4AIHnOA4KyvjELry4fVi3R+NHIiJ
   g==;
X-CSE-ConnectionGUID: l0wv116iTGe/uF3p0Qo3eQ==
X-CSE-MsgGUID: 8T4kYpOiTH+RIpqsMOxkNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26718879"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26718879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 02:06:21 -0700
X-CSE-ConnectionGUID: nJ+VBZfcTgWfIVjtNszz/g==
X-CSE-MsgGUID: 53E5KZ8FTyahyqydlV7eCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77743711"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 02:06:19 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: MAINTAINERS: change mei driver maintainer
Date: Mon, 30 Sep 2024 12:06:04 +0300
Message-ID: <20240930090604.1788402-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change maintainer of mei driver to Alexander Usyskin

Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5834a1cd10d7b83657ed5fef..c281dd82f9b37d6745cbcd3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11602,7 +11602,7 @@ F:	drivers/crypto/intel/keembay/ocs-hcu.c
 F:	drivers/crypto/intel/keembay/ocs-hcu.h
 
 INTEL MANAGEMENT ENGINE (mei)
-M:	Tomas Winkler <tomas.winkler@intel.com>
+M:	Alexander Usyskin <alexander.usyskin@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/mei/*
-- 
2.46.1


