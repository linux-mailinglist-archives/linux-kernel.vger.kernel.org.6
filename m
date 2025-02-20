Return-Path: <linux-kernel+bounces-524159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C8A3DFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05ED580066F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3B20D4E3;
	Thu, 20 Feb 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuYoRk6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20720D4EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067430; cv=none; b=R8R4lX0UO6xUgVfdtEqOJpnVIZwqsaGG7OCVoxKCxJnd8rx1Lya7/iFi+V+yfXCXp70JYzsuBFkNGp4Zur8PAJPK9L8mXP30rYEwjKc6UCEFErujRxqY1/d7bpXYnL7Z/HqCEgmCSmlQShiYOwJcHMpueepKQsPKkyo1quF/rM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067430; c=relaxed/simple;
	bh=pq6a0YOrGSJIfKrE6UCIYH5bOhZUlK2/v9ekn86EJk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyyGfVcAx4Ytu5UYD1FHganG1Z8usJflxBKFDNYG2HmnYYdAg4bRTN9klshu1swiiSx/V9OWY8qwEgm9Qvrqc/Z36Y9/UtfCElDSIzwSjqTXo0clR0AQGZJ/zRGIYtRUb8JaCxcE6FqUzO7aCOw1SC9NjLNdYbJXdiQkAankk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuYoRk6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77824C4CEE2;
	Thu, 20 Feb 2025 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740067429;
	bh=pq6a0YOrGSJIfKrE6UCIYH5bOhZUlK2/v9ekn86EJk4=;
	h=From:To:Cc:Subject:Date:From;
	b=fuYoRk6beojvBj/AGKHXwN/3J4G78rz3XrGwEhw96CRI5KMru4Kp6s6gNEL09Pp2H
	 Zg844Rzi6YYbShQf3HL7tbPiBmQO9bPZj9YaF01Ql434Mo/uZZNdg8HkYcDfVbg7cB
	 u6YeoJV6wciR60eS/Fgm5Mrxf808dAaXjskq/gW7wlcipv4yK0Fl93REjakKUaNjQj
	 Dx6INEKZvuTY8iLwzWYo1864uqrDNmk9SQkJx+/XJNBsd0ZkOdXHv0WlVkUKGBXDa6
	 TQvoCiK/H9ivy82vQkrJ7WqJEzq+VP/4iEVCbPSySRDjkuLssss1VCqU7h9k9zPBiG
	 I8QXDUSnimN6g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	myungjoo.ham@samsung.com,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/1] mfd: max8997: Remove unused function max8997_irq_exit()
Date: Thu, 20 Feb 2025 16:03:40 +0000
Message-ID: <20250220160340.844679-1-lee@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilise devm_*() managed resource helpers for freeing IRQs instead.

Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/max8997-irq.c           | 15 ++++-----------
 include/linux/mfd/max8997-private.h |  1 -
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index 93a3b1698d9c..92e348df03d1 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -335,7 +335,8 @@ int max8997_irq_init(struct max8997_dev *max8997)
 	}
 	max8997->irq_domain = domain;
 
-	ret = request_threaded_irq(max8997->irq, NULL, max8997_irq_thread,
+	ret = devm_request_threaded_irq(max8997->dev, max8997->irq, NULL,
+			max8997_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"max8997-irq", max8997);
 
@@ -348,7 +349,8 @@ int max8997_irq_init(struct max8997_dev *max8997)
 	if (!max8997->ono)
 		return 0;
 
-	ret = request_threaded_irq(max8997->ono, NULL, max8997_irq_thread,
+	ret = devm_request_threaded_irq(max8997->dev, max8997->ono, NULL,
+			max8997_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT, "max8997-ono", max8997);
 
@@ -358,12 +360,3 @@ int max8997_irq_init(struct max8997_dev *max8997)
 
 	return 0;
 }
-
-void max8997_irq_exit(struct max8997_dev *max8997)
-{
-	if (max8997->ono)
-		free_irq(max8997->ono, max8997);
-
-	if (max8997->irq)
-		free_irq(max8997->irq, max8997);
-}
diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8997-private.h
index a10cd6945232..f70eea0f2264 100644
--- a/include/linux/mfd/max8997-private.h
+++ b/include/linux/mfd/max8997-private.h
@@ -397,7 +397,6 @@ enum max8997_types {
 };
 
 extern int max8997_irq_init(struct max8997_dev *max8997);
-extern void max8997_irq_exit(struct max8997_dev *max8997);
 extern int max8997_irq_resume(struct max8997_dev *max8997);
 
 extern int max8997_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest);
-- 
2.48.1.601.g30ceb7b040-goog


