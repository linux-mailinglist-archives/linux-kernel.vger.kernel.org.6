Return-Path: <linux-kernel+bounces-415132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75B9D31D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B0CB23B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35951182BD;
	Wed, 20 Nov 2024 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfLJVfRL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73FA920
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065514; cv=none; b=u9r6pu3CisGQImeSIfhNW+JNSl98lcdk9CWyixsAttZUy3WgAgh1T79p1yI7RFcDZjWydueeesP+J1y8Ojs5veh6vA3Vu8la7qfed0RlotPCusLIuY9UWPIrqtW94BGe+VP7KGeT/TXiuxpfjSq9MLwR/Tf58VSOd3zi4CyNI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065514; c=relaxed/simple;
	bh=HVTlIWPtUN3tKcW0bjZEA30Zyg7Om2sZms0RvDsCP3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJPzbO2YRbeBrBITYRPkunOGvblfCQaS2xLPK4YBZV3oSvnaSjHh3XOKUR6skAIaWIOt4ZUrdZTcX1Fy0WKBIvTEZ8m5M+ngqPZE3JvPEDhOCiCxfisp+QRKN74Ss3twUHlMjX78ROPT3VgqGnA5amnCAuO5lO9JRPkNpfqOMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfLJVfRL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065513; x=1763601513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HVTlIWPtUN3tKcW0bjZEA30Zyg7Om2sZms0RvDsCP3o=;
  b=WfLJVfRLfDsKYiqISgGdAiOwxVuNr4ZTk0sJvQx2XfPkyK173UkxMfQM
   G5vaCMBv1qjexdQINKdVelVGgNgQuCRxmxF84A+Q066A6mmnJLUkAYIKN
   AJAeDXnWWWpGosG6X7QsxTLLfh9aDRhzvgapFGQcl+xkd5QqQxR7BXgru
   muBdvlM35mw3JEsoPgFSbQiAfNwXyjZfc+3+JzIhu9LKOaRqsZEaMHgbJ
   16Jc/90eZHFQOXUh9q4Z/j/kdWMc0cTzKDoFoQJlszbhw/lMnSoIJIm4O
   6sRcMP6J5FyRdI7u4LapVnesY3fXxXR1WG6kHt0NbU9v8lfuToCofJpNm
   w==;
X-CSE-ConnectionGUID: WDshgZynRAC/x62IyRu6Fw==
X-CSE-MsgGUID: XITJ9UzPTUGkWYsNTcnO7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="36013022"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="36013022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:18:32 -0800
X-CSE-ConnectionGUID: RyDVgf1rRzeraFk9I2kIxg==
X-CSE-MsgGUID: lduo+gU3Q8Ka2qtwlEBUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="90129289"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orviesa007.jf.intel.com with ESMTP; 19 Nov 2024 17:18:31 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/misc for 6.13-rc1
Date: Tue, 19 Nov 2024 17:18:29 -0800
Message-Id: <20241120011829.818599-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/misc changes for 6.13-rc1. As usual for this
branch, these are super random: a compile fix for some newish LLVM
checks and making sure a Kconfig text reference to "RSB" matches the
normal definition.

--

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_6.13-rc1

for you to fetch changes up to 62e724494db7954c47b4417769f1225cf98f4d77:

  x86/cpu: Make sure flag_is_changeable_p() is always being used (2024-11-08 09:08:48 -0800)

----------------------------------------------------------------
 - Rework some CPU setup code to keep LLVM happy on 32-bit
 - Correct RSB terminology in Kconfig text

----------------------------------------------------------------
Andy Shevchenko (1):
      x86/cpu: Make sure flag_is_changeable_p() is always being used

Breno Leitao (1):
      x86/bugs: Correct RSB terminology in Kconfig

 arch/x86/Kconfig             | 17 ++++++++---------
 arch/x86/include/asm/cpuid.h |  8 +++++---
 arch/x86/kernel/cpu/common.c | 39 ++++++++++++++++++---------------------
 3 files changed, 31 insertions(+), 33 deletions(-)

