Return-Path: <linux-kernel+bounces-420586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E809D7CED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D160B2820D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43D18BBBB;
	Mon, 25 Nov 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvvfBgW6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60118B47C;
	Mon, 25 Nov 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523505; cv=none; b=fiujcGHiCwcBGuY/9a5YBlaq+YySez03/1LtvnjAqaf0Cd1iq5FlpUdrPwhzf4sLkYgdkxZ4Gi9cQG9T92c9BVjRO+qV+sZ0vHAuzjGn8t2c4KSZM3Zs9rkQDCC3nSA7GJrktmx7aO0E6Big0JF4uo1yw0n3gOrW3hpUc4DSHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523505; c=relaxed/simple;
	bh=ft3wXjI0+l/wQog3RRWcR9KQksP82bwQ7eVg0sMG4oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUtlv1D9M8llS8VkDD/0pMJdfkul/JCRKiPBmGiBFtiK2ZwTDMbo9dc3LBwmWwILa5V5w760Hn1fF1fbJfLRMF9tpy5mhy/5iiZBT38/jCZsiR+406IwHQ3EMUmBWs5KyyIxkT4J0Y3Ssm2sBDUDA7hyKeWp56VMSfCHH1vHamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvvfBgW6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732523503; x=1764059503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ft3wXjI0+l/wQog3RRWcR9KQksP82bwQ7eVg0sMG4oU=;
  b=FvvfBgW6mqEnFllBnWdPMkqBiOfyD66CnPlf7FO1kS9F70fUf8nBHaUv
   T2jolBWIDVyC2s1EEawAK4bHgWRdF90CtPKAomVLbLYLW+CfI3nq3rq6d
   eI5hiw7IH+nuymYYuFpW7wwEPrf/gosCtsMOcnjvmfvIOeEzC0QXhCKR5
   dgqlADmNOAGv1935nF7nRIq/wz/EW0WOEzTb2RQUf672tN/4Qn6Shbf9w
   fqmcs8cQz3hJXCrmxxaRvQyMR+xBHqcAb/ZMA4+lIBTVfzv1BPXi+2rH/
   a1P8CcdEcZAzdS0CbF2k/If4h91AFLXL/SqGLnYV83C/cdqg6FVRZxD3j
   g==;
X-CSE-ConnectionGUID: IqgGa7jORl2Ja1PLrJ5p3Q==
X-CSE-MsgGUID: O1Jx4C7WSoSlc7PPnNWbBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36533932"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36533932"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 00:31:42 -0800
X-CSE-ConnectionGUID: fNEAcZkUSvKCB2DVgR9nnw==
X-CSE-MsgGUID: 1b+LAubpRfau9lk6vbi80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91085932"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 25 Nov 2024 00:31:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 549462D3; Mon, 25 Nov 2024 10:31:38 +0200 (EET)
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
Subject: [PATCH v1 1/1] x86/Documentation: Update algo in init_size description of boot protocol
Date: Mon, 25 Nov 2024 10:31:36 +0200
Message-ID: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com>
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
the document and fix indentation, so the syntax highliting will work
properly in some editors (vim).

Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
Fixes: d297366ba692 ("x86: document new bzImage fields")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/arch/x86/boot.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 4fd492cb4970..01f08d94e8df 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -896,10 +896,19 @@ Offset/size:	0x260/4
 
   The kernel runtime start address is determined by the following algorithm::
 
-	if (relocatable_kernel)
-	runtime_start = align_up(load_address, kernel_alignment)
-	else
-	runtime_start = pref_address
+    if ( relocatable_kernel ) {
+      if ( load_address < pref_address )
+        load_address = pref_address;
+      runtime_start = align_up(load_address, kernel_alignment);
+    } else {
+      runtime_start = pref_address;
+    }
+
+Hence the necessary memory window location and size can be estimated by
+a boot loader as::
+
+    memory_window_start = runtime_start;
+    memory_window_size = init_size;
 
 ============	===============
 Field name:	handover_offset
-- 
2.43.0.rc1.1336.g36b5255a03ac


