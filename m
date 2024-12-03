Return-Path: <linux-kernel+bounces-430063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A499E2C24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A8B28447E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084C20B21F;
	Tue,  3 Dec 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJXK4INL"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB820B217
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254410; cv=none; b=FwcgwLpjM3VEBnMHi4r3gxulxkiTik/DXaqC/mFAGwkkBq/TNdTJVFSHpoeog+LgPN1Pjlv6kN/tIYsTgfhUTLYbNjvusy+rQeIQLUAzhl139RUbww75jyJkdQbIcC7m1Xaxlwo6kB575bhzZVaj5C7IdCX+gfV8VVtoAy5WJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254410; c=relaxed/simple;
	bh=zApNaI6tojKCcUw3gPguulWlel1yi3ixAh3M2UgEB0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNJHIEIoKtLyaEHBqlZozH/Az1L8hNfy5suTPbENOX2Cn5S04bKfqf+LS7pldcBwDXKyKY6vYVzi9azTh8ojS/F1+z0bKcKEbuN9Trk7Q88PH4nb5/b5k5LjGmI0uwq56NLJdx4pP9zKlW8jWNU7lJfga7/I2tspCvU48TUMlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJXK4INL; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjObVzSUPGyiRyx8ZPD/sAgeVRJoiPetpoC5aOxqHj0=;
	b=cJXK4INL5jtoZAsVKaT4wMa0IFT2vyHXw/V60yqBYaCbLzzagsQo2oxhgaGZBMFaxdA7xO
	uTM//NBSf6MXu/swHUQrOPQ3U0GI4KKCT/QYoSi7B97s9ihPnJVkaXM8HKQgP0edrmEz9a
	6fyyV66ig91+6AszbHOSrlwLio0eemo=
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
Subject: [RFC PATCH 12/14] KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
Date: Tue,  3 Dec 2024 11:32:18 -0800
Message-Id: <20241203193220.1070811-13-oliver.upton@linux.dev>
In-Reply-To: <20241203193220.1070811-1-oliver.upton@linux.dev>
References: <20241203193220.1070811-1-oliver.upton@linux.dev>
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
index 8a565817a814..34d9c08af209 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1260,7 +1260,17 @@ u8 kvm_arm_pmu_get_pmuver_limit(void)
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


