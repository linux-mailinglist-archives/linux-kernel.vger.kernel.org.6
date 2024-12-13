Return-Path: <linux-kernel+bounces-445376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F59F153E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C46E188C15B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E61EB9EF;
	Fri, 13 Dec 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnQuYKJS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86C188012
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115891; cv=none; b=R9MN/9cSVb4kPBCEdU5Dt8qVfPOYKcTtu7lNLaG1k8EiXoIjQ1fQhxHyCBzSMtlerUwWSqDQ72SadQMD7JdJx1gokMNbMLXapt3GXSbWLQVVZX1U6cfzIzUutWCLbVlE3/RuNldOv+xWabhg5uq/IldYYLxvRihSMlRqrM428z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115891; c=relaxed/simple;
	bh=DKEoee4rPDOZEFTKYXrAxRG3POpofHTvV2awbdMC30s=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=SxLZz4PEzUdbotsf0uqPPkhby3Ov/g91qYxhwHkEZ2fyAti3etYI/xriRywhYejCccP0C5ccSdSEWPaVAG53c2CocXE+n4+yKYtfAmDZ0DVY9kVYUvGcbvWfFCY+e5hAcqXVCOM5PNxCCizsUR18gA6RkTIeWwm/EUhThlAGtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnQuYKJS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115890; x=1765651890;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=DKEoee4rPDOZEFTKYXrAxRG3POpofHTvV2awbdMC30s=;
  b=gnQuYKJS0SBdDln58ncYgW+Evg5jzGpvSAdZBeftewdWClGkD+3KQqEm
   hWWoKq5YUBzZCTmzbiJ3tlAymaTSvp2RUTXStmhAZfBmEY8pvYAl9gWWX
   /DrfS0aO0OuWSytgIaDBNimsKADtLgDSVoPhbgVH9Jna+iWaBIa97z3bY
   iuidzGagEwUlRhXd8OHpJ3r1MiuUfvXEtT6ILOQ3ySYKmkPH/yH5yk4f/
   CR3oeFH6LZlaM+u6nV/a1hMfUyCOdgFuycHJkxX1PGHY/Jv7/3IhcFHCL
   K+IH7S806QrtUKEp23Brg0VvyKLZUTK6io1t+sXWz7RC0IQJuB6BUyJug
   g==;
X-CSE-ConnectionGUID: A28UbbcDT0mI5Dy09yBFLw==
X-CSE-MsgGUID: 36gTKvzpRpmQumr1DGGKtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487422"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:29 -0800
X-CSE-ConnectionGUID: A6luHm+fQSaWwA7urr7Cig==
X-CSE-MsgGUID: L0gzuk/LSU2gTNOSwVhoDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478748"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:29 -0800
Subject: [v2][PATCH 1/5] x86/cpu: Introduce new microcode matching helper
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:28 -0800
References: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Message-Id: <20241213185128.8F24EEFC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'x86_cpu_id' and 'x86_cpu_desc' structures are very similar and
need to be consolidated.  There is a microcode version matching
function for 'x86_cpu_desc' but not 'x86_cpu_id'.

Create one for 'x86_cpu_id'.

This essentially just leverages the x86_cpu_id->driver_data field
to replace the less generic x86_cpu_desc->x86_microcode_rev field.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpu_device_id.h |    1 +
 b/arch/x86/kernel/cpu/match.c          |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff -puN arch/x86/include/asm/cpu_device_id.h~min-ucode-rev arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~min-ucode-rev	2024-12-13 10:47:30.149045000 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-13 10:47:30.153045160 -0800
@@ -278,5 +278,6 @@ struct x86_cpu_desc {
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
+extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff -puN arch/x86/kernel/cpu/match.c~min-ucode-rev arch/x86/kernel/cpu/match.c
--- a/arch/x86/kernel/cpu/match.c~min-ucode-rev	2024-12-13 10:47:30.153045160 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-12-13 10:47:30.153045160 -0800
@@ -86,3 +86,14 @@ bool x86_cpu_has_min_microcode_rev(const
 	return true;
 }
 EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
+
+bool x86_match_min_microcode_rev(const struct x86_cpu_id *table)
+{
+	const struct x86_cpu_id *res = x86_match_cpu(table);
+
+	if (!res || res->driver_data > boot_cpu_data.microcode)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(x86_match_min_microcode_rev);
_

