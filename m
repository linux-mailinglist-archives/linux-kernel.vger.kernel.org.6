Return-Path: <linux-kernel+bounces-529846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57814A42BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BEC1889DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCEC265633;
	Mon, 24 Feb 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="natX+9V6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B15B211
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422404; cv=none; b=DzxudEtLA5agddAF5dVeBjdufi+s/clqO6XOWWedJaAME/z/7p1iLXiU7jLZb2A8IyvxAISeEQ33y2VckY4PjW7kbzHWJ9w9+4vpVbgfoBzezB4mUctrKJQ8MWdFOi0CRJB2EmLZRG7O8eX0nW/Op4wN+Itsuq4XfaR2TuIVPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422404; c=relaxed/simple;
	bh=wc0zdtocactArcWWNc92vfeiMvOsfeZMyV+3V2n7pJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r70NXgBlPwjzeka8A0uE9z75R/2VC+iUtm/JVrUw7Q4SGwDd49MZXM6WBrn8OiHwSQ2hRXbPNuRnM40+mZCWtD1TTP51e+m8swxXpWwNKhPqV1VLMvaZkP0/pHwtBh9lFwu8H6V5QD7OrozdsoFEQ0aufybMBe+MZN8vqpl0TDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=natX+9V6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A974C4CEEC;
	Mon, 24 Feb 2025 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740422404;
	bh=wc0zdtocactArcWWNc92vfeiMvOsfeZMyV+3V2n7pJk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=natX+9V6g3dzYX8BdqnDRNYENMGXPf3XhHxynjvYfAYdfco1UYfculpHV8mfIWnmU
	 JXkovay7hTO7i+pbGC5OyNX0QzuJyY/ME8ao6FVgkUR6SmiJnX+U+70578b6JLUBBz
	 C0ZBGGn5KwzZOgaY5ejChQ+SCavaIb+glXRBkAgkg4zSdqfMD2CCkyA0PquCDZAwvR
	 P7c7SQpbvDpUQ17fC5Co0lrg5XGs6sfW504MGHO8/whnZ25onkAb2Hvp9gGaefqpuY
	 Zg4+ETRvYjS/4/jvcMSXd6C6CjwF/6tvuIz4bYzLSzXvBX1Pf7ZVtxv6Ry24hj+qQ5
	 dQRmTtUiFz6RA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B342C021BB;
	Mon, 24 Feb 2025 18:40:04 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 24 Feb 2025 12:39:48 -0600
Subject: [PATCH] mfd: max77620: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-max77620-module-v1-1-96eb22e9f266@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPS8vGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMT3dzECnNzMyMD3dz8lNKcVF0Lk6TUVANDyySDREsloK6CotS0zAq
 widGxtbUANxYYmmEAAAA=
X-Change-ID: 20250224-max77620-module-84bee019b0a9
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740422403; l=1436;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=+r4q7w35q/PUW+4DTP800ohxi4hzqBWXk37ruWNqFeU=;
 b=arAMSc8xvewZ6BcSWy7gonvoCNgyjMMMvOf/TwbKy6sRhU+0vTk7Rp5wkXOsVAk/5auLjFwZ7
 xOpOtRxttmmBlNNa6LPb808YyA/UbHgLmcgiF3YiDyOzpPhGxP7V7+u
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The driver works fine as a module, so allowing building as such.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/mfd/Kconfig    | 2 +-
 drivers/mfd/max77620.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32b434ee3e99940005a6cce14ff55c..922704bd0ce3fe6c094da6b1528b72fedcfa1677 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -858,7 +858,7 @@ config MFD_MAX77541
 	  There are regulators and adc.
 
 config MFD_MAX77620
-	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
+	tristate "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
 	depends on I2C=y
 	depends on OF
 	select MFD_CORE
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 89b30ef91f4f112b06e0e055e75e480fab176f8f..10264fce95a4a37f22f205edbf364fa6783e35dd 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -700,3 +700,7 @@ static struct i2c_driver max77620_driver = {
 	.id_table = max77620_id,
 };
 builtin_i2c_driver(max77620_driver);
+
+MODULE_DESCRIPTION("Maxim Semiconductor MAX77620 and MAX20024 PMIC Support");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_LICENSE("GPL");

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-max77620-module-84bee019b0a9

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



