Return-Path: <linux-kernel+bounces-435542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046949E7920
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3151885E79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B2206280;
	Fri,  6 Dec 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2Dy4Ye/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7E204583
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513914; cv=none; b=oniAAUskM0Yy+QbMArlVsTZhi26DoTDnZz/ZmRREYrgSp67g3zAYF81tX3OT8BacfnFlIesWP1vbd6PUi4sgwjIP/BP4GOwZXSEIVzzZ645VjnNGJBKZQ/GHE18C3rp8kAn93u0ppXAlR+VdrqR3Z5OfQXQS8JdnjMkqVhWNHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513914; c=relaxed/simple;
	bh=b/j6b5Gous9RrT4FOdntQAYYy7LmiWUgmtd5pcxZO0Q=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=B8QKFCcqdgqBY4a/GXq7/DjVFM4sQW6xVfnKHEg3KcHKsxB6yqkv9zQtIsW1hGjGtstJ6FORDfevcTsni0p05ZYxcquxz5P2OYcVpNwEi/RsJo0DICvQGrNrXHk5I+OAA5aVP5QmvVaeUcMSeg75iUaOQ3A7G3oAgEfr/mbkY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2Dy4Ye/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513912; x=1765049912;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=b/j6b5Gous9RrT4FOdntQAYYy7LmiWUgmtd5pcxZO0Q=;
  b=O2Dy4Ye/BEOP2lMEJgz9VqM/6NHGGtn1u42ITKIMKcWvJIJ8YrQgxvJx
   hAH7LdZ8cGnh0L9q/TnbPC0NZ/W3mYCy6xYKPKabRBURFlX+mZ9of0OeS
   JPYWiO0X0tgsaV+M6lcUVoJYSmMcpCEsk9oorp2CJzfHTwNhYos07GmbT
   gcDN2mpskB19QtLPopfOKazyJDMDDaO/ThZmoR7ew6G9LlHsBLqGy6dNw
   hmFnHdsTygrzXl/x5q93/qKCQEWF9cI1a/rwdYC2I1rcfrROYAOevR1KR
   dzFcsPODOwb3tL/TIjyiqVwYPEckZ397QnuCk16NBkltpVqZQJJ0E6/8s
   g==;
X-CSE-ConnectionGUID: 5fbsiA9xT0CvtTgBycftkw==
X-CSE-MsgGUID: Zyt2+EETRzKp5oXwiABLPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027878"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027878"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:32 -0800
X-CSE-ConnectionGUID: JA0c3wYgQpikQx8JgjdSDw==
X-CSE-MsgGUID: iJclW5wwQ8O1zANGmwEFbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94979001"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:31 -0800
Subject: [PATCH 1/5] x86/cpu: Introduce new microcode matching helper
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:31 -0800
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Message-Id: <20241206193831.3BBA3834@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpu_device_id.h~min-ucode-rev	2024-12-06 11:33:15.663128241 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-06 11:33:15.667128399 -0800
@@ -278,5 +278,6 @@ struct x86_cpu_desc {
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
+extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff -puN arch/x86/kernel/cpu/match.c~min-ucode-rev arch/x86/kernel/cpu/match.c
--- a/arch/x86/kernel/cpu/match.c~min-ucode-rev	2024-12-06 11:33:15.663128241 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-12-06 11:33:15.667128399 -0800
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

