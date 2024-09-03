Return-Path: <linux-kernel+bounces-313010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4527969EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4C28660D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2D1A7270;
	Tue,  3 Sep 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BF0BCgfG"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01251CA6AF;
	Tue,  3 Sep 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369962; cv=none; b=tj1y+Dg2iWSdOyKZtRVtOcvLE4pe7SxSfjYJBvg42sHG1QM0q5MfMuqcLGBugZ5kaY14AszDLhraw7rIwRymGEC5GkQZKvMbGHvmW+ZPxzKtvXf8RCdMVwqvACRO8njYmGlEnI17oqaGC10a+vipWWG3OOicUb3PF1c3vAhUzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369962; c=relaxed/simple;
	bh=k7iuFT1H7ujrvfLyNrffmZSfZA4lxwHy6zFA4xnUBz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCQn25IWya09VuRTYmWOguBND9XQWrS5vwCr1IvUJ/dRLOe9OQWp/yhQvzOpl3Na18ntRgoCyKKy9dxp1M2vs2l9kr19IQKA82bpHEP5yzIw2BgWp9ISPCN3w3W9w91/yMusW80VRO5kiSFcipg2Rkjpf8YnoTpdWVM7east9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BF0BCgfG; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725369961; x=1756905961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bRq6OaDwt0v/rRzT3o77hM5i/nBzjJJFOfHuaw9pAKY=;
  b=BF0BCgfGWjMgSA+3NOPaofIn5zEXCplohkdLFI575SUQodNBG9sMo7H2
   ijjf6NnvmCqHDz/uTuYFongQy1KVHIDSgvsaqOEjZ0b7TdhdlBag5WKY0
   ZkGeo3c5XIlGn5eAshExxBoDwDBEwRVIeWibFxxiQU3Q4D1fBtQDKJKGH
   A=;
X-IronPort-AV: E=Sophos;i="6.10,198,1719878400"; 
   d="scan'208";a="450080823"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:25:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:54976]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.147:2525] with esmtp (Farcaster)
 id e699812b-fed0-47f1-8332-46244ff6de93; Tue, 3 Sep 2024 13:25:38 +0000 (UTC)
X-Farcaster-Flow-ID: e699812b-fed0-47f1-8332-46244ff6de93
Received: from EX19D002ANA002.ant.amazon.com (10.37.240.152) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 3 Sep 2024 13:25:38 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D002ANA002.ant.amazon.com (10.37.240.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 3 Sep 2024 13:25:36 +0000
Received: from dev-dsk-itazur-1b-8445a99b.eu-west-1.amazon.com (10.13.227.122)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 3 Sep 2024 13:25:35 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Takahiro Itazuri <itazur@amazon.com>, Takahiro Itazuri
	<zulinx86@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: Use list table for possible GDS sysfs values
Date: Tue, 3 Sep 2024 13:25:33 +0000
Message-ID: <20240903132533.26458-1-itazur@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Using a normal table, a line break in the first column would be
recognized as two rows. Uses a list table instead as in MDS.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 .../hw-vuln/gather_data_sampling.rst          | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
index 264bfa937f7d..4a2eaa80d20a 100644
--- a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
@@ -85,23 +85,25 @@ GDS this can be accessed by the following sysfs file:
 
 The possible values contained in this file are:
 
- ============================== =============================================
- Not affected                   Processor not vulnerable.
- Vulnerable                     Processor vulnerable and mitigation disabled.
- Vulnerable: No microcode       Processor vulnerable and microcode is missing
-                                mitigation.
- Mitigation: AVX disabled,
- no microcode                   Processor is vulnerable and microcode is missing
-                                mitigation. AVX disabled as mitigation.
- Mitigation: Microcode          Processor is vulnerable and mitigation is in
-                                effect.
- Mitigation: Microcode (locked) Processor is vulnerable and mitigation is in
-                                effect and cannot be disabled.
- Unknown: Dependent on
- hypervisor status              Running on a virtual guest processor that is
-                                affected but with no way to know if host
-                                processor is mitigated or vulnerable.
- ============================== =============================================
+  .. list-table::
+
+     * - 'Not affected'
+       - Processor is not vulnerable.
+     * - 'Vulnerable'
+       - Processor is vulnerable and mitigation is disabled.
+     * - 'Vulnerable: No microcode'
+       - Processor is vulnerable and microcode is missing mitigation.
+     * - 'Mitigation: AVX disabled, no microcode'
+       - Processor is vulnerable and microcode is missing mitigation. AVX
+         disabled as mitigation.
+     * - 'Mitigation: Microcode'
+       - Processor is vulnerable and mitigation is in effect.
+     * - 'Mitigation: Microcode (locked)'
+       - Processor is vulnerable and mitigation is in effect and cannot be
+         disabled.
+     * - 'Unknown: Dependent on hypervisor status'
+       - Running on a virtual guest processor that is affected but with no way
+         to know if host processor is mitigated or vulnerable.
 
 GDS Default mitigation
 ----------------------
-- 
2.40.1


