Return-Path: <linux-kernel+bounces-190545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BE8CFFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70B5285828
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DC15EFCA;
	Mon, 27 May 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="WhXVwlkD"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02A15DBC0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811994; cv=none; b=iyslFOXxKkgUn0JULo166Wo5abZyFyNyY6vtQcDQmLUgj6+UoDAO+w9OwsvGYox65MQBRc+1P6GTz52KGrf9ux7QXof3ymA1WzbR8Us6XMIzbBRU5AgwMTAj47kIhpFjoACZieiZQxjPppSsuqWtXLgnKFar78uSiVWQ1Qlj4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811994; c=relaxed/simple;
	bh=w8EooheyDNYzk0b5wQ7asK4PXY81sD5/wVdKuo7m5AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTvsnR7kjHxtPZsgEIZxfGH5ZGgSrYYklVOAVfo4Y9qELfj0d71pzroV7bZTtHdpJGpGxJaztalkasO3uszTt8I5Q2Z+vBMAbiic4DEXIwJsHYAwtlhzH4LHHKz/I7xFrHjutMCsmTqeHrAWijc0qhBWmrviVFAaUbEnxn/s+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=WhXVwlkD; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811982; bh=w8EooheyDNYzk0b5wQ7asK4PXY81sD5/wVdKuo7m5AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhXVwlkDVTCSkIpOkx+Z8SzJ+JAEf2u2aJDj1mFbvSU1D5jive0u8eGX0Q5ACjW++
	 GzVj8m/iaeAJPTSAlrZYPWrBwvx22XrdAlL/ZlawD4Uy3OcDDUgB0VnTJAdihq+Gjq
	 qirrK2gVhSBFMjpX6JQMdGDTovm/ii9unK+DLFEzRCdjW6t32H3fbmjZu6Zq/kbWG7
	 DzWnOihtRLokhWFb4yUoPGPfOj/vowba/x1u12TqMnfQSFVNbq7fHlO3coel7Nf6WH
	 v9hMjeCX8EjIhmpVflVdTmkNRUPW2+TQ5vMNS8Ji78p/M+aDRQsIdT7D7jMXKbuWq1
	 WmltzRhbSSUBA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuat1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Ariel Suller <asuller@habana.ai>
Subject: [PATCH 3/8] accel/habanalabs/gaudi2: align interrupt names to table
Date: Mon, 27 May 2024 15:12:49 +0300
Message-Id: <20240527121254.1921306-3-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527121254.1921306-1-obitton@habana.ai>
References: <20240527121254.1921306-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ariel Suller <asuller@habana.ai>

when reporting tpc events, the dcore and tpc in dcore should
be reported and propagated, and not the generatl tpc number

