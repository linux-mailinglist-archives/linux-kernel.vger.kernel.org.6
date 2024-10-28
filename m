Return-Path: <linux-kernel+bounces-386061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D49B3EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7BA1C21B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76801FBC86;
	Mon, 28 Oct 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViQmBhi/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4881D5171;
	Mon, 28 Oct 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159446; cv=none; b=rb6JGUGtIVwcWBNVC0YbNj2KZGASibJR7btk52Yu+ZtJ2K3QZp7ei60i1rlRXqY3HIkM2Dq2WDh2/p5jm5Zk19+IuNIWUFAce+dpq2XSxiO8I6o79ZLEpYmtpFsXzlMp5DSpU2ZI8fojlZf8EVYY8G6zMo1QnHJ+tT3nRHkdg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159446; c=relaxed/simple;
	bh=oJqiwSMjDU4oPhhJBVFu9TLet5JypqFREiJbc+59QCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVsmKxeYMa6Bx5R8zGbJyCeblnlS6SDDl3CadsDIbtxcZxDsY/dcc+Cbr3qBu9BgSi+WFWCEc4uurWLT/8dUY+eQXmlf8ohyT77yIT97Dv5jwlnl5yCTdbCvT5NFsKGi9qNBLDM4H9G7ckrHsN1AHQIqGFVFrhSQuLUiQ42zi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViQmBhi/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730159444; x=1761695444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJqiwSMjDU4oPhhJBVFu9TLet5JypqFREiJbc+59QCw=;
  b=ViQmBhi/0ITSBW+nhNx5dLeGk7lJugXq/8yOx5z/W+KqlG5pV5vXXV2X
   KHDWCXTmuerW3odFOO6tzFpXTC2J7rZ0fbajybEZgv7zUhhngN9TXQzFJ
   BOw1VQkak+gSmtqPvtfqrhYPJSAuz/VM32x/4IC8zIr92ro+G+allY3nY
   rVqj0HDfcZgPsQzyQwDXD0zCrPsoywqutuFsBK50+2gYyEjoS9xhVteU+
   PWfaC4PwGZHCv0vxaW6Vohx61pSEsgJid8rd1zPuJbv6omb4dD9B13DGi
   IK4vvUN7/TR75b28NSHw5N32yxiL1ePQmkraIgp5VE+fweFjVuNhL+Tfv
   w==;
X-CSE-ConnectionGUID: LQU4+TG0RcyVK9XDaxDjpg==
X-CSE-MsgGUID: gee+u+bkQvyVZKJKfHGm8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29987680"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29987680"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:44 -0700
X-CSE-ConnectionGUID: xmV3xEJ4TImjjzyWq3TujA==
X-CSE-MsgGUID: UJAXsTOBRvaOJ3c/co5+lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86381235"
Received: from salmansi-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.80.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:42 -0700
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
Subject: [PATCH 1/2] x86/bugs: Check VERW mitigations for consistency
Date: Mon, 28 Oct 2024 16:50:34 -0700
Message-Id: <3ed45a10e2f7fbecce31d9964b1da1372e8cb838.1730158506.git.daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently 4 mitigations that use VERW: MDS, TAA,
MMIO Stale Data, and Register File Data Sampling. Because
all 4 use the same mitigation path, if any one of them is
enabled, they're all enabled. Normally, this is what is
wanted. However, if a user wants to disable the mitigation,
this can cause problems. If the user misses disabling even
one of these mitigations, then none of them will be
disabled. This can cause confusion as the user expects to
regain the performance lost to the mitigation but isn't
seeing any improvement. Since there are already 4 knobs for
controlling it, adding a 5th knob that controls all 4
mitigations together would just overcomplicate things.
Instead, let the user know their mitigations are out of sync
when at least one of these mitigations is disabled but not
all 4.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d1915427b4ff..b26b3b554330 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -582,8 +582,26 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
+static void __init verw_mitigations_check(void)
+{
+	if (mds_mitigation == MDS_MITIGATION_OFF ||
+	    taa_mitigation == TAA_MITIGATION_OFF ||
+	    mmio_mitigation == MMIO_MITIGATION_OFF ||
+	    rfds_mitigation == RFDS_MITIGATION_OFF) {
+		if (mds_mitigation == MDS_MITIGATION_OFF &&
+		    taa_mitigation == TAA_MITIGATION_OFF &&
+		    mmio_mitigation == MMIO_MITIGATION_OFF &&
+		    rfds_mitigation == RFDS_MITIGATION_OFF)
+			return;
+
+		pr_info("MDS, TAA, MMIO Stale Data, and Register File Data Sampling all depend on VERW\n");
+		pr_info("In order to disable any one of them please ensure all 4 are disabled.\n");
+	}
+}
+
 static void __init md_clear_select_mitigation(void)
 {
+	verw_mitigations_check();
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
-- 
2.25.1


