Return-Path: <linux-kernel+bounces-190500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519138CFF48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DB21C22318
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594C15DBB6;
	Mon, 27 May 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="kksWOI0+"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670815ECDF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810520; cv=none; b=j7DBh9rrhowZ+vdWdljReRvacJH2DQ1fYzeCWkm8qidn1EbbhVCq8SKt6ihXMEuv5iCt7EqmTnuAWix7My63rWJT/9LUrzg0411DhGX2vpfQKyW8eaeSQ6VaIHdeCSkXqZa0NkzCyKnVh1mr3/j4d/UR2Ceju8iIEGCIcOiK7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810520; c=relaxed/simple;
	bh=pXheFYeAWfi+J/oHigZFL4ImqWPHDuO3tD3An/fuwbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4riCJFAzrHE/USxOop4GtF8lkgLbhQrgt6qmpGtAClXl9dpxwouqJ88XiNLvTTttmpVgUFNNSGA/fiBU8Z96+qQgiXEif5kKxupQadpTc83Lrya0fp7kZcyV08PO/p0se1Cc/syCuGz2h604DRgYusxjAYhhB+WUlPRSYmuUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=kksWOI0+; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810492; bh=pXheFYeAWfi+J/oHigZFL4ImqWPHDuO3tD3An/fuwbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kksWOI0+lODuu7gon+aY5FVIRM6zlYgSD/dXWUpWYaF5BKIMaW/A0N0nM1CdejpMa
	 obTxpSrIYEkJToFjUfEipDx+gFGVs+pWfCwrTrOimwiwPQsmlQPa50ATEerFn+KZ/v
	 jEfxbCtPftQ7WGRfIHmDLNjAScPRWrJin/ARvnSymg+7uvIqpsu/90n/pVHN5Vu2gj
	 9s483rN/xP0CqlUFEDqiJwchacB3glQhpns4rXESAH7gix6B//PKMu/7y0HLmlYiM3
	 h5kyEPO6B5Ub31+0znDFn3IlAA/u//ZMdr95YIOaQ7xmusqpLqUxez/BSZexGTNGXl
	 sEEj2W6VRWuGw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNl1919357;
	Mon, 27 May 2024 14:47:55 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tal Risin <trisin@habana.ai>
Subject: [PATCH 7/9] accel/habanalabs: expose server type in debugfs
Date: Mon, 27 May 2024 14:47:44 +0300
Message-Id: <20240527114746.1919292-7-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527114746.1919292-1-obitton@habana.ai>
References: <20240527114746.1919292-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tal Risin <trisin@habana.ai>

Exposing server type through debugfs to enable easier access via
scripts.

Signed-off-by: Tal Risin <trisin@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 6 ++++++
 drivers/accel/habanalabs/common/debugfs.c           | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index a7a432dc4015..efbb78bedb8b 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -253,6 +253,12 @@ Description:    Triggers dump of monitor data. The value to trigger the operatio
                 When the write is finished, the user can read the "monitor_dump"
                 blob
 
+What:           /sys/kernel/debug/accel/<parent_device>/server_type
+Date:           Feb 2024
+KernelVersion:  6.11
+Contact:        trisin@habana.ai
+Description:    Exposes the device's server type, maps to enum hl_server_type.
+
 What:           /sys/kernel/debug/accel/<parent_device>/set_power_state
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index de3ae2e47ec4..ca7677293a55 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -1717,6 +1717,11 @@ static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_ent
 				root,
 				&hdev->device_release_watchdog_timeout_sec);
 
+	debugfs_create_u16("server_type",
+				0444,
+				root,
+				&hdev->asic_prop.server_type);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0644,
-- 
2.34.1


