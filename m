Return-Path: <linux-kernel+bounces-443322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964EE9EED3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86119164EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617B222D5F;
	Thu, 12 Dec 2024 15:40:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C68F21B8E1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018030; cv=none; b=OPb0pOYGXH44ORc9NCcXwELUshshTRVNdjEorJFYi29+pAM719GEICSpoT7zWdhIpdTOte/CeAWaRznTZr2J3t8yyqBsUAHnPcOIPaPkc73YjWaGyTy4roT2Nn1Q3j1VJoyW+u8eCbOy6javvDyLbcNqzNUtt3Hiv0bWds+fSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018030; c=relaxed/simple;
	bh=kVYLwPFzGbGALdaUwFDsYWIU755dwL4gKUOQoCbfOzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vojc2zZu5OpYJCITsAMZuQoR+lFH5C4+mRBg6Ss1e4NGOo92f3hS0CLkG+PW3qwmmg3EfGVDdz3WYguUtocmk2ucKuz9kzbG6EYDwymazNy545Q5ANXlz2P/r9bm1d4AlU5L9ffXHZR6h4GjIzgn9zXssToNsWSJOSOr412GoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5390B1764;
	Thu, 12 Dec 2024 07:40:54 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436303F720;
	Thu, 12 Dec 2024 07:40:25 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 1/6] arm_mpam: Clean up config update checks in mpam_apply_config()
Date: Thu, 12 Dec 2024 15:39:55 +0000
Message-Id: <20241212154000.330467-2-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212154000.330467-1-Dave.Martin@arm.com>
References: <20241212154000.330467-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mpam_apply_config(), a simple memcmp() test is used to check
whether the config passed by the caller is already installed or
not.

This check will never find a match except (very occasionally) by
accident, since the component's version of the struct contains
things that the caller won't pass or doesn't know (such as the
garbage collection record).  There might also be random padding.

This may result in MSCs being reprogrammed unnecessarily.

Instead, only compare fields that the caller specified.  If
anything is present in the caller's config and doesn't match the
installed config, paste it across.  If nothing was pasted across
then the MSC reprogramming step is skipped (as the previous code
attempted to do).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

There are comments in the code suggesting a change of this sort.
I may or may not have gone in the right direction with this, and
I have only tried to clean up the behaviour rather than optimising.

No attempt is made to skip unnecessary MSC register updates if the MSC
reprogramming goes ahead.

NOT well tested, yet.
---
 drivers/platform/arm64/mpam/mpam_devices.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 9463045c0011..41962dd1bb68 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -3120,6 +3120,29 @@ static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg
 	}
 }
 
+#define maybe_update_config(cfg, feature, newcfg, member, changes) do { \
+	if (mpam_has_feature(feature, newcfg) &&			\
+	    (newcfg)->member != (cfg)->member) {			\
+		(cfg)->member = (newcfg)->member;			\
+		mpam_set_feature(feature, cfg);				\
+									\
+		(changes) |= (feature);					\
+	}								\
+} while (0)
+
+static mpam_features_t mpam_update_config(struct mpam_config *cfg,
+					  const struct mpam_config *newcfg)
+{
+	mpam_features_t changes = 0;
+
+	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg, mbw_pbm, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max, changes);
+	maybe_update_config(cfg, mpam_feat_mbw_min, newcfg, mbw_min, changes);
+
+	return changes;
+}
+
 /* TODO: split into write_config/sync_config */
 /* TODO: add config_dirty bitmap to drive sync_config */
 int mpam_apply_config(struct mpam_component *comp, u16 partid,
-- 
2.34.1


