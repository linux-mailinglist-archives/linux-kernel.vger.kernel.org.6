Return-Path: <linux-kernel+bounces-370877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0B9A3324
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5761C22C65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05561547DE;
	Fri, 18 Oct 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDqvaPbP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FC14E2E8;
	Fri, 18 Oct 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220665; cv=none; b=UIaRXjedx+WbXGFUfRAnldhDdUNx6YPEZcRf4dHMu3ZXg1b21UtnFAaor+xjy7v9Pc6CRjN1DroSlb6DDKMNUJZ9buH647o5Flg3QRn8YwkQ5PRsagxcQFa0rAls/Js4/DsqZ1LPyQ4tNDOeznx6rr9S2cEqzaXzLy1PSLzcAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220665; c=relaxed/simple;
	bh=9vBgnZ8FvJjg2Y5LeLs80E1jAaj8YT4dkoY4za2UOSE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XtQgeVd31D9XJ0CBg1FYgHek1G0SDj7+VQbYySaLdvvCQz350CvuXblFdLHxoKbUbGfOtUKwgmVtv7sDCTRmuGkQkGyQygRsae9vHEBzkssl6cPGiQN0jmJRoHDJPjzJe+QhEwpp4TOge+AhgrDqnOWSUTI2H/2um1otegGO1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDqvaPbP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729220663; x=1760756663;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9vBgnZ8FvJjg2Y5LeLs80E1jAaj8YT4dkoY4za2UOSE=;
  b=dDqvaPbPln0P2vrpS4020Qs/yjLxgTzRmKddhuWirC9vAb3cYT1NMjLm
   IZngUG2t7c0WIZg9ACeadcuFYaF11djHWjKPX/PKo6vSNAY0sUb+Erfsj
   YajGHVn09g0knquEIy0iO4R5p2mQo1A0Ayb7Fljtaj9frjhp3uWQZv6bX
   FFU2WzU6gBTBrlxJ1aT1djyz9vImAUGp3wldXLZa/jD3IREKlGEznM3+A
   8cfHJbIJyEXlrnGNkNPFJ9aK8LgmDnIPv5l0O66KC9XRYJ7qdkkh/dNBu
   UGL+rkYnSNbYq5WvK3y9UghuC6lAweN0f379M/y+ZdQ5KYwi9o08/BsHF
   g==;
X-CSE-ConnectionGUID: +AG7alBIT+aIL8rY1EsUBg==
X-CSE-MsgGUID: 3TSHnZ7/SMaov8p0WWQunQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39371205"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="39371205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:04:01 -0700
X-CSE-ConnectionGUID: hU1uSwQeTLeDHXVUPpt8/w==
X-CSE-MsgGUID: T3Y6JAe7Q4uJtfw3lpJu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83812910"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.109.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:04:01 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/pmc: Fix ioremap of bad address
Date: Thu, 17 Oct 2024 20:03:55 -0700
Message-ID: <20241018030357.3580487-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pmc_core_ssram_get_pmc(), the physical addresses for hidden SSRAM
devices are retrieved from the MMIO region of the primary SSRAM device. If
additional devices are not present, the address returned is zero.
Currently, the code does not check for this condition, resulting in ioremap
incorrectly attempting to map address 0. Add a check for a zero address and
return 0 if no additional devices are found, as it is not an error for the
device to be absent.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Fixes: a01486dc4bb1 ("platform/x86/intel/pmc: Cleanup SSRAM discovery")
---
 drivers/platform/x86/intel/pmc/core_ssram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index c259c96b7dfd..70e03bd53740 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -267,8 +267,12 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 		/*
 		 * The secondary PMC BARS (which are behind hidden PCI devices)
 		 * are read from fixed offsets in MMIO of the primary PMC BAR.
+		 * If a device is not present, the value will be 0.
 		 */
 		ssram_base = get_base(tmp_ssram, offset);
+		if (!ssram_base)
+			return 0;
+
 		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
 		if (!ssram)
 			return -ENOMEM;

base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.43.0


