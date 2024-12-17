Return-Path: <linux-kernel+bounces-449962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974499F58B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2660716E789
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE01FBE83;
	Tue, 17 Dec 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hd1Dn/97"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCF1F9A81
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470484; cv=none; b=Ni1UNsdCXFmf1OYdlAoWUZTfFSP1i8tB+qb/Vbh92rDky6Omn0gjq/sk4BOs+dyY8YzuZX7yQsVqHbM271wXJ7MAepzsD5mAaPuSWQvcoFz4iDqm5zVyQIx6Hypbj88c+SEXI/oonBmudYP1Gc2qHJ6yq3HrLiZQHGM53xWzQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470484; c=relaxed/simple;
	bh=n3SOvQRODNo1srfg8BwehYgwRGk3LRjuNzLJAomOfVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnD0pBCy1wd0Gp0GZV8Or2Qn9dOhtIiwc2Y9VUf8gq+W5Xb2sY7LwMJT9WVsL7xNkGUMxBtlC5V5rg0ICgbc7COPe9KengGX2HRMM6CT0TrI0BKcVw+Bn811fTCNYuwBGQFr+4S/Qttd0eIJsB4b61s7hn1N9IMLkCxMhmtBEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hd1Dn/97; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TcLiLiTkrT1ZOgtNZ0/LRyp4Uk9ZY3x7+K0ZAo4Rt4=;
	b=hd1Dn/97T+NoQc/hRkwhWdtzP43/slWQvmsaGSweQIX8IDm8NpLbSNX+5B1+TUfdrRObC1
	uEyDi8M6QFSDcmbf5ugAowFLytn7XT33HSavk7UC3dcIVBcGig+M3pxNjbLgp4ZZ2+u+kg
	HlzjMiyc5g6VTP/GTFa1086NetX/ZWk=
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
Subject: [PATCH 07/18] KVM: arm64: Remap PMUv3 events onto hardware
Date: Tue, 17 Dec 2024 13:20:37 -0800
Message-Id: <20241217212048.3709204-8-oliver.upton@linux.dev>
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

Use the provided helper to map PMUv3 event IDs onto hardware, if the
driver exposes such a helper. This is expected to be quite rare, and
only useful for non-PMUv3 hardware.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 7f20da32266e..6d7fc0051ad8 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -692,6 +692,18 @@ static bool kvm_pmc_counts_at_el2(struct kvm_pmc *pmc)
 	return kvm_pmc_read_evtreg(pmc) & ARMV8_PMU_INCLUDE_EL2;
 }
 
+static u64 kvm_map_pmu_event(struct kvm *kvm, u64 eventsel)
+{
+	struct arm_pmu *pmu = kvm->arch.arm_pmu;
+	int hw_event;
+
+	if (!pmu->map_pmuv3_event)
+		return eventsel;
+
+	hw_event = pmu->map_pmuv3_event(eventsel);
+	return (hw_event < 0) ? eventsel : hw_event;
+}
+
 /**
  * kvm_pmu_create_perf_event - create a perf event for a counter
  * @pmc: Counter context
@@ -730,13 +742,13 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 	attr.type = arm_pmu->pmu.type;
+	attr.config = kvm_map_pmu_event(vcpu->kvm, eventsel);
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
 	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
 	attr.exclude_user = !kvm_pmc_counts_at_el0(pmc);
 	attr.exclude_hv = 1; /* Don't count EL2 events */
 	attr.exclude_host = 1; /* Don't count host events */
-	attr.config = eventsel;
 
 	/*
 	 * Filter events at EL1 (i.e. vEL2) when in a hyp context based on the
-- 
2.39.5


