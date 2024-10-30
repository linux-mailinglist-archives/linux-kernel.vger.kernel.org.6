Return-Path: <linux-kernel+bounces-389620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA139B6F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCED01C217A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6621894A;
	Wed, 30 Oct 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuIU+3XG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F021767F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324001; cv=none; b=EGhVVxmB+ZwSwpxvC1S8I2Depvw0kD4I5IxtsMnjrkp+MTXfdARNe9T1pL9h1Zu3u90qPzLNT+/7T56zM4eR+I9NPWaRDGoiVUzy7KcnV9fn933a2SJm482ZI+OyQXhgGgI2p8M1FDojeTTsmECuv/ZCGHF3i5lWvlz65fwNarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324001; c=relaxed/simple;
	bh=fZFhON5VAtFNNYMXQaKjy/lDVD2Mja6D0V4DgLGhu1E=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=g41+8GNSStfUqIrVbhoQRVWGVVFGBpryN08Zseb2UeSpiA7xebFKVK0D4TpPuMZvoMUWIo8jttf/GO1nkLQmh+FTmUY8UQqMmVwCSfhJVIQaUinWilhfGaKCBj/G915ppwdk3AteR21gncYigmhbfsXImfazg8MMiSbmwSPZdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuIU+3XG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730323999; x=1761859999;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=fZFhON5VAtFNNYMXQaKjy/lDVD2Mja6D0V4DgLGhu1E=;
  b=WuIU+3XGKmfTJazEt4xONGBl6Ofzwp9h1qDUlnTqyF2VoazRZLV9pt4I
   VHyActLfXJzg0j0WSMj7wqdAJ0/0iHmAO9Tn2X71LRR+V7md7pXCy+ebj
   znww6osTRynxqBWzxgwo+tu8a+5HXjSPgeHXFAJnp+PcAd1M8NbrvXK29
   zAAHd5cZc2ceBeuMW8JC+HrGVKyi3Nd2Tm+fPiJq6rsYLtTelEgY1kqRN
   FVrMXe4i18YyBB6N0oRw9Iby44q0URE2Ll2eycintNz1mJ7C0Td7AtmXt
   cObVG06iOLwXvNO5mKqtOhd3khtATUqn8d/2LGSdhWqUerjrpaiF41BRz
   w==;
X-CSE-ConnectionGUID: a+osCruWSQKAspOOiVeWsg==
X-CSE-MsgGUID: 27Kyd+rPQgu+w0/M6DrbKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741584"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741584"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:19 -0700
X-CSE-ConnectionGUID: mHZACPXNRiS3s5gZhvo9jg==
X-CSE-MsgGUID: PHSgYOjwR1uGo79EadPeCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257640"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:19 -0700
Subject: [PATCH 04/11] x86/acpi: Check MWAIT feature instead of CPUID level
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:18 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213318.55C19666@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I think this code is possibly buggy.  The CPU could have a high
c->cpuid_level and not support MWAIT at all.  It is much more clear to
just check for MWAIT support directly.  Also, because of the CPU level
dependency code, any CPU that has X86_FEATURE_MWAIT also has a
high-enough CPUID level.

Check X86_FEATURE_MWAIT instead of the CPUID level.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/acpi/cstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3	2024-10-30 12:28:10.374352561 -0700
+++ b/arch/x86/kernel/acpi/cstate.c	2024-10-30 12:28:10.374352561 -0700
@@ -173,7 +173,7 @@ int acpi_processor_ffh_cstate_probe(unsi
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	long retval;
 
-	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF)
+	if (!cpu_cstate_entry || cpu_has(c, X86_FEATURE_MWAIT))
 		return -1;
 
 	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
_

