Return-Path: <linux-kernel+bounces-435541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135549E791C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9858280B96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D17204597;
	Fri,  6 Dec 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuSz/wco"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3170198A06
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513912; cv=none; b=CKPKWXHuX5AAT+w/0rdA5XNK6HULDf8B8stI600fAlqRThuuB0Ydzu+wNtCc/dqaEVZl3KVGYTmQ9i/MhQSjVpsfdTe+gwEimfmSP134OiOCkd57CUY63Tfdo3uj5ys8l/Z1xc9r/B4KEdiITZ+TBVGtQtI0/oaTz8IdZBoN6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513912; c=relaxed/simple;
	bh=WOrzz6ZQujJ8swk3As+B4MlGoyi9QPbilMlVxpATvoE=;
	h=Subject:To:Cc:From:Date:Message-Id; b=eK81QPmD1+zPnNg0wG84ZL4wBm4l9mtLnsycUDE5Ji+puJx0EG+iVOkJPn6Wis8gl5+gtxDwLRsvuscmdKkKKDVDpacF/lJpFBfLF/euSSxzM+SUQY2epiTMozSvkSyyJNsVL4cIy7DF76lVWt4iIupIxH50lhWbNDtgjILLVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuSz/wco; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513911; x=1765049911;
  h=subject:to:cc:from:date:message-id;
  bh=WOrzz6ZQujJ8swk3As+B4MlGoyi9QPbilMlVxpATvoE=;
  b=DuSz/wconR1GbQ86H1TtXvhsoZNSQDeJl9PondPMFNgS3czV5O8Fxe4O
   VCWpFWZTi+e/9O3g5CA5NIg9mXUgxoP6gNRwCvg9lZm8EorkRK3xZRcBC
   YkbZHlxScvn8lHMu9v8pgL29mnR9FcmD70z5yjc4eT4/gK0Txq+Uo3bJu
   8Kp5JL5XaXgQtR0zd9nBoJyjUhTYl91OCYuEhDQ78upiO3VLAvKG5S4w6
   DZPJpzQzMxlyBw8WkHOyFDh4mltwIBfkpUZyN51S5wGRGxpfUA+oylPVP
   XFGak1bIaCAXrSwjL4c4CJFNmEysFpfNEafHsQf4bLkoQNtNs7jzqxHeU
   w==;
X-CSE-ConnectionGUID: ip298/UaSkCrNTZQ5LCcaA==
X-CSE-MsgGUID: b80o+VO6QHiDJ7uy+z4aFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027866"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027866"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:30 -0800
X-CSE-ConnectionGUID: /7reAu7PRTmYvY57Tsttwg==
X-CSE-MsgGUID: avNvEDGFTomVAr8nzTZuRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94978981"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:30 -0800
Subject: [PATCH 0/5] x86/cpu: Remove duplicate microcode version matching infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:29 -0800
Message-Id: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from RFC:
 * Convert stepping match helpers to always take a range and never
   take a raw stepping bitmap. - Ingo

--

x86 has generic CPU matching infrastructure. This lets you build
tables of CPUs with some property.  It's mostly used for enumerating
model-specific features, but it is quite a bit more flexible than
that. In includes a facility to match steppings and microcode
versions. This generic infrastructure is built around 'struct
x86_cpu_id'.

There is a less generic, parallel CPU matching facility built around
'struct x86_cpu_desc'. It is used only for matching specific microcode
revisions.  All of the 'struct x86_cpu_desc' users can be converted to
'struct x86_cpu_id'.

Do that conversion then remove the 'struct x86_cpu_desc'
infrastructure.

Testing or acks would be much appreciated!

--

 arch/x86/events/intel/core.c         |   63 +++++++++++--------------
 arch/x86/include/asm/cpu_device_id.h |   51 +++-----------------
 arch/x86/kernel/apic/apic.c          |   18 +++----
 arch/x86/kernel/cpu/amd.c            |    9 +--
 arch/x86/kernel/cpu/common.c         |   78 ++++++++++++++++----------------
 arch/x86/kernel/cpu/match.c          |   28 +----------
 drivers/edac/i10nm_base.c            |   20 ++++----
 drivers/edac/skx_base.c              |    2
 include/linux/mod_devicetable.h      |    2
 9 files changed, 105 insertions(+), 166 deletions(-)

