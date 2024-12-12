Return-Path: <linux-kernel+bounces-443324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C09EED49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C266E16766C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12E223C53;
	Thu, 12 Dec 2024 15:40:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D682236EB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018034; cv=none; b=Dk9nUoX6btcRptQm2zVgzV4rI8ZfzR73pBjvTHXXJE6mIqZQanqMyAPdVzOQlagpzP9YiVRvm4jBkdHfZrh3+fqegY2C8OEsLsesgpkcczDdxCbrIup4MKPsMZLW3YV06DlW9Ori57CzLchtk18DaXcuXp7U+pRAeHAoJAlc0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018034; c=relaxed/simple;
	bh=1SattFhb8elVsyymfvSHs2B637H3W9ty17P292w4rXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bC7/sgrib46siCEDT6jZjl6cXoioSdmqFcunJSP/UQLbrV59EQAr4BMu+zy4Zh/dWqj/P7ha/JTlWLrN4QfeTh2DHzn7P93GRNdhxE7IeW8fhMmo1Bp0GmiayRiyaWiS/oZAeuIzj6sM5f2GXBo6D9yBcM9ffaDdo1OT9jI7e3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA241762;
	Thu, 12 Dec 2024 07:40:59 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2513F720;
	Thu, 12 Dec 2024 07:40:30 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 5/6] arm_mpam: [NFU] Rework ID remapping to use a kernel command-line argument
Date: Thu, 12 Dec 2024 15:39:59 +0000
Message-Id: <20241212154000.330467-6-Dave.Martin@arm.com>
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

Hacking the source is an acceptable interface for experimentation,
but not very convenient.

Instead, add a kernel command-line parameter
mpam_partid_per_closid=<n> to specify how many PARTIDs are used to
provide monitoring groups for each resctrl CLOSID.

This change is not intended for upstream.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 0473286ec65a..870efbf39f6f 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -3,6 +3,9 @@
 
 #define pr_fmt(fmt) "mpam: resctrl: " fmt
 
+#undef KBUILD_MODNAME
+#define KBUILD_MODNAME "mpam"
+
 #include <linux/arm_mpam.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
@@ -10,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/list.h>
+#include <linux/moduleparam.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/resctrl.h>
@@ -158,6 +162,24 @@ static bool mpam_resctrl_hide_cdp(enum resctrl_res_level rid)
 
 static unsigned int partid_per_closid = 1;
 
+static int mpam_resctrl_partid_per_closid_set(const char *val,
+					      const struct kernel_param *kp)
+{
+	/*
+	 * 16 in an arbitrary maximum, sufficient for experimentation
+	 * but not ridiculously large:
+	 */
+	return param_set_uint_minmax(val, kp, 1, 16);
+}
+
+static const struct kernel_param_ops mpam_resctrl_partid_per_closid_ops  = {
+	.set = mpam_resctrl_partid_per_closid_set,
+	.get = param_get_uint,
+};
+
+device_param_cb(partid_per_closid, &mpam_resctrl_partid_per_closid_ops,
+		&partid_per_closid, 0444);
+
 static unsigned int mpam_num_pmg(void)
 {
 	return mpam_pmg_max + 1;
-- 
2.34.1


