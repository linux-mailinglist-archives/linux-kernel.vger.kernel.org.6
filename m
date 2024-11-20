Return-Path: <linux-kernel+bounces-416301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8259D42FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DE8283CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948D1C0DD6;
	Wed, 20 Nov 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4XRIIFL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFB1AA7B1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134252; cv=none; b=JF7AqqTvddYkr2bEdVRXuRXdJj12GUmZNVlnw51n74DzwY3Nxj7EHcgsm5U2XJDzClkLadm+X0p6fX2q6GDfOf1G1GLO+3tYZShu1lNflbFyNxcg59VWAMNmlokkL5XfqIEWyHcuLBqtsY2qGIvTmhk580XcQxlFvrK1ak+GM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134252; c=relaxed/simple;
	bh=erUikBYj4tcAtfTJFttSu2/q70/lxBFFI/CAgT/DkJY=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=NMtPmA4M03SBKbkFAbKIw8wZ3XjM1Jwdj5aQ8wpwhwH5mbgOtD0gs3vet3eXXx2/Yc5ucLBl+sbkhMRb+l5POsfW5kmRrIHXXAppYJ0GdFIxs9gcjwJucbASO44jpcvMcPYqbihdfmv7ByPshD6hBp3XVU8y4Z+LuZSn2IaQhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4XRIIFL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732134251; x=1763670251;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=erUikBYj4tcAtfTJFttSu2/q70/lxBFFI/CAgT/DkJY=;
  b=Y4XRIIFLjwckaZmuzrbdi7KQkrjabHvIRhE0QxgA8AFoj5G0i57oEppN
   3y7foM3JKv5wMCnIBXaVgmahA+n05rUCoCgSildeEbWBhcJ3FW+HWrlQr
   LpDUI90x6zJUcYLwuGYbcfWgXXHQKA5RyffRqy4XgqTQl3UTSKSWBtrzP
   9opu2s3VA07QWcoAYbwkcpc8Awh0uXNaKd9HUkgY22AYQikNO92xD69x6
   Qy7oA2MIacH4qV75S/Sz3eZc3d053YLq5aN/RXF8XK+6LPNDBwr5bJjF4
   SRFp5jWF/f+/eZG+cmitYafJNQmKKN3Gavz4FeM/R2NSWj3tL14p9whGH
   Q==;
X-CSE-ConnectionGUID: Fdg4Q67BQtusRq8w8BhDVQ==
X-CSE-MsgGUID: tChoofwAQZKEBQQHYDEvNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42855763"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42855763"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:24:11 -0800
X-CSE-ConnectionGUID: MXgpac0vQtGYo4VXQ0qhtw==
X-CSE-MsgGUID: PQGZm5ecSqiupVPoYWDElA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90407607"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 12:24:12 -0800
Subject: [RFC][PATCH 1/4] x86/cpu: Introduce new microcode matching helper
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 12:24:10 -0800
References: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
Message-Id: <20241120202410.8D208F0C@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpu_device_id.h~min-ucode-rev	2024-11-20 12:22:04.944380677 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-11-20 12:22:04.948380830 -0800
@@ -278,5 +278,6 @@ struct x86_cpu_desc {
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
+extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff -puN arch/x86/kernel/cpu/match.c~min-ucode-rev arch/x86/kernel/cpu/match.c
--- a/arch/x86/kernel/cpu/match.c~min-ucode-rev	2024-11-20 12:22:04.944380677 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-11-20 12:22:04.948380830 -0800
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

