Return-Path: <linux-kernel+bounces-416274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBB9D42BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E19B266C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30D1C68AA;
	Wed, 20 Nov 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y01eewSl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2F1C3051
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132412; cv=none; b=Q+zt/IiD7NlRsS7D7peA+vqfEUiG2ohgShiuqCSxYTOV1cZtcf3GwTdcPWCFmxlaftAEEt9gX93gxrwrO+gZ4LLV+/c1vcel8vKDIMB9a2lVOU8GYBKer51puLdk0Ky+1KXBkzWpkP5qiAWyOHTSEwoQ1nTtZRWeKkpcB+RugCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132412; c=relaxed/simple;
	bh=AWgnbFrdlmYYOc6Z2KKIL5YXauOpCMYbPiU2FxyxO/s=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=qJShM4DtX6zBEg6armbXsjGatCbQWH+hr2pRAIAOsqCRWuaxwk34PKm1RJrV9fruPervAtrD2QJBIEV26zh+/xZ+hN15K/LPwjIx8cNacJ8IkmX3M/y4yGlSOi+dKqtfqLxYaiSdNx/yvhdg4uXRFGRIWifkxGoVy2doY+EtJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y01eewSl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132411; x=1763668411;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=AWgnbFrdlmYYOc6Z2KKIL5YXauOpCMYbPiU2FxyxO/s=;
  b=Y01eewSlw1K7v37QDEYcZmATTf4za/O2Agb576R2tv3eWlIIDAj+DGXA
   jPqbZOSEzsPiGFTNd7lfmlsAf/k+wU1TM7+ovS3Ip2MWlCuV1FvYGrC2+
   Zu2nYDG21cyFKnHify+QyLikMVtbwWDJwPo+t9WAXvShyL3sND77m74yt
   48Ja7GoSM9KUCl9E2kh3naEqglVy3kO8sOW6b7BjJ6zaYxKpW6CBE0fT+
   ROTEKGiC0v7cWHZNrBK39XSLSk4CfB4qDnnvBjmxj0sTPYYhviEcbNeok
   6oq8A5kbuXPxI4WLGPo+RlaZA4m2PZD3XXm7ykZAUoh1e+GDqn5hOfiBn
   A==;
X-CSE-ConnectionGUID: KS4e6oj0T3CzRGb1VuTF/g==
X-CSE-MsgGUID: xaFQfH6BTtmxVxYKajtq5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32322897"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32322897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:30 -0800
X-CSE-ConnectionGUID: m4gLZ7YYTYmA0H22TbpsVw==
X-CSE-MsgGUID: HEqWhcWsRu+Hkg8+Bx5ADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90409775"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa007.jf.intel.com with ESMTP; 20 Nov 2024 11:53:30 -0800
Subject: [PATCH 02/11] x86/cpu: Use MWAIT leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:30 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195329.25931E2D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The leaf-to-feature dependency array uses hard-coded leaf numbers.
Use the new common header definition for the MWAIT leaf.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1	2024-11-20 11:44:16.169610481 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-11-20 11:44:16.169610481 -0800
@@ -29,6 +29,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
@@ -637,7 +638,7 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		0x00000005 },
+	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		0x00000009 },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
_

