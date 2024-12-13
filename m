Return-Path: <linux-kernel+bounces-445542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768139F1795
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA90188E499
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F05D191F77;
	Fri, 13 Dec 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftLuRjyZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB66FC3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123029; cv=none; b=KUFdI/qEasA0VgGxvmig1Q7WFRodJbOlydwqyOXG81eoJSrQf8pTiffrJntUYdAXuQfrC0qOPWhGQ0Suyb5zDC7LZUrOnsHIHbXQGFqpShL2sHBGQ3NvatQhEq/UbWk11I0BaODoLOKr8WOT75keByJyaTr0HDDVNcymkirmKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123029; c=relaxed/simple;
	bh=7ZyImW6S/cNfbxgo0BcRka2sjcsLvHkBpSfI5/Z73Rk=;
	h=Subject:To:Cc:From:Date:Message-Id; b=dyd85Cg+OfZX+UGp1rx2rTyNRvOJOYOCbc9wmbVt1UYXKOMKqw1ugyQ7uiBKaF9J26DweUSrF755q5BJ0fwvhWiTfltPiU0AFZNOshsvNCvKJaWFWV3L75BhaOjnHyifgVZYm5TgiNEh87VCL53XKvQyNsM676KjsIau0zviQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftLuRjyZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123028; x=1765659028;
  h=subject:to:cc:from:date:message-id;
  bh=7ZyImW6S/cNfbxgo0BcRka2sjcsLvHkBpSfI5/Z73Rk=;
  b=ftLuRjyZOQdD8R4NBUak6Gw5qu1fdFXMUVxNUHKUnR2HMviD89mKPQCn
   BIsNi8mmDsUKSQEb7QeGqTMjvPPp/u4MlyUgyaKIWjWyoZ62Tunaik4d4
   iAGvvJodaHImqYfWQaCsKjFKKM1gmkFeCpz8kEg5AyFV8tQdReHXPA8XY
   301dMtoHCY5TSSqEgFpYzzt4GLRIeeYtMkFmuNDsmnkkLSQXkbgXuKJ9n
   aI+ZUavpfIzXY+bKpfVcUQfntYPRdFdFIKLBjy6e/nZE+ww/lZERGZsZc
   JvYn2drjVHSlh5AERmDWFSWBjTOBW8VdsFFzcVAIBc6TIs2LTLPh/CgnN
   w==;
X-CSE-ConnectionGUID: lhFpiF3EQSmpJYthD7qOpQ==
X-CSE-MsgGUID: Cu8fuDR6S12vBMXe8YgEcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34820476"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34820476"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:27 -0800
X-CSE-ConnectionGUID: Llts+FKpTwGju2sPVWQw0g==
X-CSE-MsgGUID: H0ASmKCZRDe1kAn2WpI1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96501658"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 12:50:27 -0800
Subject: [PATCH 00/10] [v2] x86/cpu: Centralize and standardize CPUID leaf naming
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:26 -0800
Message-Id: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v1:
 * Drop bogus "Check MWAIT feature instead of CPUID level" patch
 * Add review tags

--

I noticed that the MWAIT code was rather haphazard in how it deals
with CPUID leaf levels.  As a result, there were a ton of unnecessary
checks for ->cpuid_level.  It is truly the worst offender because
arch/x86, intel_idle and ACPI that want to poke at it.

Move several of the leaf definitions to one place (cpuid.h).  Use
the definitions to get rid of magic numbers.  Simplify the code
when the CPUID feature level dependencies can be used.  Lastly,
change all the leaf names to be consistent.

This does not get *ALL* the leaves.  The topology and cache ones
are left along for now, but they can also be converted over.

 arch/x86/events/intel/pt.c            |    5 ++--
 arch/x86/events/intel/pt.h            |    3 --
 arch/x86/include/asm/cpuid.h          |    7 ++++++
 arch/x86/include/asm/fpu/xstate.h     |    4 ---
 arch/x86/include/asm/mwait.h          |    1
 arch/x86/kernel/acpi/cstate.c         |    5 ++--
 arch/x86/kernel/cpu/common.c          |    7 +++---
 arch/x86/kernel/fpu/xstate.c          |   26 ++++++++++--------------
 arch/x86/kernel/hpet.c                |    6 +----
 arch/x86/kernel/process.c             |    3 +-
 arch/x86/kernel/smpboot.c             |    5 +---
 arch/x86/kernel/tsc.c                 |   23 ++++++++++-----------
 arch/x86/xen/enlighten_pv.c           |    5 ++--
 drivers/acpi/acpi_pad.c               |    5 +---
 drivers/dma/ioat/dca.c                |    8 ++++---
 drivers/idle/intel_idle.c             |    6 +----
 drivers/platform/x86/intel/pmc/core.c |    7 +++---
 17 files changed, 61 insertions(+), 65 deletions(-)


