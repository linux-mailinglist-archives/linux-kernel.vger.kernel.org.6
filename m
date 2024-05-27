Return-Path: <linux-kernel+bounces-190542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2818CFFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1671A2840FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C915E5DB;
	Mon, 27 May 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="LcQCWYKU"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD615DBC7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811994; cv=none; b=fu1P7VGlIYX/7VVQhOJ0CQwVGO84i/hwjy3tcSzS8YTJMbfuNDvhx/CEkaiBPdILXM8CxnTYvmwfl71Ak8btW/Q9QKEKU1mC9TvSivKBHTj3MpfaoIBAfyYDausNK99bkfbtWP5zq/6lUeO3qBlOhF6oSFxFBp1+cms1qv6qz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811994; c=relaxed/simple;
	bh=6fkm+Ekorc42aQ0DgvCRfc8pbcF22Uheaaz/c06hl/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xi8cUKB9Puw5LIM2GEijOxELy00sKaTFB3+QT317VLoH7j1ZAxF0L0MotA3tj6BRtHjYVO1ArbhUZThX+QKtbgGGOmZo4TJRY5sdB/rNBfnT2UKisp7UgLb2ZJ6EAwAtbZnhw+D4XlxUm+u2PwAERR6rdcTMqNxuSGSafv2E5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=LcQCWYKU; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811993; bh=6fkm+Ekorc42aQ0DgvCRfc8pbcF22Uheaaz/c06hl/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcQCWYKUKob8FxyRRMksHjTJjtqkXFFJhp0EEZg6JpkjOSenDkGStR7NJby89TSSW
	 TZanMV8UbA1hd9R1uTK620Eodt+tA4htDm3++AatDc1Idwd/T5a9c+ecMIaVvDEQzM
	 6OUfr9X5A+ubbdKNT5hJNMwaDCWF44tzGAreq4dO9r/fDNVI5YZdfuoOJnZNt2Ezxt
	 xwtjGmr67clZlMO39sCnM+l6YHT4GSFHgonr1XWW6qpKog+M3hcpwVv9fAJK0ryIfo
	 AebwE8OVcR7ZaAto8gIq2gQcS9APkf/mdB/5YdF0tLI1185ouPvO8nYq8t/55TyW7F
	 r2/HVYSqr0qQg==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuas1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/8] accel/habanalabs: check for errors after preboot is ready
Date: Mon, 27 May 2024 15:12:48 +0300
Message-Id: <20240527121254.1921306-2-obitton@habana.ai>
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

From: Farah Kassabri <fkassabri@habana.ai>

Driver should check and report any fatal errors detected by preboot,
before it attempts to load the boot fit.
Some errors may cause the driver to stop the boot process and mark
the device as unusable.
This check will allow the driver to fail and print the error reported
by preboot and skip the time wasting attempt of trying to load the
boot fit, which will fail due to the error.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/firmware_if.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 886b3c07503d..6f0c40b12072 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -1482,7 +1482,7 @@ int hl_fw_wait_preboot_ready(struct hl_device *hdev)
 {
 	struct pre_fw_load_props *pre_fw_load = &hdev->fw_loader.pre_fw_load;
 	u32 status = 0, timeout;
-	int rc, tries = 1;
+	int rc, tries = 1, fw_err = 0;
 	bool preboot_still_runs;
 
 	/* Need to check two possible scenarios:
@@ -1522,18 +1522,18 @@ int hl_fw_wait_preboot_ready(struct hl_device *hdev)
 		}
 	}
 
-	if (rc) {
+	/* If we read all FF, then something is totally wrong, no point
+	 * of reading specific errors
+	 */
+	if (status != -1)
+		fw_err = fw_read_errors(hdev, pre_fw_load->boot_err0_reg,
+					pre_fw_load->boot_err1_reg,
+					pre_fw_load->sts_boot_dev_sts0_reg,
+					pre_fw_load->sts_boot_dev_sts1_reg);
+	if (rc || fw_err) {
 		detect_cpu_boot_status(hdev, status);
-		dev_err(hdev->dev, "CPU boot ready timeout (status = %d)\n", status);
-
-		/* If we read all FF, then something is totally wrong, no point
-		 * of reading specific errors
-		 */
-		if (status != -1)
-			fw_read_errors(hdev, pre_fw_load->boot_err0_reg,
-						pre_fw_load->boot_err1_reg,
-						pre_fw_load->sts_boot_dev_sts0_reg,
-						pre_fw_load->sts_boot_dev_sts1_reg);
+		dev_err(hdev->dev, "CPU boot %s (status = %d)\n",
+				fw_err ? "failed due to an error" : "ready timeout", status);
 		return -EIO;
 	}
 
-- 
2.34.1


