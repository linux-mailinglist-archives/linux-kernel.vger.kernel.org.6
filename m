Return-Path: <linux-kernel+bounces-443321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E669EED41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B08188D6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76269222D62;
	Thu, 12 Dec 2024 15:40:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7032210D6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018030; cv=none; b=LNcrLOYHTwRXZ6Kr8D9IV5zBkg9Xv06xxUU9vI9I0iW9NnAfoxnjzfKcMAer7UBdRLZ7Qhe6M4zZVktI8/ZRuzKpcxE+Liw/r6ppuHMT6w6fip0T6CGR5FkXN7K6QqE5J7b1Nh7zlx+143K4/PBuYSNGfj2bQDe/4RgH+X9qZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018030; c=relaxed/simple;
	bh=rzNle1V/OHkx+/HKOojlyyES5o3M0IeEjh41ufVnX8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNtO5XlLmZiVwywBoIsIE24l06mJPmtGX11ke0kfrvj+f4FvNlIa3SBr05duC7zgzyeu18m1qLxw0mJ9Sl7LL0SekgpPKKHCiLOsPHnKajUrBudTF3N5bzt9T+VyQKn5/r4Hpngqf+Koy0d+9mwRS5R4g9Z7XaugXHV+brOZo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A442A176A;
	Thu, 12 Dec 2024 07:40:55 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914683F720;
	Thu, 12 Dec 2024 07:40:26 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 2/6] arm_mpam: Fix read-back of cloned resource controls under CDP emulation
Date: Thu, 12 Dec 2024 15:39:56 +0000
Message-Id: <20241212154000.330467-3-Dave.Martin@arm.com>
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

When reading resource control values through a resctrl schemata
file, the index into the configuration array in the MPAM driver
is currently translated incorrectly.

This means that when resctrl is mounted with the "cdp" option, the
wrong array entry may be returned or an out-of-bounds array access
may occur when reading back of control values for the MB resource.

Fix it by translating the index for affected resources as if they
were "DATA" resources.  ("CODE" would also work, but because
resctrl_arch_update_one() clones schemata writes across "CODE" and
"DATA" for affected resources, it does not matter which one is
read.)

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

This issue was introduced by the non-upstream commit
"arm_mpam: resctrl: Improve CDP emulation"

(commit b097a6193546dbbd27cd19d7e16e1e750ebb030f in
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.12-rc1 )
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 76ddbce0ea9c..30f2caec11d7 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -1097,6 +1097,14 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_ctrl_dom);
 	cprops = &res->class->props;
 
+	/*
+	 * When CDP is enabled, but the resource doesn't support it,
+	 * the control is cloned across both partids.
+	 * Pick one at random to read:
+	 */
+	if (mpam_resctrl_hide_cdp(r->rid))
+		type = CDP_DATA;
+
 	partid = resctrl_get_config_index(closid, type);
 	cfg = &dom->comp->cfg[partid];
 
-- 
2.34.1


