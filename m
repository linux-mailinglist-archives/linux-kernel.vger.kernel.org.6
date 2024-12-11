Return-Path: <linux-kernel+bounces-440843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E779EC516
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66C3167974
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D21D7998;
	Wed, 11 Dec 2024 06:54:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF01D63D4;
	Wed, 11 Dec 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900082; cv=none; b=G9p7iTtoGgv2l+Rgn0qUDZLwGWz0zFm0GOwr5cg9BCLVrKffs9rINyAYJ6yjs4N5X6bWsbk3htX+H5EA/ygIaPy4lkHlw+Pe1fB+3uiq4VR8dYTXPu8yajtOnON2x4gTu//4K9UpIgcwsT7AKR/0JPjRaTaSpug3UbJDDeevKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900082; c=relaxed/simple;
	bh=MDjgfLH2j+JazH5VLTwXeSihzd3Ohd4sP9zEBAgsSKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoEBaDmX9Rwqw3iS0owmEDuraxLS7trfpUcvr/YqZKQNWwRglNA/fDeKyWGpV9UzXPK8JZ8fE+O7yViCVXEppFOvv9gLFQ6gSU44Ds0JhenTwouZQjLUffoNLarT9ZJN98rc+6YhdpShZJYU5M9IWyagzlZVzJ6NQGUzf9VuhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04AA1063;
	Tue, 10 Dec 2024 22:55:07 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33DF53F720;
	Tue, 10 Dec 2024 22:54:36 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: arm64: Document EL3 requirements for FEAT_PMUv3
Date: Wed, 11 Dec 2024 12:24:25 +0530
Message-Id: <20241211065425.1106683-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211065425.1106683-1-anshuman.khandual@arm.com>
References: <20241211065425.1106683-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents EL3 requirements for FEAT_PMUv3. The register field MDCR_EL3
.TPM needs to be cleared for accesses into PMU registers without any trap
being generated into EL3. PMUv3 registers like PMCCFILTR_EL0, PMCCNTR_EL0
PMCNTENCLR_EL0, PMCNTENSET_EL0, PMCR_EL0, PMEVCNTR<n>_EL0, PMEVTYPER<n>_EL0
etc are already being accessed for perf HW PMU implementation.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/booting.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 1b3ac1394e5f..60b16f00d0a8 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -455,6 +455,12 @@ Before jumping into the kernel, the following conditions must be met:
 
    - MDCR_EL3.TDA (bit 9) must be initialized to 0b0
 
+ - For CPUs with FEAT_PMUv3:
+
+ - If EL3 is present:
+
+   - MDCR_EL3.TPM (bit 6) must be initialized to 0b0
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.30.2


