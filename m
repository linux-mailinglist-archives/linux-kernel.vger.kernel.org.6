Return-Path: <linux-kernel+bounces-280978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4494D18F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1001C20CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1739B19581F;
	Fri,  9 Aug 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjG6PaWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1781922FE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211325; cv=none; b=gYyLcVljaoDWq9mNHsuSv17WY9aJLwLV1c/NaGxOI9MDXaR7r7Kc+XfjuxWYmFJMWK6kVXE0sRBhjJfH0hGKovdNxSdII4TtwfrTjQahCsogs/L8qSWsTCE2PcLV5AAQPTlc3U5uusHIJ0llfQc9umu5Kl5JWHhVVPnkIIwxke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211325; c=relaxed/simple;
	bh=A0tSM4oCvTNgFrKON+QtYT6MsGmLeuf7Q3DHmwARVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5W7Kn5rSZXDYtPsBS+1W08ycOQ1kK+WESdpdjV3y/I9fDqGvXd+UqFoMTgBFv4Zw0NfYa8rycRP0T6VQnH4UcnL5spk97b+8Uo7Hch+d0UNUjjGAdH6dOFjqvXo81hveMIN5PVpZ/z2Nr5OOyLzxsh0cO4MUvsf80VjBf3j2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjG6PaWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F77C32782;
	Fri,  9 Aug 2024 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723211325;
	bh=A0tSM4oCvTNgFrKON+QtYT6MsGmLeuf7Q3DHmwARVoI=;
	h=From:To:Cc:Subject:Date:From;
	b=tjG6PaWdPJzIm1y+GxAZWS4tJQ3MYEjkBcJyoEloNotFiP7N4LqJHrcBzQ61oYv4K
	 aRh0Un29gg9pJIJ68VF8ZQvEs3uQchMqsrZj2t+WdBJllzuU/tqzazKNM5NAnPAW/z
	 xZmgR5qkC0fTZOpjIM8SYiUaNnLaEqAkAfBtKymSzIO4hmyMoUB7syVW87+vLEq36i
	 ev8UJ8i7O57Q3Mnh8JwLAXG+ZTJBWuLozjj1gIGeq8qkpyz+3HeZituicddVrWNuOw
	 PIjUeNBNlVAQxk488ewwHtM56oF0YdI7nTZeE2hhsa/UNvBUtfrQM2KdHVuxIxqyN2
	 RCXwjTZYyKovg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Steve Wilkins <steve.wilkins@raymarine.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1] firmware: microchip: fix incorrect error report of programming:timeout on success
Date: Fri,  9 Aug 2024 14:47:44 +0100
Message-ID: <20240809-acclimate-droplet-9a782ab70193@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TWS+/+h21GGCByux8yD5HcPxtxziLmECdkjzPNrD1Xk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnbZP9vFdbiaIpnutLWpffgiY6nrziza5PVgXn7piRPr GJcttqoo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPpn8HwV+z3/a56DenYV5u3 i8xnWWEWtOFo383Xr1fkXfNXnG1w7hPD/zq/C62yIXqzXk7+oej7nMtPZqGtT1bbND3xVUcvqfz fwgEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Steve Wilkins <steve.wilkins@raymarine.com>

After successfully programming the SPI flash with an MFPS auto update
image, the error sysfs attribute reports programming:timeout.
This is caused by an incorrect check on the return value from
wait_for_completion_timeout() in mpfs_auto_update_poll_complete().

Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Update support")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I took the liberty of converting if (ret == 0) to if (!ret).
---
 drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 30de47895b1c..9ca5ee58edbd 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -166,7 +166,7 @@ static enum fw_upload_err mpfs_auto_update_poll_complete(struct fw_upload *fw_up
 	 */
 	ret = wait_for_completion_timeout(&priv->programming_complete,
 					  msecs_to_jiffies(AUTO_UPDATE_TIMEOUT_MS));
-	if (ret)
+	if (!ret)
 		return FW_UPLOAD_ERR_TIMEOUT;
 
 	return FW_UPLOAD_ERR_NONE;
-- 
2.43.0


