Return-Path: <linux-kernel+bounces-449968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA469F58B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0086216FCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6321FCCE4;
	Tue, 17 Dec 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZLNaTfC"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B731FC7E2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470501; cv=none; b=uw3pL4xTgbRhBxChrjIF/2xrYXmCCEb5Ht7o/UHS+lDVYmFqMFHDxyghMGNY4lSfPRRMXBBXbB1FMxuer+5ib0aSbaSndhpTkSHKpL3Cf5MVCcqkhIS9TmMlewYHdJbjgN7XVtLHiLiilxejhzsoiEzB6hvt+QyaE/ttPAw+0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470501; c=relaxed/simple;
	bh=MXMO6HM+iSiZcB+0JlvSfCWzsqeO9iyIKaDuZHMuzgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxvSTMpj1O9vt4PMD2OTkcqAhvj446BRDmNAUtCDuf/JS3/Kuwg0Y2lHq/h4gHlY1pBCwpJo8QZXZ2vnNEy3U1CGpEkiQkD3s1fOG5zH5dmUnGAXP0A7zPlXbAnwruT+A3xrPrOABgdT1Tf8LsJRibtfZ8c5ceHJhqAu4zrMbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZLNaTfC; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJFymO38mcOTwo9Ozy+04D6XjuWZMyD8ycVX0URXSkM=;
	b=rZLNaTfCEsziEgMq9tNF0aLUYY9DIeVJcADzb38IxuwltCL3ddXw/uZcwoisq/I04YudCl
	TDdxzzPZy1KlvfB0bekieecTRrnaxG97ovgfCghK5WMTfb4zaYt9xyrnOnQJJXUMqlM/ux
	s9suG354SnWVyc1/NWCBR8pqThWhdQ8=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 13/18] KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
Date: Tue, 17 Dec 2024 13:20:43 -0800
Message-Id: <20241217212048.3709204-14-oliver.upton@linux.dev>
In-Reply-To: <20241217212048.3709204-1-oliver.upton@linux.dev>
References: <20241217212048.3709204-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Advertise a baseline PMUv3 implementation when running on hardware with
IMPDEF traps of the PMUv3 sysregs.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 98690e53dc73..553d02a03877 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1262,7 +1262,17 @@ u8 kvm_arm_pmu_get_pmuver_limit(void)
 	pmuver = SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer,
 			       read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1));
 
-	/* Treat IMPLEMENTATION DEFINED functionality as unimplemented */
+	/*
+	 * Spoof a barebones PMUv3 implementation if the system supports IMPDEF
+	 * traps of the PMUv3 sysregs
+	 */
+	if (cpus_have_final_cap(ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS))
+		return ID_AA64DFR0_EL1_PMUVer_IMP;
+
+	/*
+	 * Otherwise, treat IMPLEMENTATION DEFINED functionality as
+	 * unimplemented
+	 */
 	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
 		return 0;
 
-- 
2.39.5


