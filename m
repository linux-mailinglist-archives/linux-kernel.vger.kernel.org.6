Return-Path: <linux-kernel+bounces-524156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B583A3DFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FB43A78F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A91FF7D3;
	Thu, 20 Feb 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2rXtdi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88D1DC991
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067406; cv=none; b=fHM6lbYjz4lsIhxj4C5QswE9k9ApqW5m/NuVNU/mYv/QOw4K5ZsdtEZSEvifHcOuW78/jeAAjswSnqXJcLsXcUClYwlJGfk2iOMIHko/yDhNWYDtvybrb3WwpjNyWBd/k7rBnmxbitTfdB704Cl3tNZZPTMufq1+ztWIrLrNFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067406; c=relaxed/simple;
	bh=pq6a0YOrGSJIfKrE6UCIYH5bOhZUlK2/v9ekn86EJk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE8COW576G0Tj6sY/MdvJaemrkWQ9IwmFfAZCFL0FNgtR6CPKhSMxnw617NUFTd5Y/vpYccNfIGbRRiPC2zsINsJM9LzGZsglFWQHmSMLnG2Ua/jFRIXrHOF7AiiggOeKKXPoCNigEhBmx5GCVxQ8WCLa+vcyYOR2QSWgVm3wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2rXtdi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9FC4CED1;
	Thu, 20 Feb 2025 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740067406;
	bh=pq6a0YOrGSJIfKrE6UCIYH5bOhZUlK2/v9ekn86EJk4=;
	h=From:To:Cc:Subject:Date:From;
	b=D2rXtdi3a4QUUkQoCUAoFDrhP/JTK97spye87A+nlsdw72oTwexG3LV452ZRMwUVc
	 RlBXyPimxOtJ/Y5NsPjoAvin7E67V9iE1LDe6jWBxdn0RQ9sH9CuzTu9j8SJs+xPXt
	 VBy6oWIINGkIWKkSx60cSqDbP6YW/a9peuuSLEQEp9rD9+a872ixwtpbX2iBH82WNB
	 LChYhtH/OZfqGHF5WSkLqF7aRy527AG77nu1zfIpbtVIfGbVsaW0EowYjUfcUBJS/x
	 mq0+KiNjlu01OX2vzfOrG7yLXkNMAScl625cllV4cNU04KkYTWfMGHzH0PV8YgsurX
	 qORQ65vKA5E4g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/1] mfd: max8997: Remove unused function max8997_irq_exit()
Date: Thu, 20 Feb 2025 16:02:48 +0000
Message-ID: <20250220160248.844051-1-lee@kernel.org>
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


