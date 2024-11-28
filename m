Return-Path: <linux-kernel+bounces-424869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371489DBA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB65B22C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9351BD003;
	Thu, 28 Nov 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWhdI4EN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045331BBBC4;
	Thu, 28 Nov 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807583; cv=none; b=pMzh0X4fYjyNx/Fs15YgOf8NurChnzsw6dVcLEcinHXsCw0jvL4Ebv0FMGLWx2d8A7WFi+qnI3LJvrH0x9XZbRz7R8wtoVziHLiV3Wo6VvTR3TmzZjwk0a8fC52QK78G/I0OE2iN8AmxfxC3hpZVk/KeOE1nhIpBhTSAOX9Jq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807583; c=relaxed/simple;
	bh=C2WbLanRa3XQnGIOT8T4PZUgLJotIUflhXkwm+x1xNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0UVtqBeXCqx9y+PrUuATcCoFQgC9tuys1cYcxFYmHZO1Pmse9/pGMRwVrAa+b0SXMfUj+dvRyipcjjZjLejXM7WmatfEW/iwyBS5rFQeTBKDwopYFEyZyySU0OpEsNYC7nhirdbz/35LK32iI6HQz97uYqfbq60x1334S7ile4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWhdI4EN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732807582; x=1764343582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C2WbLanRa3XQnGIOT8T4PZUgLJotIUflhXkwm+x1xNI=;
  b=MWhdI4ENasKRPJZPit8+7/J03/mrIt6T3J6OxGYvKzPDT43kL9Mp46B5
   NU3yVpcQiS5K1ieswKDzmrF23EBuDnkQ0DGlaRZz3HoYIWDywP1R62dFh
   HZde/qi8JlyIDG+wy9dc3S42CnjxB51fMUf7ZJgmV4XQEb/sijUu2jCad
   H5oGBEVzgYIvgnPTsHbJ4XCArWz3ZTTIEt95xFHtmV5SPXGxH4klClz8m
   FVzk2z8llKYLCVAaW7nWZnMkLFjlbLymKe8INFehP/zWei+ZSGG0oUTg5
   wKukx18/xnHdpLECc3WKnYbOo6VXTTWcys/U9MQZ565hW8xYgZvgG2OXV
   A==;
X-CSE-ConnectionGUID: c6HPAiP/TKS1QjsiZdIcvw==
X-CSE-MsgGUID: fipFBNlQR3e1Q0Y9bi+Urw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33175820"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="33175820"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:25:54 -0800
X-CSE-ConnectionGUID: jO2doY9gSx28IFhRjOYgLA==
X-CSE-MsgGUID: 1qkhgn/oSS2bgQ30GgDfWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92730961"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 28 Nov 2024 07:25:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A4EF8598; Thu, 28 Nov 2024 17:25:50 +0200 (EET)
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
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 2/3] x86/Documentation: Align Note Blocks style
Date: Thu, 28 Nov 2024 17:23:39 +0200
Message-ID: <20241128152546.2396782-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
References: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file collects pieces from different epochs and hence has unaligned
style of the Note Blocks (in terms of reStructuredText specification).

Align the style to be the same structured:
- start the text under 't' column from '.. note::' directive
- convert a couple of plain text notes to use '.. note::' directive

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/arch/x86/boot.rst | 40 +++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 17a7da883895..069073ecc87e 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -77,7 +77,7 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
-  .. note::
+.. note::
      The protocol version number should be changed only if the setup header
      is changed. There is no need to update the version number if boot_params
      or kernel_info are changed. Additionally, it is recommended to use
@@ -229,14 +229,14 @@ Offset/Size	Proto		Name			Meaning
 ===========	========	=====================	============================================
 
 .. note::
-  (1) For backwards compatibility, if the setup_sects field contains 0, the
-      real value is 4.
+     (1) For backwards compatibility, if the setup_sects field contains 0,
+         the real value is 4.
 
-  (2) For boot protocol prior to 2.04, the upper two bytes of the syssize
-      field are unusable, which means the size of a bzImage kernel
-      cannot be determined.
+     (2) For boot protocol prior to 2.04, the upper two bytes of the syssize
+         field are unusable, which means the size of a bzImage kernel
+         cannot be determined.
 
-  (3) Ignored, but safe to set, for boot protocols 2.02-2.09.
+     (3) Ignored, but safe to set, for boot protocols 2.02-2.09.
 
 If the "HdrS" (0x53726448) magic number is not found at offset 0x202,
 the boot protocol version is "old".  Loading an old kernel, the
@@ -265,7 +265,7 @@ All general purpose boot loaders should write the fields marked
 nonstandard address should fill in the fields marked (reloc); other
 boot loaders can ignore those fields.
 
-The byte order of all fields is littleendian (this is x86, after all.)
+The byte order of all fields is little endian (this is x86, after all.)
 
 ============	===========
 Field name:	setup_sects
@@ -1206,10 +1206,11 @@ bit (LOAD_HIGH) in the loadflags field is set::
   is_bzImage = (protocol >= 0x0200) && (loadflags & 0x01);
   load_address = is_bzImage ? 0x100000 : 0x10000;
 
-Note that Image/zImage kernels can be up to 512K in size, and thus use
-the entire 0x10000-0x90000 range of memory.  This means it is pretty
-much a requirement for these kernels to load the real-mode part at
-0x90000.  bzImage kernels allow much more flexibility.
+.. note::
+     Image/zImage kernels can be up to 512K in size, and thus use the entire
+     0x10000-0x90000 range of memory.  This means it is pretty much a
+     requirement for these kernels to load the real-mode part at 0x90000.
+     bzImage kernels allow much more flexibility.
 
 Special Command Line Options
 ============================
@@ -1439,12 +1440,13 @@ The boot loader *must* fill out the following fields in bp::
 
 All other fields should be zero.
 
-NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
-      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
-      loading protocol (refer to [0] for an example of the bootloader side of
-      this), which removes the need for any knowledge on the part of the EFI
-      bootloader regarding the internal representation of boot_params or any
-      requirements/limitations regarding the placement of the command line
-      and ramdisk in memory, or the placement of the kernel image itself.
+.. note::
+     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
+     loading protocol (refer to [0] for an example of the bootloader side of
+     this), which removes the need for any knowledge on the part of the EFI
+     bootloader regarding the internal representation of boot_params or any
+     requirements/limitations regarding the placement of the command line
+     and ramdisk in memory, or the placement of the kernel image itself.
 
 [0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
-- 
2.43.0.rc1.1336.g36b5255a03ac


