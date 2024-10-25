Return-Path: <linux-kernel+bounces-382397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1629B0D26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA3D1C22F64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C30214401;
	Fri, 25 Oct 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAAF1zES"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1820F3F2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880663; cv=none; b=fwliQk4Tkkq66m/xAF16RT3Ybi0au7Axs6SNAEx+z+ab/TmMCePrmPYweRtmuQm9ZiAxka6Iv8rh+V37MFMeo2PpYa58rzLca/lZuw42hBjVV6sY6Rf5msXQVOSQIjP0k+togq70/iLjq5vYHeGl+HZXppzUYjp0XrnetuaMAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880663; c=relaxed/simple;
	bh=d9/iMdqKv+XLG6+WmqeIMg4S4oZiommor9qaH5XHqAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW5X4hlbUayoK4wlnkbUXRG8VkNTzO94b1l90ewxZ+pC38B9wM4rR3WLWWjQ+NYVIDlgINxiqGFp7zwhvQVlJ1tCXMIN2RqOix1mxkHF+ak2TyWiS4PXCo1BvNR9SP7pwNVHyW9jUZObueKe1lxxCv4v62V2RUEUjedAL51JUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAAF1zES; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm9klPokIaTyW3+rN5LwBgShYgrwmCrkRkYvLTHZaEA=;
	b=xAAF1zESpqxl1al57F1z2eSH8ygVVG+N3KSq01OZtIqfAMMSELrvox0sC+4RDq+b9SYJq3
	MdECuMdcFKZZeXmfrvw2ReJZEt2Xhj5DRyrQ+E9c1sKn6HWz7kRsEq+SA4iui5q7WCxFQR
	6/i4BWazmfpCJnUoc5vmnA7L1o61H2g=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 06/18] KVM: arm64: nv: Allow coarse-grained trap combos to use complex traps
Date: Fri, 25 Oct 2024 18:23:41 +0000
Message-ID: <20241025182354.3364124-7-oliver.upton@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

KVM uses a sanity-check to avoid infinite recursion in trap combinations
that could potentially depend on itself. Narrow the scope of this sanity
check to the exact CGT IDs that correspond w/ trap combos, opening the
door to using 'complex' traps as part of a combination.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/emulate-nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 05b6435d02a9..da7ab14e036d 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2021,7 +2021,8 @@ int __init populate_nv_trap_config(void)
 		cgids = coarse_control_combo[id - __MULTIPLE_CONTROL_BITS__];
 
 		for (int i = 0; cgids[i] != __RESERVED__; i++) {
-			if (cgids[i] >= __MULTIPLE_CONTROL_BITS__) {
+			if (cgids[i] >= __MULTIPLE_CONTROL_BITS__ &&
+			    cgids[i] < __COMPLEX_CONDITIONS__) {
 				kvm_err("Recursive MCB %d/%d\n", id, cgids[i]);
 				ret = -EINVAL;
 			}
-- 
2.47.0.163.g1226f6d8fa-goog


