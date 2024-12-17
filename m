Return-Path: <linux-kernel+bounces-449972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D247D9F58DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D518892C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832561FA173;
	Tue, 17 Dec 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CgvLXXFj"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA81F9ED9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470611; cv=none; b=XPMCD6iIyRBe9mSFgPx4XXCDCLAgFnc7zmE3fO2LbuOUV611mqsf7C73PkMeWXOrQU6NANORF69enUjnbnbNsSyFsi7meBsz7BB6DqW45omL4nmd8uMZCjTJif/dUUeBhML9DNcD+VVf0bCmxSz2R62Ie9ScxsoYJOpem5BE/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470611; c=relaxed/simple;
	bh=NXA6117OUd87ryCkftHmcO053FxG/qFwi2EquP39vVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsFC062IDjhaAiYm2FxvoVXB4GDHaWnGMRg2J2kH7A6QBV15bA5XNjdhdV5Q1vpRbs5S4onsUJNwZu28/u7XQRZPqZdyxDAFSUSDtAGyv0l4EXwyoqvk3hCaVlpojyu9rp1wsrlS2Qh++35qKskF+CxA1EKmJ0daaAkcHE0MDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CgvLXXFj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcEmfpLqIW1Z12OpNFspMutcu+Tk1OvNr+7PPdfsRyo=;
	b=CgvLXXFjpqwY4rgZR3L02QL3zorf4YPkRDogp1MKm22ZPwwiUXNTZpFp/WBFpwTGZ6ocZz
	UqPADVEshmMdxJWGcW8djppmX9chkojkFiT//UtaPdOv2Gk85GUqHjpv+bb4LgSmwNLHPa
	8rZoYmUOgXe0VOcQCp5vpLsxfGsGdbU=
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
Subject: [RFC PATCH 16/18] drivers/perf: apple_m1: Map a few more PMUv3 events
Date: Tue, 17 Dec 2024 13:23:17 -0800
Message-Id: <20241217212317.3709478-1-oliver.upton@linux.dev>
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

Map some more PMUv3 events onto hardware so 'perf stat' in a KVM VM can
show some useful information (e.g. IPC, branch prediction rate).

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b4fe247543a6..0e54d3f900a7 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -180,7 +180,10 @@ static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 
 static const unsigned int m1_pmu_pmceid_map[ARMV8_PMUV3_MAX_COMMON_EVENTS] = {
 	[0 ... ARMV8_PMUV3_MAX_COMMON_EVENTS - 1]	= HW_OP_UNSUPPORTED,
+	M1_PMUV3_EVENT_MAP(INST_RETIRED,	INST_ALL),
 	M1_PMUV3_EVENT_MAP(CPU_CYCLES,		CORE_ACTIVE_CYCLE),
+	M1_PMUV3_EVENT_MAP(BR_RETIRED,		INST_BRANCH),
+	M1_PMUV3_EVENT_MAP(BR_MIS_PRED_RETIRED,	BRANCH_MISPRED_NONSPEC),
 };
 
 /* sysfs definitions */
-- 
2.39.5


