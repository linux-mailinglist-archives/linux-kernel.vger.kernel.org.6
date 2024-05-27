Return-Path: <linux-kernel+bounces-191032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B38D05C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F9E28538F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245716C85E;
	Mon, 27 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="Y6/M1a2h"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E416C6B3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822161; cv=none; b=m3AHSw4n8AxyjNOcxV/AkgsqlW9eM9DdRIeuzC/bcqXGZj/RTnwQnx/SotS5E9dpB+jepOlpMP6PycvG6k6wwRtv5O23L7ofIA+LoVDuWn4jNeNzbUThtW5qx7YRvCNTzP1V3SwDP9zBubL6occMlGoRDoWURJU6fpsmvoggYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822161; c=relaxed/simple;
	bh=PZJIzad51lipFAHvPkTrc6zNNzNFwz6JZWAXDJXz+zs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRfGCyimZZcf6kLGMw7rmyy+CfX+hupW5uW4358yfRwRpU1XglL5L6qss8MlhNJvE+rmtQTWq1e5IqSUp3P6PNqCy33GzEHu3OJ7vuNpsKYajcG7OAd+RbvpoIQgnsqxxFkagV2aZN3nQMDRlXqE8LIUodMWU8n1fO+KHA1+1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=Y6/M1a2h; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822162; bh=PZJIzad51lipFAHvPkTrc6zNNzNFwz6JZWAXDJXz+zs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y6/M1a2hlOV2P5yxkk35EU6rN/XFtO/V97JMUNWgiA/gJKKCcCNrU8ca+gPJwyy+V
	 +1V1Y0jTNnq7HMgpGM5GtdNqU/UQOjCeEofq2EpSYRlAA/Ycge5icZ+b8J+X+x4ZOE
	 P/zKT5ucAvX9q1cMP8ASyOYA7MuDkzSgrB6teOjOjPuShV4h1CNMQfW9BELTpRjxgF
	 4WfLy0JO1TJJ/l/TbE+W2uZlMPM48NiYT6kS5GSXpiJlCVW5rGNNblZICjbAwcbc7c
	 IVuYEiqLlzvTxXNyjFUF+/APB/n6dr+hmVtZk4UeUPjaXvLNIdJh6JRwUL7IKiLXJx
	 3KnylbaNzhEQg==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiW1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] accel/habanalabs: remove timestamp registration debug prints
Date: Mon, 27 May 2024 18:02:21 +0300
Message-Id: <20240527150224.1953969-5-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several timestamp registration debug prints which
spams the kernel log whenever dyn debug is enabled.
Remove those prints.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
---
 .../accel/habanalabs/common/command_submission.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 39e23d625a3c..59823e3c3bf7 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -3284,12 +3284,6 @@ static int ts_get_and_handle_kernel_record(struct hl_device *hdev, struct hl_ctx
 
 	/* In case the node already registered, need to unregister first then re-use */
 	if (req_offset_record->ts_reg_info.in_use) {
-		dev_dbg(data->buf->mmg->dev,
-				"Requested record %p is in use on irq: %u ts addr: %p, unregister first then put on irq: %u\n",
-				req_offset_record,
-				req_offset_record->ts_reg_info.interrupt->interrupt_id,
-				req_offset_record->ts_reg_info.timestamp_kernel_addr,
-				data->interrupt->interrupt_id);
 		/*
 		 * Since interrupt here can be different than the one the node currently registered
 		 * on, and we don't want to lock two lists while we're doing unregister, so
@@ -3345,10 +3339,6 @@ static int _hl_interrupt_ts_reg_ioctl(struct hl_device *hdev, struct hl_ctx *ctx
 		goto put_cq_cb;
 	}
 
-	dev_dbg(hdev->dev, "Timestamp registration: interrupt id: %u, handle: 0x%llx, ts offset: %llu, cq_offset: %llu\n",
-					data->interrupt->interrupt_id, data->ts_handle,
-					data->ts_offset, data->cq_offset);
-
 	data->buf = hl_mmap_mem_buf_get(data->mmg, data->ts_handle);
 	if (!data->buf) {
 		rc = -EINVAL;
@@ -3370,9 +3360,6 @@ static int _hl_interrupt_ts_reg_ioctl(struct hl_device *hdev, struct hl_ctx *ctx
 	if (*pend->cq_kernel_addr >= data->target_value) {
 		spin_unlock_irqrestore(&data->interrupt->ts_list_lock, flags);
 
-		dev_dbg(hdev->dev, "Target value already reached release ts record: pend: %p, offset: %llu, interrupt: %u\n",
-				pend, data->ts_offset, data->interrupt->interrupt_id);
-
 		pend->ts_reg_info.in_use = 0;
 		*status = HL_WAIT_CS_STATUS_COMPLETED;
 		*pend->ts_reg_info.timestamp_kernel_addr = ktime_get_ns();
-- 
2.34.1


