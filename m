Return-Path: <linux-kernel+bounces-416282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED849D42C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D754B283D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244711CB33B;
	Wed, 20 Nov 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mq7Fbov0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA681CB301
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132422; cv=none; b=Z0hbhdu6q3R1wHahOjXpAaZGZxVWehyXGoQqE47G8WATo7r8RsJJWH+++vpA3TYu8rkDQSZLi5CtyXOCCUt25x2yBBGSEFz0b+v/GaiSYVkv9Ix0dos6mG3s8sznQeLUlIpTbNgnLJgpcwuXFjC0sdQcbXc+EJshYzBzpfximXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132422; c=relaxed/simple;
	bh=cvGQlHRvhDXLh3TnNwLakkrjseX/TMv8SkB1KSpoeOk=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Q9fcbRCfdGkeWCRyQ3+gQkeD9yM0uZLpe8TSDIOY5Dx73MO/cvLi0t+XK7SSBSYIbba1/vP7u4cDOcYLhWacxekurL+Dq7Aswhvz3qJW6JbMeN/9VamYwMR9YMszmfszqNOuJuYWETejEDSnSiM/LHMArzbZfki2wrkRc3eeS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mq7Fbov0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132421; x=1763668421;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=cvGQlHRvhDXLh3TnNwLakkrjseX/TMv8SkB1KSpoeOk=;
  b=Mq7Fbov0YCCHYyrP6QBVt6IqRcybuvhE8G+wiODCto4L8rGQqWh5lj94
   MXYAlZdVz5TqBQkqHIUZvHsSmVK5cvSFh5SbvTGcaUEOJHtrosqs148sq
   vI/B0R3gqLG79EBiwHkGbXStgv6P7MceLUCpUVRsF2CdnSRwYL/dz7kds
   Ykh1d1UMpGb7JmPrmThMn/FMYi7sJpiQPIQb+fXuv92bvnSBf2//Jh+y4
   yIYgyQKoyOuh9/XRK9Wx7/mZLyfoF9QM6XqiuixPB99fxRiZ4p9NGhqSe
   GMX2uOuPSGYvr8idA4TBbYOkp2hgyp5EG+hFa/RJXSE2fpHzQGcnQUBHH
   A==;
X-CSE-ConnectionGUID: pkRuaU/6RN2N+rAFpDJk6Q==
X-CSE-MsgGUID: zRP4oXwXQEeEqphYbGooTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31581000"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31581000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:41 -0800
X-CSE-ConnectionGUID: LeRE0sDlRqilYFodSdv09g==
X-CSE-MsgGUID: ssJ/lTj+RK+Drnr/gfw7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884236"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:41 -0800
Subject: [PATCH 10/11] x86/fpu: Remove unnecessary CPUID level check
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:40 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195340.047C9ABE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
if the CPUID level is too low.  This code is unreachable.  Kill it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/fpu/xstate.c |    5 -----
 1 file changed, 5 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2	2024-11-20 11:44:20.369771244 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2024-11-20 11:44:20.373771397 -0800
@@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsi
 		return;
 	}
 
-	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
-		WARN_ON_FPU(1);
-		return;
-	}
-
 	/*
 	 * Find user xstates supported by the processor.
 	 */
_

