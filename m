Return-Path: <linux-kernel+bounces-386060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910D9B3EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5A8B21DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9A1F4283;
	Mon, 28 Oct 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1gyHmCt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDD1885B8;
	Mon, 28 Oct 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159444; cv=none; b=dxV7YKGDmpq/0iDCY7odrzEpsTT1BGfqQArh/LSFRb+pg+SeI53dO8i4pXLNvSUZfgTYRtQDXTYBKdJT4IAn+u51HAKbcA9l3N6aP3AVXmu0UiJgFJgy41+d5mkX9U8v59+heJLYMQN4OeQhjIcxrgjotH1cCd97BP4GOYmiGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159444; c=relaxed/simple;
	bh=s8saU6zgX1peEhwMsmeBMjiF1K0wc2wmMWaI9ipoKm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQyD7uJ9mVCFBIIYuqBlAiRkesy0zYHEEiJ/Dcd4PZZGHlc8KguElvBJyNK6IfmY0Ctsj+VnoR4nWVeodmGbLCu807ZhsWqEGCt15KBct4VFXXmOfBiUYCjPPDbUdrV0aVCtheu3c9XqhXg2clhNX0Q4S9pp1LRwB1EiuYhAD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1gyHmCt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730159442; x=1761695442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s8saU6zgX1peEhwMsmeBMjiF1K0wc2wmMWaI9ipoKm0=;
  b=d1gyHmCtI1/pDE15R9Qklv14qYlNUxx2sQ5wP/nacvr37M03fsYncmuB
   0ICEN4QYdOefheLy87xUxygsODkn1qpPVYuCohDg7/G+5Yl2B2pIlsl2y
   5lLoGah2xXXvYwmC/g+CWpE+7Z64MSkytqcihKQxEp2cMqrCb6bmIamAD
   dA3tfdkYVlu8xcCFjQT+I+h8KfKCqSiMjPa/j7R8jlcE4q/NtckbDJXMS
   7F3Led3BqqlClwCTYDt/YogGBmbvN0eqtzXWGTHh4+qUjJZD/BXXfym/d
   1aW+B8LrgZniPlNN0eW2GRDruKAIA7F0rQa/UjBP6bO1q+sydCpulub18
   Q==;
X-CSE-ConnectionGUID: 7RXZlgR/QC6No6jniUAOaw==
X-CSE-MsgGUID: pPyLXQ2GR7qSKq03r0Fo5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29987671"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29987671"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:42 -0700
X-CSE-ConnectionGUID: oeaqdOh8Tvenj3WzFJ5WEw==
X-CSE-MsgGUID: ijBWzkzRT1eDZYbR/xgzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86381229"
Received: from salmansi-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.80.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:40 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 0/2] VERW based clean-up
Date: Mon, 28 Oct 2024 16:50:33 -0700
Message-Id: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several mitigations that use the VERW instruction to clean
up internal CPU buffers.  Currently, each of these mitigations is
treated independently, but if VERW is needed for one of the
mitigations, it's on for all of them. This can lead to some confusion
if a user tries to disable one of the mitigations, but it is left
enabled for one of the others. The user needs to disable all 4 VERW-
based mitigations. Warn the user when one or more VERW mitigations are
disabled but not all of them. While we're messing with VERW
mitigations, might as well simplify them and remove the need to call
each of them twice.

V2:
Dropped the new knob previously introduced in the first patch (Borislav)
Add warning if not all 4 mitigations states match (Borislav)
Removed extra comment (Josh)
Code clean-up (Josh)


Daniel Sneddon (2):
  x86/bugs: Check VERW mitigations for consistency
  x86/bugs: Clean-up verw mitigations

 arch/x86/include/asm/processor.h |   2 +-
 arch/x86/kernel/cpu/bugs.c       | 206 +++++++++++++------------------
 2 files changed, 90 insertions(+), 118 deletions(-)

-- 
2.25.1


