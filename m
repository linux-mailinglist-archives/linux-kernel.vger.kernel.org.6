Return-Path: <linux-kernel+bounces-281452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A794D710
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01E11F23B45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9F16131C;
	Fri,  9 Aug 2024 19:15:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2B146590
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230958; cv=none; b=Z20bXnVsUVdoYmEdYe2Jr9vn5LHQ6dXvVO2AzvP9ZUoQwUamEfU2paA/8jTC5MocGe4sS4TEuuEyZ43Fmk6cSKK+y3qKZH3C/s0hRHxXPteHCA/INssvDZgCZhxAZrtgq5u0QssHlCChA11SIDkWAmizP+05CIx1Y1zmlnuaAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230958; c=relaxed/simple;
	bh=pCy+egvK2jHmQ5qflpLymO5tRyRWlBT26O/LhPcYBxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pi/wRxmtWinIRG84/TbcwfmrfvxdnAgpYtDe7E6CuE1Up0uxol7k0V5X1cPOnOF1LT927/tzW/Nl6ZFdvHIrbF+TfUkEeTIheF4a0CoJWPK9ePu+/bfr87oHfsQwR6nNDbUK2VNW31LJ20SSkTGUTe8J7/1XYM7IoSZEMK3F2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 346AC1688;
	Fri,  9 Aug 2024 12:16:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 988683F71E;
	Fri,  9 Aug 2024 12:15:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 2/8] perf/arm-cmn: Fix CCLA register offset
Date: Fri,  9 Aug 2024 20:15:41 +0100
Message-Id: <e73b31da42a7840d4247fc8a4a3cea805c2ab618.1723229941.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1723229941.git.robin.murphy@arm.com>
References: <cover.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
the CCLA_RNI combination type.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index fd2122a37f22..0e2e12e2f4fb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2393,10 +2393,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CXHA:
 			case CMN_TYPE_CCRA:
 			case CMN_TYPE_CCHA:
-			case CMN_TYPE_CCLA:
 			case CMN_TYPE_HNS:
 				dn++;
 				break;
+			case CMN_TYPE_CCLA:
+				dn->pmu_base += CMN_HNP_PMU_EVENT_SEL;
+				dn++;
+				break;
 			/* Nothing to see here */
 			case CMN_TYPE_MPAM_S:
 			case CMN_TYPE_MPAM_NS:
-- 
2.39.2.101.g768bb238c484.dirty


