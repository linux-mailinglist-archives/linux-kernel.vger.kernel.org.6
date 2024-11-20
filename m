Return-Path: <linux-kernel+bounces-416272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303279D42B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7091F220DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBDA1C2DCF;
	Wed, 20 Nov 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haNXchWb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C4158A13
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132409; cv=none; b=rCVqj8IfemH1gMT+lX4JlrR++QPQ1tSeED5UW9kBhGJgyQPotQWeL287CCwTHYBfqiL38HKWDLviGrMTyooITyQSphHHWaWb9IU/pAeFMgB1/Y3xAkephwXQrmoJMRKxVSmKo7krSRSWV7ZxJDHmu507D5rC9WLMaU9/r5w95jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132409; c=relaxed/simple;
	bh=y63QDW4bB9giI85NRGxdeAGuxqqnxC49AmpJDY3OdtM=;
	h=Subject:To:Cc:From:Date:Message-Id; b=DA4a/UFyHfaWP2rjGOZsnkZYrx27WwnGNzet3psjR9vcrqswsTneItzl5MjDT54HdeCqABoaykFunHaoucIw4QDtekt7E5TvvlslH5BoqJDli+x91FRrHI9JLgb/RMTG7Erf+9YpTD8PvCuvEnr3vn53Yjh+PIwQK+HFncJehHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haNXchWb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132408; x=1763668408;
  h=subject:to:cc:from:date:message-id;
  bh=y63QDW4bB9giI85NRGxdeAGuxqqnxC49AmpJDY3OdtM=;
  b=haNXchWbzj38u2yvPZDF8LK+hG3KV/uUhSSphnWSEhBwu0CSn062zF52
   F9KmMeBVLrwLyBKsLTehzPYCpTatgNOS2Vp39zASDbU8LESXdml4UVrHB
   n62Lk6YnBwMUomX00Y/gONM4P6aeTomyCM0JgwZW+Li5Ynd7B6FuwPMmd
   KBq8SlX1rp42rfu3eAc7VxjOBOgV2NRp74SayQAcRUaRYmDeiWfiRdCxz
   qkp5eLSK1kDQfwaLunkyLhWa3LxaJiOpIzM4msn+YLcWM8o3elFSjIewB
   7+UkUzd0PCkjGyDm1FbyFaQ2jezGlhvlKN27Z7uATNozC9mT0XMkLIKEN
   w==;
X-CSE-ConnectionGUID: mxUSLRheStSsBEeA7TWy9g==
X-CSE-MsgGUID: YbLX46aMQEyxWHjOYgaebg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32322880"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32322880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:28 -0800
X-CSE-ConnectionGUID: 1UlYEZ9hR9CRyEAAuk+iLQ==
X-CSE-MsgGUID: Jk0Bm/FVSVaE0qq0MtZXnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90409747"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa007.jf.intel.com with ESMTP; 20 Nov 2024 11:53:27 -0800
Subject: [PATCH 00/11] x86/cpu: Centralize and standardize CPUID leaf naming
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:27 -0800
Message-Id: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I noticed that the MWAIT code was rather haphazard in how it deals
with CPUID leaf levels.  As a result, there were a ton of unnecessary
checks for ->cpuid_level.  It is truly the worst offender because
there's arch/x86, intel_idle and ACPI that want to poke at it.

Move several of the leaf definitions to one place (cpuid.h).  Use
the definitions to get rid of magic numbers.  Simplify the code
when the CPUID feature level dependencies can be used.  Lastly,
change all the leaf names to be consistent.

This does not get *ALL* the leaves.  The topology and cache ones
are left along for now, but they can also be converted over.

It's obviously right in the middle of the merge window, so no
rush on looking at this.  I just wanted to get it into everyone's
review queues.  Barring any big issues I'm planning to apply this
to one of the tip branches after -rc1 drops.

 arch/x86/events/intel/pt.c            |    5 +++--
 arch/x86/events/intel/pt.h            |    3 ---
 arch/x86/include/asm/cpuid.h          |    7 +++++++
 arch/x86/include/asm/fpu/xstate.h     |    4 ----
 arch/x86/include/asm/mwait.h          |    1 -
 arch/x86/kernel/acpi/cstate.c         |    5 +++--
 arch/x86/kernel/cpu/common.c          |    7 ++++---
 arch/x86/kernel/fpu/xstate.c          |   26 +++++++++++---------------
 arch/x86/kernel/hpet.c                |    6 ++----
 arch/x86/kernel/process.c             |    3 ++-
 arch/x86/kernel/smpboot.c             |    5 ++---
 arch/x86/kernel/tsc.c                 |   23 +++++++++++------------
 arch/x86/xen/enlighten_pv.c           |    5 +++--
 drivers/acpi/acpi_pad.c               |    5 ++---
 drivers/dma/ioat/dca.c                |    8 +++++---
 drivers/idle/intel_idle.c             |    6 ++----
 drivers/platform/x86/intel/pmc/core.c |    7 ++++---
 17 files changed, 61 insertions(+), 65 deletions(-)


