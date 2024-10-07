Return-Path: <linux-kernel+bounces-353270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E43992B66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C450B2092F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3031D31A2;
	Mon,  7 Oct 2024 12:17:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672111D2F5F;
	Mon,  7 Oct 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303441; cv=none; b=IWiKyZMvIdV6HCy3QfhQUOxg9sQ57XVngk0X2WIILxAHaa/xbQzOWnuo/HpN4KnmKJq2yvaDxKjcqLbNFY73/AANHJp3JGdxpSqkb1KBgO31kISrCf/92sJ52SJRpWc5R1JUstEohtDObz7tveS81fZ+3D4Wsv0z8gHCIoP99h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303441; c=relaxed/simple;
	bh=DKW8HDSWkrcpudrgsaHkjZdeaWOD4WUKhhDTDfliFcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UaU6DNkD7GXuBeKj/uoqYCMBB7wpHqVTHXkzeSe+T5m897WGU3ug0mbtQNap6osiir6ozncNbyJhwqOEl0E5OyC2Htec+Dwc44SdnNYfP3tfT94y5d8eIUnFiR217wj1LVI/KpRghN11iezs7fECte2qXoKQzLSTZp8dZ9zVJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C423FEC;
	Mon,  7 Oct 2024 05:17:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B04183F640;
	Mon,  7 Oct 2024 05:17:18 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10 3/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:17:09 +0100
Message-Id: <20241007121709.548505-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007121709.548505-1-mark.rutland@arm.com>
References: <20241007121709.548505-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 081eb7932c2b244f63317a982c5e3990e2c7fbdd ]

A number of Arm Ltd CPUs suffer from errata whereby an MSR to the SSBS
special-purpose register does not affect subsequent speculative
instructions, permitting speculative store bypassing for a window of
time.

We worked around this for a number of CPUs in commits:

* 7187bb7d0b5c7dfa ("arm64: errata: Add workaround for Arm errata 3194386 and 3312417")
* 75b3c43eab594bfb ("arm64: errata: Expand speculative SSBS workaround")
* 145502cac7ea70b5 ("arm64: errata: Expand speculative SSBS workaround (again)")

Since then, a (hopefully final) batch of updates have been published,
with two more affected CPUs. For the affected CPUs the existing
mitigation is sufficient, as described in their respective Software
Developer Errata Notice (SDEN) documents:

* Cortex-A715 (MP148) SDEN v15.0, erratum 3456084
  https://developer.arm.com/documentation/SDEN-2148827/1500/

* Neoverse-N3 (MP195) SDEN v5.0, erratum 3456111
  https://developer.arm.com/documentation/SDEN-3050973/0500/

Enable the existing mitigation by adding the relevant MIDRs to
erratum_spec_ssbs_list, and update silicon-errata.rst and the
Kconfig text accordingly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240930111705.3352047-3-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: fix conflict in silicon-errata.rst, handle move ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/silicon-errata.rst | 4 ++++
 arch/arm64/Kconfig                     | 2 ++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 14eef7e93614b..9ee1349145573 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -108,6 +108,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
@@ -134,6 +136,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fdf8b0364288..cd13f02d579b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -703,6 +703,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-A78C erratum 3324346
 	  * ARM Cortex-A78C erratum 3324347
 	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A715 errartum 3456084
 	  * ARM Cortex-A720 erratum 3456091
 	  * ARM Cortex-A725 erratum 3456106
 	  * ARM Cortex-X1 erratum 3324344
@@ -713,6 +714,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-X925 erratum 3324334
 	  * ARM Neoverse-N1 erratum 3324349
 	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-N3 erratum 3456111
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6e63dc8f0e8c6..a77fcc9e7c723 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -371,6 +371,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
@@ -381,6 +382,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
-- 
2.30.2


