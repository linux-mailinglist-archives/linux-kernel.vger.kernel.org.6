Return-Path: <linux-kernel+bounces-517944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674FA387D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73403B5753
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143222653A;
	Mon, 17 Feb 2025 15:39:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D222618A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806781; cv=none; b=TCMaBWcVrF2Zvq21oFoOhB2geUyEyEuR4EhXUks6a+fBT49jMfFetLhPL08qDq1Q0bGPTY6fq+IdOtLV1RgaIoFxYzPFBbOKW/b4MAo544HMp/2u1Ao8stvp62P4MsF/47Hc0NZovrZ7Q8hYmSjtJzfu2IBVD+c2gCxnYWOW3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806781; c=relaxed/simple;
	bh=hSnmX8m0IsvUg6QjDxQaXp5gbNOPxEHIjGzf5RS8CBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=MT6Ltf23o0swZcnAStPomL4VO8fxqawxj3RKk+36gxIqb4px1W2L+kn5zxjQ9MmEAR1SVC6umrdvYhSA1j01im+kr3Qo+U+PqA9LlWMawGUtEXXYx++E2zfstqUyTVlotDE+yhGM5oOa8GTWs4vxZ7ozXhdGnXSWoExaO0zSKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E086152B;
	Mon, 17 Feb 2025 07:39:59 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0AB3F6A8;
	Mon, 17 Feb 2025 07:39:39 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:52 +0000
Subject: [PATCH v3 11/19] firmware: arm_ffa: Upgrade FF-A version to v1.2
 in the driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-11-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=hSnmX8m0IsvUg6QjDxQaXp5gbNOPxEHIjGzf5RS8CBA=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gutymg8h1/T86Z4nSr1TM+hJU4oaA7tvNo7
 9DWTozgOcKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mMPdEACymHmnWTf7JKO7Y7K3csg+AiOXdSGzbiUCwVe6V+Fa8bQ5plLUh5t9vUjPJvUraFC4/Ac
 rvwwJ9BYf6CrurMqCa9hgnDrehOdAlMObRIkCZpWDh/2s48+p+mJkOvnHGLCc/7efYK/vzrOpiS
 3bfCcFbRoUZqOPs6Gwnxjkh2ZqfECWCIBJquk+QYhqiXZTjkmuYsXQeyKUP6vCdt4n5ICCL/w4o
 WY6DWVlhC9bpkKJVbooYdRFAv9SyqCj3jT+TokwlHRVkSmdyhzmeOsS9B5+EaNQaQSPGBb4K90k
 Mj52pChrkVJKpwRll1T5BnCj4047Ikn0/q30pmCud/i7S4wTgS0x/KXv9vb4ri6vrtSwu6RLQLo
 +ppQ0JBgB+/0wqEQUmzNYfG+UhgAol+tSY9xPQuXvM+Fpdstbe5OApqAqi5x7wzgIJUhQ50Zliv
 F/y+7bWSGemN7DO5ZNPjQVvRi4Wv1AIVZ1393mu8gjamsk3kbnFt8JEW/6Lm3AgoJ+Bl7K9xwoW
 jCJfY1MQPttLpG6CBoogCSzsxSOvrkPA6qa+5ZMSKD86s7ZRenSIRulIMSxZvXxwBNNPWw7C65Q
 gN53nGe4vZIl9VPdts7ZrpWKrjkENfwWJly5HXaJ8CsfyrUJmQkG5e3jM/GlsRRe1wtFDX4bz0L
 GCbcHhIQ4XaXSdg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The basic and mandatory features of FF-A v1.2 are all supported now.
The driver supported version can be bumped from v1.1 to v1.2

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 include/linux/arm_ffa.h           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 545b1772df0095787b20332a7d5189c71bd5cacd..d8421a32a92fed6d56770cba282ea55b2571b155 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -44,7 +44,7 @@
 
 #include "common.h"
 
-#define FFA_DRIVER_VERSION	FFA_VERSION_1_1
+#define FFA_DRIVER_VERSION	FFA_VERSION_1_2
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 
 #define SENDER_ID_MASK		GENMASK(31, 16)
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index bd78deeff284e2f46d42cfc7af218f4a0f3d1478..4fcbdc70cbc985eabb90733329c974384d229053 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -112,6 +112,7 @@
 	 FIELD_PREP(FFA_MINOR_VERSION_MASK, (minor)))
 #define FFA_VERSION_1_0		FFA_PACK_VERSION_INFO(1, 0)
 #define FFA_VERSION_1_1		FFA_PACK_VERSION_INFO(1, 1)
+#define FFA_VERSION_1_2		FFA_PACK_VERSION_INFO(1, 2)
 
 /**
  * FF-A specification mentions explicitly about '4K pages'. This should

-- 
2.34.1


