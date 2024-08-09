Return-Path: <linux-kernel+bounces-281454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1D94D712
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50F2281B65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B21684A2;
	Fri,  9 Aug 2024 19:15:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0815FD1B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230959; cv=none; b=S7c92wNoUKpyGl8dJhi7ZpWOZj7QyDJdvWvicoo/eIoPxPExOTncJAilnEYWFmGqRgvhA+SGRbp9nkdiX85uyGds+MpD/IbPNJJHIGFbb5UiC526FbzKJz9LeAJctWuqQNfx0YOolfuZCQ+2ska2TudvV2JxjeTHxNS8BXo3JK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230959; c=relaxed/simple;
	bh=34p9Gi/zWQHOYmvvEJpb/rWkbc7+TTqiOp2IDINoO+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WC9vfDlXc+Lye3DzV1GSyCR8zGWFAuoHVKwZk3V+vENzZD53GMGD7dorjmHTz6qF5QCvXlfW3lZ/MI7RoSFBJ5y1eiXothOogRDEdsLxlz3+cZ1MrJE/cUZxvXkRuegR6WbT7FYlBhUQlYu7r9FFsS9F9e4U8HU8UQGhsht+LqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307A313D5;
	Fri,  9 Aug 2024 12:16:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 952C13F71E;
	Fri,  9 Aug 2024 12:15:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 4/8] perf/arm-cmn: Improve build-time assertions
Date: Fri,  9 Aug 2024 20:15:43 +0100
Message-Id: <2aabebd619b65416a6cd2ca7058ca85fa3656958.1723229941.git.robin.murphy@arm.com>
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

These days we can use static_assert() in the logical place rather than
jamming a BUILD_BUG_ON() into the nearest function scope. And since it
is now so convenient to do so, let's add an extra one to reinforce the
dtm_idx bitmap as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c9a2b21a7aec..8f7a1a6f8ab7 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -577,6 +577,9 @@ struct arm_cmn_hw_event {
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
 };
+static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
+/* Currently XPs are the node type we can have most of; others top out at 128 */
+static_assert(sizeof_field(struct arm_cmn_hw_event, dtm_idx) >= CMN_MAX_XPS / 4);
 
 #define for_each_hw_dn(hw, dn, i) \
 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
@@ -587,7 +590,6 @@ struct arm_cmn_hw_event {
 
 static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
 {
-	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
 	return (struct arm_cmn_hw_event *)&event->hw;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty


