Return-Path: <linux-kernel+bounces-547703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378EA50C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0423AA560
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D896E25A2B8;
	Wed,  5 Mar 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="staJyUtp"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B725A2B3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206430; cv=none; b=giJYm7h7RAK0ZW1BPQKELzwdqwYeh9BBNjtv1NsD3iZR99Jms+eYP7XDRuW7Q/u6hWW+afYG7sErc5sp4N4LIbxCPPG+CZtzgse6rzSlf/Y0Q2Rj0mn4U+e0/RCQFSCwqCmPeJKZuGoitoGmLxfPdMza4nb1uZGJq/ncV+kAgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206430; c=relaxed/simple;
	bh=KVMS2S20RqJDXL6CSXSKW6myhxVt+9yuaYWo6eiaa+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7RnwtkeeuuC8G+UI57NAnOkEhMKlD2qev4daLT19OTVXLRnWspjhZy4ODD8KCWR+ET5zIa8BnE9No2ig+0rTjYDY6zKuYXFzjk9YivhW/XWE+5RoJtDQyD4aaRkL7UwmxFWQtMM+oeCiyNrF3cT8YpGMCt4ubzgO3wimsJbIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=staJyUtp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu97JSnDOZJQo0mlrfz4ghF9+QTKmQpDVJVrWRRDCys=;
	b=staJyUtpLCEx7kJi16tJfAHUtcyOmDxGTUvIXlMrWOUIiWFmfTavmSyPxYFlKl4FnLg3Yb
	7BmKhgqn3CYnQscytyAzDSX+PTXQJPQHL37KRTy6h+olXlaZZCOvHLBxmJBB8+ii7YBF6F
	ISZdqI3kRlGY0RGBQpfLQ+pG5fjDQ1Q=
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
Subject: [PATCH v3 04/14] KVM: arm64: Always support SW_INCR PMU event
Date: Wed,  5 Mar 2025 12:26:31 -0800
Message-Id: <20250305202641.428114-5-oliver.upton@linux.dev>
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

Support for SW_INCR is unconditional, as KVM traps accesses to
PMSWINC_EL0 and emulates the intended event increment. While it is
expected that ~all PMUv3 implementations already advertise this event,
non-PMUv3 hardware may not.

Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 104672a0c5a2..62349b670cf9 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -856,6 +856,8 @@ static u64 compute_pmceid0(struct arm_pmu *pmu)
 {
 	u64 val = __compute_pmceid(pmu, 0);
 
+	/* always support SW_INCR */
+	val |= BIT(ARMV8_PMUV3_PERFCTR_SW_INCR);
 	/* always support CHAIN */
 	val |= BIT(ARMV8_PMUV3_PERFCTR_CHAIN);
 	return val;
-- 
2.39.5


