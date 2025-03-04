Return-Path: <linux-kernel+bounces-544484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6192CA4E17E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0496D7A3D34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C2264603;
	Tue,  4 Mar 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5GulmQ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4B204695;
	Tue,  4 Mar 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099431; cv=none; b=ly68vcM3L7LbF268FcewsgJjOCiA3LW7ULQZ26V2wxpwKJfMq0tGuDRIaUCp1FzcitSxBiADAAuo/arQx8NUtDMOUNIF+kwsMYXu6kMYzygyIQgFPYLm0aGUFoWHtrkOh2P+CIgNrH7nkxgZtbHYcFHicshaHuGLCs2oPgTuA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099431; c=relaxed/simple;
	bh=XfSqRqYZsA+MUDEbRTfs5BMwtTnxrzx+0E/tO5qxzN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+7S24h2bTA2uEv31j7F/L136I0jX5N5HktXaMTEvNrpZLA7gkl15ZrnZmN6v+Q0em32ZKaOV0Dt4rmrTQC8pJ5xgeHtdeGxiYG6O2iJyCZwoIehwvqomZcokTugGRU9KpEiYUBMDQM4VeWXmmEsUmXSLkSxxwpKv33HQlkjvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5GulmQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B20C4CEED;
	Tue,  4 Mar 2025 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099430;
	bh=XfSqRqYZsA+MUDEbRTfs5BMwtTnxrzx+0E/tO5qxzN0=;
	h=From:To:Cc:Subject:Date:From;
	b=R5GulmQ+RL2iHOx2ATwQmKj/WdX6qgMFdeAbidKuBl8ZTCQo5UMrIKuC5y6h6MKMR
	 bTBnvkBtU6K0yzZoSrWrCm5SSduKh/c/mYh7xFrut/IOCCdEV8H8X20YyX0/NCtBU3
	 Mmq/613fgsVeVu52eMAUkHZ3g7THAsWyZlbf3wnKZOFG5rUgJHgjhwUzGvP1SylqDI
	 2guAncPF+1nBF1cjhjki7w9ebw/L5Rq/K7xBYc1Y//7cMDhwX2FyiBrrpidjA/2x5n
	 6ALc3bxyFvwHaibCCWfygsGYwxG2Bey40wnUrDu6v4eOZzlarpt9zG6PYnczEyDquj
	 smzsF8NIBm8Yg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: soc@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Luke Parkin <luke.parkin@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: use ioread64() instead of ioread64_hi_lo()
Date: Tue,  4 Mar 2025 15:43:34 +0100
Message-Id: <20250304144346.1025658-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The scmi_common_fastchannel_db_ring() function calls either ioread64()
or ioread64_hi_lo() depending on whether it is compiler for 32-bit
or 64-bit architectures.

The same logic is used to define ioread64() itself in the
linux/io-64-nonatomic-hi-lo.h header file, so the special case
is not really needed.

The behavior here should not change at all.

Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/driver.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 60050da54bf2..1c75a4c9c371 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1997,17 +1997,7 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 	else if (db->width == 4)
 		SCMI_PROTO_FC_RING_DB(32);
 	else /* db->width == 8 */
-#ifdef CONFIG_64BIT
 		SCMI_PROTO_FC_RING_DB(64);
-#else
-	{
-		u64 val = 0;
-
-		if (db->mask)
-			val = ioread64_hi_lo(db->addr) & db->mask;
-		iowrite64_hi_lo(db->set | val, db->addr);
-	}
-#endif
 }
 
 /**
-- 
2.39.5


