Return-Path: <linux-kernel+bounces-283528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973494F5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01D71F241BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223C188CB0;
	Mon, 12 Aug 2024 17:40:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EAB191;
	Mon, 12 Aug 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484446; cv=none; b=XqkSPEvhE9YWf4DBIvjKRrU4eQGWecSVVex+smQoyRlxSNY0vXuEvf1pAbDluwxIFmjXmkhgtAHcF/XF70KkqwbiAedg0GuqRfQfpVo6I6L8dpTz8Tns9l8d1CP44zSaKl89GfecmMvtA25ucAD7GjGnt6TSH+tQNTyNdaW9gW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484446; c=relaxed/simple;
	bh=ifiv6ZN/OKPFuzPIv0KPI5CMbS3tRHi3Ny2Y5QiF2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRHfbYnER3CNWJEFTfKKgnxzYY/Cs1gQBzKuqj2lo8vYGZ4p1YEuiB1WM3akwvSIFUUPs3kmyaZeqSxzhknHtPUs2PjYxHJliSSUrZ262lPrxiG9QgzvtEUtptwkdxPHV/EJpJ1dgmnqL6jkEJbZk/dpwo3UkFHnJC2yn1+xk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58787FEC;
	Mon, 12 Aug 2024 10:41:10 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6453F40C;
	Mon, 12 Aug 2024 10:40:43 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Update various protocols versions
Date: Mon, 12 Aug 2024 18:40:27 +0100
Message-ID: <20240812174027.3931160-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few protocol versions had been increased with SCMI v3.2.
Update accordingly the supported version define in the kernel stack, since
all the mandatory Base commands are indeed already supported.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 2 +-
 drivers/firmware/arm_scmi/power.c   | 2 +-
 drivers/firmware/arm_scmi/reset.c   | 2 +-
 drivers/firmware/arm_scmi/sensors.c | 2 +-
 drivers/firmware/arm_scmi/system.c  | 2 +-
 drivers/firmware/arm_scmi/voltage.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 97254de35ab0..9939b1d84b7a 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -14,7 +14,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
 
 #define SCMI_BASE_NUM_SOURCES		1
 #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 49666bd1d8ac..59aa16444c64 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -14,7 +14,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30001
 
 enum scmi_power_protocol_cmd {
 	POWER_DOMAIN_ATTRIBUTES = 0x3,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 1b318316535e..0aa82b96f41b 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -14,7 +14,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30001
 
 enum scmi_reset_protocol_cmd {
 	RESET_DOMAIN_ATTRIBUTES = 0x3,
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 7fc5535ca34c..791efd0f82d7 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -15,7 +15,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30001
 
 #define SCMI_MAX_NUM_SENSOR_AXIS	63
 #define	SCMIv2_SENSOR_PROTOCOL		0x10000
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index b6358c155f7f..ec3d355d1772 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -14,7 +14,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
 
 #define SCMI_SYSTEM_NUM_SOURCES		1
 
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index f1a7c04ae820..fda6a1573609 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -11,7 +11,7 @@
 #include "protocols.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
 
 #define VOLTAGE_DOMS_NUM_MASK		GENMASK(15, 0)
 #define REMAINING_LEVELS_MASK		GENMASK(31, 16)
-- 
2.45.2


