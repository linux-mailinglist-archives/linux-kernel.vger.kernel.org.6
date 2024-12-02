Return-Path: <linux-kernel+bounces-426907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AC9DF9FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E6281AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D341D63FA;
	Mon,  2 Dec 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCqwI7h+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D64E28399
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114250; cv=none; b=Z1j0kjezhCJ0OBTgHjE77JN6+ckuj1D4w4XRkowvXSqw/WZcDiAoPQSDNcP6sEG2eHVmUQ1Dt8cbHS9fYsiBYfQHQouw6VQMACpNhBianRxzQp6F/XEtaMl3QUYjRO3zPi0NgPgtMY4iTKI/E92FZAasYB6gSOZDQkV4F0V/JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114250; c=relaxed/simple;
	bh=+IHqiU68nSaL7ZK/oJSrSXnG+TpPlvwPV40O8Iua4xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+2M86ZGyHZE5Uq/oOomzJAt+tKvZBl6vuSkXzHWKH4cSkKpBbwEzgIFWy8yQ5vS8nstaUTPd/vrw63g6fn4Rlr/fPwH9bJrs6mAwkBGeWe6F7cYsn6D7hXRMZShodxCAhL3e0RO3XT7Qy5g27VPEsd6iXdQa4+eJt5dxzSibeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCqwI7h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C5C4CED2;
	Mon,  2 Dec 2024 04:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733114249;
	bh=+IHqiU68nSaL7ZK/oJSrSXnG+TpPlvwPV40O8Iua4xk=;
	h=From:To:Cc:Subject:Date:From;
	b=pCqwI7h+ftZtdU79pIV9TfmOEWD9BsedW/+LXHsCspLgUPttTHYWUTi5o8G/+q6BP
	 pLTXakpqyvokkiI768mjq1AFxyf9bOlF9RaXqI707IHn7EoSJzAbD6bfxE6Gwvqlga
	 ub4bfx1s6vwF+5UylWrFzpTahdxhRcp94kJYz2Rb81H7OGWX5wFJmwS17ZLY62oJL9
	 B/wLRw/CcDo8N5w3brdeDemS75a5hyfgQfMUz30V9rJ4gccBcUrtsEXVDYjBaagDhm
	 cnqYpqLxyb8l2tvvMdKDTJrVX4Luf70NH2SzWQZ3FebeHfdO2dZ/BJ5GFEOKEtcitL
	 V1j01QWYTYr4g==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on systems with AMD preferred cores
Date: Sun,  1 Dec 2024 22:37:24 -0600
Message-ID: <20241202043724.3929062-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

For the scheduler to use and prefer AMD preferred core rankings set
SD_ASYM_PACKING for x86_die_flags().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/smpboot.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135b..419e7ae096395 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -62,6 +62,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 
+#include <acpi/cppc_acpi.h>
+
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
 #include <asm/desc.h>
@@ -497,10 +499,19 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
-	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
 		return x86_sched_itmt_flags();
 
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
+		bool prefcore = false;
+
+		amd_detect_prefcore(&prefcore);
+		if (prefcore || cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+			return x86_sched_itmt_flags();
+	};
+
 	return 0;
 }
 

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0


