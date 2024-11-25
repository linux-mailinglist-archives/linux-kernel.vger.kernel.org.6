Return-Path: <linux-kernel+bounces-420863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FD9D83C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B061652EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5866192D9D;
	Mon, 25 Nov 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4OWiHqD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEF192B88;
	Mon, 25 Nov 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531814; cv=none; b=ozTX3THfm7dEjY0mwmDNLIrx41gQ0aIa/VpCYcVJrgYYrkD4hZNI87bVt2TSObdTEfpVFxP50VbGHdY8tGIURCU7DEnG0dc/iq9JJjJM2fuScfA4Ik9Yf5VlBw0zsYDAnJbN/IVqrqQOrX4fFR/2TZvqwq9FjWAD697IYK6Zt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531814; c=relaxed/simple;
	bh=BFCNR26la+4+nNN50ZcMAbct8OAG+yKYyYr2jncxVzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgO3eHDxRLKoK5Ao6Ig+s4NuwR7aqnMQbkGQRlataFSPUg1Tl+esFEjB5uob+EIsXkWDn+J1YQjVHoTLXceXl+MKfUH/9tuLWQ3VGIFYtIs1UdnozU0X0qrCGIwhZWeQl+KuyN1igdxv3D92i5UBxYPZiz2I332ly55YGH1IoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4OWiHqD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732531812; x=1764067812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BFCNR26la+4+nNN50ZcMAbct8OAG+yKYyYr2jncxVzs=;
  b=M4OWiHqDNl47RAxTaf38ULZTxa2U/E68XISV7q/LqSY8SBM0aqP5A6zn
   j77uuAWGrpj0vlILr/xjHr6KRryzYcU/f6GpcWmLIbZNLlvkoPY5kXrFN
   iMcrI9f1+QhVyySN7zKOetm/0m81a0FFaHVtM9JF4O/+K/DDllMhisb/S
   LK0gn7T6xod7GWUnYpU3eKSHiJstd7ntoSN3YJteD5ZsNcZBtAQUClv7s
   xyPWvH+OoUPlMib2OnFCbG2Lmb3bU8vcpeLaTCn6o/W8MM5F3bKRzmCqw
   oVvhEa0VeC/wFYz1iuKJ7lZMbhCAZZFERQSUgrFuglC1vPb3m7A9uEHqc
   g==;
X-CSE-ConnectionGUID: EN+YeVySRKCXFu2EwvGxXg==
X-CSE-MsgGUID: 2GfzOpp4Q2CXRnpWOTCijA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32881290"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32881290"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:50:10 -0800
X-CSE-ConnectionGUID: jP4FtEgETgG3/X7tOLhUHw==
X-CSE-MsgGUID: r4fkVxbuQiey9E/+Il4hYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91184809"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 25 Nov 2024 02:50:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 826D3217; Mon, 25 Nov 2024 12:50:06 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Cloud Hsu <cloudhsu@google.com>,
	Chris Koch <chrisko@google.com>
Subject: [PATCH v2 1/1] x86/Documentation: Update algo in init_size description of boot protocol
Date: Mon, 25 Nov 2024 12:49:14 +0200
Message-ID: <20241125105005.1616154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The init_size description of boot protocol has an example of the runtime
start address for the compressed bzImage. For non-relocatable kernel
it relies on the pref_address value (if not 0), but for relocatable case
only pays respect to the load_addres and kernel_alignment, and it is
inaccurate for the latter. Boot loader must consider the pref_address
as the Linux kernel relocates to it before being decompressed as nicely
described in the commit 43b1d3e68ee7 message.

Due to this inaccuracy some of the bootloaders (*) made a mistake in
the calculations and if kernel image is big enough, this may lead to
unbootable configurations.

*)
  In particular, kexec-tools missed that and resently got a couple of
  changes which will be part of v2.0.30 release. For the record,
  the 43b1d3e68ee7 fixed only kernel kexec implementation and also missed
  to update the init_size description.

While at it, make an example C-like looking as it's done elsewhere in
the document and fix indentation as presribed by the reStructuredText
specifications, so the syntax highliting will work properly.

Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
Fixes: d297366ba692 ("x86: document new bzImage fields")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed the style to follow both rST and kernel conventions (Ingo, Randy)

 Documentation/arch/x86/boot.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 4fd492cb4970..ad2d8ddad27f 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -896,10 +896,19 @@ Offset/size:	0x260/4
 
   The kernel runtime start address is determined by the following algorithm::
 
-	if (relocatable_kernel)
-	runtime_start = align_up(load_address, kernel_alignment)
-	else
-	runtime_start = pref_address
+   	if (relocatable_kernel) {
+   		if (load_address < pref_address)
+   			load_address = pref_address;
+   		runtime_start = align_up(load_address, kernel_alignment);
+   	} else {
+   		runtime_start = pref_address;
+   	}
+
+Hence the necessary memory window location and size can be estimated by
+a boot loader as::
+
+   	memory_window_start = runtime_start;
+   	memory_window_size = init_size;
 
 ============	===============
 Field name:	handover_offset
-- 
2.43.0.rc1.1336.g36b5255a03ac


