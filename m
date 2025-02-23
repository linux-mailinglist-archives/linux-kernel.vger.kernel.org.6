Return-Path: <linux-kernel+bounces-527978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B50A411F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670F21886BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAC200B8A;
	Sun, 23 Feb 2025 21:39:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3715CD74
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740346771; cv=none; b=EW2VIGNyHf6rPa9xrMaQQmWecyC9gnt5PChEwoW3g3MyWmYQ4KOuEYwbelLLXJHl4qv8Jly+5ReZH1SIMzZ3X/8eiUW51og8mE902QT/BTPM6I1tJx7Z1/m33JQq4sisAvvVam2eb+jaybVu+FyOGC3XPUgfdRk2+bdUhMeRo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740346771; c=relaxed/simple;
	bh=7mVDemT51tXPsrP8f5Z8C7i0wWS/Vt4TBwX8weE0Er4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNXSbhpzQP3vHB5U2Cl6Z7GP5rOjjhL2/365c4Mpnps0uliBTazqlgHya9mFUGjlPOZCDdaiI84ma0fgH+K+DYA5eihbJJGsQKAvd9dgEd9cz8EPrAcl5ph3AphNg8B5T4wxtjnv7lKDn8pGvFj7FhuKaMqeXcdFQnL7HyOFDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D39D16F2;
	Sun, 23 Feb 2025 13:39:39 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A73B23F6A8;
	Sun, 23 Feb 2025 13:39:21 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org,
	Andrei Homescu <ahomescu@google.com>
Subject: [PATCH] firmware: arm_ffa: Skip the first/partition ID when parsing vCPU list
Date: Sun, 23 Feb 2025 21:39:09 +0000
Message-Id: <20250223213909.1197786-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FF-A notification id list received in response to the call
FFA_NOTIFICATION_INFO_GET is encoded as: partition ID followed by 0 or
more vCPU ID. The count includes all of them.

Fix the issue by skipping the first/partition ID so that only the list
of vCPU IDs are processed correctly for a given partition ID. The first/
partition ID is read before the start of the loop.

Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
Reported-by: Andrei Homescu <ahomescu@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 31832af7a7bb..f63e3b0eed16 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1012,7 +1012,7 @@ static void ffa_notification_info_get(void)
 			}
 
 			/* Per vCPU Notification */
-			for (idx = 0; idx < ids_count[list]; idx++) {
+			for (idx = 1; idx < ids_count[list]; idx++) {
 				if (ids_processed >= max_ids - 1)
 					break;
 
-- 
2.34.1


