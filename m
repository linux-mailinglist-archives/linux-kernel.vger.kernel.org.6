Return-Path: <linux-kernel+bounces-299490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D795D575
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EA81C209A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF1C1922C5;
	Fri, 23 Aug 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP5k4A2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A57139D13;
	Fri, 23 Aug 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438772; cv=none; b=XUSgAM0xqHMpEDuqlcX8+zsgWX+SgqGW897tkCNkk7mxBgh2QntreEdW+AH9jx+ZfaeSG3uq4ihzMwkJSKlsJ3QSinH9LxkslmP49b4bidmPB5dN8QtB/IjYatSVTc83K93vy7g/yhicZ0VLc5xqvWSGeG920UQ1ejtah7rFTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438772; c=relaxed/simple;
	bh=KkQEazdwshMVMtx2+tBkBwXewuq+34ODfkBojIyqB4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwVbpPiG2VDT9uTvK+sKXKxQlGEV5b+r9VrpTRyYcwrUcwzU4oMY/EiT8ZJgPmBp8N9AhtTyMl/7qda84O/euINue4AEiyQU7BgcvLWMUgEmoHhhB8iijkchfVOZslSU5a4OtSVElIwTVBHtP4gCXLstPGJ2GbGnfO3PzFq1T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP5k4A2f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724438771; x=1755974771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KkQEazdwshMVMtx2+tBkBwXewuq+34ODfkBojIyqB4I=;
  b=bP5k4A2fvsM/e8bSx06NPVrn6pcnz8JC1b2RLvZkUEHnwuRlZJCfv704
   1nHfD/Tn76iofdO8ht98cEfTuR/becKIs73Vl1P41qBEUX591wu8m3vk8
   GmvFimpyjPeMbmhIWbtnaDdeiMOFJKTSzuip1iGCzTKzEQumbNyKVH0vb
   q8UwZSTYmnttux0xLqFgfPZ9tMRwBRHZ9toGnrv08GH7WhXWG37SNG5nP
   iaC62Ku87r6f9ooFuJnlTSP37Wmpofui/gagpu4w6VoM1ies+dQaxYK7Q
   CEFTDPpcW95xXuV1oXowJygaLioVPRa6bBO/cDyPkplilTWNfuei62ltd
   A==;
X-CSE-ConnectionGUID: LZgDGc+qT7KoLyVCjZReZQ==
X-CSE-MsgGUID: WpOKB1FmT/Wf6h3REvIeUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25817557"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="25817557"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:46:09 -0700
X-CSE-ConnectionGUID: 5V8CQ4cISV2FnLnBbgfSoQ==
X-CSE-MsgGUID: dcuuvPWtR7uXBEn0GIwk/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92671763"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:46:08 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: [PATCH v1] platform/x86/intel/ifs: Fix SBAF title underline length
Date: Fri, 23 Aug 2024 18:43:37 +0000
Message-Id: <20240823184337.2923179-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit # 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image
loading support"), the documentation for "Structural Based Functional
Test at Field (SBAF)" had an incomplete underline. This resulted in the
following build warning:

Documentation/arch/x86/ifs:2: drivers/platform/x86/intel/ifs/ifs.h:131: WARNING: Title underline too short.

Fix it by extending the dotted lines to match the length of the title.

Fixes: 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image loading support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20240820134354.2aec355d@canb.auug.org.au/T/#u
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index b261be46bce8..5c3c0dfa1bf8 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -129,7 +129,7 @@
  *
  *
  * Structural Based Functional Test at Field (SBAF):
- * ------------------------------------------------
+ * -------------------------------------------------
  *
  * SBAF is a new type of testing that provides comprehensive core test
  * coverage complementing Scan at Field (SAF) testing. SBAF mimics the
-- 
2.25.1


