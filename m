Return-Path: <linux-kernel+bounces-178044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D538C47D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC5A1F22920
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EB7D408;
	Mon, 13 May 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlxULuNR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8687B3E5
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629648; cv=none; b=rHanTZyHCixtBNdVFHSRD/+MSetdVTFEGjHbBT6sc0hgU5tPcJCejb2GVK3le4JX8gsl4UhnrpqhG7Ms/qH5nIOIfF3vIUhm5l0IY3teJl1B3b2wFTj2dBp1WkPOmlK+tEUwPsjCXxQRyzy1i1ldQ33S1+OfQ+fvKPlhfr/ZhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629648; c=relaxed/simple;
	bh=Dvx8jaCDpjzDrMlZNJiqVb8gud8gHINPXhVAMLsiDdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MFkQk9FTA4AaSm1S2//ZEtHsqwhnXkl/ABAfXEqsKySs4XpoYFSQLHE9mCVezaD11/lK/v6JUcc5DBdjdmKRh8PUNZLlm0ivXqTWNIO19GeBoIHHVBOKvO59xjZyvzEIiBf/O/T0PJkeaWt8+2vzmL91/fOZMJVdEGpAXeumS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlxULuNR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715629646; x=1747165646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dvx8jaCDpjzDrMlZNJiqVb8gud8gHINPXhVAMLsiDdE=;
  b=XlxULuNR+bTTwqPb90K6hZaH1bmtAzNjv2rGU9S6Xjgt3OYRlfSIX7kX
   yuAqgjfsoX+mJx7iaX1x8Uu7mDmTisadgMIWEFtQLjaturQiFG0dOlYEL
   FCwopWAVQCU3Cx5+pIGSEklgGzYnhqRQQEluaV8+FDzW1q5VtipP+vz4+
   bMXWH8IZ5KlyDhmp8zteehOjCStXqbjmrC37P5CsC+k8i7gxySuDaOBfh
   7m1r3LCuBTfNR2JdVWROfJKzwgpeCc97Ccm4gIsrMsNtvQ+UseqMNu7oR
   oe9lbU+d24LHsDoZ6Er3co+TFCzqmKSBUEr7LN1RV/fnLAdzeFBRxyKeL
   Q==;
X-CSE-ConnectionGUID: 2WXiPOltSP+ntqpB3lrF2g==
X-CSE-MsgGUID: TEwMIwfWSAGzTEXjudalGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="34097442"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34097442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 12:47:26 -0700
X-CSE-ConnectionGUID: G5HzDGFtSyWNMC1uluoecQ==
X-CSE-MsgGUID: ojIQyldBT2ik3SdrWab4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30502882"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2024 12:47:26 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/apic for 6.10
Date: Mon, 13 May 2024 12:47:20 -0700
Message-Id: <20240513194720.456299-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull a single x86/apic change for 6.10. Coccinelle complained
about some 64-bit divisions, but the divisor was really just a 32-bit
value being stored as 'unsigned long'. Fixing the types fixes the
warning.

--

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.10

for you to fetch changes up to 0049f04c7dfe977a0f8f6935071db3416e641837:

  x86/apic: Improve data types to fix Coccinelle warnings (2024-04-03 08:32:04 -0700)

----------------------------------------------------------------
Improve data types to fix Coccinelle division warnings

----------------------------------------------------------------
Thorsten Blum (1):
      x86/apic: Improve data types to fix Coccinelle warnings

 arch/x86/kernel/apic/apic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

