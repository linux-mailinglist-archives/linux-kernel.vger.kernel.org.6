Return-Path: <linux-kernel+bounces-368445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6B9A0FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701D31F21037
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74320F5C9;
	Wed, 16 Oct 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJRU/RY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118918595F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096528; cv=none; b=EYPNuf2BWyuzMyLpe0eEqfoQRTRUj/M6y2q1hyjr7+Vk1gf9VuG8VwxQ3elwZalCi1n9EwUICoexiM2HvNzVGXkH90CV+ZMVPOgNy5G1yPSoAnhw9lFITpdH5wyUVTHg/ve5JKnKMV5NcjJGIc6ymdJJm9cRjCAJMEWukgmGVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096528; c=relaxed/simple;
	bh=xQq0Gu1/184g2g6xFV3WcqC4CNTdIQoKIjOpPhROD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TucbO2gtpmmKy46zg0WzLVvIcZwECtbJi9x9Io1e24NjTragU7bg9rJy57xnwvS9tdAiBhF8fByAV1xZT3kIqizUkCh7hgH6us9OU7Ccf9NYSppbfYsjl9ZY0BmjR3i5BUCXIJipgj5hMFnUOaInP4UYoS28HxhH8bJO30P7nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJRU/RY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF3C4CEC5;
	Wed, 16 Oct 2024 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729096526;
	bh=xQq0Gu1/184g2g6xFV3WcqC4CNTdIQoKIjOpPhROD5I=;
	h=From:To:Cc:Subject:Date:From;
	b=rJRU/RY5UQS0DAAdRDWTYvYwWhAVmKki+yt5T1gorJRFCEWnjWjcw2muYX1FeOSMX
	 6BtXubCG1eAGeugnJ95N3TDXjopaOUajubXCEuXuY0Rowa1zcg3l5QMvcP0D0g85ll
	 /uOFpA6CfcDiHjTO1SVzkWX/GdYKIcPcwz75yEkcB633bSv4xjXcOfVB5piMiDp4+Z
	 q0Bg94iDm1LI4F+iKLUdSkYsEuWb3+Mc/UQ3NSod0F7ll+ivJv0V2VfUxhMyUJ3J5P
	 YBhgzkFLttpvTRBdj3x/2Z/CCoht4QmH7wq64lR68GRqLeiZwNg9VLqoDDDPp01Koo
	 Qd8uHKCCweG+A==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: conor@kernel.org,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] firmware: microchip: auto-update: fix poll_complete() to not report spurious timeout errors
Date: Wed, 16 Oct 2024 17:35:06 +0100
Message-ID: <20241016-slouching-excess-d7a62fc926a1@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4531; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WSvX+m0pqRh8gjGDfEkhMEeHIeJcOGQf4XyqLrnNqDk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOn8ry13Z36/WfNnI1vGsck5H62kbI5lujWvvB5gvvh3w Y/4X0xPO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRmysZGT59ntzuv/nbbvWj de95d5lGds7QeGHzdbtH5I2MO+tWxYsx/BW4yj+j/b6rhO2tCyJfTHYciEy7HCbtuajoh9Q32f+ 7vHkB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

fw_upload's poll_complete() is really intended for use with
asynchronous write() implementations - or at least those where the
write() loop may terminate without the kernel yet being aware of whether
or not the firmware upload has succeeded. For auto-update, write() is
only ever called once and will only return when uploading has completed,
be that by passing or failing. The core fw_upload code only calls
poll_complete() after the final call to write() has returned.

However, the poll_complete() implementation in the auto-update driver
was written to expect poll_complete() to be called from another context,
and it waits for a completion signalled from write(). Since
poll_complete() is actually called from the same context, after the
write() loop has terminated, wait_for_completion() never sees the
completion get signalled and always times out, causing programming to
always report a failing.

Since write() is full synchronous, and its return value will indicate
whether or not programming passed or failed, poll_complete() serves no
purpose and can be cut down to simply return FW_UPLOAD_ERR_NONE.

Fixes: ec5b0f1193ad4 ("firmware: microchip: add PolarFire SoC Auto Update support")
Reported-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 drivers/firmware/microchip/mpfs-auto-update.c | 42 ++++---------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 9ca5ee58edbdf..0f7ec88482022 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -76,14 +76,11 @@
 #define AUTO_UPDATE_INFO_SIZE		SZ_1M
 #define AUTO_UPDATE_BITSTREAM_BASE	(AUTO_UPDATE_DIRECTORY_SIZE + AUTO_UPDATE_INFO_SIZE)
 
-#define AUTO_UPDATE_TIMEOUT_MS		60000
-
 struct mpfs_auto_update_priv {
 	struct mpfs_sys_controller *sys_controller;
 	struct device *dev;
 	struct mtd_info *flash;
 	struct fw_upload *fw_uploader;
-	struct completion programming_complete;
 	size_t size_per_bitstream;
 	bool cancel_request;
 };
@@ -156,19 +153,6 @@ static void mpfs_auto_update_cancel(struct fw_upload *fw_uploader)
 
 static enum fw_upload_err mpfs_auto_update_poll_complete(struct fw_upload *fw_uploader)
 {
-	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
-	int ret;
-
-	/*
-	 * There is no meaningful way to get the status of the programming while
-	 * it is in progress, so attempting anything other than waiting for it
-	 * to complete would be misplaced.
-	 */
-	ret = wait_for_completion_timeout(&priv->programming_complete,
-					  msecs_to_jiffies(AUTO_UPDATE_TIMEOUT_MS));
-	if (!ret)
-		return FW_UPLOAD_ERR_TIMEOUT;
-
 	return FW_UPLOAD_ERR_NONE;
 }
 
@@ -349,33 +333,23 @@ static enum fw_upload_err mpfs_auto_update_write(struct fw_upload *fw_uploader,
 						 u32 offset, u32 size, u32 *written)
 {
 	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
-	enum fw_upload_err err = FW_UPLOAD_ERR_NONE;
 	int ret;
 
-	reinit_completion(&priv->programming_complete);
-
 	ret = mpfs_auto_update_write_bitstream(fw_uploader, data, offset, size, written);
-	if (ret) {
-		err = FW_UPLOAD_ERR_RW_ERROR;
-		goto out;
-	}
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
 
-	if (priv->cancel_request) {
-		err = FW_UPLOAD_ERR_CANCELED;
-		goto out;
-	}
+	if (priv->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
 
 	if (mpfs_auto_update_is_bitstream_info(data, size))
-		goto out;
+		return FW_UPLOAD_ERR_NONE;
 
 	ret = mpfs_auto_update_verify_image(fw_uploader);
 	if (ret)
-		err = FW_UPLOAD_ERR_FW_INVALID;
+		return FW_UPLOAD_ERR_FW_INVALID;
 
-out:
-	complete(&priv->programming_complete);
-
-	return err;
+	return FW_UPLOAD_ERR_NONE;
 }
 
 static const struct fw_upload_ops mpfs_auto_update_ops = {
@@ -461,8 +435,6 @@ static int mpfs_auto_update_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "The current bitstream does not support auto-update\n");
 
-	init_completion(&priv->programming_complete);
-
 	fw_uploader = firmware_upload_register(THIS_MODULE, dev, "mpfs-auto-update",
 					       &mpfs_auto_update_ops, priv);
 	if (IS_ERR(fw_uploader))
-- 
2.45.2


