Return-Path: <linux-kernel+bounces-190538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB48CFFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36BF1F21D87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B21B15E5A5;
	Mon, 27 May 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="OjZ20Tx9"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AE1581E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811992; cv=none; b=Z9CXic49GomggwOMNSGgszGo5T3eFH6rrKoxV2hOguIyxpjSJ1YS4+J9yU89y0z1ORQU6chPnaimfAquRArNRixlrt1GRP8zhBLLeqw0bzh8a8aVy4JChUjnIISk3eKq71qujVhYQ3163LUn8S76UPZJoNVEKg8OcenamQhyakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811992; c=relaxed/simple;
	bh=Gweql/mYSZp0D9OIhCBaIAviu0sxLWqrmSCFgLSuNRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bt36olA/howoextuXLInSWkzeWMxgnmU7YZYxbVBr8fKq6Ia0s4kr/O6xYskTyVhRLjDBCxt9L1RoO4DKgBrzvyixT+ELKjICMD0GoklFC6EOjp6385Z8wiHBbXlkSrSU3E/c4f0BHNoWCrNY9Ai+QFbr+6inOD3j20zhmBPnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=OjZ20Tx9; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811982; bh=Gweql/mYSZp0D9OIhCBaIAviu0sxLWqrmSCFgLSuNRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjZ20Tx90j0hd7nl5hmcrPTat70TO6SQ6WRyUe6FE8V4QbtQ+zPbYRUKkPQw65Csi
	 gcg4qB6ZAwSrP/Alh64/jfqXDyJ4yfvQCjOANI1r+71rAjaIObEutwwHBg19qTFK3n
	 lyTknEjr8h+j0afti7ZrFFKNszw2z4NqwuMfzDQReNNIV19Imtzqia0coAB3NLcwtN
	 y7yCqrz1taeQw+GTKOlalQUWmJmtILAHnSL+2h4DdgnGO8YkewnACP6PaUHRJC+ZQw
	 KbNAuuX17u6nH66jXOSPT10sKHs7yZoKLBUcYJ0vIbxZXdQ6B+c/MAxGG7QxyYhfD5
	 YIGxQVkExws8A==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuav1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 5/8] accel/habanalabs/gaudi2: assume hard-reset by FW upon MC SEI severe error
Date: Mon, 27 May 2024 15:12:51 +0300
Message-Id: <20240527121254.1921306-5-obitton@habana.ai>
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

From: Tomer Tayar <ttayar@habana.ai>

FW initiates a hard reset upon an MC SEI severe error.
Align the driver to expect this reset and avoid accessing the device
until the reset is done.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 18cc7b773650..4791582d157c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10004,6 +10004,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		if (gaudi2_handle_hbm_mc_sei_err(hdev, event_type, &eq_entry->sei_data)) {
 			reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 			reset_required = true;
+			is_critical = eq_entry->sei_data.hdr.is_critical;
 		}
 		error_count++;
 		break;
@@ -10235,8 +10236,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		gaudi2_print_event(hdev, event_type, true,
 				"No error cause for H/W event %u", event_type);
 
-	if ((gaudi2_irq_map_table[event_type].reset != EVENT_RESET_TYPE_NONE) ||
-				reset_required) {
+	if ((gaudi2_irq_map_table[event_type].reset != EVENT_RESET_TYPE_NONE) || reset_required) {
 		if (reset_required ||
 				(gaudi2_irq_map_table[event_type].reset == EVENT_RESET_TYPE_HARD))
 			reset_flags |= HL_DRV_RESET_HARD;
-- 
2.34.1