Signed-off-by: Ariel Suller <asuller@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 .../gaudi2/gaudi2_async_ids_map_extended.h    | 150 +++++++++---------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
index 1db73923de62..82d639990cca 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
@@ -856,55 +856,55 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 	{ .fc_id = 412, .cpu_id = 84, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_HARD,
 		 .name = "PCIE_ADDR_DEC_ERR" },
 	{ .fc_id = 413, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC0_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC0_AXI_ERR_RSP" },
 	{ .fc_id = 414, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC1_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC1_AXI_ERR_RSP" },
 	{ .fc_id = 415, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC2_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC2_AXI_ERR_RSP" },
 	{ .fc_id = 416, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC3_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC3_AXI_ERR_RSP" },
 	{ .fc_id = 417, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC4_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC4_AXI_ERR_RSP" },
 	{ .fc_id = 418, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC5_AXI_ERR_RSP" },
+		 .name = "DCORE0_TPC5_AXI_ERR_RSP" },
 	{ .fc_id = 419, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC6_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC0_AXI_ERR_RSP" },
 	{ .fc_id = 420, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC7_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC1_AXI_ERR_RSP" },
 	{ .fc_id = 421, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC8_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC2_AXI_ERR_RSP" },
 	{ .fc_id = 422, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC9_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC3_AXI_ERR_RSP" },
 	{ .fc_id = 423, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC10_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC4_AXI_ERR_RSP" },
 	{ .fc_id = 424, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC11_AXI_ERR_RSP" },
+		 .name = "DCORE1_TPC5_AXI_ERR_RSP" },
 	{ .fc_id = 425, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC12_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC0_AXI_ERR_RSP" },
 	{ .fc_id = 426, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC13_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC1_AXI_ERR_RSP" },
 	{ .fc_id = 427, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC14_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC2_AXI_ERR_RSP" },
 	{ .fc_id = 428, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC15_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC3_AXI_ERR_RSP" },
 	{ .fc_id = 429, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC16_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC4_AXI_ERR_RSP" },
 	{ .fc_id = 430, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC17_AXI_ERR_RSP" },
+		 .name = "DCORE2_TPC5_AXI_ERR_RSP" },
 	{ .fc_id = 431, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC18_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC0_AXI_ERR_RSP" },
 	{ .fc_id = 432, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC19_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC1_AXI_ERR_RSP" },
 	{ .fc_id = 433, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC20_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC2_AXI_ERR_RSP" },
 	{ .fc_id = 434, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC21_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC3_AXI_ERR_RSP" },
 	{ .fc_id = 435, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC22_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC4_AXI_ERR_RSP" },
 	{ .fc_id = 436, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC23_AXI_ERR_RSP" },
+		 .name = "DCORE3_TPC5_AXI_ERR_RSP" },
 	{ .fc_id = 437, .cpu_id = 85, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC24_AXI_ERR_RSP" },
+		 .name = "DCORE4_TPC0_AXI_ERR_RSP" },
 	{ .fc_id = 438, .cpu_id = 86, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_HARD,
 		 .name = "AXI_ECC" },
 	{ .fc_id = 439, .cpu_id = 87, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_HARD,
@@ -1298,103 +1298,103 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 	{ .fc_id = 633, .cpu_id = 130, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC0_BMON_SPMU" },
 	{ .fc_id = 634, .cpu_id = 131, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC0_KERNEL_ERR" },
+		 .name = "DCORE0_TPC0_KERNEL_ERR" },
 	{ .fc_id = 635, .cpu_id = 132, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC1_BMON_SPMU" },
 	{ .fc_id = 636, .cpu_id = 133, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC1_KERNEL_ERR" },
+		 .name = "DCORE0_TPC1_KERNEL_ERR" },
 	{ .fc_id = 637, .cpu_id = 134, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC2_BMON_SPMU" },
 	{ .fc_id = 638, .cpu_id = 135, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC2_KERNEL_ERR" },
+		 .name = "DCORE0_TPC2_KERNEL_ERR" },
 	{ .fc_id = 639, .cpu_id = 136, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC3_BMON_SPMU" },
 	{ .fc_id = 640, .cpu_id = 137, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC3_KERNEL_ERR" },
+		 .name = "DCORE0_TPC3_KERNEL_ERR" },
 	{ .fc_id = 641, .cpu_id = 138, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC4_BMON_SPMU" },
 	{ .fc_id = 642, .cpu_id = 139, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC4_KERNEL_ERR" },
+		 .name = "DCORE0_TPC4_KERNEL_ERR" },
 	{ .fc_id = 643, .cpu_id = 140, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC5_BMON_SPMU" },
 	{ .fc_id = 644, .cpu_id = 141, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC5_KERNEL_ERR" },
+		 .name = "DCORE0_TPC5_KERNEL_ERR" },
 	{ .fc_id = 645, .cpu_id = 150, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC6_BMON_SPMU" },
 	{ .fc_id = 646, .cpu_id = 151, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC6_KERNEL_ERR" },
+		 .name = "DCORE1_TPC0_KERNEL_ERR" },
 	{ .fc_id = 647, .cpu_id = 152, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC7_BMON_SPMU" },
 	{ .fc_id = 648, .cpu_id = 153, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC7_KERNEL_ERR" },
+		 .name = "DCORE1_TPC1_KERNEL_ERR" },
 	{ .fc_id = 649, .cpu_id = 146, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC8_BMON_SPMU" },
 	{ .fc_id = 650, .cpu_id = 147, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC8_KERNEL_ERR" },
+		 .name = "DCORE1_TPC2_KERNEL_ERR" },
 	{ .fc_id = 651, .cpu_id = 148, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC9_BMON_SPMU" },
 	{ .fc_id = 652, .cpu_id = 149, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC9_KERNEL_ERR" },
+		 .name = "DCORE1_TPC3_KERNEL_ERR" },
 	{ .fc_id = 653, .cpu_id = 142, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC10_BMON_SPMU" },
 	{ .fc_id = 654, .cpu_id = 143, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC10_KERNEL_ERR" },
+		 .name = "DCORE1_TPC4_KERNEL_ERR" },
 	{ .fc_id = 655, .cpu_id = 144, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC11_BMON_SPMU" },
 	{ .fc_id = 656, .cpu_id = 145, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC11_KERNEL_ERR" },
+		 .name = "DCORE1_TPC5_KERNEL_ERR" },
 	{ .fc_id = 657, .cpu_id = 162, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC12_BMON_SPMU" },
 	{ .fc_id = 658, .cpu_id = 163, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC12_KERNEL_ERR" },
+		 .name = "DCORE2_TPC0_KERNEL_ERR" },
 	{ .fc_id = 659, .cpu_id = 164, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC13_BMON_SPMU" },
 	{ .fc_id = 660, .cpu_id = 165, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC13_KERNEL_ERR" },
+		 .name = "DCORE2_TPC1_KERNEL_ERR" },
 	{ .fc_id = 661, .cpu_id = 158, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC14_BMON_SPMU" },
 	{ .fc_id = 662, .cpu_id = 159, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC14_KERNEL_ERR" },
+		 .name = "DCORE2_TPC2_KERNEL_ERR" },
 	{ .fc_id = 663, .cpu_id = 160, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC15_BMON_SPMU" },
 	{ .fc_id = 664, .cpu_id = 161, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC15_KERNEL_ERR" },
+		 .name = "DCORE2_TPC3_KERNEL_ERR" },
 	{ .fc_id = 665, .cpu_id = 154, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC16_BMON_SPMU" },
 	{ .fc_id = 666, .cpu_id = 155, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC16_KERNEL_ERR" },
+		 .name = "DCORE2_TPC4_KERNEL_ERR" },
 	{ .fc_id = 667, .cpu_id = 156, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC17_BMON_SPMU" },
 	{ .fc_id = 668, .cpu_id = 157, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC17_KERNEL_ERR" },
+		 .name = "DCORE2_TPC5_KERNEL_ERR" },
 	{ .fc_id = 669, .cpu_id = 166, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC18_BMON_SPMU" },
 	{ .fc_id = 670, .cpu_id = 167, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC18_KERNEL_ERR" },
+		 .name = "DCORE3_TPC0_KERNEL_ERR" },
 	{ .fc_id = 671, .cpu_id = 168, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC19_BMON_SPMU" },
 	{ .fc_id = 672, .cpu_id = 169, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC19_KERNEL_ERR" },
+		 .name = "DCORE3_TPC1_KERNEL_ERR" },
 	{ .fc_id = 673, .cpu_id = 170, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC20_BMON_SPMU" },
 	{ .fc_id = 674, .cpu_id = 171, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC20_KERNEL_ERR" },
+		 .name = "DCORE3_TPC2_KERNEL_ERR" },
 	{ .fc_id = 675, .cpu_id = 172, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC21_BMON_SPMU" },
 	{ .fc_id = 676, .cpu_id = 173, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC21_KERNEL_ERR" },
+		 .name = "DCORE3_TPC3_KERNEL_ERR" },
 	{ .fc_id = 677, .cpu_id = 174, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC22_BMON_SPMU" },
 	{ .fc_id = 678, .cpu_id = 175, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC22_KERNEL_ERR" },
+		 .name = "DCORE3_TPC4_KERNEL_ERR" },
 	{ .fc_id = 679, .cpu_id = 176, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC23_BMON_SPMU" },
 	{ .fc_id = 680, .cpu_id = 177, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC23_KERNEL_ERR" },
+		 .name = "DCORE3_TPC5_KERNEL_ERR" },
 	{ .fc_id = 681, .cpu_id = 178, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC24_BMON_SPMU" },
 	{ .fc_id = 682, .cpu_id = 179, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC24_KERNEL_ERR" },
+		 .name = "DCORE4_TPC0_KERNEL_ERR" },
 	{ .fc_id = 683, .cpu_id = 180, .valid = 0, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "" },
 	{ .fc_id = 684, .cpu_id = 180, .valid = 0, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
@@ -2442,55 +2442,55 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 	{ .fc_id = 1205, .cpu_id = 511, .valid = 0, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "" },
 	{ .fc_id = 1206, .cpu_id = 512, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC0_QM" },
+		 .name = "DCORE0_TPC0_QM" },
 	{ .fc_id = 1207, .cpu_id = 513, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC1_QM" },
+		 .name = "DCORE0_TPC1_QM" },
 	{ .fc_id = 1208, .cpu_id = 514, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC2_QM" },
+		 .name = "DCORE0_TPC2_QM" },
 	{ .fc_id = 1209, .cpu_id = 515, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC3_QM" },
+		 .name = "DCORE0_TPC3_QM" },
 	{ .fc_id = 1210, .cpu_id = 516, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC4_QM" },
+		 .name = "DCORE0_TPC4_QM" },
 	{ .fc_id = 1211, .cpu_id = 517, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC5_QM" },
+		 .name = "DCORE0_TPC5_QM" },
 	{ .fc_id = 1212, .cpu_id = 518, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC6_QM" },
+		 .name = "DCORE1_TPC0_QM" },
 	{ .fc_id = 1213, .cpu_id = 519, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC7_QM" },
+		 .name = "DCORE1_TPC1_QM" },
 	{ .fc_id = 1214, .cpu_id = 520, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC8_QM" },
+		 .name = "DCORE1_TPC2_QM" },
 	{ .fc_id = 1215, .cpu_id = 521, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC9_QM" },
+		 .name = "DCORE1_TPC3_QM" },
 	{ .fc_id = 1216, .cpu_id = 522, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC10_QM" },
+		 .name = "DCORE1_TPC4_QM" },
 	{ .fc_id = 1217, .cpu_id = 523, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC11_QM" },
+		 .name = "DCORE1_TPC5_QM" },
 	{ .fc_id = 1218, .cpu_id = 524, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC12_QM" },
+		 .name = "DCORE2_TPC0_QM" },
 	{ .fc_id = 1219, .cpu_id = 525, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC13_QM" },
+		 .name = "DCORE2_TPC1_QM" },
 	{ .fc_id = 1220, .cpu_id = 526, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC14_QM" },
+		 .name = "DCORE2_TPC2_QM" },
 	{ .fc_id = 1221, .cpu_id = 527, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC15_QM" },
+		 .name = "DCORE2_TPC3_QM" },
 	{ .fc_id = 1222, .cpu_id = 528, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC16_QM" },
+		 .name = "DCORE2_TPC4_QM" },
 	{ .fc_id = 1223, .cpu_id = 529, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC17_QM" },
+		 .name = "DCORE2_TPC5_QM" },
 	{ .fc_id = 1224, .cpu_id = 530, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC18_QM" },
+		 .name = "DCORE3_TPC0_QM" },
 	{ .fc_id = 1225, .cpu_id = 531, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC19_QM" },
+		 .name = "DCORE3_TPC1_QM" },
 	{ .fc_id = 1226, .cpu_id = 532, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC20_QM" },
+		 .name = "DCORE3_TPC2_QM" },
 	{ .fc_id = 1227, .cpu_id = 533, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC21_QM" },
+		 .name = "DCORE3_TPC3_QM" },
 	{ .fc_id = 1228, .cpu_id = 534, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC22_QM" },
+		 .name = "DCORE3_TPC4_QM" },
 	{ .fc_id = 1229, .cpu_id = 535, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC23_QM" },
+		 .name = "DCORE3_TPC5_QM" },
 	{ .fc_id = 1230, .cpu_id = 536, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-		 .name = "TPC24_QM" },
+		 .name = "DCORE4_TPC0_QM" },
 	{ .fc_id = 1231, .cpu_id = 537, .valid = 0, .msg = 1, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "" },
 	{ .fc_id = 1232, .cpu_id = 538, .valid = 1, .msg = 1, .reset = EVENT_RESET_TYPE_COMPUTE,
-- 
2.34.1


