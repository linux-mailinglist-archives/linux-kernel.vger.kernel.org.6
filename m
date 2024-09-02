Return-Path: <linux-kernel+bounces-311743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084B968CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9406DB22A19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B42139B1;
	Mon,  2 Sep 2024 17:52:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCAA1C62DF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299538; cv=none; b=AGvrrTD1arNoqb2INW8w0ey+VBm3SOVSdsfpVIfvrsV3x5S9rQNPMI6xpDa21CeDwiO5MopCp1Z2LrX+6eRqQktZtd9iprqWrsUcG+ZRmMck5HL/F7RgU/5h0E/AFsQrf6DWrOO2kbiQdDjTJcIXtdWLI58F79pEERRhp15GKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299538; c=relaxed/simple;
	bh=it758AUX/OhBgme5dOZrW24gPUrXndcCKV1uuhwlu0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfSM0v3dhHZWbMhJBctK2Ux2ZzX3UzDMwMbsDI2SBJEzIUbDJTb0F7angY0A6yCzJetgAbnGqXw62jw789ODz+by6w7Hn3hEJdmcafhDemdLdPKErDeX8ob0YorhC04k6GXVefCP6kTF3b5R1erZJdSk8uOAPSkU33yXkhVH3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B2A1063;
	Mon,  2 Sep 2024 10:52:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC003F73B;
	Mon,  2 Sep 2024 10:52:16 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 4/8] perf/arm-cmn: Improve build-time assertion
Date: Mon,  2 Sep 2024 18:52:00 +0100
Message-Id: <224ee8286f299100f1c768edb254edc898539f50.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These days we can use static_assert() in the logical place rather than
jamming a BUILD_BUG_ON() into the nearest function scope.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Drop now-unnecessary dtm_idx check
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 48863b31ccfb..5b0edeb69394 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -581,6 +581,7 @@ struct arm_cmn_hw_event {
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
 };
+static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
 
 #define for_each_hw_dn(hw, dn, i) \
 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
@@ -591,7 +592,6 @@ struct arm_cmn_hw_event {
 
 static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
 {
-	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
 	return (struct arm_cmn_hw_event *)&event->hw;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty


