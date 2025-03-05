Return-Path: <linux-kernel+bounces-547709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85895A50C85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCCC16819A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662325B69F;
	Wed,  5 Mar 2025 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CvRjYyN5"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868025BAD0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206448; cv=none; b=Yeaak0sCzCuw8jlcuLOjiu9L760pamqWAAtgPcNH4eTkv/5z1jyOREKocN25KVD97gGqXaO8UNPE8wRXb/IjnHGU+i1lUAnNgZvYF4RojY8CS4KsEjNsK6Mw61h6HOs6yxPGxPn4nvD0mEjMYdTP28HaqwA/fzLRkbZhBVGv+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206448; c=relaxed/simple;
	bh=2Zvff9DSxDiWX36E1VtM6LDxSAojrVJGu+d6/O1PddI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdQQm1oR8JH07eNOu3BBGhLu8IA8b275D0E3k/C5uJUSsOElW58sTI50sdpk2U9XIoYsLCE+cySb3bPl1obfxrQO5rrhRdOpHqst0khb3MbEScwk8Bf/ZCd739eBDx6qDoyc7+ipFkppKElya3es5knEg3UrbyNYvKV1MOpKRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CvRjYyN5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bDDTqqIerMygPlFTbXBzR4bAQlHdxowEVy28NROPr0=;
	b=CvRjYyN52Un6ydpsuq1SFFaX1v1zahr9DggPQ2o4kQKHj7xsiRct/cl1sDD4Js7F6m51gC
	6HmY7UHb8yHaH5vQm5rJdloqsTjnh5LgD5Y+wszGXySE+fNvqfwlUFIQL9Lw3JyJdpEep/
	lBy3A9y3J8Mm6t/qt9Ye0ux8/lDZG1o=
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
	Janne Grunau <j@jannau.net>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v3 10/14] KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
Date: Wed,  5 Mar 2025 12:26:37 -0800
Message-Id: <20250305202641.428114-11-oliver.upton@linux.dev>
In-Reply-To: <20250305202641.428114-1-oliver.upton@linux.dev>
References: <20250305202641.428114-1-oliver.upton@linux.dev>
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

Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 0a2023aabe18..38d9490c17fd 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1231,7 +1231,17 @@ u8 kvm_arm_pmu_get_pmuver_limit(void)
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


